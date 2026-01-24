Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 668D5D715DE
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Jan 2026 12:02:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjcLK-0005dK-DQ; Sat, 24 Jan 2026 07:02:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vjcLI-0005bN-4b; Sat, 24 Jan 2026 07:02:16 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vjcLG-0007RU-El; Sat, 24 Jan 2026 07:02:15 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60O5lAb2019252;
 Sat, 24 Jan 2026 12:02:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=CtqayhydY7hjIoDRSgCYrLkIA+M2hB
 WgwZg2llDIuaY=; b=sG/f2iI7Z62SA6zuenH98gMMgjMXLIt744ZzSWM5Q6tXR6
 GeFzdGZrcOvE70LtDNVtADuGMAbAwbtiEjjqjUy+ZX2RvV2tfXHuk7xjjh5rRL12
 rNKp+xGoR0gS/W5C/wPTC8ux3RQ1Q4KhL09EeJPjet0q9/Q5XvfBzxz+h+aXM+ZB
 p56xVFthLWIurKg9whyzsOUpFqknkPEarLA/GztpGFabkW1jtR2lpEppio7Q/CcJ
 QM3ehAQEftxYhOAOfp4jknZk1npCuHSQsWSBQko4CRusrneeMpsBvIhe7w0wRjQx
 xU2BRceoeSVfUT6CUVvNnjAv08cKT7LhUEyWdoNg==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvnrt1att-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 24 Jan 2026 12:02:12 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60OC2BCD000304;
 Sat, 24 Jan 2026 12:02:11 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvnrt1atp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 24 Jan 2026 12:02:11 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60O7Dmq0027220;
 Sat, 24 Jan 2026 12:02:10 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4brnrnnf17-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 24 Jan 2026 12:02:10 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 60OC268x28836368
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 24 Jan 2026 12:02:06 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 89BC320043;
 Sat, 24 Jan 2026 12:02:06 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F41A020040;
 Sat, 24 Jan 2026 12:02:02 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.39.25.49]) by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Sat, 24 Jan 2026 12:02:02 +0000 (GMT)
Date: Sat, 24 Jan 2026 17:32:00 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: Caleb Schlossin <calebs@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, npiggin@gmail.com,
 milesg@linux.ibm.com, rathc@linux.ibm.com, fbarrat@linux.ibm.com,
 chalapathi.v@linux.ibm.com, harshpb@linux.ibm.com
Subject: Re: [PATCH v2] ppc/pnv: Add a nest MMU model
Message-ID: <aXS0XTX2VQHHUbvd@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
References: <20260120150139.714805-1-calebs@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260120150139.714805-1-calebs@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: UGapv8Gs83byfEqLq4-mJDAb_PyUQF9o
X-Authority-Analysis: v=2.4 cv=Uptu9uwB c=1 sm=1 tr=0 ts=6974b4c4 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=vOhWKxnM8ZvxlOCtnnYA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: WB-HWq622lywrBLcTkQPdeL90Q7AOffK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI0MDA5NCBTYWx0ZWRfX/ncDxuv7idjX
 CVQoRMd5bQ0EenE/ZuQtbBH3GjBHABxr4SJfNhJbzNxa8Q9Vv+rvKYQLMm9XMLarK4TUlwyIVxv
 Wkqzc3IyeXlIHcMgCpn3Kfcp+UmCQMuo+4OcTQZPrgd0a/osuaDSZb+7KmLcXUKtYSWG2kRbXMW
 R1zYJ92hRjYjr2mxGhRDP4RV7DreE/KM8bWkLtRY3CaLqICYbVEDAarBdoDLtsqp5J5PBBBfRYG
 BP5TfAIb3kYTWPZe7XFqCIuQPHvNF597JEDnz7Hyw/SprY3HNummIG77mxnaWfdvTiF3okdzIAb
 Em/6gDETN8ZkGzAJLtTAE6uC43M3WUTwiG421x/937jr6T7Ywsjo+u2de6FWn2fLA0asNXDcC9G
 Pr+cY01ErfL/rpHBZt/MbHmykeQ8ro3BYfL4CSgCzWRN6IvYpaEcFhPL7n9qlHDMxNDlvtPTJW2
 tapXrOCaHxVMCOB5Jgg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-24_02,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 clxscore=1015 lowpriorityscore=0
 phishscore=0 adultscore=0 impostorscore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2601240094
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 26/01/20 09:01AM, Caleb Schlossin wrote:
> The nest MMU is used for translations needed by I/O subsystems
> on Power10. The nest is the shared, on-chip infrastructure
> that connects CPU cores, memory controllers, and I/O.
> 
> This patch sets up a basic skeleton with its xscom
> area, mapping both needed xscom regions. Support required
> for PowerVM bringup.
> 
> Use Power9 property for device tree to allow OPAL to
> work with Power9 and Power10.
> 
> Reviewed-by: Chalapathi V <chalapathi.v@linux.ibm.com>
> Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
> Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
> Signed-off-by: Chalapathi V <chalapathi.v@linux.ibm.com>
> Signed-off-by: Caleb Schlossin <calebs@linux.ibm.com>

Thanks for the patch.

Reviewed-by: Aditya Gupta <adityag@linux.ibm.com>

- Aditya G


