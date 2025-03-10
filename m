Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CF96C282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 14:21:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trdzO-0003dt-Ii; Mon, 10 Mar 2025 10:20:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rreyes@linux.ibm.com>)
 id 1trdzL-0003Zm-V1; Mon, 10 Mar 2025 10:20:15 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rreyes@linux.ibm.com>)
 id 1trdzJ-0007Lr-EO; Mon, 10 Mar 2025 10:20:15 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52AAliwp003753;
 Mon, 10 Mar 2025 14:20:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=CEBtf3
 m9bkwc7q5hrkiNNgi3yy6WiwL2n9L2Ei2AwPo=; b=dvsPNOgk5QGwtVmjajMFKq
 VG+qxNF6d/TcX1kzGc7BZ9JnfaKKHOuvZbBQRxG5uCN79+fXwzqVvvSq2wC/vtOt
 XM4h80RLeNMeaJiBENdQ20rULh7R8c6U2+IIXulmnaslNN6Sd5XMLx54lvsLsgi3
 HtzU8c6pOnRq6qtk1sRH8JhbFYqPxz0RlpDipR8Pk/wTRnL2LYYK/XBUj4uZLsD+
 ULWH1MxE0MarwPQ0vig8qUu0RKAYUUngDHi2uEOMvn/Cr6220IoE4rghDJ5rFvb+
 k0pNlNHZenogBmiiW+dCh3W/Rco08bcIOgp+RjjstRbhBISpMXhPCnXuta5mOk5w
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 459jd4usar-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 10 Mar 2025 14:20:08 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52ABABA8027494;
 Mon, 10 Mar 2025 14:20:08 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4591qkewjt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 10 Mar 2025 14:20:08 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 52AEK5aK20054730
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 10 Mar 2025 14:20:05 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D8F5758066;
 Mon, 10 Mar 2025 14:20:06 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C00E15804B;
 Mon, 10 Mar 2025 14:20:05 +0000 (GMT)
Received: from [9.61.250.189] (unknown [9.61.250.189])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 10 Mar 2025 14:20:05 +0000 (GMT)
Message-ID: <27ccfad0-99d1-47a5-8370-2b16ea924ac9@linux.ibm.com>
Date: Mon, 10 Mar 2025 10:20:05 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 1/5] linux-headers: NOTFORMERGE - placeholder uapi
 updates for AP config change
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org, 
 qemu-s390x@nongnu.org, Vasily Gorbik <gor@linux.ibm.com>
Cc: pbonzini@redhat.com, cohuck@redhat.com, pasic@linux.ibm.com,
 jjherne@linux.ibm.com, borntraeger@linux.ibm.com,
 alex.williamson@redhat.com, thuth@redhat.com, akrowiak@linux.ibm.com
References: <20250204170759.36540-1-rreyes@linux.ibm.com>
 <20250204170759.36540-2-rreyes@linux.ibm.com>
 <52dddefa-a9d6-41e7-ad23-a93f65896034@redhat.com>
Content-Language: en-US
From: Rorie Reyes <rreyes@linux.ibm.com>
In-Reply-To: <52dddefa-a9d6-41e7-ad23-a93f65896034@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: CfQTm1-JnsWA1hfSs3aLUwFQ53KIxOnd
X-Proofpoint-GUID: CfQTm1-JnsWA1hfSs3aLUwFQ53KIxOnd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-10_05,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0
 phishscore=0 mlxlogscore=999 impostorscore=0 priorityscore=1501 mlxscore=0
 suspectscore=0 malwarescore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503100110
Received-SPF: pass client-ip=148.163.158.5; envelope-from=rreyes@linux.ibm.com;
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

On 2/5/25 3:38 AM, Cédric Le Goater wrote:

>
> Are the kernel changes planned for 6.14 ?
>
> FYI, QEMU 10.0 hard freeze is scheduled for 2025-03-18 which is
> approximately when 6.14-rc7 will be released.
>
> Thanks,
>
> C. 

Vasily - Since you applied my kernel patches already ([RFC PATCH v2] 
s390/vfio-ap: Notify userspace that guest's AP config changed when mdev 
removed), would you be able to answer Cedric's

a question?

Cedric - I have some changes I need to make based on Tony's review 
comments from Friday, but I'll wait to post it once you get an answer 
for your question. Sorry I took a while to respond. I had to

make some changes for my kernel code this past month.


