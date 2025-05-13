Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86E82C3ABCC
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 15:30:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uErZs-0007P7-Hk; Tue, 13 May 2025 11:29:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uErZo-0007On-Sg
 for qemu-devel@nongnu.org; Tue, 13 May 2025 11:29:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uErZm-0006UG-SR
 for qemu-devel@nongnu.org; Tue, 13 May 2025 11:29:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747150189;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n3SV9RrB4pXNYv42wcSIPomPi1fFx4e4cmy7nDRktu8=;
 b=Y8N/NSRIWjpTa3xCMrcq0oeZ3pYgRGHxz2BHPdF2W1KCAEZxH2k6vQuRRi2ozq6avnAd1Q
 te60/kKJ9uqnJS6Eo690cVp5wxDhkpFO7qftjeg0gCWss2++rqEagzWDfpLbnp2s52b8t5
 REtt9jihOPdWVZml7pnMW/AP5qMYNWM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-385-dIyIBkDxPkOJHbZqcpyLdQ-1; Tue, 13 May 2025 11:29:48 -0400
X-MC-Unique: dIyIBkDxPkOJHbZqcpyLdQ-1
X-Mimecast-MFC-AGG-ID: dIyIBkDxPkOJHbZqcpyLdQ_1747150187
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3a0bcaf5f45so1840008f8f.1
 for <qemu-devel@nongnu.org>; Tue, 13 May 2025 08:29:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747150187; x=1747754987;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=n3SV9RrB4pXNYv42wcSIPomPi1fFx4e4cmy7nDRktu8=;
 b=BCPZ4BwVFfpXR5gOEnuLlhYZ+tcQ1wYvMDVn2UUgdrsnZiK+Skz+LdfY+gE4uoV9hC
 nWKQ1nzmduiWdzsjTJH6qxuGoZJh6gAf8Sx1a9FjAawtDaeU8M4O49XaY0UP8TYroPt/
 XUeBcI3/0KUoZxtUkZiVcsU546ceN27nZJapukawiTN+6uxjLlKDDbJZ2DNyaW8i9d0j
 jKU00ButuS1u5n8p3JqMk0pcH3YUxBRS0q9T85ZPiOpZhZaA5QT/L6cDLY6+z9p4rFd6
 NqtTOUnmZgYFbHAzAx6ds6g8ndTjTid1+yAC5GlW7wv6ldvskomkugVt92zTDehxuquo
 x9yQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2mBWr2iKiUBjQHjhdXjanoXBS/5XuddTr/gquKHD119GtAt32hlDmYgCpKq3V7hc+h8zstZIUvLAo@nongnu.org
X-Gm-Message-State: AOJu0YwymNDXuSwPXS01Tnlbi2ApVk67yNBzGKLtjqMrM6gWkP7MbHGt
 5cce+NWG4/W0qE8WySaykEAhmYORSAB/hj4pYVxZw/sxKVbktTLMSw6jLBRd6vKFBVBnuMbNcIo
 HHN9aWdQGhoQMJurUOPcPCr/sYWHkrQJ7Tc0RbX8vvgyIkIIgeTBH
X-Gm-Gg: ASbGncs9pHrwm8aieQ9vK8ROgUYPkhjY85qIQ+dH89rF/F9nIOmVFC8cZZsXCLKwxid
 NZFieC5mYhDXYip0Qbnf074jcMHw5pWXMJspGl4xa6wNqX8OF0j6Cb4FOOnGR+jWvr0+1zYcAn7
 sGUYvCj7jRGjtntHBV+A4CzMzJA07SP7FR6OBX6Vd/4tRE68KUGDz7RTqv40SfdZEMblagvCg2r
 HJaLfiUaBbVTfPUynsfFwHweJuckopyH4vyRk18z1ktmHlAHEmFUwJRejpEQD2epn05K7KwQEzt
 ni+i5GCy1KrAofaLJAUu9W+YiEwolRPBiq+mbeSXXdg9Ie5pKDhPukKD5Ik=
X-Received: by 2002:a5d:650b:0:b0:3a1:f655:c5b2 with SMTP id
 ffacd0b85a97d-3a1f655c5femr12607481f8f.39.1747150186965; 
 Tue, 13 May 2025 08:29:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6BYhz3sS/2QCPLewK9ErS8eQbRmCxmvRhFud2ois3UN8iIw2F7w+3qHCqvVGzq9QngAQ0gA==
X-Received: by 2002:a5d:650b:0:b0:3a1:f655:c5b2 with SMTP id
 ffacd0b85a97d-3a1f655c5femr12607460f8f.39.1747150186559; 
 Tue, 13 May 2025 08:29:46 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a1f58ebe00sm16888782f8f.38.2025.05.13.08.29.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 May 2025 08:29:45 -0700 (PDT)
Message-ID: <dadc4acd-97c8-4647-9467-89cd1966a6f2@redhat.com>
Date: Tue, 13 May 2025 17:29:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/10] kvm/arm: Introduce a customizable aarch64 KVM
 host model
Content-Language: en-US
To: Cornelia Huck <cohuck@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvmarm@lists.linux.dev,
 peter.maydell@linaro.org, richard.henderson@linaro.org,
 alex.bennee@linaro.org, maz@kernel.org, oliver.upton@linux.dev,
 sebott@redhat.com, shameerali.kolothum.thodi@huawei.com, armbru@redhat.com,
 berrange@redhat.com, abologna@redhat.com, jdenemar@redhat.com
Cc: agraf@csgraf.de, shahuang@redhat.com, mark.rutland@arm.com,
 philmd@linaro.org, pbonzini@redhat.com
References: <20250414163849.321857-1-cohuck@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250414163849.321857-1-cohuck@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.549,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi,

On 4/14/25 6:38 PM, Cornelia Huck wrote:
> [This is on top of v5 of the ID register storage rework:
> https://lore.kernel.org/qemu-devel/20250409144304.912325-1-cohuck@redhat.com/T/#t]
>
> It's been a while, but here's finally a respin of the series to make ID
> registers configurable directly via the command line.
>
> Major changes from v2 include:
> - split out the rework of ID register storage (see above) and rebased on top
>   of that
> - hopefully improved the documentation
> - fixed some bugs along the way (including output of the cpu model expansion
>   command, and compilation with HVF on)
>
> Decided against zeroing unknown registers; it's mostly a "dammed if you do,
> dammed if you don't" situation as one case or the other will not quite work
> as desired, even disregarding fields like AA64PFR1_EL1.MTE_frac where 0
> might indicate things we do not support. You'll need to be careful when
> doing kernel updates and be explicit with configuring fields.
This is not totally clear to me. Is it possible to come with examples
and also derive some guidelines to avoid pitfalls? I guess this kind of
aknowledgement can be scary.
>
> The current cpu properties stay as they are; we can work on converting them
> to compatibility props once we have support for configuring the ID register
> fields on the command line for the other accelerators (this is still KVM only.)

At least what can we do to make sure they are not inconsistent and work
well together. Looks like a must have before being non RFC.
>
> The FEAT_xxx features only support a subset of what we need to configure in
> real life; for example, different AltraMax machines differ in CTR_EL0, which
> is not covered by any FEAT_. It might make sense to provide them as syntactic
> sugar on top.

I agree that anyway we will need an ID reg field granularity for some
real life cases. On top of that we shall try to build higher level props
matching to features as requested by an overwhelming majority in earlier
comments.
>
> We still have to deal with MIDR/REVIDR/AIDR differences by exploiting
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit?id=d300b0168ea8fd5022a1413bd37ab63f4e5a7d4d
> (in a different series.)
Shameer, do you plan to contribute the qemu integration of this feature
you developped on kernel side; or do you allow us to integrate it in
this series?

Thanks

Eric
>
> I have not ignored the issue of named models on Arm, I just wanted to get the
> base infrastructure into place first :)
>
> Real world example (migration Graviton 3 -> 4, thx to Sebastian):
>
> -cpu host,pauth=off,SYSREG_ID_AA64PFR0_EL1_SEL2=0,SYSREG_ID_AA64PFR0_EL1_EL0=1,
>  SYSREG_ID_AA64ISAR0_EL1_TLB=0,SYSREG_ID_AA64ISAR0_EL1_TS=0,
>  SYSREG_ID_AA64ISAR0_EL1_SM4=0,SYSREG_ID_AA64ISAR0_EL1_SM3=0,
>  SYSREG_ID_AA64ISAR1_EL1_SPECRES=0,SYSREG_ID_AA64ISAR1_EL1_SB=0,
>  SYSREG_ID_AA64ISAR1_EL1_FRINTTS=0,SYSREG_ID_AA64MMFR0_EL1_TGRAN4_2=1,
>  SYSREG_ID_AA64MMFR0_EL1_TGRAN16_2=1,SYSREG_ID_AA64MMFR0_EL1_TGRAN64_2=1
>
> (not including handling MIDR differences, which is out of scope for this series)
>
> Code also available at
> https://gitlab.com/cohuck/qemu/-/tree/arm-cpu-model-rfcv3?ref_type=heads
>
>
> Cornelia Huck (5):
>   arm/cpu: Add generated sysreg properties
>   kvm: kvm_get_writable_id_regs
>   arm/cpu: accessors for writable id registers
>   arm-qmp-cmds: introspection for ID register props
>   arm/cpu-features: document ID reg properties
>
> Eric Auger (5):
>   arm/cpu: Add infra to handle generated ID register definitions
>   arm/cpu: Add sysreg properties generation
>   arm/kvm: Allow reading all the writable ID registers
>   arm/kvm: write back modified ID regs to KVM
>   arm/cpu: more customization for the kvm host cpu model
>
>  docs/system/arm/cpu-features.rst      | 104 +++-
>  scripts/gen-cpu-sysreg-properties.awk | 325 ++++++++++++
>  scripts/update-aarch64-sysreg-code.sh |   5 +-
>  target/arm/arm-qmp-cmds.c             |  19 +
>  target/arm/cpu-custom.h               |  60 +++
>  target/arm/cpu-sysreg-properties.c    | 713 ++++++++++++++++++++++++++
>  target/arm/cpu-sysregs.h              |   2 +
>  target/arm/cpu.c                      |  12 +
>  target/arm/cpu.h                      |  47 ++
>  target/arm/cpu64.c                    |  24 +-
>  target/arm/kvm.c                      | 289 ++++++++++-
>  target/arm/kvm_arm.h                  |  26 +-
>  target/arm/meson.build                |   1 +
>  target/arm/trace-events               |   6 +
>  14 files changed, 1617 insertions(+), 16 deletions(-)
>  create mode 100755 scripts/gen-cpu-sysreg-properties.awk
>  create mode 100644 target/arm/cpu-custom.h
>  create mode 100644 target/arm/cpu-sysreg-properties.c
>


