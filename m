Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B29DAC53200
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 17:54:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wp8Sw-0007nh-Jt; Wed, 29 Jul 2026 13:53:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wp8St-0007nK-T0; Wed, 29 Jul 2026 13:53:13 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wp8Ss-0007Ti-E1; Wed, 29 Jul 2026 13:53:11 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66TFHvtU278846; Wed, 29 Jul 2026 17:53:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=E0IRs2
 vmj/Afb21J0zUsIoF8O0MyQWoajZVuo9eE/W4=; b=Bunf5IrDPaZ6kGC/Hipqd6
 jxStw3TAmzjeIdt93cYyzdybINdiW1B+1t4JJKh+1a7gr0SPi42UI/yBpBsA9JYZ
 WQXutafGY9KSTfqHqM/GW6GZwInktkhfOPfBJPn5MyFtNkEcqbavz510E94VMsbB
 qmbRv+7daalfpp8qqkENh0kg1K0pGh8m6iw5zVfUOUWq96gJHNtrwwTA6maQK5He
 bPOgkmpQmLyNgeddXHi06fpUT4HKqfHa2sPxzOjBAF/fNOC8CypBq4X2oMnieq1x
 FQ34dnkx+fYtCh44Njukwy5ds9cBzwus6hqQwbs/Qf5+bz9Z2ZSZebUlyTUAtyqg
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuyjb60m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 Jul 2026 17:53:05 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66THfHjJ018400;
 Wed, 29 Jul 2026 17:53:04 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8fk7t87-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 Jul 2026 17:53:04 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66THr3np53215676
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 29 Jul 2026 17:53:03 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E139458065;
 Wed, 29 Jul 2026 17:53:02 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 21E1C5805D;
 Wed, 29 Jul 2026 17:53:02 +0000 (GMT)
Received: from [9.61.157.32] (unknown [9.61.157.32])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 29 Jul 2026 17:53:02 +0000 (GMT)
Message-ID: <d186d6e1-a820-490e-b616-2ac521d3a20e@linux.ibm.com>
Date: Wed, 29 Jul 2026 13:53:01 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] target/s390x: Allow 2G hugepages guest backing
To: Claudio Imbrenda <imbrenda@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, borntraeger@de.ibm.com, frankja@linux.ibm.com,
 pasic@linux.ibm.com, mhartmay@linux.ibm.com, david@kernel.org,
 farman@linux.ibm.com, richard.henderson@linaro.org, iii@linux.ibm.com,
 cohuck@redhat.com
References: <20260729163043.843517-1-imbrenda@linux.ibm.com>
 <20260729163043.843517-2-imbrenda@linux.ibm.com>
From: Matthew Rosato <mjrosato@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20260729163043.843517-2-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDEzNyBTYWx0ZWRfX2L2Je6zWturb
 ETFu6LzA2YZbpz11tzsDY12y8rrT/OkjtpWHeNBwa1Eb8CPeRghZo5/IshkPz63RibbicD6chcX
 +wSOu9XNKKGV3RpW8+s2zjdbf/EbaSw=
X-Proofpoint-GUID: OYSXjCm3k2cC6DPrGRKO85rWbSkHaFuK
X-Proofpoint-ORIG-GUID: OYSXjCm3k2cC6DPrGRKO85rWbSkHaFuK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDEzNyBTYWx0ZWRfX5AiW5kDIyXXj
 I6x8F4/FMocfIyBae8q4MB72BWCOiTLFDnm1X/Ruixs30RCzekFx/Ae4ym6DT2J8/lI1BaruHSx
 D9nnd9ZnpNDWlNOslfkflHw6IkMDdtRUchtdQX65MjDKSpG56rlRM3GQYFVQiSL7Fb4+zEICrNV
 AD1BAWuAgWJfpfHCAmX/Qo38nkY9cSWlmTBKXCWLUXHnSV4fcOfGEqLHPBMr3nn3eb7Ola9bxBE
 Sk2YkN1DbgbDp6QJdP+hbjzS5evrEniKEBNz8ZBcZ1V6PRJtIFjN2BgDOkdisF8DhiPiG1bU0KV
 LTNATVu89hkt7GIaXVUhbmSRrhPS3bMuIawgDhYoNDOh3xHEfv0dniJq9fj213nOt0HUw+TWF37
 HL/GMp+JmSX8KouG7X7z8jItax4cKwr0PLY7QWAwqL1YbRFxzPoHncNznuR3JxPmW+bj4nsAaV0
 TKKCi8WILVfnK8WH4Ng==
X-Authority-Analysis: v=2.4 cv=X5Vi7mTe c=1 sm=1 tr=0 ts=6a6a3e01 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=djE01jif0jY3f_l2TnAA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_06,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607290137
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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


> -        if (kvm_enabled() && kvm_s390_get_hpage_1m()) {
> +        if (kvm_enabled() && kvm_s390_get_hpage()) {

...

>  
> -    cap_hpage_1m = 1;
> +int kvm_s390_get_hpage(void)
> +{
> +    return cap_hpage;
>  }
>  
>  int kvm_s390_get_hpage_1m(void)
>  {
> -    return cap_hpage_1m;
> +    return cap_hpage == 1;
> +}
> +
> +int kvm_s390_get_hpage_2g(void)
> +{
> +    return cap_hpage == 2;
>  }

Hey Claudio,

Thanks for changing things to differentiate between 1m and 2g for the cap.

Overall LGTM but this patch now makes kvm_s390_get_hpage_1m() dead code
(not referenced anywhere) as well as introduces a new function
kvm_s390_get_hpage_2g() that is also unused.

Since this patch is by itself, why not just remove the functions
until/if they are needed and only provide kvm_s390_get_hpage()?

Do you have planned future patches that you are confident will soon make
use of these get_hpage_1m() and get_hpage_2g() helpers?

Thanks,
Matt




