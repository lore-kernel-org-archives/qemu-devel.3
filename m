Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9B20C2D0CD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 12:55:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uH01j-0006vc-8Q; Mon, 19 May 2025 08:55:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uH01c-0006tn-ER
 for qemu-devel@nongnu.org; Mon, 19 May 2025 08:55:24 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uH01Y-0000vE-TL
 for qemu-devel@nongnu.org; Mon, 19 May 2025 08:55:23 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3a3681aedf8so1655032f8f.1
 for <qemu-devel@nongnu.org>; Mon, 19 May 2025 05:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747659318; x=1748264118; darn=nongnu.org;
 h=content-transfer-encoding:content-language:cc:to:subject:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uZQ+kqJHnCyn6CHYFHa7sINUJUudzELm10mspg5m5gU=;
 b=zcwytVU+eXD02EMS0/Ltoc19iI+Krf43dXjVQ+buYhZGMu1UE0zTGXRwFDvKFSN8tG
 CDLMOftadxPxhLMJrlaSwaXgv5s15Qlrf6aO8Qg8YC62uDuigxPKLKGl91YN5Es+o6kr
 OvowJQYH+KXmZ3F6g7Wl0wVaheoZZL7ltYR+cZptlsnZKNpTjWRR92Ii/13A3nOjvlhO
 FW4VR+00xhlxmGExFrAK3kxN6P4sp5QPDMYdvXOnOV0pw/xHP4/iY9xG8dDZb6cMAWPG
 iBry9FoWwzsOukYhcSgUzd/j5uOrHUzZhxjvbTuSrGfAUmsIXPT5A2lNb6obk31F2VxF
 7rpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747659318; x=1748264118;
 h=content-transfer-encoding:content-language:cc:to:subject:from
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=uZQ+kqJHnCyn6CHYFHa7sINUJUudzELm10mspg5m5gU=;
 b=QaYQlHSZdyiuQFKnR3jLE+WsqNSo0P4ikA2tTpHV74gVR/MCgB8JczBvUQnuKH1yRa
 V77+Vj/bziNPy61AOFbtX/P3OUfSz4IIpI3DgSzC/9b9rO3rOz0cBpcuifnAhqCSvrUq
 tbCQSlrzTkb5J98AyA53QEfJGmpyzJ7N+dTNdVI+1LUFymXZMmV2VzmPKi9v2hkSnNUF
 8HCyG3QhG3ZwQE1cYq/wuS05SmaAhC8oyIBNxE/R1gZ7E1YWeCjVqO7AfirSI+HtQl7d
 rfypB2CENJK2mv1mW+eNFyeISxXrOStchTNf4JZIg1Zr1D4icC9XmoH9TOoOtruphqLE
 ISKA==
X-Gm-Message-State: AOJu0YyZgqOH4KdW2/DT603VRYGEelrr7Hz45GRM0ZPHFh8Zk2hDls4e
 T+2zlmfbNogoLUsolkUXIbiUxGYTWVZR64Q2gW9BpceDpCPY9W4tLOLVuySmHTPacss=
X-Gm-Gg: ASbGncvfqQIibYpNyp+n9b3Vt84Dyf82dzsDAbrDGfje0UhmDk6ieJk2MB/NRFKVYDE
 KvA/Cw9qJfx59n+Tm74wt+M8lrZSLmMZlTvQYk3wGIUBBDbOnEK/yLm/fyRHPi8dv9Vtrm717ZW
 yxeEbrNMriGB0DJKGu1n/Qbe9XGOCNoytd6EpqLvI/DLGysg8SLNF2p63GVB5yG7yf5aw/mlzYz
 3PgWQLlwOyFRY55vyZuHTjwHONjdPAsoZ83xi6+U89u17j4YvO8wHGO+OMxvk18rhgU8KSSw4SW
 6O4LWpVz7TKW4eFIlVEH0ySOaagDfhgj9YII0fLt9ADQqxx0ljwgrjXJKRgBlc0kJ2/HZ6qFRK/
 YoOdmIBHADy6GPYHdbSeu8w==
X-Google-Smtp-Source: AGHT+IEtjok7RrJKBFwIPsSkIpEI+gx/+Y+6GjhIfP7PI71LVNJJB5JMEHv8kZnpQRQUxxowzk9Obg==
X-Received: by 2002:a05:6000:420c:b0:3a3:7709:3038 with SMTP id
 ffacd0b85a97d-3a3770931fdmr561675f8f.38.1747659317745; 
 Mon, 19 May 2025 05:55:17 -0700 (PDT)
Received: from [172.19.170.213] (168.160.185.81.rev.sfr.net. [81.185.160.168])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a35ca4d1f9sm12586809f8f.1.2025.05.19.05.55.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 May 2025 05:55:17 -0700 (PDT)
Message-ID: <a96c5eb8-4ac1-4f61-9642-cc9102f76e1f@linaro.org>
Date: Mon, 19 May 2025 13:55:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Notes on PFlash C model
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

Hi Manos,

You mentioned you are looking at a Rust implementation of our PFlash
model. IMHO better would be to implement from scratch without looking
at the C code. In case you need to, here are few notes about some
oddities I unfortunately inherited as maintainer.


[*] Interface to write sector to underlying Block Layer is common

W.r.t. accessing underlying Block Layer, AMD/Intel models duplicate
a lot of identical code logic. Except for eventually writing the
current block (which can be cancelled by the guest). For Intel this
was fixed in commit 284a7ee2e29 ("hw/pflash: implement update buffer
for block writes"), for AMD -- which is considered less important
because not used by cloud VMs -- it is still incorrect.


[*] Sector size isn't uniform.

"recent" devices do support more than 1 single block size. Blocks of
different size can't be mixed, they are grouped in "regions". A region
contains blocks of same sector size.
QEMU started only exposing the "num-blocks" and "sector-length"
properties, so we couldn't model regions of different sector size.
At some point the AMD model was extended to use up to 4 groups of
different sizes, via the "num-blocks[0..3]" and "sector-length[0..3]"
properties. This isn't specific to AMD, but we only implemented there.
The "old-multiple-chip-handling" is likely a related kludge for Intel.

Possibly correctly implementing regions might allow to emulate non
power-of-2 virtual parallel NOR flashes, if proven useful to (such
config has been requested for SD cards).


[*] Bus wiring doesn't belong to PFlash models

All the "width", "device-width", "max-device-width", "mappings" and
"big-endian" properties are related to how the DATA and ADDRess lines
are wired on a bus. Models can come with 8bit or 16bit DATA lines, and
there are many possible combinations to wire such devices [1]. Since
PFlash are considered "slow", hardware engineers noticed they could
speed accesses by "interleaving" devices [2], so the following configs
are common:
   - 4x 8-bit flashes
   - 2x 8-bit flashes (emulated word mode, host endianness matters)
   - 2x 16-bit flashes (host endianness matters)
The "mappings" property is related to the ADDRess lines w.r.t. the
host, and is usually described as "aliasing" [3]. I.e. if the host
is configured to see a flash I/O region 2-bit wider than the flash
addressing range, the host will see 2^2 = 4 consecutive times the
same flash I/O region.

Note, it might not be practical (as in, get fast emulation) to use
interleaved memory when the region is executed in place, as these
ROMD devices. Although I believe we could figure something out in
software, reducing the code complexity and simplifying maintenance.


[*] "unlock-addr[0,1]" are not necessary

The unlock sequence is always 0x555 (0b010101010101) then 0xaaa (opposite
0b101010101010) but depending how the address bits are wired and if
the access is byte or word, less address bits will be compared.


[*] "secure" property is a QEMU kludge

PFlashes support region / bank (write) protection, but this wasn't
modelled in QEMU when it was needed. OVMF was developed for virtual
x86 machines and was not interested in doing firmware upgrade, it only
needed a read-only executable storage. Unfortunately instead of using
a plain ROM, it used a PFlash device. "secure" property is enabled to
put a flash in write-protected equivalent, or even fuse-protected,
because the guest could try to unlock banks but will never be able to.
I suppose it is too late to rectify because OVMF uses CFI query to get
the pflash size, although it is fixed.


If re-implementing this today, I'd use the S29GL512T (or S29GL01GT)
datasheet as reference, being the biggest parallel NOR flash produced
(then the industry switched to SPI NOR flashes). It is big enough to
be used by all our boards except the SBSA-Ref (justification in [4]).


[1] "adapt bus wiring in device" in QEMU model is common, for example
     we also use it as "regshift" / "endianness" properties when
     MMIO-mapping the 8250 UART (TYPE_SERIAL_MM) or IDE (TYPE_MMIO_IDE).

[2] For interleaved I/O regions, see discussion
     https://lists.gnu.org/archive/html/qemu-devel/2019-06/msg05395.html
     and implementation:
  
https://lore.kernel.org/qemu-devel/20200817161853.593247-1-f4bug@amsat.org/

[3] For MMIO aliasing, see
  
https://lore.kernel.org/qemu-devel/20210419094329.1402767-2-f4bug@amsat.org/
     in particular for AMD flash:
  
https://lore.kernel.org/qemu-devel/20210419094329.1402767-7-f4bug@amsat.org/
     or q800:
  
https://lore.kernel.org/qemu-devel/20210326002728.1069834-11-f4bug@amsat.org/

[4] CFI-compliant virtual parallel NOR flash on QEMU:
  
https://lore.kernel.org/qemu-devel/CAFEAcA9qVBdLZMO4e+oSaL6kwpF9WS+RdeL3DxBNKVMPwnQ=TQ@mail.gmail.com/

Yes I know, I should respin all of these series...


Hope that helps.

Regards,

Phil.

