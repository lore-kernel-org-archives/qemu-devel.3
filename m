Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A99DD65C7B
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 11:34:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBY6f-0002SZ-J4; Thu, 14 Nov 2024 06:33:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1tBY6d-0002S0-Qn
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 06:33:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1tBY6c-00083O-CK
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 06:33:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731584025;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2Kf/BD32UPK0bVPXeetGCQZef7foT9CJjdeldlWY7tI=;
 b=PbQakXIZZiV4yvtfFvh5VHDQ+aW6x3qKqspWZiOI/KaByNRcORj++yJn9c17rFDv3pQ7qE
 /3LyuY5GI8z5G5QbrDVHgZOmyrrr7PPhJaXwUZrRZJB2a0RQ/N56DqP7sS5q4fhf9UsdR8
 boX17B+fEo2f8JI3OHTKRd+KetSLPHc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-362-WD2KnExTMHeXoq2-Ku9fwQ-1; Thu, 14 Nov 2024 06:33:43 -0500
X-MC-Unique: WD2KnExTMHeXoq2-Ku9fwQ-1
X-Mimecast-MFC-AGG-ID: WD2KnExTMHeXoq2-Ku9fwQ
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-382221ca9acso2017f8f.1
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 03:33:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731584022; x=1732188822;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:to:from:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=2Kf/BD32UPK0bVPXeetGCQZef7foT9CJjdeldlWY7tI=;
 b=tO/kipTWrK9m9G+K0I+RBDv2gxtw7sQ/gc09siC5WQCKrHPDbGJnacUPbQhUUGKKD/
 Ki0IvyHnThTCvWRMCxcS2+s06gtfLBLFYmC55dzsGusK5+19alVRzYk1pYAZ3UU7bTOb
 Y3gE3S+8EVZ9w3ToL4fVkYNHRXPjMtmx/Kp9Fnt5VbeXmB9K1sBSVINtO0OR6mYTWVsz
 IkX5gNOf6LyK49uSgvaNrTxkqg3/Hr5BAtJV/8mFnt13Lyqp4cjDuJUOj94SGgUAHXg8
 ZGcwtwYF6DEV6TCzl8gBiq5NbDQY6Ewy5oHrK22XCe8t3FN5oL41cZ7N3tepy9dbN1oq
 OMAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfp7hCQDEHFinkuiA1ytadOApwtSH8LZbFDidYwEBPAG1DQJcWKzvVhbl/xNh388bwSCtbERmH7SAe@nongnu.org
X-Gm-Message-State: AOJu0YwgXTKKd8Hc3aaQNsXi4RfKor42pkMPwZSYAjoBJgMY9u/BmJJn
 8Jjn8St12WF5sNVkgZJiO5Q+kqdOw+Fmiu7wrLhouLAaqhrc+w7m3Yq7nHdEIQF1cCdA2KFVdHw
 Rmz31PiW5OSFZmK95BFSYlDOiQoqYUK5Nkf/BZGBki7v7T4oiIAKQ
X-Received: by 2002:a5d:64cb:0:b0:37d:50f8:a7f4 with SMTP id
 ffacd0b85a97d-381f188c98bmr22624318f8f.52.1731584022469; 
 Thu, 14 Nov 2024 03:33:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEO+6fsttY0QVzFD9+EvrPWR1sqhk2Z49+3LHEerSgw34LsWdZFsuzOqme14KvJpxMW88oMkA==
X-Received: by 2002:a5d:64cb:0:b0:37d:50f8:a7f4 with SMTP id
 ffacd0b85a97d-381f188c98bmr22624293f8f.52.1731584022050; 
 Thu, 14 Nov 2024 03:33:42 -0800 (PST)
Received: from fedora (g2.ign.cz. [91.219.240.8])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3821adbbca7sm1245835f8f.47.2024.11.14.03.33.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 03:33:41 -0800 (PST)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org, Paolo Bonzini
 <pbonzini@redhat.com>
Subject: Re: [PATCH RESEND v4 1/4] target/i386: Fix conditional
 CONFIG_SYNDBG enablement
In-Reply-To: <2d8273dd-3355-439b-9d40-e56286b93100@tls.msk.ru>
References: <20240917160051.2637594-1-vkuznets@redhat.com>
 <20240917160051.2637594-2-vkuznets@redhat.com>
 <2d8273dd-3355-439b-9d40-e56286b93100@tls.msk.ru>
Date: Thu, 14 Nov 2024 12:33:40 +0100
Message-ID: <87cyiyjbhn.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=vkuznets@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.119,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Michael Tokarev <mjt@tls.msk.ru> writes:

> 17.09.2024 19:00, Vitaly Kuznetsov =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>> Putting HYPERV_FEAT_SYNDBG entry under "#ifdef CONFIG_SYNDBG" in
>> 'kvm_hyperv_properties' array is wrong: as HYPERV_FEAT_SYNDBG is not
>> the highest feature number, the result is an empty (zeroed) entry in
>> the array (and not a skipped entry!). hyperv_feature_supported() is
>> designed to check that all CPUID bits are set but for a zeroed
>> feature in 'kvm_hyperv_properties' it returns 'true' so QEMU considers
>> HYPERV_FEAT_SYNDBG as always supported, regardless of whether KVM host
>> actually supports it.
>>=20
>> To fix the issue, leave HYPERV_FEAT_SYNDBG's definition in
>> 'kvm_hyperv_properties' array, there's nothing wrong in having it defined
>> even when 'CONFIG_SYNDBG' is not set. Instead, put "hv-syndbg" CPU prope=
rty
>> under '#ifdef CONFIG_SYNDBG' to alter the existing behavior when the flag
>> is silently skipped in !CONFIG_SYNDBG builds.
>>=20
>> Leave an 'assert' sentinel in hyperv_feature_supported() making sure the=
re
>> are no 'holes' or improperly defined features in 'kvm_hyperv_properties'.
>>=20
>> Fixes: d8701185f40c ("hw: hyperv: Initial commit for Synthetic Debugging=
 device")
>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>
>> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
>> index ada581c5d6ea..4009fcfd6b29 100644
>> --- a/target/i386/kvm/kvm.c
>> +++ b/target/i386/kvm/kvm.c
> ...
>> @@ -3924,13 +3929,11 @@ static int kvm_put_msrs(X86CPU *cpu, int level)
>>                   kvm_msr_entry_add(cpu, HV_X64_MSR_TSC_EMULATION_STATUS,
>>                                     env->msr_hv_tsc_emulation_status);
>>               }
>> -#ifdef CONFIG_SYNDBG
>>               if (hyperv_feat_enabled(cpu, HYPERV_FEAT_SYNDBG) &&
>>                   has_msr_hv_syndbg_options) {
>>                   kvm_msr_entry_add(cpu, HV_X64_MSR_SYNDBG_OPTIONS,
>>                                     hyperv_syndbg_query_options());
>>               }
>> -#endif
>
> This change broke a minimal build:

Sorry about that :-(

>
> $ ../configure --without-default-features --without-default-devices --tar=
get-list=3Dx86_64-softmmu --enable-kvm
> ...
> FAILED: qemu-system-x86_64
> cc -m64 @qemu-system-x86_64.rsp
> /usr/bin/ld: libqemu-x86_64-softmmu.a.p/target_i386_kvm_kvm.c.o: in funct=
ion `kvm_put_msrs':
> target/i386/kvm/kvm.c:4039:(.text+0x83ae): undefined reference to `hyperv=
_syndbg_query_options'
> collect2: error: ld returned 1 exit status
>
> Why this particular #ifdef has been removed?

The patch was on the list for over a year before it got accepted and I
completely forgot the details... Looking at it now and I don't believe
we need HV_X64_MSR_SYNDBG_OPTIONS at all when !CONFIG_SYNDBG so I guess
we can bring the ifdef back. Let me do some quick tests and I'll send a
patch.

--=20
Vitaly


