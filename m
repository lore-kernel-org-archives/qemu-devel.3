Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73FEB10AB832
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 23:40:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5uJF-0003sd-56; Thu, 26 Mar 2026 19:40:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w5uJD-0003rh-GJ
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 19:40:15 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w5uJB-0005MF-Ub
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 19:40:15 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-c76864f4e58so39012a12.1
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2026 16:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774568412; x=1775173212; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fkDYQ8A6uUP11/J/8eNKQJQXtm4Ez1vUP/TRKDlm2q4=;
 b=SLrlpdZLozkb6NdDMCqeA6YJMy63tpdbrhqOYewK3wehFF/7jCytHYnMXhE+acU9Tp
 8RVYCCZdSUG+Pxsq5wVJaYxBNrWugcughU1aqsdkKDqg+yqs+ZTqT9FzrXHenRk9Clne
 IF3Y24S3Z9bLBLKS0P1F9FwnRI41MUyBFIK6r4zeN152LnK8Ow3wfY78gxpE54M642A5
 t9iV+b5Cs52KJyuyJ7zb14RS7HX0aUnlLJWmZclnBPiG8uS+cpwEKPaQHyeUeggpmvet
 Q5s1syWkAsqVg+J/YesO2kXWxW2AxIWzoULyANkUBMSJE67p/43oVnOYk2eRlCapOmwN
 RAow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774568412; x=1775173212;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fkDYQ8A6uUP11/J/8eNKQJQXtm4Ez1vUP/TRKDlm2q4=;
 b=VNPQRmm5m0hGEeVDZrYwbdV3sxtBpubBTOIQoBS43u2qZtLbNtGgm7Y1KwpCnQRGvQ
 FA67hhJaagmfz0m0+14yIHZf2J4GVpNir5hoWMsi13p3TQIikjG9esp06+kvF1XJ1k2J
 tt9WGY0X4a8TS5Dl0SQXuWS4dExQ5SSwLzUUOyP6Zi9KjqGwa9QDrKYbMjdBAo6Dd+Yk
 S6XkhXgLTgRcNJmrMtOJr88VQaw5dgUuCmEKjOvu68GTqOdII6Fgs2L2sEGXgD5VUiIc
 2UYi7ZcadfFpb3tlfn0u6vQzIszuadXInuhT5sPCBtx6WiqJLscYQvrdjwoYOCx+UD0h
 AOww==
X-Forwarded-Encrypted: i=1;
 AJvYcCUc3E5rOKuzTUSfDqrL8N1Eo7EO2Weq6CleDn0miAjfGk8lKreeWIL3EemW4t3AcU/Gm4SzMnMmJKVe@nongnu.org
X-Gm-Message-State: AOJu0YwBxg++ALTd8+FFNgPX6/M0MQFgimjdLr/8iCmbh0cdGuLUSjBL
 pPB4zqwjWH7I5A46LZw1xnu9XfszHx5Rj3gREmMRzJe9X6EjZwePQB5qnKLLaZoepe8=
X-Gm-Gg: ATEYQzw+jNAiCetD9c2lQd2vU1FR/opMVK6JCvMv+zT45FW7OCV0rwhbAhLBikNS0vz
 apr3ebmaVRhYFEL2VxOgbqcG6/ELD+UYWLLUqdJdf65JNn+iM0ZJuUnnbhBIMTX2FX5wkSM/SPT
 0STVamFT2NZ890zIeXs5Ia/fIFBFZM9vo3qT3/lfFIFYn4N4adpUIQ4Z0RiRyQTEnpgJwMw1egS
 t6AcbLuIQr1IfbYJM/WF5qRuHLNFkIxOzhxCaNZvYUbSQKeDGzniMPDO8iCdH67P2bm8AO2UnJe
 q7Th4+6K2JVDWxabFfeyxF3ztk9S/XaRMMnpcQh3f+rxKkW0bJhJEsBeVKu+W/VB2CK4LV0HmKR
 AwF7UfyVOiljsxzZnS537Xv1wGNreRIEutrWdnN3pX3ZNcpSyldKaRIOcpPL1oJ6LJe2sgr/S2C
 Er6WUxPqfHRgUpP/U4xo56//4d0/tYTheJP/2bRBEC6dQkwnUGV1rD
X-Received: by 2002:a17:902:e5c8:b0:2b0:5320:23e2 with SMTP id
 d9443c01a7336-2b0cdcb73c1mr4688795ad.34.1774568412238; 
 Thu, 26 Mar 2026 16:40:12 -0700 (PDT)
Received: from [172.16.11.156] ([103.100.225.140])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b0bc8f3b98sm38267675ad.70.2026.03.26.16.40.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Mar 2026 16:40:11 -0700 (PDT)
Message-ID: <58afb28b-3811-4f77-af65-ec622a35f0da@linaro.org>
Date: Fri, 27 Mar 2026 09:40:05 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 4/7] target/arm/cpu: Add FEAT_MEC object properties
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Cc: alex.bennee@linaro.org, peter.maydell@linaro.org
References: <20260319022335.22523-1-gustavo.romero@linaro.org>
 <20260319022335.22523-5-gustavo.romero@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260319022335.22523-5-gustavo.romero@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x531.google.com
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

On 3/19/26 12:23, Gustavo Romero wrote:
> Add 'mec' and 'mec-page' object properties to the Arm CPU object that
> allows setting at machine level the memories used by FEAT_MEC.
> 
> Signed-off-by: Gustavo Romero<gustavo.romero@linaro.org>
> ---
>   target/arm/cpu.c | 20 ++++++++++++++++++++
>   target/arm/cpu.h |  4 ++++
>   2 files changed, 24 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

