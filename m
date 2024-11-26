Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4ABBD65552
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 20:00:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tG1jH-0001oI-W9; Tue, 26 Nov 2024 15:00:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tG1jF-0001nU-Qf
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 15:00:09 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tG1jE-0007A5-B6
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 15:00:09 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-21288402a26so56450745ad.0
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2024 12:00:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732651207; x=1733256007; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4Ksw63r4iCPlDE6UFYl+L9tRoO+At7zJBQEwyqe4G1U=;
 b=mz0X0oNv/KOiRVd6VTky2wlgmpMguk6cAgp2ouTB2YGkHvARG+fwVlxKCwvxc+2fOF
 uy8F5WI9K00Y3UV7yl572L2S4eCSveRAMO2ZUkofJskHU/U/IExlxnb3P9hClBm/TyTW
 lQRDISJj7iUPWSEHb7xcM6fJpbTtxtNruBlb+ocfCquXni5wPr9CQy71MFnD+ghpk5SR
 s1PFujsroLCo3r5+ufO16P16GhxKMIevGql6+7atXF9r3fWPeXwIgShhQZBBuzwCwe5b
 KZl2PoCRlelIS42zcQsMdyfjprr7MWemjUp/wMicXI0vS3glFn0EewpFG/7xVor5v5YW
 +ckw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732651207; x=1733256007;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4Ksw63r4iCPlDE6UFYl+L9tRoO+At7zJBQEwyqe4G1U=;
 b=YUFDrbVS+zLLvdb+cA4RWPwHqxVFuvX/johF9WkLWevz16VSHc9zX+sVIxk7f+h/6f
 sJ4CVzVugyXyhU1z2YNMkT2CWubEGwbLiSaGFlJVL30KX4LRP/L6ULD/j5h19Jbm7yxM
 ntgKNPb/IXUw2+gd6REDdwz71GAef52+0A5bJ6xC9XqWYcdmfub517u30Iuxmw1Wz69B
 7IdwxaKWPbCzSK5qBUr1/4/p9cja1YpHRyoV8G7oeMzccTEk+ckY5OtTd5qPWx4d7zoO
 O+buEcwRIgLO7PFfhAKSFpofiLoJWbwySF10WHM9GpaZ0Ysp0aJtMaV/7xqCqsBPb2C4
 2xbA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBN71Oxhd4ptdRR9eb7m8kViUEUaFlx2YCPfZQWbCeirAEdN+iiIIEM9xTWWiy2s3EC6jFwfBTQGfp@nongnu.org
X-Gm-Message-State: AOJu0YzewAFhzsACvtyHjVth9ZjTDVvsiRtsRQTdG/F1ZWAz4eh6PruU
 77/UOBQO8+jL+7oCxZu/HX8uZerlNH5aC25/FJSzKN14Y0joTr68EBxg/V5dhcduhOc7cvMFrXJ
 3TRg=
X-Gm-Gg: ASbGnctGDaA2yBJAKKcuqVbAUCm1ZR+z+NTUHWq6U2hjVEB3DTasI2sy5zEYCZ5ap2n
 1JpmWxYweUwub0U43LrflkLl6HmKLgE1DJdZgwboHdHj9mXFhZu52Y+T0wSGA6ZhNwK/how0DMm
 mhY54RCL5yGMO8xqQ0I1OhhXg4lMv3gZPw/mTyo5qv2vAVZ8QyN6syqGUGrFbYIccIeTjhrWylb
 sXKhFvYJgxPHyihrkHFbjmzUC1konPGhLmxQd+DSQ+CZNqVijnoNWFSf4i5/NKjSSN1V2fNiit0
 fDaxoTEqV4BNXKs6A7jC8Q==
X-Google-Smtp-Source: AGHT+IGo5NiB/B6FdtsW7sET4H4lhIfaD4+8M+rNsXriUYNCLQhSbQ+axeoeBMgtdqsVxnuj25Ot4Q==
X-Received: by 2002:a17:902:e88b:b0:212:55cc:6ba7 with SMTP id
 d9443c01a7336-21501095f82mr4849985ad.4.1732651206597; 
 Tue, 26 Nov 2024 12:00:06 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2129dc06adcsm88971205ad.166.2024.11.26.12.00.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Nov 2024 12:00:05 -0800 (PST)
Message-ID: <8765c0f7-5534-46a4-8a02-8d1fd7dc77a8@linaro.org>
Date: Tue, 26 Nov 2024 12:00:04 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/functional/aarch64_virt: add test for FEAT_RME
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241125065950.1179068-1-pierrick.bouvier@linaro.org>
 <3b3e2723-9489-482a-b08d-09915f04fb0d@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
In-Reply-To: <3b3e2723-9489-482a-b08d-09915f04fb0d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62c.google.com
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

On 11/25/24 06:14, Richard Henderson wrote:
> On 11/25/24 00:59, Pierrick Bouvier wrote:
>> +        self.vm.launch()
>> +        self.wait_for_console_pattern('Welcome to Buildroot')
>> +        time.sleep(0.1)
>> +        exec_command(self, 'root')
>> +        time.sleep(0.1)
> 
> There are patches on list or just merged to allow matching login/ps1 prompts instead of
> sleeping.
> 
> 
> r~
> 

Indeed, exec_command_and_wait_for_pattern function seems a better 
choice. I'll use it.

