Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08414C83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Jul 2025 06:06:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uceE0-0008DS-Ra; Fri, 18 Jul 2025 02:05:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uceDu-00087E-LD
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 02:05:34 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uceDr-00045D-Py
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 02:05:33 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3a528243636so1057614f8f.3
 for <qemu-devel@nongnu.org>; Thu, 17 Jul 2025 23:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752818727; x=1753423527; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=d/Z0e0v+mj/JtzZZOgIVYftr5t4NKA0qBwbcMyxAgqQ=;
 b=TSnmPByyssxDzCazPUHh3D7UGRitmY1/Hk+onkvZ07itLoV+KQF79b0Vci/SSXsDk3
 A45sKeba4Axl4HNWwZAHtf9Jy4T6lsOOLCV7zFI422rOB8D+1b2N/GwLnyGMaWUerFoj
 0j2mu+gHzFQHQlPWS48OzN5Ly+juMlyi3xHKBJ8idD+SHt7p2f1SxxAdOizJ7bp8rLD7
 2wG7iQUAAW3yEAAUnVTXyahZT4jXl/7wsrmF85VB6GSF8eCdykGtTBzh5wAAwFSLDOTS
 oSz2w45nMLt+fgsWkkFmWqQOt9gO5KdcFcnkX21AijiJyMTgtwlkrGmhGyhDIUVh/RgS
 q0tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752818727; x=1753423527;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=d/Z0e0v+mj/JtzZZOgIVYftr5t4NKA0qBwbcMyxAgqQ=;
 b=Qyw1YWu4I3eFJuqYtg4E2ndM/yMCzj+fZNq6NOzWAKUkOqK5yMgjfUp7H+8WW+S7fI
 E/pUm2VHII7KRy7+s6nCV2PkHmk2tiqKJ+2lmM3Bmz9nGEaCG4QWIQGsL9VV+Gk2ChzA
 0A7MVrltF2qjQPw6F+1BsrOEyxD4HkEwuA+i+Htw1nus/cIA0gTqcy7NLK1jC3L7GouX
 CSd9YH940GAreVqgsKXrYcTOnJ47RvWXJy8c0kYcwFex47XCIha7d6wJsfU6fHiSVHsE
 obi2i+XF4J23QZX5XjIimtQ+BGsdf6Rf5DVM1RPPNczTNRYFC7UXFhFjlnAgfcSoSe/I
 yuGw==
X-Gm-Message-State: AOJu0YzZsx3sVEYPXVE0kLMpfr8IA7jwkfryhoZ5u7i1LAuMipa/8OXq
 iuJMp59o8zogNWlFUL6Tfcc/SX8OE7n/SmvpMDje1ZVnZVpXId+5F5TPFx4DaBQGC5s=
X-Gm-Gg: ASbGncvl+DnK6d/gWvhLuWNLWl4ybNx7URTYKS/2zmPtSGMdbEJfUkknWcIAyki0fIV
 gUK5cRK/kqme6Ef0+THlE86gkznZ4FiZdnSfjZdvsgonEWHX1kF6DsX5UteYQNz/tJjdnhLkPk6
 KqdDMmcdWVjuU1DGNR3P1roTwc/oBkRET2f+aCuInKKiQcYTCnrYlPAo3hqFaA74G5Rkv1EHlk1
 Gwf32Dnjfe+UEgu55thY1BdyeP/ukDZiIJyypNjcGD4g584RLbS8/vqANoe1f5Q0H3mgwKDvNsE
 UpSMyyDy96nf6oHy4EjBFfv1d7AFMD2jPkJg467GeHrXUk2xVK5qpJpDM2koXHt8aypBR6m9wf+
 YEtJs0EA9xaIuNylEpD+OJZYDJe0G8rk56VIh5QYGEbG3GedHK5X9+TdreVnPQhzNBlU4d7w1AA
 tS
X-Google-Smtp-Source: AGHT+IEVwoPtEffqV2UvbXG9QA/NTIVikliowCIzaSgzMAwHP1lDMSfGQA4GeS4Vvw0eyzWGzY3TTw==
X-Received: by 2002:a05:6000:4816:b0:3b6:d95:a3a4 with SMTP id
 ffacd0b85a97d-3b61b0ebecemr1002389f8f.4.1752818727223; 
 Thu, 17 Jul 2025 23:05:27 -0700 (PDT)
Received: from [192.168.69.239] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b61ca48991sm854502f8f.44.2025.07.17.23.05.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Jul 2025 23:05:26 -0700 (PDT)
Message-ID: <2c536b62-1253-4ac2-a549-ce783f8bf5c6@linaro.org>
Date: Fri, 18 Jul 2025 08:05:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xen/passthrough: add missing error-report include
To: Markus Armbruster <armbru@redhat.com>,
 Adam Williamson <awilliam@redhat.com>
Cc: qemu-devel@nongnu.org, Paul Durrant <paul@xen.org>,
 xen-devel@lists.xenproject.org, Stefano Stabellini <sstabellini@kernel.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Anthony PERARD <anthony@xenproject.org>
References: <20250717220207.171040-1-awilliam@redhat.com>
 <87v7nqgk21.fsf@pond.sub.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <87v7nqgk21.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

On 18/7/25 07:11, Markus Armbruster wrote:
> Adam Williamson <awilliam@redhat.com> writes:
> 
>> In cfcacba an `error_report` was added to this file, but the

    In commit cfcacbab38e ("xen/passthrough: use gsi to map pirq when
    dom0 is PVH") an `error_report` was added to this file, but the

>> corresponding include of `qemu/error-report.h` was missed. This
>> only becomes apparent when building against Xen 4.20+.
>>
>> Signed-off-by: Adam Williamson <awilliam@redhat.com>
>> ---
>>   hw/xen/xen_pt.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/hw/xen/xen_pt.c b/hw/xen/xen_pt.c
>> index 9d16644d82..006b5b55f2 100644
>> --- a/hw/xen/xen_pt.c
>> +++ b/hw/xen/xen_pt.c
>> @@ -54,6 +54,7 @@
>>   
>>   #include "qemu/osdep.h"
>>   #include "qapi/error.h"
>> +#include "qemu/error-report.h"
>>   #include <sys/ioctl.h>
>>   
>>   #include "hw/pci/pci.h"
> 
> Uh, error-report.h is included without this for me.  To see, build with
> -H:
> 
> . /work/armbru/qemu/hw/xen/xen_pt.h
> .. /work/armbru/qemu/include/hw/xen/xen_native.h
> ... /work/armbru/qemu/hw/xen/trace.h
> .... ./trace/trace-hw_xen.h
> ..... /work/armbru/qemu/include/qemu/error-report.h
> 
> Code smell: header in include/... includes header from hw/.  Not this
> patch's concern.

Lucky side effect of including "trace.h" a include/ file due to trace
event being called in inlined function. Bad pattern indeed.

Back to this patch:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



