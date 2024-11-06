Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CA96D44D7F
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 15:27:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8hvg-0003t1-71; Wed, 06 Nov 2024 10:26:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roman@roolebo.dev>) id 1t8hve-0003sq-7M
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 10:26:42 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <roman@roolebo.dev>) id 1t8hvc-0001Eh-IZ
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 10:26:41 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-20cd73feaabso3548625ad.0
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2024 07:26:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=roolebo.dev; s=mail; t=1730906799; x=1731511599; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=i4UPt885InRzUgsXiJkm2P2mE2G4C3jnFvzBGXCsTpE=;
 b=D0i+pdNzF/4P8rwncYDLfH/NwdhF2vkYQP/TK1zxOnlvl7ro8wFWaw3MWpWlOOaEhw
 iubfkMFSTotqJjH54yXrDOlzCzg8rGuK69GNIn+U4hxVf5qH+K+qKVnkYDeIcZ4b5XHu
 FDfDlflZZa7+URIRpmmYhsfdCWgCwP/IGQbe2d9U/cevXLJs6baKv7lbWvdYKIcp0rKl
 52rAYGnZ/l719jGYMsH9hJ1ca7oUIy+FXcfbd39bR3nah0Nw8lb6L4E66W6EbRDLlv1L
 4hATsenLLS0xgi2GYuX+ZM++pi33wTe32Zkt07mT+I/htBMdEcz3JZXiUUzIaY7NI2KW
 sCAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730906799; x=1731511599;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i4UPt885InRzUgsXiJkm2P2mE2G4C3jnFvzBGXCsTpE=;
 b=BosaXclZKNZDImrw2NSCSi29nK9tLxlaEigGe9i9O2A1kEVtqfZT2hNpCyMBL84ObC
 nBjmh8DfIMCjxfEEkPFJnPbw9R4uxLvGlCi0OxO31D7pVJZWjr/M6gH/SRFKycWHOLTS
 1GLgpT574/X/XNkLqJhqrBXkk/SIcHCFatpuzyMPPOBmy3MVmvPxbYMu+fTTRyYcjZ0H
 kZX6DYxuahY3yRJqe0xGotlVQ8PsZjwYtjF3TrX+7V45BUOoFYBKk6tCQajlmmzOt8NJ
 aYuNtGFtgo7pYllhwnGAk2Okf+D6R58IdkJuOZXSQiXvRef2kLCWEUroTkD6G6KjLuk4
 x12g==
X-Gm-Message-State: AOJu0YyMEkiu0M6HynHu+rX5oAuSa2f4cGcpx/XT1EBdJtlgJxRGuP4+
 OJncwkEGFQgNTPmuMEWKrOp1zCJZ34xb6nD7MkA9v86ccIEmldXcjOaL6JcOknw=
X-Google-Smtp-Source: AGHT+IFvrDMB9ZGtv9yO+8b2syKVgd9a+y/O+3NJPxZcSNoIDU5SfYuJ8Pii1DUPIJ8gTKE6rGCrqA==
X-Received: by 2002:a17:902:ce81:b0:20c:6f7e:2cb1 with SMTP id
 d9443c01a7336-210c68db903mr239001765ad.2.1730906798927; 
 Wed, 06 Nov 2024 07:26:38 -0800 (PST)
Received: from localhost ([2405:9800:b660:1d69:184b:7485:e878:79c4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-211056ee3d8sm96766185ad.20.2024.11.06.07.26.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Nov 2024 07:26:38 -0800 (PST)
Date: Wed, 6 Nov 2024 22:26:35 +0700
From: Roman Bolshakov <roman@roolebo.dev>
To: Phil Dennis-Jordan <phil@philjordan.eu>
Cc: qemu-devel@nongnu.org, dirty@apple.com, rbolshakov@ddn.com,
 pbonzini@redhat.com
Subject: Re: [PATCH 0/5] i386/hvf: x2apic support and some small fixes
Message-ID: <ZyuKq75sryZo8U7z@roolebo.dev>
References: <20241105155800.5461-1-phil@philjordan.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241105155800.5461-1-phil@philjordan.eu>
Received-SPF: none client-ip=2607:f8b0:4864:20::62d;
 envelope-from=roman@roolebo.dev; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On Tue, Nov 05, 2024 at 04:57:55PM +0100, Phil Dennis-Jordan wrote:
> This is a loose collection of patches against the x86 hvf accel. They
> can be applied/pulled independently from one another.
> 
> Patch 1 is a repost of a patch I've submitted a bunch of times already.
> It wires up and enables x2APIC mode in conjunction with HVF - the
> software APIC implementation in QEMU gained the feature earlier this
> year but hvf wasn't included.
> The change typically improves performance with modern SMP guest OSes by
> a 2-digit percentage. (Exact values depend on workload.)
> 
> Patch 2 fixes cases of undefined behaviour recently introduced by commit
> 7cac7aa which made changes to HVF CPUID XSAVE functionality.
> 
> Patch 3 fixes a minor one-off memory leak during hvf startup.
> 
> Patch 4 ever so slightly improves APIC correctness under hvf: when
> setting the APICBASE MSR, if the APIC deems the new value invalid,
> we raise an exception (as per spec) rather than silently doing
> nothing. This fixes a failing kvm-unit-tests test case.
> 
> Patch 5 removes some unnecessary duplication and type-rechecking in
> HVF's inner loop. (No need to cast the cpu state pointer to X86CPU
> within, the hvf_vcp_exec function already does that once at the top.)
> 
> Some of this work has been sponsored by Sauce Labs Inc.
> 
> Phil Dennis-Jordan (5):
>   i386/hvf: Integrates x2APIC support with hvf accel
>   i386/hvf: Fix for UB in handling CPUID function 0xD
>   i386/hvf: Fixes startup memory leak (vmcs caps)
>   i386/hvf: Raise exception on error setting APICBASE
>   i386/hvf: Removes duplicate/shadowed variables in hvf_vcpu_exec
> 

To the series,
Reviewed-by: Roman Bolshakov <rbolshakov@ddn.com>
Tested-by: Roman Bolshakov <rbolshakov@ddn.com>

I figured the issue with 24.04 guests, it was an issue on my side (too
little memory provided to the guest).

Paolo, please apply this if you have no objections.

Regards,
Roman

