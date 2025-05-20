Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11C3CC3ABDD
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 06:18:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHGI9-00088o-Tl; Tue, 20 May 2025 02:17:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uHGI2-00087J-0R
 for qemu-devel@nongnu.org; Tue, 20 May 2025 02:17:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uHGHz-0003gs-Jl
 for qemu-devel@nongnu.org; Tue, 20 May 2025 02:17:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747721841;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=R+Nl11R3tXr1PDaWPyXbj+MD479gg7IoF69Ji6zkV5c=;
 b=AwmSUkcz7pIpfWcnUE5XLsSRzyongCcxPMc8dblcY93oDRkihZBZXG0Z2BiTfxQNttu1bw
 vYK5qhrQ6F1ec2rt5h1LkYU7A/ioOq16VnPst37FYcy/B3d2wekC9Z85477yVMeO6xgro+
 rvdlheIFDfzh0OF5H8fiCF19iCyRg1s=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-9HA18j1-NoK0r9avdjSnmg-1; Tue, 20 May 2025 02:17:19 -0400
X-MC-Unique: 9HA18j1-NoK0r9avdjSnmg-1
X-Mimecast-MFC-AGG-ID: 9HA18j1-NoK0r9avdjSnmg_1747721838
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-601aa0cb934so1975510a12.3
 for <qemu-devel@nongnu.org>; Mon, 19 May 2025 23:17:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747721838; x=1748326638;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=R+Nl11R3tXr1PDaWPyXbj+MD479gg7IoF69Ji6zkV5c=;
 b=XCk4I3+NC77HATCNZoBxMuOvdDLtAsb9aZVCJlPJNOF/HZXlF0x5o1/+UTT5CKR9w6
 iTTprWPc68HNBffdNhVjNWJ6rxvBvfuIkWy4IetlkKt8XKzpPGvVGcXibxl6vd4om5LE
 fWxjorIpfkmS9aat4Dz8cUKliB6oaDIZfl1v2Pno7tLbqXGRXSJ2ADBs42LWhNYYI622
 KteX+LCK9jDaC5y5hJ0IMz5G37vqcv5rAn+CspjOOGDyPNStODBd6NNq4n7gJThnAxxQ
 89Vd8Z72/WK+pX5NHExWwBZoEietjAMp8PAtk98zsdrTjfgVjy2s+fLuuCeBzy9WSk/f
 At8g==
X-Gm-Message-State: AOJu0YxwDyRhKdKguFJwAwJR7N3oONU6uc7yHmG207xB3mMgSHMtthnR
 U0bLwLfuSjidx4upE7aAaY8wm2KdfGmZagCMdRHQIzCNuhxSN43BL2FebSFGYzQeIKK3E8ft8ML
 ZJmK7d4b6kIGNIM5Kj4q5IQAgVoMZSMZIOCCx3zPhw5LsSpM3smOSyAumi/XvsJq6
X-Gm-Gg: ASbGncvTI5Qtkx0j96+gAWaYlvmHWXjHUF+nesQ+mjawW5cltqiXSA2YybfrpaBuEFu
 Z0C1kPIMtf2yoaYSNBuwZocBHRfwfMIJ9b8TTgv5+ItqXHK/tmf6UIhqCmRRSrABCm4g5XJSwlc
 7EcGjTvLJbGWqhMbsDhOBrrEczQJICVbwghSrSkD5LemPAMPIVhOL2Y6Tbu4UyQOVghIDBC3Atq
 Zfe00tEnH49TCDO77Fj/C93QJO+V1xIecNUIS5110oJbIN1qBaw5pxL0hW8UOtW4myaIigF7twe
 aF+D8uHRgiNeFA==
X-Received: by 2002:a05:6402:26c9:b0:600:2af6:d942 with SMTP id
 4fb4d7f45d1cf-601140b3b5cmr13826870a12.15.1747721837769; 
 Mon, 19 May 2025 23:17:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHTYy3QvpSpz2J7a66UBMBJnqfsIhEjgyS3bwqZXuvSPuoUxOjlPilRpLh5mxbe38JCYtAB/w==
X-Received: by 2002:a05:6402:26c9:b0:600:2af6:d942 with SMTP id
 4fb4d7f45d1cf-601140b3b5cmr13826854a12.15.1747721837395; 
 Mon, 19 May 2025 23:17:17 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.46.79])
 by smtp.googlemail.com with ESMTPSA id
 4fb4d7f45d1cf-6005ae39175sm6736493a12.69.2025.05.19.23.17.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 May 2025 23:17:16 -0700 (PDT)
Message-ID: <4ac19730-87b8-44b8-a3fc-9942c3423918@redhat.com>
Date: Tue, 20 May 2025 08:17:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/26] target/riscv: SATP mode and CPU definition
 overhaul
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-devel@nongnu.org, dbarboza@ventanamicro.com,
 richard.henderson@linaro.org
References: <20250512095226.93621-1-pbonzini@redhat.com>
 <CAKmqyKOomS2NsO=7V5AhxURjSMkEDiQ0k7t59KqYq=FqJDW=Rg@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <CAKmqyKOomS2NsO=7V5AhxURjSMkEDiQ0k7t59KqYq=FqJDW=Rg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.13,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

On 5/15/25 08:05, Alistair Francis wrote:
> On Mon, May 12, 2025 at 7:53 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>> Same as v4, with suggestion from Richard to avoid parentheses---which also
>> fixes the issue with kvm-cpu.c reported by Daniel Barboza.  KVM/RISC-V is
>> now covered in CI and passes with this version.
>>
>> Paolo
>>
>> Paolo Bonzini (26):
>>    target/riscv: assert argument to set_satp_mode_max_supported is valid
>>    target/riscv: cpu: store max SATP mode as a single integer
>>    target/riscv: update max_satp_mode based on QOM properties
>>    target/riscv: remove supported from RISCVSATPMap
>>    target/riscv: move satp_mode.{map,init} out of CPUConfig
>>    target/riscv: introduce RISCVCPUDef
>>    target/riscv: store RISCVCPUDef struct directly in the class
>>    target/riscv: merge riscv_cpu_class_init with the class_base function
>>    target/riscv: move RISCVCPUConfig fields to a header file
>>    target/riscv: include default value in cpu_cfg_fields.h.inc
>>    target/riscv: add more RISCVCPUDef fields
>>    target/riscv: convert abstract CPU classes to RISCVCPUDef
>>    target/riscv: convert profile CPU models to RISCVCPUDef
>>    target/riscv: convert bare CPU models to RISCVCPUDef
>>    target/riscv: convert dynamic CPU models to RISCVCPUDef
>>    target/riscv: convert SiFive E CPU models to RISCVCPUDef
>>    target/riscv: convert ibex CPU models to RISCVCPUDef
>>    target/riscv: convert SiFive U models to RISCVCPUDef
>>    target/riscv: th: make CSR insertion test a bit more intuitive
>>    target/riscv: generalize custom CSR functionality
>>    target/riscv: convert TT C906 to RISCVCPUDef
>>    target/riscv: convert TT Ascalon to RISCVCPUDef
>>    target/riscv: convert Ventana V1 to RISCVCPUDef
>>    target/riscv: convert Xiangshan Nanhu to RISCVCPUDef
>>    target/riscv: remove .instance_post_init
>>    qom: reverse order of instance_post_init calls
> 
> This doesn't seem to have made it through to Patchew for some reason:
> https://patchew.org/search?q=SATP+mode+and+CPU+definition+overhaul

Yes, mailman decided to unsubscribe Patchew on Friday and I was only 
able to resubscribe on Monday. :/

Paolo


