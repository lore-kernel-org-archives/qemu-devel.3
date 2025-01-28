Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46CA9C0218A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 09:56:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tciKP-0001bp-MV; Tue, 28 Jan 2025 04:56:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tciKN-0001bK-MY
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 04:56:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tciKM-0001ap-3S
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 04:56:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738058172;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=6i8kSCoqlAjBAAdsOcA5niYRMIgJ2k5Gf+6P97522hI=;
 b=f+jbvyl4dEMtWF5SAWsVah551NSl1Lt1yUZsi0NRmKEq7DtRvuDta0u+alAdW/9UVEdW9b
 BcEMkbGhxXNXxlCHWdCh7Bbyr0N60nfzWT9VA7ZYHoBE9/nO1AVoKOi9WlRy0p9KH0vKcD
 q6Kzjcl3wH9wJXJfIlV2IPdk/DMY3Po=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-azFx9hOyOoWVNFVx2QvW5g-1; Tue, 28 Jan 2025 04:56:10 -0500
X-MC-Unique: azFx9hOyOoWVNFVx2QvW5g-1
X-Mimecast-MFC-AGG-ID: azFx9hOyOoWVNFVx2QvW5g
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-388d1f6f3b2so2253855f8f.0
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 01:56:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738058169; x=1738662969;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=6i8kSCoqlAjBAAdsOcA5niYRMIgJ2k5Gf+6P97522hI=;
 b=k/8gxUUNRJhaOczRw8XS0RiDHgjpnyO0tLJtyIc+yzN/II4bfI50O5byCeUUSgJq/E
 4HDw2GB0Vg13ecMDjL8yRFqVdOfRm1+UjAc6akAh6IvUv8UGxmWbNve+5eySiYxvTlZv
 VLcSDdCMAvPtKSLvC4TnAsoN1+heOIwd901srGJbExojsTS2WIFufdmJ9TW4/t69G2xm
 QgrmCbX22RwqQYtia0MGsywJV+MAjp+5i5mOwJ/c4Hk98KXkSm6YrfRYT+f2eLp1brVa
 oHChwCma4Mcz/f4I2nSFdKWupnqVB2BjOr3ArOiUgFUGrCfxDHYkLNlleTpQPbvL8r4u
 vjAg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvS43ayqn5z31X5mzB0QVxKbPLegNx12XJrBoWnIjY/fLuBsjByE6te6dESiaCo3wQhJNiIjqb9k1E@nongnu.org
X-Gm-Message-State: AOJu0YyLN9Vn3Fov2l3xM1zRrY5ljisQEt07R9oNJK9DUFXygnV1Naw8
 xhPATwaeUkHAbp0ROqGhYT+Z4ZV6mobrDsMKSwcLu3PRPqKJi0lZHWfVZhZhAemV9mYZbTL/PJI
 BzEjYful6xK3LCxT2v1iBkM94/UjM9FuKx2BFItXAa9SHW42hW1el
X-Gm-Gg: ASbGnctLIK9+iitltJ1iJIZV28oqzZiVocvHzXp5onb5CAn9OPPD6R2NpbJ6B9E0DYU
 PIIrkohPV5tJT1mqYbOBhZZaYJRrqkyNQhCghxebKlpWTfF6OgGRlJi/McFJn/di8xyv5M60PwK
 jiMIEjYP6bNSKXlyupXZ4YawS4vrbnRNZOEVNXQfQceTti7fpn8/oOYTZFpmAvxzishbeObPj7F
 nm6GPd8SlGir4BBxBvIkX8/+WJrbrcY2rdNobssHBsbrUZkmQGlCtfXyyfw47eeII1hQlfCHzU2
 Ss+8j2Lg5IMxP4rBIY6RnCVrrYiSabmHBJJdSKGJ6K2LEnuBEEYw/vOToWTtsXF/OUYw8dR2iba
 RWgozwQzMxgA6T59wMylwBaha4rMmtssj
X-Received: by 2002:a05:6000:c92:b0:38a:5122:5a07 with SMTP id
 ffacd0b85a97d-38bf5664211mr33061430f8f.15.1738058169604; 
 Tue, 28 Jan 2025 01:56:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFmmnGJ3mnaGQGCLKG3nVZ7d84eZi0/PBEhiLpXgUGYTiOylNKIgIr3b6950B9FOoCEv2UeSQ==
X-Received: by 2002:a05:6000:c92:b0:38a:5122:5a07 with SMTP id
 ffacd0b85a97d-38bf5664211mr33061409f8f.15.1738058169176; 
 Tue, 28 Jan 2025 01:56:09 -0800 (PST)
Received: from ?IPV6:2003:cb:c73f:ce00:1be7:6d7f:3cc3:563d?
 (p200300cbc73fce001be76d7f3cc3563d.dip0.t-ipconnect.de.
 [2003:cb:c73f:ce00:1be7:6d7f:3cc3:563d])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a18867esm13387256f8f.43.2025.01.28.01.56.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jan 2025 01:56:08 -0800 (PST)
Message-ID: <a26d7e7a-27c2-4d36-82cb-35012f72d446@redhat.com>
Date: Tue, 28 Jan 2025 10:56:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] target/s390x: Fix MVC not always invalidating
 translation blocks
To: Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 Berthold Gunreben <azouhr@opensuse.org>, Sarah Kriesch
 <ada.lovelace@gmx.de>, qemu-stable@nongnu.org
References: <20250128001338.11474-1-iii@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250128001338.11474-1-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 28.01.25 01:12, Ilya Leoshkevich wrote:
> Node.js crashes in qemu-system-s390x with random SIGSEGVs / SIGILLs.
> 
> The v8 JIT used by Node.js can garbage collect and overwrite unused
> code. Overwriting is performed by WritableJitAllocation::CopyCode(),
> which ultimately calls memcpy(). For certain sizes, memcpy() uses the
> MVC instruction.
> 
> QEMU implements MVC and other similar instructions using helpers. While
> TCG store ops invalidate affected translation blocks automatically,
> helpers must do this manually by calling probe_access_flags(). The MVC
> helper does this using the access_prepare() -> access_prepare_nf() ->
> s390_probe_access() -> probe_access_flags() call chain.
> 
> At the last step of this chain, the store size is replaced with 0. This
> causes the probe_access_flags() -> notdirty_write() ->
> tb_invalidate_phys_range_fast() chain to miss some translation blocks.

We added the size parameter in:

commit 1770b2f2d3d6fe8f1e2d61692692264cac44340d
Author: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Date:   Thu Feb 23 20:44:24 2023 -0300

     accel/tcg: Add 'size' param to probe_access_flags()
     
     probe_access_flags() as it is today uses probe_access_full(), which in
     turn uses probe_access_internal() with size = 0. probe_access_internal()
     then uses the size to call the tlb_fill() callback for the given CPU.
     This size param ('fault_size' as probe_access_internal() calls it) is
     ignored by most existing .tlb_fill callback implementations, e.g.
     arm_cpu_tlb_fill(), ppc_cpu_tlb_fill(), x86_cpu_tlb_fill() and
     mips_cpu_tlb_fill() to name a few.


And added support for more than one byte for the notdirty case in

commit e2faabee78ff127848f59892747d4c07c56de033
Author: Jessica Clarke <jrtc27@jrtc27.com>
Date:   Fri Nov 10 21:43:03 2023 -0800

     accel/tcg: Forward probe size on to notdirty_write
     
     Without this, we just dirty a single byte, and so if the caller writes
     more than one byte to the host memory then we won't have invalidated any
     translation blocks that start after the first byte and overlap those
     writes.

So I guess it's rather hard to find a "Fixes:" tag, because likely it's been
broken forever?

> 
> When this happens, QEMU executes a mix of old and new code. This
> quickly leads to either a SIGSEGV or a SIGILL in case the old code
> ends in the middle of a new instruction.
> 
> Fix by passing the true size.


Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


