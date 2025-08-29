Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 210EDCA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 15:20:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usN7w-0000su-0g; Sat, 30 Aug 2025 11:04:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1urtB8-00087f-DV
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 03:05:42 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1urtB6-000580-Q0
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 03:05:42 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3c68ac7e238so852110f8f.1
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 00:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756451138; x=1757055938; darn=nongnu.org;
 h=mime-version:message-id:in-reply-to:references:user-agent:subject
 :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=cAOhZGc27dkuJST8zP11DmoI//cCNWK0In89yfdGBtI=;
 b=Usq7gCy7WWU9bQ4rkdCDMET2J0i/ktPvoy7cVBaD3jx0VAzxPPWEXhU0A/htE0ZtY1
 4hhIPhlcp5FAx8g5VTxrKW7jk1d4WczqjKXlrrwx9L9EU/vyIeGAhWOTuXmq0W3fXHrT
 TujhNh3y/g+9sMaqm/ApJ41CJ9wUsWAXeR5TqQjDHeZfujjeaUoNPWkIF0ZyxCL0EHoi
 YXEUU3eMCqmTOXNeVTEsbQ2JSok+vLjy7tiOK1waL/KLqnIlSZlQdPhaCSESRgAmtp3b
 2zKjxul/xfxUPiMW+OUudVinxH9rm1rD5gOvzDNPOVkkLA7e3ZHrzMAiu/6ujOdK1NnU
 8w6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756451138; x=1757055938;
 h=mime-version:message-id:in-reply-to:references:user-agent:subject
 :cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cAOhZGc27dkuJST8zP11DmoI//cCNWK0In89yfdGBtI=;
 b=gp9bKCYy8IM5TOjyi/cHsnoa2BMrfP1GFqXw+wQjR1e95kULwc3HEuVDHLkz7+GE9Y
 H0X2xV7vpOxpZbLvxYGcamknENPp4bNjQ5bPDT1DdSKSRlygW1kcH3WVeqkpiCvGXFEQ
 qrgIZ315JNAk4gs4tareUjVmnmufZlujRDugvQsvx/QE6Grp5jDZkbwQ2sz4pUzmFd15
 HnUYl/GcZmGcM4/1FJOEwDQGzTv9QBWtNBX2CfBd6aGr+psvELHqRtN6cdZkxy0+Acpw
 0NL2nk+ECx7e1oVseTmvromtn726LL08glla3tPba3IERrNiBdcwljcwW2czVZ4fxVo7
 O1Gg==
X-Gm-Message-State: AOJu0YzAhB60SQi+urUJ/eIw2BsGkBS4xqm5VR+Ql+ocEt2qTSRtd3Hu
 MZJ0EmiDmkXuel6+LvKcI2mSjMAKixM4d5Xw90gnBywDOnVEHzoh9iW4jJlOmXKDgYY524q7uwn
 J0Fn4318=
X-Gm-Gg: ASbGncvJ8TJAQzzW0kg05idFDASljWnt+JGZhSEGgqg72x8Z28L9D4T1LE+DoW03QqG
 Kcv5iF7QYZDu1KFZFcVkW97GvZqqL4YHh1uVfCdRD3NFyBJiZCTdUK7+apiXhRTe8lm37JhXIjf
 Ndkp6cGUagp88CVIzQFnBvHrHU6fAl1oHFsvil+MM+URBBwjeaycE4MxtWxtm42mmjyeHpWjpfD
 dYyciw3XtN+RsQhjAOtwgG9lrJLiVWW9GY5MvTV6QKVf3iGwhMaSLa/HoNg3EhmTOhoNJyl7q5c
 NIBhXo7n2VofLAA+wAh/Jj2lYfAGkZeGORiraUDQ5F9Nl8P6ti14ItTh1+8LnShqMo7gQrMdVdl
 SO648Xw+uAyEGJYnJkeoSwfq+FRBJRm0fdo8IMPRrsFaEUI5dP0FQzb0OenskuxJUIlCPUKlO
X-Google-Smtp-Source: AGHT+IGJ1PgFzNy1q7ttXbnzDctuCEmlWCg78sitn7yqV3Y4V4H/seXq6XhyiRDj8ifTEA2XoGJjmQ==
X-Received: by 2002:a5d:64e1:0:b0:3bb:2fb3:9afb with SMTP id
 ffacd0b85a97d-3c5dd8aa03cmr20614987f8f.31.1756451137823; 
 Fri, 29 Aug 2025 00:05:37 -0700 (PDT)
Received: from meli-email.org (athedsl-4441256.home.otenet.gr.
 [79.129.180.152]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b7e7d1319sm27430195e9.5.2025.08.29.00.05.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 00:05:37 -0700 (PDT)
Date: Fri, 29 Aug 2025 10:05:23 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-arm@nongnu.org
Subject: Re: [PATCH 10/61] target/arm: Use raw_write in cp_reg_reset
User-Agent: meli/0.8.12
References: <20250827010453.4059782-1-richard.henderson@linaro.org>
 <20250827010453.4059782-15-richard.henderson@linaro.org>
In-Reply-To: <20250827010453.4059782-15-richard.henderson@linaro.org>
Message-ID: <t1qudc.3cwx3bccf19p3@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x430.google.com
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

On Wed, 27 Aug 2025 04:04, Richard Henderson <richard.henderson@linaro.org> wrote:
>Reduce the places that know about field types by 1.
>
>Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>---


Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

> target/arm/cpu.c | 10 ++--------
> 1 file changed, 2 insertions(+), 8 deletions(-)
>
>diff --git a/target/arm/cpu.c b/target/arm/cpu.c
>index e2b2337399..ed40e102fc 100644
>--- a/target/arm/cpu.c
>+++ b/target/arm/cpu.c
>@@ -192,14 +192,8 @@ static void cp_reg_reset(gpointer key, gpointer value, gpointer opaque)
>      * This is basically only used for fields in non-core coprocessors
>      * (like the pxa2xx ones).
>      */
>-    if (!ri->fieldoffset) {
>-        return;
>-    }
>-
>-    if (cpreg_field_is_64bit(ri)) {
>-        CPREG_FIELD64(&cpu->env, ri) = ri->resetvalue;
>-    } else {
>-        CPREG_FIELD32(&cpu->env, ri) = ri->resetvalue;
>+    if (ri->fieldoffset) {
>+        raw_write(&cpu->env, ri, ri->resetvalue);
>     }
> }
> 
>-- 
>2.43.0
>
>

