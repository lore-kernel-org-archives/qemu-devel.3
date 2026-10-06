Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E252CA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:20:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEMsH-0007V5-8u; Wed, 07 Oct 2026 04:19:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1xEHLG-0003PP-Kj; Tue, 06 Oct 2026 22:25:28 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1xEHL8-00083s-3W; Tue, 06 Oct 2026 22:25:10 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 696DZndQ3725801; Tue, 6 Oct 2026 14:12:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=wRIVhhHnpJQpRblu/W7Spl4ZWuLW+sizk4CsKz3S7Qo=; b=VVXTyWs/LiO1
 V28ghc/w33EixIuY4vzmL/qElGvPgOBJUZCuulDqkv8M09ZvaoXjoJ+qY5n/x+fQ
 XIsXa7bNL66SclFvnQ9uUgTWrMuBMclt/jubAT6gSdP5oe6ov1T6Wo42x35Kj5JH
 jJJij56gglp7p30m3M52SPWCY7RIMAGErtzQGo9uo2+i0JharFSjidPwolfXdH4e
 Qp8VnErbV4mXE0KQwZ6jVIWbPD0XmOiy31A/CE+XLZTIUMq0FDD8n1asiKA8XfdC
 pT8j67oFEFgFIdyI+voTwmnuEjqRLvMsv8YS2sypE4UJkl8JxTV46C7HOamwa/lM
 gKIfUwNJSw==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2q4jquvg-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 06 Oct 2026 14:12:07 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 696DWXuf361216; Tue, 6 Oct 2026 14:12:06 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h3c1ptdp6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 06 Oct 2026 14:12:06 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 696EC5u819595974
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 6 Oct 2026 14:12:05 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1B6825805A;
 Tue,  6 Oct 2026 14:12:05 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5C70D5805D;
 Tue,  6 Oct 2026 14:12:04 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  6 Oct 2026 14:12:04 +0000 (GMT)
Message-ID: <ff76938939cac5d306f84af4ba5d3cd75d854248.camel@linux.ibm.com>
Subject: Re: [RFC PATCH 0/8] Enable DMF for Power ISA 3.2
From: Miles Glenn <milesg@linux.ibm.com>
To: Chinmay Rath <rathc@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, harshpb@linux.ibm.com
Cc: npiggin@gmail.com, amachhiw@linux.ibm.com, uverma@linux.ibm.com, Saif
 Abrar <saif.abrar@linux.ibm.com>
Date: Tue, 06 Oct 2026 09:12:03 -0500
In-Reply-To: <20261006105650.189752-1-rathc@linux.ibm.com>
References: <20261006105650.189752-1-rathc@linux.ibm.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: luEsak5RHv1PzM9jzuzlhdsjfLgYefdw
X-Proofpoint-GUID: 5OD9859gParwS2CabRe_mvn7Y-sy-zlV
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDA1NiBTYWx0ZWRfX28M98PUMzaXW
 vgDVqosYRVU/M8S/EbLYt1n/9Qz7zTbUWm8Q7UJJjHKTvFknFB7VRveCl0RVqUpB4yJYwY5vtu2
 ktQNHWzySCk+GmF0g/jzas8s5r9OADg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDA1NiBTYWx0ZWRfX4IdSlsxAOm8X
 ULAPGMFnizHBMG7s/wwVUQaEkzuIYSk7M/LzWcy0tq19UrsIuaMynNZllTEVoirZfd2DqyBGG35
 ok2/LP13sw1ZUtBIWZPsUE/AyEUmeO8eeN5s3okkEU6mf02mMnIvWHLOBEiQ1y0VHmwnJ8mtVYE
 cfI81h+GH2ACM2HVbQkprKy0Kb4NGHEr4vmEW7lKSc+6wzqPD/3QxfXGLYwB/Y5rXxRKwf6yRxw
 wuN3A5fp9OWJQpjOsw8ob2ZnGZibiQ3Ms4VJQHKiVGycMBjXlvWwmHrfgC8IBveeZZpnKmoh90c
 AgY3YVzdw/5OAaBT8jWZmaWvme0quQBmbTRBiB6jx64HXdale/0n8rQ7uyQm3Au5FJRzYDeCvEy
 YoPg8AZU6qllP20/UuSrCT/qQgStDuTPU7SXlVDXt2HEGRRREvFL4DHCFWIuWlJ7Cl4+P7HxnKv
 j4qG6SbAB45Nk7CnZYA==
X-Authority-Analysis: v=2.4 cv=eYeo7LEH c=1 sm=1 tr=0 ts=6ac501b7 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=Ixqt2FsUAAAA:8
 a=pNjESXi9GmZwinAVpVkA:9 a=QEXdDO2ut3YA:10 a=wbNHd7AAyUN6gYWAVcba:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_04,2026-10-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0 clxscore=1015
 spamscore=0 malwarescore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610060056
Received-SPF: pass client-ip=148.163.158.5; envelope-from=milesg@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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
Reply-To: milesg@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

I know that Saif has done some work on DMF recently so adding him to
the CC list as well.

Regards,

Glenn
 
On Tue, 2026-10-06 at 16:26 +0530, Chinmay Rath wrote:
> This series aims to implement the dense math facility introduced in
> RFC 02653: Dense Math Facility for Power ISA 3.2.
> The RFC is available in the OpenPOWER website here :
> https://files.openpowerfoundation.org/s/Fyp9TWZf8oYTd7D
> 
> Chinmay Rath (8):
>   target/ppc: Add flag for Power ISA 3.2
>   target/ppc: Enable Dense Math Facility for ISA 3.2
>   target/ppc: Implement DMR getter/setter and some DMF insns.
>   target/ppc: Add FSSIR spr for ISA 3.2
>   target/ppc: Implement DMMR and DMXOR instructions.
>   target/ppc: Implement DMF accumulator instructions
>   target/ppc: Add function to point to dmr regs in tcg_env
>   target/ppc: Add DMF Outer-Product accumulate to ACC insns
> 
>  target/ppc/cpu.h                    |  23 ++-
>  target/ppc/fpu_helper.c             |   5 +
>  target/ppc/helper_regs.c            |   4 +
>  target/ppc/insn32.decode            | 201 +++++++++++++++++-----
>  target/ppc/insn64.decode            | 244 +++++++++++++++++++-------
>  target/ppc/int_helper.c             |   5 +
>  target/ppc/translate.c              |  13 ++
>  target/ppc/translate/dmf-impl.c.inc | 255 ++++++++++++++++++++++++++++
>  8 files changed, 644 insertions(+), 106 deletions(-)
>  create mode 100644 target/ppc/translate/dmf-impl.c.inc
> 


