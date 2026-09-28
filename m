Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C620CA5FA2
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 18:37:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBGDe-0002w7-0f; Mon, 28 Sep 2026 14:36:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xBGDY-0002tU-FS
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 14:36:49 -0400
Received: from mail-yx2-x0f.google.com ([2607:f8b0:4864:41::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xBGDW-0006or-Ht
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 14:36:48 -0400
Received: by mail-yx2-x0f.google.com with SMTP id
 956f58d0204a3-66f7f72a284so3340299d50.2
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 11:36:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790620605; cv=none;
 d=google.com; s=arc-20260327;
 b=a5cXMdqa3bJurA7TcFdl21qCaYJ6+PQpY1rAaRAbxnOb11sPIP8wjX+FjPY7f1GKBA
 qPq/V5g15oU+THczVwOVgYtvdWXzq0DbQ2e5wwZu3rnq2ohAPEfH5DrDwg6/VGZ02KmG
 wlKL58e3x3Ed+xsrSQgUn8cYWHT7jT/LyOH54ggDggFD2Ym+nfDPtoZAMCJvsQbY6ZKu
 7DQZXT2nP5Nal8P0U01MWmrikatcdGSS8pIWmcsO8nEHe8VjCjJiUasdPQxzM1Y/5CAd
 QTL8/aAcGtePCTkZQF2sSZNf8VvhHq4rQS5ZE71rwDmqnNasb/0RLkymFoLaHJyiIvsC
 PE9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=VfXZmPzgDoa5P7dYUzGaXCTyNeVCE8jiaFThkqVF1Ik=;
 fh=1aI44e0p5XplGskc+UeFLoNCjn/8ANQtrjF8ujCp7vc=;
 b=SMJrMsbs/dalWVgdc2SRHjLPNtwKQRx9llyfIy0RoQSSTrTCkUd8Obxt7kkcagCzHX
 a0DFTeqe71U8D26xY04f7Z5JyHmsp6NXCnGIMaW/pb6rboyQ66OAsIwqk8l79ckIy26X
 Op69LI6MhqfCDUZfp68aAD5Uzc5nwtMjmXh0jplNKyyFy7Wgk7P4pTInXUg8PKrxBj8M
 xHc7I61Yrj5Y8QFNc08WffknQfTSI+MSzS5zTvsx3YcPkeWDeudH4BLLRV1XLVeB3CKc
 v8Ks8s1ptRCtXH/fqLHmqeZzM2TWdaGZnn5JNE71VTvYoVWyACgHHx1/XjG/63gEBY8Q
 0p1Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790620605; x=1791225405; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=VfXZmPzgDoa5P7dYUzGaXCTyNeVCE8jiaFThkqVF1Ik=;
 b=gg6dP/l+zH/BNNBGvswMLKDL7RQu87T2crEnKFj6la1O05anexmsONE/vTAYAsE2b8
 dSsiSOdNKGzuOkZkGoG1+ELcQl8sRzY6tk/+3xNntXeM6vkOAtpUNCht5EwepbEjaSIq
 LtM6yXA6fBJAF/Ey2bUQ0xGcacSbeDlORT7LIpWQeVhe9iOyP3YGOgwXXMys0EWmDf4a
 OvDULyCj274V4S7FP+XjWDp0YGzZwaE+BJ+WWLqe3SIuVVvGcSMjvcxk+mmWTKVXaynZ
 rIcUMBxa3nhNaf2Lh1rdqvNGwNyYXrf9L9X8pf8noICvZ1/9po0oLQSW4rCruRUBwoRq
 Un2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790620605; x=1791225405;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=VfXZmPzgDoa5P7dYUzGaXCTyNeVCE8jiaFThkqVF1Ik=;
 b=PjVrOIrmtJ9gPVSSTCeR34GiLbl7tgkV+mKHwdlWct8GWGJxFHiIH532KCoMn6EE98
 6Q1YP/3cuVzzI4x+PHqMQD6a9GMhBFIL4sXPniFJZnTM4PcTwWfwTCwvKIfRVojlkreZ
 t5cV5AmniP1pUaJ88CLFLMaKg35Ib67of1/J88VwjxRO2OSEaA5892hTUCUfArVG/DfG
 FdGIqFaYwQmQxBjyCr3pGpJvNdzHUMSZbOVgpGmhk25ryAgW5J0rNSdNGYnkS3ZGbgIS
 2avXJoNY7gsdlbewTURlJqljVsKN057sUsQqwa/HvzB1npbfd0q5n1YK+PAqrb0ZEJ6G
 Pmvw==
X-Gm-Message-State: AFq9FYLQJNd4z96xZRlVJUXINy1TpbkzsbbjhmoaNwPamU2fW+sGpM7M
 OtEzbAJJY6jcjRRsbK6Q7F06dE/e+v8ZtyBenyLSLGBR9UrNMArAVsj6kqZcMoowU+B7e5eu+zR
 QOUs8JHfP1fFxM8S/QmknCUns/I87PdDjC6thfosv7w==
X-Gm-Gg: AYBFou2YM+Pp6XnIb027vK0OcUGDFFIPWg9rZfVfg9nK2ofwmRznQSNUco9L7AiLo53
 PMSHx3dc3pQRm3qsRO745bgAODMgVJ4NVaYLEvcUelwSWKkV6t9DIvcMWgNgaG9QX7qMc1DXcUs
 SDW0hViuZdU4mT/KAlGzjanLQGef+lnSCo7B0XUDMJk1xNA0ywtUnSK5YxSyEOI77wDqm7bVfx9
 zZ5cg6HgkY73nD6YGYXnoINITNCL46fVyk7424RGl2o6CKZl+L213VbvE6nQzZy3NXPfhT/T0GR
 LT9By9xedtZQQmLWlLzf0vf92HSnQT13u27Eph08es4dt4TA+bd4oY1ltmvwjVxW+h/NpXT4FVv
 8cYUhiELReFawLE3JE0dLBK1KjFAFZZ1TP/4AYec=
X-Received: by 2002:a05:690e:1c0e:b0:675:2f4a:53dc with SMTP id
 956f58d0204a3-6752f4a58afmr2673831d50.22.1790620604759; Mon, 28 Sep 2026
 11:36:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260921214710.29422-1-shentey@gmail.com>
 <20260921214710.29422-4-shentey@gmail.com>
In-Reply-To: <20260921214710.29422-4-shentey@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 28 Sep 2026 19:36:33 +0100
X-Gm-Features: AclHuK9ClvGMFqhPwyX4dBQX_CUXvMzYGlZX3KWQSLED_vyBuWm5Ogp3zn5RoBc
Message-ID: <CAFEAcA8XL_THyxPv4dBi6qe7O-J7cTiHUmoBp6jaqx0F4mHOjw@mail.gmail.com>
Subject: Re: [PATCH 03/42] hw/arm/imx8mm-evk: Fix reference count of SoC object
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
Received-SPF: pass client-ip=2607:f8b0:4864:41::f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx2-x0f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Mon, 21 Sept 2026 at 22:47, Bernhard Beschow <shentey@gmail.com> wrote:
>
> Using sysbus_realize_and_unref() requires object_new() rather than
> object_new_with_props(), otherwise the initial reference count is
> subtracted twice, i.e. ends up being one too low.
>
> Fixes: 7bcd1f30bc83 ("hw/arm: Add the i.MX 8MM EVK(Evaluation Kit)
> board")
> cc: qemu-stable
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>  hw/arm/imx8mm-evk.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/arm/imx8mm-evk.c b/hw/arm/imx8mm-evk.c
> index c3215b11cb..6de0d9c4a2 100644
> --- a/hw/arm/imx8mm-evk.c
> +++ b/hw/arm/imx8mm-evk.c
> @@ -83,8 +83,8 @@ static void imx8mm_evk_init(MachineState *machine)
>      ims->bootinfo.psci_conduit = QEMU_PSCI_CONDUIT_SMC;
>      ims->bootinfo.modify_dtb = imx8mm_evk_modify_dtb;
>
> -    s = FSL_IMX8MM(object_new_with_props(TYPE_FSL_IMX8MM, OBJECT(machine),
> -                                         "soc", &error_fatal, NULL));
> +    s = FSL_IMX8MM(object_new(TYPE_FSL_IMX8MM));
> +    object_property_add_child(OBJECT(machine), "soc", OBJECT(s));

Ah, yes, I vaguely remember this. We noticed this was the wrong way
to do it for imx8mp-evk.c, in this thread:
 https://lore.kernel.org/qemu-devel/CAFEAcA_cYDwOFP_h_pKyUQ0kKmT671iZiNntzMC5O5tF=1cC=A@mail.gmail.com/
but not before I incorrectly suggested using it in the imx8mm
patchset that was just landing in the tree at that time.

This patch makes imx8mm do the same thing as imx8mp used to do
and eg imx6ul does now, so

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

I do notice that we also have the approach that you changed
imx8mp-evk to in 8099d86d3, where we have the SoC struct
directly embedded in the machine state struct and can use
object_initialize_child(). But we don't need to adopt
that here (especially as I think there's an unresolved
design discussion about whether we should prefer to avoid
the "embed struct in struct" pattern entirely in future).

thanks
-- PMM

