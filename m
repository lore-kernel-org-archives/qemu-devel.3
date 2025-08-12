Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C7B8CA0EC4
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Aug 2025 06:17:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uliJn-0000hU-35; Tue, 12 Aug 2025 02:17:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uliID-0007AT-Er
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 02:15:32 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uliHz-0004qH-OY
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 02:15:24 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-458b49c98a7so32240355e9.1
 for <qemu-devel@nongnu.org>; Mon, 11 Aug 2025 23:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754979311; x=1755584111; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=V0JWJo4SViWKiNN4xpgB6DcEPuM227grV2fn8SaUMjE=;
 b=S8G90bOz5Naoih28DHSyApdcEYZchZFbiSVmGMTsUkF0QC45Rx9xXp/HQIiTrgNWfM
 fvohR3e6fStmRigNPc8pbsvpWjQl2dxriibEWKEaLBPDuJ3shQuE2LaM1PLug7GI55oM
 zQoFGxZ5C6q/zi7OurcJdJu2OuzwSaDJ5idc2asAUZWrmao/uiCDnF5pB85kVR2Rgfo6
 I+LX/Qs20Wip+q8oF2i4GYX1AVGv0qnXhXiD2lrT88fxoZpitl1WRYAU0juDW+oCWcqV
 Mj+yW1UYEFdQA0AlJGGQRFSUd3WfQ2b9ObYOLFSnDv/AgUDivhdJRXedYrH2CNxmMKxl
 wd1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754979311; x=1755584111;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=V0JWJo4SViWKiNN4xpgB6DcEPuM227grV2fn8SaUMjE=;
 b=tNoPhXlhUpmq8lt0dAkHCqDbW5vauYGPEQS0Znf/aaQ+HmqDTuqJzul8i/Xmo5vEYE
 vdlR5OI/MZImfIrMGKCASoFZm3BivV/1nftr5h/jwYc28H3cANRhV9l5oSIMzTZqniLE
 6hP9ecCdrncSNsU+SWB8pnBS6ONDXPsTQ0n7krLM+mn8gK9eFX5RMPJWp+Xl+9NY1oX4
 Py6xSOFnVCME3wzTQBeBDLc+oRJdaxH95w44WqHLRFkQn7uSkeIAXAoIh4eTVfbqUUiY
 WWKkGc4fj27yXOA2NIMOzjvuIIN8pWsRpaA3BAYxkfEsaH/oifUC6SYArAHy5u+5ZPVZ
 OuKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXoE2WAsKOeKm+xFEa6/pBazVFvtOaQujS4tNitmlE16prdgLIi7olDh0msMksxw1Da1Cgf4mzYaxGF@nongnu.org
X-Gm-Message-State: AOJu0YzWMJ8utUrnOGH2lwzEvyZYpjcN6vtx68s7LQ3ktfcPSyYwdawG
 9E7LiuejYeFglCbnvPVZars+KvS8A7gVDWz4yEWEqyJxKPkGilsHXWnaF67lMTNZR8PjYhtz+BO
 pFzGO
X-Gm-Gg: ASbGncvqcjl+1WLoooFBEmHBnSc0N3MJvgqaG1PS2NaQKfO4Ooch99zL5qOxBmr7xPE
 Cy586HT83EQZAMaUocu1xLAjdg34TrYkqVKerZOwOqGgOWjxEHMyocDL/loeaiMYsUMeK4GEofQ
 fawG83AV0PWazmad+aPCPkvaPepzHDTm0nN3DDN5dHYgLGzj6C7vvwLtYHZyie5zc7HpuIBh+tg
 Ry4HJwITCAk8lq/3x/JDMPyY6ZtBr2VQsvBpWJtzbSRC65QwMCGMD8HFAlMQ2sut/Vf9B+RIiOJ
 Aa9AFV1qOUgBMAhUnhy0Qq1d10cM2hM1yVO6mMUCpnLWY0GckQxVwd9KzTq7yfwArIyRGzhJOCJ
 IQWdY6ONpX2ACUojxRtsDlE5Q1s3hVqR4Y+VsXfGA8FbNSG9CSYsXfqIrL3hF0Rnf4q4jniSU9j
 xK
X-Google-Smtp-Source: AGHT+IEmNnTSeDRGyBgZ8nzzJWc7uU76DgAU1NSkvej99Qvkyh42uKe3L/BPeh4NEacw0iJUSzfJ0Q==
X-Received: by 2002:a05:600c:1d06:b0:456:18f3:b951 with SMTP id
 5b1f17b1804b1-45a10bb735fmr22234505e9.15.1754979310973; 
 Mon, 11 Aug 2025 23:15:10 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459e5852e28sm277918505e9.9.2025.08.11.23.15.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Aug 2025 23:15:10 -0700 (PDT)
Message-ID: <68275a88-edbc-4e54-9a8f-0d99d1234ed0@linaro.org>
Date: Tue, 12 Aug 2025 08:15:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 34/85] target/arm: Remove unused env argument from
 regime_el
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250802232953.413294-1-richard.henderson@linaro.org>
 <20250802232953.413294-35-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250802232953.413294-35-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 3/8/25 01:29, Richard Henderson wrote:
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/internals.h      |  8 ++++----
>   target/arm/helper.c         |  2 +-
>   target/arm/ptw.c            | 34 +++++++++++++++++-----------------
>   target/arm/tcg/mte_helper.c |  2 +-
>   4 files changed, 23 insertions(+), 23 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


