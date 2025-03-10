Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3758C282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 17:54:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trhK3-00024j-02; Mon, 10 Mar 2025 13:53:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1trhJx-000240-0V
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 13:53:46 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1trhJu-00075Y-IQ
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 13:53:44 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-22423adf751so65057085ad.2
 for <qemu-devel@nongnu.org>; Mon, 10 Mar 2025 10:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741629221; x=1742234021; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SNdf7vCKO5Xmhce53+rIBW2Mul00fvnfIPGlQMOUVdU=;
 b=EJ90iYuUKfZOA9FkJ3caxnwTrFpq8ygWdDNONSdyhNw8hEvG5bQmBwEV99Kl1KAqpB
 edh0ww/uoAxe12jQgleB9cNzWA+wjnF0PE1lKed9dNdm1grz5XT6pvLgJyvzTZ4VTjkL
 7vThgrBe73fKO+a2K2EQGDtcqMEP4TyxR+NtFs3yQQnbeJKnP2wlYTuvfzxYu5kaUsl4
 keNmCi6imza9QLdlzn3fKWrZ+LfyJlUu7nO5RXkx3o0TIalCzlr8wbULf86K1AiE6Lrj
 JXQj+wagMMryjvf05KfdeGZqi8lhJ+zHn4hFEmB7r4cCPWr43M3GUaR5XqLAYuGYUbQj
 moyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741629221; x=1742234021;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SNdf7vCKO5Xmhce53+rIBW2Mul00fvnfIPGlQMOUVdU=;
 b=SIBltd6ajFBhMqQcxUEYKx6uIySymX0bfSU3iZiZIsTHQuze4NNgrJey+YYwbqdNrc
 rxGh/AnEB0dFvOvFRvEnpetwOzfNlPV15QZcFxSGeSXaMckii4AC6grH/xdwfJBB5Md3
 Ost/uDyTp3ttAZZevnQvxJXDWkLTjrpKOV1uMtZJKNyCi+WK7E6uMYLCIFfjRdhUE5HW
 /Z8P/eUK/XouhLAQv8cD6s5lxJ+NsxlmTLZHoqKTAGlNBT7rdlbCaJ4Vri0o8XHy66X0
 rxpMPzXnkEO1EWwXOQ8TjSMv66dPyPA6l29sbFouRJik832wsGOsA8y2dPWVe8cjumx1
 aOlg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXaFaqnA/gs5DJ9rApIEY9qplQnEfH+JTAETbN13kOfIljF3O2GJl8nh0XA55ObIAbxd3PRsiqiqoU5@nongnu.org
X-Gm-Message-State: AOJu0YxVzEhTmwmPpkcMNpE3PK3iwP4aRO11/zDiywy3vZzGztOfdwwB
 lYyk67i50y/tK4s55B+ub46T0QtfA1WuKMvQ/ZdpYjrMRuypzK9VStBmbGGtCCE=
X-Gm-Gg: ASbGncuP/SYguNmhfV/DZJvMH/3pgsm2mCCmHHd0qV/OlYBm+vP3O4CvW38T/kO5cbb
 YbAbluQSMecbzC0rQzKAuK6JfL5BXTXPuRGC3FMT/BrmoWSzcb1ylab1Evp6R/CzUGTzRG+hO2Z
 KhuqQu79Zl1SBHc6bXKbsRkq1RRcC0wlu+GW6m/hLshhhl5WbZQJtk+DOLBFf6PsxnMidk4fNC4
 6tIRy/AeLdVMd+F7+nYLuLEbPik/x1sgc0Nocj0m45vPchff/pdm+R87u0qJhsR74qMban7Fpea
 mhs0Sk206xat6JNw2l8xILfWyIwVyPo4XCIGE7eaPW6mY4NF3m9ZVgh3OXIxukclyM0b0hcvH0c
 4BQhubJoLe04EfFiy9VE=
X-Google-Smtp-Source: AGHT+IGCVgP9PziNftFebnihidqJpZEqMNj9oPIAQo/15NgC61c2mw9blKtVcunMOb4YHp6Z1tB/zA==
X-Received: by 2002:a17:902:ce0b:b0:223:5945:ffd5 with SMTP id
 d9443c01a7336-22593184cfcmr10225125ad.32.1741629220974; 
 Mon, 10 Mar 2025 10:53:40 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22410a7f722sm81464135ad.152.2025.03.10.10.53.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Mar 2025 10:53:40 -0700 (PDT)
Message-ID: <4d74d2f7-7ec9-40c3-a1ec-b9c54f88413c@linaro.org>
Date: Mon, 10 Mar 2025 10:53:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] trace/control-target: cleanup headers and make
 compilation unit common
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Mads Ynddal <mads@ynddal.dk>, alex.bennee@linaro.org,
 Stefan Hajnoczi <stefanha@redhat.com>, manos.pitsidianakis@linaro.org,
 philmd@linaro.org
References: <20250305050716.3460989-1-pierrick.bouvier@linaro.org>
 <0227dd71-5c01-4bde-acf1-8c5c39b46d1e@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <0227dd71-5c01-4bde-acf1-8c5c39b46d1e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

On 3/10/25 10:17, Pierrick Bouvier wrote:
> On 3/4/25 21:07, Pierrick Bouvier wrote:
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>   trace/control-target.c | 2 --
>>   trace/meson.build      | 4 +---
>>   2 files changed, 1 insertion(+), 5 deletions(-)
>>
>> diff --git a/trace/control-target.c b/trace/control-target.c
>> index d58e84f6dd8..57ceac21084 100644
>> --- a/trace/control-target.c
>> +++ b/trace/control-target.c
>> @@ -8,8 +8,6 @@
>>    */
>>   #include "qemu/osdep.h"
>> -#include "qemu/lockable.h"
>> -#include "cpu.h"
>>   #include "trace/control.h"
>> diff --git a/trace/meson.build b/trace/meson.build
>> index c3412dc0ba5..3df45493555 100644
>> --- a/trace/meson.build
>> +++ b/trace/meson.build
>> @@ -1,6 +1,4 @@
>> -system_ss.add(files('trace-hmp-cmds.c'))
>> -
>> -specific_ss.add(files('control-target.c'))
>> +system_ss.add(files('control-target.c', 'trace-hmp-cmds.c'))
>>   trace_events_files = []
>>   foreach item : [ '.' ] + trace_events_subdirs + qapi_trace_events

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

