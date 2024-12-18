Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EBA7E77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 13:53:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNuUm-0007K9-SK; Wed, 18 Dec 2024 08:53:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tNuUR-00077A-So
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 08:53:31 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tNuUQ-0000NB-C2
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 08:53:27 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3862d6d5765so4471906f8f.3
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 05:53:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734530004; x=1735134804; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iU1wah6x7b5MslfUYKQomLNIR3ZIixvB16ptQKyzYo4=;
 b=Sbjt00bTMRdxJKVlubbQn2sjiJMEBRvwMT+Vh6HaaY9I2wCtrWuiEITM9f7aqgmK8I
 B5k01yWJIEN3pJmDuXE41RZCR3xrMB+k8wqV7g/79s4r9LclhCjz6XkduqjidIhpazsZ
 NrTYAyJq3t43gCCPs+hrQUURdO3QW9euRm2kfNcDq0GRtgc/1aVhPw9tlC4YTHZtRb8H
 Z21blatUpeD6e1AjTAsGPvIzGBBwR/pY+O7ns95wtjLk1sapuSdAXpYw/Rapzwum4oKe
 wH35g5Hk581qSjdbVMXg5bndudmztCMqkGCxKHy21xFpwYqB5W2M+wjzSJ2KZUD/8EUk
 74cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734530004; x=1735134804;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iU1wah6x7b5MslfUYKQomLNIR3ZIixvB16ptQKyzYo4=;
 b=PQKt5ennxya3bke3a53tMcw/l5eW85H8L5bvgP6fi+qYIPDF/Y4xycZNLXkB1b68XG
 rvI9d4fl+sHMZeNGmusOAvqs5Y8YLHPa4M4eJyOFo8n22Luo4DNhCyKg3/GQTgZdLK91
 3Hc2Ixj6bVciSZDLqYSv5RcN7wrjiL5R8PQaoo7eW9sEZhhgKYmnC8IoxzXlnBzIe8ln
 fT9j3cHhemZMBa+834PZs/MbsV3oyheyAx7HCLL3r18iMhI3UoTJOHeJ5aKUZptj+hsI
 1dKNcI0a/rgSkjG8pgXfgLLC18bAYM7CGOmzv6F90VSNZzq0QSAk4WRhsq84o22YXTnc
 KH8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWC5IW4PRuPl4uMVcLsSstwqn1SqdamaEcTi0iJmdIn7Y0gKqGMELxIjYTasukc1RBVJtiWFcOuj/Bk@nongnu.org
X-Gm-Message-State: AOJu0YyUNsK9lA7Wr+Lara7+TmP65ILnLFJ5uZkhKXw9dZ0YERPArmTN
 v43Dwcck9YePwXnBpaEyeRilshPIgDGTyO3/1qLYtFcActFv1ELY1SPstlXpFdKGdnxpbm7p78y
 v
X-Gm-Gg: ASbGncv7obiTOPBvKPkeqi0OsMVfc0i7npwGQv+6SdtxQ5RSt/VHXkZ6iZRzqIWqTcD
 bRCtTrRNXVb4A1cS1O725ZKdTxmL2nXtL5ExU58Qk+132B2PFga12T2khs5NSS3WNuFwvvHhtPb
 2PJI3JKZub9o0d0oWUxCk0ymvkPi4UWgjXZQdWI0mvfNSgGbDz3oA2x28wMymjErRRjkaH6Ti31
 kWqyjglWVE6b8SMOnAI+vwb3+ytHwXJGLrHojHayUTNlJ5AKrpmwDaylvTJRPwYmGxGBHao
X-Google-Smtp-Source: AGHT+IGYmZXfmuu3fp3l0rao5CtfLftJ2frt84ylyfq3g0urpdE03ZIBTA0BO8f8T0XnDYtnQkZ2aw==
X-Received: by 2002:a05:6000:156b:b0:382:4a4e:25bb with SMTP id
 ffacd0b85a97d-388e4db272fmr2866949f8f.46.1734530004580; 
 Wed, 18 Dec 2024 05:53:24 -0800 (PST)
Received: from [192.168.1.117] ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c8016678sm14099200f8f.27.2024.12.18.05.53.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Dec 2024 05:53:24 -0800 (PST)
Message-ID: <32f3951b-73f9-4ee2-addc-601f40d3979b@linaro.org>
Date: Wed, 18 Dec 2024 14:53:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/24] hw/sparc: Remove empty Property lists
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
References: <20241218134251.4724-1-richard.henderson@linaro.org>
 <20241218134251.4724-11-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241218134251.4724-11-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

On 18/12/24 14:42, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   hw/sparc/sun4m.c   | 5 -----
>   hw/sparc64/sun4u.c | 5 -----
>   2 files changed, 10 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


