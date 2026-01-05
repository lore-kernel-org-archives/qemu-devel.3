Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05020C79FA3
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 16:05:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vcmv0-0002ox-AQ; Mon, 05 Jan 2026 10:54:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1vcmux-0002oT-0d; Mon, 05 Jan 2026 10:54:51 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1vcmuv-0007uY-5l; Mon, 05 Jan 2026 10:54:50 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 605D99FK000759;
 Mon, 5 Jan 2026 15:54:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=7rNBPT
 fY3QHeQ6vc8h0Aj4PQlaF50J7Utca2rigsauE=; b=F/yQgFhZBz5gQVlUnldMl0
 Cvz7kr0CnIUjGw+E+qADAzxfirIg+Xpg4fy53W7myQ1CdMPt13DrFZXU+vAzZfdz
 KfvUzRPCRGpy2wnJ85vGNRhpSBcf3M1fXWakEExLu8s7bdscStZVZf+ZiQrjqc8o
 V1H0LWLuI6pzw3u7bqkh5FIYz5GsrEDwLRwgg9CDb6P5MoEReMFx2Va9+pE1dvgJ
 LwGQG9N5CX8GF4eDEOC+YpNXAKz+GJ0RvDMf/0NjNUPSyr98wn+UxjCSFFRquver
 w6E1K80QgOjp9gdqKCyoaeNv/Ka62EyJ3HzIeioWV52L8Hmwv1HtdEAYmhCD67mw
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4betrtfc8x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 05 Jan 2026 15:54:44 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 605FfZv4010926;
 Mon, 5 Jan 2026 15:54:43 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4betrtfc8t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 05 Jan 2026 15:54:43 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 605EU0pe005284;
 Mon, 5 Jan 2026 15:54:43 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bfexjxjtt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 05 Jan 2026 15:54:43 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 605FsNun29229694
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 5 Jan 2026 15:54:23 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 43CE258052;
 Mon,  5 Jan 2026 15:54:41 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 56A2A58045;
 Mon,  5 Jan 2026 15:54:40 +0000 (GMT)
Received: from [9.10.80.137] (unknown [9.10.80.137])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  5 Jan 2026 15:54:40 +0000 (GMT)
Message-ID: <ac981147-f670-4dc7-b1b0-fa90f4f51560@linux.ibm.com>
Date: Mon, 5 Jan 2026 09:54:39 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/7] hw/ppc: Snapshot support for several ppc devices
To: Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Chalapathi V <chalapathi.v@inux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, npiggin@gmail.com, adityag@linux.ibm.com,
 milesg@linux.ibm.com, alistair@alistair23.me, kowal@linux.ibm.com,
 chalapathi.v@linux.ibm.com, angeloj@linux.ibm.com
References: <20251216151359.418708-1-calebs@linux.ibm.com>
 <8ed05d78-f09a-4718-9ed6-ea24d3ca5f57@inux.ibm.com>
 <9f59b26e-ba76-430f-a725-ef36f2fd4ab8@linux.ibm.com>
Content-Language: en-US
From: Caleb Schlossin <calebs@linux.ibm.com>
In-Reply-To: <9f59b26e-ba76-430f-a725-ef36f2fd4ab8@linux.ibm.com>
X-TM-AS-GCONF: 00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=aaJsXBot c=1 sm=1 tr=0 ts=695bdec4 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RpNjiQI2AAAA:8 a=VnNF1IyMAAAA:8 a=5aVG2hVjmkKWcmxzNIoA:9 a=lqcHg5cX4UMA:10
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 11EyPi1oAz99gM3-KcSIP_p9JehyXTYz
X-Proofpoint-ORIG-GUID: udqwVUhfJPJO-l75MBXhoWgfEv-0buxa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA1MDEzOCBTYWx0ZWRfX5SKIVg7OTKzn
 C7qTMPwdURB/ksdQ0kE6A2LIiyB8snX51YX9cdnLVuSUFdOgP99/hgzfMPmq3A6gWjS3AAmqked
 aUQfN8xEg696hM1phPun+tQC4cseH1ZyO8NCA0Y5V5CoonyCR7RDp46x5o76kZbKmJxJE1xlUGo
 Zr8p02WNtM/49YjtB05vsmw2Jt7GRTmV4o5Eu5BHm39YL0l9j4Z/+iYOQxc8pkOq4iaK5cLG7eF
 1KTjQ+VQkktFs7R1yNHoBB0JGx0Qvh5K+158FWWIUQWWoV+W0gthgExRl7RNMFPlGVy1wCRM0Eo
 kPK1ERTWk0Q7O0VPUIJ7yIvrYgN8fritQv0ZEC06MT9onMZZVylqPuzqb56tdhjKa70v6YRvKDL
 3TBfKvIaWnSeP/iE+2c1Rm/KuNZ3eX+iHLgkUumlpBS+1NK6ixVPFX0Bg5m/Nqp3aHFdlOevyle
 +iYGY2Dl3t2RMDrn2Ag==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_01,2026-01-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 clxscore=1015 phishscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2601050138
Received-SPF: pass client-ip=148.163.158.5; envelope-from=calebs@linux.ibm.com;
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



On 1/5/26 3:21 AM, Harsh Prateek Bora wrote:
> Hi Caleb,
>=20
> Thanks for addressing the review comments.
> I am seeing a git am failure on top of upstream commit 159107e390609f.
> Could you please take a look, rebase and resend?
>=20
> % git am patches/v3_20251216_calebs_hw_ppc_snapshot_support_for_several_p=
pc_devices.mbx
> Applying: hw/ppc: Add VMSTATE information for LPC model
> Applying: hw/ppc: Add pnv_spi vmstate support
> error: patch failed: hw/ssi/pnv_spi.c:13
> error: hw/ssi/pnv_spi.c: patch does not apply
> Patch failed at 0002 hw/ppc: Add pnv_spi vmstate support
> hint: Use 'git am --show-current-patch=3Ddiff' to see the failed patch
> hint: When you have resolved this problem, run "git am --continue".
> hint: If you prefer to skip this patch, run "git am --skip" instead.
> hint: To restore the original branch and stop patching, run "git am --abo=
rt".
> hint: Disable this message with "git config set advice.mergeConflict fals=
e"
>=20
> Thanks
> Harsh

Thanks for letting me know. Will rebase and fix as part of v4 patch set.

Thanks,
Caleb

>=20
> On 22/12/25 4:31 pm, Chalapathi V wrote:
>> For the series: Reviewed-by: Chalapathi V <chalapathi.=E2=80=8Av@=E2=80=
=8Alinux.=E2=80=8Aibm.=E2=80=8A com> Thank You, Chalapathi On 16/12/25 8:=
=E2=80=8A43 pm, Caleb Schlossin wrote: Addressing comments from V2 review: =
Updates in V3: - pnv_psi: Remove PSI_DEBUG section as it was not
>>=20
>>
>> For the series:
>> Reviewed-by: Chalapathi V <chalapathi.v@linux.ibm.com>
>>
>> <mailto:milesg@linux.ibm.com>Thank You,
>>
>> Chalapathi
>>
>>
>> On 16/12/25 8:43 pm, Caleb Schlossin wrote:
>>> Addressing comments from V2 review:
>>>
>>> Updates in V3:
>>> - pnv_psi: Remove PSI_DEBUG section as it was not used
>>> - pnv_psi: Add missing post_load and vmstate info
>>>
>>> Updates in V2:
>>> - Added new patch set for PnvPsi support as it fits with the rest
>>> - Added vmstate support for Power8 and Power9 for LPC
>>> - Fixed pnv_core.c commit message
>>>
>>> Tested:
>>> passed make check
>>>
>>> Thanks,
>>> Caleb
>>>
>>> Michael Kowal (2):
>>> =C2=A0=C2=A0 hw/ppc: Add VMSTATE information for LPC model
>>> =C2=A0=C2=A0 hw/ppc: Add VMSTATE information to PnvPsi
>>>
>>> Caleb Schlossin (2):
>>> =C2=A0=C2=A0 hw/ppc: Add pnv_spi vmstate support
>>> =C2=A0=C2=A0 hw/ppc: Add pnv_i2c vmstate support
>>>
>>> Angelo Jaramillo (3):
>>> =C2=A0=C2=A0 hw/ppc: pnv_adu.c added vmstate support
>>> =C2=A0=C2=A0 hw/ppc: pnv_core.c add vmstate support
>>> =C2=A0=C2=A0 hw/ppc: pnv_chiptod.c add vmstate support
>>>
>>> =C2=A0 hw/ppc/pnv_adu.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | 12 +++++++++++
>>> =C2=A0 hw/ppc/pnv_chiptod.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 38 +++++++++++++++++++++++++++++++++
>>> =C2=A0 hw/ppc/pnv_core.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 | 22 +++++++++++++++++++
>>> =C2=A0 hw/ppc/pnv_i2c.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | 11 ++++++++++
>>> =C2=A0 hw/ppc/pnv_lpc.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | 41 ++++++++++++++++++++++++++++++++++++
>>> =C2=A0 hw/ppc/pnv_psi.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | 36 +++++++++++++++++++++++++++++--
>>> =C2=A0 hw/ssi/pnv_spi.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | 27 ++++++++++++++++++++++++
>>> =C2=A0 include/hw/ppc/pnv_chiptod.h |=C2=A0 2 ++
>>> =C2=A0 8 files changed, 187 insertions(+), 2 deletions(-)
>>>
>=20


