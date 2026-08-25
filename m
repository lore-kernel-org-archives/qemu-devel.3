Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6848CC61DBE
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 15:35:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wytB8-0006Fu-Gr; Tue, 25 Aug 2026 11:35:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wytB6-0006Dj-SJ
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 11:35:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wytB3-0002kG-Gj
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 11:35:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787672104;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ppgXbPiE+3Uv8DDxwDgRxNERk1v/95srvtY0MygFPJY=;
 b=eze8KP6QOyB9ZqWFdjKoFt/vBisND4Mqnrh++g1+xDyvV0wQX7uJ71TQgMqgG2yYVVIHrK
 4E/e6BZhsBCltWATLKDsmUqHssoaA9UnLbKxkcaDv07tcD0bGPPMsKiqZCJo/r4Ec8kgxV
 AyUOwTnJuxnmkxQAYSbmlAunDArrNxc=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-9-u_zrZThiOPWDiD_Vx8m9fg-1; Tue, 25 Aug 2026 11:35:01 -0400
X-MC-Unique: u_zrZThiOPWDiD_Vx8m9fg-1
X-Mimecast-MFC-AGG-ID: u_zrZThiOPWDiD_Vx8m9fg_1787672101
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-6a3899d74c5so6485274a12.0
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 08:35:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787672100; x=1788276900;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:reply-to:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ppgXbPiE+3Uv8DDxwDgRxNERk1v/95srvtY0MygFPJY=;
 b=kjybySeWmtHTQgtNvTEGDFn4Vi9oTok+kIQxxNO+8sEtFFWyoWEhgwTKOrhV5/bqdM
 +kcFcOj1jAdn6tCALx45jYQChgTS84ASQpAKeS5kJJyDTh2Sqb6hPcRwfX0wnLnem1ch
 HZD3LKTv/LEK4XPJVX/pRPZX6CiBGAB7Spnn2s8uxxxiphy3J+ePo1c907YVHJDF66gn
 i3Xq7sA5879DGYUBWww1c45wyKVDNOaS7jh4gTmP6xXeAbpJ2gr0p++71IuOwEvr3aMi
 qeVJCQ5gghyfNy5835nYhR5Gl3R4cNrPP5hyFqqtsY1VLFMnjmFAJErnoWQ/++eRGB//
 Srjg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqTClWBBGGfRzg406uvGSJfR1PdsKwwg2vNmtAGqujQmj5OFjvHpyPi1P1/TJzmbv+dbUcxXQ+F0bSc@nongnu.org
X-Gm-Message-State: AFuF++nfa7W2w2M8gngzC1DLr0sbE9TWP38OoBMrgB/cC/1ZcmAi97NA
 Ku9RUaVaVXYknkTQrVOoOFDu0P5P6lNH6crtLix4J/L8nTmZkmdGpoZTVrcv71zI505bY/4IqOm
 UZC/lAxV8LGZ7BUMz/P4irjcWH9WZRqrWLZS36QjqEYz32cwgfF+vJO2F
X-Gm-Gg: AR+sD12KfpNGghaAEpe2SIvhdur8LHk/j/UZdycrgDiwsm9Y0Lj4WJ5b3FbGUDRtvlW
 gUlJSvk5oGJbueELpDW7cWBp0fEh0K8N57ng3cd7lLPtVogVqqttU1x7ppuH/RQ1eh6cDLDh1GL
 O1MIYnOWSkL5+TOmW03AB7//YybssqBLSBsgWyJJ99FIvcL8IFMrYd3Sy7kCcsOAoIkNYxplE4V
 mXM7v2+uS+pdQrTC0oxHpWmhnjg4XTXwec/aUWYxvY+4RkwUGnK2W+H58DXOhCe08aTbqZ9n5Ts
 VYeL1A/80/Wb1/jhq5uiHCz6tnw/fhTadWa/G3w9Ai+iXIgEHkvHuZcOSjVG2z4QqoxXRKL4kH3
 2KQNNhPJwNkZ5ksXVqIUpmASU8N3BhBBlx84rXGSh2ogl79jw
X-Received: by 2002:a05:6402:324d:b0:6a3:f47c:969 with SMTP id
 4fb4d7f45d1cf-6a5c40ccb42mr8830745a12.3.1787672100324; 
 Tue, 25 Aug 2026 08:35:00 -0700 (PDT)
X-Received: by 2002:a05:6402:324d:b0:6a3:f47c:969 with SMTP id
 4fb4d7f45d1cf-6a5c40ccb42mr8830691a12.3.1787672099808; 
 Tue, 25 Aug 2026 08:34:59 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a5dea83babsm201637a12.16.2026.08.25.08.34.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Aug 2026 08:34:59 -0700 (PDT)
Message-ID: <71022115-11f5-41d7-96fe-14499952c10e@redhat.com>
Date: Tue, 25 Aug 2026 17:34:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v7 14/18] target/arm/cpu-idregs.h.inc: Generate
 reserved fields
Content-Language: en-US
To: Khushit Shah <khushit.shah@nutanix.com>
Cc: "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 Shaju Abraham <shaju.abraham@nutanix.com>,
 "yangjinqian1@huawei.com" <yangjinqian1@huawei.com>,
 "cohuck@redhat.com" <cohuck@redhat.com>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "sebott@redhat.com" <sebott@redhat.com>,
 "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "philmd@oss.qualcomm.com" <philmd@oss.qualcomm.com>,
 "maz@kernel.org" <maz@kernel.org>,
 "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>,
 "abologna@redhat.com" <abologna@redhat.com>,
 "jdenemar@redhat.com" <jdenemar@redhat.com>
References: <20260726153221.24773-1-eric.auger@redhat.com>
 <20260726153221.24773-15-eric.auger@redhat.com>
 <F9333A1C-BBFF-4134-8FDB-5DC94CD31445@nutanix.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <F9333A1C-BBFF-4134-8FDB-5DC94CD31445@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, UPPERCASE_50_75=0.008 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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

Hi Khushit,

On 8/24/26 8:55 AM, Khushit Shah wrote:
>
>> On 26 Jul 2026, at 8:59 PM, Eric Auger <eric.auger@redhat.com> wrote:
>>
>> !-------------------------------------------------------------------|
>>  CAUTION: External Email
>>
>> |-------------------------------------------------------------------!
>>
>> Extract reserved fields: RES0, RES1, RAZ, ...
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> ---
>> target/arm/cpu-idregs.h.inc                   | 69 ++++++++++++++-
>> .../update-aarch64-cpu-sysreg-properties.py   | 83 +++++++++++++++----
>> 2 files changed, 136 insertions(+), 16 deletions(-)
>>
>> diff --git a/target/arm/cpu-idregs.h.inc b/target/arm/cpu-idregs.h.inc
>> index 1c8b26133b..5fdc84237c 100644
>> --- a/target/arm/cpu-idregs.h.inc
>> +++ b/target/arm/cpu-idregs.h.inc
>> @@ -15,16 +15,20 @@ IDREG_START(AIDR_EL1)
>> IDREG_END(AIDR_EL1)
>>
>> IDREG_START(CCSIDR2_EL1)
>> +    IDREG_FIELD(CCSIDR2_EL1, RES0, 24, 40)
>>     IDREG_FIELD(CCSIDR2_EL1, NumSets, 0, 24)
>> IDREG_END(CCSIDR2_EL1)
>>
>> IDREG_START(CCSIDR_EL1)
>> +    IDREG_FIELD(CCSIDR_EL1, RES0, 56, 8)
>>     IDREG_FIELD(CCSIDR_EL1, NumSets, 32, 24)
>> +    IDREG_FIELD(CCSIDR_EL1, RES0, 24, 8)
>>     IDREG_FIELD(CCSIDR_EL1, Associativity, 3, 21)
>>     IDREG_FIELD(CCSIDR_EL1, LineSize, 0, 3)
>> IDREG_END(CCSIDR_EL1)
>>
>> IDREG_START(CLIDR_EL1)
>> +    IDREG_FIELD(CLIDR_EL1, RES0, 47, 17)
>>     IDREG_FIELD(CLIDR_EL1, Ttype7, 45, 2)
>>     IDREG_FIELD(CLIDR_EL1, Ttype6, 43, 2)
>>     IDREG_FIELD(CLIDR_EL1, Ttype5, 41, 2)
>> @@ -55,7 +59,10 @@ IDREG_START(CLIDR_EL1)
>> IDREG_END(CLIDR_EL1)
>>
>> IDREG_START(CTR_EL0)
>> +    IDREG_FIELD(CTR_EL0, RES0, 38, 26)
>>     IDREG_FIELD(CTR_EL0, TminLine, 32, 6)
>> +    IDREG_FIELD(CTR_EL0, RES1, 31, 1)
>> +    IDREG_FIELD(CTR_EL0, RES0, 30, 1)
>>     IDREG_FIELD_START(CTR_EL0, DIC, 29, 1)
>>         IDREG_FIELD_ARCH_VAL(0)
>>         IDREG_FIELD_ARCH_VAL(1)
>> @@ -73,23 +80,28 @@ IDREG_START(CTR_EL0)
>>         IDREG_FIELD_ARCH_VAL(2)
>>         IDREG_FIELD_ARCH_VAL(3)
>>     IDREG_FIELD_END(CTR_EL0, L1Ip)
>> +    IDREG_FIELD(CTR_EL0, RES0, 4, 10)
>>     IDREG_FIELD(CTR_EL0, IminLine, 0, 4)
>> IDREG_END(CTR_EL0)
>>
>> IDREG_START(DCZID_EL0)
>> +    IDREG_FIELD(DCZID_EL0, RES0, 9, 55)
>>     IDREG_FIELD(DCZID_EL0, TBS, 5, 4)
>>     IDREG_FIELD(DCZID_EL0, DZP, 4, 1)
>>     IDREG_FIELD(DCZID_EL0, BS, 0, 4)
>> IDREG_END(DCZID_EL0)
>>
>> IDREG_START(GMID_EL1)
>> +    IDREG_FIELD(GMID_EL1, RES0, 4, 60)
>>     IDREG_FIELD(GMID_EL1, BS, 0, 4)
>> IDREG_END(GMID_EL1)
>>
>> IDREG_START(ID_AA64AFR0_EL1)
>> +    IDREG_FIELD(ID_AA64AFR0_EL1, RES0, 32, 32)
>> IDREG_END(ID_AA64AFR0_EL1)
>>
>> IDREG_START(ID_AA64AFR1_EL1)
>> +    IDREG_FIELD(ID_AA64AFR1_EL1, RES0, 0, 64)
>> IDREG_END(ID_AA64AFR1_EL1)
>>
>> IDREG_START(ID_AA64DFR0_EL1)
>> @@ -136,6 +148,7 @@ IDREG_START(ID_AA64DFR0_EL1)
>>     IDREG_FIELD_START(ID_AA64DFR0_EL1, CTX_CMPs, 28, 4)
>>         IDREG_FIELD_ARCH_VAL(15)
>>     IDREG_FIELD_END(ID_AA64DFR0_EL1, CTX_CMPs)
>> +    IDREG_FIELD(ID_AA64DFR0_EL1, RES0, 24, 4)
>>     IDREG_FIELD(ID_AA64DFR0_EL1, WRPs, 20, 4)
>>     IDREG_FIELD_START(ID_AA64DFR0_EL1, PMSS, 16, 4)
>>         IDREG_FIELD_ARCH_VAL(0)
>> @@ -209,6 +222,7 @@ IDREG_START(ID_AA64DFR1_EL1)
>> IDREG_END(ID_AA64DFR1_EL1)
>>
>> IDREG_START(ID_AA64DFR2_EL1)
>> +    IDREG_FIELD(ID_AA64DFR2_EL1, RES0, 28, 36)
>>     IDREG_FIELD_START(ID_AA64DFR2_EL1, TRBE_EXC, 24, 4)
>>         IDREG_FIELD_ARCH_VAL(0)
>>         IDREG_FIELD_ARCH_VAL(1)
>> @@ -221,6 +235,7 @@ IDREG_START(ID_AA64DFR2_EL1)
>>         IDREG_FIELD_ARCH_VAL(0)
>>         IDREG_FIELD_ARCH_VAL(1)
>>     IDREG_FIELD_END(ID_AA64DFR2_EL1, SPE_EXC)
>> +    IDREG_FIELD(ID_AA64DFR2_EL1, RES0, 8, 8)
>>     IDREG_FIELD_START(ID_AA64DFR2_EL1, BWE, 4, 4)
>>         IDREG_FIELD_ARCH_VAL(0)
>>         IDREG_FIELD_ARCH_VAL(1)
>> @@ -233,6 +248,7 @@ IDREG_START(ID_AA64DFR2_EL1)
>> IDREG_END(ID_AA64DFR2_EL1)
>>
>> IDREG_START(ID_AA64FPFR0_EL1)
>> +    IDREG_FIELD(ID_AA64FPFR0_EL1, RES0, 32, 32)
>>     IDREG_FIELD_START(ID_AA64FPFR0_EL1, F8CVT, 31, 1)
>>         IDREG_FIELD_ARCH_VAL(0)
>>         IDREG_FIELD_ARCH_VAL(1)
>> @@ -257,10 +273,13 @@ IDREG_START(ID_AA64FPFR0_EL1)
>>         IDREG_FIELD_ARCH_VAL(0)
>>         IDREG_FIELD_ARCH_VAL(1)
>>     IDREG_FIELD_END(ID_AA64FPFR0_EL1, F8MM4)
>> +    IDREG_FIELD(ID_AA64FPFR0_EL1, RES0, 16, 10)
>>     IDREG_FIELD_START(ID_AA64FPFR0_EL1, F16MM2, 15, 1)
>>         IDREG_FIELD_ARCH_VAL(0)
>>         IDREG_FIELD_ARCH_VAL(1)
>>     IDREG_FIELD_END(ID_AA64FPFR0_EL1, F16MM2)
>> +    IDREG_FIELD(ID_AA64FPFR0_EL1, RES0, 8, 7)
>> +    IDREG_FIELD(ID_AA64FPFR0_EL1, RAZ, 2, 6)
>>     IDREG_FIELD_START(ID_AA64FPFR0_EL1, F8E4M3, 1, 1)
>>         IDREG_FIELD_ARCH_VAL(0)
>>         IDREG_FIELD_ARCH_VAL(1)
>> @@ -312,6 +331,7 @@ IDREG_START(ID_AA64ISAR0_EL1)
>>         IDREG_FIELD_ARCH_VAL(0)
>>         IDREG_FIELD_ARCH_VAL(1)
>>     IDREG_FIELD_END(ID_AA64ISAR0_EL1, RDM)
>> +    IDREG_FIELD(ID_AA64ISAR0_EL1, RES0, 24, 4)
>>     IDREG_FIELD_START(ID_AA64ISAR0_EL1, Atomic, 20, 4)
>>         IDREG_FIELD_ARCH_VAL(0)
>>         IDREG_FIELD_ARCH_VAL(2)
>> @@ -335,6 +355,7 @@ IDREG_START(ID_AA64ISAR0_EL1)
>>         IDREG_FIELD_ARCH_VAL(1)
>>         IDREG_FIELD_ARCH_VAL(2)
>>     IDREG_FIELD_END(ID_AA64ISAR0_EL1, AES)
>> +    IDREG_FIELD(ID_AA64ISAR0_EL1, RES0, 0, 4)
>> IDREG_END(ID_AA64ISAR0_EL1)
>>
>> IDREG_START(ID_AA64ISAR1_EL1)
>> @@ -498,6 +519,7 @@ IDREG_START(ID_AA64ISAR2_EL1)
>> IDREG_END(ID_AA64ISAR2_EL1)
>>
>> IDREG_START(ID_AA64ISAR3_EL1)
>> +    IDREG_FIELD(ID_AA64ISAR3_EL1, RES0, 48, 16)
>>     IDREG_FIELD_START(ID_AA64ISAR3_EL1, LSCP, 44, 4)
>>         IDREG_FIELD_ARCH_VAL(0)
>>         IDREG_FIELD_ARCH_VAL(1)
>> @@ -561,6 +583,7 @@ IDREG_START(ID_AA64MMFR0_EL1)
>>         IDREG_FIELD_ARCH_VAL(1)
>>         IDREG_FIELD_ARCH_VAL(2)
>>     IDREG_FIELD_END(ID_AA64MMFR0_EL1, FGT)
>> +    IDREG_FIELD(ID_AA64MMFR0_EL1, RES0, 48, 8)
>>     IDREG_FIELD_START(ID_AA64MMFR0_EL1, ExS, 44, 4)
>>         IDREG_FIELD_ARCH_VAL(0)
>>         IDREG_FIELD_ARCH_VAL(1)
>> @@ -713,6 +736,7 @@ IDREG_START(ID_AA64MMFR2_EL1)
>>         IDREG_FIELD_ARCH_VAL(0)
>>         IDREG_FIELD_ARCH_VAL(1)
>>     IDREG_FIELD_END(ID_AA64MMFR2_EL1, TTL)
>> +    IDREG_FIELD(ID_AA64MMFR2_EL1, RES0, 44, 4)
>>     IDREG_FIELD_START(ID_AA64MMFR2_EL1, FWB, 40, 4)
>>         IDREG_FIELD_ARCH_VAL(0)
>>         IDREG_FIELD_ARCH_VAL(1)
>> @@ -778,6 +802,7 @@ IDREG_START(ID_AA64MMFR3_EL1)
>>         IDREG_FIELD_ARCH_VAL(2)
>>         IDREG_FIELD_ARCH_VAL(3)
>>     IDREG_FIELD_END(ID_AA64MMFR3_EL1, SDERR)
>> +    IDREG_FIELD(ID_AA64MMFR3_EL1, RES0, 48, 4)
>>     IDREG_FIELD_START(ID_AA64MMFR3_EL1, ANERR, 44, 4)
>>         IDREG_FIELD_ARCH_VAL(0)
>>         IDREG_FIELD_ARCH_VAL(1)
>> @@ -1031,6 +1056,7 @@ IDREG_START(ID_AA64PFR1_EL1)
>>         IDREG_FIELD_ARCH_VAL(1)
>>         IDREG_FIELD_ARCH_VAL(2)
>>     IDREG_FIELD_END(ID_AA64PFR1_EL1, SME)
>> +    IDREG_FIELD(ID_AA64PFR1_EL1, RES0, 20, 4)
>>     IDREG_FIELD_START(ID_AA64PFR1_EL1, MPAM_frac, 16, 4)
>>         IDREG_FIELD_ARCH_VAL(0)
>>         IDREG_FIELD_ARCH_VAL(1)
>> @@ -1058,6 +1084,7 @@ IDREG_START(ID_AA64PFR1_EL1)
>> IDREG_END(ID_AA64PFR1_EL1)
>>
>> IDREG_START(ID_AA64PFR2_EL1)
>> +    IDREG_FIELD(ID_AA64PFR2_EL1, RES0, 48, 16)
>>     IDREG_FIELD_START(ID_AA64PFR2_EL1, VMTETCL, 44, 4)
>>         IDREG_FIELD_ARCH_VAL(0)
>>         IDREG_FIELD_ARCH_VAL(1)
>> @@ -1117,6 +1144,7 @@ IDREG_START(ID_AA64SMFR0_EL1)
>>         IDREG_FIELD_ARCH_VAL(0)
>>         IDREG_FIELD_ARCH_VAL(1)
>>     IDREG_FIELD_END(ID_AA64SMFR0_EL1, FA64)
>> +    IDREG_FIELD(ID_AA64SMFR0_EL1, RES0, 62, 1)
>>     IDREG_FIELD_START(ID_AA64SMFR0_EL1, LUT6, 61, 1)
>>         IDREG_FIELD_ARCH_VAL(0)
>>         IDREG_FIELD_ARCH_VAL(1)
>> @@ -1136,6 +1164,7 @@ IDREG_START(ID_AA64SMFR0_EL1)
>>         IDREG_FIELD_ARCH_VAL(0)
>>         IDREG_FIELD_ARCH_VAL(15)
>>     IDREG_FIELD_END(ID_AA64SMFR0_EL1, I16I64)
>> +    IDREG_FIELD(ID_AA64SMFR0_EL1, RES0, 49, 3)
>>     IDREG_FIELD_START(ID_AA64SMFR0_EL1, F64F64, 48, 1)
>>         IDREG_FIELD_ARCH_VAL(0)
>>         IDREG_FIELD_ARCH_VAL(1)
>> @@ -1180,6 +1209,7 @@ IDREG_START(ID_AA64SMFR0_EL1)
>>         IDREG_FIELD_ARCH_VAL(0)
>>         IDREG_FIELD_ARCH_VAL(1)
>>     IDREG_FIELD_END(ID_AA64SMFR0_EL1, F32F32)
>> +    IDREG_FIELD(ID_AA64SMFR0_EL1, RES0, 31, 1)
>>     IDREG_FIELD_START(ID_AA64SMFR0_EL1, SF8FMA, 30, 1)
>>         IDREG_FIELD_ARCH_VAL(0)
>>         IDREG_FIELD_ARCH_VAL(1)
>> @@ -1192,6 +1222,7 @@ IDREG_START(ID_AA64SMFR0_EL1)
>>         IDREG_FIELD_ARCH_VAL(0)
>>         IDREG_FIELD_ARCH_VAL(1)
>>     IDREG_FIELD_END(ID_AA64SMFR0_EL1, SF8DP2)
>> +    IDREG_FIELD(ID_AA64SMFR0_EL1, RES0, 26, 2)
>>     IDREG_FIELD_START(ID_AA64SMFR0_EL1, SBitPerm, 25, 1)
>>         IDREG_FIELD_ARCH_VAL(0)
>>         IDREG_FIELD_ARCH_VAL(1)
>> @@ -1204,10 +1235,12 @@ IDREG_START(ID_AA64SMFR0_EL1)
>>         IDREG_FIELD_ARCH_VAL(0)
>>         IDREG_FIELD_ARCH_VAL(1)
>>     IDREG_FIELD_END(ID_AA64SMFR0_EL1, SFEXPA)
>> +    IDREG_FIELD(ID_AA64SMFR0_EL1, RES0, 17, 6)
>>     IDREG_FIELD_START(ID_AA64SMFR0_EL1, STMOP, 16, 1)
>>         IDREG_FIELD_ARCH_VAL(0)
>>         IDREG_FIELD_ARCH_VAL(1)
>>     IDREG_FIELD_END(ID_AA64SMFR0_EL1, STMOP)
>> +    IDREG_FIELD(ID_AA64SMFR0_EL1, RES0, 1, 15)
>>     IDREG_FIELD_START(ID_AA64SMFR0_EL1, SMOP4, 0, 1)
>>         IDREG_FIELD_ARCH_VAL(0)
>>         IDREG_FIELD_ARCH_VAL(1)
>> @@ -1215,6 +1248,7 @@ IDREG_START(ID_AA64SMFR0_EL1)
>> IDREG_END(ID_AA64SMFR0_EL1)
>>
>> IDREG_START(ID_AA64ZFR0_EL1)
>> +    IDREG_FIELD(ID_AA64ZFR0_EL1, RES0, 60, 4)
>>     IDREG_FIELD_START(ID_AA64ZFR0_EL1, F64MM, 56, 4)
>>         IDREG_FIELD_ARCH_VAL(0)
>>         IDREG_FIELD_ARCH_VAL(1)
>> @@ -1235,10 +1269,12 @@ IDREG_START(ID_AA64ZFR0_EL1)
>>         IDREG_FIELD_ARCH_VAL(0)
>>         IDREG_FIELD_ARCH_VAL(1)
>>     IDREG_FIELD_END(ID_AA64ZFR0_EL1, SM4)
>> +    IDREG_FIELD(ID_AA64ZFR0_EL1, RES0, 36, 4)
>>     IDREG_FIELD_START(ID_AA64ZFR0_EL1, SHA3, 32, 4)
>>         IDREG_FIELD_ARCH_VAL(0)
>>         IDREG_FIELD_ARCH_VAL(1)
>>     IDREG_FIELD_END(ID_AA64ZFR0_EL1, SHA3)
>> +    IDREG_FIELD(ID_AA64ZFR0_EL1, RES0, 28, 4)
>>     IDREG_FIELD_START(ID_AA64ZFR0_EL1, B16B16, 24, 4)
>>         IDREG_FIELD_ARCH_VAL(0)
>>         IDREG_FIELD_ARCH_VAL(1)
>> @@ -1258,6 +1294,7 @@ IDREG_START(ID_AA64ZFR0_EL1)
>>         IDREG_FIELD_ARCH_VAL(0)
>>         IDREG_FIELD_ARCH_VAL(1)
>>     IDREG_FIELD_END(ID_AA64ZFR0_EL1, EltPerm)
>> +    IDREG_FIELD(ID_AA64ZFR0_EL1, RES0, 8, 4)
>>     IDREG_FIELD_START(ID_AA64ZFR0_EL1, AES, 4, 4)
>>         IDREG_FIELD_ARCH_VAL(0)
>>         IDREG_FIELD_ARCH_VAL(1)
>> @@ -1274,9 +1311,11 @@ IDREG_START(ID_AA64ZFR0_EL1)
>> IDREG_END(ID_AA64ZFR0_EL1)
>>
>> IDREG_START(ID_AFR0_EL1)
>> +    IDREG_FIELD(ID_AFR0_EL1, RES0, 0, 64)
>> IDREG_END(ID_AFR0_EL1)
>>
>> IDREG_START(ID_DFR0_EL1)
>> +    IDREG_FIELD(ID_DFR0_EL1, RES0, 32, 32)
>>     IDREG_FIELD_START(ID_DFR0_EL1, TraceFilt, 28, 4)
>>         IDREG_FIELD_ARCH_VAL(0)
>>         IDREG_FIELD_ARCH_VAL(1)
>> @@ -1328,6 +1367,7 @@ IDREG_START(ID_DFR0_EL1)
>> IDREG_END(ID_DFR0_EL1)
>>
>> IDREG_START(ID_DFR1_EL1)
>> +    IDREG_FIELD(ID_DFR1_EL1, RES0, 8, 56)
>>     IDREG_FIELD_START(ID_DFR1_EL1, HPMN0, 4, 4)
>>         IDREG_FIELD_ARCH_VAL(0)
>>         IDREG_FIELD_ARCH_VAL(1)
>> @@ -1340,6 +1380,7 @@ IDREG_START(ID_DFR1_EL1)
>> IDREG_END(ID_DFR1_EL1)
>>
>> IDREG_START(ID_ISAR0_EL1)
>> +    IDREG_FIELD(ID_ISAR0_EL1, RES0, 28, 36)
>>     IDREG_FIELD_START(ID_ISAR0_EL1, Divide, 24, 4)
>>         IDREG_FIELD_ARCH_VAL(0)
>>         IDREG_FIELD_ARCH_VAL(1)
>> @@ -1375,6 +1416,7 @@ IDREG_START(ID_ISAR0_EL1)
>> IDREG_END(ID_ISAR0_EL1)
>>
>> IDREG_START(ID_ISAR1_EL1)
>> +    IDREG_FIELD(ID_ISAR1_EL1, RES0, 32, 32)
>>     IDREG_FIELD_START(ID_ISAR1_EL1, Jazelle, 28, 4)
>>         IDREG_FIELD_ARCH_VAL(0)
>>         IDREG_FIELD_ARCH_VAL(1)
>> @@ -1413,6 +1455,7 @@ IDREG_START(ID_ISAR1_EL1)
>> IDREG_END(ID_ISAR1_EL1)
>>
>> IDREG_START(ID_ISAR2_EL1)
>> +    IDREG_FIELD(ID_ISAR2_EL1, RES0, 32, 32)
>>     IDREG_FIELD_START(ID_ISAR2_EL1, Reversal, 28, 4)
>>         IDREG_FIELD_ARCH_VAL(0)
>>         IDREG_FIELD_ARCH_VAL(1)
>> @@ -1458,6 +1501,7 @@ IDREG_START(ID_ISAR2_EL1)
>> IDREG_END(ID_ISAR2_EL1)
>>
>> IDREG_START(ID_ISAR3_EL1)
>> +    IDREG_FIELD(ID_ISAR3_EL1, RES0, 32, 32)
>>     IDREG_FIELD_START(ID_ISAR3_EL1, T32EE, 28, 4)
>>         IDREG_FIELD_ARCH_VAL(0)
>>         IDREG_FIELD_ARCH_VAL(1)
>> @@ -1495,6 +1539,7 @@ IDREG_START(ID_ISAR3_EL1)
>> IDREG_END(ID_ISAR3_EL1)
>>
>> IDREG_START(ID_ISAR4_EL1)
>> +    IDREG_FIELD(ID_ISAR4_EL1, RES0, 32, 32)
>>     IDREG_FIELD_START(ID_ISAR4_EL1, SWP_frac, 28, 4)
>>         IDREG_FIELD_ARCH_VAL(0)
>>         IDREG_FIELD_ARCH_VAL(1)
>> @@ -1519,12 +1564,12 @@ IDREG_START(ID_ISAR4_EL1)
>>         IDREG_FIELD_ARCH_VAL(0)
>>         IDREG_FIELD_ARCH_VAL(1)
>>     IDREG_FIELD_END(ID_ISAR4_EL1, Writeback)
>> -    IDREG_FIELD_START(ID_ISAR4_EL1, WithShifts, 4, 4)
>> +    IDREG_FIELD_START(ID_ISAR4_EL1, WI, 4, 4)
>>         IDREG_FIELD_ARCH_VAL(0)
>>         IDREG_FIELD_ARCH_VAL(1)
>>         IDREG_FIELD_ARCH_VAL(3)
>>         IDREG_FIELD_ARCH_VAL(4)
>> -    IDREG_FIELD_END(ID_ISAR4_EL1, WithShifts)
>> +    IDREG_FIELD_END(ID_ISAR4_EL1, WI)
> unintended change?

Correct. This comes from an issue in the script

+                for r_type in ["RES0", "RES1", "RAZ", "RAO", "WI", "UNKNOWN"]:
+                    if r_type in name_upper:


r_type = "WI" in "WithShifts" evaluates to true
fixed by 

if r_type == name_upper:


>
> This is the problem with relying solely on AARCHMRS?
> Imagine a named model/management stack using _WithShifts
> prop, and suddenly it no longer exists.
In the unlikely case a field name has changed (again it is not the case
here), I guess we could rely on a property alias, update the model version.

Thanks!

Eric
>
>>     IDREG_FIELD_START(ID_ISAR4_EL1, Unpriv, 0, 4)
>>         IDREG_FIELD_ARCH_VAL(0)
>>         IDREG_FIELD_ARCH_VAL(1)
>> @@ -1533,6 +1578,7 @@ IDREG_START(ID_ISAR4_EL1)
>> IDREG_END(ID_ISAR4_EL1)
>>
>> IDREG_START(ID_ISAR5_EL1)
>> +    IDREG_FIELD(ID_ISAR5_EL1, RES0, 32, 32)
>>     IDREG_FIELD_START(ID_ISAR5_EL1, VCMA, 28, 4)
>>         IDREG_FIELD_ARCH_VAL(0)
>>         IDREG_FIELD_ARCH_VAL(1)
>> @@ -1541,6 +1587,7 @@ IDREG_START(ID_ISAR5_EL1)
>>         IDREG_FIELD_ARCH_VAL(0)
>>         IDREG_FIELD_ARCH_VAL(1)
>>     IDREG_FIELD_END(ID_ISAR5_EL1, RDM)
>> +    IDREG_FIELD(ID_ISAR5_EL1, RES0, 20, 4)
>>     IDREG_FIELD_START(ID_ISAR5_EL1, CRC32, 16, 4)
>>         IDREG_FIELD_ARCH_VAL(0)
>>         IDREG_FIELD_ARCH_VAL(1)
>> @@ -1565,6 +1612,7 @@ IDREG_START(ID_ISAR5_EL1)
>> IDREG_END(ID_ISAR5_EL1)
>>
>> IDREG_START(ID_ISAR6_EL1)
>> +    IDREG_FIELD(ID_ISAR6_EL1, RES0, 32, 32)
>>     IDREG_FIELD_START(ID_ISAR6_EL1, CLRBHB, 28, 4)
>>         IDREG_FIELD_ARCH_VAL(0)
>>         IDREG_FIELD_ARCH_VAL(1)
>> @@ -1601,6 +1649,7 @@ IDREG_START(ID_ISAR6_EL1)
>> IDREG_END(ID_ISAR6_EL1)
>>
>> IDREG_START(ID_MMFR0_EL1)
>> +    IDREG_FIELD(ID_MMFR0_EL1, RES0, 32, 32)
>>     IDREG_FIELD_START(ID_MMFR0_EL1, InnerShr, 28, 4)
>>         IDREG_FIELD_ARCH_VAL(0)
>>         IDREG_FIELD_ARCH_VAL(1)
>> @@ -1647,6 +1696,7 @@ IDREG_START(ID_MMFR0_EL1)
>> IDREG_END(ID_MMFR0_EL1)
>>
>> IDREG_START(ID_MMFR1_EL1)
>> +    IDREG_FIELD(ID_MMFR1_EL1, RES0, 32, 32)
>>     IDREG_FIELD_START(ID_MMFR1_EL1, BPred, 28, 4)
>>         IDREG_FIELD_ARCH_VAL(0)
>>         IDREG_FIELD_ARCH_VAL(1)
>> @@ -1695,6 +1745,7 @@ IDREG_START(ID_MMFR1_EL1)
>> IDREG_END(ID_MMFR1_EL1)
>>
>> IDREG_START(ID_MMFR2_EL1)
>> +    IDREG_FIELD(ID_MMFR2_EL1, RES0, 32, 32)
>>     IDREG_FIELD_START(ID_MMFR2_EL1, HWAccFlg, 28, 4)
>>         IDREG_FIELD_ARCH_VAL(0)
>>         IDREG_FIELD_ARCH_VAL(1)
>> @@ -1733,6 +1784,7 @@ IDREG_START(ID_MMFR2_EL1)
>> IDREG_END(ID_MMFR2_EL1)
>>
>> IDREG_START(ID_MMFR3_EL1)
>> +    IDREG_FIELD(ID_MMFR3_EL1, RES0, 32, 32)
>>     IDREG_FIELD_START(ID_MMFR3_EL1, Supersec, 28, 4)
>>         IDREG_FIELD_ARCH_VAL(0)
>>         IDREG_FIELD_ARCH_VAL(15)
>> @@ -1772,6 +1824,7 @@ IDREG_START(ID_MMFR3_EL1)
>> IDREG_END(ID_MMFR3_EL1)
>>
>> IDREG_START(ID_MMFR4_EL1)
>> +    IDREG_FIELD(ID_MMFR4_EL1, RES0, 32, 32)
>>     IDREG_FIELD_START(ID_MMFR4_EL1, EVT, 28, 4)
>>         IDREG_FIELD_ARCH_VAL(0)
>>         IDREG_FIELD_ARCH_VAL(1)
>> @@ -1809,6 +1862,7 @@ IDREG_START(ID_MMFR4_EL1)
>> IDREG_END(ID_MMFR4_EL1)
>>
>> IDREG_START(ID_MMFR5_EL1)
>> +    IDREG_FIELD(ID_MMFR5_EL1, RES0, 8, 56)
>>     IDREG_FIELD_START(ID_MMFR5_EL1, nTLBPA, 4, 4)
>>         IDREG_FIELD_ARCH_VAL(0)
>>         IDREG_FIELD_ARCH_VAL(1)
>> @@ -1822,6 +1876,7 @@ IDREG_START(ID_MMFR5_EL1)
>> IDREG_END(ID_MMFR5_EL1)
>>
>> IDREG_START(ID_PFR0_EL1)
>> +    IDREG_FIELD(ID_PFR0_EL1, RES0, 32, 32)
>>     IDREG_FIELD_START(ID_PFR0_EL1, RAS, 28, 4)
>>         IDREG_FIELD_ARCH_VAL(0)
>>         IDREG_FIELD_ARCH_VAL(1)
>> @@ -1863,6 +1918,7 @@ IDREG_START(ID_PFR0_EL1)
>> IDREG_END(ID_PFR0_EL1)
>>
>> IDREG_START(ID_PFR1_EL1)
>> +    IDREG_FIELD(ID_PFR1_EL1, RES0, 32, 32)
>>     IDREG_FIELD_START(ID_PFR1_EL1, GIC, 28, 4)
>>         IDREG_FIELD_ARCH_VAL(0)
>>         IDREG_FIELD_ARCH_VAL(1)
>> @@ -1902,6 +1958,7 @@ IDREG_START(ID_PFR1_EL1)
>> IDREG_END(ID_PFR1_EL1)
>>
>> IDREG_START(ID_PFR2_EL1)
>> +    IDREG_FIELD(ID_PFR2_EL1, RES0, 12, 52)
>>     IDREG_FIELD_START(ID_PFR2_EL1, RAS_frac, 8, 4)
>>         IDREG_FIELD_ARCH_VAL(0)
>>         IDREG_FIELD_ARCH_VAL(1)
>> @@ -1949,11 +2006,14 @@ IDREG_START(MIDR_EL1)
>> IDREG_END(MIDR_EL1)
>>
>> IDREG_START(MPIDR_EL1)
>> +    IDREG_FIELD(MPIDR_EL1, RES0, 40, 24)
>>     IDREG_FIELD(MPIDR_EL1, Aff3, 32, 8)
>> +    IDREG_FIELD(MPIDR_EL1, RES1, 31, 1)
>>     IDREG_FIELD_START(MPIDR_EL1, U, 30, 1)
>>         IDREG_FIELD_ARCH_VAL(0)
>>         IDREG_FIELD_ARCH_VAL(1)
>>     IDREG_FIELD_END(MPIDR_EL1, U)
>> +    IDREG_FIELD(MPIDR_EL1, RES0, 25, 5)
>>     IDREG_FIELD_START(MPIDR_EL1, MT, 24, 1)
>>         IDREG_FIELD_ARCH_VAL(0)
>>         IDREG_FIELD_ARCH_VAL(1)
>> @@ -1964,6 +2024,7 @@ IDREG_START(MPIDR_EL1)
>> IDREG_END(MPIDR_EL1)
>>
>> IDREG_START(MVFR0_EL1)
>> +    IDREG_FIELD(MVFR0_EL1, RES0, 32, 32)
>>     IDREG_FIELD_START(MVFR0_EL1, FPRound, 28, 4)
>>         IDREG_FIELD_ARCH_VAL(0)
>>         IDREG_FIELD_ARCH_VAL(1)
>> @@ -2002,6 +2063,7 @@ IDREG_START(MVFR0_EL1)
>> IDREG_END(MVFR0_EL1)
>>
>> IDREG_START(MVFR1_EL1)
>> +    IDREG_FIELD(MVFR1_EL1, RES0, 32, 32)
>>     IDREG_FIELD_START(MVFR1_EL1, SIMDFMAC, 28, 4)
>>         IDREG_FIELD_ARCH_VAL(0)
>>         IDREG_FIELD_ARCH_VAL(1)
>> @@ -2040,6 +2102,7 @@ IDREG_START(MVFR1_EL1)
>> IDREG_END(MVFR1_EL1)
>>
>> IDREG_START(MVFR2_EL1)
>> +    IDREG_FIELD(MVFR2_EL1, RES0, 8, 56)
>>     IDREG_FIELD_START(MVFR2_EL1, FPMisc, 4, 4)
>>         IDREG_FIELD_ARCH_VAL(0)
>>         IDREG_FIELD_ARCH_VAL(1)
>> @@ -2059,6 +2122,7 @@ IDREG_START(REVIDR_EL1)
>> IDREG_END(REVIDR_EL1)
>>
>> IDREG_START(SMIDR_EL1)
>> +    IDREG_FIELD(SMIDR_EL1, RES0, 60, 4)
>>     IDREG_FIELD_START(SMIDR_EL1, NSMC, 56, 4)
>>         IDREG_FIELD_ARCH_VAL(0)
>>         IDREG_FIELD_ARCH_VAL(15)
>> @@ -2094,6 +2158,7 @@ IDREG_START(SMIDR_EL1)
>>         IDREG_FIELD_ARCH_VAL(2)
>>         IDREG_FIELD_ARCH_VAL(3)
>>     IDREG_FIELD_END(SMIDR_EL1, SH)
>> +    IDREG_FIELD(SMIDR_EL1, RES0, 12, 1)
>>     IDREG_FIELD(SMIDR_EL1, Affinity, 0, 12)
>> IDREG_END(SMIDR_EL1)
>>
>> diff --git a/scripts/update-aarch64-cpu-sysreg-properties.py b/scripts/update-aarch64-cpu-sysreg-properties.py
>> index e1d6c4afef..9e829fda2e 100644
>> --- a/scripts/update-aarch64-cpu-sysreg-properties.py
>> +++ b/scripts/update-aarch64-cpu-sysreg-properties.py
>> @@ -81,9 +81,13 @@ def collect_fields(item, bit_offset=0):
>>
>>     # Normal Field Types
>>     leaf_types = ['Fields.Field', 'Fields.ConstantField',
>> -                  'Fields.EnumeratedField', 'Fields.Bitfield']
>> +                  'Fields.EnumeratedField', 'Fields.Bitfield', 'Fields.Reserved']
>>     if _type in leaf_types:
>>         field_copy = item.copy()
>> +
>> +        if _type == 'Fields.Reserved' and not field_copy.get('name'):
>> +            field_copy['name'] = item.get('value', 'RES0')
>> +
>>         if field_copy.get('rangeset'):
>>             new_ranges = []
>>             for r in field_copy['rangeset']:
>> @@ -96,7 +100,7 @@ def collect_fields(item, bit_offset=0):
>>         return fields
>>
>>     # Traverse the hierarchy for other cases
>> -    for key in ['fields', 'values', 'fieldsets']:
>> +    for key in ['fields', 'values', 'fieldsets', 'constants']:
>>         for nested in item.get(key, []):
>>             fields.extend(collect_fields(nested, bit_offset))
>>
>> @@ -163,44 +167,95 @@ def generate_sysreg_properties_from_registers_json(id_reg_names, raw_json_path):
>>
>>         final_output += f"IDREG_START({reg_name})\n"
>>
>> -        unique_fields = {}
>> +        fieldset_variants = []
>> +
>>         for fieldset in register.get('fieldsets', []):
>> +            current_fieldset_fields = {}
>>             candidates = collect_fields(fieldset)
>> +
>>             for val in candidates:
>> -                name = (val.get('name') or val.get('label', '')).strip()
>> -                if not name or "RESERVED" in name.upper():
>> +                raw_name = val.get('name') or val.get('label') or val.get('value') or ''
>> +                name = raw_name.strip()
>> +                if not name:
>>                     continue
>> +
>> +                name_upper = name.upper()
>> +
>> +                # Check for architectural target states, including UNKNOWN remapping
>> +                base_reserved = None
>> +                for r_type in ["RES0", "RES1", "RAZ", "RAO", "WI", "UNKNOWN"]:
>> +                    if r_type in name_upper:
>> +                        base_reserved = "RES0" if r_type == "UNKNOWN" else r_type
>> +                        break
>> +
>> +                is_valid_reserved = base_reserved is not None
>> +                if "RESERVED" in name_upper and not is_valid_reserved:
>> +                    continue
>> +
>> +                # Force naming uniformity across padding blocks
>> +                if is_valid_reserved:
>> +                    name = base_reserved
>> +
>>                 for r in val.get('rangeset', []):
>>                     lsb = int(r.get('start'))
>>                     width = r.get('width')
>>                     msb = lsb + int(width) - 1
>>
>> -                    # Only keep the fields with the highest MSB
>> -                    # needed fir CCSIDR_EL1
>> -                    if name not in unique_fields or msb > unique_fields[name]['msb']:
>> -                        # extract enum values if any
>> +                    if is_valid_reserved:
>> +                        unique_key = f"{name}_{lsb}"
>> +                    else:
>> +                        unique_key = name
>> +
>> +                    if unique_key not in current_fieldset_fields or \
>> +                       msb > current_fieldset_fields[unique_key]['msb']:
>>                         enums = extract_field_enums(val)
>> -                        unique_fields[name] = {'lsb': lsb, 'msb': msb, 'width': width, 'enums': enums}
>> +                        current_fieldset_fields[unique_key] = {
>> +                            'raw_name': name,
>> +                            'lsb': lsb,
>> +                            'msb': msb,
>> +                            'width': width,
>> +                            'enums': enums
>> +                        }
>> +
>> +            if current_fieldset_fields:
>> +                fieldset_variants.append(current_fieldset_fields)
>> +
>> +        best_fieldset = {}
>> +        max_total_width = -1
>> +
>> +        for variant in fieldset_variants:
>> +            total_width = sum(f['width'] for f in variant.values())
>> +            # prioritize layout variants with the highest MSB coverage
>> +            max_msb = max(f['msb'] for f in variant.values()) if variant else 0
>> +
>> +            # Combine width and max_msb into a fitness score tuple
>> +            if (total_width, max_msb) > (max_total_width, max_total_width):
>> +                max_total_width = total_width
>> +                best_fieldset = variant
>> +
>> +        unique_fields = best_fieldset
>>
>>         # Sort decreasing lsbs
>>         sorted_fields = sorted(unique_fields.items(),
>>                                key=lambda x: x[1]['lsb'], reverse=True)
>>
>> -        for name, bits in sorted_fields:
>> +        for unique_key, bits in sorted_fields:
>>             enums_list = bits.get('enums', [])
>>
>> +            clean_name = bits.get('raw_name', unique_key)
>> +
>>             if enums_list:
>>                line = (f"    IDREG_FIELD_START({reg_name}, "
>> -                       f"{name}, {bits['lsb']}, {bits['width']})\n")
>> +                       f"{clean_name}, {bits['lsb']}, {bits['width']})\n")
>>             else:
>>                line = (f"    IDREG_FIELD({reg_name}, "
>> -                       f"{name}, {bits['lsb']}, {bits['width']})\n")
>> +                       f"{clean_name}, {bits['lsb']}, {bits['width']})\n")
>>             final_output += line
>>             # add the enum value definition if any
>>             for enum_item in enums_list:
>>                 final_output += (f"        IDREG_FIELD_ARCH_VAL({enum_item['value']})\n")
>>             if enums_list:
>> -               line = (f"    IDREG_FIELD_END({reg_name}, {name})\n")
>> +               line = (f"    IDREG_FIELD_END({reg_name}, {clean_name})\n")
>>                final_output += line
>>
>>         final_output += f"IDREG_END({reg_name})\n"
>> -- 
>> 2.53.0
>>


