Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 369EAC8303C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 20:45:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZFAg-0003ue-SC; Tue, 08 Jul 2025 16:44:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uZDaq-0000hJ-5B
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:03:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uZDaf-0003LQ-Cq
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:02:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752001371;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=5LTihkAM4nk0aean+/b4dviw52JpVpN8+MR4k4njjo8=;
 b=AeEwRgrx3npWDAHpBzYF9PzjkZkyB+3WHSmHqYOEJbaypW115FH8nKElsoxHmuptZe346p
 F2Ri5OXSwNbxtvVxD4d/Vv+c60OTuN64RfXDaE/JsVHuDgg2XDtoQVDXtx2vc9u1hNEPk/
 ZqRBnpArFERgBKW8q1syR4FZlvaJ04M=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-500-PsVEPvUWO9SRe50GA5CSAw-1; Tue, 08 Jul 2025 04:35:15 -0400
X-MC-Unique: PsVEPvUWO9SRe50GA5CSAw-1
X-Mimecast-MFC-AGG-ID: PsVEPvUWO9SRe50GA5CSAw_1751963714
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-450eaae2934so32755275e9.2
 for <qemu-devel@nongnu.org>; Tue, 08 Jul 2025 01:35:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751963713; x=1752568513;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5LTihkAM4nk0aean+/b4dviw52JpVpN8+MR4k4njjo8=;
 b=a2CZ382ANqdbh0u9WzR+GUZO3NEmok1tRSSAAGX7ApLvXv+EyUJeKyu3XSArQ12Xx3
 JcJH4UunX62u1331Nx50IINl7e3ZmNVZsaTjpud2GfDumCpgEJCrNTf5Y7EVPhxXGE9q
 mQ/8iRaZxHI1KiL2XGGYFIELsUlpp/+fWq+wGs4oTeGBn0KxSWvRbt8YRDnPjFSwywC6
 DOsv+N/z89gTDvNpg3T/YxbmhYDIS6fF9ruSicYNQIcWaGdKFvbkZAmiYZGdeBpqWZwz
 SoXyscY+kgTSOajTzhVp2FxM3gMIE4nhl7NZb6HXdD5wP2GrSxRYJKTNpDLYXpJ9ryyE
 Fnug==
X-Forwarded-Encrypted: i=1;
 AJvYcCVPtYP2wptQa+Re0crjUKr2qm136J1XTLIZcqdT5xopkDVk4JAqREn06ozYbpbXtl79qLgodBamGEzf@nongnu.org
X-Gm-Message-State: AOJu0YwtS2rU+ZPbjUbsMEDLGslcSUkbrr4RyFR+TntSCspwR+jn8S8H
 9lAaEhT9NXTb3I4d6WPkBuklLPiJM4bPG4niywO4YsWy6C7W2O+gO+sxWBMIV2c/3DEAzvt1jbd
 eXUDLB29IBt9fRwd8+zvIa4E5UoR7mi9f6Vj3oKwY/TSLopH3qQeQIAmryMaeCgMu
X-Gm-Gg: ASbGncvXVO5M2mUg2K8acpt8luWHKIw31nIsmTSFqOfwt3lW8FnnzBKrJO7HKyeCqC9
 aXnTcAUSFeUMEbOsJEAAPLe7TlVvUBHbBEkcJ4uWk3say3uteq1UbW0Zr+8wuc4eLhrALE6fzoZ
 wLqPD4qxKqeWG4vLSFVioqOBwVNoKT4wQ4hZKyL6scrw49L4X/3aqmUeE/jmE6lZ7y1a+XQiFmd
 3K6OeTL4STVzeI9u95pXYZif7K8xTCec5SFFHKu/ULNWzgdGiVeaILUG3y0GjIPARKBpda6UKh+
 N5C8O0q/RNBXYh2cUapxGohA8SY=
X-Received: by 2002:a05:600c:3b10:b0:44d:a244:4983 with SMTP id
 5b1f17b1804b1-454cde10611mr18634135e9.3.1751963713431; 
 Tue, 08 Jul 2025 01:35:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHraeHBC0Ql+WplsiGyQXAJs4gO/VtysIFk4ox8H9ht5kGxU18G4bXI1Vh35b9SY8vrv/SQOA==
X-Received: by 2002:a05:600c:3b10:b0:44d:a244:4983 with SMTP id
 5b1f17b1804b1-454cde10611mr18633885e9.3.1751963713000; 
 Tue, 08 Jul 2025 01:35:13 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.202.169])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-454cd4eef79sm12763685e9.0.2025.07.08.01.35.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Jul 2025 01:35:12 -0700 (PDT)
Message-ID: <591f8a81-2c8e-4e30-abf2-4571afed41b4@redhat.com>
Date: Tue, 8 Jul 2025 10:35:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] rust/memory: replace size arg with Bits enum
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
References: <20250703-rust-mem-api-v1-0-cd5314bdf580@linaro.org>
 <20250703-rust-mem-api-v1-1-cd5314bdf580@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20250703-rust-mem-api-v1-1-cd5314bdf580@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

> We have the ability to make memory accesses use a typesafe access width
> type in Rust, which the C API currently lacks as it does not use a
> newtype wrapper for specifying the amount of bytes a memory access has;
> it uses a plain 32-bit integer value instead.

I find this both verbose and (ok, that's subjective) ugly due to the 
extra import, the underscore.

There are two parts on the patches:

1) the extra checking on impl_sizes and valid_sizes.  That's valuable, 
what about just adding something like this:

         assert!(min == 1 || min == 2 || min == 4 || min == 8);
         assert!(max == 1 || max == 2 || max == 4 || max == 8);
         assert!(max >= min);

It can be validated at compile time anyway, since the functions are 
pretty much always used in const context (in fact, for C code there's a 
scripts/checkpatch.pl check that they are declared as const).


2) Passing Bits to the read and write callbacks.  The argument is 
ignored for pl011, and converted with "as u32" for HPET.  I find this to 
be worse than before, because it's very unobvious that _32 is defined to 
4 rather than 32.

The main effect on generated code is to add an assert! to 
memory_region_ops_read_cb() and memory_region_ops_write_cb() that's 
similar to the above.  I'm not sure of its value, either: if the size is 
not 1/2/4/8, memory.c/physmem.c must have screwed up big.  It's not a 
safety concern, either, since the size is not used in any unsafe code.

Thanks,

Paolo


