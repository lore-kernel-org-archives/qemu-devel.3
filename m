Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05677CA5FC1
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 18:26:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBz01-0004yM-6T; Wed, 30 Sep 2026 14:25:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1xByzw-0004uF-Ln; Wed, 30 Sep 2026 14:25:45 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1xByzu-0005QO-NN; Wed, 30 Sep 2026 14:25:44 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68UI5PJ13708324; Wed, 30 Sep 2026 18:25:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=U0sQPL
 rXXmhwetWW2jXpsiruKjnBIRDe4vaDQ9xZM0E=; b=RWP9jKNmJ/T525jLYrw0zu
 X7ztetk650GTiKddVt5BfU/5ux+fe3qn+F3cu1715BsWvAUDaOMmWtPAUVBk4gkT
 YyNibz9t87htVxte3MT/LXo7Q7O82V8pdBFYZpkXycuk+KIsYNZ0AAnYMJYSqqZc
 JRUyyo1ftgENr3jKFAk3iVhtIwWzIPd0bd2jLl2i3MifAqKhFWi6iWZFQByLUZSn
 neoOGtbzYillj5EaOpoLqhSgQIG/zY+Tj1fd98nEmO39IBFHP/P4QSlexlyEHnvr
 O26e4IsnS9saYRhC7eme/IGZpqYMfTrWqJK9ddqCBTa0TwFxhuHoE44aW5XVVuEA
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5j5ewye-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 30 Sep 2026 18:25:40 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68UI2MKM3863800; Wed, 30 Sep 2026 18:25:39 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h0xcsacn3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 30 Sep 2026 18:25:39 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68UIPc0l11862744
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 30 Sep 2026 18:25:38 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4700F5805D;
 Wed, 30 Sep 2026 18:25:38 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C295D58052;
 Wed, 30 Sep 2026 18:25:37 +0000 (GMT)
Received: from [9.61.244.222] (unknown [9.61.244.222])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 30 Sep 2026 18:25:37 +0000 (GMT)
Message-ID: <623e5974-639a-4db4-9d78-cf85932ee398@linux.ibm.com>
Date: Wed, 30 Sep 2026 11:25:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/2] s390x/pci: Reset a device in error state
To: Matthew Rosato <mjrosato@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: farman@linux.ibm.com, cohuck@redhat.com, alex@shazbot.org, clg@redhat.com
References: <20260922171756.920-1-alifm@linux.ibm.com>
 <20260922171756.920-3-alifm@linux.ibm.com>
 <523a3e09-856c-4adb-8134-9a4dc44e16ba@linux.ibm.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <523a3e09-856c-4adb-8134-9a4dc44e16ba@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA3MyBTYWx0ZWRfX9/z7mOTxfSq0
 PYVjfzFxufv6sTlONW6sRuN/VoUSkIxS0ziRDqwYs3vzmEZBY8OJVrUTBxE02BvdPJdbio3kvhK
 Cw/f+zViBKcdPnTrgO4seWyz4pU0v4A=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA3MyBTYWx0ZWRfX/dQY9hrTaf7l
 uRhil4W+QbppBytK5v9APT4Sbd2PhYOMRI0jl1SPXgceEHhVRucs/JyBWTr9eC1inIx82emj0aV
 qesc2XbnoIGumMcXVtUngpGcqnMISjk9KYy/PKcAQfIWwqm0NW22Mqo9y5m66sCH7egDT7OcVSd
 noQW2t2Yd7pjjEmsCVcKbE3Bqcs8yG17L5Xdj5zF/1ucI57p8BMHpw9YOMsbjiJibckuF4Ed9nP
 42cesRtAkN9rBAWHl1UHY2PjlQUB49WQ+VS4aegm2m80bGO4mlv8t7QxpGM48/qKO3sjnarp4sn
 vNh38frmJX6UoWJ2kbeakx9M390dej/GR8QQWgE0OHrTgdwNbQg4HU8CKbgg+inBEYV/xViLP2i
 qISJPHPrNjkWa7hOU1ri9E2uSuIWt+PrvemMnA5OEdGXFOCLCEqkqF0RdGIy1GCekLCKr3F3yO3
 /PEYNG9uvXjv2WTlYGQ==
X-Proofpoint-GUID: QHRek4FkZubGsz8V5EjzxaK1ybbNMXCp
X-Authority-Analysis: v=2.4 cv=RKcmjIi+ c=1 sm=1 tr=0 ts=6abd5424 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=cpXPkdbrrH2Fta4yfDEA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: QHRek4FkZubGsz8V5EjzxaK1ybbNMXCp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0
 adultscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300073
Received-SPF: pass client-ip=148.163.156.1; envelope-from=alifm@linux.ibm.com;
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


On 9/30/2026 8:32 AM, Matthew Rosato wrote:
>> --- a/hw/s390x/s390-pci-bus.c
>> +++ b/hw/s390x/s390-pci-bus.c
>> @@ -1505,6 +1505,8 @@ static void s390_pci_device_reset(DeviceState *dev)
>>           return;
>>       case ZPCI_FS_STANDBY:
>>           break;
>> +    case ZPCI_FS_ERROR:
>> +        break;
>>       default:
>>           pbdev->fh &= ~FH_MASK_ENABLE;
>>           pbdev->state = ZPCI_FS_DISABLED;
>> @@ -1517,6 +1519,11 @@ static void s390_pci_device_reset(DeviceState *dev)
>>       } else if (pbdev->summary_ind) {
>>           pci_dereg_irqs(pbdev);
>>       }
>> +
>> +    if (pbdev->state == ZPCI_FS_ERROR) {
>> +        s390_pci_reset(pbdev);
>> +    }
> I know it was mentioned in the prior version, so apologies for not
> chiming in til now.  But you really need a comment block explaining why
> it's OK to reset the device yet leave it in the ZPCI_FS_ERROR state
> after the fact.  That's confusing.

I can add a comment block explaining why we don't change the state. But 
my understanding is the guest needs to drive the change of the function 
state.


>
> You mentioned in the last version it's because this happens on the
> disable path, and there yes we will set the device to ZPCI_FS_DISABLED
> right after this -- but what about any other case where we drive this
> reset path (e.g. subsystem reset, reboot, and the ISM-specific extra paths)
>
> Note that the non-error cases are ensuring we either leave this function
> with the device listed as disabled or standby/reserved.
>
> Would there be harm in, after performing the reset, doing
> pbdev->fh &= ~FH_MASK_ENABLE;
> pbdev->state = ZPCI_FS_DISABLED;
> for the ZPCI_FS_ERROR case now?

One reason I didn't change the state was also because per my 
understanding of architecture we need the guest to clear the error 
state. This could be done via a mpcifc instruction (oc=7 
ZPCI_MOD_FC_RESET_ERROR) or through a CLP set pci function 
enable/disable cycle. So if we leave the device in disabled state after 
a reset without the guest driving any change, I think it might present a 
wrong view to the guest. I am open to suggestions if you think it would 
be more appropriate to keep the device in disabled state.

Thanks

Farhan

> Consider that:
> 1) For a guest-initiated disable, we already checked those were valid
> before reaching this point.
> 2) For all other reset cases, if the device were not in
> error/reserved/standby we were leaving here with the device disabled
> before this patch.  If the device happened to be in error, now you fix
> it up but isn't the proper fix state now 'disabled' to match what an
> enabled device would have been?
>
> Thanks,
> Matt

