Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CDBDC369AB
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Apr 2025 17:43:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5pjb-0005rB-T5; Fri, 18 Apr 2025 13:42:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u5pjS-0005pa-6V
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 13:42:31 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u5pjQ-0001qq-Ec
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 13:42:29 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-af548cb1f83so2014745a12.3
 for <qemu-devel@nongnu.org>; Fri, 18 Apr 2025 10:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744998145; x=1745602945; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=54GVeFf+1YhOup6gVBZLiAxlghlprRIZsMI9ENYu9y4=;
 b=WbHv7HmXeJDaZ+xkZ4sJL7r04Bz3oiAQU8RkQEJuzNuNEP72JSZG0bjUmO4AOPvCYs
 PYlaZtVtG2Z97ifNdbCLhjSxM2V2CvFhoKEXYu2H48rTR55TbJKg7iuCe/PpeXxPoCaM
 LvNJ0ZxlfYWRqhfio51ZO+m88wf5LFgiywuu9JVsTX/bEPTMWPpfYn38qa93A065M5gA
 Hx+cOvRaChERTZpT/eWC9cRBRvBfCtbHE22RJQK8du2zzBrg6x53Jj+uTVBxbCdWR24k
 1gmu/kApyjvLU1sMIqMapNIxKT9WxsXYWvtIeYhsS8EM7MRqPdQYTiiyosEXNdNiB1Zy
 O0ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744998145; x=1745602945;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=54GVeFf+1YhOup6gVBZLiAxlghlprRIZsMI9ENYu9y4=;
 b=VJ8Pyksby7LgocULZzIrM8bSr8L0uWuG9GyXfMfrguP1WBBBHujRr8FXVneam2TZK0
 /bB6VIIdTDpdl6FKSemVp0KC9OGox8ptM7R7/wRL6/hoo7ibZkuNjtbIE2EopObDnjZ2
 lo3bg/5xmNhDxYbqJsWZtZOoBHga5UyRN+0jFeaJTGN3znNfnEPtHmD7fWlZdoWLbbj3
 LojhndCQ+X26C+lraVbQ9jion5jlEen+gQ+S7W1sWtYM/ZurdcBELo7ma3wrIuXEqcYF
 Wp3SZcW9pW8UI9XLbwb0QNPs2mJJL/zOxz40BzLzEEzEGHjXtI5WqqPTszhLO9j0tP0T
 2SEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWudWSI0BqXDFXspVRvQN+/izZ87gQSChnDbICdQC2Z2fCZ9aFX0AAw0fELFzNifCO1ofzc+UeSLty@nongnu.org
X-Gm-Message-State: AOJu0YzZBElegTw6EjSUugkgIrqRRm1SoHny+o0P9m6LAmlDQVgwkDEa
 1buG2lz38J9mFaM121jS/QlqJeooHIqwVTB8Du4jhl6LFDFYcJknWNNc2LYoRqA=
X-Gm-Gg: ASbGncshAu2ULkm4xtF85sjk+KDVMgHaT4vDhJ7FLKRqF5rNN5UhYeZdS3dqUMFEozi
 fb1r7IljcgdA3VBhO25pyEYLtb6AWDZKzzncfO6m40vwTYbFUUWWoYlYmju7XWjRdCV5iSk1cFY
 h9B3BA8zKsvKjDy/n/P3NkQyxOnzHsL7NVvn9FewX9kNSpHJb2eKuL9xiHdGrYTKCr6wdtiu3Cy
 tq7xs8FLBTUtCuuuO8+CG16zr6LPay3wZF/4CDUfNFpa5dkx3U6JvLCIHyohxroqWITsg/02ld6
 qut/bNWZuiMw+RjXOy0Bi5wM4FTBVS552Dugdq7KyPvE1x2nRMzUiFHIaAN2eQmKEKHarHJSNXy
 fgaX9+18=
X-Google-Smtp-Source: AGHT+IE1zSu1h7LuEPQeCDZVVEkqDQ8xD6OZpf//zRiOjiXzw6hqAU3EVu+UH+60qqWD277F41tWGQ==
X-Received: by 2002:a05:6a20:4392:b0:1f5:769a:a4c3 with SMTP id
 adf61e73a8af0-203cbd0aed4mr5431584637.27.1744998144976; 
 Fri, 18 Apr 2025 10:42:24 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b0db13cb3b5sm1635901a12.38.2025.04.18.10.42.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Apr 2025 10:42:24 -0700 (PDT)
Message-ID: <cf2c9dda-f0b9-4b41-a650-bb3d401ad5ec@linaro.org>
Date: Fri, 18 Apr 2025 10:42:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] cpus: Replace CPU_RESOLVING_TYPE -> target_cpu_type()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Yanan Wang <wangyanan55@huawei.com>, 
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>
References: <20250417165430.58213-1-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250417165430.58213-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x530.google.com
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

On 4/17/25 09:54, Philippe Mathieu-Daudé wrote:
> Philippe Mathieu-Daudé (7):
>    qemu: Introduce target_cpu_type()
>    cpus: Replace CPU_RESOLVING_TYPE -> target_cpu_type()
>    cpus: Move target-agnostic methods out of cpu-target.c
>    accel: Implement accel_init_ops_interfaces() for both system/user mode
>    accel: Include missing 'qemu/accel.h' header in accel-internal.h
>    accel: Make AccelCPUClass structure target-agnostic
>    accel: Move target-agnostic code from accel-target.c -> accel-common.c

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

