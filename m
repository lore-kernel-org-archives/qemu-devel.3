Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 748BAC28B20
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Mar 2025 09:04:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ty5d4-00042k-8p; Fri, 28 Mar 2025 05:03:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1ty5d2-00042O-Su; Fri, 28 Mar 2025 05:03:52 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1ty5d1-0005sR-1n; Fri, 28 Mar 2025 05:03:52 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52S8p8tr020645;
 Fri, 28 Mar 2025 09:03:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=Io8jgo
 MwQT9SvyDTwtdgcveVl5cwCsvWexAfrquTa5I=; b=O28XQxUXgaYiGgzHgr5akZ
 j3f4Se+MyMr8mxmJfMMmo/8i9nSsKJgMc60edEIl3cuTu0gg7oC2ZHIS7AaQmt+P
 RaTJEgCTnh8l7bV8O1XVpV7nxZxqwtUrsWqSX7NlQY40ieOb4s+cdvGX9jMTEgiT
 PyFs+4JrZRFFIo6BrMNDJFptSZ5D2Gsa/F1Mk6r+kr3qUc1F7BANJBAsGiJkzWmM
 f3MmeEeQlqWNdivrsQ98BMnSuhLz++HkZwOacHlmFMhg3KuOugqDcikBI15ozY+4
 +q+LgpHcsnyUtTEWpgrYqgzD5tjiHLYM4YHgttX4etHT8uZS6T7CvMjDz8BtWs+g
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45ndw0ar3h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 28 Mar 2025 09:03:39 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52S8T1GV032508;
 Fri, 28 Mar 2025 09:03:39 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45ndw0ar3f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 28 Mar 2025 09:03:39 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52S8GTTV020105;
 Fri, 28 Mar 2025 09:03:38 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45j8hp9n1p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 28 Mar 2025 09:03:38 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 52S93YOp50397632
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 28 Mar 2025 09:03:34 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6E8322004B;
 Fri, 28 Mar 2025 09:03:34 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 202E620043;
 Fri, 28 Mar 2025 09:03:32 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.39.30.224]) by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Fri, 28 Mar 2025 09:03:31 +0000 (GMT)
Date: Fri, 28 Mar 2025 14:33:21 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?utf-8?B?RnLDqWTDqXJpYw==?= Barrat <fbarrat@linux.ibm.com>,
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Subject: Re: [PATCH v7 0/7] Power11 support for QEMU [PowerNV]
Message-ID: <zdmzqpdhc47w4cgfl2dpw5ef2ohjyxbk3bgg3z6didkwrpyzmz@rm3mliubqplk>
References: <20250327200738.1524401-1-adityag@linux.ibm.com>
 <c2f2fb9a-3cf9-4d5c-bf2a-01522b047759@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c2f2fb9a-3cf9-4d5c-bf2a-01522b047759@kaod.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ns8q1QZ-zoed1p3-knZuYmpGYsRYnGjs
X-Proofpoint-ORIG-GUID: Pu3DNL6qHlrzm0xqvD8dy0zgTRoSd1z8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-28_04,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 lowpriorityscore=0 impostorscore=0
 bulkscore=0 malwarescore=0 clxscore=1015 spamscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503280061
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 25/03/28 09:02AM, Cédric Le Goater wrote:
> On 3/27/25 21:07, Aditya Gupta wrote:
> > <...snip...>
> 
> In OPAL, the Power11 "CPU: PXYZ generation processor" string seems
> inconsistent with the previous generations :

Yes, that was intentional due to how we wanted to export it as "Power11"

Quoting mahesh's reply from skiboot list on 6th Feb 2025:
    > Power brand wants to export P11 as Power11. 'P' capital reset
    > lower

I have handled this difference in the functional test also, where it
will look for "CPU: P10" for powernv10, but "CPU: Power11" for powernv11

Thanks,
- Aditya G

> 
> [    0.033505806,6] CPU: P8 generation processor
> [    0.072640552,5] PLAT: Detected QEMU POWER8 platform
> [    0.035156993,6] CPU: P9 generation processor
> [    0.062078034,5] PLAT: Detected QEMU POWER9 platform
> [    0.026078226,6] CPU: P10 generation processor
> [    0.044514479,5] PLAT: Detected QEMU POWER10 platform
> [    0.022154632,6] CPU: Power11 generation processor
> [    0.038760508,5] PLAT: Detected QEMU Power11 platform
> 
> 
> Thanks,
> 
> C.
> 

