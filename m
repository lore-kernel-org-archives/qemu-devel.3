Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48AFFD2F7E1
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 08:11:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1i59-0002St-Fr; Fri, 18 Oct 2024 04:11:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1t1i56-0002SC-Qu
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 04:11:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1t1i54-0008MX-HM
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 04:11:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729239089;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8Mp+4L/2WiR+ric0AUZFE5eZdBjHDdMwrLfnVQnkCHU=;
 b=az9lKWUU/5OVPswAnnDlQ1Qyd0A4O8UDdvat5Y2gC+ZF6v8nZx3tN67hWJXOHavXz0by56
 9FEz0IkKRRmNUVDr2QAiUFNWW6jy9gt/QSFd3wt4EiujzyafGJ+K2AGJx/xakq/ySpfuuI
 AJpoIvnuRtTfJrkkY3sqzw4dhtSXFGQ=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-153-yTlDpTBaPLmlf-PEooKXOA-1; Fri, 18 Oct 2024 04:11:27 -0400
X-MC-Unique: yTlDpTBaPLmlf-PEooKXOA-1
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2e2a29fa586so1877503a91.2
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2024 01:11:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729239087; x=1729843887;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8Mp+4L/2WiR+ric0AUZFE5eZdBjHDdMwrLfnVQnkCHU=;
 b=ezHoC8euTKIWqa8X6UibsqwCixKyDNr9ZnE5dUX/aGMekIZoH23KknnsSmuiLzWIlA
 JOS3pPSHkNBp64V5qHzRmsDB70ZeddHwfM9WsrIictXNKuMweVZ9kpz2ihIAb4ZBtE09
 6jTbX5XtiyAsnOWot0g/yEmypOLeF1mgunC2ryopKaFHM7voWFbC9cLem4Kie2CSDGJe
 tGQyXITKH5qYPaBQ/Kqn4POLcatpEAys6sxtV0543X9c09JrFDOWw9vXhGwf060rYqgz
 KZeZgbyemciHlcQBYWVLQjvc5hvimP+CjhtwOLIG5ct3M9e32s+ZxOJuF6MFagysYPPq
 PMog==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8pVF0/cuQkm5TPgq3m6nso5IBGnQjianrc207EUmw6snvg0tDKS/stmtdawg1ExlufQRZQ2GJpTHd@nongnu.org
X-Gm-Message-State: AOJu0YzIJ2K1sf4Epyl6fqrOSDoOTj/P4gk/ft1gKsMaMaSSxddAbZyc
 mdyzlH0aZxO6loUIrvcUFc0UM7XFFQgodxMIppwdyGXlZi6TZdbyn2DJIQJvRtLdIsMYnc+pB+2
 p8U44j4F1BUUZ6t3Q7PfAlFWEJdNTPuXvyK8r2nKlTdPeH/OwAVBUz5CYYcd5p5CX5ahKUV+XOt
 riNtFVnxmuH7AgVhrPVAAdEMqS/nM=
X-Received: by 2002:a17:90a:8a8f:b0:2e2:9a48:dbb7 with SMTP id
 98e67ed59e1d1-2e561703d73mr1712434a91.29.1729239086834; 
 Fri, 18 Oct 2024 01:11:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGsu7e5TCEQiIZLBZrBzxnBh9B3FZjR8GcBLtlJJ0hheQUN6YZ4DJLjXvXP4EDU4WvcD69etM1mF9TwXuUr1zE=
X-Received: by 2002:a17:90a:8a8f:b0:2e2:9a48:dbb7 with SMTP id
 98e67ed59e1d1-2e561703d73mr1712414a91.29.1729239086359; Fri, 18 Oct 2024
 01:11:26 -0700 (PDT)
MIME-Version: 1.0
References: <20240817-net-v1-1-699b5591ad3b@daynix.com>
 <20241011015437-mutt-send-email-mst@kernel.org>
In-Reply-To: <20241011015437-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 18 Oct 2024 16:11:15 +0800
Message-ID: <CACGkMEvGYAejDkitSv_xU_dp3=FWRkZAYG-29XRfVkeL9vXHZw@mail.gmail.com>
Subject: Re: [PATCH] net: Check if nc is NULL in qemu_get_vnet_hdr_len()
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Luigi Rizzo <rizzo@iet.unipi.it>, 
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>,
 Vincenzo Maffione <v.maffione@gmail.com>, 
 Andrew Melnychenko <andrew@daynix.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>, qemu-devel@nongnu.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.068,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Oct 11, 2024 at 1:55=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Sat, Aug 17, 2024 at 04:00:43PM +0900, Akihiko Odaki wrote:
> > A netdev may not have a peer specified, resulting in NULL. We should
> > make it behave like /dev/null in such a case instead of letting it
> > cause segmentatin fault.
>
> segmentation
>
> >
> > Fixes: 4b52d63249a5 ("tap: Remove qemu_using_vnet_hdr()")
> > Reported-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>
>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
>
> Jason, you tree?
>

Yes.

Queued.

Thanks


