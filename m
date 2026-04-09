Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0A5FE98FAC
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 05:04:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAhYn-0004XF-Ct; Thu, 09 Apr 2026 01:04:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wAhYl-0004Wb-7g
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 01:04:07 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wAhYj-0006HA-F8
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 01:04:06 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-488ab2db91aso6292085e9.3
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 22:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775711043; x=1776315843; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dd6UNXO7JeiUNApjr3jnOq1zBzbJl/m6T20BS9iksvY=;
 b=t2c5a+1qsdbjTO7iMFynr4sdTqAdeQH3tFnLa+caSG25t/hAbIcK9PexGyV7vS+bCM
 LVxp6vpMUEbeKETnDpUwvkeNiswfJkFwN4ky3GnlRE+7nlCnjxDQ8zkQOrHG5NAmEGvr
 sUsGW1LUgOX+i5e/G96uezbZvlK46hpaTIQMniSdfNTOdxSgHM1lf165uwY8xWA2R+qi
 NyUWL84DpfNoicR6UVd+86R6dAXzU9DmJftciNaDUQDdxCod5jtWKSTUy7mA3eOL0Mlt
 03RgwzGcDvW3w1WGVkxhNC+dpxmKD61jG5x6ccJ7+UcnUZLZWgUQ0fHhUi5TQ2irdfWb
 nmXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775711043; x=1776315843;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dd6UNXO7JeiUNApjr3jnOq1zBzbJl/m6T20BS9iksvY=;
 b=FeV+GA/C582iLJOgulIhXtWtduo3KSWpH1QgvuAxmdtmNLmeQO9VhDSCh77BNUAlGp
 lKHrB++zo0ZEuXGiI0Yy1Is/nrZPRJMFG1e1ZUGAslYJc3hHyeF82is8Bp8MwBC9jamF
 6G58SQF2SqE6QvQrppEvKXIoPFKCyElzvi+GUGXia4Q1NR1SFOoWwUheXIxcDukPFkni
 S+99+V7IF2G2R7QzPsF1QPMbNOVea2SUY264Rm+xjik3Ir9FuXHbIseTY+owk0fgcWHx
 VVOxnwpYcTORkIygTVitZYTOoIq5xpcE3NGL1E9mancFAW8imgaQW4pQQWxfW3GbiOZ7
 7vNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW56YgZHxdZFUdzXV3EpQM9hDwsX3set3BBLAXitBE0KX+eiKOnAh3ohcKTlKE6chj4E1nV0b0geKmm@nongnu.org
X-Gm-Message-State: AOJu0Yxrn9VfXxBAyG/vA6xoRDm6gYCwt+ay1QlTmpG08QHiFmr/Ibsh
 4Wy8zf7u5FFU2PSVoB2Tb6gpNUiXg9/auXX8H6M5Ng0Qctp+oyB56TwDhmlspI9rgww=
X-Gm-Gg: AeBDievaBSK+aU5JCJCU4j5cwKxcGh14Zybhptu2q0qw7/ngihXr4cVCRFB682x0/Vq
 Jnf6/Mkeu9RfiJuVdoG3MxHmi3v9S16crlyvQDS9M9YWxfFtzUrBsxeJQV9CZaHzsw0qj2obgzT
 XaBN0R1aqcJ/AcjUSDkC43TzBNgKukYYPsG0wb1kuIdWTsAgDExq2qVPpI9iXvJ3NYNel9qs0Nx
 N4WcefPlFhcDawbG7cRBkwc6BHSpOGiJlwA4uWnObbaGwyd3dZzMVrjODQLSL7sx/duqa83cNKk
 swAZ0hLL1mJMt/59vuQo7ToAkPHJNqpmhXJnd3gkb6NGfeua1ZTKDqSuTkWMbnne9DxknCTlPyR
 qFTRtCA+iq0UGPhfHMEBml6/vUEWOCbS2iNBK2c7/jmqOM7CSyMoiuj6GfgsTc7SGdU5H21+I7O
 C/xXMAQZqP4VQY83bRVxIZHhXk6++Siuzy4fcf7MlTdO9zSo4QGn37yTS/gzMxhZgJ+Q==
X-Received: by 2002:a05:600c:4689:b0:488:be21:54ae with SMTP id
 5b1f17b1804b1-488be21569bmr137194405e9.0.1775711043119; 
 Wed, 08 Apr 2026 22:04:03 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d5e969be7sm897338f8f.6.2026.04.08.22.04.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Apr 2026 22:04:01 -0700 (PDT)
Message-ID: <55bf85d3-3b62-4dab-9b21-ec1ca193dd15@linaro.org>
Date: Thu, 9 Apr 2026 07:04:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/7] target/riscv: Add big-endian CPU property
Content-Language: en-US
To: Alistair Francis <alistair23@gmail.com>
Cc: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>,
 "thuth@redhat.com" <thuth@redhat.com>, Chao Liu <chao.liu.zevorn@gmail.com>
References: <20260406154935.144674-1-djordje.todorovic@htecgroup.com>
 <20260406154935.144674-3-djordje.todorovic@htecgroup.com>
 <884193da-0078-44f0-804d-e5ccaf5f3398@linaro.org>
 <CAKmqyKPZRQ6djtJU2w5y=5i6Bt3Nkr7yOe+K0vnj-m_XKvG=Kg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAKmqyKPZRQ6djtJU2w5y=5i6Bt3Nkr7yOe+K0vnj-m_XKvG=Kg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 9/4/26 06:00, Alistair Francis wrote:
> On Wed, Apr 8, 2026 at 12:17 AM Philippe Mathieu-Daudé
> <philmd@linaro.org> wrote:
>>
>> On 6/4/26 17:49, Djordje Todorovic wrote:
>>> Add a "big-endian" boolean property to the RISC-V CPU configuration,
>>> defaulting to false (little-endian). This property allows machine
>>> models to configure individual HARTs for big-endian data operation.
>>>
>>> The RISC-V ISA supports big-endian data accesses via the mstatus
>>> SBE/MBE/UBE bits, while instructions remain always little-endian.
>>> This property provides the configuration interface; subsequent
>>> patches will connect it to the CPU state and translation logic.
>>>
>>> Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
>>> Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
>>> ---
>>>    target/riscv/cpu.c                | 1 +
>>>    target/riscv/cpu_cfg_fields.h.inc | 1 +
>>>    2 files changed, 2 insertions(+)
>>
>>
>>> diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
>>> index 70ec650abf..51436daabf 100644
>>> --- a/target/riscv/cpu_cfg_fields.h.inc
>>> +++ b/target/riscv/cpu_cfg_fields.h.inc
>>> @@ -154,6 +154,7 @@ BOOL_FIELD(ext_xmipscbop)
>>>    BOOL_FIELD(ext_xmipscmov)
>>>    BOOL_FIELD(ext_xmipslsp)
>>>
>>> +BOOL_FIELD(big_endian)
>>
>> Since it is runtime it doesn't belong to RISCVCPUConfig.
> 
> I think the idea is that a user can set the `big-endian` property
> (from the command line or machine) and then MBE, SBE and UBE are
> always 1 and big endian is always enabled. Basically to model
> big-endian only hardware
> 
> So in that context it isn't runtime, but it's not clear from the
> commit description. Also if we are adding a property the property
> should be exposed last, as in once all of the functionality is
> supported. That way we don't have a property that doesn't do anything.
> We would also need documentation added.

Reading "3.1.6.3 Memory Privilege in mstatus Register" it is not
clear to me whether MBE and SBE are hard-wired, I'd have expected
a HART to be able to reset itself in a different endianness, and
in that case the current riscv_cpu_reset_hold() would overwrite that.

> 
> This patch should be merged with patch 3 as well

Indeed.

> 
> Alistair


