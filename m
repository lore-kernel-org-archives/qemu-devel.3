Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 212ACCA0ED1
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Aug 2025 10:39:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umrqM-0001uu-Pe; Fri, 15 Aug 2025 06:39:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1umrqL-0001uW-N7
 for qemu-devel@nongnu.org; Fri, 15 Aug 2025 06:39:29 -0400
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1umrqK-0006oB-8l
 for qemu-devel@nongnu.org; Fri, 15 Aug 2025 06:39:29 -0400
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-71d608e34b4so14811227b3.3
 for <qemu-devel@nongnu.org>; Fri, 15 Aug 2025 03:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755254366; x=1755859166; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9wc/eqV5CJpniaNekjMFu9EClWKreI+sOXyh0BkdMtE=;
 b=Tz8cZWICI6bQ0g9VNM+1CjpNM6r9ydn6b36C2b3tApg13loHnQoCoaplI8buUtDq4+
 jBNAWWnAEEOUeHzlBnv/hVNGIrjaCFGSHdQUL/4yLlKHHcf4tiMfFspBoRYoLPcRUYMQ
 n51mNIuoY2nZ/gniT4pyTa+/Oqwl+FP3hpwe32jtFkKgYlARHNKpWxPxA5dQ7vzWK69U
 g2xMn01s1XWthsCYuHngw+h2s7hykOlu8zbxFEhqLq56VcRmZJ5QB9rYcs/vgRGaIVSk
 Neaj443Qyo5sxxpONpM7ykTf3H21abdA3XDPoGiJSBZhBOHW1vTazWgCh9jyj7VnQYnu
 FAdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755254366; x=1755859166;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9wc/eqV5CJpniaNekjMFu9EClWKreI+sOXyh0BkdMtE=;
 b=wu/9BStWnNxQloWVyfJ1FIVPuffNS6MCbf9YEZ7MswMnMPcT3mhSoo1AjP6OCMv953
 8Trnd88HptNTUTiw1tph+NxkO4PyTZiD9xrJ9MkanJEb0PheGQgsnFfZereRUH955ZEI
 o2Y5lQpiEg6r/fluNPOW4n6yK7iJh3YMvLwROdZC3CNR4Fw8yJlGcVMGZdeBgmYmdIkN
 Di8TITgSZTMo0XbG9K092xOL+uHjoD7HdrEXPtOzaDaebyotUwJXHdZz8Fc4GJYnuqEz
 9VMwg4OhpdqmEtPc5IBsl5+qq7N608fVMa0tj8ozrAgtQIZ0Qz3xIY+M9pcbG2dPv24e
 27Ig==
X-Gm-Message-State: AOJu0Yxwm6m98ESykfKUU99+nHA5RMUrenWhRMQPcg8rNAYW684TpZ9j
 anIzC8/riNTxi13L8Ldi/BPd/deRFdHeIEYB1HwU+UUcUtG9LeTE9gWRtQhTriB4xZMquDG//g5
 PbL6LcFjyEc1hQx8yfJIOTVQsTEj+a2z/bAEvd7frFg==
X-Gm-Gg: ASbGncuQ58vuzD9hRKS2HcDxIyoipEILKoEed4bqCaJkAuKi7R3SrISfeot/Qkx5s6K
 3I1mvLtgwZgEIpS1tpJgm83h/1Ams/1aiLOE6u4IV/TkGQZ9Ujlxz6Wc/+tvLkrPc9B0Tq/hGcm
 FP4uGrbU267zk1IMrQyMm+w370am+91FW0m6Pe/Ge86dy44FPzteip2OhCC/+uOWdblYYX5z0He
 IWS8gVu
X-Google-Smtp-Source: AGHT+IH/GAPe0xMzpu2J/gIwWSUNd5criB3mTG9uE9JvpqBodcZ3QPZfBms61fdaWK6rgkl5vEFea6LbqyQuMTFYPwg=
X-Received: by 2002:a05:690c:a9e:b0:70e:2d30:43eb with SMTP id
 00721157ae682-71e6db0b8e6mr18300727b3.12.1755254366458; Fri, 15 Aug 2025
 03:39:26 -0700 (PDT)
MIME-Version: 1.0
References: <20250725014755.2122579-1-gustavo.romero@linaro.org>
In-Reply-To: <20250725014755.2122579-1-gustavo.romero@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 Aug 2025 11:39:15 +0100
X-Gm-Features: Ac12FXze1AQlmvC5N8zBROO2cVX_Nx756cuSGpZhiFsFbNrHNiXdKqGfrF8xRxs
Message-ID: <CAFEAcA8CB=iKVbs4tvyCRZBECxkH6WxXXZR=4=X-ci1Bbo+3Fw@mail.gmail.com>
Subject: Re: [PATCH] target/arm: Clean up of register field definitions
To: Gustavo Romero <gustavo.romero@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, alex.bennee@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1132.google.com
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

On Fri, 25 Jul 2025 at 02:48, Gustavo Romero <gustavo.romero@linaro.org> wrote:
>
> Clean up the definitions of NSW and NSA fields in the VTCR register.
> These two fields are already defined properly using FIELD() so they are
> actually duplications. Also, define the NSW and NSA fields in the
> VSTCR register using FIELD() and remove their definitions based on VTCR
> fields.
>
> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>



Applied to target-arm.next for 10.2, thanks.

-- PMM

