Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5B72C61DC4
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 15:37:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzc9y-0003XM-46; Thu, 27 Aug 2026 11:36:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wzc9w-0003X4-P6
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 11:36:56 -0400
Received: from mail-yx1-xb129.google.com ([2607:f8b0:4864:20::b129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wzc9v-0007fb-6X
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 11:36:56 -0400
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-66b32bb75beso155652d50.2
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 08:36:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787845013; cv=none;
 d=google.com; s=arc-20260327;
 b=o3/ALhhS79k47Snx0TJdVLTpDG3dBEKNOm5Wd0uaefxGRBf0qG4STBpxBB/9s5vm/0
 5O9geRsB3nyg3mRrT1dSx6ryeEFecbUqmJw+FEXrP9T9dipL5bTUx6EiriNWMn9x/Xwg
 kENDq7Is9fWb4BnVGaJO+MWrNI6n9xo44OTwAPLcRFJ2eIW+81A27hxZ0wDsurMX3QHc
 heVA2qensvNqczYroDOxBzgNjr8SVgVuTnOYaZMDl25Fmyb5C5B+H9EWfmFclOYQGlCb
 rGgpemRZBcTDx6vb8Kir6NNU/MrjgLbSExIv5rN1KZNNBL+wm22IqSYxlac+PW4oa0g0
 g/uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=l/TIyVx59OMApJQbBVsOFK1nHzU6lLIk98gtKNMSbdc=;
 fh=bIE/bXSCkVaBwWnI5E22W+KoiLTAK5S4CW9f53swsiE=;
 b=OsDQJWWt3TZStyP5b+aRF+7S4m1hgsRkljzlqrtCGi7H8Mauu+pVM+JQKrd1NPBQ98
 wH6L+Vbn+Xc+UaefEAEAUcmAS0JnP8ZMMutUWg8f0Mq2tXZQ6B9pZ8kOGocVOR8ZL7OF
 5J6SzHuCuB5ANSiFkjOLtq6LOcCtoNGRLxTxG5I/aqiifF9F8Be2JmUvRyjw6CElO1PB
 wUoPA4RWkY6m63j4zN5q5w+CG+WQb3vMcKHbJksXmQZVoTyFNJy4Ma5g2o8IVseTZgIa
 L/NYTWz51ff4Lhwi4lLr+hAPluLRQX1TWD6QcLqBRH/c2v2+fdTQYVFcfptTjhECQyc+
 kRDw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787845013; x=1788449813; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=l/TIyVx59OMApJQbBVsOFK1nHzU6lLIk98gtKNMSbdc=;
 b=QtA0KBtnuxpV0FnJiYEqRzceMyBzwJEBIEAmwZNG15iOHNnZQuez1zhLruh9bMIqKX
 40iyn8bOd+J2ZsjOZdXIoEN8ihWBktNZ3GA98tL2Y7dxRbIYx0MpAWgzN7svBQmOde70
 gPI6jRnFMg0gc/nzA3hugzOwDDEBd4pHVwRDBew7rNTczo73qRLiQHGIMEqqDiU2TfvE
 tMfQBXcrkxPxgLhaskFvFGtp34/jRAjL4XHRV7M3ORLRhOzR75UolSlv0+3VcU/J5L3b
 dMD87gbuckW2hYGlpKuqQmJuAW9sBovZcq2/Q/4shFre3G0p5nLfzEMQ+wQC2FWn/ZWw
 rATw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787845013; x=1788449813;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=l/TIyVx59OMApJQbBVsOFK1nHzU6lLIk98gtKNMSbdc=;
 b=M9kCqAvRMUm3qYMdIR5rLsQxzfDLyNp8vr+Z0ngcrhbc71ttJkFQ6qTUq8qsGpLdCr
 RPfLud+b/Vc0eZX1RTaVjCg6abTnRtNHm7BFya5F0SuXHBGOtN0tlD/for1/jAg7kRJX
 jv7rrtrreXhYirVkihCQlGmNU3RdKWftqDSvGl/qutzSAClZgJ2nm7sjT2c8+uZzIw1g
 y3X7IVoBwHqSYTErO51H4VNMs3VojheN3krnrVul7PmMJdhuZYewkoAmHfO+h6ziOFgr
 ilaGeh1JE0/JPkoDKul3qyrVrgP81fuCyQwTfSrXXestcOEydWiPnFNdHWelJXYtm+QB
 B6aA==
X-Gm-Message-State: AFuF++m+E8REf949/rXaXXxqFuPGp8edtUC3MNpjKf4Rigf3yLaazfmO
 UFe2/5SGdk7n1cTB0N7gffIPbncW93fzgbDn+cjHviUnYlNMIwSd2n1oWNJNVmId/VJmiv0yemH
 3Sq6qk6LTcn4LStUEwg8FN3g1XiSfV8AN32Vw4PjRHg==
X-Gm-Gg: AR+sD10yu3mcvmMUUnWhc14nriYyzcYsUMBnnN6zycw+JXGtQbhVgPR6Gltlt5YM3V7
 fdQ59qkIeIIx/KKtQ+2bEc9MUPHJlTGs8PjR4zCPGs20RI8quvBXUsY+3MomhkTvEgyqXl708CG
 AMEtPgIgUy3Gh+pjTphJRBAqCsj1O2Ona+IqBjheZIefAhM4g9qyweEwsqbv9fFkIM2e4XIpHfL
 ejNDbmd3kO/P+v/7ym3UPYpNbzEls9xxqvB+dbNJFG9/Z1yDG5dCT/rF1BmV5QjLhPSbr37/8Rw
 Dn4vKtHgfx49Zl9kVCLFZ1NnzkPdZrFOlDSbFx7g6aLyUT0lRuv2E1xItXp7QTsfP/49D5x+rEp
 cxjgBVITXUB9915he3q1VV8f2+czD
X-Received: by 2002:a53:d4cd:0:b0:66b:245f:bc5c with SMTP id
 956f58d0204a3-66d265b185emr4118134d50.24.1787845013526; Thu, 27 Aug 2026
 08:36:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260827041557.775080-1-richard.henderson@linaro.org>
 <20260827041557.775080-7-richard.henderson@linaro.org>
In-Reply-To: <20260827041557.775080-7-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 27 Aug 2026 16:36:42 +0100
X-Gm-Features: AcwNN1VE4A6DEQBsF9B2SBkhWaLHpuI2MlkXT4GBej8LorOtY5HOOEoOTmHpQtA
Message-ID: <CAFEAcA9HkALxGJ-iExtMCyw-KKnJD2UGwfjh85iKo0zi0cf4Ug@mail.gmail.com>
Subject: Re: [PATCH v4 6/6] target/arm: Separate cpu types max-v8 and max-v9
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 pierrick.bouvier@oss.qualcomm.com, philmd@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb129.google.com
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

On Thu, 27 Aug 2026 at 05:17, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Do not include v9-only features in "max-v8".
> Do not include the prohibited v8 features in "max-v9".
> In aarch64 tcg mode, define "max" as "max-v9".
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

