Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8475CD98CE
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2026 06:37:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXvVP-0007Z0-6r; Fri, 12 Jun 2026 02:36:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wXvVB-0007Xx-TW; Fri, 12 Jun 2026 02:36:25 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wXvVA-000730-46; Fri, 12 Jun 2026 02:36:25 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65BMHHTJ4146662; Fri, 12 Jun 2026 06:36:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=+1rWn+
 CZ2B26mcHtKcZuLefpGwJd27vWkvu9PDRRlzI=; b=b7yMeEpiWhKRU5UPIt9IqN
 YXtv3/1BIlJAQOwp6YNhCe4o9NT/rnh9exrBZ8JLeMEUxqXATbY1msyc1Q2bD7SG
 ntaAtiODg5vtfPVE9YE0Jr9q6jSjOqP3RsOflxyFY5KLxcCobFPDsKl4PFqTqTUF
 laGtgdkdZelADe4C2KJDZaOV6CJyf0VgbwsIzUdezfGc74fRLMQdMuqRUEZKCxOw
 gBhXdDCz5qA16Vc9Ii2acW175dsiRqgMyEe5gm44ric+BvhbgqcwQvz0RLrCl172
 72ZcuQTUEzbpiB0RetB1iawU1ESjLaHdzwpMO14xpX+9eGWriss95fa+kzp/QCTA
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eqe8c7jj9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 12 Jun 2026 06:36:17 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65C6Yc6G008900;
 Fri, 12 Jun 2026 06:36:16 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4eqe08xmd0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 12 Jun 2026 06:36:16 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65C6aDrD49873170
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 12 Jun 2026 06:36:13 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EC89820043;
 Fri, 12 Jun 2026 06:36:12 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A943420040;
 Fri, 12 Jun 2026 06:36:07 +0000 (GMT)
Received: from [9.124.211.181] (unknown [9.124.211.181])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 12 Jun 2026 06:36:07 +0000 (GMT)
Message-ID: <e87e7d6f-2ee2-423e-9111-19b7f14f376e@linux.ibm.com>
Date: Fri, 12 Jun 2026 12:06:05 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] ppc/pnv: Remove Power8E and Power8NVL spapr cores
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Miles Glenn <milesg@linux.ibm.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, devel@lists.libvirt.org,
 kvm@vger.kernel.org, Misbah Anjum N <misanjum@linux.ibm.com>,
 Shivang Upadhyay <shivangu@linux.ibm.com>
References: <20260610090800.3672832-1-adityag@linux.ibm.com>
 <20260610090800.3672832-4-adityag@linux.ibm.com>
 <2610e4bd-7ddc-4880-808d-3f55bb166938@oss.qualcomm.com>
Content-Language: en-US
From: Aditya Gupta <adityag@linux.ibm.com>
In-Reply-To: <2610e4bd-7ddc-4880-808d-3f55bb166938@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEyMDA1OCBTYWx0ZWRfX+nwDxc+/Zh3P
 QQgmv4hdp9JxoSnYYpuatN4ePapVX4FWTzBSiXNjLZ9udr2/0rxc90XjeSHGgpZBUdHBgxgbQ2o
 8XAQqnwlXlXt9nRXi5N1a6sYmbBcDBI=
X-Authority-Analysis: v=2.4 cv=AYCB2XXG c=1 sm=1 tr=0 ts=6a2ba8e2 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=MFgsVc_P71K-EoIa1lMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: zko1NFm39B5RYfWzefPsOq9Zl13t8aEo
X-Proofpoint-ORIG-GUID: AbRD2TZNRJE-OGv-lwpMI5Ula9L1zne2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEyMDA1OCBTYWx0ZWRfX7NVrGtLpjENA
 b9T8bFDiNxDdt7z8M7E2aMRmobQcNjt+LMBaG0g3kI8e0dLEVYXXXeTpQQC6emHvaT8iyECg4NV
 f1S0ycUnc9/IADJiJvf31ZJq+GFuBSXsbPlZ6Jdk/tAwPIn8svjmSpNEF6k25BSSqKpyvGWR93t
 tJueHfj6h0vu8Da01R1EFJ5+usNrlIeNUf7cmpc8P19Q2SghNCRdC3PMAr2kr5rJ+uT0ZW/d9xs
 eSkGp/dU5dz2Yj6Ebyizqj+nVGqcvcuWRneLN4bBRPAKrbGXYhj+Y2OhPv4I1USP/vwvtboX4Rp
 wIH/I1rRsdQVX+5hR+BFeBMCcTGPbRjU8+ap2Ecri1XwJcpgENFkwpwY2tNTyejnA+f/LRZj6Z6
 FPuD/y/I9y6CT7fuujEZtEJ0uihdagGElvxKP7JCuGoP5UOw9Pp8Lhu66Szpy/HhA7dumZdKkXx
 ur0MRnozRKrP55PKNhQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-12_01,2026-06-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 priorityscore=1501 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606120058
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, TVD_SUBJ_WIPE_DEBT=1.004 autolearn=no autolearn_force=no
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

On 11/06/26 12:12, Philippe Mathieu-Daudé wrote:

> On 10/6/26 11:07, Aditya Gupta wrote:
>> Power8E and Power8NVL were deprecated since QEMU 10.1, with
>> commit 264a604e7163 ("target/ppc: Deprecate Power8E and Power8NVL")
>>
>> Remove the corresponding 8E and 8NVL CPU cores from spapr/pseries
>>
>> Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
>> ---
>>   docs/system/ppc/pseries.rst | 2 +-
>>   hw/ppc/spapr_cpu_core.c     | 2 --
>>   2 files changed, 1 insertion(+), 3 deletions(-)
>
> Squash with following?
>
Sure, you mean squash into patch #4, the target/ppc change ?


Thanks for reviewing !

- Aditya G


