Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9AD9E77180
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2024 15:56:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKg6H-0001Oe-CC; Mon, 09 Dec 2024 10:55:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brueckner@linux.ibm.com>)
 id 1tKg6F-0001Md-KB; Mon, 09 Dec 2024 10:55:07 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brueckner@linux.ibm.com>)
 id 1tKg6C-00087Z-AB; Mon, 09 Dec 2024 10:55:07 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B96gvAo015339;
 Mon, 9 Dec 2024 15:55:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=iwSnt0R5prh8U2duUw6JRrnRRm2iqI
 kkLwJQlFvBd8A=; b=hluC1RKO16lEniyCp0NRkSwqSpNWanGWw6Mr6fVNpqVYMj
 7J6ea7AHMJXPSd6I1z6lge3M40q7bYufpjxIN7A/gazt5VEKfv8Kk8sKQZ9qdx6K
 ib8rpXti66Ek6Et8oe1rSCaoWxWts/LEP5bRLlzng4cNOAe3PTIeaqGj6xeZQWze
 ow7Hx5pNl2VNLAnGvTYaBcVt0PAOJBaqmXHJisMQu/W1HhEnrgccf8jYlG3KWslV
 pO7aPEIQD3svNIQoUkJyj2ao4EVwNECO5i2YSFYYSzDltrlMAPqNjB/c1T9rWb9V
 mezCNljxCIsezyH+WrPTYwyRjk1/cQwMtGNvnSCA==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43ce38j7km-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Dec 2024 15:55:01 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9ExY2F018602;
 Mon, 9 Dec 2024 15:55:00 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43d26k7885-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Dec 2024 15:55:00 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4B9Fsup757344450
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 9 Dec 2024 15:54:56 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B81BD2004D;
 Mon,  9 Dec 2024 15:54:56 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9FBD52004B;
 Mon,  9 Dec 2024 15:54:56 +0000 (GMT)
Received: from vela (unknown [9.171.25.246])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Mon,  9 Dec 2024 15:54:56 +0000 (GMT)
Received: from brueckner by vela with local (Exim 4.98)
 (envelope-from <brueckner@linux.ibm.com>) id 1tKg63-000000007IA-1mDN;
 Mon, 09 Dec 2024 16:54:55 +0100
Date: Mon, 9 Dec 2024 16:54:55 +0100
From: Hendrik Brueckner <brueckner@linux.ibm.com>
To: Janosch Frank <frankja@linux.ibm.com>
Cc: Hendrik Brueckner <brueckner@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org, thuth@redhat.com, nsg@linux.ibm.com,
 mimu@linux.ibm.com, borntraeger@linux.ibm.com
Subject: Re: [RFC PATCH v2 03/15] s390x/cpumodel: add msa12 changes
Message-ID: <Z1cSz8uBCZ6SDOrX@linux.ibm.com>
References: <20241206122751.189721-1-brueckner@linux.ibm.com>
 <20241206122751.189721-4-brueckner@linux.ibm.com>
 <93eff988-d6b9-4789-bf11-721c92401d6a@linux.ibm.com>
 <Z1cLpjc9r5oKSqFE@linux.ibm.com>
 <3601af1b-1324-4635-b64b-00f965551550@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3601af1b-1324-4635-b64b-00f965551550@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: fZ2qdN3K6GJ-jOv8DHuv1hRNPhk5drNo
X-Proofpoint-ORIG-GUID: fZ2qdN3K6GJ-jOv8DHuv1hRNPhk5drNo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 bulkscore=0 mlxscore=0 malwarescore=0 mlxlogscore=383
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412090121
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=brueckner@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Dec 09, 2024 at 04:45:25PM +0100, Janosch Frank wrote:
> On 12/9/24 4:24 PM, Hendrik Brueckner wrote:
> > On Mon, Dec 09, 2024 at 03:48:11PM +0100, Janosch Frank wrote:
> > > On 12/6/24 1:27 PM, Hendrik Brueckner wrote:
> > > > MSA12 changes the KIMD/KLMD instruction format for SHA3/SHAKE.
> > > > 
> > > > Signed-off-by: Hendrik Brueckner <brueckner@linux.ibm.com>
> > > > Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> > > 
> > > MSA6 is a prereq, no?
> > 
> > MSA6 is the prereq. However, there is no explicit feature definition
> > for the MSA_EXT_6 due to no STFLE and subfunctions only.  The only
> > way would be to pick one or more / all MSA6 subfunctions for which
> > there is a feature defined...
> 
> Which you did for MSA11, no?

The other way around.

Here: MSA_EXT_12 would check/have a dependency on all(?) subfuncs
introduced with MSA_EXT_6.

> 
> I'm not saying that subfunc handling is great :)

Let me have a look which functions come with MSA_6 related to KIMD/KLMD.

Would it be OK to have those checks as a separate patch so that cpu
model in general is not blocked?

