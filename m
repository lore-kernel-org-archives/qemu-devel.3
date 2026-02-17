Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C044E63F2B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Feb 2026 07:10:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsFDe-00052t-UD; Tue, 17 Feb 2026 02:10:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vsFDd-000524-El; Tue, 17 Feb 2026 02:10:01 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vsFDb-0003QK-Tc; Tue, 17 Feb 2026 02:10:01 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61GFx8sE1915831; Tue, 17 Feb 2026 07:09:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=nxPGF3bHEjINJKr2VvHy+C+xUgOxXY
 cvrw38vtH0/OU=; b=XgRkOcYXZ/2lX/AHhBm5Y0iQp3hNrIn8L8aTB+ElWlHFNf
 7UoXEhKsVMXJm42TxLCREaVD2W0CsbeSboiWT69EC4vrRC16hnRSklzD+3a1Bvpm
 Avn67Y0Krpv7p9334VEblWAwangJjoGxObD9z+0SfmlTe3PHbwdwIgeFRufQ0lUQ
 qoDLiLEbzVcSII1JVToa42hk1E0QiKxoHWfONoNi+CEDZUVgWxgiPwjxJnab/e24
 Ez38pAoRNHBGAz0qsC0RKhaa53B36lLrwYYnWRrL9VDZ3T8xbtnNkceXNcZU1yae
 CQ8xvkCDmfIlbCXKBMiEN/APboydxIFTtvIwDBgg==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4caj6ujus0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 17 Feb 2026 07:09:57 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61H3AHvZ023889;
 Tue, 17 Feb 2026 07:09:56 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ccb451f4r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 17 Feb 2026 07:09:56 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 61H79rPQ55443776
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 17 Feb 2026 07:09:53 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0A38020043;
 Tue, 17 Feb 2026 07:09:53 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 91EFB20040;
 Tue, 17 Feb 2026 07:09:51 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.109.199.210])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Tue, 17 Feb 2026 07:09:51 +0000 (GMT)
Date: Tue, 17 Feb 2026 12:39:49 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: Hari Bathini <hbathini@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: Re: [PATCH v2 4/9] pnv/mpipl: Preserve memory regions as per
 MDST/MDDT tables
Message-ID: <aZQIZyGyV_rXeSxb@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
References: <20251206055648.1908734-1-adityag@linux.ibm.com>
 <20251206055648.1908734-5-adityag@linux.ibm.com>
 <eb079c05-2ff9-4dde-a82d-31d3f37951d8@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb079c05-2ff9-4dde-a82d-31d3f37951d8@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=E+/AZKdl c=1 sm=1 tr=0 ts=69941445 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=jf3XgTADd5hNh77I6RYA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDA1OCBTYWx0ZWRfXwnp7hBz8QBUq
 wpnbDwr11yfNiwzORe1jvZ2s1TKGuVVO1gP2qNls9hHL6kqQXQFICxlv8TY24lKC0RDo2EvhtUD
 4BbtwhDBO5MDzLrLNghA2S9Fgd/z/rGyjA9lAXj2VfAi3SpOkQ7l4ikgW5bcGqzcTzqJ4QWq4cd
 Ksy12rA95/Akk5ocdxV0p4zqio0+PpR7CaZRM5qDi/RIHQfEGcygxWLRMuGeq2jQFtuGblhARLp
 acXIzHqAR36Rn8WsHZ1420G6jJexVXpyMKvLyCn8j+OuRonRPqNBSw3f9Nzbk8nuodWWeVl6J9m
 MRKyiO+qcpZA6yiGQTeHF/5bUcaaKdnbL/7NuTkL2HBHcrNpAOysjbDU+6reaH/9suX2q4tZepw
 H8Cwhqr1UL4QG54ZfW1YiEWqZGJNjHwxKB1U7cnjDJG2NJB8n2K9LdURX3zEdVCL8y/CWxfg2Kr
 O9GipPN9w9Yp4cpc7Dw==
X-Proofpoint-ORIG-GUID: xIWu87mPS8cwmmgmcpU6NKhgxy6LOIth
X-Proofpoint-GUID: xIWu87mPS8cwmmgmcpU6NKhgxy6LOIth
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-17_01,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 phishscore=0 bulkscore=0
 suspectscore=0 spamscore=0 clxscore=1015 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602170058
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

On 26/01/19 01:15PM, Hari Bathini wrote:
> 
> 
> On 06/12/25 11:26 am, Aditya Gupta wrote:
> > <...snip...>
> >
> > Though HDAT section "15.3.1.3 Memory Dump Results Table (MDRT)" says:
> >      The Memory Dump Results Table is a list of the memory ranges that
> >      have been included in the dump
> > 
> > Based on above statement, it looks like MDRT should include only those
> > regions which are successfully captured in the dump, hence, regions
> > which qemu fails to dump, just get skipped, and will not have a
> > corresponding entry in MDRT
> 
> Yeah. No error status is looked for by kernel. It tries to export
> /proc/vmcore with how much ever firmware succeeds in preserving..

Thanks for confirming. We are handling it correct way in qemu then.

> 
> > <...snip...>
> >
> > +        src_addr  = be64_to_cpu(mdst[i].addr) & ~HRMOR_BIT;
> > +        dest_addr = be64_to_cpu(mddt[i].addr) & ~HRMOR_BIT;
> 
> > +        src_len   = be32_to_cpu(mddt[i].size);
> 
> data_len sounds more appropriate instead of src_len here, especially
> as we are using mddt length..

Makes sense, Will do it.

Thanks,
- Aditya G

> 
> - Hari

