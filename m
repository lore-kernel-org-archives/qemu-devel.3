Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D5EAC624D6
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 14:24:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1lsc-0003tD-0n; Wed, 02 Sep 2026 10:23:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1x1lsa-0003sn-6o
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 10:23:56 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1x1lsY-00083D-M4
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 10:23:55 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 682CWK8T4190499; Wed, 2 Sep 2026 14:23:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=Ods+m3
 1hBQwWpchFpHJW9HudKDr5ARgxfcMr87kMwnQ=; b=KZjiD9lKYu9G3O6tX8USby
 HbmvoHyvG6VdYuMrF4Vt6x2o5pzgYQNfAa2QBnEhgdOeGLOgZEu8+EV8fl1CFfSK
 dxgR6HB5tJT830z0I9yG/R54cZPzhLcHzc+Yt91lgf9McqkLSo7wLtJ18doFprwL
 wIilgzGFRzmc3zuxrpH5NaiIRQbszdVTG+I9nMJrxcIJP+xfY9NwMdEcrtdWss3u
 Bzf6pZjTJNfzBBUSz3qRt540cBBVjaB2x7IQ66i2xRHelgEw1cyJCqHkxSHiR95Y
 K4K/cgJy2QUd80LCduQesJ6uTG28iKr9jdBVzk/5gP81zar7+s40jZPKb6HT54iA
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbpx5q53r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 02 Sep 2026 14:23:52 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 682EBHBK030338;
 Wed, 2 Sep 2026 14:23:51 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gcarka8xp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 02 Sep 2026 14:23:51 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 682ENpr812714704
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 2 Sep 2026 14:23:51 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0196D58062;
 Wed,  2 Sep 2026 14:23:51 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9899F58052;
 Wed,  2 Sep 2026 14:23:50 +0000 (GMT)
Received: from [9.47.158.153] (unknown [9.47.158.153])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  2 Sep 2026 14:23:50 +0000 (GMT)
Message-ID: <f492e217-bc70-4090-8d37-167b6ae00efc@linux.ibm.com>
Date: Wed, 2 Sep 2026 10:23:50 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Remove stale contact info for Stefan Berger
To: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: John Snow <jsnow@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>, QEMU <qemu-devel@nongnu.org>
References: <20260901195334.463267-1-jsnow@redhat.com>
 <CAJ+F1CKA-UPwzx7XLLhvA+VW8PuDQGbXKXDBK0mVfo0E4C6-hA@mail.gmail.com>
 <CAFn=p-Zix9rEXMQsCj=zanoOUXbS_dSTnWY3OaiLRSN4viTtjA@mail.gmail.com>
 <apfhDvrlNFQKJLI7@redhat.com> <87ik4o3psc.fsf@pond.sub.org>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <87ik4o3psc.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=PPc/P/qC c=1 sm=1 tr=0 ts=6a983179 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=20KFwNOVAAAA:8
 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=xYFGmzvKs1anFAXFgxkA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 9YhhRMbtEK1i-W6ZgW2ae1twXiB51FaQ
X-Proofpoint-ORIG-GUID: 0w4aEFior5IShTMpx2woQpcnWxTswxPZ
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDEyNCBTYWx0ZWRfX7uOSzMnZ7q6g
 uhGtwLLNO/J8vIHII6t5rPgmdE5nzVXSnFnLoxTPigD0IjFELzJJlgjSV9o2nVY7Q2KCheguld+
 sKj9huR+lzWPiFDAfF74Re5KBTiys6E=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDEyNCBTYWx0ZWRfX1GrlRrw3X39n
 KU+zK0izrUZSh9P4VsXSZcSu51iXovTLTgtJadR/m3lbKrl4mWg7DqrpOvsLtWd8aJCfK3gKXN9
 rwiv2gzVlmY/0Yq0kdaScV5/LlY4Zp3FmRtxwMtS/OsIO2MHM1jDsD5nWFVAJZs5FNyrN2CQsWW
 OjSppxb9+gbE2SGl8STx0+cb40Xg8I+rPUS3HGgkZGtL8M7klJL9vMhIyuv33A8uMu8DaFpJN3S
 GHKtLEIzz79iH1wVQ42HHPn7EVYrEyMaAoV3+lYsXRlOzOmQ3OADoZRi5S09F8FxDsn8rLYLMXF
 EK99Exmk+L0WiZyb4+ttYp0nJQ6CT77PIhcPwQ+YYzduiCF+Qz87ECOFYfuvSmjxv6yZFG02cP8
 zuwyoCSxGzMAyYZZIBtPi7x/Hf/QAuRdU87QanepD+E+6FfB0fyui3e4Xujd8jqiIw0kjEl5ZGk
 v6WS+TcJ464NgyN+WtQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_03,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609020124
Received-SPF: pass client-ip=148.163.156.1; envelope-from=stefanb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 9/2/26 6:34 AM, Markus Armbruster wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
>> On Tue, Sep 01, 2026 at 06:11:03PM -0400, John Snow wrote:
>>> On Tue, Sep 1, 2026 at 4:18 PM Marc-André Lureau
>>> <marcandre.lureau@gmail.com> wrote:
>>>>
>>>>
>>>> Hi
>>>>
>>>> Le mar. 1 sept. 2026, 23:54, John Snow <jsnow@redhat.com> a écrit :
>>>>>
>>>>> I was unable to get in touch with Stefan and I am not currently sure
>>>>> if this module is maintained or not. To prevent an avalanche of
>>>>> bounced emails, remove his contact information.
>>>>
>>>>
>>>> Really? There must be something wrong. He is a very responsive and active maintainer.
>>>
>>> All of the emails I have are bouncing; I hope they turn up! I would
>>> love to be proven hasty.
>>
>> When I replied to John's docs series last week it triggered a
>> blizzard of non-delivery emails for Stefan's address:
>>
>>    Attempting to deliver following mail to recipient(s):
>>      <stefanb@linux.ibm.com>
>>    VMSDVM9.POK.IBM.COM unable to connect for 1 days to recipient host.
>>    Delivery will be attempted for a total of 3 days.
>>
>> but I never got any more of those after that, and the 3 days passed,
>> so I'm thinking they did indeed get delivered in the end.
>>
>> With regards,
>> Daniel
> 
> I got several "552 Over quota" bounces in the past few days.
> 
Right. I was trying to get Thunderbird to use my retention policy for 
holding a certain number of emails per mailing list. No luck. It went 
back to what *it* wanted and I went away for a few days and ran over 
quota. Problem solved by unsubscribing.

> 


