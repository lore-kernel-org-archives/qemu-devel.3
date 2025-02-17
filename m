Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E631C021A9
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 13:16:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tk0yh-0000p9-Fl; Mon, 17 Feb 2025 08:16:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tk0yR-0000Uq-Tw
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 08:15:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tk0yM-0006WH-9C
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 08:15:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739798141;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=fTVPYoe5L5uJkQvegQQeLsaX8dS1W9t+vCAtuSlt0Wk=;
 b=UMBLzg9Znvs8bCIG2wj83Oiw52xvXj+D8N2YaZ5SvwGjGs5wljJeiysw2OgScLDls+CpPs
 Nu3Zu1Qz0Y0f3FoBu0GcNGvowgdlG8gxSA3iF2aZyWMsW9XTjaIH5TfJVd6lUKLPCJbcBv
 78RMSxNFJV6sugLgCpOyXgAsyQehPJg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-457-ufdknJ8iPoye7cDh3W0IyA-1; Mon, 17 Feb 2025 08:15:40 -0500
X-MC-Unique: ufdknJ8iPoye7cDh3W0IyA-1
X-Mimecast-MFC-AGG-ID: ufdknJ8iPoye7cDh3W0IyA_1739798139
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-38f4156f3daso783043f8f.2
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 05:15:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739798139; x=1740402939;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fTVPYoe5L5uJkQvegQQeLsaX8dS1W9t+vCAtuSlt0Wk=;
 b=cebV5kUQylLcTYCWv5HBOCJHM0Er//GAJveHtgJAnEohC7E0pTCElD7NGJ/VwATmkB
 15vpXorK4BLg3RdhYQgG3nMmSiPMyl0FYXSffXLLNJIe7kN9vIOkBY5lgcTltV21/nTe
 T6KpqKbSinhE6T6u+zzqJC9W6B6lVs60tfeeAw0K/3TzfO2t1wcZNp8ZOm9+js+5+Ke8
 fc5GRBbUWHIWuEvMlq4vQwLkwPIkMD1DNjw38AYBSBv4tUo5jmi8QA/L9OrsE1p91yYs
 1xOK7V0bTPZw5p7XHX+zxMlc3/HsWpgc62TEJus+YgibwZz6taPZ+5bQ2CtUpAFpwkfZ
 MtPA==
X-Gm-Message-State: AOJu0YxiebcBZcNUlizoCs0GxTAwxCdKyrrOfhG4oU0zx/VbQjH18FKB
 +7SYqoN3k7P3z28cxKrdZ60uCF2J6LBgRBEBGRwUQ/sqOdEZymyy2LXoCovRQ34p4YYMahwV7qq
 rxgX8zrT+ySWP65i9EIUpaQTXYhjawDtMlpSc7D/TG1JUUc2PdSKy
X-Gm-Gg: ASbGncu+ALy/UgbN3xVATMG9KIwMlpppvgG7yJ2Y1MmEj65g7T9oaPZmoiJ6iUZF4eM
 wqlbP9Nz2kxbrFCVqavR7JcipFcdk9a4HwHvbAiToSQn01J6S01KK2Ct0AuRvpiXypNtRMU4g5x
 hFlbk5C+2Uy370bVKu4S/YtibiZhQKEIHuEMeq9C1mLtA5W8N9q3zG70eiJh19LT7LHlYm+QpGs
 61QNBaMmhCmZv8ZlD2vzZvgg8aEVxa36K5AiZY9kSVhN1zb8Mr/mU+OcBIk3IllgBIT1Yicbkfg
 iIEJh+paMYo=
X-Received: by 2002:adf:f6c6:0:b0:38d:d371:e01d with SMTP id
 ffacd0b85a97d-38f33f565c1mr7497622f8f.49.1739798139158; 
 Mon, 17 Feb 2025 05:15:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEDmxITiZSUvZjKqkDfVx2XRpYhM1gIM/khQkFgc2MzE+H4MWbDWMOEDl+HeGeJVpvRMH25xQ==
X-Received: by 2002:adf:f6c6:0:b0:38d:d371:e01d with SMTP id
 ffacd0b85a97d-38f33f565c1mr7497585f8f.49.1739798138791; 
 Mon, 17 Feb 2025 05:15:38 -0800 (PST)
Received: from [192.168.10.28] ([176.206.122.109])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-38f259f8273sm11972456f8f.89.2025.02.17.05.15.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2025 05:15:38 -0800 (PST)
Message-ID: <7c22d254-f1a1-4162-bf07-e70677bce540@redhat.com>
Date: Mon, 17 Feb 2025 14:15:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] physmem: replace assertion with error
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Xiaoyao Li <xiaoyao.li@intel.com>,
 qemu-stable@nongnu.org, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Brijesh Singh <brijesh.singh@amd.com>, Pankaj Gupta <pankaj.gupta@amd.com>
References: <20250217120812.396522-1-pbonzini@redhat.com>
 <051e10cb-7cb1-430d-956d-b508b7f7db5a@linaro.org>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <051e10cb-7cb1-430d-956d-b508b7f7db5a@linaro.org>
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On Mon, Feb 17, 2025 at 1:28 PM Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
> >      qemu-system-x86_64 -m 512 -nographic -object sev-snp-guest,reduced-phys-bits=48,id=sev0 \
> >         -M q35,kernel-irqchip=split,confidential-guest-support=sev0
> >      qemu-system-x86_64: ../system/physmem.c:1871: ram_block_add: Assertion `kvm_enabled()' failed.
>
> I'd expect sev-snp-guest to bail out early enough.
>
> Is a KVM-enabled check in sev_snp_guest_instance_init() missing?

instance_init cannot do any check (it cannot fail). There is a check for
whether sev_common_kvm_init succeeded:

     if (machine->cgs && !machine->cgs->ready) {
         error_setg(errp, "accelerator does not support confidential guest %s",
                    object_get_typename(OBJECT(machine->cgs)));
         exit(1);
     }

but that doesn't help if the system/physmem.c code is reached before
qemu_machine_creation_done(), for example in qemu_init_board().

Likewise, you cannot fal in host_memory_backend_init() because that's
also an instance_init callback.

> > -        assert(kvm_enabled());
> > +        if (!kvm_enabled()) {
> > +            error_setg(errp, "cannot set up private guest memory for %s: KVM required",
> > +                       object_get_typename(OBJECT(current_machine->cgs)));
>
> Common code should be SW vs HW accel, so IMHO your check
> should go within sev_snp_guest_instance_init(), removing
> the assertion here. That said I have no clue about SEV.

This code is outside accel/kvm or target/*/kvn, but it is not quite
common code. A few lines below you have:

     new_block->guest_memfd =
           kvm_create_guest_memfd(new_block->max_length, 0, errp);

Paolo


