Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EF4DC5DF81
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 02:21:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxEsA-00011w-Iu; Thu, 20 Aug 2026 22:20:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiangwencheng@lanxincomputing.com>)
 id 1wxEs8-00011o-MM
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 22:20:44 -0400
Received: from va-2-29.ptr.blmpb.com ([209.127.231.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xiangwencheng@lanxincomputing.com>)
 id 1wxEs3-0002HQ-Pv
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 22:20:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=lanxincomputing-com.20200927.dkim.feishu.cn; t=1787278827;
 h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=J3wC1Oj2yP39aQG8a74rqxHzKDCG9roEV9f2lTU5nss=;
 b=dApEYUB1teb9BbFBtdqFD5R7ZI/Q9Fvz2VyL08cwquMdYL3lwAzNdKWAW4fMwFpQf4na7/
 cEtYumQjmP2sTiXsuZpiGFPU6S4u0fnjhnWh8gxo2VhTGcr6uBVZ9wCKA7V1APTDy9n4i0
 7bxWgrFmBqI3hcAALvE71dn9pNhbWb/0en/Mz83MyHxc0Uvy1V0+fD6ZZZq+m8HY1LvPpW
 SA/aol1njz13nHU3HcTW0aQwZVYVZEOCLHtdSDFy74R9JI4KNM4CoKvJhzwAA+oMGfar9n
 Hu/7OYDL84RQ7jXmtcHPoCLH9z7eYghwLX5VfVfIuFKB7/qo/7Wni2K8sqmSTQ==
To: "Richard Henderson" <richard.henderson@linaro.org>, <mst@redhat.com>
Cc: <pbonzini@redhat.com>, <peterx@redhat.com>, <philmd@mailo.com>, 
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH] virtio: Add aligned ld/st accessors for vring
References: <20260820094611.1767100-1-xiangwencheng@lanxincomputing.com>
 <0ab52741-c059-4b3b-b1cd-fcf289bf820f@linaro.org>
Content-Type: text/plain; charset=UTF-8
From: "BillXiang" <xiangwencheng@lanxincomputing.com>
Message-Id: <6e417ca3-ec49-498c-8bfa-e29be60c6551@lanxincomputing.com>
Mime-Version: 1.0
X-Lms-Return-Path: <lba+26a87b5e9+7b11af+nongnu.org+xiangwencheng@lanxincomputing.com>
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <0ab52741-c059-4b3b-b1cd-fcf289bf820f@linaro.org>
Content-Language: en-US
Date: Fri, 21 Aug 2026 10:20:20 +0800
X-Original-From: BillXiang <xiangwencheng@lanxincomputing.com>
Received: from [127.0.0.1] ([123.120.5.129]) by smtp.feishu.cn with ESMTPS;
 Fri, 21 Aug 2026 10:20:24 +0800
User-Agent: Mozilla Thunderbird
Received-SPF: pass client-ip=209.127.231.29;
 envelope-from=xiangwencheng@lanxincomputing.com; helo=va-2-29.ptr.blmpb.com
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

On 8/20/2026 10:59 PM, Richard Henderson wrote:
> On 8/20/26 02:46, BillXiang wrote:
>> diff --git a/include/qemu/bswap.h b/include/qemu/bswap.h
>> index 387d65c..c23f5a2 100644
>> --- a/include/qemu/bswap.h
>> +++ b/include/qemu/bswap.h
>> @@ -255,6 +255,20 @@ static inline int lduw_he_p(const void *ptr)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return r;
>> =C2=A0 }
>> +static inline int lduw_he_p_aligned(const void *ptr)
>> +{
>> +=C2=A0=C2=A0=C2=A0 uint16_t r;
>> +=C2=A0=C2=A0=C2=A0 __builtin_memcpy(&r, __builtin_assume_aligned(ptr, s=
izeof(r)),=20
>> sizeof(r));
>> +=C2=A0=C2=A0=C2=A0 return r;
>> +}
>=20
> If you know it's aligned, then you don't need anything special: just a=20
> normal C memory access.=C2=A0 E.g.
>=20
>  =C2=A0=C2=A0=C2=A0 *(uint16_t *)ptr
>=20
> and then of course no need for a wrapper function.

Noted, thanks! I=E2=80=99ll resend it with the changes.

>=20
>> +static inline int lduw_le_p_aligned(const void *ptr)
>> +{
>> +=C2=A0=C2=A0=C2=A0 return (uint16_t)le_bswap(lduw_he_p_aligned(ptr), 16=
);
>> +}
>=20
> And this:=C2=A0 le16_to_cpu(*(uint16_t *)ptr)
>=20
>=20
> r~

