Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF3F7C2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 15:45:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSIRx-0002aL-Ag; Fri, 12 Jul 2024 11:44:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sSIRv-0002Zd-FI
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 11:44:43 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sSIRt-00040c-Mr
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 11:44:43 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-58e76294858so5722165a12.0
 for <qemu-devel@nongnu.org>; Fri, 12 Jul 2024 08:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720799080; x=1721403880; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Z7UffHzQjmPyx7rxKTTvVwSEtjIHN+mL2q34pvIefb0=;
 b=ieVwYxCpvjlDxCYfHgDkheD6qTX8nhy0rEWqjuH5gilwV9JbulKsHCCr//wQSw+32q
 NPvA/nrdhNTq2ACxFMuI93kNm1lMQ8oNMk91oOmhiJUhuV28GfRljqbjjODTjH+4LnaP
 D0nEw1Jk5AbidRJBzOb+u4oM1AV0yethkaQ941EpsXFbwDGT4kIjzB6s+LzFpIBde63B
 snuesdQIk78Nkfk1prh7Es5Iq7KNwRyOpirgpbMYG/4P8Mi1UhdIfn+tQBMGu2idYzTY
 2TOsZcfDS9FzMtytyVs8Sn+3dAonRYd9cqe4/vUSvXCRZYpQ6EE4VoBCmD2yHe240HIk
 yHNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720799080; x=1721403880;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Z7UffHzQjmPyx7rxKTTvVwSEtjIHN+mL2q34pvIefb0=;
 b=O1AMywLjgUakCLonyDhdTHF0x38anAAywVTdM1Ydv+EviiGKhPOKHict4M0P872Dfc
 4OfmVHWHM44HGBGBZP+t+tLo2WO/4AT/PtwIpVsiL9LVLqtdQEsSth13hn0MSBRkQTDy
 A0x2a5txWi18RaNr2v19xjc1D1NIela8yOPJ+i9nc3a7d4Xc3lrRmOGLEHKf/jNUsJAU
 /UZUMsLJtWwiExjL3MGkg/AQA4Eb45vlzGLGzvVEkvuh7YkqlKpv0sHrLpEy0jqdUW5C
 vWsFc94tgoNzhP06S6Gyk44kp8r9YetGIjb90MzBxNofwZ5EzW2XVw2N9SsVsc+BkbyF
 sRPQ==
X-Gm-Message-State: AOJu0YyvfA9xUuVqEjVBDDmuppOOGwvm+y3M3PJDKjmaG8kKIWPzex35
 sdpdmUbWGehJ5xkk+uLfrJCGYqRn+cXP2NoWI//ZpaGPjhujYUXmTkUa+lleV++tosCqeawX9s0
 zvQnh61oSJ8XMje09Tke24LffdtEya01ZhP67Iw==
X-Google-Smtp-Source: AGHT+IE040j2o9MWhsEig2caw8f7e/XhZ3IgxnAtIjnz0uoKqke/zm4dBH9bIPGg4+iw3yBnMGOk3wPDU+UQDmOBKok=
X-Received: by 2002:a05:6402:2107:b0:58c:36e:51bf with SMTP id
 4fb4d7f45d1cf-59963bf43a4mr2845480a12.3.1720799080041; Fri, 12 Jul 2024
 08:44:40 -0700 (PDT)
MIME-Version: 1.0
References: <20240712153857.207440-1-sgarzare@redhat.com>
In-Reply-To: <20240712153857.207440-1-sgarzare@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 12 Jul 2024 16:44:29 +0100
Message-ID: <CAFEAcA_vtekZr7aEuH_=HQMPSw2L4mD32f3+rUCr8mUHWjwYKw@mail.gmail.com>
Subject: Re: [PATCH] contrib/vhost-user-blk: fix overflowing expression
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Raphael Norwitz <raphael@enfabrica.net>, changpeng.liu@intel.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, 12 Jul 2024 at 16:39, Stefano Garzarella <sgarzare@redhat.com> wrote:
>
> Coverity reported:
>
>   >>>     CID 1549454:  Integer handling issues  (OVERFLOW_BEFORE_WIDEN)
>   >>>     Potentially overflowing expression
>           "le32_to_cpu(desc->num_sectors) << 9" with type "uint32_t"
>           (32 bits, unsigned) is evaluated using 32-bit arithmetic, and
>           then used in a context that expects an expression of type
>           "uint64_t" (64 bits, unsigned).
>   199                               le32_to_cpu(desc->num_sectors) << 9 };
>
> Coverity noticed this issue after commit ab04420c3 ("contrib/vhost-user-*:
> use QEMU bswap helper functions"), but it was pre-existing and introduced
> from the beginning by commit caa1ee4313 ("vhost-user-blk: add
> discard/write zeroes features support").
>
> Explicitly cast the 32-bit value before the shift to fix this issue.
>
> Fixes: Coverity CID 1549454
> Fixes: 5ab04420c3 ("contrib/vhost-user-*: use QEMU bswap helper functions")
> Fixes: caa1ee4313 ("vhost-user-blk: add discard/write zeroes features support")
> Cc: changpeng.liu@intel.com
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  contrib/vhost-user-blk/vhost-user-blk.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/contrib/vhost-user-blk/vhost-user-blk.c b/contrib/vhost-user-blk/vhost-user-blk.c
> index 9492146855..6cc18a1c04 100644
> --- a/contrib/vhost-user-blk/vhost-user-blk.c
> +++ b/contrib/vhost-user-blk/vhost-user-blk.c
> @@ -196,7 +196,7 @@ vub_discard_write_zeroes(VubReq *req, struct iovec *iov, uint32_t iovcnt,
>      VubDev *vdev_blk = req->vdev_blk;
>      desc = buf;
>      uint64_t range[2] = { le64_to_cpu(desc->sector) << 9,
> -                          le32_to_cpu(desc->num_sectors) << 9 };
> +                          (uint64_t)le32_to_cpu(desc->num_sectors) << 9 };
>      if (type == VIRTIO_BLK_T_DISCARD) {
>          if (ioctl(vdev_blk->blk_fd, BLKDISCARD, range) == 0) {
>              g_free(buf);
> --

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

