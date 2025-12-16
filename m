Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AF4BD609C2
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Dec 2025 17:10:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVYYR-0004iJ-ET; Tue, 16 Dec 2025 12:09:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vVYY1-0004fr-HD; Tue, 16 Dec 2025 12:09:18 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vVYXv-0004dy-D4; Tue, 16 Dec 2025 12:09:14 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BGAleVB029519;
 Tue, 16 Dec 2025 17:09:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=rE+P0XonqMfjjH8Xn65MFFkFcXymO9
 v4tr4LYElN8jg=; b=ESVQhTI5WOkKzPq9JD86dnb0wBfk0IJ9fe78vF3c7dwuOx
 JCxaDBDwchKf0cZ1Nsiy/huGXQGFDFanzlycZ6tCGNcQ0EcwEHfexnTwjtLMdybj
 Ji1GKKpZ9xLyMO4yi8D4iu4JEPKSGRioYE76GBSvfLP4xvOLBc0qkav1kXTeUb+G
 90+smyM4SBqRwvtA1j+Ug2USpyNHu+Ka2RbncnSY/nCMzGtBMNLs2H565677dAq0
 WTDHGt3QNPVI/rwuWB/xNhU+67q/OHGojKlITssATtYxGZxDpoxU7R4+K/vS/GDN
 DQnwbIRYKTG47x2XIa6ExTwBqPqoMAtxcHvm4qAQ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0yt1fqy9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Dec 2025 17:09:08 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BGH97be013952;
 Tue, 16 Dec 2025 17:09:08 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0yt1fqy5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Dec 2025 17:09:07 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BGGZd0h002945;
 Tue, 16 Dec 2025 17:09:07 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4b1kyknej7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Dec 2025 17:09:07 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5BGH937V23462278
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 Dec 2025 17:09:03 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 14EAB20049;
 Tue, 16 Dec 2025 17:09:03 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1A12E20040;
 Tue, 16 Dec 2025 17:09:00 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.124.209.67])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Tue, 16 Dec 2025 17:08:59 +0000 (GMT)
Date: Tue, 16 Dec 2025 22:38:57 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: Caleb Schlossin <calebs@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, npiggin@gmail.com,
 milesg@linux.ibm.com, alistair@alistair23.me, kowal@linux.ibm.com,
 chalapathi.v@linux.ibm.com, angeloj@linux.ibm.com
Subject: Re: [PATCH v3 0/7] hw/ppc: Snapshot support for several ppc devices
Message-ID: <x7itslairv77vr63fprjagwvscevftbbv4fjzabdkgwetgimxw@3fiiyq6xam4q>
References: <20251216151359.418708-1-calebs@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251216151359.418708-1-calebs@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: XnT1mCrI8njpzzWkRgDZHwp5OedcG8vD
X-Proofpoint-ORIG-GUID: PognN0HuR_E9DuwHER4JED-u7h0WP4OP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEzMDAyMyBTYWx0ZWRfX2ACU4PawrX3W
 xNvOTbqUnQeTc8F+NVoeLnHLNVdQt0XYEsyMOjOIPp9++E0fvBkdJAM83QQQDgC8XAvzQx7oivB
 awJvh9+Nc0tq1qFl3uvstgwe0jTOH5MftaHRU9RKuSfVP8u7Jk6qrA/XYwyYW08W7utYTWtidCi
 WkhIYAk6x0q+53659UyWyd6pXGwRF5JoKb0CAs8oJJuZsq3IW01UBsjUkc1VRXsbeZHF7bv8LiV
 riyoKgZyqdLiV7p70BTRKZpR20OMQZ8bmif2RqbF9b0Fo9XwGDiNIfFDVp1O3+mAIdtCdpB0JOO
 7+5VQaId1oM65ejdr9VS3YMATzIGV3/UJfvMCUKRermogpQg6v9H1/I+zrub92PRZ6pDfRzWuJs
 mvdAE4PkUy4MkQdGw60oEJDmAxZ32g==
X-Authority-Analysis: v=2.4 cv=L/MQguT8 c=1 sm=1 tr=0 ts=69419234 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=NvMH4ALGgqt76U9gcA8A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-16_02,2025-12-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 clxscore=1015 lowpriorityscore=0 bulkscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512130023
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
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

On 25/12/16 09:13AM, Caleb Schlossin wrote:
> Addressing comments from V2 review:
> 
> Updates in V3:
> - pnv_psi: Remove PSI_DEBUG section as it was not used
> - pnv_psi: Add missing post_load and vmstate info

Looks good to me now. Thanks for introducing this functionality in pnv
devices.

For the series:
Reviewed-by: Aditya Gupta <adityag@linux.ibm.com>

Thanks,
- Aditya G

> 
> Updates in V2:
> - Added new patch set for PnvPsi support as it fits with the rest
> - Added vmstate support for Power8 and Power9 for LPC
> - Fixed pnv_core.c commit message
> 
> Tested:
> passed make check
> 
> Thanks,
> Caleb
> 
> Michael Kowal (2):
>   hw/ppc: Add VMSTATE information for LPC model
>   hw/ppc: Add VMSTATE information to PnvPsi
> 
> Caleb Schlossin (2):
>   hw/ppc: Add pnv_spi vmstate support
>   hw/ppc: Add pnv_i2c vmstate support
> 
> Angelo Jaramillo (3):
>   hw/ppc: pnv_adu.c added vmstate support
>   hw/ppc: pnv_core.c add vmstate support
>   hw/ppc: pnv_chiptod.c add vmstate support
> 
>  hw/ppc/pnv_adu.c             | 12 +++++++++++
>  hw/ppc/pnv_chiptod.c         | 38 +++++++++++++++++++++++++++++++++
>  hw/ppc/pnv_core.c            | 22 +++++++++++++++++++
>  hw/ppc/pnv_i2c.c             | 11 ++++++++++
>  hw/ppc/pnv_lpc.c             | 41 ++++++++++++++++++++++++++++++++++++
>  hw/ppc/pnv_psi.c             | 36 +++++++++++++++++++++++++++++--
>  hw/ssi/pnv_spi.c             | 27 ++++++++++++++++++++++++
>  include/hw/ppc/pnv_chiptod.h |  2 ++
>  8 files changed, 187 insertions(+), 2 deletions(-)
> 
> -- 
> 2.47.3
> 

