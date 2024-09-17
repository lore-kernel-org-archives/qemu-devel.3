Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EE80C3ABCB
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2024 04:38:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqPyB-000796-8e; Tue, 17 Sep 2024 00:37:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1sqPy9-00078C-22; Tue, 17 Sep 2024 00:37:41 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1sqPy7-0005aC-49; Tue, 17 Sep 2024 00:37:40 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48GIUxdZ030256;
 Tue, 17 Sep 2024 04:37:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=+
 7SHNvBq1FlvhJV7HFCU7AF/6JGgIWfJV6UCH/Dh0d8=; b=emmNQQ4GLO24GXmoS
 MdV/YllUvr2ZBq6EEshYVQRroWJLZx2unVAVd2tfgl6VkzcbT4WC8W/+SMqzrrFu
 dnbvuzk/Zt6Y9BSZu8QS5nhM22JNzk3RLwnrOXMbo8frXnvin+DR4wm8Wa80oceL
 pCkXZwgTqzqeiLobRwqzOh8J+fU12oCGrG5Ig/mue8f6A03E1RK1E03/wuwfoAcF
 JSZJW/6PqByk0eZOjQCObGVKKl1aRMQiWGPdquO+2FnnC590hOzX82k22YywQFVm
 8Jby0nF+BRL1YfFAcWq+ubRcLILwEJDJZORl0402A029MyyxyxtbldJiXDiAFCue
 TBQrA==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41pht8ctt4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 17 Sep 2024 04:37:28 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48H4bR08025449;
 Tue, 17 Sep 2024 04:37:27 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41pht8ctsy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 17 Sep 2024 04:37:27 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48H2AA20000731;
 Tue, 17 Sep 2024 04:37:26 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41nntq321d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 17 Sep 2024 04:37:26 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 48H4bQAS20382282
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 17 Sep 2024 04:37:26 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2B50F58060;
 Tue, 17 Sep 2024 04:37:26 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5E5CD58056;
 Tue, 17 Sep 2024 04:37:24 +0000 (GMT)
Received: from [9.109.242.165] (unknown [9.109.242.165])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 17 Sep 2024 04:37:24 +0000 (GMT)
Message-ID: <2829b101-4129-4d96-b6c6-eb287822c097@linux.ibm.com>
Date: Tue, 17 Sep 2024 10:07:23 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 20/49] spapr: Tag pseries-2.1 - 2.11 machines as deprecated
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 Thomas Huth <thuth@redhat.com>
References: <20240219082938.238302-1-npiggin@gmail.com>
 <20240219082938.238302-21-npiggin@gmail.com>
 <00b812a8-48ba-4d51-bb4d-30d7e461c907@kaod.org>
Content-Language: en-US
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <00b812a8-48ba-4d51-bb4d-30d7e461c907@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 8ooWOpWFgu0SEmcmgy77uI4SrsqtTzC9
X-Proofpoint-ORIG-GUID: Iid0lpteOswXFaenh0OBkE6oGj7AoOlo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-17_01,2024-09-16_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 phishscore=0 bulkscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 mlxlogscore=996 mlxscore=0 clxscore=1015 malwarescore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409170030
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Cedric,

On 9/16/24 18:44, Cédric Le Goater wrote:
> Hello Harsh,
> 
> On 2/19/24 09:29, Nicholas Piggin wrote:
>> From: Cédric Le Goater <clg@kaod.org>
>>
>> pseries machines before version 2.11 have undergone many changes to
>> correct issues, mostly regarding migration compatibility. This is
>> obfuscating the code uselessly and makes maintenance more difficult.
>> Remove them and only keep the last version of the 2.x series, 2.12,
>> still in use by old distros.
>>
>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>> Reviewed-by: Daniel Henrique Barboza <danielhb413@gmail.com>
>> Signed-off-by: Cédric Le Goater <clg@kaod.org>
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>> ---
>>   docs/about/deprecated.rst | 8 ++++++++
>>   hw/ppc/spapr.c            | 1 +
>>   roms/skiboot              | 2 +-
>>   3 files changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
>> index 5a2305ccd6..36bd3e15ef 100644
>> --- a/docs/about/deprecated.rst
>> +++ b/docs/about/deprecated.rst
>> @@ -229,6 +229,14 @@ The Nios II architecture is orphan.
>>   The machine is no longer in existence and has been long unmaintained
>>   in QEMU. This also holds for the TC51828 16MiB flash that it uses.
>> +``pseries-2.1`` up to ``pseries-2.11`` (since 9.0)
>> +''''''''''''''''''''''''''''''''''''''''''''''''''
>> +
>> +Older pseries machines before version 2.12 have undergone many changes
>> +to correct issues, mostly regarding migration compatibility. These are
>> +no longer maintained and removing them will make the code easier to
>> +read and maintain. Use versions 2.12 and above as a replacement.
>> +
> 
> Would you have time, or a KVM PPC team member, to start removing
> the now deprecated pseries machines in the QEMU 9.2 cycle ?
> 

Sure, I can take a look at that.

regards,
Harsh

> Thanks,
> 
> C.
> 
> 

