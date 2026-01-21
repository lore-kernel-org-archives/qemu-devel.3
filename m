Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A28E5C44506
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 22:02:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vigHE-0001CA-V5; Wed, 21 Jan 2026 17:02:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <michael@anarch128.org>)
 id 1vif6e-0002Q4-4i
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 15:47:12 -0500
Received: from anarch128.org ([2001:4801:7825:104:be76:4eff:fe10:52ae])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <michael@anarch128.org>)
 id 1vif6c-0001XS-80
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 15:47:11 -0500
Received: from [192.168.1.3] (dynamic-cpe-pool.orcon.net.nz [121.99.116.25]
 (may be forged)) (authenticated bits=0)
 by anarch128.org (8.15.2/8.15.2/Debian-22+deb11u3) with ESMTPSA id
 60LKkr7s2202517
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 21 Jan 2026 20:46:56 GMT
Authentication-Results: anarch128.org; dmarc=fail (p=reject dis=none)
 header.from=anarch128.org
Authentication-Results: anarch128.org; arc=none
ARC-Seal: i=1; a=rsa-sha256; d=anarch128.org; s=100003; t=1769028416; cv=none;
 b=R/KW937ozcY0AENnUyWuDPMWsR+ug7GoRE0P5r1+p2cxjuunaLB4TW8n4MxBopDuvXjcxHzh675rVtGPseAT6gFgQCsW/Slxa/4FQYoQzOyvr528hIrzYWIAtoOA8D8JG6g/PGeA9HsT9yGceyNtWBIk45XZLjM7CayrKDQGt9GIRfVS6QcNeqq6Gj2TzXkwt+Ypwz9/rd8FmY8SzbWU5m1LqRO7sHQ+2qw07tUGlG0tP+V1UifFBZmefrZzvRHu+9qP1tL1KWEQzBwqwEh7JvFmixwHcQIDABxrBVTF5GBh7e4oZiilTC8g7Upnhyfuxt4B8BDl9s0LZPZSQpae9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=anarch128.org; s=100003;
 t=1769028416; c=relaxed/simple;
 bh=s+FEDyij42DwGmbYKhAiuyT/g9zXE6lV26zbuKsoqJc=;
 h=DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:From:
 Subject:To:Content-Language:Content-Type:
 Content-Transfer-Encoding;
 b=mGdGp3MkZKVKpaGDgFQrM0OCYl6Bd2W2H1DdqCFQ/0KrrMLSaGXP8FQFgdngQUqM6bJn2EYbWO+s7OJCVPTVdh4kBYiRWND9NLNkcCdmAPYn3vstPDhWXmTYbX2Fw79A9jwv+gLqI32qwXHaL+q1PaqWsajQhK3hdlbN/I0k1QO9vYegNkNn1NvyvbqfZiMhNQhBMXlCFyTDVDhpVxCx8DdjF2szR+v8VqeCk2W23xIkjtuByQp2WaVfmtPlykpHSHTFRWJw28oiy58nTx4my4NT3S+VlnM2vnpnyR5eAb+p3/tVU4+ReAJbgUNkrpJfU8JxE4WqHTlp/ju4hEyWvA==
ARC-Authentication-Results: i=1; anarch128.org; dkim=none (no signatures found);
 (null)=pass (MX Records found: mail.anarch128.org)
 smtp.domain=anarch128.org policy.is_org=yes; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=anarch128.org;
 s=100003; t=1769028416;
 bh=s+FEDyij42DwGmbYKhAiuyT/g9zXE6lV26zbuKsoqJc=;
 h=Date:From:Subject:To:From;
 b=fTci60pH/uekN2MhwKIQGdYM1PVbhk/gju4U3bDyBOU7PucXSNQ4Otlr2rN1vSJ5E
 miZsBNKv3DE8of0ZF+Ws5rrrO9FPku6V1uib0U+VUSlRxJu1Q7jtLbQ/h1vxdvC3/e
 V0RKHJRaaknuPBVKV/CDbFyeigAOfwPb4xKHE63Y/D43kfimWEnrGzKz+oEB8ezOdG
 NTV4NFeqFzqst16LZRDktnQHKeEygU1NnRX78MpiwctGPkpRc/c7yIJPlDC8Z6BmrZ
 WUvd2fL8x1dzfNRBRvZIh1NSvcP1wQ5QZQCiNhXHthbls0ITjxamFcbPv9+2SfKvjG
 fhmtIPcgimpiA==
Authentication-Results: anarch128.org; auth=pass;
 dkim=none (no signatures found);
 x-return-mx=pass header.domain=anarch128.org policy.is_org=yes (MX Records
 found: mail.anarch128.org); 
 x-return-mx=pass smtp.domain=anarch128.org policy.is_org=yes (MX Records
 found: mail.anarch128.org)
Message-ID: <997772af-8b58-4550-8b3b-1249d8ae0cb7@anarch128.org>
Date: Thu, 22 Jan 2026 09:46:47 +1300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: GLYPH Instruction Set Architecture
To: qemu-devel <qemu-devel@nongnu.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4801:7825:104:be76:4eff:fe10:52ae;
 envelope-from=michael@anarch128.org; helo=anarch128.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 21 Jan 2026 17:01:56 -0500
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
Reply-to:  Michael Clark <michael@anarch128.org>
From:  Michael Clark via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Folks,

an update to the GLYPH ISA with specification of the vector registers:

     latest: https://metaparadigm.com/~mclark/glyph-20260122.pdf
     current: https://metaparadigm.com/~mclark/glyph.pdf
     source: https://github.com/michaeljclark/glyph
     source: https://github.com/michaeljclark/x86

GLYPH has been designed from the perspective of an emulator developer.
it has many features that make it ideal for emulation. it has twice as
many registers as mainstream CPU architectures which means privileged
state can be mapped to registers. it also has a software-defined MMU.

GLYPH design

GLYPH was designed after reflection on the combinatorial complexity of
X86 instruction decode and the complexity of constant synthesis in
RISC-V. the GLYPH ISA adopts an even simpler length decoding scheme than
present-day RISC-V, at the expense of losing a bit of coding space in
the 16-bit packet. the goal is that after quantitative evaluation, we
can win back some density with more compact constant synthesis due to
the "constant stream," which is analogous to push constants in Vulkan.

GLYPH has 16/32/64-bit instruction packets. at present, only the 16-bit
packet has been placed, and it has been placed based on analysis of
common X86 prolog epilog codegen sequences seen in QEMU for X86-64,
with special PC-relative loads and stores designed to fish pointers
from .data sections and operations for register save/restore, pointer
arithmetic, and loops. 16-bit instructions are presently limited to
64-bit arithmetic except with sign-extended 32-bit constants. e.g.

   MOVABS reg, imm64
   MOV reg, imm32
   ADD reg, imm32

GLYPH evolution

it is intended that the 64-bit instruction packet will contain Intel
EVEX-like instructions for a 512-bit vector register file, plus the
addition of an extended 4096-bit vector length (i32x128 and f32x128).
there are no special mask registers because the scalar port is 128-bit.
I intend to add 4-lane swizzle to common integer and floating-point
vector operations: VFADD, VFSUB, VFMUL, VFDIV, VFMIN, VFMAX:

     float swizzle bits = { x, y, z, w, 0, 1, -1, NaN }
     int swizzle bits = { x, y, z, w, 0, 1, -1, 2 }

this is so that we can reduce lane shuffle ops for common arithmetic.
here is a 3D cross product, and it maps to current SPIR-V shader caps:

   VFMUL   r4   r1.yzx_  r2.zxy_     ; (ay*bz, az*bx, ax*by)
   VFMUL   r5   r1.zxy_  r2.yzx_     ; (az*by, ax*bz, ay*bx)
   VFSUB   r3   r4       r5          ; cross product in r3

GLYPH future

one of the defining characteristics of the work is that we have tried,
where possible, to use ARPA naming, and that distinguishes this work
from many other instruction set architectures, not in any essential
functional way, but primarily in comprehension. for example, instead
of using topological and logical APIC IDs for IPI targets, we simply
use "thread address" and "thread domain".

Regards,
Michael.

