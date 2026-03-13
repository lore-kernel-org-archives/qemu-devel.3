Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20BFC105F79B
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 11:22:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w10a0-0001ro-Nq; Fri, 13 Mar 2026 07:21:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1w10Zy-0001rP-Ty; Fri, 13 Mar 2026 07:21:19 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1w10Zx-0000ye-Br; Fri, 13 Mar 2026 07:21:18 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62D4VgV22278217; Fri, 13 Mar 2026 11:21:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=krC2FoZY8TVRztjOsfz0t8nQIBxHwp
 Ck+mjR2fSXcZ0=; b=DvaEWEFEcCWvV4n0kQMX5ekhPvXAie4ewv5Z+3K988QrnX
 V2KL4nwFqw+mSzZocKO9fVRDX1LjqBkpqIeVnGcuc4clGe3QNuPuCaFlCn+ZrvD8
 jySxYigszEUW4kEplwTDZQ6/EeOxIsB2FKuHQkKEJ0Or/1QCIA/Uy+pINGtREMwM
 5Ol0MQt7e2K1AQ6XYLJYLwSxPvkGgLyY7SbH9fNIFcxECDpE+JC1ygi6qDJvbToq
 SeNqIvSv83b3aNi9q0J8XSg7OXq3iCAiAIVt7YgTFwlx0vFiKTtAVDWcmMk99YLb
 va4oeRY7OxdyOS1Jae7ErNu104f4UBX2jXt8ovCw==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cuh91qfxd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 13 Mar 2026 11:21:04 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62DAZCjA006042;
 Fri, 13 Mar 2026 11:21:03 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cuha9pdk6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 13 Mar 2026 11:21:03 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62DBL0Rn27918704
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Mar 2026 11:21:00 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E87892004E;
 Fri, 13 Mar 2026 11:20:59 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 47B772004B;
 Fri, 13 Mar 2026 11:20:56 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.124.217.187])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Fri, 13 Mar 2026 11:20:56 +0000 (GMT)
Date: Fri, 13 Mar 2026 16:50:53 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: Shivang Upadhyay <shivangu@linux.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, npiggin@gmail.com,
 milesg@linux.ibm.com, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>, qemu-stable@nongnu.org
Subject: Re: [PATCH v2] ppc/pnv: fix dumpdtb option
Message-ID: <abPy6W6-_putw9Tz@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
References: <20260311143549.118720-1-shivangu@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260311143549.118720-1-shivangu@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: -g2upIhjX9cwzFsfbQfNORufH1IbGige
X-Authority-Analysis: v=2.4 cv=E6/AZKdl c=1 sm=1 tr=0 ts=69b3f320 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=69wJf7TsAAAA:8 a=tYiP9IUGiIZ_IUM1XqsA:9
 a=CjuIK1q_8ugA:10 a=cvBusfyB2V15izCimMoJ:22 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDA4NiBTYWx0ZWRfX62qkc6qPKkSV
 Otx9rNYwsqIO5SYnaUyLuTUv9BgjiHtM0HDbghKg2QkMEwfRWlpHrhiNQBMTijrZKtXzfFu/pVS
 0Rp2/V1XhynO69sFajdwvtcYp5L2na/F0TjK7HilUB8RNs/tRueHJd1k1GdSIN52n0brm5G38/2
 YnxUe5biMIT562C+rBDHv7D8x6xK7azXZyFk25dvao75/YNMz6EW3sDBNq2/vWskTB68jSEMHkj
 2CE4Oem7IN1ACZOLaAR+JzqQrQMWGRQjrEpyhkAeeEdOCqG0cuCX3Y2RFYSLZ4tYNOgLI59rDfk
 zsAfAgRQR5e8K7U9EWkgTjIuMUs83LSDd7EhCJgFKstQ2KXnbsBvyipRQiDV/sVfX2T66Nzke7y
 A4Jh3bdZgayIpICooWcXYahF2Q3lo43Fob/ipYAeY7NORWtfGkqR2otlLJuXoyKeZbK/qpQl6Lp
 Ax3qvZ5TidI8seiHOQw==
X-Proofpoint-ORIG-GUID: iEeAFtIP9K06sR8nVY3moBeP53lA8vQF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_02,2026-03-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0 phishscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603130086
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 26/03/11 08:05PM, Shivang Upadhyay wrote:
> The '-machine dumpdtb' command line option stopped working on
> PowerPC/pnv systems after recent design change [1].
> 
> Fixing this by generating fdt blob in `pnv_init`.
> 
> [1] https://lore.kernel.org/qemu-devel/20250206151214.2947842-1-peter.maydell@linaro.org/
> 
> Cc: Aditya Gupta <adityag@linux.ibm.com>
> Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: BALATON Zoltan <balaton@eik.bme.hu>
> Cc: qemu-stable@nongnu.org
> Fixes: 8fd2518ef2f8d34 ("hw: Centralize handling of -machine dumpdtb option")
> Signed-off-by: Shivang Upadhyay <shivangu@linux.ibm.com>

Looks good to me.

Reviewed-by: Aditya Gupta <adityag@linux.ibm.com>

Thanks,
- Aditya G


