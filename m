Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D1CBC369C2
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 07:28:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBqEw-0005bN-JB; Mon, 05 May 2025 03:27:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shalini@linux.ibm.com>)
 id 1uBqEr-0005aU-Ns; Mon, 05 May 2025 03:27:46 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shalini@linux.ibm.com>)
 id 1uBqEo-0004ao-FU; Mon, 05 May 2025 03:27:45 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 544LhvhB009514;
 Mon, 5 May 2025 07:27:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=2clPdw
 vo1odkyz+NTTJUDE/oX67guVodFvyeYhwGur0=; b=raboaS21GbPe278L5cURxZ
 gkCoDY0SOLkehSRai+I5bahFeeYAKPnuYOfrqwyCI4DN/2gCgOOC4FWWSiqgESp/
 Fb1qJSDivymUMAyZPl+YXscLi0UjhETml/UNVsH4UZhXzlRLBue3avAFvulW3XvQ
 gped/OP8J3lMoR88pCGTSrJfZ2dNYUN01OpJG5Jqm3Xd4DZ6ZS4kEEQBzVS4G4l/
 TJ+hy781lqUFDmSnqmbsgcj+V//m0Vh4raYl8IPQXLOmHgZQETZMDRT4zEArpQJe
 Z5FlqGtJVD9o+2ZjpHwTybtRbY7o/lgpz07Glr5NAXSF70jCqgLdeF4RUG0S//LA
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46egcv1kqq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 05 May 2025 07:27:25 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 545723Pt001313;
 Mon, 5 May 2025 07:27:24 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 46dwft5bjd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 05 May 2025 07:27:24 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5457RMXh27918920
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 5 May 2025 07:27:22 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3DF3A5805A;
 Mon,  5 May 2025 07:27:22 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D4EDC58062;
 Mon,  5 May 2025 07:27:21 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  5 May 2025 07:27:21 +0000 (GMT)
MIME-Version: 1.0
Date: Mon, 05 May 2025 09:27:21 +0200
From: Shalini Chellathurai Saroja <shalini@linux.ibm.com>
To: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Cc: qemu-s390x mailing list <qemu-s390x@nongnu.org>, Thomas Huth
 <thuth@redhat.com>, Daniel Berrange <berrange@redhat.com>, qemu-devel
 mailing list <qemu-devel@nongnu.org>, Hendrik Brueckner
 <brueckner@linux.ibm.com>, "<Shalini Chellathurai Saroja"
 <shalini@linux.ibm.com>
Subject: Re: [PATCH v4 2/4] hw/s390x: add Control-Program Identification to QOM
In-Reply-To: <af38cbebea53bea3e06537ec69c25a2a3d36577c.camel@linux.ibm.com>
References: <20250410150934.1331433-1-shalini@linux.ibm.com>
 <20250410150934.1331433-3-shalini@linux.ibm.com>
 <af38cbebea53bea3e06537ec69c25a2a3d36577c.camel@linux.ibm.com>
Message-ID: <86795ad321003348e05852f470f4df57@linux.ibm.com>
X-Sender: shalini@linux.ibm.com
Organization: IBM Deutschland Research & Development GmbH
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 5lJHd1Vnw5ZRwbWQs7_Ngwvd0uLzom50
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA1MDA2NSBTYWx0ZWRfX89lpdCdYwam2
 ycFPMaqCEYF11jDMSgnygzyfn+6N8XSYlCjVy3IZhK18Y3j9q43wgpjOkAZrnGDyEauB52pdVXp
 Hm2vsqNV0oXoxHXQ68m7+3cGiD4N38E7ghPHIQms5hWbgtTHRHExelpZb+5QtAbBj+2AhU4MpTH
 FAJIORxQbjZjFzXhLWxKoFtEXJqPmq4LQkkyJEHE3yQAJJsnXA/DX8wLoFWJW8B5dI0/7g4HuOl
 YmXk19F5I/cr3Fk6cMm5v4LLHrgRA18WwGZNte2oXqu2xWCidYUmv93Uqd2lPvAFniF86RNAVjO
 YOilkaJWLFLAsQPIXy0ku8+e6DiuSy2Apmcna2SaB03W8k8DiC+aJdjehinlxSiooMtCsUrwmdt
 Roo8MXEqkPN/R5LakCH2OnnrmpsMFIpU7x84ih+6j7IbHuaqvTxxnuCKaLxtEDkWPgOtK1Yl
X-Authority-Analysis: v=2.4 cv=O7k5vA9W c=1 sm=1 tr=0 ts=6818685d cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=g2SceEVK1yM_osEzJNkA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 5lJHd1Vnw5ZRwbWQs7_Ngwvd0uLzom50
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-05_03,2025-04-30_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxlogscore=999
 malwarescore=0 spamscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 mlxscore=0
 adultscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505050065
Received-SPF: pass client-ip=148.163.158.5; envelope-from=shalini@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

On 2025-04-28 14:01, Nina Schoetterl-Glausch wrote:
> On Thu, 2025-04-10 at 17:09 +0200, Shalini Chellathurai Saroja wrote:
>> Add Control-Program Identification data to the QEMU Object
>> Model (QOM), along with the timestamp in which the data was received.
>> 
>> Example:
>> virsh # qemu-monitor-command vm --pretty '{
>> "execute": "qom-get",
>> "arguments": {
>> "path": "/machine/sclp/s390-sclp-event-facility/sclpcpi",
>> "property": "control-program-id" }}'
>> {
>>   "return": {
>>     "timestamp": 1742390410685762000,
>>     "system-level": 74872343805430528,
>>     "sysplex-name": "PLEX ",
>>     "system-name": "TESTVM  ",
>>     "system-type": "LINUX   "
>>   },
>>   "id": "libvirt-15"
>> }
>> 
>> Signed-off-by: Shalini Chellathurai Saroja <shalini@linux.ibm.com>
>> ---
>>  hw/s390x/sclpcpi.c                | 39 +++++++++++++++++++++
>>  include/hw/s390x/event-facility.h |  9 +++++
>>  qapi/machine.json                 | 58 
>> +++++++++++++++++++++++++++++++
>>  3 files changed, 106 insertions(+)
> 
> [...]
> 
>> --- a/include/hw/s390x/event-facility.h
>> +++ b/include/hw/s390x/event-facility.h
>> @@ -199,9 +199,18 @@ typedef struct SCLPEventCPI SCLPEventCPI;
>>  OBJECT_DECLARE_TYPE(SCLPEventCPI, SCLPEventCPIClass,
>>                      SCLP_EVENT_CPI)
>> 
>> +typedef struct ControlProgramId {
>> +    uint8_t system_type[8];
>> +    uint8_t system_name[8];
>> +    uint64_t system_level;
>> +    uint8_t sysplex_name[8];
>> +    uint64_t timestamp;
>> +} ControlProgramId;
>> +
>>  struct SCLPEventCPI {
>>      DeviceState qdev;
>>      SCLPEvent event;
>> +    ControlProgramId cpi;
> 
> Now that this struct exists I would go ahead and inline 
> ControlProgramId.

Ok, I will do so, thank you.
> 
>>  };
>> 
>>  #define TYPE_SCLP_EVENT_FACILITY "s390-sclp-event-facility"
> 
> [...]

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

