Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94089C55171
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Aug 2026 11:48:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wqUft-0003MB-K9; Sun, 02 Aug 2026 07:48:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wqUfQ-00037z-NL
 for qemu-devel@nongnu.org; Sun, 02 Aug 2026 07:47:46 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wqUfM-0008Iq-Kd
 for qemu-devel@nongnu.org; Sun, 02 Aug 2026 07:47:43 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-6a0ed8a10ceso225639a12.3
 for <qemu-devel@nongnu.org>; Sun, 02 Aug 2026 04:47:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785671257; cv=none;
 d=google.com; s=arc-20260327;
 b=C95W7RK75SrR752H8XZtxbDDo/ed7XAKOrOgZtKAUmC140zD3bZr4n46nHldyGroza
 6HUoT1l5s95Trm1Edgou2hFzIz0QqfqIbLmqlMChE5TNY3wur+xDiNV/bt6PqSgsioyD
 fjAuxjvymF91IJAMzKH/Nju4XLpcE6elLQRdCcH+y8sTT3j5HF0rA/AMu19HhDqAfCz0
 BRSdxf+3bZCZGpCz3idsAHYj0gP6/la/BL6Fv/ReEmBlk7AqYvy2ZSRXqgQ8Tptf4VDi
 6HZqacrIZIZAcbuvV/GiaQWpdoQ24GaJFBh2Bjpv4xZgyJ8R/e/CDcHhpW2LaxAy1WGh
 Zh4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=3X9det38Io24u5nf0zK9X3XLBPXpIWFltxhldsxowZA=;
 fh=Fi9leVjchoVZBzhzHTswcGE21LDkhk/aPMzEep374U8=;
 b=HH+j57ZXgjCXAJm2MnLfeJExGFzCJcHiqHwjj1L+6mdrqGUijBDOvWB5i1ybXplxmm
 /H+kmjtfAtiTTQ1I/wUHAxMeqQkHjXbO+iw6IvoRHOzAgGMNvXncnLb7rB4Jw2YB3qob
 gU+Jj61iBHaP291xSNa0T94V8yqlZzZUYDyrb1W18kIFJnd9AXdn7W0mmIERlTjU7T4b
 WAa8ACek3q1ZihLYBsmXsPWW50V+6SIAI8+y1nVPoK8PJ2MlNlu+9vzvpgUesNmAMWVe
 VxzR9hAnK6x6lheHVT+cwySa/RnKIFBpi5l/N3VTY8A/cgkT9QIvLzNTOVkIz/OhPbMM
 ZqQg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785671257; x=1786276057; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3X9det38Io24u5nf0zK9X3XLBPXpIWFltxhldsxowZA=;
 b=Zxyyey3nXg+yWy53CQrc7hLgZo0L/FW1cCPUKTRDmzree62skCVlr63EE/s/Sx4MOD
 gTTtI/tV0mhY8xszvJaoTM9LiSdk7W+aUpkn7X8FT82hji+6lRHjm2kQj8SUik9QNN0g
 u5H4zaK8KA9UxfdZAin4Ziueqgztdj/Eoi1Y/0ALSNiOkeeXU7GVVnpvOt7Nuwut6GyL
 pyB997cb6m61utCC0BgkvRtc4cmCejwereKQ94QEWpCQCHcxum1uI/urSeghARAldoGo
 MhGMBRnTTIZ7JWWJp3rn/HDJb+g8s0jPJp7yx8SRRZxv1H20LjOV5/qT1h6/OzH/PRRd
 upew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785671257; x=1786276057;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3X9det38Io24u5nf0zK9X3XLBPXpIWFltxhldsxowZA=;
 b=Iu7zeeMSWlDusiaS24TvE8cFE1wmN1czuDxHuS3seVQdpcrmqnvE7b2UaaWbSbw8A7
 9uDa/xyIZkw2uEPAX/9mLxA8qVuLUF33kk/DTzRSrg5JlensX2/YtSKhBHjgMyXxm8Nr
 vMDcxN3SsrEunuy7HcfecS70wYay7oS43g1Qnlj3VxLk9VDbWMgzvTysqsbM4GnILXuT
 VlJRuY2rBBcYvhmk6VFJBKQcyGU+hL4aH6tUN+ohZk/WcOVju3LQ/KsP7qt74/5uaXh6
 aKLRigvgQcQC1qnng5j7GrlN0kOOY+qd5zFH0h8hmaMW5Wm5xkr5FEf2rnPsX+L3uG4f
 Fl+Q==
X-Forwarded-Encrypted: i=1;
 AHgh+Rovqdsy3VKSvhVzbDzTsUN02Rh81yQI8yGcfDQj3augNWNB3Ru55lQDjMEPf74C18OFSYJSOj/hEN0o@nongnu.org
X-Gm-Message-State: AOJu0Yymw8VJbmwAfe3hiuZnc1DZV+hZDcev9AX1j38Oe2pSN2hb8/QF
 +Tp/f44leD18VXv9b6ZdME83StfKMqwdLWRT3mfDVjdPt+ccBA6Egv+mqgA0GDaQzYrUc2VJscd
 +NCckP5dLTPQmtbhbXXi6PntVWadVZDk=
X-Gm-Gg: AR+sD113eoFpOETP+VZLSQG4czcb3Ai6mJ5i1U1CiXv0Y3X1Ya9FuR9e0dmbu1EHBmu
 nu9RSXnT6jLM29v8sxPG/VrfNtKPBEB/aZVTHoLTy4wb6ogiMZzj8rOBDx4v1CWL9oiNg1X1bDr
 uBuHvgylX6ttebjJ4JJSL4nGNPiN9VT2PRbvkhsH8qVCntX2XtpZErFxW/D4vzrnqpbktVxHfPN
 C60SwW/H8kjU3ZdR8AfQEdfAPOsmNAJi8WZdbjArk4ubzQ9oWerZapT8oEgpt3MKeaXY3CXSeaZ
 5qs//jDPq0sX9AJpk/RUbD0JEnEVHhK0WklZwPp0XyzVZzlLDrnFvMQ4yaFTprw+U0xb+EHrlJx
 AWQ==
X-Received: by 2002:a05:6402:324e:b0:69f:b347:a681 with SMTP id
 4fb4d7f45d1cf-6a0a7c6c13cmr4054285a12.4.1785671257155; Sun, 02 Aug 2026
 04:47:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260729084046.22211-1-kwolf@redhat.com>
 <20260729131927.GA1379893@fedora>
In-Reply-To: <20260729131927.GA1379893@fedora>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Sun, 2 Aug 2026 07:47:24 -0400
X-Gm-Features: AUfX_mzeTWFittyK246WMSn1MyzXPRqqbj_yqneSFEaHl7uWYX1Xrk3FmLH38v0
Message-ID: <CAJSP0QV_ZT2o1w3f+krQMAqxO7X1Sa_33apVfF+rB8vQvszm5w@mail.gmail.com>
Subject: Re: [PULL v2 00/17] Block layer patches
To: Kevin Wolf <kwolf@redhat.com>, Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, 
 Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, Jul 29, 2026 at 9:19=E2=80=AFAM Stefan Hajnoczi <stefanha@redhat.co=
m> wrote:
>
> Applied, thanks.

This was sent out in error. The series has not been applied yet.

The following CI failure occurred. It is probably caused by "iotests:
test O_TRUNC behavior for fuse exports":

************* Module tests.fuse-truncate
tests/fuse-truncate:43:4: W0702: No exception type(s) specified (bare-excep=
t)
tests/fuse-truncate:48:4: W0702: No exception type(s) specified (bare-excep=
t)

https://gitlab.com/qemu-project/qemu/-/jobs/15659234232#L166

Please take a look and resend.

Stefan

