Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0770C83F03
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 02:47:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWnTz-0006wU-Lh; Tue, 01 Jul 2025 22:45:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWnTy-0006vn-0K
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 22:45:58 -0400
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWnTs-0006kA-M9
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 22:45:57 -0400
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-73afbe1497bso2262544a34.1
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 19:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751424351; x=1752029151; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yOUz08V11kaL3DgWpOFup6WqYbjWhFe8LbqotQ3b9nQ=;
 b=Bx90QFFY6MwGgP8BdyIqDMmuqBakYMr5B/ygc3YE9xiisDzURNMRZMxBXGKSuIi+wd
 MD4j0yj8Tjc6XQ6k7pGZr20m89m5HsWrLqoPgEuctBS1+Bq5qmwP7JbUeqxNmFmJIOUQ
 4n8lZ88cOEk87T7RqzhWXFjmkugmdVpqoYUFGxMp+l2Qj04euaDmo4GZ/9VbKPysX7mX
 W2HNj9kW0j5yjzPZqb6Ow0b0houbd7jddbGlZyUUhEW4hxVVVTpbeWHc23ISJaetmjcy
 zsbEw1/cINjgr3opCflzU4x4ZidEH6QTaYup4CQKp6GJKDRYuGcK5DqZFBuHEfFh6GoP
 tEbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751424351; x=1752029151;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yOUz08V11kaL3DgWpOFup6WqYbjWhFe8LbqotQ3b9nQ=;
 b=MdmL29lE40OVHifHgKkc+OScxuBhszS4RgebFv3Unxrx3EeSrXlZIXZfiarOA4aaQq
 gdCWH7ZGbAdaYtZ7+xJx4RDv2nNSnOKZpsYS66CI9FPRxvhSrWAZaSZWBqs5Z8L5u+yz
 IPqK1gtAPX/ArBp/UsmyfhQdaHxc/kssvt5p5hHVZ11Z6U4ShheB+PD3J/AoFnE9EaUF
 qKabVZk1m9IA9eEp+EeUN38Rw8K2eQKPYpXrReZHExyPYvjZVjIwKzDbcwqT170w3DWS
 2XajwIcfd5VX9UAqKvSCn3RHc+/ZePoMCFeofXfzuchpc9IZV6FqJVV8V0jAAtKRPvab
 wB8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUxDu1S0YNLr+SZxMZw94l8P4uTmAIp3nqYPqYWuo1yD4VppwhWvHSCp3fAZieOl3yg29WTdT6xDZnn@nongnu.org
X-Gm-Message-State: AOJu0Yy8Tmasy3DjODLZ6jSjuN6rTUNiZiI46ryjWgr7yLMuy7dZRBKO
 Tf/WlO4Mk3pqEhOgYtiXDy5Ld2o9ic/iLLqdG4KZihkiYx6TPAxS/ZOhziIbnm/GG7U=
X-Gm-Gg: ASbGncspnX9Ail71F772ABUzLuRFZMSBlkn/fjZCciAaSyK2t7SPeT7XWkzNo9mfMEk
 BEP5RDPSZeUmmh6j+LJiLJDhhWDaLY+110ZUfzZtGCIMSN+2TVSj3PmWzyqgOIGSDjxOyq1A2rO
 LhpvKFC2nV1h4kE49xZo5HpepTVUBBDv3oT1FMiFmpfIYjrsusZiBwzs8h8XQaZPHAU/UZNBrYa
 EjZgzzpR2iSFPtOSoHGibgfV3/hufrCAmEmV/cfhDgSNlhJrps0kdN58j+CPn5WV1biMGOS94XU
 4WWA/DAnJgDULm+xfC+1gRAYpxrG7dD5V0lwQdOkJiTeUHaJZlqnjeuSDu+f6KFtXitJoB6Xu0Z
 DrSNYcrWDEmVu
X-Google-Smtp-Source: AGHT+IG286AHdejNutHKCEWddz4hywa7DRgfmUa/eA3MMfunHpldwBuKTMF6OBQATpd1unmBcclwIQ==
X-Received: by 2002:a05:6830:61c7:b0:73a:9158:fb7e with SMTP id
 46e09a7af769-73b4d264eb5mr971656a34.25.1751424350680; 
 Tue, 01 Jul 2025 19:45:50 -0700 (PDT)
Received: from [10.25.7.201] ([187.210.107.185])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73afafee647sm2346532a34.4.2025.07.01.19.45.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Jul 2025 19:45:50 -0700 (PDT)
Message-ID: <5cad28ff-c825-40cd-b425-15643ca05dc7@linaro.org>
Date: Tue, 1 Jul 2025 20:45:47 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 13/68] accel: Directly pass AccelState argument to
 AccelClass::has_memory()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>
References: <20250701144017.43487-1-philmd@linaro.org>
 <20250701144017.43487-14-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250701144017.43487-14-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::329;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x329.google.com
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

On 7/1/25 08:39, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/qemu/accel.h | 2 +-
>   accel/kvm/kvm-all.c  | 4 ++--
>   system/memory.c      | 2 +-
>   3 files changed, 4 insertions(+), 4 deletions(-)
> 

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

