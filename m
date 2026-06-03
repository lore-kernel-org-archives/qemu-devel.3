Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37D8BCD6E55
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 08:02:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUgXQ-0005hS-CM; Wed, 03 Jun 2026 04:01:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wUgXF-0005gw-Du
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 04:01:14 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wUgXC-0003Lm-6M
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 04:01:08 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-490acbb0f89so15931965e9.0
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2026 01:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780473664; x=1781078464; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5o8jccpqzHoAZLu8hqR6tBvp7dftuQUcL1/tQRxvLLo=;
 b=PMd7UkS8vLYWxJTA4lUrcaX/TOjZD/qhFIUs9e4XbHy619y71qvbYjVhK9KyxKfkew
 4FI5ENVWEx45XUamy0s5VgVrfduRPOBoXEnAldVRAuPdnBBdXpKf2+dVszxA4pDKlp1h
 x8ik01M1LhfnQRa6+W9s4nt83y3Ej03j593F/29m/cQyJiqDpIjiMzv7Bg8xjiZe7kgq
 JMjcfyC5B8Rv3rJGJRnDdPpMD26erdM4jfgd5YA9mGdqxX0++iMZ7nOL5s6I5YsJ9gu8
 JiPyyriMXBdqwkk8DvmptJ/gs+mk8mSfd8jLbuQIGBhSKDoxixFoJ/eX8VHXHCMSYpVo
 DVgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780473664; x=1781078464;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5o8jccpqzHoAZLu8hqR6tBvp7dftuQUcL1/tQRxvLLo=;
 b=JNrtaWO1J2n/ACjBMgbTvy0YFW9/6wKbvOTuvWh+25pi/XV2XrcC1Rb/4hdNNID01x
 7C7uybVko7qjVSKFt4zH808p+CuSoZwZxfd2c/S7Q//ByrBF6qghiR0Eiy9U9++rNR7u
 M4xoeWgJAlOhTUeFnC8emSPPqlgfcNh6IvRK21Wt1N0XIkcxVcsNWuZYC7VnQSD3Ej29
 9Wh9ekJiiANG1ywR69ydBs+nW37k7/1dxQVz+R1hresD28LcZnSY9lmUZIILsmOEssaB
 alCFfuiJORCZrZdPjghGywo1yf6cHHfWqZImHefMwV2dEqNzKGgaglU802H9Qn+Reo4u
 /6VA==
X-Gm-Message-State: AOJu0Yyb4v2TdCDTL0rGPgaSwBaoplXobeRMwbvLxSOBbT0oYHuCm/so
 2Ad1FiPprIO5i8jfKy1vEX30/mE8sRk72SCq+oM8DxQ8dJan0T4VqLN2ZWWclOY4Yy1BnrUERKO
 gFIrS
X-Gm-Gg: Acq92OFET9nwGUMI/t0H2/6am+ePqbXdblZlgL2Dhttm8zMbXEhp/eiWkjrqUguh7m5
 LZrKFkOWMQjTXGWBP6o0VIi2dbabvm181HjmOpD14O0D449GLEtxNGwcG/dsUGMr/O5emGWABbD
 TFpYJNUvkMuFVYQBkZY9Awq1paNAE7dNvyZG6eYIuAly3GPDVrc2MGbEF8NsPYHItI1ABIoYlUz
 nMvNq0RSGgSa/iT55XjN9BR261V6n+uTvaZ6j3v/HCy8GmiQKU0ooxE10TXYsh/qA2bLKqwLE0L
 mxvgvv28mOPvsOPHDkJjegzT1vO2mu4ZD/fdkLg3LO7QDX62RXjJazxTOgeGRue9fQ5HbCycryQ
 xEGvKOEvJRYBtEHTzAsZvfI0NBUpoa8lvYrO4ukuhi/9YHf05OSzdNpfK/956O+3QsWmLTXZBwR
 +CSMJmCmtxNO1fu7u1OElGWvUSKjt84x0K4H6fxac4W87K
X-Received: by 2002:a05:600c:1e0f:b0:490:3ff5:737f with SMTP id
 5b1f17b1804b1-490b5ed6353mr31077755e9.18.1780473662338; 
 Wed, 03 Jun 2026 01:01:02 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490b7d6b990sm14862605e9.2.2026.06.03.01.00.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 01:01:00 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A8D4F5F7F0;
 Wed, 03 Jun 2026 09:00:57 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] target/arm: replace cp_regs hashtable lookup with
 direct array index
In-Reply-To: <fff37ec8-1242-4c45-b2bb-d17c672757db@linaro.org> (Richard
 Henderson's message of "Tue, 2 Jun 2026 15:18:05 -0700")
References: <20260518-enhance_arm_gdb_get_sysreg_performance-v1-1-f0a5b22003c0@gmail.com>
 <CAN1cRoPWtbqKgxKPT54=qF6p4Au1y2Hd8-9xEQ+CBSHffEMMVg@mail.gmail.com>
 <fff37ec8-1242-4c45-b2bb-d17c672757db@linaro.org>
User-Agent: mu4e 1.14.1; emacs 30.1
Date: Wed, 03 Jun 2026 09:00:57 +0100
Message-ID: <877boguk7a.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32b.google.com
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

Richard Henderson <richard.henderson@linaro.org> writes:

> On 6/2/26 08:19, abdelrahman elbehery wrote:
>> Ping
>> On Mon, 18 May 2026, 12:58=E2=80=AFpm Abdelrahman Elbehery,
>> <elbeheri95@gmail.com <mailto:elbeheri95@gmail.com>> wrote:
>>     Profiling showed g_hash_table_lookup as a hot spot when running
>> TCG
>>     plugins that log all CPU registers (e.g. execlog with reg=3D*).
>>     Replace it with a direct array index to avoid lookup overhead.
>>     Signed-off-by: Abdelrahman Elbehery <elbeheri95@gmail.com
>> <mailto:elbeheri95@gmail.com>>
>>     ---
>>     While profiling (via callgrind) a TCG plugin that logs all the CPU r=
egisters
>>     (very identical to execlog with reg=3D*) i noticed that arm_gdb_get_=
sysreg is a hot spot,
>>     mostly while calling g_hash_table_lookup. Probably this is due to so=
me hashtable collision
>>     that is handleded by glib internally.
>>     Currently each DynamicGDBFeatureInfo item holds keys for
>> cp_regs, and the keys are always
>>     used to retrieve the ARMCPRegInfo pointer.
>>     By replacing the keys array with a GPtrArray, we now just access
>> reg info directly from
>>     the given index.
>>     The benchmarking was done on c2d-highcpu-16 (16 vCPUs, 32 GB
>> memory) GCP
>>     Setup was to run qemu-system-aarch64 against a buildroot kernel
>> and rootfs
>>     with and without the patch mostly using:
>>      =C2=A0 =C2=A0 --plugin contrib/plugins/libstoptrigger.so,icount=3D2=
000000
>>      =C2=A0 =C2=A0 --plugin contrib/plugins/libexeclog.so,reg=3D*
>>      =C2=A0 =C2=A0 -M virt -cpu cortex-a710 -smp 1
>>     Benchmark showed ~15% performance gain when hashtable is not
>> used.
>>     For benchmarking, i used hyperfine with 3 warmup rounds and 10 itera=
tions each.
>>     ---
>>      =C2=A0target/arm/cpu.h=C2=A0 =C2=A0 =C2=A0|=C2=A0 6 +++---
>>      =C2=A0target/arm/gdbstub.c | 28 ++++++++++++++++------------
>>      =C2=A02 files changed, 19 insertions(+), 15 deletions(-)
>>     diff --git a/target/arm/cpu.h b/target/arm/cpu.h
>>     index
>>     15a13b929276dad161032b61ba51ebbce7eeebc6..8816e94e3f8271ad403e77f618=
2fdb8cee31c527 100644
>>     --- a/target/arm/cpu.h
>>     +++ b/target/arm/cpu.h
>>     @@ -121,15 +121,15 @@
>>      =C2=A0 * DynamicGDBFeatureInfo:
>>      =C2=A0 * @desc: Contains the feature descriptions.
>>      =C2=A0 * @data: A union with data specific to the set of registers
>>     - *=C2=A0 =C2=A0 @cpregs_keys: Array that contains the corresponding=
 Key of
>>     - *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 a =
given cpreg with the same order of the cpreg
>>     + *=C2=A0 =C2=A0 @cpregs_regs: Array that contains the corresponding=
 Register info pointer
>>     + *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 of=
 a given cpreg with the same order of the cpreg
>>      =C2=A0 *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 in the XML description.
>
> This will not work, because each ARMCPU has separate cpreg info
> structures, and these structures only have the lifetime of the ARMCPU
> struct.  We create and destroy these at runtime, so at some point you
> may end up with pointers to freed memory.

Shouldn't it be the same set for each CPU though?

>
>
> r~

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

