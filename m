Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AD03C2D0CD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 16:02:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFb1C-0005gk-N7; Thu, 15 May 2025 12:01:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uFb18-0005cI-RY
 for qemu-devel@nongnu.org; Thu, 15 May 2025 12:01:06 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uFb14-00089E-81
 for qemu-devel@nongnu.org; Thu, 15 May 2025 12:01:06 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-74251cb4a05so1651100b3a.3
 for <qemu-devel@nongnu.org>; Thu, 15 May 2025 09:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747324859; x=1747929659; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cLm3qYpvrI0kV/DQ8TrnXD57aWGKyWY23QfFxV00H9k=;
 b=g0QKcSR5V2aMBpO/xanUfKfHmh6tOavVTNedHSJ7S6bGe4QUpST2lXruimn0wye8HM
 lzOGlRytRbz9zlnrOjPFc15CYezGKybxUe54X8B0LgtkZDHIgkeVtr2gCMMvN+RaePq1
 zhw5WBF2U7CgTb0ZwksnrlZE5CyEal8zLEmLCnemLhCqQwDaxBFQ+LM2Ie3zvfQJfnSF
 Aw4/GB6UEB9kaSxJ3iLJZFUSGiRnnpvJba/xAXsbxPjlnLrRIgMbs3lLKpa6vLhP9/dX
 8tMJPuadEnm1mx1T/ipX1eCDthyAdhvp2sTmnfRCISYnbAddKtM1NLiQxRZQi2pLmuxp
 hB/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747324859; x=1747929659;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cLm3qYpvrI0kV/DQ8TrnXD57aWGKyWY23QfFxV00H9k=;
 b=CVDJFPzG2n+FDpWo2EQRUjcv297+NuoZ4I95Vpy1WrvcYYhm7YNPx5jZmdZrPqiHum
 pqni8lfLL9JMS6eS+AIYKXlw2Jzo/MBko222bu6ZHhSBaxepLV2h/9jSfHnvmXY63u/n
 xgpxsjLNffDysC1xeRtOdFTYbFNccrKbZUymbcMIU8+YoCXO/0EjUa7BxZ4Bki3eQvIP
 AFI7zYkKRisExOKkdTHOYsjhGpuw22PtO1Ad+eZYulcSHIt0Vc4J4qLRKFdrsjRj/EO3
 +slbOR31gJkPFmenQNJ9n3SvkXX4yKdO3TE7drLcdD8ai6MoD0bPE9pN+4zotil4S35I
 /Xuw==
X-Gm-Message-State: AOJu0YyajhUToiZtdtkAHKHlPSBROOMP/v9rl08LcdPiHParpHkOjCMg
 +k+gIBb7M3S6AxUc9WDwHw/ywVeYaBbOrlc0gm+HmYfNqw21MI8EFgJvLqhVN34=
X-Gm-Gg: ASbGncsOqRw49SuL2vXRc9vdF2tZPTkTZNdaKtP6dQgnRcKW9WsN0D00ifFf/1V7h0+
 fyDvy7KSfswqr52UAj1z26WBftzgOiiC/sB3knI+fFpjX8rKKzTq/L721r3qGqqh+eTyB/87Vat
 8fOkN9CrZV/qlCadGHeL3HUK6KYgY0pQuNEqg/A831KiPRNxS6vPzq6Tc/4KE2VKdKcceh570jd
 MQEmRP/wlVJh8eaPbLtyuj19jyb2gAEzV2ufJO8pssy59mZqRHMXlZ8cUlF4nxDim2UvH+W73xU
 5haeuZnCfv9qNcBr0m8mEPdQrqAHlgT72YM3sw5sASsd3ZoBc8t1QX61/IBQVUba
X-Google-Smtp-Source: AGHT+IEU2t1FTWk5WKxpBF7TCxxSvm/oUX77m/2wK0GYSUSFPbxrMRHkBAwlwzXXCbVonAP+Uqk6CA==
X-Received: by 2002:a05:6a00:6f02:b0:742:a91d:b2f5 with SMTP id
 d2e1a72fcca58-742a91db382mr58825b3a.13.1747324859152; 
 Thu, 15 May 2025 09:00:59 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74237a8ef50sm11797726b3a.171.2025.05.15.09.00.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 May 2025 09:00:58 -0700 (PDT)
Message-ID: <b7dfa7b2-b35c-4f56-bf98-43468d90f488@linaro.org>
Date: Thu, 15 May 2025 09:00:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/12] qapi: expose rtc-reset-reinjection command
 unconditionally
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>,
 alex.bennee@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, peter.maydell@linaro.org,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20250514234108.3746675-1-pierrick.bouvier@linaro.org>
 <20250514234108.3746675-2-pierrick.bouvier@linaro.org>
 <aCWpn-ZzyygxT-2F@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <aCWpn-ZzyygxT-2F@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x429.google.com
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

On 5/15/25 1:45 AM, Daniel P. Berrangé wrote:
>> diff --git a/stubs/monitor-i386-rtc.c b/stubs/monitor-i386-rtc.c
>> new file mode 100644
>> index 00000000000..e78757b24f2
>> --- /dev/null
>> +++ b/stubs/monitor-i386-rtc.c
>> @@ -0,0 +1,14 @@
>> +/* SPDX-License-Identifier: GPL-2.0-or-later */
>> +
>> +#include "qemu/osdep.h"
>> +#include "qapi/error.h"
>> +#include "qapi/qapi-commands-misc-i386.h"
>> +
>> +void qmp_rtc_reset_reinjection(Error **errp)
>> +{
>> +    /*
>> +     * Use of this command is only applicable for x86 machines with an RTC,
>> +     * and on other machines will silently return without performing any
>> +     * action.
>> +     */
>> +}
> 
> Based on Markus' feedback, I think we need to report an error here
> rather than silently ignore the code.
>

Sorry, I missed that part.
I changed the patch and updated the commit message:

+void qmp_rtc_reset_reinjection(Error **errp)
+{
+    error_setg(errp,
+               "rtc-reset-injection is only available for x86 machines 
with RTC");
+}

Thanks,
Pierrick

