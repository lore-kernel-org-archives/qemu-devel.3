Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C0BDC369C2
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 06:59:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBpme-0003lJ-J0; Mon, 05 May 2025 02:58:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shalini@linux.ibm.com>)
 id 1uBpma-0003kS-Mc; Mon, 05 May 2025 02:58:33 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shalini@linux.ibm.com>)
 id 1uBpmW-0000YL-Sd; Mon, 05 May 2025 02:58:30 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 544CU5gr025949;
 Mon, 5 May 2025 06:58:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=xgEjAi
 fhINb60Y3VmturNxjZqvUuGNhkblarMzhkwu4=; b=V/HQtKgNNsVo7gNyfYp2g/
 cs3TA40Cau7YLHYI9KJjhDwyvXBlRbPzeP5yS7B13r2mT24R5q7utNrO/7qSa/rT
 YiOnbKu40On/HNHEhgWmVsvqQEerRg4q73vIckPmzrIVlDoE/HXgG9e0hCggKFGr
 hYhDFd3ny3eYwp1Z8r3zmhKxV+dOAT7R6zj7UW5jqHFGokbNuUhLtcYnLktRqdq9
 wiAEy4Jl35gMgVR2DdLd5ZptAjhKYxsTwH1l/BRyCQVLiTvr/i79IvLcW9gdALGD
 yfvWosaLKBVs1+QzX/alvQ/z3OS1nMV/eD6cAL0anJDkqRtFXDK23FZfUa/XXVMQ
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46e6pravqb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 05 May 2025 06:58:27 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5455LA72013830;
 Mon, 5 May 2025 06:58:26 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 46e0624p4e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 05 May 2025 06:58:26 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5456wPx431195678
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 5 May 2025 06:58:25 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 00C5058054;
 Mon,  5 May 2025 06:58:25 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5C99158052;
 Mon,  5 May 2025 06:58:24 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  5 May 2025 06:58:24 +0000 (GMT)
MIME-Version: 1.0
Date: Mon, 05 May 2025 08:58:24 +0200
From: Shalini Chellathurai Saroja <shalini@linux.ibm.com>
To: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Cc: qemu-s390x mailing list <qemu-s390x@nongnu.org>, Thomas Huth
 <thuth@redhat.com>, Daniel Berrange <berrange@redhat.com>, qemu-devel
 mailing list <qemu-devel@nongnu.org>, Hendrik Brueckner
 <brueckner@linux.ibm.com>, "<Shalini Chellathurai Saroja"
 <shalini@linux.ibm.com>
Subject: Re: [PATCH v4 1/4] hw/s390x: add SCLP event type CPI
In-Reply-To: <fd8ffc6bf1ba66c0479f6b02bbc747d392d34f1c.camel@linux.ibm.com>
References: <20250410150934.1331433-1-shalini@linux.ibm.com>
 <20250410150934.1331433-2-shalini@linux.ibm.com>
 <fd8ffc6bf1ba66c0479f6b02bbc747d392d34f1c.camel@linux.ibm.com>
Message-ID: <0b44c22b01e731f584ed278551842abb@linux.ibm.com>
X-Sender: shalini@linux.ibm.com
Organization: IBM Deutschland Research & Development GmbH
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Cu2/cm4D c=1 sm=1 tr=0 ts=68186193 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8
 a=Q5H0uIFeTx4jFr_PMnUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 5ZzpZpVAM9ZPo7wGf5pZuWnfg3k2YhKQ
X-Proofpoint-ORIG-GUID: 5ZzpZpVAM9ZPo7wGf5pZuWnfg3k2YhKQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA1MDA2MCBTYWx0ZWRfX1pI7THQVE3hZ
 Dr963Ukt6RjBnVjNLDFLsKhlDUHiF/QAtl9bUj2C9D3leiBPPPNBPnRO4sATjk0B7iktdail2Kw
 gIru0gdEvOPG+tTUxahs9jR32xcgDXzoczBsnxGIliOYwc5R7L3s5lG/VG/L8pAzpZdtj+fVkns
 qnkA4/WXN5rbVW76bpLaAuP50yFQdRt09jepj9+ZPels4h+0rUJL2n+PX/sUB1rjnftizsBYoZW
 cz6YQ1CJVGdHB5dDQ1oPmXn5V1QRFLrOqJYnO5XZyLHl+VDecP/jETfa/GJbB/r1tTFYA9GZF2O
 NSjT4Ok7MFjhcHXiVKjjw30Xp3P19liqa3qDi76uzH/K9Xi5s0Fw0Nb98/DfeLegtnP9y/PyxtX
 QYb0o/trdcx0T9CZDxVSpo/KLaCfDMTTQBRzKErzU43QqBjKWqIOT1ITCsyXFciMubl8940I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-05_03,2025-04-30_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxscore=0
 spamscore=0 mlxlogscore=999 malwarescore=0 phishscore=0 adultscore=0
 impostorscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505050060
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

On 2025-04-29 11:20, Nina Schoetterl-Glausch wrote:
> On Thu, 2025-04-10 at 17:09 +0200, Shalini Chellathurai Saroja wrote:
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
>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  hw/s390x/event-facility.c         |  2 +
>>  hw/s390x/meson.build              |  1 +
>>  hw/s390x/s390-virtio-ccw.c        | 14 +++++
>>  hw/s390x/sclpcpi.c                | 92 
>> +++++++++++++++++++++++++++++++
>>  include/hw/s390x/event-facility.h | 13 +++++
>>  5 files changed, 122 insertions(+)
>>  create mode 100644 hw/s390x/sclpcpi.c
> 
> [...]
> 
> 
>>  static void s390_cpu_plug(HotplugHandler *hotplug_dev,
>> diff --git a/hw/s390x/sclpcpi.c b/hw/s390x/sclpcpi.c
>> new file mode 100644
>> index 0000000000..13589459b1
>> --- /dev/null
>> +++ b/hw/s390x/sclpcpi.c
> 
> [...]
> 
>> +static void cpi_class_init(ObjectClass *klass, void *data)
> 
> Should be 'const void *data'.
> 

Ok, thank you.

>> +{
>> +    DeviceClass *dc = DEVICE_CLASS(klass);
>> +    SCLPEventClass *k = SCLP_EVENT_CLASS(klass);
>> +
>> +    dc->user_creatable = false;
>> +
>> +    k->can_handle_event = can_handle_event;
>> +    k->get_send_mask = send_mask;
>> +    k->get_receive_mask = receive_mask;
>> +    k->write_event_data = write_event_data;
>> +}
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

