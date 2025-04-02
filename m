Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33714C36014
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 07:55:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzsvq-00071a-Pd; Wed, 02 Apr 2025 03:54:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shalini@linux.ibm.com>)
 id 1tzsvn-00070w-QO; Wed, 02 Apr 2025 03:54:40 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shalini@linux.ibm.com>)
 id 1tzsvm-0007Mu-5A; Wed, 02 Apr 2025 03:54:39 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 531NDIqC030375;
 Wed, 2 Apr 2025 07:54:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=cq56FM
 OkoUp8T1/QT/E966JS3cV/o+K010RawVRpImA=; b=nXi3G1CYmGA37S0MZQEw3o
 jzSJvlRud1mOP+lewD8JkUcSzlNkKp1azAtmXQ8DR/FT1vVbwLiZqZnorpTOihuW
 W+aQwY5jzGYgWz/YI8XK3ECl4vHoVm+1HBxqOGY/zJMKvG9QofMzA9BnndHnaE5/
 RCBQTdps4FjdY6wGSgdJygdMmr26bhviE/rbzc9tD0AuDshyNt2K29aLSVsL8Myk
 zkzhG89I4vlWLWH9otSH1tcsnhZMu8t/SIy2coHMz78fky8MIYt95p+RcUMnu22L
 X3eEyWv5TOKEhppLnjwJkNpj6Puh+5T9T+ZCtpoS2y1fnRmFmGKu1gOIlOkVh4SQ
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45rqc0jf4g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 02 Apr 2025 07:54:34 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53264ZN8005420;
 Wed, 2 Apr 2025 07:54:34 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 45pww2efdr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 02 Apr 2025 07:54:34 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5327sWYt20054766
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 2 Apr 2025 07:54:32 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5406C58056;
 Wed,  2 Apr 2025 07:54:32 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EC6C658052;
 Wed,  2 Apr 2025 07:54:31 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  2 Apr 2025 07:54:31 +0000 (GMT)
MIME-Version: 1.0
Date: Wed, 02 Apr 2025 09:54:31 +0200
From: Shalini Chellathurai Saroja <shalini@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-s390x mailing list <qemu-s390x@nongnu.org>, Daniel Berrange
 <berrange@redhat.com>, qemu-devel mailing list <qemu-devel@nongnu.org>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>, Hendrik Brueckner
 <brueckner@linux.ibm.com>
Subject: Re: [PATCH v3 1/4] hw/s390x: add SCLP event type CPI
In-Reply-To: <57012b33-9b28-4324-bd91-75866c55b3f5@redhat.com>
References: <20250331140041.3133621-1-shalini@linux.ibm.com>
 <20250331140041.3133621-2-shalini@linux.ibm.com>
 <57012b33-9b28-4324-bd91-75866c55b3f5@redhat.com>
Message-ID: <19c2da854c1ea613190908c8f0602338@linux.ibm.com>
X-Sender: shalini@linux.ibm.com
Organization: IBM Deutschland Research & Development GmbH
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: k6Ym2FjhMx-2z0ux2oOXQ-3exFdNUxia
X-Proofpoint-GUID: k6Ym2FjhMx-2z0ux2oOXQ-3exFdNUxia
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-02_02,2025-04-01_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0
 impostorscore=0 mlxscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 spamscore=0 clxscore=1015 mlxlogscore=999 phishscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504020046
Received-SPF: pass client-ip=148.163.158.5; envelope-from=shalini@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 2025-04-02 07:48, Thomas Huth wrote:
> On 31/03/2025 16.00, Shalini Chellathurai Saroja wrote:
>> Implement the Service-Call Logical Processor (SCLP) event
>> type Control-Program Identification (CPI) in QEMU. This
>> event is used to send CPI identifiers from the guest to the
>> host. The CPI identifiers are: system type, system name,
>> system level and sysplex name.
>> 
>> System type: operating system of the guest (e.g. "LINUX").
>> System name: user configurable name of the guest (e.g. "TESTVM").
>> System level: distribution and kernel version, if the system type is 
>> Linux
>> (e.g. 0x50e00).
>> Sysplex name: name of the cluster which the guest belongs to (if any)
>> (e.g. "PLEX").
>> 
>> Signed-off-by: Shalini Chellathurai Saroja <shalini@linux.ibm.com>
>> Reviewed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
>> ---
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>

Hello Thomas,

Thank you very much.

-- 
Mit freundlichen Grüßen / Kind regards
Shalini Chellathurai Saroja
Software Developer
Linux on IBM Z & KVM Development
IBM Deutschland Research & Development GmbH
Dept 1419, Schoenaicher Str. 220, 71032 Boeblingen
Vorsitzender des Aufsichtsrats: Wolfgang Wendt
Geschäftsführung: David Faller
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht 
Stuttgart, HRB 243294

