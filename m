Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BC45CA1010
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 22:51:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utwJw-0005Dh-Hv; Wed, 03 Sep 2025 18:51:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1utwJt-0005DL-6l; Wed, 03 Sep 2025 18:51:13 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1utwJn-0002NW-In; Wed, 03 Sep 2025 18:51:12 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 583FNOB4001650;
 Wed, 3 Sep 2025 22:51:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=pF4YwbdRkV4wsvInXu9xqUejFz2OVIzHwHJB0eBn2X0=; b=cVIcg8hrlbl/
 gcSWsHijHjQmbnx2BI7RNWWAcyWnQLKarExBZxBS0IZUcSL8MXcG+EHm7XenPWcr
 ooq5hRJ5w1OcmuXFcugq2jIi2JOZmysngABSeOoeliB0VvCBFrI9IytNZZkG0k0c
 VHK3/HON0jM9/fy5JN4QebjDZurmV01rvNqhbvlMCIwSq0skFMKIvzxTNpFj0IPL
 Ogev3saGGwqNrED0A7HZ0HQ8IW3ezeU4fwW9cHT2wgTwqfaotlt7EGhrvr7tw/oI
 xuzv22HRiFJFLdIuRqF1R5Csm8VJzdJVE36CgJ9IGWD94cQ+l5NjWmzEmUcWanHp
 Etcr1mwLyQ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48usv373d8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 03 Sep 2025 22:51:02 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 583MoSma030747;
 Wed, 3 Sep 2025 22:51:02 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48usv373d7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 03 Sep 2025 22:51:02 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 583J7amq009000;
 Wed, 3 Sep 2025 22:51:01 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 48vdumhepg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 03 Sep 2025 22:51:01 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 583Mp07L18023092
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 3 Sep 2025 22:51:00 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DCDB45805A;
 Wed,  3 Sep 2025 22:50:59 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 844CE58054;
 Wed,  3 Sep 2025 22:50:59 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  3 Sep 2025 22:50:59 +0000 (GMT)
Message-ID: <e0cb3079e4f10f1f4ff45964c14c6a7eea17d9bf.camel@linux.ibm.com>
Subject: Re: [PATCH v2 3/4] hw/ppc: Add a test machine for the IBM PPE42 CPU
From: Miles Glenn <milesg@linux.ibm.com>
To: =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, npiggin@gmail.com, harshpb@linux.ibm.com,
 thuth@redhat.com, rathc@linux.ibm.com, richard.henderson@linaro.org
Date: Wed, 03 Sep 2025 17:50:59 -0500
In-Reply-To: <3defe91d2756da45060069efad4857c2e8ceec88.camel@linux.ibm.com>
References: <20250826201920.335308-1-milesg@linux.ibm.com>
 <20250826201920.335308-4-milesg@linux.ibm.com>
 <e867b3af-c2fc-4776-8c47-bff7114e29f8@redhat.com>
 <3defe91d2756da45060069efad4857c2e8ceec88.camel@linux.ibm.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: rXq-q4N1COcmS_roKn6BbrKej-DmxXTI
X-Authority-Analysis: v=2.4 cv=FPMbx/os c=1 sm=1 tr=0 ts=68b8c656 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=tXxU32m9-8aGLtKzEi8A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
X-Proofpoint-GUID: 69n0ZVR8FjIYXSFrRzQv4ePR10wXYVw8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzNCBTYWx0ZWRfX45vMAJaBhs0c
 2PzN4IeWvVOYM6zTMUs6szDkEDsehu5GmvdzNIGplDCA7T+wJQMH7fgeOH3sBKgtZaLsE00feXp
 9u96c4BkLcvPOAUPypq9bNzkMsKHTyuCG0BAW37Q4zfiUF3i26Bg0LnS3Y/MWsZrAZ2J3ve3AQD
 9gW6+vjtTOs5p7ChC7DuThu7AcHXqgFz5yeA4zFXVJsvEhfaWeA5RCcPqeYGohh97mN8vvTdy55
 qox8nCcmuxdh78HHOI0POQxymaGPdtz5pCZW0zJ+m/WBgJu0MO6UwGzG17sbgkUZzsjl8xKwMeD
 yWc0CQ5qQ9WDnCssHmuwUppJK58V8TolIvkRfN1c5Dt2TVxeut4Ur4jLQkNf4xR7fULJb0uQT7h
 UWBMsldw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_11,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 phishscore=0 clxscore=1015 bulkscore=0
 spamscore=0 adultscore=0 suspectscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300034
Received-SPF: pass client-ip=148.163.156.1; envelope-from=milesg@linux.ibm.com;
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: milesg@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, 2025-09-02 at 11:56 -0500, Miles Glenn wrote:
> > > +
> > > +static void main_cpu_reset(void *opaque)
> > > +{
> > > +    PowerPCCPU *cpu = opaque;
> > > +
> > > +    cpu_reset(CPU(cpu));
> > 
> > There are no register settings ? Just asking
> > 
> 
> Admittedly, I did not do much digging into the reset case.  I'll look
> into it.


Cédric,

As far as I can tell, it doesn't look like we need to add any other
registers here besides the cpu registers, which are already handled by
cpu_reset().  Also, I did verify that executing a system_reset from the
QEMU command line works as expected (resets to the correct vector and
executes successfully).

Thanks,

Glenn


