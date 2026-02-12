Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8437EE369C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 15:46:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqYtD-0007X9-Qk; Thu, 12 Feb 2026 10:45:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akrowiak@linux.ibm.com>)
 id 1vqYt9-0007WK-VC
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 10:45:58 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akrowiak@linux.ibm.com>)
 id 1vqYt7-00057X-1X
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 10:45:55 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61C5dgD2476050
 for <qemu-devel@nongnu.org>; Thu, 12 Feb 2026 15:45:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pp1; bh=c54bL/Y6F/lAW6Oz7yH5IMQM7Dao
 +25Vbt8TJV4WcUg=; b=Tn9FFNn4rnUfuCUGfhshGoG+rz0hqJwY6UiY1eao/aTD
 R8ykgZBM9mBopNmzgekfAwwDlc/UkWTydcNbdijb4so6c4PBZX/Ic+r+1+EQdvKP
 +Noy4PsWVsxJhSq4tJd+xpRCC9yAayofQa09OFRitwLu1vwOy8QogdlJ0S+beIOW
 WakwGluFMwSPoimQ1rbw6mYtzOJOokeBCHc5eaP9/Jxoc1T3kJ/1m3kzXsd7Uc6n
 wg6f+9MyjisldWCtHUWVavuQeG7VNLVnmVPSnpK3tibUWFiziNQ5pNmwhAgGIwhV
 r2qWdlmYJI357eSXlFsv5wxvbjQpuhsAu7BPLZhldw==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c696vc341-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 12 Feb 2026 15:45:49 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61CCADBi002635
 for <qemu-devel@nongnu.org>; Thu, 12 Feb 2026 15:45:48 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4c6fqsu94y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 12 Feb 2026 15:45:48 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 61CFjlod21168682
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <qemu-devel@nongnu.org>; Thu, 12 Feb 2026 15:45:48 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D290758053
 for <qemu-devel@nongnu.org>; Thu, 12 Feb 2026 15:45:47 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 869D358043
 for <qemu-devel@nongnu.org>; Thu, 12 Feb 2026 15:45:47 +0000 (GMT)
Received: from [9.61.87.55] (unknown [9.61.87.55])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP
 for <qemu-devel@nongnu.org>; Thu, 12 Feb 2026 15:45:47 +0000 (GMT)
Message-ID: <72283828-6d7e-4c80-ba24-8c114c8d052d@linux.ibm.com>
Date: Thu, 12 Feb 2026 10:45:47 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: qemu-devel@nongnu.org
From: Anthony Krowiak <akrowiak@linux.ibm.com>
Subject: [RFC] hw/vfio: What is the best way to detect start of vfio device
 migration
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: AYIfoQ3EdPAGP4WZpeIJI9EcbrzumoZQ
X-Proofpoint-ORIG-GUID: AYIfoQ3EdPAGP4WZpeIJI9EcbrzumoZQ
X-Authority-Analysis: v=2.4 cv=JdWxbEKV c=1 sm=1 tr=0 ts=698df5ad cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=n4C5IOH4TsmGSRh6:21 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=0tGoRNrPEzy2CWAMWdsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEyMDExNyBTYWx0ZWRfXyx3eizm8qZmq
 H3IMdx55dgxbFS0yMmnueTscWabh8D5EdUwiW4Z3k68ugUZRJ+W+RWQxpvPb80LqFicS9txtp3t
 DVkcWfjAGUGCp0jkC22qkOe5qrnicgmZ7yCEsD8TPeqKNZbDQQ1GkXpcatsdWg5rInoXPdLUJtY
 0PXxMuOKzbO8wbozrE45kylhFyZrpSmjJ2XWQlGH8v5PvIYjWHHxPxPQmeC+DlWIhb09+CHuIu2
 WE1KzML50aX4y1ziKaMb1L30MYIa2P9iJ0duma8XEfv/jRCwXK/Y3Ec5w1N8Ccv+grSn668Cv2L
 Nbq7WFr1CysXykYOL/EFRgV9X7AJaR2vzaG0vql3g/WyOEkTXGgRswLVlWl7Nu9IITUIbobLeds
 xbHcuiqP9mbdIqxGVnQIlLoP6TKaP4UCEgUdG/7d8mdibRRURhG9C/jKZaf5GIFC+yWm1LvwlSl
 6Cix00bPFeJ3hIbAK0w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-12_04,2026-02-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1011 impostorscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602120117
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=akrowiak@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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

I created a sysfs attribute for a mediated device to enable/block migration
of the associated VFIODevice in QEMU. When the sysfs attribute is changed,
an eventfd is signaled to QEMU to enable or block migration. In response,
QEMU adds a migration blocker to the VFIODevice object and sets it's
'enable_migration' field to 'ON_OFF_AUTO_OFF'.

I do not want to send the signal to block migration if a migration of the
VFIODevice is already in progress, so I need to detect when migration is
initiated/completed in QEMU and notify the VFIO device driver so it
can respond to a request to block migration via the sysfs attribute with
an -EBUSY error while migration is in progress.

The only way I've been able to find to do this is via callbacks to the 
VFIO device
driver in response to the 'VFIO_DEVICE_FEATURE_MIG_DATA_SIZE' and
'VFIO_DEVICE_FEATURE_MIG_DEVICE_STATE' ioctl calls. In the former case, a
flag is set via the driver to indicate that migration is in progress. 
This flag is
checked when a user attempts to block migration via the sysfs attribute and
is prevented from doing so by returning -EBUSY from the attribute's store
function. In the latter case, the flag is cleared when the VFIO device 
migration
state transitions from 'VFIO_DEVICE_STATE_STOP_COPY' to
'VFIO_DEVICE_STATE_STOP'.

This works for the most part, but it's not foolproof because the eventfd 
can
still be signaled after migration is started but before the saving phase of
of VFIODevice migration is initiated. It would be great if the VFIO device
could be notified by QEMU when migration is initiated and when it ends.
Is there any way in the QEMU code that manages my VFIODevice to get
notified that a migration has been initiated/ended? I tried registering a
migration notifier, but the only notification I got was
'MIG_EVENT_PRECOPY_DONE' which wasn't helpful. I also tried setting
a 'pre_save_errp' callback in the VMStateDescription for the VFIODevice,
but that also got called too late in the migration process.

So, the main question is, does QEMU provide a means for getting notified
earlier in the migration process or even when it is initiated? Thanks 
for any
suggestions you can provide.

