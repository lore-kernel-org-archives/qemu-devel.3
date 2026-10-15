Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBBC5CC6B34
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 12:58:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHL1x-0003vL-2s; Thu, 15 Oct 2026 08:57:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xHL1t-0003sQ-61
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 08:57:54 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xHL1r-000261-Ek
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 08:57:52 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-48afcfc4bf5so436638f8f.1
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 05:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792069070; x=1792673870; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=o1kTbWF6eSR/dGBva+ghoI+u9kpp5kxvRKYTyDQ1H9Q=;
 b=lHwHCj9zsfetLi/ejkBUyqz0EVf73MQCIqkmz5w4diNi/c4AKPAtpxCs4dERWI7ryM
 WaURF32P3ecU9KRg3BRFCddtgcL2uGLKMUplnBnbE+7MBJZen2kRigXhNHXK0s1q3tX9
 nFz4n9rPKStEJRirwRozfRzwH4Go3+bFXT3atf+8fZGq7a7eXgshJhFXR2exzvOXN4CV
 r+zRxof7kcdRtH8L1FG1UcvrBs9cJhfE3Ft/Q26Sn8VhwIS4iutMXi6F5B2CGGGkTBnq
 HpZRp7lBTUmqI7fWJQFfQj2wUpz3xuaXqjC/BBj/mBxa57v9xi6u1/X7aZHvLgKtQaZH
 qkqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792069070; x=1792673870;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=o1kTbWF6eSR/dGBva+ghoI+u9kpp5kxvRKYTyDQ1H9Q=;
 b=uRWkMBNnEAk2pkbILp5S3RNEm2FPxJoobL/uNlpShK7E7sx7KlkzK6O+J9RCQcujJV
 DbUFgS+vdyU0hIvwk63yDCGRINf9t5i4mc6pFnfqrGwRgWi9StwSioD7pafVXhTAarHm
 vDXWB6MR0+8E4vRrlVORQ/cCrzcPM2Ubw/daoEsUUnYZ1CqqgDliyhTLmb+ftNuLZ1i2
 Bb6W/jRIFZjcl2YuRfBhJftFBirekcxSwPqQHW0ZMhbx4Ug+Coy4OTrqsSCzsEfMYZve
 k3QFyWlxwlLOoblPOsaqoYLxmKLNaZLz1Jif5KrCdtoMlZ+3J70Zj2avXHgQFf9Djd9A
 CGSQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBw+zEvNf60xIKx0oAFlq/4KYUu7AGxwHA1T6GpvPM4kVH4Cd8JhxCO4EtX34QhgP1QovfMCS0+4h7bn@nongnu.org
X-Gm-Message-State: AFq9FYJjNqY4R2Mh4/FdSMIC2TZWAckkTWeU1eddDsaPTJwNw2yasxf8
 oTynyjsdFBjjQrTesjYW6rj4m180Ete5CPvpAeWr/5m9H1c4zXr2NVAGtRfqI+JIz3TakiXNLo7
 EnwD8HJw=
X-Gm-Gg: AYBFou30mRI0XLw1VVVPgI3EP9Yuyu+wZKImBZywvm84qvRho37ON8EAs5HCBk2wnpJ
 /OEfZkt3xm2GCixuLF/jrL2bpr4vlTy8XtQndIUTLFJ7rgZB07aUt2E8dFa0ujO79XJv1mOP78z
 VcBFc9Q9Gb7EvUQ74poE2cnjFLne+8AFz+au0UA+fs+pkIlMGuolNKme53CB3LuFLNa6PYW5hSP
 WzNg1yLpkI4fmtYWguEKdCom/bqr1Qmz0NMnM1/2nGCqN2mVw4i5X587ahp1+JzP44/xgwlRzVI
 po0TR0Pfw4qlyIMW0enqX4dsVuVrtWx2wsFb5LfRCple7rWAPu7BvQFPSZTaMYZOLGxFGHu+qKI
 l/+m8iUyNF64O6LDxRZCmC9tDzrkpsigAronGjjoMgIiL0u1dTJsudtQIY+oz7YuQedfRQFk3b/
 9r6AAkGjj0rwvUKXtEgU2LS4tEC56BTxiazOcOPA/OnEhLsfLYXBFeqbBXFlk97RWgSIPcJrBfx
 4kIHlOFeSn37bKB/ZIvxoXo+5sMup966DVQjn16fa5lw35Cq7t0taKaAbE2+itFVG/LePCpFaRP
 IIJDk3Y0+CM6VISpO3o1GpTQ3c+zH3r3Op7ILzvUOQ==
X-Received: by 2002:a5d:5f43:0:b0:48d:f464:6989 with SMTP id
 ffacd0b85a97d-48df4646c70mr4309346f8f.27.1792069069796; 
 Thu, 15 Oct 2026 05:57:49 -0700 (PDT)
Received: from ?IPV6:2003:ca:3f0f:8b00:6e0e:d1a6:87ab:6860?
 (p200300ca3f0f8b006e0ed1a687ab6860.dip0.t-ipconnect.de.
 [2003:ca:3f0f:8b00:6e0e:d1a6:87ab:6860])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48df8316eeesm2407563f8f.7.2026.10.15.05.57.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Oct 2026 05:57:49 -0700 (PDT)
Message-ID: <d14eddc4-877c-4c8e-98bf-ec3cd2da245a@linaro.org>
Date: Thu, 15 Oct 2026 14:57:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/13] target/i386/tcg, SCSI changes for 2026-10-15
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20261015105347.827029-1-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261015105347.827029-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/15/26 12:53, Paolo Bonzini wrote:
> The following changes since commit 615ece3c406b262996e569f29ea6eed0d81c4d8d:
> 
>    Merge tag 'for-upstream' ofhttps://gitlab.com/bonzini/qemu into staging (2026-10-09 15:49:53 +0200)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/bonzini/qemu.git tags/for-upstream
> 
> for you to fetch changes up to eec2d0c16d4a2541a14f5a1867812a508ba7b95e:
> 
>    scsi: document PR_HELPER_CLEANUP command (2026-10-15 12:05:44 +0200)
> 
> ----------------------------------------------------------------
> * target/i386/tcg: zero FXSAVE FOP and reserved slot bytes
> * target/i386: fix immediate stack adjustment for RET and RETF
> * target/i386/tcg: remove unused operand types
> * pr-manager-helper: fix sense buffer overflow
> * scsi, pr-helper: clean up multipathd PR state after migration

Applied, thanks.

r~

