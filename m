Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A7BDC282DE
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 08:07:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tq6GU-00042S-I4; Thu, 06 Mar 2025 03:07:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shalini@imap.linux.ibm.com>)
 id 1tq6GL-00041H-5F; Thu, 06 Mar 2025 03:07:25 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shalini@imap.linux.ibm.com>)
 id 1tq6GH-0007bX-Et; Thu, 06 Mar 2025 03:07:23 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 525MbAbF032569;
 Thu, 6 Mar 2025 08:07:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=+17ers
 MgZrx8zmVN/HtHO8yi0iW7/kF/j6MqIk8+VHw=; b=T6jgcVKZfdLDFgnR8q9YBR
 pE1MO0HhZ3nEbCB3v00aN3YKA71UDu4cEs2lFHP5LzyiGnvExwJ1YzGvt/1TXlux
 yyvKdp5X8nfqzshLPS7tt/Nw5GSyXAFS3xq/8+iPEmgfL+TxHZLpDOke+hXSJNQU
 TDv4rzxZm2N7eyOWc0pOXR9DUdKTkd8WXy3CnNa8ejIXnO/F2xBzVmgwjAZa8zXK
 27s5+RWlOEGIRZWifpL8cXXeZOKZN9fYLzNNdL8SZijTCPrw2aPhCVz0KAaSwZY/
 WBpwbl2CNamCBGRpiZZ591EtSmoXDWgUov4DX2PW/Xevp0Tpt4sie53uWVOPjHnA
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 456r1pvkup-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 06 Mar 2025 08:07:19 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52652NUH020835;
 Thu, 6 Mar 2025 08:07:18 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 454djnqjqm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 06 Mar 2025 08:07:17 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 52687GgD5898898
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 6 Mar 2025 08:07:16 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A89A25805B;
 Thu,  6 Mar 2025 08:07:16 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2EA2058059;
 Thu,  6 Mar 2025 08:07:16 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  6 Mar 2025 08:07:16 +0000 (GMT)
MIME-Version: 1.0
Date: Thu, 06 Mar 2025 09:07:15 +0100
From: shalini <shalini@imap.linux.ibm.com>
To: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Cc: Thomas Huth <thuth@redhat.com>, Shalini Chellathurai Saroja
 <shalini@linux.ibm.com>, qemu-s390x mailing list <qemu-s390x@nongnu.org>,
 qemu-devel mailing list <qemu-devel@nongnu.org>, Hendrik Brueckner
 <brueckner@linux.ibm.com>
Subject: Re: [PATCH qemu v2 2/3] hw/s390x: add SCLP event type CPI
In-Reply-To: <dd6a3b1487abdb16202d435aa1f8d8c34454b0bc.camel@linux.ibm.com>
References: <20250224120449.1764114-1-shalini@linux.ibm.com>
 <20250224120449.1764114-2-shalini@linux.ibm.com>
 <01508dbb-7ee5-4c5b-87c9-667bc296fdbf@redhat.com>
 <dd6a3b1487abdb16202d435aa1f8d8c34454b0bc.camel@linux.ibm.com>
Message-ID: <b606ef7ddbda7a0349088411e1d81888@imap.linux.ibm.com>
X-Sender: shalini@imap.linux.ibm.com
Organization: IBM Deutschland Research & Development GmbH
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: dtvRjmxeQLz4cvtA-ZV7NcxttKtf-6DP
X-Proofpoint-GUID: dtvRjmxeQLz4cvtA-ZV7NcxttKtf-6DP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-06_03,2025-03-06_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 mlxlogscore=874 spamscore=0
 mlxscore=0 clxscore=1034 priorityscore=1501 impostorscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503060059
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

On 2025-03-05 20:00, Nina Schoetterl-Glausch wrote:
> On Wed, 2025-03-05 at 19:04 +0100, Thomas Huth wrote:
> 
> [...]
> 
>> > +
>> > +static int write_event_data(SCLPEvent *event, EventBufferHeader *evt_buf_hdr)
>> > +{
>> > +    ControlProgramIdMsg *cpi = container_of(evt_buf_hdr, ControlProgramIdMsg,
>> > +                                            ebh);
>> > +    S390CcwMachineState *ms = S390_CCW_MACHINE(qdev_get_machine());
>> > +
>> > +    ascii_put(ms->cpi.system_type, (char *)cpi->data.system_type, 8);
>> > +    ascii_put(ms->cpi.system_name, (char *)cpi->data.system_name, 8);
>> > +    ascii_put(ms->cpi.sysplex_name, (char *)cpi->data.sysplex_name, 8);
>> > +    ms->cpi.system_level = be64_to_cpu(cpi->data.system_level);
>> 
>> Can we be confident that system_level is always properly aligned?
> 
> It has offset 40 from the start of a heap allocation, so yes, but it is 
> far
> from obvious so I wouldn't mind ldq_be_p.
> 

ok, I will use ldc_be_p() instead, thank you Nina.

>> Otherwise it's maybe better to use ldq_be_p() instead?
>> 
>>   Thomas
>> 
>> 

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

