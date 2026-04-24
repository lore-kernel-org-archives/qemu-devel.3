Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80C0AFED3F1
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 17:23:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGKEV-00048T-AZ; Fri, 24 Apr 2026 13:22:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neotheuser@gmail.com>)
 id 1wGKEE-00046V-8w
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 13:22:10 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neotheuser@gmail.com>)
 id 1wGKEC-0000PB-LB
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 13:22:10 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2ab08e6c553so8763885ad.3
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 10:22:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777051326; cv=none;
 d=google.com; s=arc-20240605;
 b=GEUhWT6PBxB4LhY1HOi/URVNSRwhfKDA42dJ9ZcavCY5vITUMNQ2/e7eg3h422cD/b
 sJ7GomwfdpS9lcXOQcAOr3nE9zshqnkHqk66roMiK0jLRqTe3CRWClISq4xGfYneEDAy
 hSldJnWiCES8qlJ0B/dfVe56WN19x67wfM9TWm7pudWrdkiypCbz+UMiMECIpR7Ds2Ie
 o0ZiYttTSE0tHfgcbbbUlq2oH7qtq1Bu3dPU73Tj5T1r9CDglEUnvDd3/go0qZt26pR0
 Y156oXHW+Sy0S3DyHsGI+BLJpaHSCyrMajkqczuKvB2N250Huhw7TKd/MQRYCqSCJ1Qq
 4Bjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=4nqQSABcZqQtWk7aX+r+IRffb+aBiWfOBw1e0+MUR4s=;
 fh=PnYt+qEB9tAfMKoqBm2xjKOFpYyFFGPudh5cVIoieJM=;
 b=eBaIQJu2rWRdlFSKRgP+ZYJfRujl/Wqj4rfdvGcI7vPFDHFNKr17InwTOpM9kACQUR
 trRDYtXOqYCBTxAcliksWWdRP4vGR3RSpFBAvH2+c8m7CClHdp27v5EUqGCFIwNA4nSd
 wteSgWfZRIKKy44O1Ylc88APksK++KABUs4yBAjpLJZPuh3XLCK44kWCJbpaAmWKTgs1
 XFy3AXG08Lmiuy+6hdAUu/M5RhAdqHLS9AJlJHaLe6l0WFc3GF7Jp5JcCBILLi82RC5Q
 7pqm4WkVKwPsnf0TwalZAmwb/tIt9CoaqwAM4YdjKvg5PLKKxnrE/l/SOYs6G3b98af1
 /ukg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777051326; x=1777656126; darn=nongnu.org;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4nqQSABcZqQtWk7aX+r+IRffb+aBiWfOBw1e0+MUR4s=;
 b=cYmonLqo3DVeqDgSJY3oOoSTLoCzCu5xKPFhf4iBvCdSX4AYj2gYRaQxppKPYG0WlM
 KLaNX2vM+VPpSOVDy3+LAU52SlaVdSsqAusvoPAFohwBlQYf0B0hH1xr876Nvzz0156s
 gRKUEpLwSuqHEuykESgm/D2lh2Fqmr7CYFoSuBrtHkvqzukVpJ1/Hc7HuO+CojpexeSn
 h9BEcmFaIr3gf79F9W7af2EObCbayiUoiQPj7NJrqVqNRwD/422jSBcFrB0yMlgwBOKw
 arpZ82waGVAsdtVd7NDWMDFeV66662Rw9W6t5wlohpl5EVw7QG0K8JF0Fbxn/gZWutB5
 7mxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777051326; x=1777656126;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4nqQSABcZqQtWk7aX+r+IRffb+aBiWfOBw1e0+MUR4s=;
 b=sFwrKIzt2HWnkP9ifQB8R9BRul+pCoStLGe659iUtzhTIXwJUB84Z4tuxveqyl3uc9
 tN/f3U3dDVfD4cotD9mXnF08g2WtfAKbmycr8jPZwlfze3TjYfarF41J+3OybSJaynqa
 BRk3VcYeLkBNB/lEUfvIyFAdxUKi73icWhgcRrFUjymvlKa7PImSAce2ECpOdU8VW/C+
 7Xy5LVq2gimK7Lx9zv30a3beb8IqztwLFBlcc5hQ0fkKHWqs62qasfK7gS1bdcqI6lxN
 asWEm6s1aVHGyzjwUAuLu+CiyckLB180MnQd7QzrOJPxVD5EmGlNHG8b5nFBDmKyHwYt
 PzGA==
X-Gm-Message-State: AOJu0Yw6JjOKdVGt15eK7nOv1eR7t0cAbHRJYIoaLLHTRD6s89ofQgYL
 eFzAlSnylEfn9QXoxiWGdHUZPXOcdQ3VlYVU4empP9Sspg4CGJH/VlD8heoTCV/41X6dIu2475H
 FCNwOuFGtrGYPfxnYpNtE1ij0t0No9WhFClS1
X-Gm-Gg: AeBDiesUVBMwwVItuQI5Kh7n2bFSttIsxi9mFlqWXNaC6bxZmzLtXnZHuH/74B9os/h
 72cxH1e8Rq568MQu5bdlf9dHU3bT8zKwH+iqcnO5zBfOI3WyJFu2jO3fbokLiuRkjh0Ge4pCTrK
 /ndA37ar3yLCYpKMEGUaMYM5+JBCBJenXYnT8p4JQ3MjT5GALm8CvgvDIUo8N6VxWe8zRlXVCCE
 pkZvF6ugtTT/pg2V4BHOxsXFw03N1NVcrt6TBcGNYUWFsggL4cWre7hXbAyx5+AX5WTBv0QDR33
 KyPVpQrkp3BYejw=
X-Received: by 2002:a17:903:390f:b0:2b0:5075:96fb with SMTP id
 d9443c01a7336-2b5f9e7a7ffmr197964385ad.2.1777051326006; Fri, 24 Apr 2026
 10:22:06 -0700 (PDT)
MIME-Version: 1.0
References: <CAM5Ud7OgnsygAHxjGEO-qo5+3zYiAQFN85D2bx1Wb62vK2hzRw@mail.gmail.com>
 <3ba72d44-91bf-417b-9a8f-4fd7ce796359@linaro.org>
 <CAM5Ud7MwS+_UmT-AfRaXMQmmrKs_k8kUfQTb+mk0Dma5gumFkg@mail.gmail.com>
In-Reply-To: <CAM5Ud7MwS+_UmT-AfRaXMQmmrKs_k8kUfQTb+mk0Dma5gumFkg@mail.gmail.com>
From: Alec Ari <neotheuser@gmail.com>
Date: Fri, 24 Apr 2026 12:21:53 -0500
X-Gm-Features: AQROBzCH9hZarJx7M0MVSp7B0ljVdi6LC0ifmT1xE0GQCC2u-12aIS1bkmxlM6E
Message-ID: <CAM5Ud7OxDDd1otNFsozq+gpWH-WYBEB6U7mWXTbLqYjRhvmP_w@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] raspi4b: Disable L2 cache
To: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=neotheuser@gmail.com; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hello, and thanks for the feedback!

A few things.. The kernel is not a .deb package, it's not going to be
up forever so the test would eventually break, and I also quickly
threw it together for a friend so I wouldn't say it's for production.
I also don't know how to modify the python test to support a second
kernel, nor how to decompress a tar.xz file using python in
coordination with the QEMU source.

Also, I didn't mean to email you directly, sorry about that.

Alec

On Fri, Apr 24, 2026 at 12:19=E2=80=AFPM Alec Ari <neotheuser@gmail.com> wr=
ote:
>
> Hello, and thanks for the feedback!
>
> A few things.. The kernel is not a .deb package, it's not going to be
> up forever so the test would eventually break, and I also quickly
> threw it together for a friend so I wouldn't say it's for production.
> I also don't know how to modify the python test to support a second
> kernel, nor how to decompress a tar.xz file using python in
> coordination with the QEMU source.
>
> Alec

