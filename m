Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25E71EA3F0F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 07:04:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vphnY-0001AG-F2; Tue, 10 Feb 2026 02:04:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vphnV-00019w-R0; Tue, 10 Feb 2026 02:04:33 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vphnU-0004zs-9A; Tue, 10 Feb 2026 02:04:33 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 619Gf4Iq614323; Tue, 10 Feb 2026 07:04:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=xO617q2d3V/0iJUeS+S0sqpXU45bCE
 k4rhxbGSU5nWA=; b=RNdTvuY+FXdeH6aDwOX5LQn7YC04gHtFQkeDhnjK2h20dT
 aLUrh/odxLjY+Tni4woo0CHpV7UUqebC0pd/Y1h09h8bQ6nXq1/qHh26VVOqFl7T
 J/UA8S7zCkjuMWwixPV1YVBL+1fkW6llqPGdR/6oOAyo0zQJgpdcXSnbo0HxBNz9
 CESyY6fZnsd8yxmwVdf4BL+AKddca0+bT2iS979BFmFebMcqgvMBEQmtXi5iOFJ1
 Bukmq7+jiDTenzNIBVk0RcFDIU51tbRgKnwUpNBJQw7W6MvHk98QOjto9jjb4pnK
 UoC4FuBECmIVnUPIkU6tYWt/bIurSJfJhvjTGPlQ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c696w2wsa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Feb 2026 07:04:28 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61A4poDs001407;
 Tue, 10 Feb 2026 07:04:27 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4c6gqn0a17-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Feb 2026 07:04:27 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 61A74NxN48497074
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Feb 2026 07:04:23 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5F1482004B;
 Tue, 10 Feb 2026 07:04:23 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B80B520049;
 Tue, 10 Feb 2026 07:04:21 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.109.199.210])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Tue, 10 Feb 2026 07:04:21 +0000 (GMT)
Date: Tue, 10 Feb 2026 12:34:19 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: Caleb Schlossin <calebs@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, npiggin@gmail.com,
 milesg@linux.ibm.com, chalapathi.v@linux.ibm.com, harshpb@linux.ibm.com
Subject: Re: [PATCH v2 2/3] ppc/pnv: Add unimplemented quad and core regs
Message-ID: <aYrXdeZol4koVzYX@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
References: <20260126135507.771552-1-calebs@linux.ibm.com>
 <20260126135507.771552-3-calebs@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260126135507.771552-3-calebs@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=YeCwJgRf c=1 sm=1 tr=0 ts=698ad87c cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=L_DLxeZRvcLHnZ-rSf8A:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: WRmrGMpd74ZUbN4F49A8Up61PJCecKPV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEwMDA1NSBTYWx0ZWRfX2bAR8KUE3gSA
 AKv+1K1SLyX+oebHz0ktMHT5AQPtC8ggNf6r9j8n8KTXMchjec/IpX3Nwr+X8CIfILjMXjM6K7I
 Q7i1pwouVbcUEXpikl9myc1V5tNm4sx46ORRAXJxw32L51ySn8kFuvffdhHpmOqC8hWbmG7hjPM
 Ix40RpFqXr7FEdoFUDkTFyoYPGrKJ44FwnlMxpGjQf9+ACrBDYNzaZ6ZVmKLToxmnZHz3muPOEj
 oKj1mkmdKSr1QVVLvbXKV4lCekWeLavpKv4Fo+/4TWU4iccFMeILBFG/jx15W9xdkj/CwLgrqDS
 eq0WEwtMEJM1G3vICRS9P0Rk8oJ3vMD2RtkVbcD4r4YwhYdsV487dOjdy/GYNrmsSN+CGvtlLw/
 UWNT04rZBsYwqToWHxUUxoF0PdiSyLT6EgoELUC5SaupjbRiOxFfRegwrKx/9xi96SQJl3BC5oB
 rT+qVhN5GQ/ypMRta0w==
X-Proofpoint-ORIG-GUID: x3tNdKBaeuSsD7j6Cj8rYydWnph1no0V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-09_01,2026-02-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602100055
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Hello Caleb,

Was going through the patch again. Can we add a comment doc, about the
scoms for which the unimplemented warning is getting hidden ?

On 26/01/26 07:55AM, Caleb Schlossin wrote:
> <...snip...>
>
> @@ -284,6 +305,15 @@ static void pnv_core_power10_xscom_write(void *opaque, hwaddr addr,
>          }
>          break;
>  
> +    case PNV10_XSCOM_EC_IMA_EVENT_MASK:
> +    case PNV10_XSCOM_EC_CORE_FIRMASK:
> +    case PNV10_XSCOM_EC_CORE_FIRMASK_OR:
> +    case PNV10_XSCOM_EC_CORE_FIRMASK_AND:
> +    case PNV10_XSCOM_EC_SPATTN_OR:
> +    case PNV10_XSCOM_EC_SPATTN_AND:
> +    case PNV10_XSCOM_EC_SPATTN:
> +    case PNV10_XSCOM_EC_SPATTN_MASK:
> +        break;
>      default:
>          qemu_log_mask(LOG_UNIMP, "%s: unimp write 0x%08x\n", __func__,

Here, the unimp warning is getting skipped, by ignoring writes to those
scoms.
Similarly in other places, you return 0 as default value for few scom
reads.

A comment about the special treatment will help future developers to
read the code.

Thanks,
- Aditya G



