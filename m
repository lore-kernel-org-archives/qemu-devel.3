Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2213FC02193
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 16:05:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfLPz-0006ox-UP; Tue, 04 Feb 2025 11:04:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tfLPx-0006kW-Gu
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 11:04:53 -0500
Received: from mail-yb1-xb34.google.com ([2607:f8b0:4864:20::b34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tfLPu-0004Jw-2O
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 11:04:51 -0500
Received: by mail-yb1-xb34.google.com with SMTP id
 3f1490d57ef6-e3983426f80so5068891276.1
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2025 08:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738685087; x=1739289887; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Okbtc3zy1ExQAS3dQnXD9WnVhEHm18zS9WJrarGNMh4=;
 b=Lb4cMpP4uBYd5b30pEAhwdHw9kuNI8DAU1uNqvvnum+fQNWIVDsEi7YXlyLlvNs9Wh
 XqiJqDbiG32xPbBeJiDfg4jBwUcpNEQ+eLJY40T6HpM4xr3R7LqHsChYw1JAyJc1jEyN
 6VUX7FWzrDmexUK8QRqwiMBX6n4yP2E4IOK5aEKOCWfkcFoA5e8Wi1WMXplZ9zdK5eIK
 ZAqIH0WDGUjJQ7eUKakCD3EgXNkW4hWbGxPuKQJpkVAYxUkY+lp/hDWG5or3xVdfCPny
 qLfeBZLBnoK1a8uPhv+fPWlu9ENlpcQGLwbYIa5K/vOyPWSJJmLkMYmquM08hD9/dNdZ
 yEKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738685087; x=1739289887;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Okbtc3zy1ExQAS3dQnXD9WnVhEHm18zS9WJrarGNMh4=;
 b=LH4kLONTxOrs7G8JR9coGaQJRYSFeO9fWHxQOXtZbvtlw2+W0CXzfYDhprIwAJybKU
 0+iixP7la79TR3a+pOQC6k/yPxH5s/cRcIR16Gn0cHt0+5WbcKrYrkNdfvuou17JVu9D
 kGVgW9nj1l0r1uMpVCUios8Wen+URASLq2YllpCGoZ09RLEWDFZLcQs84idph2RoOR7n
 g+SebpyWwZrpk7aV2dfweGyeEmNKOncC2OvXkaZBGJc1tzuXgs7K0Fas3Ek0G4WGGrY5
 pBIS6dfDpGSmPvOlEkukSG0yvVGcnQmiAEUoa/uRtIo2BwOw3hIRrrT9eVBAFSmfQhK0
 euHQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXy9ex5dpCm5V2m2tLUGCKZK9jvndX+XHdyV1rvh/myqlc86QgsqNdutP0HMZuLrCHtD6sZ2x0yQg0t@nongnu.org
X-Gm-Message-State: AOJu0Yx8nOA8ZVUmLsaAx4t18BCXdTuXa2leVfRCymwnzfbUX+Lcjs0r
 fvmeGEClS1BlaHkNXrhlAlpgP2vb8YpaVY7inyflte4GfMshnbbttXPl2/oZnSbrpExSxNTZDzR
 makGJ2RnShcYhV8sj7Vdv8FsaRsTgMpY5YoAFv+q98BjREFi+
X-Gm-Gg: ASbGncu8QkyXjp51NPtoroJAA45LfeaYFoN91n6dvnwYU9YMM2eKIZlgwbR/xNmwJWu
 4ngdqNzx8osygpIkBayb/nvYNme4Gxn4gBZ4t4sCfkL5DxfGwrWo5ARcwsBgJFDjuJzjHZ2W8qA
 ==
X-Google-Smtp-Source: AGHT+IEEPuXDnnOewQr0xl+U+nlqYnqQHCuQoJKkoA04g476BL/7RVYBfIO25KXsdD0kN8J45rvQQAVXMGryMM8H9uU=
X-Received: by 2002:a05:6902:200b:b0:e5b:229a:f1a3 with SMTP id
 3f1490d57ef6-e5b229af773mr501424276.11.1738685087495; Tue, 04 Feb 2025
 08:04:47 -0800 (PST)
MIME-Version: 1.0
References: <20241226082800.2887689-1-wuhaotsh@google.com>
 <20241226082800.2887689-14-wuhaotsh@google.com>
In-Reply-To: <20241226082800.2887689-14-wuhaotsh@google.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 4 Feb 2025 16:04:36 +0000
X-Gm-Features: AWEUYZlvze7u6l_dW4EIGh31GDYXxdpy3GDY_qLGjmmPxokUfJWMi5-FXDWg2L8
Message-ID: <CAFEAcA9hi0+PDh5RvcsCNe3zJGX1WmHVsu0S3_UeeyuJcWV9dg@mail.gmail.com>
Subject: Re: [PATCH v2 13/17] hw/misc: Add nr_regs and cold_reset_values to
 NPCM CLK
To: Hao Wu <wuhaotsh@google.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Avi.Fishman@nuvoton.com, 
 kfting@nuvoton.com, titusr@google.com, mimik-dev@google.com, 
 hskinnemoen@google.com, venture@google.com, pbonzini@redhat.com, 
 jasowang@redhat.com, alistair@alistair23.me
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b34;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb34.google.com
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

On Thu, 26 Dec 2024 at 08:28, Hao Wu <wuhaotsh@google.com> wrote:
>
> These 2 values are different between NPCM7XX and NPCM8XX
> CLKs. So we add them to the class and assign different values
> to them.
>
> Signed-off-by: Hao Wu <wuhaotsh@google.com>
> ---
>  hw/misc/npcm_clk.c         | 17 +++++++++++------
>  include/hw/misc/npcm_clk.h |  9 ++++++++-
>  2 files changed, 19 insertions(+), 7 deletions(-)
>



> @@ -870,10 +872,9 @@ static const struct MemoryRegionOps npcm_clk_ops = {
>  static void npcm_clk_enter_reset(Object *obj, ResetType type)
>  {
>      NPCMCLKState *s = NPCM_CLK(obj);
> +    NPCMCLKClass *c = NPCM_CLK_GET_CLASS(s);
>
> -    QEMU_BUILD_BUG_ON(sizeof(s->regs) != sizeof(cold_reset_values));
> -
> -    memcpy(s->regs, cold_reset_values, sizeof(cold_reset_values));
> +    memcpy(s->regs, c->cold_reset_values, sizeof(s->regs));

Same remark about an assert as in the other patch.
Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

