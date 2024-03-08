Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C40FCC5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 15:17:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ribyU-0004Xa-KT; Fri, 08 Mar 2024 10:17:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1ribyQ-0004Wj-Gw; Fri, 08 Mar 2024 10:17:26 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1ribyP-0004AC-0G; Fri, 08 Mar 2024 10:17:26 -0500
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 428EhFeO004872; Fri, 8 Mar 2024 15:17:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=9Re5orMEoe40jLl+xgsDONwVKhZKptcejsRYt6t5S04=;
 b=NLK7GSgg2eFFeimrw/dfhutg1j2X65uXN5S8tdyBFvIIsh2dJ6CMnic21Jp2oPpmpaSO
 mlQvQt4QccRia+Pqa2kgytoodCncK18gILDzBx+qFH+oS1F3nKgeROk8zYOh4L7h/h/Y
 VGbqmw/98ni/vaRWoDTjfF7DGcg6o/VWp/lUL13L9u3c62EvhZ5XTEi8CvHVLnORx8rH
 3nHnFwXIgxYWf+0Ew+oCP2WSW8sOj2jQ+A8XfLW7/cSftkPk8hgUIUEEfw72mNyIkUBB
 YIGn0pojxz7mnmfxqySzyRtz7Aj6sYRgFvRoDMSbkHqLvpgzmjdIAx1Jc8QZ8XDpTMHi sA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wr4pc0jcn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Mar 2024 15:17:16 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 428F0auI021185;
 Fri, 8 Mar 2024 15:17:15 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wr4pc0jcg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Mar 2024 15:17:15 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 428EgWrN027187; Fri, 8 Mar 2024 15:17:15 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wmfepd4e6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Mar 2024 15:17:15 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 428FHAW020906676
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 8 Mar 2024 15:17:12 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C865858070;
 Fri,  8 Mar 2024 15:17:08 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4143158068;
 Fri,  8 Mar 2024 15:17:08 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  8 Mar 2024 15:17:08 +0000 (GMT)
Message-ID: <4b73cdf8-ce5c-424b-b81d-73c1fd72a385@linux.ibm.com>
Date: Fri, 8 Mar 2024 10:17:07 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/5] hw/ppc: SPI controller model - registers
 implementation
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
To: Chalapathi V <chalapathi.v@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, fbarrat@linux.ibm.com, npiggin@gmail.com,
 clg@kaod.org, calebs@us.ibm.com, chalapathi.v@ibm.com,
 saif.abrar@linux.vnet.ibm.com
References: <20240207160833.3437779-1-chalapathi.v@linux.ibm.com>
 <20240207160833.3437779-3-chalapathi.v@linux.ibm.com>
 <6ab8bb8e-5126-4322-bb91-6709e46c444a@linux.ibm.com>
In-Reply-To: <6ab8bb8e-5126-4322-bb91-6709e46c444a@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: E-sLS95uWSw5Z3a34aezIOW9YY4ZmGSz
X-Proofpoint-GUID: EkjZfK3VXOcw_i_Zx7wBghLGeeN1P3xJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-08_08,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 spamscore=0 clxscore=1015
 adultscore=0 malwarescore=0 phishscore=0 mlxlogscore=821
 priorityscore=1501 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311290000 definitions=main-2403080123
Received-SPF: pass client-ip=148.163.158.5; envelope-from=stefanb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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



On 3/7/24 13:54, Stefan Berger wrote:
> 
> 
> On 2/7/24 11:08, Chalapathi V wrote:
>> SPI controller device model supports a connection to a single SPI 
>> responder.
>> This provide access to SPI seeproms, TPM, flash device and an ADC 
>> controller.
>>
>> All SPI function control is mapped into the SPI register space to 
>> enable full
>> control by firmware. In this commit SPI configuration component is 
>> modelled
>> which contains all SPI configuration and status registers as well as 
>> the hold
>> registers for data to be sent or having been received.
>>
>> Signed-off-by: Chalapathi V <chalapathi.v@linux.ibm.com>
>
>> +    case SEQUENCER_OPERATION_REG:
>> +        for (int i = 0; i < SPI_CONTROLLER_REG_SIZE; i++) {
>> +            sc->sequencer_operation_reg[i] =
>> +                 (val & PPC_BITMASK(i * 8 , i * 8 + 7)) >> (63 - (i * 
>> 8 + 7));
> 
> To me it would be more obvious if you used a mask here like this:
> 
> mask = PPC_BIT_MASK(0, 7);
> mask = (0xff << 56);
> 
> for (...) {
>      sc->sequencer_operation_reg[i] = (val & mask) >> (56 - i * 8);
>      mask >>= 8;
> }
>

Actually simpler and even this masking is not necessary:

for (...) {
     sc->sequencer_operation_reg[i] = (val >> (56 - i * 8)) & 0xff;
}



