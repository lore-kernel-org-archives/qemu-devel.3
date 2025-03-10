Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 128EBC282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 14:48:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trePh-0001dY-R4; Mon, 10 Mar 2025 10:47:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gor@linux.ibm.com>)
 id 1trePW-0001So-Sm; Mon, 10 Mar 2025 10:47:22 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gor@linux.ibm.com>)
 id 1trePU-00036C-M1; Mon, 10 Mar 2025 10:47:18 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52A9SeVp003899;
 Mon, 10 Mar 2025 14:47:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=5QAOVw
 dN1sf9L8Y7dBcicH9j/G0Zwnusg7zV7kpMM2s=; b=KJFPS1s9W1wIcuQ5l+tfK+
 icEYdsR4sd2ZqZrGfLQTLzvmsLnlD7mmHabDL970Rw3lOmGVuWoAFNNDjp6Ytkml
 w499M37Uyy9lOEqXn7ivrUtWRsqpmSAN3QHuOaav6YuF3RctYTMJNoqkJVyrH3BD
 T2R7iwW253PZDfl/hp9zd/vIATAvcD16V6UXYi32zB9owfp2G3avIu9ZHb5YH51l
 ASqYv01pmPYLb+umlu9dr3XHyBia9wrcsMtFmxGFvz7CmnFqbKb+J3eZadD9Zztq
 GeYwfbScaNi9BWXueeTk6WEOFWpCMxdqjU+RYTDikpAFT1qzIC90BJoLjQWAPvjg
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 459jd4ux9s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 10 Mar 2025 14:47:09 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52ADOmr6006935;
 Mon, 10 Mar 2025 14:47:09 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 45907sya2p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 10 Mar 2025 14:47:09 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 52AEl5da51904836
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 10 Mar 2025 14:47:05 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8493C20043;
 Mon, 10 Mar 2025 14:47:05 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CB52520040;
 Mon, 10 Mar 2025 14:47:04 +0000 (GMT)
Received: from localhost (unknown [9.179.22.167])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Mon, 10 Mar 2025 14:47:04 +0000 (GMT)
Date: Mon, 10 Mar 2025 15:47:03 +0100
From: Vasily Gorbik <gor@linux.ibm.com>
To: Rorie Reyes <rreyes@linux.ibm.com>
Cc: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>, qemu-devel@nongnu.org, 
 qemu-s390x@nongnu.org, pbonzini@redhat.com, cohuck@redhat.com,
 pasic@linux.ibm.com, jjherne@linux.ibm.com, borntraeger@linux.ibm.com,
 alex.williamson@redhat.com, thuth@redhat.com, akrowiak@linux.ibm.com
Subject: Re: [RFC PATCH v2 1/5] linux-headers: NOTFORMERGE - placeholder uapi
 updates for AP config change
Message-ID: <your-ad-here.call-01741618023-ext-3477@work.hours>
References: <20250204170759.36540-1-rreyes@linux.ibm.com>
 <20250204170759.36540-2-rreyes@linux.ibm.com>
 <52dddefa-a9d6-41e7-ad23-a93f65896034@redhat.com>
 <27ccfad0-99d1-47a5-8370-2b16ea924ac9@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <27ccfad0-99d1-47a5-8370-2b16ea924ac9@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: uwK5BrLEP3qUVLihpdqeA9O6cuhCKLcW
X-Proofpoint-GUID: uwK5BrLEP3qUVLihpdqeA9O6cuhCKLcW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-10_05,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0
 phishscore=0 mlxlogscore=881 impostorscore=0 priorityscore=1501 mlxscore=0
 suspectscore=0 malwarescore=0 clxscore=1011 bulkscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503100114
Received-SPF: pass client-ip=148.163.158.5; envelope-from=gor@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Mon, Mar 10, 2025 at 10:20:05AM -0400, Rorie Reyes wrote:
> On 2/5/25 3:38 AM, Cédric Le Goater wrote:
> 
> > 
> > Are the kernel changes planned for 6.14 ?
> >
> >
> > 
> > FYI, QEMU 10.0 hard freeze is scheduled for 2025-03-18 which is
> > approximately when 6.14-rc7 will be released.
> > 
> > Thanks,
> > 
> > C.
> 
> Vasily - Since you applied my kernel patches already ([RFC PATCH v2]
> s390/vfio-ap: Notify userspace that guest's AP config changed when mdev
> removed), would you be able to answer Cedric's

We are at v6.14-rc6. The changes are queued for the 6.15 merge window.

https://lore.kernel.org/r/20250107183645.90082-1-rreyes@linux.ibm.com
https://lore.kernel.org/r/20250304200812.54556-1-rreyes@linux.ibm.com

