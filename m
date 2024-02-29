Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BF5EC48BF6
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 05:47:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfZFm-0008Pg-Ka; Thu, 29 Feb 2024 00:46:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1rfZFi-0008PA-PU; Thu, 29 Feb 2024 00:46:44 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1rfZFg-00056d-Ib; Thu, 29 Feb 2024 00:46:42 -0500
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41T5LaDS031196; Thu, 29 Feb 2024 05:46:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=CsIVn6ZWBePjktsu8WtGrd5aQ6kf6zmCfDQ1j2HEueo=;
 b=VL7TJgHKrIAds91jL+lbKbVMf7heWWv9chiQTaZI4an3gopoJwYRILdiW0wljFhxKCWA
 l/P4/fcX8GbZGCOxSR5oeU0mVLKsjIkFj4IXT8ol2OhLYzVBUiVZR4lKD6MnFzwxLuxX
 gxvVrM/Zs5kMpNuacdeOCSuPGlDhzGPG2Qb9TiXJTnuR0idBz4Eqh8hXMfwrWd1oYJ47
 qXNcuNAb2+vcoPv3u0gz9KR9wo3OJ2iQ6wOdxLk70VnNomXcG6x1fnu7zFsabk7oomN6
 6SI+kB/E2/bqM4tDErrK0IYaHcJLlLhOTbdbr18AavkS9rHCFtROgMbMsYQcBGz4bf4y RA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wjk05ssfc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 29 Feb 2024 05:46:34 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41T5LtZ0032442;
 Thu, 29 Feb 2024 05:46:34 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wjk05ssey-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 29 Feb 2024 05:46:33 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 41T4PDHt012324; Thu, 29 Feb 2024 05:46:33 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wfwg2jt4y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 29 Feb 2024 05:46:33 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 41T5kUsG61407598
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 Feb 2024 05:46:32 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3ABF15805D;
 Thu, 29 Feb 2024 05:46:30 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 83E6958057;
 Thu, 29 Feb 2024 05:46:27 +0000 (GMT)
Received: from [9.109.243.35] (unknown [9.109.243.35])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 29 Feb 2024 05:46:27 +0000 (GMT)
Message-ID: <377b4501-9e5b-44af-9219-c5e7e8a2c70e@linux.ibm.com>
Date: Thu, 29 Feb 2024 11:16:26 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/15] spapr: nested: Document Nested PAPR API
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: clegoate@redhat.com, mikey@neuling.org, amachhiw@linux.vnet.ibm.com,
 vaibhav@linux.ibm.com, sbhat@linux.ibm.com, danielhb413@gmail.com,
 qemu-devel@nongnu.org
References: <20240220083609.748325-1-harshpb@linux.ibm.com>
 <20240220083609.748325-6-harshpb@linux.ibm.com>
 <CZFR7EN29EWC.EK4AP0CCTQJI@wheely>
 <8b71d5a6-7ed1-428f-8b08-dddf4fd09870@linux.ibm.com>
 <CZFSP3JYT0C5.140WKB17N0IQG@wheely>
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <CZFSP3JYT0C5.140WKB17N0IQG@wheely>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: zE-HKGJkbhXVlcoAuff7VC-0QtH98VBv
X-Proofpoint-ORIG-GUID: R1MtReOrwMnruyhPA8vcBOC2PsYwZP6f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-28_08,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=687
 priorityscore=1501 impostorscore=0 mlxscore=0 suspectscore=0 spamscore=0
 bulkscore=0 adultscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402290043
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
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



On 2/27/24 16:09, Nicholas Piggin wrote:
> On Tue Feb 27, 2024 at 7:31 PM AEST, Harsh Prateek Bora wrote:
>>
>>
>> On 2/27/24 14:59, Nicholas Piggin wrote:
>>> On Tue Feb 20, 2024 at 6:35 PM AEST, Harsh Prateek Bora wrote:
>>>> Adding initial documentation about Nested PAPR API to describe the set
>>>> of APIs and its usage. Also talks about the Guest State Buffer elements
>>>> and it's format which is used between L0/L1 to communicate L2 state.
>>>>
>>>> Signed-off-by: Michael Neuling <mikey@neuling.org>
>>>> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
>>>
>>> v2 is upstream in Linux now, I suppose you could reference that too?
>>>
>> Yes, upstream Linux commit is mentioned in the doc at the end.
> 
> The API doc commit is mentioned as a reference. I would expect something
> following the comments under the Existing Nested-HV API heading for the
> New PAPR API.
> 
> Oh, is it lifted directly from linux.git docs? Sigh, in that case never
> mind, it's better to stick with them. Although could be just a link or
> reference.
> 

Well, initially the documentation was floated across with both
kernel/qemu patches, and now we have the kernel side merged. Although, I
think it would be more appropriate to keep it in Qemu which actually
implements the L0 functionality and the related APIs, however, for now,
let's keep a single source of documentation and we can provide a link
after the brief intro about the two APIs.

regards,
Harsh

> Thanks,
> Nick
> 

