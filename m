Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 525EFC54E41
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 16:10:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhtpx-0005c6-TD; Wed, 06 Mar 2024 11:09:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rhtpv-0005bq-HK
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 11:09:43 -0500
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rhtpt-00076K-8F
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 11:09:43 -0500
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-51323dfce59so6329513e87.3
 for <qemu-devel@nongnu.org>; Wed, 06 Mar 2024 08:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709741378; x=1710346178; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MmVJkOBa60r8dmjE4j3/FlIqeLJFuZIPlB7HqkAJG3U=;
 b=Lr7YTRgoKyc0l+VIvSfvG9khnsJJ4aAb9/xhfT2RCjbzRM4xd2DdJWBSFbNvjPPQ7U
 iyBUq9GpZfzm7aacRMESKXNQHUSy1AJOjGOV3ekAkq53GDEXeX7oUSh8H4ploVHBSmJF
 tfvwG/Zpd1UCKmkGpcvFVmJ875Cind5kAHGLevnqLZZ44uP9a/JOpQpzciqZ1JAkEhH3
 esQuW6m4QaRtLqTLn/wROpYRVNcMkXP5yi2ERthpEw/ri7jqgxTQyR4/qY6p+boy9fVv
 H9+zX1D9RmLeimk4CwGbEpBARQKK6R4jAhG5sLVCGWGx9vBfGTvx3MXLkoOuAItKzjRQ
 OzvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709741378; x=1710346178;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MmVJkOBa60r8dmjE4j3/FlIqeLJFuZIPlB7HqkAJG3U=;
 b=suotcoUF4NSSq0tKXUmomq9uQiZX8LYAolfntkM4Cepn7S+blL5WXSQFXRIpLq7W38
 qE1M2ZXCyNzH8T+HBqi4FMVjc2DjOh7w76AiFKDutt3oG6Ub8QN58nExuHNK6UJ6/oL2
 4ScajQlB/0iHZ/QvpwXva9KA0iOwPBYKmujqmf9nBjanBlG3GLRLPBAVKkjFSR5xq5Eh
 1Ka9XVnq8Z+5ewoFHlPdxuj0BQ/KWcOSkN4W8N/SsVIDBYMU1IydJV+Xapu4m5+NFpzC
 lc5RllhIUPnx4s7x1j76jZjBz2U+dQn2DvjzCnO7Uvp04z3T6eEhVmQPX+BPxMBRBxj5
 zj8w==
X-Gm-Message-State: AOJu0YyWIqTlYjnBr7Mc2rZZ0PlDrJI6KW3An04KfhABtFDyfnE5EedA
 uWAAZYG3pY6RREZePaOSgDWMsnKCOK5mb5X9DMGfipQZ/W1bfbaNJg9MsWkSw4Y=
X-Google-Smtp-Source: AGHT+IG4stqdDxyaCO58ulQvA/V8i8I2EmJqoiv+uo867kaEoCgfjVCTHVOY8GKWq/Q3rUdbVWP5Eg==
X-Received: by 2002:ac2:442d:0:b0:513:685a:8696 with SMTP id
 w13-20020ac2442d000000b00513685a8696mr887152lfl.10.1709741378413; 
 Wed, 06 Mar 2024 08:09:38 -0800 (PST)
Received: from [192.168.69.100] ([176.187.210.193])
 by smtp.gmail.com with ESMTPSA id
 cx4-20020a170907168400b00a43a5bdd58bsm7259799ejd.211.2024.03.06.08.09.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Mar 2024 08:09:37 -0800 (PST)
Message-ID: <ea194c20-cf6f-4a7f-8eec-ef2036b82b97@linaro.org>
Date: Wed, 6 Mar 2024 17:09:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.1 02/18] hw/usb/hcd-xhci: Enumerate xhci_flags
 setting values
Content-Language: en-US
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, kvm@vger.kernel.org,
 Marcelo Tosatti <mtosatti@redhat.com>, devel@lists.libvirt.org,
 David Hildenbrand <david@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
References: <20240305134221.30924-1-philmd@linaro.org>
 <20240305134221.30924-3-philmd@linaro.org> <ZehvWi8UhQOl3v8j@intel.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <ZehvWi8UhQOl3v8j@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x134.google.com
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

Hi Zhao,

On 6/3/24 14:27, Zhao Liu wrote:
> Hi Philippe,
> 
> On Tue, Mar 05, 2024 at 02:42:04PM +0100, Philippe Mathieu-Daudé wrote:
>> Date: Tue,  5 Mar 2024 14:42:04 +0100
>> From: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Subject: [PATCH-for-9.1 02/18] hw/usb/hcd-xhci: Enumerate xhci_flags
>>   setting values
>> X-Mailer: git-send-email 2.41.0
>>
>> xhci_flags are used as bits for QOM properties,
>> expected to be somehow stable (external interface).
>>
>> Explicit their values so removing any enum doesn't
>> modify the other ones.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   hw/usb/hcd-xhci.h | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/usb/hcd-xhci.h b/hw/usb/hcd-xhci.h
>> index 98f598382a..37f0d2e43b 100644
>> --- a/hw/usb/hcd-xhci.h
>> +++ b/hw/usb/hcd-xhci.h
>> @@ -37,8 +37,8 @@ typedef struct XHCIEPContext XHCIEPContext;
>>   
>>   enum xhci_flags {
>>       XHCI_FLAG_SS_FIRST = 1,
>> -    XHCI_FLAG_FORCE_PCIE_ENDCAP,
>> -    XHCI_FLAG_ENABLE_STREAMS,
>> +    XHCI_FLAG_FORCE_PCIE_ENDCAP = 2,
>> +    XHCI_FLAG_ENABLE_STREAMS = 3,
>>   };
>>
> 
>  From the commit 290fd20db6e0 ("usb xhci: change msi/msix property
> type"), the enum values were modified directly.
> 
> So it seems not necessary to bind enum type with specific value,
> right?

Indeed! Let's drop this patch then.

Thanks for referencing the commit,

Phil.

> Thanks,
> Zhao
> 
> 


