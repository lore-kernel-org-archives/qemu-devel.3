Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEBFCC021A0
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2025 20:25:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjOil-0004BM-32; Sat, 15 Feb 2025 15:25:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <michael@anarch128.org>)
 id 1tjOic-0004AD-JC
 for qemu-devel@nongnu.org; Sat, 15 Feb 2025 15:24:55 -0500
Received: from anarch128.org ([2001:4801:7825:104:be76:4eff:fe10:52ae])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <michael@anarch128.org>)
 id 1tjOiY-0007DT-SS
 for qemu-devel@nongnu.org; Sat, 15 Feb 2025 15:24:53 -0500
Received: from [192.168.1.5] (dynamic-cpe-pool.orcon.net.nz [121.99.116.25]
 (may be forged)) (authenticated bits=0)
 by anarch128.org (8.15.2/8.15.2/Debian-22+deb11u3) with ESMTPSA id
 51FKOicm3790327
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
 Sat, 15 Feb 2025 20:24:46 GMT
Authentication-Results: anarch128.org; auth=pass;
 dkim=pass (2048-bit rsa key sha256) header.d=anarch128.org
 header.i=@anarch128.org header.b=Pk4vitsS header.a=rsa-sha256 header.s=100003;
 x-return-mx=pass header.domain=anarch128.org policy.is_org=yes (MX Records
 found: mail.anarch128.org); 
 x-return-mx=pass smtp.domain=anarch128.org policy.is_org=yes (MX Records
 found: mail.anarch128.org)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=anarch128.org;
 s=100003; t=1739651088;
 bh=azAoXsI93gbRyvtnyubPzfmZ8xu9lcg41E42zu2Q3DU=;
 h=Date:Subject:To:References:From:In-Reply-To:From;
 b=Pk4vitsSSnORxeRYtdOYKT78uBUFEhmEzfvVHduS66Nit/DcW8MqDPIrwkX0MG5mX
 7wtJqu/9yRttYbi4w9LiApP1X+5DqFUg9xaL+U3f2/ascK/dKE5j3PgZ0OWX9TpXM1
 Rb0Xt6K7qkiiHJSxSzgpWFTidcsW+6oWioWAs7JpSipLtAtauRTqk4k0o9+7T+hMOX
 zDxuqIFgdsTnpuKqOqDjB0u9LVKzbYtjaZ+URG8Oil5msaMypEbyN3CilO0eq3qaSL
 2VUPRgenFxTP5YnDWiEyPtLVeGKiGLK/dK2O1RGrj0EE6x0PLDP4Wc2V10fEDRlA6r
 hN4072opfJhMA==
Message-ID: <8f107cd4-f5a2-4d3e-b023-5e53225511d4@anarch128.org>
Date: Sun, 16 Feb 2025 09:24:38 +1300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tcg: refactor pool data for simplicity and comprehension
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20250215021120.1647083-1-michael@anarch128.org>
 <a62ee246-4249-458c-9f9b-bad79816ce5e@linaro.org>
Content-Language: en-US
From: Michael Clark <michael@anarch128.org>
In-Reply-To: <a62ee246-4249-458c-9f9b-bad79816ce5e@linaro.org>
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

On 2/16/25 06:58, Richard Henderson wrote:
> On 2/14/25 18:11, Michael Clark wrote:
>> the intent of this patch is more conventional nomenclature
>> but the constant pool data code is also simplified a little.
>>
>> - merge new_pool_{alloc,insert} -> new_pool_data.
>> - rename TCGLabelPoolData -> TCGData.
>> - rename pool_labels -> pool_data.
>> - rename macro TCG_TARGET_NEED_POOL_DATA.
>> - move TCGData struct definition into tcg.h.
>> - comment translation block epilogue members.
> 
> You can see from this list that this should be multiple patches.

possibly. possibly not. I don't know how much value it adds to split it 
up as one can see a logical change together in the message and diff. 
"label" to "data" essentially. splitting it splits the logical name 
change across commits and imho would be harder as a reader of history.

splitting the name change and the merging of the two functions seems a 
little complex to coordinate as I would need some intermediate names. 
they seem to be part of the same change. if I changed it to varargs 
without naming consistent with my thinking it makes less sense to me.

>> TCGLabelPoolData is ambiguous and asks for potential confusion
>> with the unrelated TCGLabel type. there is no label in the sense
>> of TCGLabel.
> 
> Fair.
> 
>> the label member is merely a pointer to the instruction text to
>> be updated with the relative address of the constant, the primary
>> data is the constant data pool at the end of translation blocks.
>> this relates more closely to .data sections in offline codegen
>> if we were to imagine a translation block has .text and .data.
> 
> No, it doesn't.  It relates most closely to data emitted within .text, 
> accessed via pc-relative instructions with limited offsets.
> 
> This isn't a thing you'd have ever seen on x86 or x86_64, but it is 
> quite common for arm32 (12-bit offsets), sh4 (8-bit offsets), m68k (16- 
> bit offsets) and such.  Because the offsets are so small, they could 
> even be placed *within* functions not just between them.

yes I am aware of what it is. sometimes referred to as constant islands. 
but you could also consider it as switching between .text and .data or 
maybe interleaved .sdata or "small data". and yes one needs also to be 
careful about pads. one could try to put host instruction text into them 
and use them as a piece of an emulator break out if you can find out how 
to modify the stack pointer to jump to these "constants" in RX pages.

I can revise the text. I see it as a reified text constant as the 
primary data with a label (pointer not object) and a relocation embedded 
inside the constant data object for performance. in a more conventional 
code generator one would create a TCGLabel and TCGReloc. and yes you are 
right. it's not really .data section. I am just curious about 
reconciling concepts between binary translators and more traditional 
compilers. but ideally without a loss in performance.

I actually have a VM in mind that has a constant stream with it's own 
counter that branches called IB (immediate base). IB is set in call 
procedure and we pack a vector into the link register with the relative 
offset of the program counter and immediate base register (i32,i32) 
gives call +/-2GiB reach. link register no longer has absolute address. 
and there is a branch instruction for the constant stream. return needs 
two immediate offsets displaced from the text and constant entry points 
to compute the return address.

I have a sketch for a design that does this. and constants don't come 
over the same memory port as data as it has dedicated fetch bandwidth 
with a constant prefetcher. I could build a front-end and back-end for 
it when I get time. a CPU with some GPU concepts but no fixed function 
rasterizer. also relocs are easier because a RISC using this gets more 
conventional aligned PC-relative relocs of whole words. so the linker 
would be a little faster. constants are all bonded register slot sized 
in the instruction form instead of a special immediate form. it needs 
extra bypassing for "large immediate" but the latency can be covered by 
adding pipeline stages. constant branch predictor in parallel up front.

>> thus TCGData is more succinct and more reflective of what the
>> structure contains; data emitted in the constant data pool at
>> the end of translation blocks. also, pool_labels is renamed to
>> pool_data as the primary contents of the list is constant data.
> 
> I guess.  TCGData is perhaps too short, but we can certainly avoid the 
> confusion of "labels".

TCGPoolData would be okay and I thought about that. the reason against 
was that it competed with TCGPool. but in some senses that might be the 
right name because it is a data constant in the pool. but we embed the 
relocation and label (as pointer) without a full TCGLabel and TCGReloc.

>> finally, new_pool_alloc and new_pool_insert are merged into a
>> single function named new_pool_data, which moves nlongs to the
>> end of the parameter list with varargs to allocate, copy, and
>> insert constant data items to simplify new_pool_label et al.
>> a successive step would be to collapse callers into calling
>> new_pool_data and remove a layer of indirection.
> 
> Why?  varargs generally produces horrible code.
> The split between alloc and insert was intentional to avoid this.

it's pretty good code on SysV because it goes via registers except for 
perhaps new_pool_l8 which will spill to stack and get copied unless the 
inliner can eliminate the copies. maybe windows has bad varargs. but I 
like the style better than deeper layers of wrapper functions. they 
should fix the compiler so that it produces better code.

btw I didn't run through a benchmark suite to check for performance 
regressions because I don't have one in the rig. it was more of a code 
comprehension comment expressed as a patch. it could be merged if it 
adds to the code comprehension without affecting performance.

>> diff --git a/tcg/tci/tcg-target.h b/tcg/tci/tcg-target.h
>> index a9ca493d20f6..448c2330ef0f 100644
>> --- a/tcg/tci/tcg-target.h
>> +++ b/tcg/tci/tcg-target.h
>> @@ -72,6 +72,6 @@ typedef enum {
>>   } TCGReg;
>>   #define HAVE_TCG_QEMU_TB_EXEC
>> -#define TCG_TARGET_NEED_POOL_LABELS
>> +#define TCG_TARGET_NEED_POOL_DATA
> 
> Oops, this should have been removed with a417ef83.

I will refresh.

