Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5218AC282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 08:05:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tq6Dt-0001Lz-Ql; Thu, 06 Mar 2025 03:04:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shalini@imap.linux.ibm.com>)
 id 1tq6Do-0001Ku-6L; Thu, 06 Mar 2025 03:04:48 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shalini@imap.linux.ibm.com>)
 id 1tq6Dl-0006zp-EN; Thu, 06 Mar 2025 03:04:46 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5263junW023608;
 Thu, 6 Mar 2025 08:04:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=k6jzW9
 DAg7U6KgAgzggz5AjsSmc0ZI9foav3W/QE1jE=; b=ViROI0oDaui/hBsRZmE5YH
 vdhtF3aiPcsvcARPIqSuTs3UYPfLZAA0iIcUT0IbJG3AaznydBwmfvdLHJPMCew4
 Ow1YPSRHS5bVCasCHykkw8csYqWd/ibqbiVCA91zSDrGMb5z60BNcB7yVOuM5wIL
 On0ifSA8V6hR5Bbei79WcH+9Vdw2KQ8vglcsq50tKkhKhObPh1LyaSRXHJvExtZS
 BlDqjlg7QpGaP0USSVR1pLwD6D3DO6X5a7MsZtCumBEd/MdBShAcQXxTQVi2W4vZ
 T05GhMDlT0iykrsOQ5mXfW/izicn1L+8Yf+5Cu4iIJfcmWcHMAksYksr7TxphS9Q
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45743912r8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 06 Mar 2025 08:04:39 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5265YUKJ013784;
 Thu, 6 Mar 2025 08:04:38 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 454e2kyfgr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 06 Mar 2025 08:04:38 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 52684bi658392976
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 6 Mar 2025 08:04:37 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3AB5158054;
 Thu,  6 Mar 2025 08:04:37 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A817558062;
 Thu,  6 Mar 2025 08:04:36 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  6 Mar 2025 08:04:36 +0000 (GMT)
MIME-Version: 1.0
Date: Thu, 06 Mar 2025 09:04:36 +0100
From: shalini <shalini@imap.linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Shalini Chellathurai Saroja <shalini@linux.ibm.com>, qemu-s390x mailing
 list <qemu-s390x@nongnu.org>, qemu-devel mailing list
 <qemu-devel@nongnu.org>, Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 Hendrik Brueckner <brueckner@linux.ibm.com>
Subject: Re: [PATCH qemu v2 2/3] hw/s390x: add SCLP event type CPI
In-Reply-To: <01508dbb-7ee5-4c5b-87c9-667bc296fdbf@redhat.com>
References: <20250224120449.1764114-1-shalini@linux.ibm.com>
 <20250224120449.1764114-2-shalini@linux.ibm.com>
 <01508dbb-7ee5-4c5b-87c9-667bc296fdbf@redhat.com>
Message-ID: <394b86bb529f03d6b6d076aa8fb7dfa8@imap.linux.ibm.com>
X-Sender: shalini@imap.linux.ibm.com
Organization: IBM Deutschland Research & Development GmbH
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: kW6geUBH1zRLLbdNMu3UDQgznm6F2uJh
X-Proofpoint-ORIG-GUID: kW6geUBH1zRLLbdNMu3UDQgznm6F2uJh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-06_03,2025-03-06_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 clxscore=1034 mlxscore=0
 malwarescore=0 adultscore=0 mlxlogscore=935 priorityscore=1501 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503060059
Received-SPF: none client-ip=148.163.156.1;
 envelope-from=shalini@imap.linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_ADSP_NXDOMAIN=0.9,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NO_DNS_FOR_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=no autolearn_force=no
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

On 2025-03-05 19:04, Thomas Huth wrote:
> On 24/02/2025 13.04, Shalini Chellathurai Saroja wrote:
>> Implement the SCLP event type Control-Program Identification
>> (CPI) in QEMU. This event is used to send CPI identifiers,
>> which provide information about the guest OS to the host.
>> 
>> Save the information obtained from the SCLP CPI event to the
>> QOM along with the timestamp in which the data was received.
>> 
>> Example:
>> virsh # qemu-monitor-command vm --pretty '{
>> "execute":"qom-get","arguments": {
>> "path": "/machine", "property": "s390-control-program_id"}}'
> 
> I guess it should be a "-" instead of a "_" between "program" and "id"?

Hello Thomas,

Thank you very much for the review. Yes, that is correct. I will change 
it.

[...]

>> diff --git a/hw/s390x/sclpcpi.c b/hw/s390x/sclpcpi.c
>> new file mode 100644
>> index 0000000000..f2830d2d57
>> --- /dev/null
>> +++ b/hw/s390x/sclpcpi.c
>> @@ -0,0 +1,105 @@
>> +/*
> 
> scripts/checkpatch.pl recently learnt a new check to mandate SPDX
> license tags now for new files ... so please add one here now!
> 

ok.

[...]

>> +static int write_event_data(SCLPEvent *event, EventBufferHeader 
>> *evt_buf_hdr)
>> +{
>> +    ControlProgramIdMsg *cpi = container_of(evt_buf_hdr, 
>> ControlProgramIdMsg,
>> +                                            ebh);
>> +    S390CcwMachineState *ms = S390_CCW_MACHINE(qdev_get_machine());
>> +
>> +    ascii_put(ms->cpi.system_type, (char *)cpi->data.system_type, 8);
>> +    ascii_put(ms->cpi.system_name, (char *)cpi->data.system_name, 8);
>> +    ascii_put(ms->cpi.sysplex_name, (char *)cpi->data.sysplex_name, 
>> 8);
>> +    ms->cpi.system_level = be64_to_cpu(cpi->data.system_level);
> 
> Can we be confident that system_level is always properly aligned?
> Otherwise it's maybe better to use ldq_be_p() instead?

ok, I will use ldq_be_p() instead.

> 
>  Thomas

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

