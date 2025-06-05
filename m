Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0C59C5B543
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 11:57:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uN9Dw-0002ef-VX; Thu, 05 Jun 2025 07:57:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liujingqi@lanxincomputing.com>)
 id 1uN9Dh-0002W9-CZ
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 07:57:17 -0400
Received: from sg-1-23.ptr.blmpb.com ([118.26.132.23])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liujingqi@lanxincomputing.com>)
 id 1uN9Dd-0003Nz-Nj
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 07:57:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=lanxincomputing-com.20200927.dkim.feishu.cn; t=1749124618;
 h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=3mDuP2s2I6/k7lD3fwHjr3v1hd0NxwWVh9qh5Z+7hQs=;
 b=F8dnkYitYm5ulBa/7zMRG6Q4LpGJsytTqy2pltHkFTaRmLXMryHRcUrTxgHg2Pjro5v9MG
 fQJkuCPZdrX8eGlcxEYnePJfrcJOzziX2s/whbpChvfDBKBzhn42vBa7I725fOaKIOipDd
 m4/aEixTp1B0hmDFd8ciJCXfWXTvFh1bY8+kNMJ8tyZ+dUqRmiT0yH95hDKvrvPAqGIU41
 DdVID9vFyeMy0VTLdb++36wHAtvPJKAgnSasHk/sD2BB3nex2URiKlL/TH4O/vba6OnjQJ
 rB7SYelcytlgxxq9EropEppCIOSILr03MIAF95xtcDp5MHDRowQ07wNlGJq8Cg==
To: "Tomasz Jeznach" <tjeznach@rivosinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Content-Language: en-US
User-Agent: Mozilla Thunderbird
X-Lms-Return-Path: <lba+268418608+46c7bf+nongnu.org+liujingqi@lanxincomputing.com>
Cc: "Alistair Francis" <alistair.francis@wdc.com>, 
 "Daniel Henrique Barboza" <dbarboza@ventanamicro.com>, 
 "Richard Henderson" <richard.henderson@linaro.org>, 
 "Jason Chien" <jason.chien@sifive.com>, <qemu-riscv@nongnu.org>, 
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH] hw/riscv/riscv-iommu: Fix PPN field of
 Translation-reponse register
Date: Thu, 5 Jun 2025 19:56:53 +0800
From: "Nutty Liu" <liujingqi@lanxincomputing.com>
Received: from [127.0.0.1] ([180.165.23.184]) by smtp.feishu.cn with ESMTPS;
 Thu, 05 Jun 2025 19:56:54 +0800
X-Original-From: Nutty Liu <liujingqi@lanxincomputing.com>
Message-Id: <9b26fbae-d07b-4a56-8300-1cbb17b524b1@lanxincomputing.com>
References: <20250529091351.4304-1-liujingqi@lanxincomputing.com>
 <CAH2o1u7L=O+AOtbpkb09EanpmdhKX20Xx+EoFBJOStv3kVxKwg@mail.gmail.com>
In-Reply-To: <CAH2o1u7L=O+AOtbpkb09EanpmdhKX20Xx+EoFBJOStv3kVxKwg@mail.gmail.com>
Received-SPF: pass client-ip=118.26.132.23;
 envelope-from=liujingqi@lanxincomputing.com; helo=sg-1-23.ptr.blmpb.com
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

On 6/4/2025 1:52 AM, Tomasz Jeznach wrote:
> On Thu, May 29, 2025 at 2:14=E2=80=AFAM Nutty Liu <liujingqi@lanxincomput=
ing.com> wrote:
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
>>
> Thanks for catching this. Yes, there is an issue here.
> Also, the line below, clearing _S bit, is no longer needed.

Thanks for your review.
Indeed. I will also remove the line below.

>>               /* We do not support superpages (> 4kbs) for now */
>>               iova &=3D ~RISCV_IOMMU_TR_RESPONSE_S;
>> --
>> 2.49.0.windows.1
> Reviewed-by: Tomasz Jeznach <tjeznach@rivosinc.com>
>
> Best,
> - Tomasz

Thanks,
Nutty

