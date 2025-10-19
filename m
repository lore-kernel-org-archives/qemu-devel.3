Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9611BCCD184
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Oct 2025 19:32:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAZ7s-0006m5-2h; Sun, 19 Oct 2025 15:31:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vAZ7j-0006lp-7E; Sun, 19 Oct 2025 15:31:23 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vAZ7g-0007aJ-JU; Sun, 19 Oct 2025 15:31:21 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59JAjIwl010514;
 Sun, 19 Oct 2025 19:31:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=oimJAP
 nYK3z0pEN+RA+OOLksdTT+9UYisgZSr30W3Ns=; b=AlJCAPxctqUKejv0BEigq/
 9i788H3Kex2mpLYBY2r8A9AZ4j9lqbp+SITm8KMR+JpLP5YjgTDw/rSzIzilV+EC
 KDud3pjJTiTLKvDORCoedLwc8LQXrxBeK7dV2gC9OrH3gEEmxmxP6QpRQPuZ7W3R
 yIg1FEHVkJZuMpBBma/q2uwVck1hv8rtJBTF44gKqcIYVMVcZiGwGrlClJ0Qqyyd
 a7FgWBRFV6jO8g3yrx4FYBGztGn0FxdqiMF8IyoG2tisCjXKbAhaDrfWrfE6i0oE
 6XdvAGyxbIzP7+djdht9VkLmhY0qlZ3/mMqsyypDaPQXVcJ6bhceYX1lZp5lp13Q
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v326e6a3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 19 Oct 2025 19:31:18 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59JJVHaA006507;
 Sun, 19 Oct 2025 19:31:17 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v326e6a1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 19 Oct 2025 19:31:17 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59JEEncP024677;
 Sun, 19 Oct 2025 19:31:16 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49vpqjjj9u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 19 Oct 2025 19:31:16 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59JJVCgX30212534
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 19 Oct 2025 19:31:12 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AC30C2004B;
 Sun, 19 Oct 2025 19:31:12 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 84F9D20040;
 Sun, 19 Oct 2025 19:31:10 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.39.22.247]) by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Sun, 19 Oct 2025 19:31:10 +0000 (GMT)
Date: Mon, 20 Oct 2025 01:00:59 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>
Subject: Re: [PATCH v4 6/8] hw/ppc: Pass dump-sizes property for fadump in
 device tree
Message-ID: <wr5sfi6omicfuxnfua7pjkbm345niursrgrddfdkbzcexeqoap@xyqknkyfqmif>
References: <20250323174007.221116-1-adityag@linux.ibm.com>
 <20250323174007.221116-7-adityag@linux.ibm.com>
 <65b70282-c6ca-4140-92f6-d266082b6d49@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <65b70282-c6ca-4140-92f6-d266082b6d49@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=EJELElZC c=1 sm=1 tr=0 ts=68f53c86 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=wr0B0juNZGx8OR4fBVsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX0WprL0h9d718
 Qy2K5Dxx3hJcuKy04+4PvziUMeEdO6/bcuBFFeudPZapIJqEBQrR5CHE2SN6M1EChDlgCmm3nKB
 UsLtVYUnELYhlgVuIwvKPTBOPy4sJVIJg6fPgWM4BxFuk1aBJA0HSIgAciU72ZiSbVIkGgjFSCV
 UyNXUok/x06TukV1oWcMXmukZx12IXIrbS5sZ1LSuGPgS4ETs2JMPVhbe0mSuhRQxRadcE+RfCY
 hxanE/jWsJ1dEzxQ5f3X2hLc1c6IMRyhwDVJpQMegbYmFwCWtRRAn1J9yCgLW/tjGAPiCkVXj8k
 MeMfoiaoP86YqTeXmTzMVVIhSggii7+1gx6UNTiUqGzR+Y7UaEHBOKJ1qbBUjAx5k0DpvTRWG7r
 IzWdbZBcUjZwXg1QaHxEL8o+SEuPTg==
X-Proofpoint-GUID: 1Xq6fOdXndh75faNptmfWANnecDLzo_g
X-Proofpoint-ORIG-GUID: ttvDjrou8tefUVXUZuYQPUZBLQXnBKjk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-19_06,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 spamscore=0
 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On 25/10/18 04:50PM, Sourabh Jain wrote:
> 
> 
> > <...snip...>
> > +    uint32_t fadump_rgn_sizes[2][3] = {
> > +        {
> > +            cpu_to_be32(FADUMP_CPU_STATE_DATA),
> > +            0, 0 /* Calculated later */
> > +        },
> > +        {
> > +            cpu_to_be32(FADUMP_HPTE_REGION),
> > +            0, 0 /* HPTE region not implemented */
> > +        }
> 
> #nit-pick
> Why to advertise if we don't support it? Kernel anyways ignores this for
> now.

Nice catch.
PAPR doesn't seem to say about HPTE being optional anywhere, nor being
mandatory, so to be on safe side, exported it with 0 size until/if
it's implemented.

PAPR R1–7.3.30–7 says this (trimmed, emphasis mine):

	The platform 'must' present the RTAS property,
	“ibm,configure-kernel-dump-sizes” in the OF device tree, which
	describes space required for 'firmware defined dump sections', where
	the 'firmware defined dump sections' are:
		0x0001 = CPU State Data
		0x0002 = Hardware Page Table for Real Mode Region

Thanks,
- Aditya G


