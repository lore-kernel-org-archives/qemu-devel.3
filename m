Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 760ABC02198
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 09:31:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkJwC-0006TC-Pb; Tue, 18 Feb 2025 04:30:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tkJw4-0006SD-4K
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 04:30:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tkJvu-0000ZG-3f
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 04:30:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739871023;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=fKxbREbYYut+UzJL+lxoM94dklK9mlMdBL1wz8/W0EM=;
 b=IEG0vsrEcDDzVP0jvr5rlAEzuqkLSQ/P+P/0VvGdkxJ2Eva+1ceVte53a6lXrZJCTb4c1R
 lCIM3UmzAQGmXT8m+8oosOXwuUkGbieh4xs3q1opgIfxWQ/amEYnQUaiLB9wF/3UmcJTxR
 XXWncDlZ3UngN5h8JwC7jsWrnh32iY4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-475-bs8xyhT0Ob6a-B4WvAwJgg-1; Tue, 18 Feb 2025 04:30:22 -0500
X-MC-Unique: bs8xyhT0Ob6a-B4WvAwJgg-1
X-Mimecast-MFC-AGG-ID: bs8xyhT0Ob6a-B4WvAwJgg_1739871021
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4393e873962so28534255e9.3
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2025 01:30:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739871021; x=1740475821;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fKxbREbYYut+UzJL+lxoM94dklK9mlMdBL1wz8/W0EM=;
 b=mE+x/B83lzjeSZGbuPn8MPbF94/mwt31+OYysf1nzwza+4N5neiMK/xVMTJKcfVwTN
 3i5PCI5aWo09mn2Z7ZXGITr3pYmaQODMmR/OhEfy6zU18upAyNo4UWcRXqrYUuWWj/80
 RVWqvoZCzQRVncIOQODawkojZC7BWUisGNxvqhSQUHI8/IwcctP3MEOHWvGOR+boHt5W
 5ULHpWyM5LH80Qp20EUki2+uyvHH3FhxBZJY2cUoWjbiCyph/EIh9P+oPg7Khyb5AA0o
 LTGkYo/Nmx2g7xhKtvtdC7nMpuPv6mK+9ugQ/jaqKNfakjL4NX0c3WfClbEvRhWESPlS
 s5TQ==
X-Gm-Message-State: AOJu0YytyXkuaPkqvhbIToWmxuMosNpeBoS5UfypnSP4QVS0wpF+oOvc
 WL2MLPJOe4ZgIb/E1dw+3EHbZu0M2A5+Ml513huvKNHCAtKreTwRXnDUjwQrEXGUpvHrGvPj53s
 BS4tIod7DrdkqTSIREWJw9LAKbYFFpt8Grqxso5TLjItekGAs1I4j
X-Gm-Gg: ASbGncsQVCV0GMFGNeveOw/JKSoC6JRJSVAfrz1ULVP/NFPVWc2b4Q0cc8CqktIEIqh
 SUXuO8ujlQFENLmjX+JrRvBbdPimlw4oL3PzYusYzBLEgYVwjcq7nK/tSxfv2H+w5WJvof9vbik
 k4hJwHfz9PPisWhN1IbouAu/6rbCG5FvKPf+wpkUlnqXsqycZS5m8LAcy+RNTniCWqHqTxv2euX
 0oecI1RfKFiMLEE+Lmmij1UoIGAT+MVFRFlkHRWnq0bsBl5b8Po8CfKu3IHA7BG95fJ1UuDJaJA
 ONFfQMxj5sg=
X-Received: by 2002:a05:600c:470a:b0:434:f5c0:328d with SMTP id
 5b1f17b1804b1-4396e752a98mr114863135e9.23.1739871020876; 
 Tue, 18 Feb 2025 01:30:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEoLZqvcpCETBLrHseQsw1T8dvPlao5k4MSApjE4pKB/trIUBiEN16ptYEbh5UxHeSjrpnbIg==
X-Received: by 2002:a05:600c:470a:b0:434:f5c0:328d with SMTP id
 5b1f17b1804b1-4396e752a98mr114862855e9.23.1739871020481; 
 Tue, 18 Feb 2025 01:30:20 -0800 (PST)
Received: from [192.168.10.81] ([176.206.122.109])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-439858ec5fasm49436255e9.29.2025.02.18.01.30.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Feb 2025 01:30:19 -0800 (PST)
Message-ID: <be838a82-6ca5-4e28-99c5-23e88c17c84e@redhat.com>
Date: Tue, 18 Feb 2025 10:30:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/22] target/riscv: add more RISCVCPUDef fields
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-devel@nongnu.org, alistair.francis@wdc.com
References: <20250206182711.2420505-1-pbonzini@redhat.com>
 <20250206182711.2420505-7-pbonzini@redhat.com>
 <CAKmqyKN2Og+uA00i8a_WMVV_885iU8uw7stoxRRS7VoGLrRONA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <CAKmqyKN2Og+uA00i8a_WMVV_885iU8uw7stoxRRS7VoGLrRONA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 2/18/25 01:23, Alistair Francis wrote:
> On Fri, Feb 7, 2025 at 4:29 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>> Allow using RISCVCPUDef to replicate all the logic of custom .instance_init
>> functions.  To simulate inheritance, merge the child's RISCVCPUDef with
>> the parent and then finally move it to the CPUState at the end of
>> TYPE_RISCV_CPU's own instance_init function.
>>
>> STRUCT_FIELD is introduced here because I am not sure it is needed;
>> it is a bit ugly and I wanted not to have it in the patch that
>> introduces cpu_cfg_fields.h.inc.  I don't really understand why satp_mode
>> is included in RISCVCPUConfig; therefore, the end of the series includes
> 
> I don't follow. `satp_mode` is a configurable option, hence the
> inclusion in `RISCVCPUConfig`

My understanding is that satp_mode is a combination of:

- the maximum supported satp mode; this is stored in 
cpu->satp_modes.supported and actually comes from the instance_init 
function.

- the value of the properties, which is stored in satp_map->map and 
satp_map->init

For non-bare CPU models, including all vendor CPU models, 
cpu->satp_modes.supported also acts as the default value for the mode 
properties.  Furthermore, for all vendor CPU models all modes are 
supported up to the max mode, for example you never have a CPU that 
supports sv48 but not sv39.

So it seems that the CPU config is really the supported satp modes, it's 
just bare CPU models that have the further restriction that you have to 
specify at least one mode by hand.  Under this interpretation:

- all that needs to be in RISCVCPUConfig is what I called satp_mode32 
and satp_mode64

- satp_mode32 or satp_mode64 therefore can be removed from RISCVCPUDef

- init and map would be moved to RISCVCPU because they are purely a QOM 
concept

Paolo

> Alistair
> 
>> a patch to move satp_mode directly in RISCVCPU, thus removing the need
>> for STRUCT_FIELD; it can be moved before this one in a non-RFC posting.
>>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>   target/riscv/cpu.h                |  6 ++++
>>   target/riscv/cpu_cfg.h            |  1 +
>>   target/riscv/cpu_cfg_fields.h.inc |  6 +++-
>>   target/riscv/cpu.c                | 48 ++++++++++++++++++++++++++++++-
>>   4 files changed, 59 insertions(+), 2 deletions(-)
>>
>> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
>> index f757f0b6210..9b25c0c889b 100644
>> --- a/target/riscv/cpu.h
>> +++ b/target/riscv/cpu.h
>> @@ -519,6 +519,12 @@ struct ArchCPU {
>>
>>   typedef struct RISCVCPUDef {
>>       RISCVMXL misa_mxl_max;  /* max mxl for this cpu */
>> +    uint32_t misa_ext;
>> +    int priv_spec;
>> +    int32_t vext_spec;
>> +    int satp_mode32;
>> +    int satp_mode64;
>> +    RISCVCPUConfig cfg;
>>   } RISCVCPUDef;
>>
>>   /**
>> diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
>> index ad02693fa66..07789a9de88 100644
>> --- a/target/riscv/cpu_cfg.h
>> +++ b/target/riscv/cpu_cfg.h
>> @@ -39,6 +39,7 @@ typedef struct {
>>   struct RISCVCPUConfig {
>>   #define BOOL_FIELD(x) bool x;
>>   #define TYPED_FIELD(type, x) type x;
>> +#define STRUCT_FIELD(type, x) type x;
>>   #include "cpu_cfg_fields.h.inc"
>>   };
>>
>> diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
>> index 56fffb5f177..cbedf0a703b 100644
>> --- a/target/riscv/cpu_cfg_fields.h.inc
>> +++ b/target/riscv/cpu_cfg_fields.h.inc
>> @@ -4,6 +4,9 @@
>>   #ifndef TYPED_FIELD
>>   #define TYPED_FIELD(type, x)
>>   #endif
>> +#ifndef STRUCT_FIELD
>> +#define STRUCT_FIELD(type, x)
>> +#endif
>>
>>   BOOL_FIELD(ext_zba)
>>   BOOL_FIELD(ext_zbb)
>> @@ -160,8 +163,9 @@ TYPED_FIELD(uint16_t, cbop_blocksize)
>>   TYPED_FIELD(uint16_t, cboz_blocksize)
>>
>>   #ifndef CONFIG_USER_ONLY
>> -TYPED_FIELD(RISCVSATPMap, satp_mode);
>> +STRUCT_FIELD(RISCVSATPMap, satp_mode)
>>   #endif
>>
>>   #undef BOOL_FIELD
>>   #undef TYPED_FIELD
>> +#undef STRUCT_FIELD
>> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
>> index baf4dd017b2..1d999488465 100644
>> --- a/target/riscv/cpu.c
>> +++ b/target/riscv/cpu.c
>> @@ -74,6 +74,15 @@ bool riscv_cpu_option_set(const char *optname)
>>       return g_hash_table_contains(general_user_opts, optname);
>>   }
>>
>> +static void riscv_cpu_cfg_merge(RISCVCPUConfig *dest, RISCVCPUConfig *src)
>> +{
>> +#define BOOL_FIELD(x) dest->x |= src->x;
>> +#define TYPED_FIELD(type, x) if (src->x) dest->x = src->x;
>> +    /* only satp_mode, which is initialized by instance_init */
>> +#define STRUCT_FIELD(type, x)
>> +#include "cpu_cfg_fields.h.inc"
>> +}
>> +
>>   #define ISA_EXT_DATA_ENTRY(_name, _min_ver, _prop) \
>>       {#_name, _min_ver, CPU_CFG_OFFSET(_prop)}
>>
>> @@ -432,7 +441,7 @@ const char *satp_mode_str(uint8_t satp_mode, bool is_32_bit)
>>   }
>>
>>   static void set_satp_mode_max_supported(RISCVCPU *cpu,
>> -                                        uint8_t satp_mode)
>> +                                        int satp_mode)
>>   {
>>       bool rv32 = riscv_cpu_mxl(&cpu->env) == MXL_RV32;
>>       const bool *valid_vm = rv32 ? valid_vm_1_10_32 : valid_vm_1_10_64;
>> @@ -1476,6 +1485,24 @@ static void riscv_cpu_init(Object *obj)
>>       cpu->cfg.cbop_blocksize = 64;
>>       cpu->cfg.cboz_blocksize = 64;
>>       cpu->env.vext_ver = VEXT_VERSION_1_00_0;
>> +
>> +    env->misa_ext_mask = env->misa_ext = mcc->def->misa_ext;
>> +    riscv_cpu_cfg_merge(&cpu->cfg, &mcc->def->cfg);
>> +
>> +    if (mcc->def->priv_spec != RISCV_PROFILE_ATTR_UNUSED) {
>> +        cpu->env.priv_ver = mcc->def->priv_spec;
>> +    }
>> +    if (mcc->def->vext_spec != RISCV_PROFILE_ATTR_UNUSED) {
>> +        cpu->env.vext_ver = mcc->def->vext_spec;
>> +    }
>> +#ifndef CONFIG_USER_ONLY
>> +    if (riscv_cpu_mxl(env) == MXL_RV32 && mcc->def->satp_mode32 != RISCV_PROFILE_ATTR_UNUSED) {
>> +        set_satp_mode_max_supported(RISCV_CPU(obj), mcc->def->satp_mode32);
>> +    }
>> +    if (riscv_cpu_mxl(env) >= MXL_RV64 && mcc->def->satp_mode64 != RISCV_PROFILE_ATTR_UNUSED) {
>> +        set_satp_mode_max_supported(RISCV_CPU(obj), mcc->def->satp_mode64);
>> +    }
>> +#endif
>>   }
>>
>>   static void riscv_bare_cpu_init(Object *obj)
>> @@ -2968,6 +2995,25 @@ static void riscv_cpu_class_base_init(ObjectClass *c, void *data)
>>               assert(def->misa_mxl_max <= MXL_RV128);
>>               mcc->def->misa_mxl_max = def->misa_mxl_max;
>>           }
>> +        if (def->priv_spec != RISCV_PROFILE_ATTR_UNUSED) {
>> +            assert(def->priv_spec <= PRIV_VERSION_LATEST);
>> +            mcc->def->priv_spec = def->priv_spec;
>> +        }
>> +        if (def->vext_spec != RISCV_PROFILE_ATTR_UNUSED) {
>> +            assert(def->vext_spec != 0);
>> +            mcc->def->vext_spec = def->vext_spec;
>> +        }
>> +        if (def->satp_mode32 != RISCV_PROFILE_ATTR_UNUSED) {
>> +            assert(def->satp_mode32 <= VM_1_10_SV32);
>> +            mcc->def->satp_mode32 = def->satp_mode32;
>> +        }
>> +        if (def->satp_mode64 != RISCV_PROFILE_ATTR_UNUSED) {
>> +            assert(def->satp_mode64 <= VM_1_10_SV64);
>> +            mcc->def->satp_mode64 = def->satp_mode64;
>> +        }
>> +        mcc->def->misa_ext |= def->misa_ext;
>> +
>> +        riscv_cpu_cfg_merge(&mcc->def->cfg, &def->cfg);
>>       }
>>
>>       if (!object_class_is_abstract(c)) {
>> --
>> 2.48.1
>>
>>
> 
> 


