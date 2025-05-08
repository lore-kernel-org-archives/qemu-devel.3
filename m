Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 497AFC3ABBE
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 20:33:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uD7vm-0004T6-92; Thu, 08 May 2025 16:33:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uD7vl-0004Sn-2d
 for qemu-devel@nongnu.org; Thu, 08 May 2025 16:33:21 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uD7vj-0006pm-ED
 for qemu-devel@nongnu.org; Thu, 08 May 2025 16:33:20 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-736ad42dfd6so1217586b3a.3
 for <qemu-devel@nongnu.org>; Thu, 08 May 2025 13:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746736398; x=1747341198; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NCueMDDjXEfE1wVpJdpkz3Q7vMMKFXFelZsxCzsBDGU=;
 b=CH1yQY2XmdM3hp6iBPXOV7GGvrXUD1mE+3ccvnugafS0BZUO20JZQAvMGTFPwxlRAc
 V+XHjS0EiK1xbRljmXuwbapChAt4amtQgN6Odg2TdeYuDdG2LtbpxY6249WIyPPrSJ9/
 y+0kAVePFGwSxmwrBWobnBgupcHv8E05eAYg33+KN2xBPl3E4pv8Ec66i1qc9158LAz4
 MCo4l0/SEuVCcefAKke5G+yc+GfR+OqE29weJMO8hO/4C2f97j+FuJljkqGa/rEL74Xf
 BHtxDuEBy0h7rgwl0lkKaDz4Mqgbw9fakmRmia3RlZpErlU3HW/lERB6VDxrjqfpS0kg
 QCwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746736398; x=1747341198;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NCueMDDjXEfE1wVpJdpkz3Q7vMMKFXFelZsxCzsBDGU=;
 b=GANkV8246pMXUTyT0gqqiR2aeQuNC5Pk4Zt/h2rkO0k/WYpObuk1qxGL3/in2jmvkx
 NqeFoEY98B1TG7hFLj4KmWiPp8ZbfeZAhIJ08hdcLu+eX6AAAR795AD/SF1G8bfyFLAD
 kPq6lWGcRzer0P5bPK1pV+oKN+oBgrcJlkOq1uf2VldZ4XPS43RgCpV2HTa29sg8wY9U
 sGX1fdAYy03RwJwRl4kAduUs0JvWbachuzq1WErFBC87Blhf6Rctf80cnOhurDDcE9xI
 FfzgSz2CIiMG3l62e8/JPibcVWoMgniWDOUQG3GLPZnsKA6dnDpb0CRUzdSdom+To8S7
 iPnw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXoK0KVFuDQu76Q+JRJgFCEpP2tSArmm4ucfuriDI2PuDkjsxT+j0QYjHrwxrEnPVMn3jre1sj55mGm@nongnu.org
X-Gm-Message-State: AOJu0Yyy5/Mu3w+sTrt1Qx4Zd6+7v5reM3SutzHkNLECTmrycCunvOkA
 bDk+0pp3PUyIVI7VqldW3lYEb1Laaqqz9TbeBUQt5IgU/Kn76e2P+/8+gFGTmHg=
X-Gm-Gg: ASbGncvJ2wsgtC6Fc7w4LwF4u5e+z0JHHZBa1OfbOCzcD/R0OoUNTFnPbP7g3M0QlA0
 nkdGFF+589aimtU9PndzF3t9gNl1JtG71kcgwy1G0VRxjWYlDQKe3pO0bGtxCqyKnRI1cnVB9Xc
 CcjhjR2dJ3XL6YRysGyF8pEe/Wxn+VMebdrqPzl5ndjEGFwEna3WCssmPnpg1uDt34pwv4vpKpW
 9hlnAEqrsKWMFO5M6qb1omb+PZdjVqA/TLZujQnrt3An5TtnD6aCvPfhwaCOJ2syDPGPNRnSV5t
 3TtkiKlXDbNk899udc+kA5fmg3MBBRBkNPfApN3+9sWX/S60Wwe+Xw==
X-Google-Smtp-Source: AGHT+IFRKqjZQueN/FXf+JcNZ7cwbsSiQkVaTvGeI9MwJsiLP9K6gF1MpuBt74qsgBMqVtOcYE2b5Q==
X-Received: by 2002:a05:6a00:148b:b0:736:a540:c9ad with SMTP id
 d2e1a72fcca58-7423c073074mr910719b3a.20.1746736397995; 
 Thu, 08 May 2025 13:33:17 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74237703f97sm463105b3a.8.2025.05.08.13.33.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 May 2025 13:33:17 -0700 (PDT)
Message-ID: <8993e11b-d9c4-42a7-b24e-6626900b836d@linaro.org>
Date: Thu, 8 May 2025 13:33:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/13] qapi: add weak stubs for target specific commands
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, stefanha@redhat.com, peter.maydell@linaro.org,
 Markus Armbruster <armbru@redhat.com>, richard.henderson@linaro.org,
 pbonzini@redhat.com, jsnow@redhat.com, berrange@redhat.com,
 thuth@redhat.com, Michael Roth <michael.roth@amd.com>
References: <20250507231442.879619-1-pierrick.bouvier@linaro.org>
 <20250507231442.879619-11-pierrick.bouvier@linaro.org>
 <30076d35-3452-4061-8fc6-d3eb9810d0b8@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <30076d35-3452-4061-8fc6-d3eb9810d0b8@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x432.google.com
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

On 5/7/25 11:57 PM, Philippe Mathieu-Daudé wrote:
> On 8/5/25 01:14, Pierrick Bouvier wrote:
>> We are about to expose various target specific commands for all targets,
>> so we need to stub not implemented qmp_* functions.
>>
>> MinGW does not support weak symbols without at least one strong
>> definition, so we'll have to detail stubs per target. Sad.
>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>    qapi/commands-weak-stubs.c | 38 ++++++++++++++++++++++++++++++++++++++
>>    qapi/meson.build           |  2 ++
>>    2 files changed, 40 insertions(+)
>>    create mode 100644 qapi/commands-weak-stubs.c
>>
>> diff --git a/qapi/commands-weak-stubs.c b/qapi/commands-weak-stubs.c
>> new file mode 100644
>> index 00000000000..9734263c32e
>> --- /dev/null
>> +++ b/qapi/commands-weak-stubs.c
>> @@ -0,0 +1,38 @@
>> +/*
>> + * Weak symbols for target specific commands
>> + *
>> + * Copyright Linaro, 2025
>> + *
>> + * This work is licensed under the terms of the GNU LGPL, version 2.1 or later.
>> + * See the COPYING.LIB file in the top-level directory.
>> + *
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include <glib.h>
>> +
>> +#define NOT_REACHABLE(symbol)                                                  \
>> +void __attribute__((weak)) symbol(void);                                       \
>> +void __attribute__((weak)) symbol(void) { g_assert_not_reached(); }
>> +
>> +#define WEAK_STUB(command)                                                     \
>> +NOT_REACHABLE(qmp_marshal_##command)                                           \
>> +NOT_REACHABLE(qmp_##command)
>> +
>> +WEAK_STUB(query_cpu_model_comparison);
>> +WEAK_STUB(query_cpu_model_baseline);
>> +WEAK_STUB(set_cpu_topology);
>> +WEAK_STUB(query_s390x_cpu_polarization);
>> +WEAK_STUB(rtc_reset_reinjection);
>> +WEAK_STUB(query_sev);
>> +WEAK_STUB(query_sev_launch_measure);
>> +WEAK_STUB(query_sev_capabilities);
>> +WEAK_STUB(sev_inject_launch_secret);
>> +WEAK_STUB(query_sev_attestation_report);
>> +WEAK_STUB(query_sgx);
>> +WEAK_STUB(query_sgx_capabilities);
>> +WEAK_STUB(xen_event_list);
>> +WEAK_STUB(xen_event_inject);
>> +WEAK_STUB(query_cpu_model_expansion);
>> +WEAK_STUB(query_cpu_definitions);
>> +WEAK_STUB(query_gic_capabilities);
> 
> Shouldn't this also be generated by QAPI scripts?
> 

It's a bit tricky, because we would need to generate the build system 
also (which targets links what), and meson is a sane tool so it prevents 
users from doing that.

>> diff --git a/qapi/meson.build b/qapi/meson.build
>> index eadde4db307..60fc958ec10 100644
>> --- a/qapi/meson.build
>> +++ b/qapi/meson.build
>> @@ -147,3 +147,5 @@ foreach output : qapi_specific_outputs + qapi_nonmodule_outputs
>>      specific_ss.add(when: 'CONFIG_SYSTEM_ONLY', if_true: qapi_files[i])
>>      i = i + 1
>>    endforeach
>> +
>> +system_ss.add(files('commands-weak-stubs.c'))
> 


