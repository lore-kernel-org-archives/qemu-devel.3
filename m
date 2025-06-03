Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8350C5AE59
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 04:44:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMJUC-0002uD-34; Tue, 03 Jun 2025 00:42:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liujingqi@lanxincomputing.com>)
 id 1uMJU7-0002tT-Fo
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 00:42:49 -0400
Received: from sg-1-21.ptr.blmpb.com ([118.26.132.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liujingqi@lanxincomputing.com>)
 id 1uMJU3-0000S0-BP
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 00:42:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=lanxincomputing-com.20200927.dkim.feishu.cn; t=1748925747;
 h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=hQUJQuIiNJmjXD6aky80806PNqs5JG6X+Xg9H5Oinms=;
 b=fJ/zuLX4pq3bisT8nwxAi3It1XMdWUYn5QXP6/OwRjau4i6EXcQBo6ChRDtO7eoynh3Vej
 3SyCYlVHIgwpBL+65Wu+Ekrr+CMmOvnGNNZbBzYiE7ZlfhEskWvwIFYTVo/wEqI61fB5BT
 o847Fv8KfUO80U/2guIyjPrRFsAuZ4bVyGPI/4x1FnGa069w+Ze2Vcq4YL5j0F43//TUWF
 WDKs8c2BoY9teRkXYxIuwcJkZUU181nu2hXyhgWEaiBx0Lykb2rsWkn9fNtlTCtU6XYErU
 vlRBf78KN1K96WKFBFtp6Sn7u/nx066bzzZH8FRuZf47nn4IF7fRzdxF9zDcpg==
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Cc: "Palmer Dabbelt" <palmer@dabbelt.com>, 
 "Alistair Francis" <alistair.francis@wdc.com>, 
 "Weiwei Li" <liwei1518@gmail.com>, 
 "Daniel Henrique Barboza" <dbarboza@ventanamicro.com>, 
 "Liu Zhiwei" <zhiwei_liu@linux.alibaba.com>, 
 "Tomasz Jeznach" <tjeznach@rivosinc.com>, 
 "Richard Henderson" <richard.henderson@linaro.org>, 
 <qemu-riscv@nongnu.org>, <qemu-devel@nongnu.org>
Date: Tue, 3 Jun 2025 12:42:23 +0800
Mime-Version: 1.0
Received: from [127.0.0.1] ([180.165.23.184]) by smtp.feishu.cn with ESMTPS;
 Tue, 03 Jun 2025 12:42:24 +0800
In-Reply-To: <CAKmqyKPKLHk97s-eVGANq7hYfny1g-WgFQA32eoNo9UYLC9ixA@mail.gmail.com>
X-Lms-Return-Path: <lba+2683e7d31+cf118c+nongnu.org+liujingqi@lanxincomputing.com>
To: "Alistair Francis" <alistair23@gmail.com>
From: "liu" <liujingqi@lanxincomputing.com>
Message-Id: <bd2323c1-b712-4db6-935e-f645e57ef134@lanxincomputing.com>
References: <20250529092632.4367-1-liujingqi@lanxincomputing.com>
 <CAKmqyKPKLHk97s-eVGANq7hYfny1g-WgFQA32eoNo9UYLC9ixA@mail.gmail.com>
Subject: Re: [PATCH] hw/riscv/riscv-iommu: Fix PPN field of
 Translation-reponse register
Content-Type: text/plain; charset=UTF-8
X-Original-From: liu <liujingqi@lanxincomputing.com>
User-Agent: Mozilla Thunderbird
Received-SPF: pass client-ip=118.26.132.21;
 envelope-from=liujingqi@lanxincomputing.com; helo=sg-1-21.ptr.blmpb.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Hi Alistair,

Thanks for your review.

On 6/2/2025 1:11 PM, Alistair Francis wrote:
> On Thu, May 29, 2025 at 10:52=E2=80=AFPM Nutty Liu
> <liujingqi@lanxincomputing.com> wrote:
>> The original implementation incorrectly performed a bitwise AND
>> operation between the PPN of iova and PPN Mask, leading to an
>> incorrect PPN field in Translation-reponse register.
>>
>> The PPN of iova should be set entirely in the PPN field of
>> Translation-reponse register.
>>
>> Signed-off-by: Nutty Liu <liujingqi@lanxincomputing.com>
>> ---
>>   hw/riscv/riscv-iommu.c | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
>> index a877e5da84..f529a6a3d7 100644
>> --- a/hw/riscv/riscv-iommu.c
>> +++ b/hw/riscv/riscv-iommu.c
>> @@ -1935,8 +1935,7 @@ static void riscv_iommu_process_dbg(RISCVIOMMUStat=
e *s)
>>               iova =3D RISCV_IOMMU_TR_RESPONSE_FAULT | (((uint64_t) faul=
t) << 10);
>>           } else {
>>               iova =3D iotlb.translated_addr & ~iotlb.addr_mask;
>> -            iova >>=3D TARGET_PAGE_BITS;
>> -            iova &=3D RISCV_IOMMU_TR_RESPONSE_PPN;
>> +            iova =3D set_field(0, RISCV_IOMMU_TR_RESPONSE_PPN, PPN_DOWN=
(iova));
> I don't see how this is different.
>
> PPN_DOWN(iova)
> is the same as
> iova >> TARGET_PAGE_BITS
Yes. The results of above operations are the same.
>
> and
>
> set_field(0, RISCV_IOMMU_TR_RESPONSE_PPN, PPN_DOWN(iova))
> should just return
> (0 & ~RISCV_IOMMU_TR_RESPONSE_PPN) |
>      (RISCV_IOMMU_TR_RESPONSE_PPN & PPN_DOWN(iova))
It's not correct.Let me show the definitions of the related macros as=20
follows.
1) The definition of 'set_field' in 'target/riscv/cpu_bits.h' is as=20
below:#define set_field(reg, mask, val) (((reg) & ~(uint64_t)(mask)) |=20
\(((uint64_t)(val) * ((mask) & ~((mask) << 1))) & \(uint64_t)(mask)))2)=20
The definition of 'RISCV_IOMMU_TR_RESPONSE_PPN'=20
in'hw/riscv/riscv-iommu-bits.h' is as follows:#define=20
RISCV_IOMMU_PPN_FIELD GENMASK_ULL(53, 10)#define=20
RISCV_IOMMU_TR_RESPONSE_PPN RISCV_IOMMU_PPN_FIELD
Let me give you an example as follows.
With the original implementation,1) Assume:iova =3D 0x12345678;
2) iova >>=3D TARGET_PAGE_BITS=EF=BC=9BThe result is as follows:iova =3D=20
0x12345;It's the same as PPN_DOWN(iova). This is the correct value of PPN.
3) iova &=3D RISCV_IOMMU_TR_RESPONSE_PPN;
After substituting with 'iova =3D 0x12345', the result is as follows:iova=
=20
=3D 0x12345 & 0x3ffffffffffc00;The final 'iova' is :iova =3D 0x12000;
This 'iova' will be set to Translation-reponse register finally by=20
thebelow sentence.riscv_iommu_reg_set64(s, RISCV_IOMMU_REG_TR_RESPONSE,=20
iova);
Then the value of Translation-reponse register will be set to=20
'0x12000'.The PPN field is between bit 10 and bit 53. So the PPN is=20
0x48(calculated by 0x12000 >> 10 =3D 0x48).
It's incorrect. The PPN field should be 0x12345.It should be calculated=20
as follows:iova =3D (iova << 10) & RISCV_IOMMU_TR_RESPONSE_PPN;
After substituting with 'iova =3D 0x12345', and the result is as=20
follows:iova =3D (0x12345 << 10) & 0x3ffffffffffc00 =3D 0x48D1400The correc=
t=20
value of Translation-reponse register should be '0x48D1400'.
4) With the new implementation,iova =3D set_field(0,=20
RISCV_IOMMU_TR_RESPONSE_PPN, PPN_DOWN(iova));
It will set the bits 10 to 53 of 'iova' to PPN_DOWN(iova).After=20
substituting with 'iova =3D 0x12345', the final 'iova' is as follows:iova=
=20
=3D 0x48D1400;
And then the correct 'iova' will be set to Translation-reponse register.
>
> Can you describe the issue with the original implementation and why
> this fixes it in the commit message?
Hope the above description and the example can help you understand.
Nutty,
Thanks
>
> Alistair
>
>>               /* We do not support superpages (> 4kbs) for now */
>>               iova &=3D ~RISCV_IOMMU_TR_RESPONSE_S;
>> --
>> 2.49.0.windows.1
>>

