Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FDC8C282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 15:00:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trebh-0001Vz-KT; Mon, 10 Mar 2025 10:59:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1trebd-0001Qh-5q; Mon, 10 Mar 2025 10:59:49 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1trebb-0004qr-0N; Mon, 10 Mar 2025 10:59:48 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52ADslSI017830;
 Mon, 10 Mar 2025 14:59:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=VCCDkV
 o4v2mZbPP3dj2xaTnIBwqPL29dT3N4QxSz6wk=; b=A5BNX7gaCHrD2u5V3Kq5uI
 KZqr3TzsI5HzcQ4A4PmPNYQJcaaeXU+Gdj/ga872ktGCAcEZGh2eVTDttwagsYNA
 Js2pnj2SYgT9qjFU5GsobE9p+g6psu1uoeBG6yancjlAJISSaRGZ+TRW7/099O2H
 pcRBdB4/1Z5H3zN5pXX+pBsqQKFxHVCIo1aDrw0FCmDIu+PfidsoS7e9bWv/GFGI
 IayOnjFkKFUTKcPLXRvNfB2pQwTJtQpndzQE+bdeUad7hfiRJzy+GKdI688CKXfB
 Ah3CK1SeyQ0J71kaeswcONEEdOYRhXqodxzC1oCuglvtTU/VkTBivBUWRsccxCkw
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 459rf935ur-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 10 Mar 2025 14:59:36 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52AEtNnJ002999;
 Mon, 10 Mar 2025 14:59:36 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 459rf935uj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 10 Mar 2025 14:59:36 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52AC3MWG014527;
 Mon, 10 Mar 2025 14:59:35 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4592ek6v98-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 10 Mar 2025 14:59:35 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 52AExVam36110616
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 10 Mar 2025 14:59:31 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9D11120043;
 Mon, 10 Mar 2025 14:59:31 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8310920040;
 Mon, 10 Mar 2025 14:59:29 +0000 (GMT)
Received: from [9.39.21.21] (unknown [9.39.21.21])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 10 Mar 2025 14:59:29 +0000 (GMT)
Message-ID: <d9ca52cd-6afd-4ed2-9e99-76ca5cbf7b80@linux.ibm.com>
Date: Mon, 10 Mar 2025 20:29:28 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 8/8] ppc/pnv: Update skiboot to support Power11
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
References: <20250308205141.3219333-1-adityag@linux.ibm.com>
 <20250308205141.3219333-9-adityag@linux.ibm.com>
 <f9ea56e0-a104-4acd-a27e-7d2813efe319@kaod.org>
 <094f0623-e483-4097-aca0-9f320b27af1a@linux.ibm.com>
 <04b8c4ce-0a58-4f50-97e4-b1cc30b8b340@kaod.org>
Content-Language: en-US
From: Aditya Gupta <adityag@linux.ibm.com>
In-Reply-To: <04b8c4ce-0a58-4f50-97e4-b1cc30b8b340@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: CZeGY1QBXGMl80FsEEg2FyolDYkFnHtG
X-Proofpoint-GUID: eH4SWktn27AbppkaDP0QWsmsBmNvEIxj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-10_06,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 mlxlogscore=637
 phishscore=0 bulkscore=0 mlxscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503100117
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 10/03/25 17:15, Cédric Le Goater wrote:
> On 3/10/25 11:31, Aditya Gupta wrote:
>>>> <...snip...>
>>>>   pc-bios/skiboot.lid | Bin 2527328 -> 2527424 bytes
>>>>   1 file changed, 0 insertions(+), 0 deletions(-)
>>>
>>> This change should come first as a sub maintainer PR, to avoid 
>>> sending 2.5MB
>>> on the mailing list :/ See how SLOF is handled.
>>>
>> Sorry didn't know this. I just checked the git log of skiboot.lid and 
>> thought maybe it's this same way of sending patches.
>
> For example, see  :
>
> https://lore.kernel.org/qemu-devel/CACPK8XfoKNxr6_KkDFFZm0P5w9m_ddD5E4SeuAkypXXr7swR7A@mail.gmail.com/
>
Thanks for the example Cédric. Now I see.


> To be sent before v6.

Sure, will wait for the maintainer to send it first before v6.


Thanks,

- Aditya Gupta

>
> Thanks,
>
> C.
>
>

