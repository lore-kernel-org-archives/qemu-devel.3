Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF231CCF9F8
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 08:06:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vENfw-0006iw-Nl; Thu, 30 Oct 2025 04:06:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vENfu-0006ia-U8; Thu, 30 Oct 2025 04:06:26 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vENfo-0001nj-Hx; Thu, 30 Oct 2025 04:06:24 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59TM6j8Z004792;
 Thu, 30 Oct 2025 08:06:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=LIqUZp
 YSn32mcNHijQiUkJ/rYcahiymgdrwlBpFiwAo=; b=DQwDTvV50zg5L7Lwn9Iplk
 g4ZLmKfwaVVF99jmmXKMOYuycC1Q8tTZG5xYFvXCXAcJeW1AjG2zgPepgNfS7l/Y
 U55j07XwE3RDdPSqjY7d1qiGQBhaN3ouSShnFXIIzk01dm9ARgUHelj3XsnXdAbl
 QlsmfRiLPCIuVAzlFJsH4L8t43vzXOp65x6IEzF6SWyiMp6PUABEeZEvrBxrjMUH
 EVyUVVk4kYYRuyMW/4yHKkR2CzJRUFo0pDF3hDxs8nUhqcujnjaWRUkkRiznEOjb
 bkZtUU/tvEBUToWhmiG/njEBZlOekPq5l/qAq5CeQjG2GApub15pDNSP0M5Pk1VQ
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a34a8qaga-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 Oct 2025 08:06:13 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59U84fH4028700;
 Thu, 30 Oct 2025 08:06:13 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a34a8qag5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 Oct 2025 08:06:13 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59U5e8nT023839;
 Thu, 30 Oct 2025 08:06:12 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4a33vx7g62-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 Oct 2025 08:06:12 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59U86B9r3015190
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 30 Oct 2025 08:06:11 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4DE2B58064;
 Thu, 30 Oct 2025 08:06:11 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A60095805A;
 Thu, 30 Oct 2025 08:06:09 +0000 (GMT)
Received: from [9.109.242.24] (unknown [9.109.242.24])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 30 Oct 2025 08:06:09 +0000 (GMT)
Message-ID: <31effff7-cdff-4ddb-a772-3849941af587@linux.ibm.com>
Date: Thu, 30 Oct 2025 13:36:08 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] hw/ppc/pegasos2: Add /chosen/stdin node with VOF
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <cover.1761346145.git.balaton@eik.bme.hu>
 <642ef77674d08ba466e7a2beb4858ab1e67776ae.1761346145.git.balaton@eik.bme.hu>
Content-Language: en-US
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <642ef77674d08ba466e7a2beb4858ab1e67776ae.1761346145.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=DYkaa/tW c=1 sm=1 tr=0 ts=69031c75 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8 a=65ho8ntZO24EVziD3ksA:9
 a=QEXdDO2ut3YA:10 a=oH34dK2VZjykjzsv8OSz:22 a=pHzHmUro8NiASowvMSCR:22
 a=n87TN5wuljxrRezIQYnT:22
X-Proofpoint-GUID: IALbCea5llIRDjBX-BoaViPdnsZaDLGB
X-Proofpoint-ORIG-GUID: ZmvehMgthqJKqQ2WlZE5UriTJSt7w9rj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDE2NiBTYWx0ZWRfXxZG6AGSk5H0/
 7FtU5At3Krha+EDhMa5Woes8Qf7J9xdGgrQJ93YNg97Hkm6yn9xXxwf699xgZHKP1grav+/B9jT
 2RFbj9POrEUF7vSfBuNfLdM7xF5fxgzpVux9rFnV6ZVeJxnQGSh4aldVA7oaAXnFdTnllUfyNGL
 ta3HM9/2uBvJQrOa0Pge0+3O9mlX1YMGWTSJI7viZPqORY0M+Lx+3aeEu/Tnbi67TxPQ40ung/u
 AY0+FEU8eMsGPfmgQ/J5Q/kkEGSc9AIB+cUZQDeBZVAgdqthBoNwOl3uHm1rVggBtMOcJVb6MNX
 18m/99HS5x6XYRdil71zByidlg8vxiKCHHIS7hIM9KVEgz3XB67FjtIG46ETJdVFwslXINlNLyN
 tyLdp3Pdd4YIWCgWjeCFJ0HKj9HS5g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_02,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 malwarescore=0 bulkscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2510280166
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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



On 10/25/25 05:01, BALATON Zoltan wrote:
> Some very old Linux kernels fail to start if /chosen/stdin is not
> found so add it to the device tree when using VOF.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>   hw/ppc/pegasos2.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/hw/ppc/pegasos2.c b/hw/ppc/pegasos2.c
> index 93696ed381..21299dde3c 100644
> --- a/hw/ppc/pegasos2.c
> +++ b/hw/ppc/pegasos2.c
> @@ -565,6 +565,7 @@ static void pegasos_machine_reset(MachineState *machine, ResetType type)
>       qemu_fdt_setprop(fdt, "/chosen", "qemu,boot-kernel", d, sizeof(d));
>   
>       vof_build_dt(fdt, pm->vof);
> +    vof_client_open_store(fdt, pm->vof, "/chosen", "stdin", "/failsafe");

Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>

>       vof_client_open_store(fdt, pm->vof, "/chosen", "stdout", "/failsafe");
>   
>       /* Set machine->fdt for 'dumpdtb' QMP/HMP command */

