Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 911D0C369B2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Apr 2025 14:57:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4LFL-0002Lf-So; Mon, 14 Apr 2025 10:57:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rreyes@linux.ibm.com>)
 id 1u4LFF-00027l-D4; Mon, 14 Apr 2025 10:57:11 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rreyes@linux.ibm.com>)
 id 1u4LFD-0003lB-KP; Mon, 14 Apr 2025 10:57:09 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53EA0iGx029640;
 Mon, 14 Apr 2025 14:57:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=QLpS12
 OraT+tsit7J5qQhcmzABPOSNM47zb3bBraFHE=; b=MCx5hnuUscmQSDF5ZzQ7F2
 5vf6KRTXAt65I9XglbonCX2TfFMJkh4rpyGAy48yrDRrOx7/n/PGEMcBVY+zHLpn
 1YiNm2Nd8jgItkdbZ0akT5A3B/tqdEkggQeeh1clmodaQnVvN12/wFyOuqtOvQT1
 j8le5uUP1EQ1i2aLHgOADy52aknInMlHz6OVrP8/GjAOASpxTc9qtUvD6lbmcZH5
 MxMOJ4Fonw/WMpDg253iWbr/K1ShVnStRh3oUzNAU/VvyX/7JkFir7bAkpskZn96
 xhKy7+/xcDQ42uJb+/bV7S/5K8DMhsv/1DKeiSoKpZ3EgD0JudUpMNO2U/i9zsFw
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 460ndsuu13-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Apr 2025 14:57:05 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53EDx6Jm016746;
 Mon, 14 Apr 2025 14:57:05 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 460571xc89-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Apr 2025 14:57:05 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 53EEv35C25887048
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Apr 2025 14:57:03 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8656658059;
 Mon, 14 Apr 2025 14:57:03 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 479F95805E;
 Mon, 14 Apr 2025 14:57:02 +0000 (GMT)
Received: from [9.61.250.58] (unknown [9.61.250.58])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 14 Apr 2025 14:57:02 +0000 (GMT)
Message-ID: <1ba623ee-187a-4713-9ebc-6e491efba1c7@linux.ibm.com>
Date: Mon, 14 Apr 2025 10:57:01 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 5/5] s390: implementing CHSC SEI for AP config
 change
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: pbonzini@redhat.com, cohuck@redhat.com, pasic@linux.ibm.com,
 jjherne@linux.ibm.com, borntraeger@linux.ibm.com,
 alex.williamson@redhat.com, clg@redhat.com, akrowiak@linux.ibm.com
References: <20250311151616.98244-1-rreyes@linux.ibm.com>
 <20250311151616.98244-6-rreyes@linux.ibm.com>
 <f2168937-5252-4e91-80d6-2ad344f443fa@redhat.com>
 <ed45e437-5534-4ace-8a7e-196860b43cde@linux.ibm.com>
 <ce83485a-7575-49df-a3eb-7feac3cfd675@redhat.com>
 <9c837758-c45b-4e08-8cd9-918e25fb1063@linux.ibm.com>
 <9ee2d05c-cb62-4685-88b0-7f2f6ea2a006@redhat.com>
Content-Language: en-US
From: Rorie Reyes <rreyes@linux.ibm.com>
In-Reply-To: <9ee2d05c-cb62-4685-88b0-7f2f6ea2a006@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Y_dezpgN4X0oUAAMxeAv2zhW3V-t5IZy
X-Proofpoint-ORIG-GUID: Y_dezpgN4X0oUAAMxeAv2zhW3V-t5IZy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-14_05,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015
 mlxscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 mlxlogscore=999 bulkscore=0 spamscore=0 adultscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504140105
Received-SPF: pass client-ip=148.163.158.5; envelope-from=rreyes@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


On 4/14/25 10:54 AM, Thomas Huth wrote:
> On 14/04/2025 16.37, Rorie Reyes wrote:
>> On 4/11/25 2:45 AM, Thomas Huth wrote:
>>
>>> #include CONFIG_DEVICES
>>>
>>> at the beginning of the ioinst.c file. Then you should be able to do:
>>>
>>> #ifdef CONFIG_VFIO_AP
>>>     if (s390_has_feat(S390_FEAT_AP)) {
>>>        return ap_chsc_sei_nt0_get_event(res);
>>>     }
>>> #endif
>> This worked
>>>
>>> (or whatever the code should look like).
>>>
>>> Alternatively, and this might even be the nicer variant, add a file 
>>> hw/ vfio/ap-stub.c and include a dummy ap_chsc_sei_nt0_get_event() 
>>> function there. Then in hw/vfio/meson.build add this line:
>>>
>>> vfio_ss.add(when: 'CONFIG_VFIO_AP', if_false: files('ap-stub.c'))
>> This worked as well. Since you mentioned that this is a nicer 
>> variant, I'll go with this change. What do you recommend I do for my 
>> patches? Should I do an interactive rebase to add the new file 
>> hw/vfio/ap-stub.c and updating hw/ vfio/meson.build? Or should I make 
>> two new commits for each file (ap-stub.c and meson.build)
>
> Please do a "git rebase -i ..." to fix up the corresponding patch 
> (that's what we're doing in the QEMU development workflow).
>
>  Thanks
>   Thomas
>
Thank you. I'll make those changes and send my patches later today

