Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C104CD5BA4
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 17:22:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPkaU-00036L-Rb; Wed, 20 May 2026 13:20:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPkZX-0001mq-Jd
 for qemu-devel@nongnu.org; Wed, 20 May 2026 13:19:08 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPkZV-000266-5J
 for qemu-devel@nongnu.org; Wed, 20 May 2026 13:19:07 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-48e6db3ff7eso26719275e9.0
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 10:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779297543; x=1779902343; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/kyaJ/nzemdvOsAG6Z3J6mmqZKXxa9crsXJirdrRsf8=;
 b=OZeyV2+G+DsQQCBIlGZJJsqIYyvu8j2vOY8iAcdlynRhDX/Qb+sQbsHlq/xmVOdzz1
 YlBnahUZ0zr/7OziH5w8XPBbb1aKxkj7201+42fK2Mz7ZqpiYlw9AY44fphbJ2wvAUT4
 BKaALktYVkPAjXJpqMPh2wV0fYNrFpBou55nVsIrZcUfmg4YxcCdxPAFL9tugKaUkqv0
 DHTxdhvIJFTVR24H/WvJfAKl6Knf9lliZvlGzeZ9GeaigGiQV2uBNMU8fnW+h5TlcEil
 3QgyCGE5i1eEdpSsFhgphbe2bfqmAwBvnVsswtvEEmZB9Vm5WrS/f2veH4Gdk6asxMHA
 lqig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779297543; x=1779902343;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/kyaJ/nzemdvOsAG6Z3J6mmqZKXxa9crsXJirdrRsf8=;
 b=cG0lDP+vzqCquGpGZWv3BeHQT5QxXhtWhQiyBiZc8JJkJoHgOHmLUBjO6v4knn5unl
 ettlB4L9YlVGknYdhA6F1KFAbVAkDtYW1K5L+4VQqfP0i+wDLMp62MzBJOXs4DhvS3MK
 zwcXK/Prgjc0Vwp8pmvKslfEZo1PVSwooSdQlnnHuyF9biJ6V+YLjWxw9u3D3LYtBrTw
 IWz44bPNqoletg365fW4GnUHdLUTPtMszLWBfz49g1uLTubaYqQ6v1aIUiAVh2rJywdN
 EW8BxH1EcHvVioENWne4Vj+l7C4ENcu/mvokNYdP7ykmHUk6gsKltd9+v6ilezPnM56C
 9/1g==
X-Forwarded-Encrypted: i=1;
 AFNElJ/iQGW9V1hixzfjbofjh/q9qb9MzDTPdaD1Hw7hqQuypTF1Bte3CpIQn1/s87jSQRPyeWK4d6HNnkSK@nongnu.org
X-Gm-Message-State: AOJu0YzR0cZbkVZGh5adqpyx4msrox5ddMEdDuGrnr4iPUDW3GM21g/Y
 i6hg/lFBz+yFM8PcV1q5zwtm3EP4KhCh9LtAfU0NgkVy69s5gzzPBlLXeIXxv1huUjk=
X-Gm-Gg: Acq92OG0it2kpO/syurB3NucgkD8Lii96j1xzBJixC5As6h+mjhYRbdlzKWWUc2MDlU
 ltU43A7KzJeqTaGLpU9QFgHiiSF1IzaugkeHbJyRzAHICRhyqUV/QiQQi1Q6vuLuDEcMsmLdYNV
 PkwoB3pkRU4+SEMl3jfMdgdDR8AVW6ZHrDGgy0XfTJeWQobYPPDhrvV64L8lRxb8/fYpUNxdU3H
 T2lge6rIDvSZmS6lLUp/4tLtxjs5u6Y3YR+o8N1CaB4yL8S/Cd8/aAm0QDfjiaQeyPb92Ty2tST
 KfAWxc2n2b6Hz8gUxcwOTDo1Lue7RpFFtRW0ivH7SLmvuTDlaSLl36K+mW06QHbhJq7FwDrb8Ll
 ZRoJXZHx6Wcp4dkeMqDC5EJyp5hY58uZdoVzesQE7Cang2IR03Fr/cnzCKYwE0xdlaZkpnlTZXK
 pAoOm2ACvrITPsEqy1NJXec5w5AW6Wx+9yOtgWVsKfu2qXS0X8RsZ9DJAh0YiCDLa31ylMmVNR3
 XMR
X-Received: by 2002:a05:600c:6288:b0:490:32da:30d with SMTP id
 5b1f17b1804b1-49032da04e9mr25340955e9.9.1779297542789; 
 Wed, 20 May 2026 10:19:02 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49031731733sm30037185e9.0.2026.05.20.10.19.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 May 2026 10:19:02 -0700 (PDT)
Message-ID: <4533011a-4128-4823-bfd1-cabd3bd0e646@linaro.org>
Date: Wed, 20 May 2026 19:19:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 0/7] Add RISC-V big-endian target support
Content-Language: en-US
To: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "cfu@mips.com" <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>,
 "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>
References: <20260511083819.206216-1-djordje.todorovic@htecgroup.com>
 <5d2b27bb-f8d0-4992-b8dd-719b7a17b516@htecgroup.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <5d2b27bb-f8d0-4992-b8dd-719b7a17b516@htecgroup.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 20/5/26 16:08, Djordje Todorovic wrote:
> Hi all,
> 
> I am wondering, if there is any comment on v9. :)
> 
> Thanks a lot!
> Djordje
> 
> 
> On 5/11/26 10:38, Djordje Todorovic wrote:
>> Rebase on top of master.

More than a "rebase" comment I was hoping to read what was the
conclusion on previous versions about wired endianness bits.

>>
>> Djordje Todorovic (7):
>>     target/riscv: Define MSTATUS_SBE and MSTATUS_MBE bit masks
>>     target/riscv: Add big-endian CPU configuration field and reset logic
>>     target/riscv: Implement runtime data endianness via MSTATUS bits
>>     hw/riscv: Make boot code endianness-aware at runtime
>>     target/riscv: Fix page table walk endianness for big-endian harts
>>     target/riscv: Expose big-endian CPU property and add documentation
>>     target/riscv: Add endianness test for RISC-V BE
>>
>>    docs/system/target-riscv.rst                  | 24 ++++++
>>    hw/riscv/boot.c                               | 81 ++++++++++++++++---
>>    include/hw/riscv/boot.h                       |  1 +
>>    target/riscv/cpu.c                            | 11 +--
>>    target/riscv/cpu.h                            | 23 ++++++
>>    target/riscv/cpu_bits.h                       |  2 +
>>    target/riscv/cpu_cfg_fields.h.inc             |  1 +
>>    target/riscv/cpu_helper.c                     | 28 +++++--
>>    target/riscv/insn_trans/trans_rva.c.inc       |  4 +-
>>    target/riscv/insn_trans/trans_rvd.c.inc       |  4 +-
>>    target/riscv/insn_trans/trans_rvf.c.inc       |  4 +-
>>    target/riscv/insn_trans/trans_rvi.c.inc       |  8 +-
>>    target/riscv/insn_trans/trans_rvzacas.c.inc   |  4 +-
>>    target/riscv/insn_trans/trans_rvzalasr.c.inc  |  4 +-
>>    target/riscv/insn_trans/trans_rvzce.c.inc     |  4 +-
>>    target/riscv/insn_trans/trans_rvzfh.c.inc     |  4 +-
>>    target/riscv/insn_trans/trans_rvzicfiss.c.inc |  4 +-
>>    target/riscv/insn_trans/trans_xmips.c.inc     |  8 +-
>>    target/riscv/insn_trans/trans_xthead.c.inc    | 16 ++--
>>    target/riscv/insn_trans/trans_zilsd.c.inc     |  4 +-
>>    target/riscv/internals.h                      |  9 +--
>>    target/riscv/tcg/tcg-cpu.c                    |  3 +
>>    target/riscv/translate.c                      | 22 ++---
>>    tests/functional/riscv64/meson.build          |  1 +
>>    tests/functional/riscv64/test_endianness.py   | 57 +++++++++++++
>>    25 files changed, 251 insertions(+), 80 deletions(-)
>>    create mode 100644 tests/functional/riscv64/test_endianness.py
>>


