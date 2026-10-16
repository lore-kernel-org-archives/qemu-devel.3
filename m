Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9878CCCA464
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 08:02:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHctE-0001Ma-13; Fri, 16 Oct 2026 04:02:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiangwencheng@lanxincomputing.com>)
 id 1xHctA-0001M4-MG
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 04:02:04 -0400
Received: from va-2-57.ptr.blmpb.com ([209.127.231.57])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xiangwencheng@lanxincomputing.com>)
 id 1xHct6-0005Mt-Fi
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 04:02:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=lanxincomputing-com.20200927.dkim.feishu.cn; t=1792137712;
 h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=rVqwVSb1ecKRYFexgzok1omkUkFfDH95/3y/k9gEVqM=;
 b=E/mXdRrivlx4WJbvokC63dyjR14mzY8E/Si5/oGJRyb9F72k0rtJYnSgr0fRjsu8TFAOeh
 e/GADMJHBukP592aPTkxmi02pmjzh8VcqjTIZhQeeOcaWphweeQEqBaWrEsfQAHdiVqtEH
 B7Ue2yuvgbfS3fT+9g7yXMYQI1NQF1Un5SsrSkp+U1m4Qoi0//Gai5rOWDuiRivgDDT5jz
 IQoMN/mdvewujIdiZN7NmkpQ8dSLQI47hFOs6X2V9E12ImjCQlhz2Vrp0FcyZzqfPTnu4g
 jvZRRqyPp+PBnZfQw+g9yxaciSAeKh/EVBGO6UVa7Hcrbg9XizhUSt7vlIOiJw==
Cc: "Peter Xu" <peterx@redhat.com>, 
 "Richard Henderson" <richard.henderson@linaro.org>, <mst@redhat.com>, 
 <pbonzini@redhat.com>, <philmd@mailo.com>, <qemu-devel@nongnu.org>, 
 <qemu-riscv@nongnu.org>
Subject: Re: [PATCH v2] virtio: Add aligned ld/st accessors for vring
X-Lms-Return-Path: <lba+26ad1d9d9+54d4c9+nongnu.org+xiangwencheng@lanxincomputing.com>
Content-Transfer-Encoding: quoted-printable
User-Agent: Mozilla Thunderbird
Content-Type: text/plain; charset=UTF-8
To: "Peter Maydell" <peter.maydell@linaro.org>
Date: Fri, 16 Oct 2026 16:01:26 +0800
Mime-Version: 1.0
X-Original-From: BillXiang <xiangwencheng@lanxincomputing.com>
In-Reply-To: <CAFEAcA-hV-eZHfH1FMYNLaFY8M-emt8aN+Nt4MvfhSfkUZv7AQ@mail.gmail.com>
From: "BillXiang" <xiangwencheng@lanxincomputing.com>
References: <20260821100856.1794011-1-xiangwencheng@lanxincomputing.com>
 <CAFEAcA_kLpaz0UQi3Q315kLVqvDtxKh77kU2meN9G1_evfKBeQ@mail.gmail.com>
 <bad5c8b3-668f-4893-974f-9dbca8dc6893@linaro.org>
 <02da9676-febf-4389-b09b-5e5d41c1084e@lanxincomputing.com>
 <aoxiBB2Wn8NiL5s6@x1.local>
 <5a2a8e0e-2fa6-4905-9752-b2ed0ab3f0ac@lanxincomputing.com>
 <aprI8xQIDCRTJOV1@x1.local>
 <9d125a95-0fa1-4ea8-a8a6-4869afc629bc@lanxincomputing.com>
 <CAFEAcA-hV-eZHfH1FMYNLaFY8M-emt8aN+Nt4MvfhSfkUZv7AQ@mail.gmail.com>
Content-Language: en-US
Message-Id: <e6cab0f9-6a10-43b7-95e5-35609ea3929d@lanxincomputing.com>
Received: from [127.0.0.1] ([123.120.5.129]) by smtp.feishu.cn with ESMTPS;
 Fri, 16 Oct 2026 16:01:27 +0800
Received-SPF: pass client-ip=209.127.231.57;
 envelope-from=xiangwencheng@lanxincomputing.com; helo=va-2-57.ptr.blmpb.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, MSGID_FROM_MTA_HEADER=0.001, SPF_HELO_NONE=0.001,
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

On 9/7/2026 6:29 PM, Peter Maydell wrote:
> On Mon, 7 Sept 2026 at 11:12, BillXiang
> <xiangwencheng@lanxincomputing.com> wrote:
>>
>> On 9/4/2026 9:34 PM, Peter Xu wrote:
>>> On Tue, Sep 01, 2026 at 10:44:13AM +0800, BillXiang wrote:
>>>> On 8/24/2026 11:23 PM, Peter Xu wrote:
>>>>> On Mon, Aug 24, 2026 at 12:19:15PM +0800, BillXiang wrote:
>>>>>> Hi Richard, I've read your code in accel/tcg/ldst_atomicity.c.inc. D=
o
>>>>>> you think it would be better to make the load/store_atomic* public?
>>>>>
>>>>> They do not fit by default, as we need to still process unaligned cas=
es?
>>>>
>>>> You mentioned the use of guest CPU context in [1]. However, what I mea=
nt
>>>> by load/store_atomic* is code like the following:
>>>>
>>>> static inline uint16_t load_atomic2(void *pv)
>>>> {
>>>>        uint16_t *p =3D __builtin_assume_aligned(pv, 2);
>>>>        return qatomic_read(p);
>>>> }
>>>>
>>>> static inline void store_atomic2(void *pv, uint16_t val)
>>>> {
>>>>        uint16_t *p =3D __builtin_assume_aligned(pv, 2);
>>>>        qatomic_set(p, val);
>>>> }
>>>>
>>>> I consider these to be generic atomic load/store primitives.
>>>
>>> __builtin_assume_aligned() tells the compiler the address is aligned.  =
What
>>> if it is not?
>>
>> When using __builtin_assume_aligned, the compiler will generate
>> unaligned load/store instructions if the data is not aligned, rather
>> than emitting byte=E2=80=91by=E2=80=91byte code, which may cause errors =
on processors
>> that do not support unaligned accesses. That's what I mean: callers must
>> ensure @addr is naturally aligned to the access size.
>=20
> Indeed. That's why the ldst_atomicity.c.inc code only calls them
> when it can guarantee the alignment, with fallback cases for
> when it isn't. Those are the lowest level internal functions
> in that code, and the higher level ones are things like
> load_atom_2() (which might call load_atomic2() if the address
> is 2-aligned, or lduw_he_p() if it's not but the caller said
> it doesn't care about getting a 2-byte-atomic load for an
> unaligned pointer, or a function to do an atomic 8-byte access
> and extract the 2 bytes we care about, or if all else fails
> falling back to "stop all QEMU threads and do a non-atomic read".
>=20
> The difficulty in generalizing that code for device use I suspect
> is whether the fallback cases remain the right thing to do.
>=20
> -- PMM

Hi all,

Sorry for the long delay on this patch. I've been occupied with other=20
matters.

As discussed above, it would be better to address all the same failures,=20
but it is also difficult to cover all the fallback cases.

Does anyone have any further suggestions? Could we just focus on the=20
specific virtio case where the address is aligned and needs to be=20
accessed atomically? Or could we use Peter's patch[1] to automatically=20
switch to aligned access?


Thanks,

--
BillXiang

[1] https://lore.kernel.org/qemu-devel/aoxiBB2Wn8NiL5s6@x1.local/

