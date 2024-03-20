Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09B6CC54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 10:00:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmsjf-0005Rx-D8; Wed, 20 Mar 2024 05:59:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rmsjd-0005Rl-Dt
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 05:59:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rmsjb-00039s-KF
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 05:59:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710928786;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=4E6cV7Z0IXhk3/9ASVcucF4jSLxiWXgVx3agQhS5UWA=;
 b=Bc4QfBiGqTESw/IEDNH2N3Hpu/H6wYX1n1MCOCY13DpJGFkJf82sbMVNjuZGjBHiWCzord
 3QTpx0e7ktRIgcww92uniz00h7cI/j+/TGcnIQqr4JU1BvQYl3DLfqqjMr0bdAEsUuwMql
 YK3K7bwOJMfSbWIW61wVZgpcLUGAmUQ=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-301-H0ARBhVSP9mC9UM2wuw_0w-1; Wed, 20 Mar 2024 05:59:45 -0400
X-MC-Unique: H0ARBhVSP9mC9UM2wuw_0w-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a46f5f2896dso27620466b.3
 for <qemu-devel@nongnu.org>; Wed, 20 Mar 2024 02:59:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710928782; x=1711533582;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4E6cV7Z0IXhk3/9ASVcucF4jSLxiWXgVx3agQhS5UWA=;
 b=P/eFsmri9PYmVLxiIygKHIDulSN7MtzMDWR+J+DUd4onVA7FVuS87lHGLks5zbPlMj
 QLmC+RG8+V/5r6b/Z0rOE9sGive9LmSiBfYv4Xu/d1t6glF+c1TwZyacNYPEPP6laK96
 GBz6q1N0Fv2tAt2aQrKCcMEC7vRhoiN10MzG7Exy9Hfo5F9sqPZ0ELlwU9lkRvS9BZSV
 hZR03tMEjj0YOOA2x/19sE/3cq0KSK8LQZi82BtQ1M3oRkh96YrRHScdLQtW2z6qbpku
 CQYENktAWJYdgeydhEO0xyfd0//Xyb4IGzokyi45Iem1VQ6evGjVJhrYAY81LRqFk+CP
 8sDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUB/04UDOsazvUb2uo432qzTt3pRvw7KzgZ9ULcNwsZKKG7x0LdbbueHkhhUNUm2EBq9+0Vtti+2weTcdAeHgpHoOQcwGo=
X-Gm-Message-State: AOJu0YyHeGrwZ6Baf1B1xS4WKkaQzjV/QlbPJSpOlqhpIB3XbGnUnzb9
 d8xCc6q7DZDllvpdv4vE9Im59IzaHXQwnWkwjyYq/Ip9d0GKkPB0gZVIZuPdjQoAq4o49KwKgch
 5d4iVox3eGLOyqOPg3996HfGxqMHbp7sMaywQXQVANAOdlalKgO1X
X-Received: by 2002:a17:906:874d:b0:a46:11a9:430 with SMTP id
 hj13-20020a170906874d00b00a4611a90430mr10945336ejb.76.1710928782547; 
 Wed, 20 Mar 2024 02:59:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJxJ9NP1udzip8cs/ntajoHKAsSNPNLtMjuJRtzEyV7kcMkGCa6+sfp3x2uAcI8kr/s5GSxQ==
X-Received: by 2002:a17:906:874d:b0:a46:11a9:430 with SMTP id
 hj13-20020a170906874d00b00a4611a90430mr10945331ejb.76.1710928782222; 
 Wed, 20 Mar 2024 02:59:42 -0700 (PDT)
Received: from [192.168.10.118] ([151.95.49.219])
 by smtp.googlemail.com with ESMTPSA id
 gq5-20020a170906e24500b00a46be5c78f4sm3425428ejb.142.2024.03.20.02.59.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Mar 2024 02:59:41 -0700 (PDT)
Message-ID: <eea690c2-7d2f-4a35-b5c3-078c12ef228b@redhat.com>
Date: Wed, 20 Mar 2024 10:59:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 00/49] Add AMD Secure Nested Paging (SEV-SNP)
 support
Content-Language: en-US
To: Michael Roth <michael.roth@amd.com>, qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Pankaj Gupta <pankaj.gupta@amd.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>,
 Isaku Yamahata <isaku.yamahata@linux.intel.com>
References: <20240320083945.991426-1-michael.roth@amd.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20240320083945.991426-1-michael.roth@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 3/20/24 09:38, Michael Roth wrote:
> These patches implement SEV-SNP base support along with CPUID enforcement
> support for QEMU, and are also available at:
> 
>    https://github.com/amdese/qemu/commits/snp-v3-rfc
> 
> they are based on top of the following patchset from Paolo:
> 
>    "[PATCH 0/7] target/i386: VM type infrastructure and KVM_SEV_INIT2 support"
>    https://lists.gnu.org/archive/html/qemu-devel/2024-03/msg04663.html
> 
> 
> Patch Layout
> ------------
> 
> 01-05: Various changes needed to handle new header files in kvm-next tree
>         and some hacks to get a functional header sync in place for building
>         this series.
> 06-18: These are patches directly plucked from Xiaoyao's TDX v5 patchset[1]
>         that implement common dependencies between SNP/TDX like base
>         guest_memfd, KVM_EXIT_MEMORY_FAULT handling (with a small FIXUP), and
>         mechanisms to disable SMM. We would've also needed some of the basic
>         infrastructure for handling specifying VM types for KVM_CREATE, but
>         much of that is now part of the sevinit2 series this patchset is based
>         on. Ideally all these patches, once stable, could be maintained in a
>         common tree so that future SNP/TDX patchsets can be more easily
>         iterated on/reviewed.
> 19-20: Patches introduced by this series that are  possible candidate for a
>         common tree.
>         shared/private pages when things like VFIO are in use.
> 21-32: Introduction of sev-snp-guest object and various configuration
>         requirements for SNP.
> 33-36: Handling for various KVM_EXIT_VMGEXIT events that are handled in
>         userspace.
> 37-49: Support for creating a cryptographic "launch" context and populating
>         various OVMF metadata pages, BIOS regions, and vCPU/VMSA pages with
>         the initial encrypted/measured/validated launch data prior to
>         launching the SNP guest.

I reviewed the non-SEV bits of patches 21-46 and it looks nicely 
self-contained.  That's pretty much expected but still good news.

I didn't look closely at the SEV-SNP code for obvious reasons (it's only 
been one hour :)), except for the object-oriented aesthetics which I 
have remarked upon.  However, they seem to be in good shape.

I will now focus on reviewing patches 6-20.  This way we can prepare a 
common tree for SEV_INIT2/SNP/TDX, for both vendors to build upon.

Thanks for posting this, and thanks to the Intel people too for the 
previous work on the guest_memfd parts!

Paolo


