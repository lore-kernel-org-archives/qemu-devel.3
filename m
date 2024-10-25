Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CB20D0C608
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 13:19:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4KDB-0004mI-MP; Fri, 25 Oct 2024 09:18:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1t4KD7-0004lk-Ep
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 09:18:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1t4KD5-0008KV-UN
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 09:18:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729862314;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ovdnNFJWfaMrNfQOdsyd8gG4V34tuPWZ0MBGZ/4cI3c=;
 b=RhDTofgxhpTCBcDtyue2FXulLz50F2qmy6/mI6YbZj9XEQt1GrJiUKVDdxVlfAr6U4gfuY
 z7QOo+5C9nrZrqkpgQJz7Qb7ZdxqSk6F1pmii1OYxVw5ZjF7O2koMMWjGAi32uFlBuAQZf
 qHhCHfqNWkw4qqrDCWxdq9AmRzLze2A=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-310-ez4UslBmOOOEAByF4E5eOw-1; Fri, 25 Oct 2024 09:18:30 -0400
X-MC-Unique: ez4UslBmOOOEAByF4E5eOw-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-539e75025f9so1302075e87.3
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2024 06:18:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729862308; x=1730467108;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ovdnNFJWfaMrNfQOdsyd8gG4V34tuPWZ0MBGZ/4cI3c=;
 b=vRa+3OpA7zFOws6Km3jjND6onWb0LElFjkSqlxJGH8u0v6a3O/0e9TsMw50D9BwLu/
 YwPZQr2S9QL3rHIMYarGa9E553yNEqPBFOO3vuEW+vPdiQ63MFk6HXQqGKR9jRQxXirD
 uuOx9U+6vC+3x8ezEIeDfvSrLPlnJ3slxP6Sk0Td2zi7/WLO4sT27v6USuoeMHoupFTo
 IbhFw7DHjqmWEG5WOrGHm0eD/r4yFTxfCllqorHzW5s17D/BvYZIvzDb998wU8Tgcvgy
 3qSLPbE9Bd998M5i8KscTowGJiyo2K+HK3YgaDqUtFDjJZNxYpM0VObcmmuGSYefCO2y
 V/7w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVleV+sd66BVBWPq+s2wsGz7gjm8D2HAjb/+AK92j167X91cuFIojS7ioWwDhdOUIysfvDiBzkvtW2r@nongnu.org
X-Gm-Message-State: AOJu0YzPDvmxSZdOm3NWl805m9UMzq0NczKFSib3fkRpi+C3WUvXgUKz
 fXrzrUs7mCpelrW72vR/P9FPtGP0+Mu5qkC4jod5sGPFssunbM0ENGney6RuRVMIhd8i2/yoRZw
 gjICUo9tTjUbVLHHn1FbIqtuVVeF7TWdguWrWiyUIcY58WPnPoI1c
X-Received: by 2002:a05:6512:6ca:b0:52e:f2a6:8e1a with SMTP id
 2adb3069b0e04-53b23e1913amr3353649e87.29.1729862308360; 
 Fri, 25 Oct 2024 06:18:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEE6l1RO+HFEJ0fSLyfHGTU99HTtHKSVheFimbf6qCBYJTxuCcv2khs7uZGHEDow/AG4mL6qA==
X-Received: by 2002:a05:6512:6ca:b0:52e:f2a6:8e1a with SMTP id
 2adb3069b0e04-53b23e1913amr3353619e87.29.1729862307898; 
 Fri, 25 Oct 2024 06:18:27 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-431935f875esm17460435e9.37.2024.10.25.06.18.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Oct 2024 06:18:27 -0700 (PDT)
Message-ID: <cb6c8f62-c5dc-416d-865f-fbdf96164dac@redhat.com>
Date: Fri, 25 Oct 2024 15:18:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 18/21] arm/cpu: Introduce a customizable kvm host cpu model
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: eric.auger.pro@gmail.com, cohuck@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, kvmarm@lists.linux.dev, peter.maydell@linaro.org,
 richard.henderson@linaro.org, alex.bennee@linaro.org, maz@kernel.org,
 oliver.upton@linux.dev, sebott@redhat.com,
 shameerali.kolothum.thodi@huawei.com, armbru@redhat.com,
 abologna@redhat.com, jdenemar@redhat.com, shahuang@redhat.com,
 mark.rutland@arm.com, philmd@linaro.org, pbonzini@redhat.com
References: <20241025101959.601048-1-eric.auger@redhat.com>
 <20241025101959.601048-19-eric.auger@redhat.com>
 <ZxuX4i9NjVRizB72@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <ZxuX4i9NjVRizB72@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.454,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Daniel,

On 10/25/24 15:06, Daniel P. Berrangé wrote:
> On Fri, Oct 25, 2024 at 12:17:37PM +0200, Eric Auger wrote:
>> This new cpu model takes by default the host cpu values.
>> However it exposes uint64 SYSREG properties for writable ID reg
>> fields exposed by the host kernel. Properties are named
>> SYSREG_<REG>_<FIELD> with REG and FIELD being those used
>> in linux arch/arm64/tools/sysreg. This done by matching the
>> writable fields retrieved from the host kernel against the
>> generated description of sysregs.
>>
>> An example of invocation is:
>> -cpu custom,SYSREG_ID_AA64ISAR0_EL1_DP=0x0
>> which sets DP field of ID_AA64ISAR0_EL1 to 0.
> "SYSREG_" feels kinda redundant to repeat on every single
> feature. 

I do agree. To be honest this was mostly driven my implementation need
for cpu model expansion. Given the high number of props which are
getting exposed, I iterate on all props and having a prefix let me
return only those SYSREG props. Most probably we can get rid of the
prefix by using some generated code as well.
>
> Also, is this naming convention really the same one that users
> will see when they look at /proc/cpuinfo to view features ? It
No it is not. I do agree that the custom cpu model is very low level. It
is very well suited to test all series turning ID regs as writable but
this would require an extra layer that adapts /proc/cpuinfo feature
level to this regid/field abstraction.

In /cpu/proc you will see somethink like:
 Features    : fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics fphp
asimdhp cpuid asimdrdm lrcpc dcpop asimddp
> feels pretty low level to me ?  Naming after the registers &
> fields, would be like configuring x86 CPU features by asking
> for "SYSREG_EAX_1_ECX_20" instead of saying "vmx" which is the
> human friendly name.
agreed.
>
>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
>>
>> ---
>>
>> At the moment, the custom model does not support legacy options
>> of the host cpu model. We need to understand what we do with those
>> latter (SVE, ...). This means that related KVM ioctl are
>> not called yet.
> It will be pretty painful to have to use different feature
> terminology for different CPU models. Everything in libvirt
> assuming feature terminology varies per-arch, not per-CPU
> model.
Actually as far as I understand those regids/fields would fit all kind
of aarch64 Cortex-A CPUs. So they wouldn't vary per-CPU (I mean their
terminology. Their availability will).

Thanks

Eric
>
>
> With regards,
> Daniel


