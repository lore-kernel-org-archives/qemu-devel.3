Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B821E7FDF3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 01:12:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vn4x8-0000CR-37; Mon, 02 Feb 2026 20:11:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vn4x5-0000Bs-Tp
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 20:11:36 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vn4x4-0007YM-9s
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 20:11:35 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2a09a3bd9c5so35455625ad.3
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 17:11:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770081092; x=1770685892; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2wTD9C7g1r4Qt9O4glRCThVykt+z6nyaT3Yx8fjx5iY=;
 b=eIimSYXlxrHaTTKmplTijnOQ4j0qQxRs8eUkVX4MF0nZtaAAAS25y5BVUUuB5GS+nS
 kPKKCgCmvhdYngqEZXK9PG04zLiJpeMuNIijdCT08x5IcKm9pkDWrcaiqvHHETnII6pH
 w5ISNS7TG2dTHGpEkSEnyFcReNf3xmG321aNEJn2JJHusTZBWhrKWQ7maFkE7Rz6rjyR
 VmOdUPvINA35W5H4vrHpeBagKB1AfPAzuD//Bx5vPMnl2z1vsNzfYSK2+ZT/pVN0ubuI
 8z+aV0mLOSWcLK5kU/BvXhL4c/pPki8vL7lg/ROArD561+jw/ZR7j+NPIjhw1Oe1YnF5
 xDVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770081092; x=1770685892;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2wTD9C7g1r4Qt9O4glRCThVykt+z6nyaT3Yx8fjx5iY=;
 b=a/y1pzSgMByBaiapxhOheR1Ww8zu+Fvs7VtZnaLX2+7ZzzARRR7ZNZNrgGq+uw69V/
 Q/RzqoGVjxFZeEBzmSIOv56iykrCIFFs2ETQecDvasZFrzy0laFiIC9sqYFSCl2Z2yLy
 jrahn/lIXkSswZLRitB6Pcnx5hL2T4A+17WPpGDWxaR5LDxrKeQZgPDqzuzod9wTG1AV
 QqjhiOJd8P90Yf005jWfP0jlENr8aQUq38xePey/xYe7eMWLMokXvTEP8wxoA4i2lLtY
 K9nMRzx0z/rLsljpd1rlFaNBBW+3P9OxrvbAfjDJolxEA5Jmaf/5bhGq9vTw9WQP2t9D
 NwzQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXBXEPiUYA/eTevdolRz2beCKRfAYVFAAiuNVwp1Yj1L1MYx3PrTGbQOt5R/wgyxcEmC5Y2jnS5K/vD@nongnu.org
X-Gm-Message-State: AOJu0YxPniY9C94k9QgE9Q3J3QTb5/JX2wpWC9nOwUmOu/iBkgQ7R7RT
 yMLnfnJI9QWEU5zU5Lusgmu+ZehOMCf2jv5Uln/hDihceW8086OfFm02z3s7WQC/5hs=
X-Gm-Gg: AZuq6aJyIhezTy1/dztWNYGkN2W/f8ZJk3OdM+zYKMEQbf074IdcxMy+/dcGjHtRLwv
 gYYe31sc4Syk9ore9ApHip0tWD6ZwhRHWpOwN2inNjM42qW3LUHpRuTdrJX754AC/y2mEhL/vuX
 NztrbO55JxMlGPXPsfez/bLIRTC85axNglcuGyo35QVDsb25xInQhbP44j1Ag8F0ArYF/TUxR4J
 4mSrPNgBGBJR4+oFjo32P/TI4lMNYs9aZukr/0PsDliAc6vQc/DWGijz/lULb4R8DYugPD871qy
 rDAgZ46WtgOmL3OpOCuYdG65fEj9kCLJcEjhNzMEOVS3jE0LockgwQgL/oxMSPS0IRw93oCrZcH
 HT0Mwg//aFLbLdvlXuockWBfSx/dP+Qfs/uxV4y/fk72UL/zfhueKXi9L7x7VbmGHbHE5HMRWjC
 izpbUNZDFLfWkosrU6vmZS87qKq7kUc05AGhUEfBZ3tLEaIr9CEU0Z4C4Qp+eeh+3wKSpoVwiD
X-Received: by 2002:a17:903:a8f:b0:2a7:d729:6a76 with SMTP id
 d9443c01a7336-2a8d9a72230mr140198415ad.60.1770081092430; 
 Mon, 02 Feb 2026 17:11:32 -0800 (PST)
Received: from ?IPV6:2401:d002:dc0f:2100:1047:c02f:591b:6a5c?
 ([2401:d002:dc0f:2100:1047:c02f:591b:6a5c])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a88b4148d0sm159339075ad.27.2026.02.02.17.11.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Feb 2026 17:11:32 -0800 (PST)
Message-ID: <b7f94202-3924-4fa8-88b3-8532c7e886cb@linaro.org>
Date: Tue, 3 Feb 2026 11:11:27 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/16] Misc HW & Memory API patches for 2026-02-02
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20260202212019.94205-1-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260202212019.94205-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

On 2/3/26 07:20, Philippe Mathieu-Daudé wrote:
> The following changes since commit 587f4a1805c83a4e1d59dd43cb14e0a834843d1d:
> 
>    python: fix msys64 wheel directory specification (2026-02-02 16:46:40 +1000)
> 
> are available in the Git repository at:
> 
>    https://github.com/philmd/qemu.git tags/hw-misc-20260202
> 
> for you to fetch changes up to d8316b64dfbb4fdb706f20c3b42fd9bcf70b0cdc:
> 
>    monitor: Reduce target-specific methods (2026-02-02 22:14:51 +0100)
> 
> Ignoring this checkpatch.pl error:
> 
>    ERROR: unnecessary whitespace before a quoted newline
>    #85: FILE: tests/unit/test-cutils.c:3685:
>    +            "s is \n";
> 
> ----------------------------------------------------------------
> Misc HW & memory API patches
> 
> - Add unit test for qemu_hexdump()
> - Remove legacy native endianness API uses on the Alpha target
> - Remove unused memory_region_init_rom_device_nomigrate()
> - Fix use-after-free in NvmeNamespace "bootindex" suffix
> - Correct documentation of SCSI Rotation Rate field
> - Make iotlb_to_section() work with non-CPU AddressSpaces
> - Reduce few monitor target-specific methods

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/11.0 as appropriate.

r~

