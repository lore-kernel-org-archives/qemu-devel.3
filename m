Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A148C5DF94
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 04:20:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyM9z-0007f7-Oc; Mon, 24 Aug 2026 00:19:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiangwencheng@lanxincomputing.com>)
 id 1wyM9w-0007XX-3s
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 00:19:44 -0400
Received: from va-2-26.ptr.blmpb.com ([209.127.231.26])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xiangwencheng@lanxincomputing.com>)
 id 1wyM9n-0002ED-MZ
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 00:19:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=lanxincomputing-com.20200927.dkim.feishu.cn; t=1787545159;
 h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=sOu+nA9qfhPW2Q3g1lYMGd8euuxsXo5wHVgkjt6/5kU=;
 b=0C0K0C/fkwFJVIMbbtTvo0YBt/zf4GaSs9lt7fUxp7GL4WZcMc8H1WENzLEf7bQEDJI6FA
 XK0ETnSY0VPtNirZlWtbiectfwPCV4Y7z+oCazWwQsXmEWykiV9ugw6CXbqpbezdUbp/0y
 e/+U1dn2nPdNyanUqROCpbS0Vpe6gzJQuagSZzCLvsweBmJyp/RcE9IL9jL0FUrGb+MTyp
 jkX76L7IpO9Nz0Rc1kwVKmeqNVKeyvHnSmXaStnSg1dO5RHgZbFriBqsr7rwZsD+1PQqzf
 LMIRPWx6mD3G5m4Z/86ZQfih2Ukcw8TmXSLOvU6qBfnTDmXrVR2QIw6cCmcYSw==
User-Agent: Mozilla Thunderbird
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <bad5c8b3-668f-4893-974f-9dbca8dc6893@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Original-From: BillXiang <xiangwencheng@lanxincomputing.com>
X-Lms-Return-Path: <lba+26a8bc645+6fb25d+nongnu.org+xiangwencheng@lanxincomputing.com>
From: "BillXiang" <xiangwencheng@lanxincomputing.com>
Date: Mon, 24 Aug 2026 12:19:15 +0800
References: <20260821100856.1794011-1-xiangwencheng@lanxincomputing.com>
 <CAFEAcA_kLpaz0UQi3Q315kLVqvDtxKh77kU2meN9G1_evfKBeQ@mail.gmail.com>
 <bad5c8b3-668f-4893-974f-9dbca8dc6893@linaro.org>
Content-Language: en-US
Received: from [127.0.0.1] ([123.120.5.129]) by smtp.feishu.cn with ESMTPS;
 Mon, 24 Aug 2026 12:19:16 +0800
To: "Richard Henderson" <richard.henderson@linaro.org>, 
 "Peter Maydell" <peter.maydell@linaro.org>
Cc: <mst@redhat.com>, <pbonzini@redhat.com>, <peterx@redhat.com>, 
 <philmd@mailo.com>, <qemu-devel@nongnu.org>, <qemu-riscv@nongnu.org>
Subject: Re: [PATCH v2] virtio: Add aligned ld/st accessors for vring
Message-Id: <02da9676-febf-4389-b09b-5e5d41c1084e@lanxincomputing.com>
Received-SPF: pass client-ip=209.127.231.26;
 envelope-from=xiangwencheng@lanxincomputing.com; helo=va-2-26.ptr.blmpb.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, SPF_HELO_NONE=0.001,
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

On 8/22/2026 1:32 AM, Richard Henderson wrote:
> On 8/21/26 03:25, Peter Maydell wrote:
>> I'm tempted to suggest some kind of "if pointer is aligned take
>> aligned path, otherwise take slow path" either here or actually
>> in lduw_le_p(), but maybe that's a bad idea. Richard ?
>>
>> (I have a suspicion that other places than this one will assume
>> that an aligned ldl_he_p() is not going to tear.)
> I agree -- I expect most everything assumes ldl_he_p won't tear for=20
> aligned accesses.

Hi Peter, I noticed that in your commit [1], you have pointed out that=20
ld*_he_p() and st*_he_p() is not atomic especially for vring_avail_idx.
This suggests it=E2=80=99s time to finally implement the atomic functions. =
And=20
I think we should provide explicit atomic operations, similar to those=20
in CPU instruction sets, rather than a single all=E2=80=91purpose function=
=20
cluttered with conditional branches =E2=80=94 and it should be the caller=
=E2=80=99s=20
responsibility to decide whether to use them.

>=20
> This kinda begs the question of what atomicity the caller expects.=C2=A0 =
It's=20
> not implausible that an x86 path expects even unaligned accesses not=20
> crossing a cacheline to be atomic, since that's been a thing since=20
> 1995.=C2=A0 I expect both IBM architectures similarly expect atomicity by=
=20
> alignment, since that's been a thing for s390 since yonks and Power has=
=20
> the same language.
>=20
> We have a bunch of code in accel/tcg/ldst_atomicity.c.inc that can=20
> handle this, we'd just need to provide it with the correct inputs.=C2=A0 =
And=20
> I assume we'd still like to inline the single access on appropriate hosts=
.
>=20
>=20
> r~

Hi Richard, I've read your code in accel/tcg/ldst_atomicity.c.inc. Do=20
you think it would be better to make the load/store_atomic* public?

--
Bill Xiang

[1]=20
https://lore.kernel.org/qemu-devel/1554826986-37164-4-git-send-email-pbonzi=
ni@redhat.com/#r

