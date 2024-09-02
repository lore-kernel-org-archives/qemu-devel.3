Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C007CD13CF
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2024 08:58:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sl2sa-0002RH-Ts; Mon, 02 Sep 2024 04:57:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1sl2sY-0002HG-EF; Mon, 02 Sep 2024 04:57:42 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1sl2sU-0005uR-3O; Mon, 02 Sep 2024 04:57:40 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 481Ksrp2024121;
 Mon, 2 Sep 2024 08:57:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 message-id:date:subject:to:references:cc:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=pp1; bh=
 VUUddSpU0lEg3Bj6NbyiuCMd4AsUN7xCc+RtFfhN0qQ=; b=MekIjt0C+oV2dpAG
 fRQe4hs6aFqitoCEmWGB8rWkwmWlgyqVsBuOGWEZGcuc9FWn4CR445a6UsbEwtyI
 ofDl38RPMze+9vubLZmidwIjre/s1QJZ0astg+ENp4CMCtCpy33uVyxtXSycAVqI
 K9igFn0GwKFgBB6dtDG7+MfBXV4Cr9IAABV53nYLjc37l6EFPhuwqvHZxeqRV++y
 Yl4mFE18c6lzCILMzc7UXJ9Ud8n1Ii2lsyWgPgUQBKN6kyMHj3z/QrEY5vt/yVP+
 6672JZv87qsp/vIfPU3Hv4+1Qf4FhrJevQo8PS9xMFguAOqzNlJtJva4XmWsugqQ
 PSfe2A==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41btty7ydu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 02 Sep 2024 08:57:28 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4828vRLi016638;
 Mon, 2 Sep 2024 08:57:27 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41btty7yds-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 02 Sep 2024 08:57:27 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48288pBN012098;
 Mon, 2 Sep 2024 08:57:27 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41cegpnd00-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 02 Sep 2024 08:57:27 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4828vNfr52363704
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 2 Sep 2024 08:57:23 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 373362004D;
 Mon,  2 Sep 2024 08:57:23 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CD73520040;
 Mon,  2 Sep 2024 08:57:20 +0000 (GMT)
Received: from [9.109.199.38] (unknown [9.109.199.38])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  2 Sep 2024 08:57:20 +0000 (GMT)
Message-ID: <59509b23-1acb-4052-96d4-0dd6d420cb90@linux.ibm.com>
Date: Mon, 2 Sep 2024 14:27:19 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 RESEND 0/5] Power11 support for QEMU [PSeries]
To: Amit Machhiwal <amachhiw@linux.ibm.com>
References: <20240731055022.696051-1-adityag@linux.ibm.com>
 <20240902111703.0faafa80-d0-amachhiw@linux.ibm.com>
Content-Language: en-US
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
From: Aditya Gupta <adityag@linux.ibm.com>
In-Reply-To: <20240902111703.0faafa80-d0-amachhiw@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: JTmjJnslyxtLj5fvzAJn_HEc9G-4DZMW
X-Proofpoint-ORIG-GUID: Kc53LQLdg2UdxUnEtN-ZdeKTmiBQ-sqB
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-09-02_01,2024-08-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxlogscore=999
 suspectscore=0 mlxscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 phishscore=0 spamscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2409020070
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi Amit,

On 02/09/24 11:19, Amit Machhiwal wrote:
> On 2024/07/31 11:20 AM, Aditya Gupta wrote:
>> <...snip...>
>>
>> Git Tree for Testing
>> ====================
>>
>> QEMU: https://github.com/adi-g15-ibm/qemu/tree/p11-v6-pseries
>>
>> Has been tested with following cases:
>> * '-M pseries' / '-M pseries -cpu Power11'
>>
> I could boot a Power11 pseries KVM guest with this patch series applied which
> does not work without it.
>
> Command Used:
>
>   qemu-system-ppc64 -m 4G -smp 4 -nographic -drive file=/root/testing/debian-12-generic-ppc64el.qcow2,format=qcow2 -accel tcg -cpu Power11
>
> Tested-by: Amit Machhiwal <amachhiw@linux.ibm.com>

Thanks for testing it, Amit !


- Aditya Gupta


