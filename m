Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3311C30658
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 07:10:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOXet-0008Fx-1N; Tue, 02 Jul 2024 03:10:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1sOXer-0008CC-Sy
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 03:10:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1sOXep-0002mB-3J
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 03:10:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719904228;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=USog+E6Zm7/+D4m3B75qnus4rG/GYwAiXhgefD+hK/Y=;
 b=gnxjMPonQ3ZzBi+J6D0f1UNvBc0/A4dhmZq8bjsjWHoy58767yNbtMycYCbz44tx9ffLFv
 hBwGCiX47y57WMaWPATlAWr4L9KMcF3beZqFM/33Nn9LXgj5LxZF/9r4Y1ipN+eQHJbQK8
 rLPJIzRd1ePf0Cr2icuFWVTZfMbuYAI=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-540-_x7VxRFYO8akzgzkLkrdkw-1; Tue, 02 Jul 2024 03:10:27 -0400
X-MC-Unique: _x7VxRFYO8akzgzkLkrdkw-1
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-70a95a33c06so3210305b3a.0
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 00:10:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719904226; x=1720509026;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=USog+E6Zm7/+D4m3B75qnus4rG/GYwAiXhgefD+hK/Y=;
 b=kADd5pAQa78xdNBE7LiQVtOk+DpbjqcF/WXfGZDpBK+gzVpLlleA7XxE+lvEKq1+C3
 1js1DE+iriyzz+QOHba8pLGziKokeMMM1O+8+WYjSv7e8Ju0ctoj4c7SFn1RZUsuRpMe
 cDTAA/aNgP9mUY2W5dE3nQlGbRICbOi6vifQEXBYuUNoQktO3Yz4bkajELP5tiyYs3kA
 ra0hbsfGOfsNulK46WknejSb6vV5n6G4NKvKF0/Di4KfpJinVV0Ee9zE4ZAejDN81brO
 Nk7mplX3YEdCbmxLwII98bbbymg8FBiwjfi3hddksJuz3RUWs2beeKQB4uw0G+GCbe+x
 PTPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2KXZ2SyaDixTXvELcxiY3s1S2tMdZz+iQp8zDeSSHSRWXEyl8BNh+Ou/llZvmh1Twv5tuDdip+Mpu2fY3jb+vffsmt6M=
X-Gm-Message-State: AOJu0YxCUVgyW0Rg7ARw++v6Gm7d/yWDs1IeY82qU+NSMR3+1aH8gN+D
 TBzZHdJem/L8fgPcG+kegG+7bjKmqUgSrJFNxqHVbcdMuMfdVWl7UjNJ6NE0lj2hwdTUMufEC5s
 Yde5LzV0RJ9XrL5SOHKROl0w0MNjR72U5pF7ZPInfe2Wu5EAzESWlol4WskJxuzkcsgpDG3mI5M
 gKhlNzj8BUd8jK1VLRfRzo7qpS1c0=
X-Received: by 2002:aa7:88d5:0:b0:706:a8f0:257d with SMTP id
 d2e1a72fcca58-70aaad3b2femr8760857b3a.13.1719904226037; 
 Tue, 02 Jul 2024 00:10:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHdkiEheHEzkNVt/2sV0CkcMZSr6a4HBbgWToapeAhraALYDWwyPmrHRzC+uIG/gL0+tQ1T6v9OObiBCwEYrw=
X-Received: by 2002:aa7:88d5:0:b0:706:a8f0:257d with SMTP id
 d2e1a72fcca58-70aaad3b2femr8760839b3a.13.1719904225515; Tue, 02 Jul 2024
 00:10:25 -0700 (PDT)
MIME-Version: 1.0
References: <20240702020033.139261-1-lulu@redhat.com>
 <20240702020033.139261-3-lulu@redhat.com>
In-Reply-To: <20240702020033.139261-3-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 2 Jul 2024 15:10:14 +0800
Message-ID: <CACGkMEvq----WyGyZndgxbopp-=wd9r5TfBaXJ1v9HN0MmsGDA@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] virtio-pci: Add check the return of
 kvm_virtio_pci_vector_use_one
To: Cindy Lu <lulu@redhat.com>
Cc: mst@redhat.com, qemu-devel@nongnu.org, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Jul 2, 2024 at 10:00=E2=80=AFAM Cindy Lu <lulu@redhat.com> wrote:
>
> Add the return value check for kvm_virtio_pci_vector_use_one().
> Since the return value of function virtio_pci_set_vector() is void,
> we can do nothing here. So just add the error message here.
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


