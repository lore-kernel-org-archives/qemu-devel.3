Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C38B1F9D0C9
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 12:10:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCcap-0001cw-Kh; Tue, 14 Apr 2026 08:10:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1wCcan-0001cN-IA
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 08:10:10 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1wCcah-0004yl-Lt
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 08:10:08 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-482f454be5bso58158455e9.0
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2026 05:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776168601; x=1776773401; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BGLiCqxc+sZUWsp9H4FUgQejtSA17QSl//MP5Mn+Bng=;
 b=nPGEh/AscnLXde9rY0hU+PFcDqZMH3xirLlN15edvBH+hC6l7jb3dD3eQBUcNmmGY6
 WqUdQ7o5d36+l3Uk0c5pFcvxAyFBqfTUqo1X6M8wEF6b9+//15cESsLxLJdg+EEn7CEY
 xHYXgfm4HqE+6e5wa7GNJuHjoJWMp4VpBgwx4TMnzf6yEg3TqoY3LUoAAXESq/0iJJjM
 NFBgAgB0d43kpPn7Cb+wqhLGU/Xpa7O4zMW1Q6jOm0xHWvyXG/dU/aj+HZT/dSRTxrEy
 N9PXRNFP+cCp5NA6OVnm0dYVrNA0y8Rv8mgOVFmxeRwpAktxeWavn/V0G/SdDAXtqI1E
 LUSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776168601; x=1776773401;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BGLiCqxc+sZUWsp9H4FUgQejtSA17QSl//MP5Mn+Bng=;
 b=oMSNIdF5AAWOp5m7KKsZbpk8A3GOIsAVEfGAA+upvDytv/v2ShclfzSv6fIhBgkbNI
 IR3zx5/2XEBmIHPYiSS1FFvpIJvAx2ER6gh3sOJMkk6ZxQsgttsBXeOdM3J05XCJ5SBf
 raAOPsBJlaz8YJOZMyzZeRk1cC9/zzEQ0xKxBhB77e42p3Hj9ZjZzuQnH8ugTwYREEQl
 gXX7IJlqgQ9TUSAxPI5i+WPYyWum2+WkhiaiFrNiFNg9gEkTYe0A9C8MGCXJXpKyVZB4
 VTlZ7Bden6NRm9A/jw3pDNSIwhNrp3vB7ANViMC5SGKwreSYGhK041M/unQLuEhWxgHW
 fakA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/nBSv/sHw/2O0lfybchaQ+kM+mlHUpeJWrCilKTSLVh8LwHZl/s7Zvxv8r40lBDgGv+IO2M2yWZLlw@nongnu.org
X-Gm-Message-State: AOJu0YxMH7Cs4tkQXdnR8NyJJZrvOp3k94uJ7UB1/+si47akWJsEpXYt
 hGxFsZfu6eM/hoShXoP+90BxBDuMoKKv8eKCwLLIEJpr1XiOi9XCRqpz
X-Gm-Gg: AeBDieveMMFO21R2kRKx353c/1pBO1FfYVxB1KpwBmyZI40L9iBfZa8+5TOeWAbb466
 lMdgTtFjCRBNw4d8gALQ1Rn97+LynWAp86XoqSAa0F7xxhPIBcQ0Vy/b8zhS6kpt8g0i6goaE3+
 3l++12Tfsb/eiVewrG0ke1C6I/YOl2pKbI0ASp1PCaRgzRtJue2z3YXycN+32BX+k+hqF9Wcsmj
 AmUGsyendRkq1qxu865BzPUf1QYjYX18kXk68VbQpMSTbiLkymM6gorEEKShDiGmW+JpLQXfhIi
 oy7iPqiN0g2XXEVFaUY3jjQjDB2oeaYpKS1m4C6sGEh4A/iES6oEYAk4Yjhelj4rxDF4YtK4bUF
 IQI9DydXEi0bbvkTucEY4RgmUONdaMFni3I3BoDFNjuwoyQI1b3Xi9RI3yNE20q4X4EMkohwYmJ
 8fU8clP01+5QJ9++YcBGrHaCbjVUE7jGq0e8Lkq3PXL6XldkHq4U8w45s42adp/ZZGYWw/CB87F
 oNikyEfgaiWKH6osVug
X-Received: by 2002:a05:600c:609a:b0:485:3e00:944a with SMTP id
 5b1f17b1804b1-488d68ae78amr229494945e9.9.1776168600549; 
 Tue, 14 Apr 2026 05:10:00 -0700 (PDT)
Received: from ehlo.thunderbird.net
 (p200300faaf1c6100004fcff454cbdf8f.dip0.t-ipconnect.de.
 [2003:fa:af1c:6100:4f:cff4:54cb:df8f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488ec77508csm70036345e9.0.2026.04.14.05.09.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Apr 2026 05:10:00 -0700 (PDT)
Date: Tue, 14 Apr 2026 12:09:57 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Pavel Pisa <pisa@fel.cvut.cz>
CC: =?UTF-8?Q?Maty=C3=A1=C5=A1_Bobek?= <matyas.bobek@gmail.com>,
 qemu-devel@nongnu.org, Matyas Bobek <bobekmat@fel.cvut.cz>,
 qemu-arm@nongnu.org, Marc Kleine-Budde <mkl@pengutronix.de>,
 Oliver Hartkopp <socketcan@hartkopp.net>,
 Nikita Ostrenkov <n.ostrenkov@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v2 4/7] hw/net/can/flexcan: NXP FlexCAN core emulation
In-Reply-To: <202604140030.35350.pisa@fel.cvut.cz>
References: <cover.1773866323.git.matyas.bobek@gmail.com>
 <e790990bfaaebf2c1dd884c2c2f4eab5de6d4076.1773866323.git.matyas.bobek@gmail.com>
 <9c21bd91-3732-4438-9b83-dc36e09f9ec3@gmail.com>
 <202604140030.35350.pisa@fel.cvut.cz>
Message-ID: <299DB2A5-4F8A-4985-8E84-A0530D540442@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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



Am 13=2E April 2026 22:30:35 UTC schrieb Pavel Pisa <pisa@fel=2Ecvut=2Ecz>=
:
>Dear Bernhard,

Hi Pavel,

>thanks for time for review=2E I agree with all suggested
>changes except one where I express soft opinion
>to keep code as it is, see below=2E=20
>
>On Monday 13 of April 2026 12:56:40 Bernhard Beschow wrote:
>> Am 19=2E M=C3=A4rz 2026 19:13:11 UTC schrieb "Maty=C3=A1=C5=A1 Bobek"
>>
>> <matyas=2Ebobek@gmail=2Ecom>:
>> >Added the FlexCAN2 emulator implementation core, with
>> >CAN_FLEXCAN Kconfig flag and MAINTAINERS entry=2E
>> >
>> >FlexCAN2 version can be found in i=2EMX6 SoCs and others=2E
>> >
>> >More information about the implementation can be found in [1]=2E
>> >
>> >[1]
>> > http://dspace=2Ecvut=2Ecz/bitstream/handle/10467/122654/F3-BP-2025-Bo=
bek-Maty
>> >as-BP_Bobek_FlexCAN_final_4=2Epdf
>> >
>> >Signed-off-by: Maty=C3=A1=C5=A1 Bobek <matyas=2Ebobek@gmail=2Ecom>
>> >---
>=2E=2E=2E
>> >+    flexcan_irq_update(s);
>> >+}
>> >+
>> >+static void flexcan_mem_write(void *opaque, hwaddr addr, uint64_t val=
,
>> >+                              unsigned size)
>> >+{
>> >+    FlexcanState *s =3D opaque;
>> >+
>> >+    flexcan_trace_mem_op(s, addr, val, size, true);
>> >+    flexcan_reg_write(s, addr, (uint32_t)val);
>>
>> The contribution of this method is now only to add a trace statement=2E=
 It
>> can now be merged with flexcan_reg_write(), keeping the
>> flexcan_mem_write() identifier=2E
>>
>> Note: I suggest to call the trace function just before the switch
>> statement, i=2Ee=2E after the variable declarations=2E
>
>I would suggest to keep names
>
>  flexcan_mem_write()
>  flexcan_mem_read()
>
>not to change one to flexcan_reg_write=2E The flexcan_reg_write()
>can be absorbed into flexcan_mem_write() for now

Yes, that's what I meant=2E

> but for longer term
>I would like that message boxes (user memory) writes are separated
>from  register access though overlay structure describing registers
>and in addition even reads from registers are separated from memory
>area=2E That would better fit newer version of FlexCAN controllers=2E
>For example on the imxRT there is FD capable FlexCAN and ranges
>
> 0x0000 to 0x007f (used up to 0x53) is range for registers
> 0x0080 to 0x047F is for up to 64 frames, data 8 byte (16 bytes each)
> 0x0880 to 0x097C is range for Rx Individual Mask Registers (RXIMR0 - RXI=
MR63)
> 0x0BF0 to 0x0D2f is again registers area, i=2Ee=2E enhanced CAN bit-timi=
ng=20
> 0x2000 to 0x204f is allocates the Enhanced Rx FIFO output
> 0x3000 to 0x31FC is enhanced Rx FIFO filter element
>
>So this is mix and may it there are even more variations between
>different versions=2E So in these cases I would prefer to keep registers
>block as separate structures, which needs RO/RW masks side effects
>handling and memory areas in between as more regular RAM with no
>masking and simpler side effects rules=2E
>
>But I consider as the priority to have basic support which passes
>review, is mainlined and can be used for imx6 developmet and CI testing
>now=2E When we or somebody else find somebody with interrest at universit=
y
>(i=2Ee=2E final thesis, GSoC project) or some company willing to provide
>some their developers time or funding, it can be base to move forward=2E
>But there is no plan on my side at this moment=2E All my organization
>and conceive of the QEMU CAN subsystem is personal activity without any
>income and I have lot of other much higher priority projects for teaching
>and even use in the the wild including space, so I cannot promise anythin=
g
>nor predict any dates when something is ready=2E=2E=2E

For now, I propose to keep the code simple and only introduce the complexi=
ty that is actually used=2E That is, we can add the complexity once new dev=
ice models are implemented which require it=2E

>
>By the way, I have noticed that you invest time into ESP32 mainlining
>support=2E

Well, I haven't planned that=2E Maintaining it would be a lot of work, esp=
ecially as a volunteer=2E Though I'd like to see Espressif upstreaming thei=
r work=2E=2E=2E

Best regards,
Bernhard

>If you are willing to discuss that, I would open another
>therad=2E I have tested original Espressinf QEMU version and tried
>yours but end by segmentation-fault=2E May it be incorrect arguments
>to QEMU=2E
>
>The ESP32C3 QEMU support could be interesting for RTEMS community which
>included basic ESP32C3 support in mainline
>
>  https://users=2Ertems=2Eorg/t/rtems-support-for-esp32-xtensa-existing-b=
sp-work/660
>
>and I have tested Michal Lenc's contributed RTEMS SJA1000 CAN driver
>with real ESP32C3 chip up to detect and configuration phase and QEMU woul=
d
>be great for CI and Espressinf and Yours QEMU already maps SJA1000/TWAI=
=2E
>The RTEMS ESP32C6 support has proposal for this year RTEMS GSoC=2E
>The ESP32C5 and ESP32S31 are even more interesting because they provide
>motion control, CAN FD and the last one even wired Ethernet=2E=20
>
>Best wishes
>
>                Pavel
>
>                Pavel Pisa
>    phone:      +420 603531357
>    e-mail:     pisa@cmp=2Efelk=2Ecvut=2Ecz
>    Department of Control Engineering FEE CVUT
>    Karlovo namesti 13, 121 35, Prague 2
>    university: http://control=2Efel=2Ecvut=2Ecz/
>    personal:   http://cmp=2Efelk=2Ecvut=2Ecz/~pisa
>    social:     https://social=2Ekernel=2Eorg/ppisa
>    projects:   https://www=2Eopenhub=2Enet/accounts/ppisa
>    CAN related:http://canbus=2Epages=2Efel=2Ecvut=2Ecz/
>    RISC-V education: https://comparch=2Eedu=2Ecvut=2Ecz/
>    Open Technologies Research Education and Exchange Services
>    https://gitlab=2Efel=2Ecvut=2Ecz/otrees/org/-/wikis/home

