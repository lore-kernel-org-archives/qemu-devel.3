Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8BB8C54E41
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 13:33:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhUvX-0006wx-Lx; Tue, 05 Mar 2024 08:33:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rhUvV-0006w1-Ku
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 08:33:49 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rhUvU-000291-22
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 08:33:49 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-33e4f15710aso133096f8f.2
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 05:33:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709645626; x=1710250426; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=E7EFSTMqzvSmKUux6ZLtev4fgkNsE4tcqaaPrp/KLuo=;
 b=Hhwd9ZTMnCSU/VhZDL61+9xsgnjFBjb26Jv/K09V7MB3PzZf+9zClFnPNbki0/L52x
 NI4X3WfflBrl2IH3Jk5owhff5ky0DslEkgvaOPHIUGpmiP4T9O7yEjvDQWd9IqsErMXK
 9fvPL5Ux+DUCWHL+E8rakQlNGCMoCq66gL6kgg+nS0kY/1GmFjX1zPoTYknH8TMFzlkN
 A38U6DYWWbISi9YmEItuZSJREE6vrx8BpyC9qHKWs95DFjCwYkK5+QuNcw5tg/7U0vtK
 9GgeVGlOW5l8li+897iJrBBRq11kigk6fkAxhJcO7nnAhXGSmXeJibtOkXPNwXb86FZt
 ntaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709645626; x=1710250426;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=E7EFSTMqzvSmKUux6ZLtev4fgkNsE4tcqaaPrp/KLuo=;
 b=FrHE4IRTG0U2apJe3jUH+bW3yVMvvLBacCRsHpOSbtq4jrATfBHQjHqW7yHfzobaGO
 Uya8zlrmavU+l1/1/On6Imoc7wm9sPQenIfGjizwRUfDBlOtPFQov+bmMTtTKEWvQTu/
 VE9eGnlI9YOj+0SvZHAtRtpOtO4XQezXeEtO5Qk1Rz1HsRDrv+kicaFdBHxW8I6gatUV
 kYR1xNVe7j7JK87CXvh1Dq735T1qdKCXhavzTHEqZPo715wG0F32PPULAFcUBMnVakEI
 3672uDPumc5H3sRG3WOccxkgdVd2PAHmwEXeia7iYoWXY3+hOysmS6Ijxs2Okz4B9u8o
 sXIg==
X-Gm-Message-State: AOJu0YyN5kYzVe882k4AWldw1DyIrVvKwxtk9RCw7FH+32tg5IJwCSgJ
 gPIsCX9ifRZURkjURi/udtU1FMPL++KXf3Vn1kyYdHLbsKPO37RIPi8of1LMdMM=
X-Google-Smtp-Source: AGHT+IEj8RDpg5hjU9nOuxT5/9Wu2yhj0IqLj8sTBJisdvrFFwMctuC5Rihenjsp0ZPX6IfMD3wOFg==
X-Received: by 2002:a5d:5a98:0:b0:33e:4d6a:ea25 with SMTP id
 bp24-20020a5d5a98000000b0033e4d6aea25mr1616487wrb.32.1709645626293; 
 Tue, 05 Mar 2024 05:33:46 -0800 (PST)
Received: from [192.168.69.100] ([176.176.177.70])
 by smtp.gmail.com with ESMTPSA id
 p6-20020adf9d86000000b0033e0dd83be1sm15013846wre.91.2024.03.05.05.33.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Mar 2024 05:33:45 -0800 (PST)
Message-ID: <2a48f0b6-98a2-4ea0-bf26-660da8662a14@linaro.org>
Date: Tue, 5 Mar 2024 14:33:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/rtc/sun4v-rtc: Relicense to GPLv2-or-later
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Artyom Tarasenko <atar4qemu@gmail.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Eduardo Habkost
 <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
References: <20240223161300.938542-1-peter.maydell@linaro.org>
 <ZecIzqmNouZZBrbv@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <ZecIzqmNouZZBrbv@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 5/3/24 12:58, Daniel P. Berrangé wrote:
> On Fri, Feb 23, 2024 at 04:13:00PM +0000, Peter Maydell wrote:
>> The sun4v RTC device model added under commit a0e893039cf2ce0 in 2016
>> was unfortunately added with a license of GPL-v3-or-later, which is
>> not compatible with other QEMU code which has a GPL-v2-only license.
>>
>> Relicense the code in the .c and the .h file to GPL-v2-or-later,
>> to make it compatible with the rest of QEMU.
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>> Before we can commit this to either head-of-git or any stable branch,
>> we need a Signed-off-by: from everybody who's touched this file (or,
>> for corporate contributions, from somebody from the relevant company
>> who can confirm that the company is OK with the licensing, which is
>> RedHat and Linaro in this case).
>>
>> The full list of people who've made changes to the file is:
>>   Artyom Tarasenko <atar4qemu@gmail.com>
>>   Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> NB mailmap translations - the commit was philmd@redhat.com originally

Oh I missed that...

>>   Markus Armbruster <armbru@redhat.com>
>>   Eduardo Habkost <ehabkost@redhat.com>
> 
> On behalf of Red Hat, I can confirm that any contributions to
> this file where Red Hat would hold copyright are acceptable
> to relicense to GPL-v2-or-later.
> 
>    Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>

Thank you!

Phil.

