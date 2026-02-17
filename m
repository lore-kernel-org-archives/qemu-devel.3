Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A961E8385B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Feb 2026 07:14:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsFHf-0007N6-1q; Tue, 17 Feb 2026 02:14:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vsFHX-0007Kc-ES; Tue, 17 Feb 2026 02:14:03 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vsFHW-0003qT-2b; Tue, 17 Feb 2026 02:14:03 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61H505ML3310647; Tue, 17 Feb 2026 07:14:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=HKsWdBHfX8vQk0ENBocK4+IxdVEsMz
 oAr8eSrkajCd8=; b=IBwDuMpmGtzVvNyUgtxjr2yWXGlSJINY5MJMil04Rr1zd2
 H4OridF0ljg1Er64n/CahylylZKfOAZl8ITZniLp4bdvF/kGuUHD9mAbRK6Z/ouk
 BXJzJt/okcNpoJbamb9z2E1Dt4G81XxRfbWct0xz8PuvJWyerkXi8L5e57jWncT9
 Xl+KEsSJv7zMKqauqOaTnJh+kfNI73LSzJa4Rrgh6n4zWVSAHGl4E0SYBvHqUBaA
 ASdENCWuE/Cbi3SmPC+raDO1ttc/eNVAIf1UaVLxXg3WJgyGftMO6zKx1fYV6DNK
 TXX+fKrcH0eltl7nezW3ac2P7feXo4JZbRGnqVIw==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4caj4ka2w2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 17 Feb 2026 07:14:00 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61H3Jem6023886;
 Tue, 17 Feb 2026 07:14:00 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ccb451fh2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 17 Feb 2026 07:13:59 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 61H7DtrO50856256
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 17 Feb 2026 07:13:55 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AFA332004B;
 Tue, 17 Feb 2026 07:13:55 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5F09E20043;
 Tue, 17 Feb 2026 07:13:54 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.109.199.210])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Tue, 17 Feb 2026 07:13:54 +0000 (GMT)
Date: Tue, 17 Feb 2026 12:43:52 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: Hari Bathini <hbathini@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: Re: [PATCH v2 8/9] pnv/mpipl: Enable MPIPL support
Message-ID: <aZQU2n-YFOxp-YQN@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
References: <20251206055648.1908734-1-adityag@linux.ibm.com>
 <20251206055648.1908734-9-adityag@linux.ibm.com>
 <f67681eb-d2b2-48cd-995c-a889550cdba4@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f67681eb-d2b2-48cd-995c-a889550cdba4@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDA1OCBTYWx0ZWRfX8hjC1JTCgny/
 3LcZAudEKofCjilTxuFJy6gNhnJ7lBYRwaqGR/MV6SrVm7BJr2mtA5skV+bOGIZx+Aewgz4F+/P
 FEw/oxOX4oIux2umu0Bp+DPBaIhzWdYpYiny7LN2SSHrkf3DsIbTMOyrRx2rJybYhkrN6iW5Nve
 /paHRQGAWzPbSY8kkE5AX4PUBeY/HPx8I6Ki5d+f7SWa4lNXT/IMxxjxcO05BanG0RsaDoS/YmY
 9Jmk+aHFc2U5b+vzKE3GMXbuy+bsfkRORwmVX2FY5/xrZVymTnyI3MqoFucLioMH9Aw46wRm36l
 PAYIRpZ6EpJTPb3PQ0kwOdj8pQhJG+hld0FqnEcAN5eB2LfiR95Lw8pEmlribK4QIpWnaahXf6o
 u+2W9VZklLf6goycn3sijdt72tsrJSDU3+3JD6AWVo3Jiqkno05yj7pn2Ra3cokLGIAEDFGKtni
 ZXsPf54PBnQNCW1UETg==
X-Proofpoint-ORIG-GUID: RcvRFD-SRiqrMQ7E61-nBiF0D4qDfgtS
X-Proofpoint-GUID: RcvRFD-SRiqrMQ7E61-nBiF0D4qDfgtS
X-Authority-Analysis: v=2.4 cv=M7hA6iws c=1 sm=1 tr=0 ts=69941538 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=n5_htZFP4T_TsJTqqv8A:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-17_01,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 impostorscore=0 suspectscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602170058
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

On 26/01/19 01:21PM, Hari Bathini wrote:
> 
> 
> <...snip...>
> 
> > +    /* Add kernel and initrd as fw-load-area */
> > +    uint64_t fw_load_area[4] = {
> > +        cpu_to_be64(KERNEL_LOAD_ADDR), cpu_to_be64(KERNEL_MAX_SIZE),
> > +        cpu_to_be64(INITRD_LOAD_ADDR), cpu_to_be64(INITRD_MAX_SIZE)
> > +    };
> > +
> > +    _FDT((fdt_setprop(fdt, off, "fw-load-area",
> > +                    fw_load_area, sizeof(fw_load_area))));
> > +}
> > +
> 
> While the changelog only talks about dump node, fw-load-area is
> exported too. A comment explaining what and why it is used helps..

Sure hari, will add purpose of fw-load-area also in the description

Thanks,
- Aditya G

> 
> - Hari

