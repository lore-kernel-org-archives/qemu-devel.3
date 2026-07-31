Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67C02C55167
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 17:27:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpr0g-0004DJ-7z; Fri, 31 Jul 2026 13:27:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wpr0d-0004Cp-LV
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 13:27:00 -0400
Received: from mail-yx1-xb12f.google.com ([2607:f8b0:4864:20::b12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wpr0c-0004Ev-AW
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 13:26:59 -0400
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-668432fe416so1442109d50.0
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2026 10:26:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785518817; cv=none;
 d=google.com; s=arc-20260327;
 b=Ne1821lYy+4wVE0xT+H53NV3xjBlLlAhiltYQah+2xmWIcBUWPWtuTY8O4n9Skok8o
 Vkno1wpGF2+0U9s+juNqWcYIqYvnaHCqB/lgNSf9gRj2CeFHRLT7F9FtDEsk1EciwVb1
 I1+CsMHiiBmcgKv/Lb43ydRGMw8yTVzfpVC5EyEIKWdfLqAuBZiANuAfOFu6wI53xlrk
 dmRAymI8D87TeKtvfjpHjmGshRlA0vgjH8zsTlOApKqstFXzHuboG+CSNbrlwe6u3wRm
 ocgr7ygU03FJzV9EXVSeyyRDAJ7zocY0XwRQWS8u+dqDV1NdL/HB/Oh10Ijq1SvdDoK2
 n/8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=KuuowhP2UdDdnOWtUgrEsplMwd0+prZe4J3mAit1Okw=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=n/HIOLmo7IaouD9CQdJrKDwVDPqhIVkPwrqQ7MnpsM/qJhV8oWXbLN2QPC1lCb6uzD
 Bfyq92js28xMN1Cbv1jh25xWnP8BWZxUr52SCI6O7njZLs79AU8kD81WXxUTMI7DvEbd
 99ZPxhGHqcBrzXiXnGS+BeNqFNBpVz9QZK99fiICBY+qzXgdipuX0qsbdS4THzMHKhQG
 piq5seTJrY774t99h5N+vAn72hAqH+CXREGsQ73qayPG1eaivELuN/3aJ1idgu1z/2Dx
 aanFX6tA6NH/dn8uweF1bffjV4cpoeKKCKdorUrh2xF+dV6QHWBSgOYOVp4mxADoCBDC
 DA8g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785518817; x=1786123617; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=KuuowhP2UdDdnOWtUgrEsplMwd0+prZe4J3mAit1Okw=;
 b=ae7Q54+szhFQKFUkyoJ3WeVvFuNujcPxTLheVKJvYm0Tluyt8c33WZ7M5VUUKNmp3o
 S0EBHYqSN/3J+fzkdQnHDlyCEYVGNcgrblB+HpgjdfX6o+v83ypAGKn6zp53ldNfSIUc
 kqkg8n6+T92SeqyfwrAyBzZ4fG7U1sKxMj+FE+DiWIqZ52clqPnjNmiZhi+2E+z/xWJx
 a5w0dlQRpP5lYfTw3qf4SD5ufwzA+SHmk4LPqrbbzl6arqQHRyw17GPGVc4eydhy5FAx
 zDt24NrYyzzJp52sNkFuuDQOIptV2wIzaBmrjv0/Q1ql0BYWprUWuTlEbzU+WLC40tBc
 4v+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785518817; x=1786123617;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=KuuowhP2UdDdnOWtUgrEsplMwd0+prZe4J3mAit1Okw=;
 b=SMILGgZHYtcOsdIEwEWXFNKKWV0i2WcNzyxVEX596X4tAIj2Qt5QL8VStv5vLo+I3i
 79bVB4r4mvGg0K0vSksuwcPDNasn0i7k1YUM+kpEvVqM7QpVpz8HgbVFQwcrNLxTT7F4
 jrfNeQ2rl2Y3JxjPaxfTofd5GFkKjcRb8gL3uYNvzvoGddiX4rz8C6mDt18xRJNdRngT
 NeFlJBk+8u1zEeVbQokyGxVErLshbmMf9kCQO9WuDvNfkxsse57OAFbPreaiGalFmz9p
 dTCDQ0wc8g3fIyiLfKVVGqD8I1Xuxko4DzZ6M+LvCKqFMingrG9kZKtNcoeNYQj4tM1O
 yEWg==
X-Gm-Message-State: AOJu0Ywdtg1dKSriz5asYH2Yl368A5XRgMgo7JILIQx2rZu9CTODpcc2
 HvTqRwKf6cK9skSIbkOhdomP0vJROHjPR2P1bJ2VHTrLDetwln1imerjMTLKVUMy9h8srt9NvhZ
 g9L26kRyQfmbbStqEAhh83GYknfn0e+/KAHITm3FC7g==
X-Gm-Gg: AR+sD13OR0Tt+J3s2loWGoMeuVMwMWcs5cJ7ZKZdsf3/hLGzeLxPLBLJNvbhPmxS9mS
 Ju5nPbZnYQ4iGrV+MWZGr/mRzMrASWd0V2u1zpT1CRSYSw+SAn1Wnb+U9AtWELCH7Dz2NY8pWsA
 PqBJ+o189gq3Z0+dvFUzB2QRjlOgn6ULVpd769I+Nb9M4GQ25x5/H+SkilVTDSJSy9LL5k6/kf9
 20XvypJS8U0jFW5nymSr2E/msYQ37rt/9XQMiWcfk4jEnAlQQt62wHWleF2aaeqnlhOdnDV+mJ9
 gaHKN3ruAt+fdAfcUOg51i7Lo5wL/c/gh7DAhiQdfG0bkQ4L7MvdWceBLGOFtH/IVOICZmbkwcU
 w2YUZ5ptnARGtaVHxNMyximlGErTJ
X-Received: by 2002:a05:690e:484d:b0:667:6919:897a with SMTP id
 956f58d0204a3-6694f17d7e3mr795128d50.25.1785518817107; Fri, 31 Jul 2026
 10:26:57 -0700 (PDT)
MIME-Version: 1.0
References: <20260724030616.76180-1-richard.henderson@linaro.org>
 <20260724030616.76180-6-richard.henderson@linaro.org>
In-Reply-To: <20260724030616.76180-6-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 31 Jul 2026 18:26:45 +0100
X-Gm-Features: AUfX_mwqS7jehq9hJGk8fgiV1fY2kBzARIX6t7PaSuTp2SoMhZBir5V_tDKOUKE
Message-ID: <CAFEAcA9BLUaK9p-MbBP+6qm2vAtd70hdkfXcAovPyw8m5bg6Kw@mail.gmail.com>
Subject: Re: [PATCH 5/6] target/arm: Set fgt in cpregs for FGWTE3
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12f.google.com
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

On Fri, 24 Jul 2026 at 04:06, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpregs-gcs.c |  5 +++--
>  target/arm/helper.c     | 47 ++++++++++++++++++++++-------------------
>  2 files changed, 28 insertions(+), 24 deletions(-)

You missed setting fgt for MECID_RL_A_EL3.

Otherwise

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

