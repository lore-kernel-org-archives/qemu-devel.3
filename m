Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 329D6C61DC4
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 20:04:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzgKj-0002V0-Du; Thu, 27 Aug 2026 16:04:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wzgKi-0002US-09
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 16:04:20 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wzgKg-0008DD-8K
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 16:04:19 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-3969e82ff8fso144514a91.0
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 13:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787861057; x=1788465857; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=4rCglbz52X7qOdM5cT8BtTl1SNjhvQiQi3859mG0BJ0=;
 b=bHlCgv/t5XEbNkR/kWFZJtmbxOdk4Joa0No2/aybIUM0FJdNoLv7DUcY/+qzX6IuX4
 N+myeXCySR46MLdCFb1iGrHdjsqgg7pUP+FGz8tVHV3+/fn/cDrtJ5j8QNtB/uq47SBS
 MpXIvnBLnmF7lbA9Gkhl3XAh4WVCGpLOdbixeV0Hk29HeLqcJp6gACHa6omPFw06CMyG
 3VKI4rK0Pu6bKgslL1l61XhL9TEuQ9EIDDRj7kygguO5NWkcbi9F6SGt5/WQ12hjGldz
 AIexl4qAu2/BlR9WRv3yV2ibBnqX2so2k/htt7Jf8Whnt+oe0Q969aFnWffqf+i57JLC
 s0IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787861057; x=1788465857;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=4rCglbz52X7qOdM5cT8BtTl1SNjhvQiQi3859mG0BJ0=;
 b=WmgTaE/aCjo+VKxnAxmcL5J1iHfqDrkV+WnIbylwPLQJy7nTD7zDJNdWiB6S3iKUyH
 lvZDVSFA0pbC+uaCcYNRGI/dTg+LAoxR88Y7sevQSYj66gFxyenVuOvZ7rAC6IUm5ctP
 QWb+bjVvLBBprog8J4llT2B9A59UnvRA2CUg5faY0jjCDzECpm8TpeZSGVMmVb3Q9jMe
 jZss475kevuNdeWs+GpMObcnS6FmdOmMEMQwaBZAWxSWvgT1rNw+3Bt5HEz3jB3iqm6C
 BIJJQOzMU7A9LnWPZVtrXfhjCEueckL3GCXo8VZblfVgW76oYEksECHe+jLF8QRFz9Ld
 Fd1Q==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpt801E7nurLFGm5Q9V6ixKQ1PaFS+WNBBaW7TiE66Wav9xRPUZwboMkIOJNAj2tLqh4cQS27XRQG9d@nongnu.org
X-Gm-Message-State: AFuF++nyF0HSH9wkj7J3Q0mlLx932oZL9xi4anEtewMdcmxAO3xNwJuQ
 j1wIkwiPnWnkkNi9lF9cMXg4oDORmphUAvgmYv/3+g0KKQAFuA/dQ1Ens55/rAqgYMk=
X-Gm-Gg: AR+sD109g37prvG4twcSfqv1Onz/rl4h3jMvcwl1zoWUSic0PvyLuBNntxmF5kUjzlc
 VbArch7pQHl0Hebv5S4fRcA3p66igDL7ur57Gs+fRGHhmnzujjtTOUHjdNGDtBdAgZyL0BD0Gm7
 UfmMIDVRPyzKWggxEjHh+co/dHKTLowm1Mf1BOmvYW6mEKyP9w8yk5zAiulHTgj2mzEPCNQYlbo
 bXCkxCCJ1Wm6s5bS67Mbe16cY9Gt6Fj4Nh0P+SDv2gNNQjuZwVYuViCHuXwgux7CY6d0StX1agT
 U4K9eBm8zj+VPy1cDpG8UMXJcY2Kt2gdVowsQtNGNlZ8492fU5kvNzWvh82BICfCjfydRIFsx2H
 azBBNUAyj3q2ZIBKeRWkEQusVUqWi+iKMTJesqeDw7TgSvUVj2CtoOSOpDeom+1SXxsAzBHidbY
 Az8kkQLdF7H2aOVW+iKIBXyeBTpLcvxssgUDJNkWQNBv3goL/+Bl2yMhJvUrCh4wMcKcIVSFjEY
 wX/6m31qmrt5A+FotHwJp992TTf
X-Received: by 2002:a17:90b:1a92:b0:396:4d8c:6c4 with SMTP id
 98e67ed59e1d1-396d0f4554fmr2652646a91.14.1787861056729; 
 Thu, 27 Aug 2026 13:04:16 -0700 (PDT)
Received: from [192.168.0.4] (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-396b0ea80edsm4038315a91.1.2026.08.27.13.04.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Aug 2026 13:04:16 -0700 (PDT)
Message-ID: <6a420a4e-1f0e-4a32-a4bc-d41faa407f77@linaro.org>
Date: Thu, 27 Aug 2026 13:04:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/23] Rust, i386, SCSI changes for 2026-08-27
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20260827141314.1099352-1-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260827141314.1099352-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102e.google.com
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

On 8/27/26 07:12, Paolo Bonzini wrote:
> The following changes since commit f57fc2f7ce667b6527582862e69d526edd3ee0e2:
> 
>    Merge tag 'for-upstream' ofhttps://gitlab.com/bonzini/qemu into staging (2026-08-20 16:01:59 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/bonzini/qemu.git tags/for-upstream
> 
> for you to fetch changes up to cfa6e2c52ca8f756461fe41f4ce40e61a82fd914:
> 
>    i386/vapic: unref MemoryRegion if vapic_map_rom_writable fails (2026-08-27 14:02:31 +0200)
> 
> ----------------------------------------------------------------
> * rust: introduce script to update crates
> * rust: update dependent crates
> * target/i386: tcg: small cleanups
> * target/i386: tcg: decoder cleanups around VEX prefix
> * scsi-disk: disable MODE SELECT block size change by default
> * scsi-disk: fix out-of-bounds read in WRITE SAME
> * hw/i386: harden vapic against mapping the writable region over SMRAM

Applied, thanks.

r~

