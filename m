Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86F22C2A07B
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 09:22:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vcgn3-0004Xl-4K; Mon, 05 Jan 2026 04:22:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vcgn0-0004XU-7K; Mon, 05 Jan 2026 04:22:14 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vcgmy-0003yu-IT; Mon, 05 Jan 2026 04:22:13 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60511fuC030074;
 Mon, 5 Jan 2026 09:22:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=NH9n7n
 Kmqf2eVSI7WSG7Z4WidEsuIVGu7nacknVsWUo=; b=hE2VpDN/ZWpyDZAZrIKEFV
 4f16T236sTwzOir8I+A0hfzuB459R2KLmMl/fzQv/3mMcAXKTGvFBGESdUCuV6HK
 igsQag8XADg7WfG915VEHbRT1ZHENJgKmQV625J1SLc9SNQd06ftH6JiGvVQXKih
 zpPXQYIrfBEUAJVjLcN2cVmnZY2l0rPrtbWq+yhs2+HQnIIxpdGyZ5bmy4dVd83j
 gxPhRRfrbV7KdNKvpepE5Atn87ms6o7R6TwLHAGpnLr/BW7pHoB9McFbwE0XZoJj
 uUvXRO26gZa2qhG7EotP8yQ/5oEL+EITe3TZeS1qVhZQ84rLzbkHIw79NMJ40U7w
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4betrtdva4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 05 Jan 2026 09:22:09 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 6059K2Ps023474;
 Mon, 5 Jan 2026 09:22:08 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4betrtdva1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 05 Jan 2026 09:22:08 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6057XJlX012645;
 Mon, 5 Jan 2026 09:22:07 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bffnj4qpy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 05 Jan 2026 09:22:07 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6059LlLP21496532
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 5 Jan 2026 09:21:48 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0FCCB58061;
 Mon,  5 Jan 2026 09:22:05 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 745C858058;
 Mon,  5 Jan 2026 09:22:01 +0000 (GMT)
Received: from [9.109.216.92] (unknown [9.109.216.92])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  5 Jan 2026 09:22:01 +0000 (GMT)
Message-ID: <9f59b26e-ba76-430f-a725-ef36f2fd4ab8@linux.ibm.com>
Date: Mon, 5 Jan 2026 14:51:59 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/7] hw/ppc: Snapshot support for several ppc devices
Content-Language: en-GB
To: Chalapathi V <chalapathi.v@inux.ibm.com>,
 Caleb Schlossin <calebs@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, npiggin@gmail.com, adityag@linux.ibm.com,
 milesg@linux.ibm.com, alistair@alistair23.me, kowal@linux.ibm.com,
 chalapathi.v@linux.ibm.com, angeloj@linux.ibm.com
References: <20251216151359.418708-1-calebs@linux.ibm.com>
 <8ed05d78-f09a-4718-9ed6-ea24d3ca5f57@inux.ibm.com>
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <8ed05d78-f09a-4718-9ed6-ea24d3ca5f57@inux.ibm.com>
X-TM-AS-GCONF: 00
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=aaJsXBot c=1 sm=1 tr=0 ts=695b82c1 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RpNjiQI2AAAA:8 a=VnNF1IyMAAAA:8
 a=iwG3B9P1yltx3OCZH54A:9 a=lqcHg5cX4UMA:10 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: vbBuLcgIwJlBzaWX3kRfNWo7i_Fdt2jL
X-Proofpoint-ORIG-GUID: x_nk_KAtLldgRxMZ33NbzGsBHbOt_27f
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA1MDA4MiBTYWx0ZWRfX6QONId/o78OB
 ft1wrZzsjd9eNXA0OaksylhXyqp6W3A8CB0GI6uGWW3M4WoFGzK5QBAxUsKw5r0ZF1sO94n3Cug
 EzvNMMq9nngbT3sR3r9YibWQ4LqVsnDGWExYwe31m4QpouzqXJvDx2Y1pTHCooaxPaOadJzzffT
 lmh6/AF5Aw+iXc+pResRMoB70h/a4FSDG+dP1t5vlenLZg9HqNrwWaZzCayGVz+4QIZVdYVwcjV
 eRj4C33DBxcMuNNenrQFaFY3aiWIH6AsNgCvdQblkSjijQ6IuTRXliz8qFjiMqFt3dIOe8XoNFo
 4NFFLXE+wwyNof6mVU8WAlL5Uvsld0y8EpG0pb2d0uv1WhlrZrjxY3pCTzulbQ6y3BRIbexfQCc
 LRoDl22zO4NXni56R28q/U5o6iFL6QNoeIWSei483RB/ohBtH5wLTkgMvIGWJ4ZY+xhtzlg81x4
 9re8B43HMVHbtWcxiEw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_01,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 clxscore=1011 phishscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2601050082
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Caleb,

Thanks for addressing the review comments.
I am seeing a git am failure on top of upstream commit 159107e390609f.
Could you please take a look, rebase and resend?

% git am=20
patches/v3_20251216_calebs_hw_ppc_snapshot_support_for_several_ppc_devices.=
mbx
Applying: hw/ppc: Add VMSTATE information for LPC model
Applying: hw/ppc: Add pnv_spi vmstate support
error: patch failed: hw/ssi/pnv_spi.c:13
error: hw/ssi/pnv_spi.c: patch does not apply
Patch failed at 0002 hw/ppc: Add pnv_spi vmstate support
hint: Use 'git am --show-current-patch=3Ddiff' to see the failed patch
hint: When you have resolved this problem, run "git am --continue".
hint: If you prefer to skip this patch, run "git am --skip" instead.
hint: To restore the original branch and stop patching, run "git am=20
--abort".
hint: Disable this message with "git config set advice.mergeConflict false"

Thanks
Harsh

On 22/12/25 4:31 pm, Chalapathi V wrote:
> For the series: Reviewed-by: Chalapathi V <chalapathi.=E2=80=8Av@=E2=80=
=8Alinux.=E2=80=8Aibm.=E2=80=8A=20
> com> Thank You, Chalapathi On 16/12/25 8:=E2=80=8A43 pm, Caleb Schlossin =
wrote:=20
> Addressing comments from V2 review: Updates in V3: - pnv_psi: Remove=20
> PSI_DEBUG section as it was not
>=20
>=20
> For the series:
> Reviewed-by: Chalapathi V <chalapathi.v@linux.ibm.com>
>=20
> <mailto:milesg@linux.ibm.com>Thank You,
>=20
> Chalapathi
>=20
>=20
> On 16/12/25 8:43 pm, Caleb Schlossin wrote:
>> Addressing comments from V2 review:
>>
>> Updates in V3:
>> - pnv_psi: Remove PSI_DEBUG section as it was not used
>> - pnv_psi: Add missing post_load and vmstate info
>>
>> Updates in V2:
>> - Added new patch set for PnvPsi support as it fits with the rest
>> - Added vmstate support for Power8 and Power9 for LPC
>> - Fixed pnv_core.c commit message
>>
>> Tested:
>> passed make check
>>
>> Thanks,
>> Caleb
>>
>> Michael Kowal (2):
>>    hw/ppc: Add VMSTATE information for LPC model
>>    hw/ppc: Add VMSTATE information to PnvPsi
>>
>> Caleb Schlossin (2):
>>    hw/ppc: Add pnv_spi vmstate support
>>    hw/ppc: Add pnv_i2c vmstate support
>>
>> Angelo Jaramillo (3):
>>    hw/ppc: pnv_adu.c added vmstate support
>>    hw/ppc: pnv_core.c add vmstate support
>>    hw/ppc: pnv_chiptod.c add vmstate support
>>
>>   hw/ppc/pnv_adu.c             | 12 +++++++++++
>>   hw/ppc/pnv_chiptod.c         | 38 +++++++++++++++++++++++++++++++++
>>   hw/ppc/pnv_core.c            | 22 +++++++++++++++++++
>>   hw/ppc/pnv_i2c.c             | 11 ++++++++++
>>   hw/ppc/pnv_lpc.c             | 41 ++++++++++++++++++++++++++++++++++++
>>   hw/ppc/pnv_psi.c             | 36 +++++++++++++++++++++++++++++--
>>   hw/ssi/pnv_spi.c             | 27 ++++++++++++++++++++++++
>>   include/hw/ppc/pnv_chiptod.h |  2 ++
>>   8 files changed, 187 insertions(+), 2 deletions(-)
>>


