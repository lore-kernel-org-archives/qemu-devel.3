Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A796DD31A31
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 09:26:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfx8o-0001bS-E6; Wed, 14 Jan 2026 04:26:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vfx8n-0001b1-7q
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 04:26:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vfx8l-0000vX-FX
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 04:26:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768382770;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=bsSvA1SR/eWeCy9aBlyPOx/wemqUPjj6Rc2C2gkuJKE=;
 b=WQ+Zgqo1p81Ll/WQ++Dyxp/3LGhLLWujU/+cDXK9JpZJsr17zzkoCqUvwBM6FX/UNIBkzT
 6HnZSl8v+bfMpHm2ntL/IcqMjlq+9WjyGPgrth/8VpAE/w/lJqJTLuUIuPDnr+zZZhKgf7
 56EQpkx6KygSvnEv2qJk4gjtl/6bq9s=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-KW4NFjIeOKG8qe7_Mxa5Hw-1; Wed, 14 Jan 2026 04:26:08 -0500
X-MC-Unique: KW4NFjIeOKG8qe7_Mxa5Hw-1
X-Mimecast-MFC-AGG-ID: KW4NFjIeOKG8qe7_Mxa5Hw_1768382767
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-47edc79ff28so9232195e9.2
 for <qemu-devel@nongnu.org>; Wed, 14 Jan 2026 01:26:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768382767; x=1768987567; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=bsSvA1SR/eWeCy9aBlyPOx/wemqUPjj6Rc2C2gkuJKE=;
 b=L/DKOQTGfXEM65lISxOYPx8mJJwa888+AWFgiOCyTll0dAcO+JaRBZkzgFPDrpaibs
 S5uQVx6i3GTVuHDGg2K3t8Wbk7EBvNV+MxSfUxzEn1UcWfWAm+qealBjy3HJSlBh9hay
 3A00DDWegeL5EVuvQYAJh1omC4W/OVdXYa0f3bWLOjmeYmxzj/XYyyK6muUlojcLV3oM
 4WH4sxv9SyduBImFuS69jR3bYYh9rYDNht6RzMBQPJfX0oTsNKyt6ql/aeFbhvfJW2uj
 My2fdbFx8vkY0yEA7I0e6xp1SxRifVhf6b9nY67tmULPvd11xxaUpp+vqT8aB7mX0/Xa
 tmdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768382767; x=1768987567;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bsSvA1SR/eWeCy9aBlyPOx/wemqUPjj6Rc2C2gkuJKE=;
 b=nZeqaEqgMg6TDRK69V9BqPHnWv0HczzIpQXKILCsjHxdoo/NQzB+OHFQu8d3PZpm8I
 8eUSHpIav8XEMd8U+qVn9XlbvAwDB5HYt5wEZXyDp0ijAZPW178fMpHltYbUH8KoobUC
 3SPJ48NYXvSxVOsWvtUnKeHhO/TSZGjRj3e4iVZcJBACwYA5zc4qL0SftVPSzgebhpxQ
 qlhtimiH5CM/pLZHimpw+8cgmZGBy3XgTHXlEK1A35sTLRwoNGIb5atvW6QVB/6JgBl+
 RwJDOx5YFscNKXoUETrnK9RkaKwWZsl+ccNQAHpbwBc3G1c+gDdtDyKCwJdJJMhn3uVL
 +gvw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhRQVVm1anOvuIIZUiWKz4lpNGkdhbP+k2LBhwhJgd6Mj33oo2lNitnbHXdxNaq8bzEjTnDGwP5ia+@nongnu.org
X-Gm-Message-State: AOJu0YzkuzDCh3SQx2a9S3tAu9DtXlKwud211iEL2jo2TJPZ8JE9ZWEt
 Js0Yt1ApT5tho6ZRTztrmF430O0gh9CZb2ASG+TJejHHIAsSnIxLqd2cWWlyiPG6gRKOJ2fWl9t
 OXrc9vxR/f5Rk2khTzqws7mIB/3biY/OO9OG9QkNVNeGahf74WwPvfofS
X-Gm-Gg: AY/fxX5EFkwSeQo/XO/MG5BVaeTUrYNDLjpu/a3q6i8Kv0WfDBbz1fq2IQzFxyBmTBl
 YpYFRSlE9sIGzKZ+qNX4MBxtVJCDAmgSw5jABl5iOj4yEtSpQ+n4mm/dUOlpZF0NAFfJtrS1ewH
 4W7v7lKeTeiRjWyHksz75pT+0tUxwd364I3tTI8K+YokKgvEm/tDx7ABBRBTCk2fzS76zzS/0o5
 3tFjrpKnFc9prVeXImUI4ffVS3v9xW0Jt3Pq38aMOTI1M44tt22LFddQjOi2M2SK8lXkP+v2ijw
 uGqvrnA35bSiR+mPx8gBhAc1Yk+PnH3PCipmrCvcZsyNrtlo5jsHYhyWQaCKkHvzAcPC5zTzoWk
 OJTDe4zo3vOXv0kzautEdzUiufwTAxtKOzPczY9FErtUZNRK4lBJHTUkOWDuJt+V8EruSD02mIG
 VHh2x+7opNr/v9+g==
X-Received: by 2002:a05:600c:c0d0:b0:47e:e78a:c833 with SMTP id
 5b1f17b1804b1-47ee78aca5amr4964965e9.32.1768382767398; 
 Wed, 14 Jan 2026 01:26:07 -0800 (PST)
X-Received: by 2002:a05:600c:c0d0:b0:47e:e78a:c833 with SMTP id
 5b1f17b1804b1-47ee78aca5amr4964775e9.32.1768382767010; 
 Wed, 14 Jan 2026 01:26:07 -0800 (PST)
Received: from [192.168.10.48] ([151.61.26.160])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-432bd5ede7esm50194071f8f.32.2026.01.14.01.26.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Jan 2026 01:26:06 -0800 (PST)
Message-ID: <ea1e0e45-f864-4a43-a40e-48fd82c26c56@redhat.com>
Date: Wed, 14 Jan 2026 10:26:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 13/31] accel/nvmm: Replace @dirty field by generic
 CPUState::vcpu_dirty field
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Reinoud Zandijk <reinoud@netbsd.org>, Ryo ONODERA <ryoon@netbsd.org>
References: <20250704101433.8813-1-philmd@linaro.org>
 <20250704101433.8813-14-philmd@linaro.org>
 <44ccfba7-21a3-4c24-aa6a-4b2bdb989792@redhat.com>
 <dd7fbe03-1458-4c44-b8db-a9d5e9ae33f1@linaro.org>
 <87v7h44pal.fsf@pond.sub.org> <aWdfqvJhtDt14lTJ@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <aWdfqvJhtDt14lTJ@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 1/14/26 10:19, Daniel P. Berrangé wrote:
> This doesn't imply we should automatically rip it out, but if we see
> no evidence of (3) for a prolonged period of time, and no sign of it
> being used downstream in any way, it is worth considering the cost /
> benefit.
> 
> In the case of NetBSD something must be working to some extent since
> it appears that 10.1.0 QEMU is present in the pkg repos:
> 
>     https://pkgsrc.se/emulators/qemu
> 
> so that argues against ripping stuff out even if we notice breakage.

And indeed their pkgsrc has the same patch that Philippe has now
submitted for inclusion in qemu.git:

https://cvsweb.netbsd.org/bsdweb.cgi/pkgsrc/emulators/qemu/patches/patch-target_i386_nvmm_nvmm-all.c.diff?r1=1.10;r2=1.11

---- target/i386/nvmm/nvmm-all.c.orig	2024-11-20 22:48:05.000000000 +0000
+--- target/i386/nvmm/nvmm-all.c.orig	2025-08-26 18:32:38.000000000 +0000
  +++ target/i386/nvmm/nvmm-all.c
-@@ -1057,7 +1057,11 @@ nvmm_process_section(MemoryRegionSection
+@@ -984,7 +984,7 @@ nvmm_init_vcpu(CPUState *cpu)
+         }
+     }
+
+-    qcpu->vcpu_dirty = true;
++    cpu->vcpu_dirty = true;
+     cpu->accel = qcpu;
+
+     return 0;
+@@ -1059,7 +1059,11 @@ nvmm_process_section(MemoryRegionSection
       unsigned int delta;
       uintptr_t hva;


