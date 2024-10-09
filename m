Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FC09CED628
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 08:29:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syS3z-0004qm-FM; Wed, 09 Oct 2024 04:28:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1syS3x-0004qX-Jf
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 04:28:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1syS3v-0008P8-V6
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 04:28:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728462530;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qVAGNi3B+zaqDsLtRotXeOeufFoRjHnbuO1Ir4cRYYQ=;
 b=A1KVrpLotmIJL6x+jNUfhcYSKGw3gbtjcl/6kxgoX+Hm0rHPEkrjkN48wocYa1XUNcOSL9
 atsj6ucMWf6DPclmaHDYGVcd5Yy/Y6bz6YGkuNV4oIgzi/Q90JoQpZY1CdE5+HJzgc808H
 aGg6ybaAATT+fMV+0eF7S4SsDZsa9aM=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-13-d4zIX_YHOgujzjZF-n85sA-1; Wed, 09 Oct 2024 04:28:48 -0400
X-MC-Unique: d4zIX_YHOgujzjZF-n85sA-1
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2e28d7928d8so1754860a91.3
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2024 01:28:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728462527; x=1729067327;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qVAGNi3B+zaqDsLtRotXeOeufFoRjHnbuO1Ir4cRYYQ=;
 b=MvHfEqmuUcN8lqse6HL2ImJ6Ev6k7zeDnAzG3kCSI7tbbYlD+0laifoAj4u1F3R77G
 Bv/R6f0cYJrJYEMLV14Aiu02+oZPAdMn8EptLXEXVeIfxCd+Ex8fBrib4gQ3YVTYwIA1
 BtzVKDpMi6p3mTYrXkENzAZ7A8JucuD+u/b7OJ+OU8glIaSuyLbc0WVATbiNyWfE6p3i
 sK7j/ZeNsZoIITG1eYjIIzYGFke0FNsxH2SuRl75lhwbhbrNsgBiTkkhqJQR6NOiEk9w
 +spjtx9iEV2cjJmghWlIlwKXUXP9CtqrJ1cSL/QWlhZIl/qL3ij60yOghkjz7JKHj4y1
 y1eA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLP4VMZJnEyKQA9POOG3cmhM0Py+VCizv2q4D3phsltNoklpgTP0JLgq4R3uBn7lFnEujVqbfgmXNP@nongnu.org
X-Gm-Message-State: AOJu0YxrWBBFZrHvNyUCvEsiFfv1Ss4Rz09XxIha3e1gTYX6WqO7tjxz
 bygAVr4YeucbI0PelHTgpgQp3jPDRtIx7zHPFbWjBIH7ej4v3bBVpDAFt974yfdkdp28W9oIWpA
 UPm46B3mLL3jkMYMGKhc9zbgsbqBbySmwIEPmKMzcHYGdkxgsbKBCq3ZcFe9Qo7QKsCilbU4vRl
 SPp+sunThuReUlJNADgslMgcISNlHRNcn2H04V5Q==
X-Received: by 2002:a17:90b:23d2:b0:2e0:9160:1842 with SMTP id
 98e67ed59e1d1-2e2a21e7c97mr2278376a91.1.1728462527677; 
 Wed, 09 Oct 2024 01:28:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHaYw052rn7hGGSKjBdHha8J9jonvL8PCmkQ6+x5Uhyu0CNP3+HvDGw/ldblWJrgWF+0zZcBlS459r5wjUgZ+o=
X-Received: by 2002:a17:90b:23d2:b0:2e0:9160:1842 with SMTP id
 98e67ed59e1d1-2e2a21e7c97mr2278355a91.1.1728462527258; Wed, 09 Oct 2024
 01:28:47 -0700 (PDT)
MIME-Version: 1.0
References: <20240929160045.2133423-1-lulu@redhat.com>
 <20240929160045.2133423-2-lulu@redhat.com>
In-Reply-To: <20240929160045.2133423-2-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 9 Oct 2024 16:28:34 +0800
Message-ID: <CACGkMEvMndysLRjsBdxov+RQ4YJvSmPNgAev9HP0tnM-rb71eg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] virtio_net: Add the check for vdpa's mac address
To: Cindy Lu <lulu@redhat.com>
Cc: mst@redhat.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.151,
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

On Mon, Sep 30, 2024 at 12:01=E2=80=AFAM Cindy Lu <lulu@redhat.com> wrote:
>
> When using a VDPA device, it is important to ensure that the MAC
> address is correctly set. The MAC address in the hardware should
> match the MAC address from the QEMU command line. This is a recommended
> configuration and will allow the system to boot.

Would there be a case that the system can boot even without the
suggested setting here? Can we even know about that?

I'm asking since if there's one, we break them. At least we can have a
new parameter for strict checking.

Thanks


