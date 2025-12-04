Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13912D1CDB9
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Dec 2025 02:18:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQyu7-0004dA-4B; Wed, 03 Dec 2025 21:17:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vQytx-0004bi-Ei
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 21:17:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vQytu-0006Ur-Fh
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 21:17:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764814616;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zLT6q4nDLq8QkE9rC9QYBbZwwguZJcYR87+y25eQilA=;
 b=Ig4Vcu3ddGEIR/7cFraRNy7u7HlNbkM5dFPw3dkZ8wQvX5NUWPTSuuwcNkczTrIZ5q84Hg
 n3r4sbyaOZyLctLWbfOAQdT7F0pJx70u1mvpI6a0g2LJ8ws9GoJCvKXfTwoc0Q/Fsv+vui
 oFK8bwW/UE0QWhDUV1b3RTyuDHDbD5A=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-313-sOJJe93BPOK16ZsHBJIqAQ-1; Wed, 03 Dec 2025 21:16:54 -0500
X-MC-Unique: sOJJe93BPOK16ZsHBJIqAQ-1
X-Mimecast-MFC-AGG-ID: sOJJe93BPOK16ZsHBJIqAQ_1764814613
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-340d3b1baafso559746a91.3
 for <qemu-devel@nongnu.org>; Wed, 03 Dec 2025 18:16:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764814613; x=1765419413; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zLT6q4nDLq8QkE9rC9QYBbZwwguZJcYR87+y25eQilA=;
 b=MK+3wm5iQPn2Lj4UPkl8LJ7fT95SZqtpi4CQ9tRK+7ZU/zwV5CqBYHkEqMyH+Gtftr
 ANCAxE8IgXeoIHM/jiGCV85hthOw8dcm4yCelHFrF1SZcDW6ORp61kNKI1/LjJ1MyevV
 cd84A0t0IFWhclctLMaVvbvpTb0dr9D9I0eS6C+eG4A5wennDw4cSQXRMVMcqQdChuf2
 G77QcsIFiFFoOibHyH4s+thwq8mFPvc0MdQYHi7kNs1ZBm2hhoZbjhJyXFA3QuhADD9D
 L+FLqWmEXiaAQHvbfRf+6dl2bZm6yEgBo0k050+uztGZf9VO2xrqFQlRs3cNTtJSLxo3
 fZbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764814613; x=1765419413;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zLT6q4nDLq8QkE9rC9QYBbZwwguZJcYR87+y25eQilA=;
 b=QPY4ihTMjyeNVUo0D7xU/ciC2AUTNPUY6wM5dj3CzNSw08RLWvz6SczY96An8M1lxc
 e0rUwCf3aDWFWEI8gTyxTKLT8+8uWn3at0k+RzaqZdbnrvIp9zbsWNB9yxjvWMqhGpqy
 9Jip48R8dwFI/aCfUbjFWoLe+VWefQj2CYe1e0kCRzlBs1naD0iIVpv7y5mDFNZZaITG
 bsMhABt6u3Fmj8Fz1fsCVX2xBxMXaKjRsdVbCuoNBDO7I5vB5IrMGVMTuMoY6u2eD5Ic
 F6xvzLR69uXk5Kl4djulJHoDgqBEZexzX00SBsElrMjhsj65053ZmF8thDHjMGAFGCgx
 mT6A==
X-Gm-Message-State: AOJu0YwhktrLevwwRr/BMuII9ixm/Up5HTX8aQki5OPr1jdzY3KEYZ7e
 ZpxnZNDYCaJshty512YfdaqDFkb/E+2k1BoKhv/+heoIZjY4Rc6qtZiqb3jUz43H5rZUmTpdU4o
 gQn6IejNrfaeF7pXh9V/kJu8Om/7JnMzHZIvr5vBsDxqIlND0NcJMKhkbpPcgvzWvpGvXWgente
 jQslP9PXc/oNyyvt/Awr+6PeYciBk5M1o=
X-Gm-Gg: ASbGncsvinDgY2F+hnmhUN6bNz8jVroRwHkhjh/wfbwJ5xvjqtxjZ2KgPTiKSmbf3dU
 XMaNP6J37ogp6VgIM+CYd3bzf4DM0e9qsQFXxSUsJ2qzDXcncM1CNS1ca1owYETGkVEjo95aLn+
 FW2B5L+rHNyqS5tRmMa/Fc+c3uQl58gSC2gejFRwVOQ/7ckaBf241aO2X4y0ksL39rEXg=
X-Received: by 2002:a17:90b:5403:b0:340:2a59:45c6 with SMTP id
 98e67ed59e1d1-349126df0e5mr4705228a91.4.1764814613351; 
 Wed, 03 Dec 2025 18:16:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGzTRvYKPP6FpBlPSvWSG2wvpEJ0j+vzvQYhj1+KZ3RS5MlKr6Q9eg046zn51xgVu2bLqyaJc1MYng2qbHeYtw=
X-Received: by 2002:a17:90b:5403:b0:340:2a59:45c6 with SMTP id
 98e67ed59e1d1-349126df0e5mr4705206a91.4.1764814612972; Wed, 03 Dec 2025
 18:16:52 -0800 (PST)
MIME-Version: 1.0
References: <20251201125149.2151026-1-eperezma@redhat.com>
In-Reply-To: <20251201125149.2151026-1-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 4 Dec 2025 10:16:39 +0800
X-Gm-Features: AWmQ_bmxPq7iCKcLD9tkDW3-FxECTj2SFOoXJKnK9l7MxRJGrG0SgiuoUPaIheY
Message-ID: <CACGkMEvvr4jVqtj93ktOXB5xLDzaoCYvgChcxTwLfdArFFadBQ@mail.gmail.com>
Subject: Re: [PATCH] vhost: accept indirect descriptors in shadow virtqueue
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Lei Yang <leiyang@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Dec 1, 2025 at 8:51=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@redhat.=
com> wrote:
>
> The device is not able to generate indirect descriptors by itself, only
> the driver can do it.  And SVQ is already able to handle them by reusing
> VirtQueue struct.
>
> Shadow VirtQueue just transform the indirect descriptors to chained
> buffers.  This way we don't need to map a new buffer for the indirect
> table and handle its exhaustion etc.  As they are only used in control
> plane and HW devices don't like indirect, we should not see significant
> downsides with these.
>
> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> --
>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


