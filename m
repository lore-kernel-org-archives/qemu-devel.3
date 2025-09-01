Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AA55CA1002
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 08:32:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uszy4-0004UZ-Ac; Mon, 01 Sep 2025 04:32:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1uszxt-00047b-GD; Mon, 01 Sep 2025 04:32:38 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1uszxo-0003iI-Nr; Mon, 01 Sep 2025 04:32:37 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57VN09aV006431;
 Mon, 1 Sep 2025 08:32:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=4twBt3
 +/m6YEBaxRubxgOG0Rf4qUK00pu4Uy6D59dLk=; b=r8GbGDiOVBu5cOctJDpiUF
 Ak/s694b9Fr8lRugGIG6uWNtWpOFEHy/RS2CADssoYaeVfdbCELqWlh7bHVzebKx
 twEIiHO7sscTH83p9r3mERgB0LEqKhQ4mX4bNt0pNdPE+00bmNN38PkZ4gbKtedH
 huL1wxXVg/Nntctju3x1kh1hraVGshLRpfT6EVBev1Mou9U9ZiUTeYV+8vF27P6P
 kJ6fwcTlQ3JHb26oKxdU/VY3u4HGJDsy6Fo3tmtGAxCwEhvr7I6mHMMXg9XWj62z
 zLRImPflUzn/25nr/ZrFsmWu11s/YXmM5vmJyiOHDKpFwxFXO/2zkywayTNAxHZA
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48usu9qqw6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 01 Sep 2025 08:32:21 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5818NvqV027092;
 Mon, 1 Sep 2025 08:32:20 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48usu9qqw2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 01 Sep 2025 08:32:20 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5816UdSR009248;
 Mon, 1 Sep 2025 08:32:19 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 48vdum4uhm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 01 Sep 2025 08:32:19 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5818WG2742205530
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 1 Sep 2025 08:32:16 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F164E20040;
 Mon,  1 Sep 2025 08:32:15 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B3F942004D;
 Mon,  1 Sep 2025 08:32:13 +0000 (GMT)
Received: from [9.109.199.210] (unknown [9.109.199.210])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  1 Sep 2025 08:32:13 +0000 (GMT)
Message-ID: <08e60753-d9e8-4af8-83c0-492e5dda7a40@linux.ibm.com>
Date: Mon, 1 Sep 2025 14:02:12 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fix: Fix build error with CONFIG_POWERNV disabled
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Chinmay Rath <rathc@linux.ibm.com>
Cc: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Thomas Huth <thuth@redhat.com>
References: <20250820122516.949766-2-adityag@linux.ibm.com>
 <238387ee-055e-40c2-a889-66cb320e26c8@redhat.com>
Content-Language: en-US
From: Aditya Gupta <adityag@linux.ibm.com>
In-Reply-To: <238387ee-055e-40c2-a889-66cb320e26c8@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: uLn-oxlD9mGnDkcujgvFxM51TjxyQwpP
X-Authority-Analysis: v=2.4 cv=U6uSDfru c=1 sm=1 tr=0 ts=68b55a15 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=KKAkSRfTAAAA:8 a=20KFwNOVAAAA:8
 a=VnNF1IyMAAAA:8 a=sULMLQYTfiKUNo0OxekA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzNCBTYWx0ZWRfX3T1EuKoWReeF
 Pui3xy/6l87AefJwvqh6ZOU/oQK9ZN+h4uHB8KN2DxUCl+FZSYGtmoc5RlcBAmbxOxY7Z7qzmhp
 T8WGN3O/ImemrXXzRnIgnibfVMJTXSiSGb+hLtBHlO21/NWUGoDsE7fIBrNzLQzX537D2BqlMxz
 lCU94dDLvUZZ0dtO81ub/zbbvbumwRgoEhf2tQvd0cEsGmlaMRjIiLomQj09Ue/NZ7r2RBWgv4p
 XxlGVYM0F+ye783zcBsqX6GM1HwN40FgWayFI2I3eHOOkvI/s/fRb3m1kHDEzpvr+vymiuKNViM
 udELzsEYE7DS5AoudCnTftuakuW6z2gWg0kFZBs3S3X4j6aR20KQoPq8HhazU9bud7Z5LIz+rcE
 f4bSsg4U
X-Proofpoint-ORIG-GUID: utpeqCzDalpAsW-QZq1VsaiUs8zsbKoR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-01_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 adultscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 spamscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300034
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On 01/09/25 12:29, Cédric Le Goater wrote:

> On 8/20/25 14:25, Aditya Gupta wrote:
>> Currently when CONFIG_POWERNV is not enabled, the build fails, such as
>> with --without-default-devices:
>>
>>      $ ./configure --without-default-devices
>>      $ make
>>
>>      [281/283] Linking target qemu-system-ppc64
>>      FAILED: qemu-system-ppc64
>>      cc -m64 @qemu-system-ppc64.rsp
>>      /usr/bin/ld: 
>> libqemu-ppc64-softmmu.a.p/target_ppc_misc_helper.c.o: in function 
>> `helper_load_sprd':
>>      .../target/ppc/misc_helper.c:335:(.text+0xcdc): undefined 
>> reference to `pnv_chip_find_core'
>>      /usr/bin/ld: 
>> libqemu-ppc64-softmmu.a.p/target_ppc_misc_helper.c.o: in function 
>> `helper_store_sprd':
>>      .../target/ppc/misc_helper.c:375:(.text+0xdf4): undefined 
>> reference to `pnv_chip_find_core'
>>      collect2: error: ld returned 1 exit status
>>      ...
>>
>> This is since target/ppc/misc_helper.c references PowerNV specific
>> 'pnv_chip_find_core' call.
>>
>> Split the PowerNV specific SPRD code out of the generic PowerPC code, by
>> moving the SPRD code to pnv.c
>>
>> Fixes: 9808ce6d5cb ("target/ppc: Big-core scratch register fix")
>> Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Reported-by: Thomas Huth <thuth@redhat.com>
>> Suggested-by: Cédric Le Goater <clg@redhat.com>
>> Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
>
>
> Acked-by: Cédric Le Goater <clg@redhat.com>


Thank you for the tag, Cedric !

- Aditya G



