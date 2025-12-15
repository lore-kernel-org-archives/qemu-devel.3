Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B125D5B16F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 13:20:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vV8UP-0006vY-FK; Mon, 15 Dec 2025 08:19:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1vV8UO-0006vL-4w; Mon, 15 Dec 2025 08:19:48 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1vV8UM-0004op-Iz; Mon, 15 Dec 2025 08:19:47 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BEMptUq018505;
 Mon, 15 Dec 2025 13:19:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=zrB7Pc
 YyhtikOm2/FR9mYc96bpS+5oQ1JBmCrNVhSPg=; b=baO2I+duZtXyVfO0QP1Y4j
 W6LEBPeArcvcY7hyN+LfzQ9Se4HEd0nOtLQeKBOtZoBzbcwlolQw3h+F/sCb3Bud
 rhnsbZG92pb4YVr/3fCZgKpgfER+50KRME/S0QSlYEy9pR6HdX7TjsvLDrHUn0W/
 ZlTpQ5GzbTuX2M3s2QJD3sA7gZxgynm9m9ggNVm9OoQ0eWRnUemDSrxY+P0P1k8c
 hm6Mg+KU02oBWMFRA24AikPAtvTWu8c7dMqtYPFJA33300P2Io3k996IwoeLSF82
 qRbiUYn4FTtJGjR1lOi2HeOn06dCJGvVomsmcXbSR2rlLA7CYnnS+YCROfD9Zkhw
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0yt19aty-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Dec 2025 13:19:43 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BFDJhD3032394;
 Mon, 15 Dec 2025 13:19:43 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0yt19atu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Dec 2025 13:19:43 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BFD5cpJ014332;
 Mon, 15 Dec 2025 13:19:42 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4b1mpjp77m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Dec 2025 13:19:42 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5BFDJfnl32441004
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 15 Dec 2025 13:19:41 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 38D1E5805D;
 Mon, 15 Dec 2025 13:19:41 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C761D58058;
 Mon, 15 Dec 2025 13:19:40 +0000 (GMT)
Received: from [9.10.80.79] (unknown [9.10.80.79])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 15 Dec 2025 13:19:40 +0000 (GMT)
Message-ID: <4c4cc5f1-808a-4dc5-a35a-52b94f10df5d@linux.ibm.com>
Date: Mon, 15 Dec 2025 07:19:40 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] hw/ppc: Snapshot support for several ppc devices
To: Aditya Gupta <adityag@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, npiggin@gmail.com,
 milesg@linux.ibm.com, alistair@alistair23.me, kowal@linux.ibm.com,
 chalapathi.v@linux.ibm.com, angeloj@linux.ibm.com
References: <20251211220926.2865972-1-calebs@linux.ibm.com>
 <2vux3irnfwzssnleomcymy42vgd45bsqtjprhg6ro53koxannx@k3i2yh4dz647>
Content-Language: en-US
From: Caleb Schlossin <calebs@linux.ibm.com>
In-Reply-To: <2vux3irnfwzssnleomcymy42vgd45bsqtjprhg6ro53koxannx@k3i2yh4dz647>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: GmdFPqGRzNEv4TxHhGwXYbF8fexpipNh
X-Proofpoint-ORIG-GUID: ic1SZtYRVP5fO9rOOBbY-aywxe9zODrW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEzMDAyMyBTYWx0ZWRfX+GOZ224fTsNk
 SR+wewR1IXWOYoUUFl0qlU5j4ybTxEet+O6N13wq+Rh36G8CYO8oSBbWe0mcDcmfdjtNpfavPPr
 CLE9s/425WeaD6KyiTWi0uoqWM/2HjayC8BAEKyJUvz5233WduKofEKennJMT5M7MBPnrCcjOi+
 +z9X6Ut77PHtPsg2SeklMYPmLEe6hc1EGN4IKbpwpzfWLzT46qjpPM/9CCAobHfr0jeRFHz/S4n
 2Il1u6lESGU3hQAQJc6Tyq0qkuFEP28r1w4P+wMqgcP29AgH5pF5yR+/2xfVfNl9dxwji4LxPP1
 Fex9lp4/Vg3Oeqn3AO9/mHPOgylMBZW0hGPMS5R/0ewP0m9ZkH5LHrBRFnCMJuP+DkJRdf7XKKA
 +VeDDrPhysDdso9bOY8EgDhYGIAS+Q==
X-Authority-Analysis: v=2.4 cv=L/MQguT8 c=1 sm=1 tr=0 ts=69400aef cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=-H_8PTMz8_JlYa-9OgsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-15_02,2025-12-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 clxscore=1015 lowpriorityscore=0 bulkscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512130023
Received-SPF: pass client-ip=148.163.158.5; envelope-from=calebs@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Aditya,

My team has gotten snapshot support working with PowerNV and I'm now working on trying to upstream the smaller (less complicated) devices. Other, more complicated, support will be send upstream separately (PHB, XIVE, etc.).

Regarding LPC, all we had been focused on testing was Power10. If you'd like me to add support for Power8 and Power9, I can work on that in the next patch set.

- Caleb

On 12/15/25 12:08 AM, Aditya Gupta wrote:
> Hello Caleb,
> 
> On 25/12/11 04:09PM, Caleb Schlossin wrote:
>> Add snapshot support for several ppc devices for the powernv machines.
>>
>> * Adding LPC, ADU, SPI, I2C, core, and chipTOD
>>
>> No specific ordering of the patches as this is ongoing development to
>> support the PowerVM team. Additional patches for other (non-ppc) devices
>> will be coming in separate patch submissions.
> 
> Thanks for the patches, can you tell more background on this ? Because
> afaik PowerNV doesn't seem to have vmstate mostly, are these enough to
> store/restore full PowerNV context ?
> 
> The patches look good overall, though I am yet to review in detail.
> Some minor nits, LPC only sets vmstate for Power10's LPC, and many
> devices vmstate don't have pre/post load handlers, assuming just the
> vmstate info is enough in those cases ?
> 
> Thanks,
> - Aditya G
> 
>>
>> Thanks,
>> Caleb
>>
>> Michael Kowal (1):
>>   hw/ppc: Add VMSTATE information for LPC model
>>
>> Caleb Schlossin (2):
>>   hw/ppc: Add pnv_spi vmstate support
>>   hw/ppc: Add pnv_i2c vmstate support
>>
>> Angelo Jaramillo (3):
>>   hw/ppc: pnv_adu.c added vmstate support
>>   hw/ppc: pnv_core.c add vmstate support
>>   hw/ppc: pnv_chiptod.c add vmstate support
>>   
>>
>>  hw/ppc/pnv_adu.c             | 12 +++++++++++
>>  hw/ppc/pnv_chiptod.c         | 38 +++++++++++++++++++++++++++++++++++
>>  hw/ppc/pnv_core.c            | 22 ++++++++++++++++++++
>>  hw/ppc/pnv_i2c.c             | 11 ++++++++++
>>  hw/ppc/pnv_lpc.c             | 39 ++++++++++++++++++++++++++++++++++++
>>  hw/ssi/pnv_spi.c             | 27 +++++++++++++++++++++++++
>>  include/hw/ppc/pnv_chiptod.h |  2 ++
>>  7 files changed, 151 insertions(+)
>>
>> -- 
>> 2.47.3
>>


