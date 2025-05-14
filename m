Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22CEFC3ABCC
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 12:53:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFBbr-0003BG-JA; Wed, 14 May 2025 08:53:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <michael@anarch128.org>)
 id 1uFBbo-00038Y-4i
 for qemu-devel@nongnu.org; Wed, 14 May 2025 08:53:16 -0400
Received: from anarch128.org ([2001:4801:7825:104:be76:4eff:fe10:52ae])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <michael@anarch128.org>)
 id 1uFBbi-0007Of-GL
 for qemu-devel@nongnu.org; Wed, 14 May 2025 08:53:15 -0400
Received: from [192.168.1.4] (dynamic-cpe-pool.orcon.net.nz [121.99.116.25]
 (may be forged)) (authenticated bits=0)
 by anarch128.org (8.15.2/8.15.2/Debian-22+deb11u3) with ESMTPSA id
 54ECqw621202651
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
 Wed, 14 May 2025 12:53:01 GMT
Authentication-Results: anarch128.org; auth=pass;
 dkim=pass (2048-bit rsa key sha256) header.d=anarch128.org
 header.i=@anarch128.org header.b=FL0gYaOY header.a=rsa-sha256 header.s=100003;
 x-return-mx=pass header.domain=anarch128.org policy.is_org=yes (MX Records
 found: mail.anarch128.org); 
 x-return-mx=pass smtp.domain=anarch128.org policy.is_org=yes (MX Records
 found: mail.anarch128.org)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=anarch128.org;
 s=100003; t=1747227183;
 bh=6AgvbNx+XejMhHh4GYrbCPKir6fGqilbVFHMDF+C5F8=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=FL0gYaOYxpTkXRLotgp1coy5Z3RyBbZe99bfRUqdhui8QXxv41bjL/XIw6Hbsc1oG
 emarqCtZhiJLMQTydZn4RGbUQ9wVb7w7qKMimuSVwXV86n7GdyrdJ3/HdIIy8HfvIS
 ZmWSSL1ykewrYeg2r43D3eKpT/IX4p58nxlwNUPbOvl61KjeS3tefLT7WVITduoFJq
 T32IhZl19RlA7ODb5PqSPPmeJrI71kU8N6Z68oThAnavom3rpRyMmP3pwV2nPvHgHG
 LwJideN7RufmiEKTwYBkxS1x/odRXvMR1ZLbc4rhS/gOo+qSSnQqXFlqI4C/cOKTwr
 6ChJkUfgA93hQ==
Message-ID: <50b4bbe3-6214-4bf4-b22f-3bf90d7ea8e0@anarch128.org>
Date: Thu, 15 May 2025 00:52:52 +1200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] x86-disas: add x86-mini disassembler implementation
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>
References: <20250514073927.2735727-1-michael@anarch128.org>
 <20250514073927.2735727-5-michael@anarch128.org>
 <aCRROhtUyLK7axOf@redhat.com>
 <6f3e890f-5424-4052-9025-696ca1426c36@anarch128.org>
 <aCRjhghDuv4EuLr4@redhat.com>
Content-Language: en-US
From: Michael Clark <michael@anarch128.org>
In-Reply-To: <aCRjhghDuv4EuLr4@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4801:7825:104:be76:4eff:fe10:52ae;
 envelope-from=michael@anarch128.org; helo=anarch128.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 5/14/25 21:33, Daniel P. Berrangé wrote:
> On Wed, May 14, 2025 at 09:23:58PM +1200, Michael Clark wrote:
>> On 5/14/25 20:17, Daniel P. Berrangé wrote:
>>> On Wed, May 14, 2025 at 07:39:27PM +1200, Michael Clark wrote:
>>>> diff --git a/disas/x86-core.c b/disas/x86-core.c
>>>> new file mode 100644
>>>> index 000000000000..c4f7034e3420
>>>> --- /dev/null
>>>> +++ b/disas/x86-core.c
>>>> @@ -0,0 +1,2716 @@
>>>> +/*
>>>> + * Copyright (c) 2024-2025 Michael Clark
>>>> + *
>>>> + * SPDX-License-Identifier: MIT
>>>
>>> Note that we expect contributions to be under GPL-2.0-or-later, unless
>>> derived from existing code that forces use of a different license, which
>>> needs to be explained in the commit message
>>
>> okay no problem, I can do that. there is a freestanding external origin:
>>
>> https://github.com/michaeljclark/x86
> 
> IIUC, that would only apply to the x86-core.c file - the other files
> tagged with MIT look like thy were written just for QEMU inclusion.

there are two files that should stay MIT licensed:

- disas/x86.h
- disas/x86-core.c

# which bits are neutral

half of x86.h is neutral and represents an expression of C structures
and enumerations that map precisely to the structures and enumerations
in the Intel SDM for the core encoding. things like prefixes, ModRM,
SIB, VEX, EVEX, and the VEX maps which are general and would come
out the same had someone else transcribed them from the Intel SDM,
given that the enum values precisely map to the binary encoding.

# which bits are unique

on the other hand there is a rather unique compression for the opcode
encoding metadata related to densely packing the encoding in the Intel
CSV metadata, as well as a completely new LEX format which is unusual
in that it makes sense had Intel encoded the metadata like this in the
first place, given some reflection on the VEX and EVEX encodings. it
took a surprising amount of time to do this because I started on this
about 5 years ago in May 2020 from looking at my home directory. and
I had several false starts where I completely discarded prior work.

- x86_enc_*, x86_opr_*, and x86_ord_* and x86_codec are unique and
   represent a very densely packed encoding of x86 codec metadata.

it was quite weird to write because I wrote no code for three months,
August to October 2024, just metadata. and I started from scratch
and completely threw out previous attempts which had included some
code from TCG. you can see that the emitter is radically different.

see x86-core.c:x86_codec_write

# what is QEMU-specific

the disassembly stub could change to GPL-2.0-or-later no problem:

- disas/x86-disas.c

# tangent on MIT licensed TCG headers

tangential to this. I have extracted TCG MIT headers from QEMU and
have a separate goal to write a new TCG compiler with the same API
but using this new x86 back-end. I have an unsent draft with some
licensing questions but I decided to just believe the MIT license.

I am choosing to use the interface portion for a new freestanding
TCG-workalike compiler. the Google LLC v. Oracle America Inc.
Supreme Court ruling on fair-use doctrine in relation to interface
header portions of existing works seems to make that plausible.

# tangent on instruction selection

there is an exhaustively complete encoding of AVX-512 that has been
fuzz tested against LLVM and it is small in comparison to capstone.
it could potentially be used as an EVEX emitter inside of QEMU.

but I don't have instruction selection yet. I note the metadata has
been de-duplicated compared to NASM. it does not use data from NASM
but I adopted a consistent coding scheme because NASM has been most
faithful to the Intel SDM metadata, which makes it very easy to add
new instructions because we can just copy-paste from the Intel SDM.

in this way LEX seems like something that should have been there
in the first place. because we don't have extraneous opcode bytes.
it ends up as 2-byte OPC+ModRM with masks, plus maps and prefixes,
either legacy or via VEX/EVEX. it makes the decoder very uniform.

for instruction selection I plan to do a combinatorial expansion
to generate enums mapping to subsets of the encodings for memory
or register operands, or other options like broadcast, more like
the denormalized NASM metadata which has thousands more entries
but auto-generated instead, and with type sizes or without for a
selection based on best fit. enums on the right are work-in-progress
from a new generator so that I can add instruction selection. so
it can't be used as an emitter yet until we have enums because
at the moment the emitter requires the opcode from decode to round
trip as opposed to being populated by instruction selection code.

# typed instruction selection enum expansions

   add rw,rw/mw                ADD_r32_r32
   add rw,rw/mw                ADD_r32_m32
   add rw,rw/mw                ADD_r64_r64
   add rw,rw/mw                ADD_r64_m64

   adc rw/mw,iw                ADC_r32_i32
   adc rw/mw,iw                ADC_m32_i32
   adc rw/mw,iw                ADC_r64_i32
   adc rw/mw,iw                ADC_m64_i32

   vxorps xmm,xmm,xmm/m128     VXORPS_v128_v128_v128
   vxorps xmm,xmm,xmm/m128     VXORPS_v128_v128_m128

# untyped instruction selection enum expansions

   add rw,rw/mw                ADD_rr
   add rw,rw/mw                ADD_rm
   adc rw/mw,iw                ADC_ri
   adc rw/mw,iw                ADC_mi

   vxorps xmm,xmm,xmm/m128     VXORPS_vvv
   vxorps xmm,xmm,xmm/m128     VXORPS_vvm

Michael.

