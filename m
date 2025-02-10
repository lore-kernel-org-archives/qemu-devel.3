Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4449BC02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 21:39:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thbUF-0007YL-JI; Mon, 10 Feb 2025 16:38:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1thbUD-0007Y4-NL
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 16:38:37 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1thbUC-0003qW-6J
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 16:38:37 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-21f48ebaadfso80101885ad.2
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 13:38:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739223514; x=1739828314; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FwcIAyQOSDuYdLPU29tlT6XQIdmIwxpG3uIobg/t6tE=;
 b=xdGDCOl25cZINb+aGGPOgNZF+hTUtm8DZdH7mpUfCYlYcAP0+bwT77cLJIzdmZC+xl
 I6/AdOXHSkIrvFKBGYWbvsjxbwkwAIEf6jv/k5ghQUC0In5WYNAxvXOsCJ8yLDF9kePf
 hiqQV5vUv1dHcusd8R7zuQuiClLv0vj81DaWVtgUFb9HDgQW11ylIpE6qIKgGrnXbB3R
 S7zkUY1ekbsdSoPH/7g0esUbS8m4EVjVLinLMeJmB9ChtYBCpRMXATHQeRJKat45jyNh
 UOM9CY9j3pp9t3EgtmgZZOtk3Z4NKONw8/1Q3fyfX4kfrFaXVFQRhiHYahTKZqaqvwNm
 0tNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739223514; x=1739828314;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FwcIAyQOSDuYdLPU29tlT6XQIdmIwxpG3uIobg/t6tE=;
 b=VqLrvIMXVU3wEhM6iVD0S+su6fJQ/JywK+QoYrDNuNCqoHwXzgBHNciQ+uCDElsf/u
 UGBrtzy4bJkPfX2skdZIAHzzrQ/aDFynQgLyE8FsBGdtqE2yucMWM1F2CrlWlzDa7JCP
 HOwC1dTlV6Tk/UXmnJON+6HHgCURJ9eHqTrjrOpdnAP3h/KCAFNOShZ2TS7DrOrrpPMV
 Um+f4PY4pUQ3IuxplHBPTmTV7RulqN2aQWF67s2cLzgvKccULSHdlOAeFSBC5Q/cuBhA
 yci6rj0K05sRYhc7R5wY45o23OFWvsd8G4fH4IQq6fLzFv9eowr+IPORWRSB3DZCN4YB
 CD2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6F5xVIOg/3LBj9axA+KJRFQnvcyj9rLxxVuE6g9HqzzX6HK9rOtlRHZHHuiawX0mUDZpUsYcfHilB@nongnu.org
X-Gm-Message-State: AOJu0Yy9+D4BETIo68vz8cyun1YkO5LfN7sMVNi+kV24zmrkQGxxBqMH
 GF/EzQXa/17UZhxJIpgeVE6PEv8uK8S3ge8a60rHiFZDcj0bejbGI9ALt3hzGBk=
X-Gm-Gg: ASbGncvyufl1vTb2Gw5doFFPl8fsoHg/UpHkzlMzIYQSqHn1309hphNnAobantWvojl
 3CPKIdNlMfFPmkjJNicx3LmJewTmbbO8vTsC4lde2EmFTBC6/Jivi6hGwORR+bKmxcmSe7t0ZQS
 mxWtIV/7jQ+3gnO0dGwrwgyP18sUmsTjgdopAyJ7y8aMRXSQq4k5NOZ6vrpKxBBTp9hmb21DKEH
 M1hw4Ze+RYeyjkt25KdNul2qObO2MlGS9R+ZKbIrcWlRuLFG6VfU27gTeeqfUcMuJhkBSuL/1cc
 RkLQFem/F34uRhRosnJHBSIrFPOi+dN40HlbaxLjSlCk9kr/1+8tst8=
X-Google-Smtp-Source: AGHT+IFtwrIl9M8XBdjUDoxo6RHzqzDz+/sl2grxbthax7CrOR09XU2r2dShiM4FT03z2dfa96sy7w==
X-Received: by 2002:a17:903:2f87:b0:21f:6d66:9f24 with SMTP id
 d9443c01a7336-21f6d66a3bcmr173225645ad.14.1739223514535; 
 Mon, 10 Feb 2025 13:38:34 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21f36560ee5sm83488345ad.96.2025.02.10.13.38.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Feb 2025 13:38:34 -0800 (PST)
Message-ID: <9dc194b7-fdab-4583-9eb1-fb81a4fab704@linaro.org>
Date: Mon, 10 Feb 2025 13:38:32 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 24/24] cpus: Remove CPUClass::has_work() handler
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20250125170125.32855-1-philmd@linaro.org>
 <20250125170125.32855-25-philmd@linaro.org>
 <cbd78ef0-c06e-4a6a-8c17-1072fc58c777@linaro.org>
 <8da57d8a-a42a-446e-ad5b-a6ab07c65647@linaro.org>
 <256e36c4-d0d7-4d2b-96a1-888e516f917a@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <256e36c4-d0d7-4d2b-96a1-888e516f917a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

On 2/10/25 13:36, Philippe Mathieu-Daudé wrote:
> I'll amend to the description:
> 
> ---
> Note, since cpu-common.c is in meson's common_ss[] source set, we
> must define cpu_exec_class_post_init() in cpu-target.c (which is
> in the specific_ss[] source set) to have CONFIG_USER_ONLY defined.
> ---

Excellent, thanks.


r~

