Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68E79C3ABDD
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 12:38:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHMEp-0005vE-28; Tue, 20 May 2025 08:38:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uHMEl-0005v4-KQ
 for qemu-devel@nongnu.org; Tue, 20 May 2025 08:38:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uHMEj-0005hx-Jq
 for qemu-devel@nongnu.org; Tue, 20 May 2025 08:38:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747744703;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=OlTwYbYiSwZbnPaQhK2N89+wWKbyTlp1cjbCg09zpFY=;
 b=hdCUYWbUTWDREk1DmYLy/xd3RSahVlnJRtU0sSwgDxlM01/D8izkc7hcPGFtvea42WdJE0
 K9/7jqxXMOPIyGurQMgx44+XqTiJ8aEX7cy7TQiTbWBMqpSL8vbMuVXlfb7/pZvbUWagWP
 OjTN643oeUWpRKNQF3oC+kY6jjFGonU=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-490-ojjpIKuSPDOGZvBXU4Yy6g-1; Tue, 20 May 2025 08:38:22 -0400
X-MC-Unique: ojjpIKuSPDOGZvBXU4Yy6g-1
X-Mimecast-MFC-AGG-ID: ojjpIKuSPDOGZvBXU4Yy6g_1747744701
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-acf16746a74so126310666b.0
 for <qemu-devel@nongnu.org>; Tue, 20 May 2025 05:38:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747744701; x=1748349501;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OlTwYbYiSwZbnPaQhK2N89+wWKbyTlp1cjbCg09zpFY=;
 b=WNS5RoTzl2Mqq5RqCR/kLEcoXwNILR8gOI2xfW3y0p/wy8dNNSk66ea5U5/kVEAlMT
 HNLGVRA0okXSBL7HqOCvr/hLsAu4WB6s78xYm7p1SawZpBYDpG2bGat0bAYfu4oemqXE
 VMcFQi/+hzwYVkluykj3Tq+kXW/Eb/PHNC9SJYvgYhJA8pf2TjQUBY9/u9TAKbrkGb9C
 u2rfI/wUIMoJWbLngeOtlMdW6uofDIsCZmT+qStY/x60Jd4GjntqJGc41YGrnpv6VWLO
 VkyaD/B3blffDAME9HupxUw2hgK75TqFrqASI1hjJk5GuTDptXZgTpVWaTLAGu58UugA
 m4jA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXf6870VjXvgx/U5ulFQSNb5+4MlhYaUG2MCIa8wrQYzibeGnCw8gfHvA+f+QJ3A2JmeqxYobp/YbF1@nongnu.org
X-Gm-Message-State: AOJu0YzPuP/IR6XEo7bgdFB3woWxCLjwZxjRx3c022eFb0ykwr8X8I+v
 jX30WBJYOZ9odxaf+jaDZsE72O6JkuK6e1eKqa4TVHoybgACM1uok0sO5Q5zfV07pCXk3eqf2Wd
 0mUkhGuxvey4S3RwSEdq658K8eeQq6vxapO3RJre5J8qSQk+IC/eC+4dD
X-Gm-Gg: ASbGnctJFCgX6lRZZ2HH93LDNfrCBkznn3FZCWu4NDVjqIYHL5yxoT+Pdxx+LvGl3e7
 NxxAMeAJvlGoi1cN7WQAW0aTpMlCNadtSlk+J1CjyzaFXWE/Dvfkd1E0JrPRDUtC7z6FTe5cNC6
 Cs20ZKm3C7KShwrePWY2sRDDBxg6lfOp23dPHnOXsZzvmMPXLxnY2jGZw5CU3x7zZS4D+tQZkZB
 Ba8oeYUWq2UzQFskB1ffJWqhN6tvoRh5VcPNjcXk2R8+vlw8m4IzUSDFYw9wxFkLhG+cWNyUBop
 LxJETghU2ov5PA==
X-Received: by 2002:a17:907:97cf:b0:ad2:4eef:d33a with SMTP id
 a640c23a62f3a-ad52d49b55cmr1581787166b.15.1747744701188; 
 Tue, 20 May 2025 05:38:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEfAY3VArnQtSMeZ6Y6FTC6/qgwtri/lhgd4kgPFomDLWaMuga4byy0/DM7yU2Pji6ho8akyA==
X-Received: by 2002:a17:907:97cf:b0:ad2:4eef:d33a with SMTP id
 a640c23a62f3a-ad52d49b55cmr1581784966b.15.1747744700750; 
 Tue, 20 May 2025 05:38:20 -0700 (PDT)
Received: from [192.168.10.81] ([151.95.46.79])
 by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-ad52d277a1fsm721736366b.85.2025.05.20.05.38.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 May 2025 05:38:20 -0700 (PDT)
Message-ID: <37631dff-d3cd-49eb-9a2d-f42d94ed74a3@redhat.com>
Date: Tue, 20 May 2025 14:38:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 06/25] accel/mshv: Add accelerator skeleton
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>
Cc: magnuskulke@microsoft.com, qemu-devel@nongnu.org, liuwe@microsoft.com,
 "Michael S. Tsirkin" <mst@redhat.com>, Wei Liu <wei.liu@kernel.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Roman Bolshakov
 <rbolshakov@ddn.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cameron Esfahani <dirty@apple.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20250520113018.49569-1-magnuskulke@linux.microsoft.com>
 <20250520113018.49569-7-magnuskulke@linux.microsoft.com>
 <aCxvOfF3ytXYnhp1@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <aCxvOfF3ytXYnhp1@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.487,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 5/20/25 14:02, Daniel P. Berrangé wrote:
> On Tue, May 20, 2025 at 01:29:59PM +0200, Magnus Kulke wrote:
>> Introduce the initial scaffold for the MSHV (Microsoft Hypervisor)
>> accelerator backend. This includes the basic directory structure and
>> stub implementations needed to integrate with QEMU's accelerator
>> framework.
>>
>> Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
>> ---
>>   accel/meson.build      |   1 +
>>   accel/mshv/meson.build |   6 ++
>>   accel/mshv/mshv-all.c  | 143 +++++++++++++++++++++++++++++++++++++++++
>>   include/system/mshv.h  |  34 ++++++++++
>>   4 files changed, 184 insertions(+)
>>   create mode 100644 accel/mshv/meson.build
>>   create mode 100644 accel/mshv/mshv-all.c
>>
> 
>> diff --git a/accel/mshv/mshv-all.c b/accel/mshv/mshv-all.c
>> new file mode 100644
>> index 0000000000..44605adf94
>> --- /dev/null
>> +++ b/accel/mshv/mshv-all.c
> 
>> +
>> +static int mshv_init(MachineState *ms)
>> +{
>> +	error_report("unimplemented");
>> +	abort();
>> +}
> 
> Nit-picking - although you remove these lines in later patches,
> lets remove the tabs from these lines.

Indent is a bit messy throughout the whole series, in some files there 
are also TAB characters that are supposed to expand to 4.

Probably easiest to run all new files through autoindent, there must be 
some VSCode magic for that. :)

Paolo

>> diff --git a/include/system/mshv.h b/include/system/mshv.h
>> index bc8f2c228a..0858e47def 100644
>> --- a/include/system/mshv.h
>> +++ b/include/system/mshv.h
>> @@ -16,6 +16,14 @@
>>   #ifndef QEMU_MSHV_INT_H
>>   #define QEMU_MSHV_INT_H
>>   
>> +#include "qemu/osdep.h"
>> +#include "qemu/accel.h"
>> +#include "hw/hyperv/hyperv-proto.h"
>> +#include "hw/hyperv/linux-mshv.h"
>> +#include "hw/hyperv/hvhdk.h"
>> +#include "qapi/qapi-types-common.h"
>> +#include "system/memory.h"
>> +
>>   #ifdef COMPILING_PER_TARGET
>>   #ifdef CONFIG_MSHV
>>   #define CONFIG_MSHV_IS_POSSIBLE
>> @@ -28,6 +36,32 @@
>>   #ifdef CONFIG_MSHV_IS_POSSIBLE
>>   extern bool mshv_allowed;
>>   #define mshv_enabled() (mshv_allowed)
>> +
>> +typedef struct MshvMemoryListener {
>> +  MemoryListener listener;
>> +  int as_id;
>> +} MshvMemoryListener;
>> +
>> +typedef struct MshvAddressSpace {
>> +    MshvMemoryListener *ml;
>> +    AddressSpace *as;
>> +} MshvAddressSpace;
> 
> Inconsistent mix of 2-space and 4-space
> indents - stick with 4-space throughout


