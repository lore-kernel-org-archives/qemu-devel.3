Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55504CA5FA3
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 18:25:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBG2N-0000Vc-Cc; Mon, 28 Sep 2026 14:25:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xBG2B-0000TV-GO
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 14:25:04 -0400
Received: from mail-yx2-x18.google.com ([2607:f8b0:4864:41::18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xBG29-0005CY-O0
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 14:25:03 -0400
Received: by mail-yx2-x18.google.com with SMTP id
 956f58d0204a3-672c2880f58so3215931d50.3
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 11:25:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790619900; cv=none;
 d=google.com; s=arc-20260327;
 b=MAbgacHteDssoKmH/PjTEC9jrBGXeUEFarFbyQYELep1vcXhClwm2H/8hAlgSraach
 VK/vn1AD4YxQhh3/GugWgzU9KH9FRxVihe2Qmfnux22piaQO1Yl4CMUjoSWzcmtMgTDD
 bovXUjRMo6w7sEBXYY9iMmKS+OFDu4c83zxqIvjvBO3aFgvVL1ZOvaGJGdko8DdfczHh
 SAUlFM0EfgOFizhvgKfNjHYK2ce/Z94UGJ3te7WrdqLlBvP0xfnsr3PClnct5tLspsuD
 BG7vP5Baj3SLJJUe85UVY2VCqHXXQtYgUlMkhR5e5MEMn76SsesoCEG3+HvoJDJKWWqb
 M6Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=gZpVKf1g9yRixFnkrPBx6mrrZHYsG7fWj+h4V75H9V8=;
 fh=1aI44e0p5XplGskc+UeFLoNCjn/8ANQtrjF8ujCp7vc=;
 b=JtrRHj6e5b0k0jdxLP4W2m/zAYhvyAPheRdBZrX8r7bdyRIn01n5I2PpwCvVkFVl1m
 5UmKolfsnFb6ykI118bMT9pY0+17SdnJZkaUqcygdZ8oUnOI0yjEKb3sV8yrsMV4gdSt
 0OegW6HJPfJreg1GUWKfYQmmnr84hxxx+cTI1lmU0KVNcu8ilXJ/HT2VdWHx1sadiLW8
 ybzrV2ahL8VtD0G1P1op5M5XFsr1JVgbE28vy4ldAYkJR6HrmYUVYuvt+jgKl4do7wfc
 b4HI7HSji/RonRh5eLyOXRChTbda8Ty+RooruDrUkdEk600cjv0Qyu0+mczRke7OKSe6
 kUeA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790619900; x=1791224700; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=gZpVKf1g9yRixFnkrPBx6mrrZHYsG7fWj+h4V75H9V8=;
 b=cPGPMJszvqDg+YhmxrYvapr7WJ8jwMSJ2CO1Uar8II2kJURiv1UgqIDmbBPp9+Ewd+
 XtnF+ZKYFqU727Oafdq0Re/ejyLE7tPPS+457zMcjle6n5Ddvvh+KWWpodFTQl1HpbxH
 uL6OIJraxQsfq/EVoxmnW86dWxhe8fEgloWx7BTzAfYXJa0yf/FVTcFIJJR1VaehCmlW
 2gjBYEmjXFdp1oSQJ2KiZweeZ3LYfyNh1A94ONYtdgPeZoDd6PF4V8YM9FydXCqVhhqj
 PGl8CVL2hkz9wPKpH55fwwbn3qa41y3XXbWBIEM/jDdRYPAzLAqUdxdOP9O66s7T2aW4
 4gZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790619900; x=1791224700;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=gZpVKf1g9yRixFnkrPBx6mrrZHYsG7fWj+h4V75H9V8=;
 b=qIkEfaYtLudXONQXLOah+Bv6X21ePBOIPdF3987AP2wif0seZp6kRxUObDGUdwxdNS
 cLEp5MacDslHiUoUOfLr4k3bT3Wz+KczLivEB6H+B80UbL9ZeVUNQuD7me1tQ2BNhN0Z
 umYzegPE4y+ZMaF06so2aFPLl87puDLJy0GFuHJbHMe1tORdVyqCmJWtIQ0FntQK3ZrT
 ITiLfopsHFi/AYd8czhSffqfjUyk4ckre1VysUGLZQUuci5TDP78dYk7Hz2eQt2vimGm
 JRlNmaKGi8ZeZ3dPHDDCtC0vbmU1+4XODOS0Xwctrj82w3oMC4bBfapkuhhtyGtwYebt
 XU2w==
X-Gm-Message-State: AFuF++k4s3FW/GbSjUcb45Z4BhdLqsC/wDb1nhxHJ66WEQoqIoB5acpZ
 Xp2PFLcqVdK/L91Tebf/e6hNhdk2SEgBKqWLnDukE6Eib8jlzSeMZCcvRspGMV3NpZJBxJMLDUm
 ZWxDMY5uRDN4oHGbaYq3kyJ1/C7IMM6NxfF2hNOOTCg==
X-Gm-Gg: AYBFou0T4DsnfFSf+82jeO7+ti2FOmOycsjTDPMV8/JE9WYCGwVGWJwrKuLd2C3ezT/
 KAMHZYDsdfJtsckN6vjJdp9RKo1es7Bx48iXyc4mIxHoObryZOncBMkRGXJNYbTVq3GeR27tbk7
 aM8GKBq1zXYVxQuuS4x0m+RRVOKZfMmMRpA0Kizifb26g6ph7YPrc0RrFWCyTDK9wBc1e+uBY47
 LLIeI701LIRNNtzxoPviIddeiBUihrBQBDpKEBCZiHCCKYc+EoyZhvWnKkx23RyzE9P0gEVTSs6
 NpjtQTI2xaijmUBHeSdWaexcxBYgzg2M79d9DnkVDBj8I9K217vrmAURpyClMzpj0Zzp+BiLpV5
 KvgwU864kFnGljmKMKmI1yzHp3sIgx8R+rRoVohcWKqJbAfW2WFFrGZTJYZ/z
X-Received: by 2002:a05:690e:138e:b0:671:26c4:3ac6 with SMTP id
 956f58d0204a3-672ed2d42b6mr6316143d50.37.1790619900134; Mon, 28 Sep 2026
 11:25:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260921214710.29422-1-shentey@gmail.com>
 <20260921214710.29422-3-shentey@gmail.com>
In-Reply-To: <20260921214710.29422-3-shentey@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 28 Sep 2026 19:24:48 +0100
X-Gm-Features: AclHuK_sROfBW1qfLbwtQ0CUTqzgWPm1WlICzUHlHwBeNhdtxobVPxQuV9afFsQ
Message-ID: <CAFEAcA-vzAe6CZ3W5wSw6Avxp4nBp3CJR9BL0G_DL8VNbNzjGg@mail.gmail.com>
Subject: Re: [PATCH 02/42] hw/watchdog/wdt_imx2: Remove unused attributes
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, Phil Dennis-Jordan <phil@philjordan.eu>, 
 Alistair Francis <alistair@alistair23.me>, Alexander Graf <agraf@csgraf.de>, 
 Jason Wang <jasowangio@gmail.com>, qemu-arm@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:41::18;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx2-x18.google.com
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

On Mon, 21 Sept 2026 at 22:47, Bernhard Beschow <shentey@gmail.com> wrote:
>
> The previous change rendered the locked attributes unused but they were kept
> for migration compatibiliy when backporting. Remove the unneeded attributes
> and break migration compatibility since QEMU does not guarantee
> compatibility for i.MX devices between feature releases.
>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>  include/hw/watchdog/wdt_imx2.h | 2 --
>  hw/watchdog/wdt_imx2.c         | 3 +--
>  2 files changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/include/hw/watchdog/wdt_imx2.h b/include/hw/watchdog/wdt_imx2.h
> index ad36b8820d..0bf2903959 100644
> --- a/include/hw/watchdog/wdt_imx2.h
> +++ b/include/hw/watchdog/wdt_imx2.h
> @@ -84,8 +84,6 @@ struct IMX2WdtState {
>      uint16_t wmcr;
>
>      bool wcr_locked;            /* affects WDZST, WDBG, and WDW */
> -    bool wcr_wde_locked;        /* affects WDE */
> -    bool wcr_wdt_locked;        /* affects WDT (never cleared) */
>  };
>
>  #endif /* WDT_IMX2_H */
> diff --git a/hw/watchdog/wdt_imx2.c b/hw/watchdog/wdt_imx2.c
> index aaf4695db2..c8ea704aa3 100644
> --- a/hw/watchdog/wdt_imx2.c
> +++ b/hw/watchdog/wdt_imx2.c
> @@ -220,13 +220,12 @@ static const MemoryRegionOps imx2_wdt_ops = {
>
>  static const VMStateDescription vmstate_imx2_wdt = {
>      .name = "imx2.wdt",
> +    .version_id = 1,
>      .fields = (const VMStateField[]) {
>          VMSTATE_PTIMER(timer, IMX2WdtState),
>          VMSTATE_PTIMER(itimer, IMX2WdtState),
>          VMSTATE_BOOL(wicr_locked, IMX2WdtState),
>          VMSTATE_BOOL(wcr_locked, IMX2WdtState),
> -        VMSTATE_BOOL(wcr_wde_locked, IMX2WdtState),
> -        VMSTATE_BOOL(wcr_wdt_locked, IMX2WdtState),
>          VMSTATE_UINT16(wcr, IMX2WdtState),
>          VMSTATE_UINT16(wsr, IMX2WdtState),
>          VMSTATE_UINT16(wrsr, IMX2WdtState),

We could alternatively keep the migration compat by using
   VMSTATE_UNUSED(1), /* was wcr_wde_locked */
   VMSTATE_UNUSED(1), /* was wcr_wdt_locked */

but as you say we don't care about this for imx boards, so
bumping the version field is fine.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

