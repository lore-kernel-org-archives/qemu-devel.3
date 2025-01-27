Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09D0CC02188
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 20:45:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcVyz-0004AX-Gv; Mon, 27 Jan 2025 15:45:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1tcVyq-00049L-DF; Mon, 27 Jan 2025 15:45:12 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1tcVyo-00055r-EO; Mon, 27 Jan 2025 15:45:11 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50RFuu5G025735;
 Mon, 27 Jan 2025 20:45:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=x43rwo
 bwNOPxy97wBt+6gGsoY7Ai78kvK/QQ13Eprgk=; b=ODHKb/DFbpGFQDLiwIAQNL
 EQEOawDMWhq0HJhv42+rgPbq0IQsVUZ5JPWSBBwhi9wvVaPI/+wPm2+IbNyT86VP
 qlKduwqrdwlWqFqLubmspNwZe6jhLSP+5ih7M2Ouh7k9REjcIvSc0ya3z9jHcrFV
 tuQLzuKAJ67NDcTAZXnjrkp+7TaOxPx561aYKCVG/Zo6mdcy4jolo9TfqED6oBgR
 O1JJhLy05P/W55l3RLFZbQ1pDFa7dGV9XWAuu3MiTUSykl9fva/dhKm6B5gIFO9A
 YWvVA+Jq8dNUKMGfheDj/Oc9TFGYW+e3gwrM0Wmf1jAgZFa0Jji6PGWGY3OgxOsQ
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44e079d55c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 Jan 2025 20:45:04 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50RHLCQP022229;
 Mon, 27 Jan 2025 20:45:03 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 44dcgjfs1t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 Jan 2025 20:45:03 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 50RKj2pU22282864
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 27 Jan 2025 20:45:02 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1BC2858053;
 Mon, 27 Jan 2025 20:45:02 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CAD0558043;
 Mon, 27 Jan 2025 20:45:00 +0000 (GMT)
Received: from [9.61.39.122] (unknown [9.61.39.122])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 27 Jan 2025 20:45:00 +0000 (GMT)
Message-ID: <6881033c-efb8-4276-aae7-234e611d5fb9@linux.ibm.com>
Date: Mon, 27 Jan 2025 15:45:00 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] s390x/pci: add support for guests that request
 direct mapping
To: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org
Cc: farman@linux.ibm.com, schnelle@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, richard.henderson@linaro.org,
 david@redhat.com, iii@linux.ibm.com, clegoate@redhat.com,
 qemu-devel@nongnu.org
References: <20250124202115.349386-1-mjrosato@linux.ibm.com>
 <20250124202115.349386-2-mjrosato@linux.ibm.com>
 <209cba11-2fb3-404f-bbe4-e02b8e2595dd@redhat.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <209cba11-2fb3-404f-bbe4-e02b8e2595dd@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: -n50dnVlI8EnNHLXmvhY0L3jpar8LOLG
X-Proofpoint-GUID: -n50dnVlI8EnNHLXmvhY0L3jpar8LOLG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-27_10,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0
 clxscore=1015 malwarescore=0 suspectscore=0 bulkscore=0 priorityscore=1501
 mlxlogscore=682 mlxscore=0 phishscore=0 lowpriorityscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501270161
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


>>   #include "hw/s390x/s390-pci-bus.h"
>> @@ -1008,17 +1009,25 @@ static int reg_ioat(CPUS390XState *env, S390PCIBusDevice *pbdev, ZpciFib fib,
>>       }
>>         /* currently we only support designation type 1 with translation */
>> -    if (!(dt == ZPCI_IOTA_RTTO && t)) {
>> +    if (t && !(dt == ZPCI_IOTA_RTTO)) {
> 
> While you're at it, you could change that "!(dt == ZPCI_IOTA_RTTO)" into
> "dt != ZPCI_IOTA_RTTO".
> 

ACK

>>           error_report("unsupported ioat dt %d t %d", dt, t);
>>           s390_program_interrupt(env, PGM_OPERAND, ra);
>>           return -EINVAL;
>> +    } else if (!t && !pbdev->rtr_allowed) {
>> +        error_report("relaxed translation not allowed");
> 
> Not sure, but maybe better use qemu_log_mask(LOG_GUEST_ERROR, ...) instead?
> 

Hrm, this one I'm not so sure.  If I force this path and we give back the operand exception to the guest, the guest kernel is going to panic as a result.  We are very much in a "that wasn't ever supposed to happen" path, just like the unsupported dt above, because we already reported what we do (not) support via CLP.

I just tried to force the path with default settings + the above change, and I don't see anything in the qemu log from qemu_log_mask(LOG_GUEST_ERROR, ...) but I do with error_report.  Given the unlikely scenario that we reach this path and the potential ramifications, I think I'd rather leave it as error_report unless you've got a strong opinion on it!

Thanks,
Matt





