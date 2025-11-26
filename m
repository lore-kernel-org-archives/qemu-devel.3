Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55D40D0EE10
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Nov 2025 01:33:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vO4Oi-0003mo-J7; Tue, 25 Nov 2025 20:32:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenmiao@openatom.club>)
 id 1vO4OP-0003di-Hy
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 20:32:26 -0500
Received: from sg-1-17.ptr.blmpb.com ([118.26.132.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chenmiao@openatom.club>)
 id 1vO4OF-0004GL-Qq
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 20:32:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=openatom-club.20200927.dkim.feishu.cn; t=1764120714;
 h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=/kGeqQE9Vcb17yeusO4w5RcOzGr7Z4wVYIyHeFVPFmo=;
 b=MBruHgA50S1po4onCgKhp/8ReBW57cY5QFYsfw802RMKqMGHSSW0yhZDE8Z8sD3bWrvrq3
 BQAiEbDQJDzfadMDxMfw2JR2lI4+J0yZ+F0lRuNmlV36zgOunqM7tX2JDjE2yMh1GCHYu2
 5+MC9OxoBTaE/dIPHSnohetxPAQ7g4rD09a1T63vyJ4iLkSOe52DZXGIKsyax62rf7IdaG
 W5cdrioa0x5omKAsdTCzuQv2txYcu9rzagduoOZ9XiRL7O2m3ojFiglNZNUFYnA8E65I1Q
 YjsUbZe1H4xso2IeVS0btwSSc8Tn6Cjh+pjB+sYr2Lsdl6ydYNk7Es0MkLKQPw==
Date: Wed, 26 Nov 2025 09:31:50 +0800
Message-Id: <10c40d33-39ab-4078-8ef5-ccd31a7a1982@openatom.club>
In-Reply-To: <CABgObfap3WcggLUkRh5u6i44fA9krrmr4ufJj8M6tdVy-FQH7A@mail.gmail.com>
To: "Paolo Bonzini" <pbonzini@redhat.com>
Cc: <zhao1.liu@intel.com>, <manos.pitsidianakis@linaro.org>, 
 <richard.henderson@linaro.org>, <philmd@linaro.org>, 
 <chao.liu@openatom.club>, <qemu-rust@nongnu.org>, 
 <qemu-devel@nongnu.org>, <hust-os-kernel-patches@googlegroups.com>
From: "Chen Miao" <chenmiao@openatom.club>
X-Original-From: Chen Miao <chenmiao@openatom.club>
X-Lms-Return-Path: <lba+269265888+58f799+nongnu.org+chenmiao@openatom.club>
Subject: Re: [RFC PATCH v2 0/5] rust/hw: Add the I2C and the first GPIO device
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
User-Agent: Mozilla Thunderbird
References: <cover.1761644606.git.chenmiao@openatom.club>
 <CABgObfap3WcggLUkRh5u6i44fA9krrmr4ufJj8M6tdVy-FQH7A@mail.gmail.com>
Received: from [198.18.0.1] ([114.249.49.233]) by smtp.feishu.cn with ESMTPS;
 Wed, 26 Nov 2025 09:31:51 +0800
Received-SPF: pass client-ip=118.26.132.17;
 envelope-from=chenmiao@openatom.club; helo=sg-1-17.ptr.blmpb.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, MSGID_FROM_MTA_HEADER=0.001,
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

On 11/25/2025 6:47 PM, Paolo Bonzini wrote:
> On Tue, Oct 28, 2025 at 11:18=E2=80=AFAM chenmiao <chenmiao@openatom.club=
> wrote:
>> We have implemented I2C and the first GPIO device in Rust for QEMU.
>> Additionally, in the respective patches, we have shared our insights and
>> experiences regarding the use of Rust for device modeling within QEMU.
>>
>> 1. The first patch implements the BusState for the I2CBus infrastructure=
.
>> 2. The second patch implements the I2CBus and I2CSlave infrastructure, a=
long
>>     with a discussion of the challenges encountered during the implement=
ation.
>> 3. The third patch moves the struct definition of the PCF8574 to the
>>     corresponding header file.
>> 4. The fourth patch provides a set of necessary helper functions for the=
 PCF8574
>>     GPIO device.
>> 5. The fifth patch implements the PCF8574 GPIO device, along with a disc=
ussion
>>     of the issues and considerations addressed during the implementation=
.
>>
>> Regarding this series of patches, we have found that Rust for QEMU is in=
deed
>> still not mature enough and requires continuous iteration. Additionally,=
 the
>> lack of basic documentation also needs to be addressed. In this regard, =
I hope
>> our team(HUST OpenAtom Open Source Club) can contribute to the documenta=
tion
>> efforts for Rust for QEMU.
>>
>> Link: https://groups.google.com/g/hust-os-kernel-patches/c/z7vHWg3xvDc
>>
>> Signed-off-by: Chao Liu <chao.liu@openatom.club>
>> Signed-off-by: Chen Miao <chenmiao@openatom.club>
> Hi! Are you going to send v3?
>
> Thanks,
>
> Paolo

Hello,

I've been a bit busy lately, but I believe we will complete V3 and send it =
out=20
before mid-December.

Regards,

Chen Miao

>
>> ---
>> Changes in V2:
>>    - According to Zhao's suggestions, some modifications were made to th=
e first
>>      and second patches respectively, such as changing some bus names, a=
dding
>>      some Safety comments, and adding callbacks for I2CSlave.
>>    - While we were making changes to the first PATCH, Chao Liu pointed o=
ut that
>>      the realize function was unnecessary in the bus. After discussion, =
we
>>      removed the bus::realize function. Since no other components are cu=
rrently
>>      using the bus, we added a TODO comment for clarification.
>>
>> chenmiao (5):
>>    rust/hw/core: Add the BusState of rust version
>>    rust/hw/core: Add rust bindings/funcs for i2c bus
>>    hw/gpio: Move the pcf8574 struct to header
>>    rust/hw/core: Provide some interfaces for the GPIO device
>>    rust/hw/gpio: Add the the first gpio device pcf8574
>>
>>   hw/gpio/Kconfig                      |   5 +
>>   hw/gpio/meson.build                  |   2 +-
>>   hw/gpio/pcf8574.c                    |  32 --
>>   include/hw/gpio/pcf8574.h            |  36 +++
>>   rust/Cargo.lock                      |  21 +-
>>   rust/Cargo.toml                      |   1 +
>>   rust/hw/Kconfig                      |   1 +
>>   rust/hw/core/meson.build             |   2 +
>>   rust/hw/core/src/bus.rs              |  44 +++
>>   rust/hw/core/src/i2c.rs              | 421 +++++++++++++++++++++++++++
>>   rust/hw/core/src/irq.rs              |   6 +-
>>   rust/hw/core/src/lib.rs              |   6 +
>>   rust/hw/core/src/qdev.rs             |  12 +-
>>   rust/hw/core/wrapper.h               |   1 +
>>   rust/hw/gpio/Kconfig                 |   2 +
>>   rust/hw/gpio/meson.build             |   1 +
>>   rust/hw/gpio/pcf8574/Cargo.toml      |  31 ++
>>   rust/hw/gpio/pcf8574/build.rs        |   1 +
>>   rust/hw/gpio/pcf8574/meson.build     |  50 ++++
>>   rust/hw/gpio/pcf8574/src/bindings.rs |  29 ++
>>   rust/hw/gpio/pcf8574/src/device.rs   | 180 ++++++++++++
>>   rust/hw/gpio/pcf8574/src/lib.rs      |   4 +
>>   rust/hw/gpio/pcf8574/wrapper.h       |  51 ++++
>>   rust/hw/meson.build                  |   1 +
>>   24 files changed, 902 insertions(+), 38 deletions(-)
>>   create mode 100644 rust/hw/core/src/bus.rs
>>   create mode 100644 rust/hw/core/src/i2c.rs
>>   create mode 100644 rust/hw/gpio/Kconfig
>>   create mode 100644 rust/hw/gpio/meson.build
>>   create mode 100644 rust/hw/gpio/pcf8574/Cargo.toml
>>   create mode 120000 rust/hw/gpio/pcf8574/build.rs
>>   create mode 100644 rust/hw/gpio/pcf8574/meson.build
>>   create mode 100644 rust/hw/gpio/pcf8574/src/bindings.rs
>>   create mode 100644 rust/hw/gpio/pcf8574/src/device.rs
>>   create mode 100644 rust/hw/gpio/pcf8574/src/lib.rs
>>   create mode 100644 rust/hw/gpio/pcf8574/wrapper.h
>>
>> --
>> 2.43.0
>>

