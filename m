Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FA31C9833F
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 12:47:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBAlI-0001nD-0X; Mon, 28 Sep 2026 08:47:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xBAl5-0001mO-97
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 08:47:03 -0400
Received: from mail-yx2-x0e.google.com ([2607:f8b0:4864:41::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xBAl3-0002Rj-3a
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 08:47:03 -0400
Received: by mail-yx2-x0e.google.com with SMTP id
 956f58d0204a3-672f4b7091dso1491553d50.0
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 05:46:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790599619; cv=none;
 d=google.com; s=arc-20260327;
 b=MTvTnG+qz93LiZjW+UB8NYHIMZvdoDHPd+aJRFji89d8K9xLKounA5E14zXVRMvXqx
 GqZ5QUogK7NMq7Z4ma58uhTN06T9xD75g1CUAtI0brsY9mTTh4uSrmAZYeAxYYXOsHaf
 B7HZJAINGH7gcBkBOwVXsPA9EIfwEWJeq+vi3uAR//1wQJXbv8ss8GU+HCLc8HbJnfXR
 RxLKY2v7A1ytgRxiGHTTDGhbbirumIecDg5QaqGNhaLhgR5RqQNQ65sL48L9abvcFORN
 vKytCd/2rd+XoYmFxbNlyzXT14GEkwE45XUVIfTHnfAzYOvwZcAhRuJMqvgP3nA6f7R4
 TVGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=1+VGnfe7ib3gQRob+y51DwBtrmpQpMtEkJB8abEMfHI=;
 fh=gicmf1zLCz5mLo37/slHRwiGNwG9FuwwhzHTeCt9t94=;
 b=NHbFI+3MldWr3gMMmKqQ/Fh8Zoxy8h/1PmBLzQ0SgyyD9uYWdq6wqvnQoslDe34ah4
 of9hx+zJ4nFEFsGjqW2EQtn0uubNsHHhz1brOuFOtVI8hN80YwDja+aEbaTx+Bj/Nbf4
 2nxXlZVdeLN6+xVgbuDU9eJ/ZaSpfR2om4kJpW0GGDDBFklphlIK1YlX5/vX/Wzh6tpA
 a+m0r3TizHt+mHNE0eojQcyd/haVw36Vhu1FaNJKt5/ZiP9fphyHVLhLG5usJvOLc485
 4wYpOwYNWq7prOzWLrf9LerZ/W4h94su3yB+bY0gNMfE9fbY9RupRqbgPnlvCRcIDis7
 MGHA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790599619; x=1791204419; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=1+VGnfe7ib3gQRob+y51DwBtrmpQpMtEkJB8abEMfHI=;
 b=TTqPhQxKTHe5DMnnQAlI8u9yWG+m3OGO+lDEBm7ckCA81Vy0cSZPWciObuuotlS3R7
 3n9RDAJMDg2fccpxrUoMWPyJoK+U6pVj8TYZX02ALtYgDoCvhRs4w87ppc/ijtYGMJNd
 gVMEOO9VLS9xoRp1GuSshDEy77NPUQ2SUIvPZRlPUourokZqMa6Oz7IurukJ2Fog118a
 NB05RZjslL1rJyoEVCOhmdDN20Fv0e6psfj8xvP9TLI2bBOzgLiG5zWDPXmrFUGEP1VP
 g4SWIxobw/8Vq2lY1fnb1gEGGLM8PgKBqW+IgljjJJmLvJ6BfAKA6bjl0rxkJu8oTbOK
 yp0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790599619; x=1791204419;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=1+VGnfe7ib3gQRob+y51DwBtrmpQpMtEkJB8abEMfHI=;
 b=ybHqNMrVHStGVCjPNdzltkHantPT9DelFzBHT7Ae028p3IcA6c0w7XSiLjAZOtmI1N
 2EDgegTHWN5Ar/xMgs+GFgVbYBBzidnyMzfafz1bw0Q6yfDHl8oxTaQ5gwB3znKwzawD
 8Yvvj1NsUHAtUMR70am+dmxzr+zSsSBcPC28dqjP3BCfHav4mujYT0N/pvdyN1u+RnRc
 gtkszVFuT54doaZ+6LnULeNi+FiEuIUXWZ0AezqfAUqfNSeFS1G7VzJXFxo/idIkj8PQ
 GodfSz7u9G/MBTD5KP5aIiX3XWwSMmp4wxvTZ0IMZ/C1qsgmyInVSH/7VKb1nHHD+BKL
 3xwQ==
X-Gm-Message-State: AFq9FYKfr8UP4hWE/Jyr/Lcy+DjB8atVQFdd4dLN8jM4RUA7o3QtfpSZ
 2Oz1kfGAuYXrtC9s1+UHociqtl32CX4U/Rq0TrHUEcZ8G6OzfRcGAZOuAVpsiwovYs0nKWXCMZk
 5+eaL9iykfS+ep81DE3iUDyaUQNLL00mRFAeQ7eH8jg==
X-Gm-Gg: AYBFou21u+ix9AZLt6jmne1hosDseBYjsLcbT4vRVWR330pKoKuk5Zj0YsUlnwtu5Z6
 k9ViLQQvdFx7JcYe1rdmfYyPzLZE8JYl/x7QcyBDhISKZvl9JeOggcG8prjuqNfF1SPRyeHraX3
 lk5e8/CYdgzLYrFmO2lFM2PbkwznhVOkz37QjznktpfcHqr5/xab7T2lZzp2l/DX6Ix4dpMSnwa
 S0/HKwu2GWyhWFCFG+kCcQ7kqhRRNtqxovwQLOXGB6wwynxK5xYXEnEz4G5EXNdvIvTGfvfk4M3
 HipQ0Q81wh6/hl6oPSSPlG5ttpyWZOJGgNuauTe+eSmxcYuNCc/zqD2VZC4Ry189YtmseHAE/QY
 fkJeMNALuuTxCYQpg0UoYc/3wK0egD8VfnJ2bCkQ=
X-Received: by 2002:a05:690e:191a:b0:672:b59a:3784 with SMTP id
 956f58d0204a3-672f82be77bmr4530233d50.28.1790599619037; Mon, 28 Sep 2026
 05:46:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260915-allwinner-gpio-v4-0-b1ee1d09c9fd@gmail.com>
In-Reply-To: <20260915-allwinner-gpio-v4-0-b1ee1d09c9fd@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 28 Sep 2026 13:46:47 +0100
X-Gm-Features: AclHuK8MQJ5VUUQArtFEHdvd7zJe6_nFwFZL2uYShKGj2cKjGpMO_aiSMW2-jUM
Message-ID: <CAFEAcA9_=TV9xxkgBC+30xAtbqX9A9EJ8-1sO_ei9U1SB3qEiw@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] Allwinner A10 GPIO support
To: Strahinja Jankovic <strahinja.p.jankovic@gmail.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Jack wang <163wangjack@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:41::e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx2-x0e.google.com
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

On Tue, 15 Sept 2026 at 21:27, Strahinja Jankovic
<strahinja.p.jankovic@gmail.com> wrote:
>
> This patch series introduces GPIO support for Allwinner A10 and
> Cubieboard.
>
> The support is focused on input/output and interrupt functionality.
> The qtest suite is also updated with tests for implemented
> functionality.
>
> Signed-off-by: Strahinja Jankovic <strahinja.p.jankovic@gmail.com>
> ---



Applied to target-arm.next, thanks.

-- PMM

