Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEE4BC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2024 09:06:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rypc8-00042H-DI; Mon, 22 Apr 2024 05:05:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rypc5-00040z-Ek
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 05:05:25 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rypc2-0005Mz-Jn
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 05:05:25 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-346406a5fb9so3290434f8f.1
 for <qemu-devel@nongnu.org>; Mon, 22 Apr 2024 02:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713776720; x=1714381520; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6bku35Pa23hx7jlKF3U6gFrNWhDJqMIVbU8YTHxAROc=;
 b=mYwPYEAWn6jwyErhGD9HGJqjenDlPOT7R/IWYnEoDnt5+92aITEAQNUvqWuOlPXVrt
 EOla1paW84Ujyja/bqoPDtj2CBi6t6dEei3AkUvT0ezvotUIonx3bhbqbnpBdrXLjpWy
 KfqWWS+svTUuagSVf7CwOfXpOxLrCe1qVmmitMkZeqQIcF1fQ6cBsvxldy/4d6XRMFVe
 FwnVP+7O507/olkioQD662e8WL251KWbkYnhH6TQd5Moq4ZMFCkiAJxoRiPfYcDeQfCH
 lNHXgIVPhsdBm0JMWtXbW2WaSOQoxQbBK18nBejxzvK9v14kFBCZREwSjkKcYN7KLFF8
 IVOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713776720; x=1714381520;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6bku35Pa23hx7jlKF3U6gFrNWhDJqMIVbU8YTHxAROc=;
 b=QkOh4EZXe7NBNuzQIugOz7oHT+YhbrpEHD1xFlEEmgYN0J0dUTRFEZGaqtP0NUmh+P
 2vDwwMM4YjtVRrtvz7gFueAjLBSAtrIyzL7xAbvUzw8S4EVM9R+cesIpwLKqW3DL/j+O
 d6gfka4E+zg2vfaypwydP1TBGD2X4mBOK6dA+xspLXUvrhAlJ1L5l8MKPlTlhvs6ynqH
 LAfCzmDvxQYT4zKMAisX6j0iNylltuTT+sWQ9KTjoJ26EsA6s5xhTVvFP/2D0FvvpaFV
 UII8N4YyjRbSIk3llubq/M+VRFkMXdnWjokJDVAgn45s/OH6q2tiIuuX6Hida7CFQBKF
 q1Hw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWyjQBHVcEi98qBty+NPxzUOZa03FdR4NJJ2fnFTc6ho58ng2Rv4XiqFwoztjamptSpd/yKqbsvKLRaVocDWHErJrRNb/4=
X-Gm-Message-State: AOJu0YwtcNMCEtJtfaa1WTMJjdRjKtqrAJdE/9qRizfJDkRPikQpd7fE
 OIIN5vxQqkGTvTdzffJ1QXNjAQxIhyRzWo2Tr30CVx7K2JhYdxOMb9a1cl1LnVM=
X-Google-Smtp-Source: AGHT+IH0bW441SeuH4pzB1JOInkylQKy7UFVU+26AbFUsLZxLebVBbEZ1E84FAsT/enoZ+PA/mOzjQ==
X-Received: by 2002:adf:f6ca:0:b0:346:72f4:c805 with SMTP id
 y10-20020adff6ca000000b0034672f4c805mr5044587wrp.66.1713776720049; 
 Mon, 22 Apr 2024 02:05:20 -0700 (PDT)
Received: from [192.168.1.28] (lfbn-bay-1-170-196.w83-193.abo.wanadoo.fr.
 [83.193.250.196]) by smtp.gmail.com with ESMTPSA id
 r30-20020adfb1de000000b00343e392829dsm11578896wra.97.2024.04.22.02.05.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Apr 2024 02:05:19 -0700 (PDT)
Message-ID: <50a43668-4a21-4f3e-a306-133dd1d54594@linaro.org>
Date: Mon, 22 Apr 2024 11:05:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/24] exec: Include missing 'qemu/log-for-trace.h' header
 in 'exec/log.h'
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 David Hildenbrand <david@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Anton Johansson <anjo@rev.ng>
References: <20240418192525.97451-1-philmd@linaro.org>
 <20240418192525.97451-18-philmd@linaro.org>
 <76d68cab-7b28-43bf-89a6-bb39a7fdb131@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <76d68cab-7b28-43bf-89a6-bb39a7fdb131@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

On 21/4/24 18:44, Richard Henderson wrote:
> On 4/18/24 12:25, Philippe Mathieu-Daudé wrote:
>> "exec/log.h" accesses the qemu_loglevel variable,
>> which is declared in "qemu/log-for-trace.h".
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   include/exec/log.h | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/include/exec/log.h b/include/exec/log.h
>> index 4a7375a45f..e0ff778a10 100644
>> --- a/include/exec/log.h
>> +++ b/include/exec/log.h
>> @@ -2,6 +2,7 @@
>>   #define QEMU_EXEC_LOG_H
>>   #include "qemu/log.h"
>> +#include "qemu/log-for-trace.h"
>>   #include "hw/core/cpu.h"
>>   #include "disas/disas.h"
> 
> I disagree: qemu/log.h is the main file; log-for-trace.h was split out 
> for other usage. That shouldn't mean that log-for-trace.h needs to be 
> spread around.

Good point, I haven't noticed we can just move the qemu_loglevel
declaration.


