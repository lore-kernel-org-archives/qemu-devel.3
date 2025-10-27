Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F00FACCF9EB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 08:26:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDIY0-0007L6-4f; Mon, 27 Oct 2025 04:25:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vDIXw-0007KY-Uk; Mon, 27 Oct 2025 04:25:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vDIXt-0006ue-UD; Mon, 27 Oct 2025 04:25:44 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59QMFVAB021966;
 Mon, 27 Oct 2025 08:25:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=fw9GeX
 qRj2lreeBIq32ovaMfoW/uUlIoDrHT22Ejeag=; b=kHQabNKAFZ19pYWXFNkzR6
 5t/IuF4FfUCz9s0u6+A6cSWn33DEMhbrmjwQinrmQDKBvZ1pdZZeI4L7L7SvNDMR
 qgz+iJIrKUOIb9IF/4BEflzK3Y5uqVNf0fDAq2De7SuLlNp8fxQLk4QonmzagRDL
 OnuBAharBsq9T8OAA3pijEva+sTfkflk4cOF9bGMIwA2XlVNmR3ldgU7lULTfUs2
 xQg+z6yHzNbLUQuxrQl26XCbvL/jtFHXOzCrT0wLNvauwExySPFXVm+eM1Og2yDc
 tQEi5aEuhB1imLhmNu7D6P3q5GJ8AC/98/M2Mh9XUrqmMqf7k+/zQFBHdDPx1/LQ
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a0p81nryb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 Oct 2025 08:25:37 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59R8AlDh009942;
 Mon, 27 Oct 2025 08:25:36 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a0p81nrya-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 Oct 2025 08:25:36 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59R7nNoI029965;
 Mon, 27 Oct 2025 08:25:35 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4a1acjmh23-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 Oct 2025 08:25:35 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59R8PZIk24248984
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 27 Oct 2025 08:25:35 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E2F2A58045;
 Mon, 27 Oct 2025 08:25:34 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0D45D58050;
 Mon, 27 Oct 2025 08:25:33 +0000 (GMT)
Received: from [9.109.242.24] (unknown [9.109.242.24])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 27 Oct 2025 08:25:32 +0000 (GMT)
Message-ID: <21a94013-c3ef-49e4-abfa-a277277a03b0@linux.ibm.com>
Date: Mon, 27 Oct 2025 13:55:31 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL SUBSYSTEM qemu-pseries 0/1] pseries: Update SLOF firmware
 image to 20251026
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Alexey Kardashevskiy <aik@ozlabs.ru>
References: <20251027074404.25758-1-thuth@redhat.com>
Content-Language: en-US
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20251027074404.25758-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=fIQ0HJae c=1 sm=1 tr=0 ts=68ff2c81 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=p0WdMEafAAAA:8 a=M6vYHJULnwh_f0BOw9wA:9
 a=QEXdDO2ut3YA:10 a=poXaRoVlC6wW9_mwW8W4:22 a=oH34dK2VZjykjzsv8OSz:22
 a=Z5ABNNGmrOfJ6cZ5bIyy:22 a=QOGEsqRv6VhmHaoFNykA:22
X-Proofpoint-ORIG-GUID: kMoPzNo-FfVqfj0joEFh4W4WLReSC5Lm
X-Proofpoint-GUID: 72wvDLRe-Rxc9ooKxePAA1GquKUIZacW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI1MDAyNCBTYWx0ZWRfXxgC3n1+DZCVB
 RLP2RebNkE/iuLZaISoFQW7UAUNsScCkoYHPgbPy9TCshT3QCoUHFIuwdQTOdzjEFaAj2DfCPIW
 lxWKSD7M4e/dSS7cyUC5bfZmtZzehaFz46/gtIUd/Zy40vupGUyJcQSu3NRokTwd6BzPFUZLMek
 S33ezdxRfbc2FM9ChMlWS17B4qwIWwn4X54Sg9YUgmYh2jjHCD0aRkCA9oaENYvhYYOmX9hp4B3
 iMFNynH3HoGrzy1/r2axdzeRNdZHjpKusvUzDYXQVHHWiAryNLychUfAfA/c4pjeg1rwVh27rK6
 IEwmWCeM2Ql8xjd85g4Nc79nUoUInMHwP/pg5P5dqB9t9rgQ1r+gtIG8ZqWQUqKhW9R2GpAJx8S
 Zp9AFeP8nUKt18Im8pp0uXu1K+b9NQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-27_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 adultscore=0 suspectscore=0 spamscore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510250024
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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



On 10/27/25 13:14, Thomas Huth wrote:
>   Hi Harsh, hi Nicholas,
> 
> Alexey currently seems to be away from keyboard, so I took care of tagging a
> SLOF release this time. Please merge this into your next ppc pull request,
> thanks!

Thanks for this update, Thomas.
I shall take care of it.

regards,
Harsh

> 
> (Richard, please note: this is not for master, this is for pseries)
> 
> The following changes since commit 88b1716a407459c8189473e4667653cb8e4c3df7:
> 
>    Merge tag 'pull-target-arm-20251023' of https://gitlab.com/pm215/qemu into staging (2025-10-23 13:17:27 -0500)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/thuth/qemu.git tags/qemu-slof-2025-10-27
> 
> for you to fetch changes up to 371c87b3ef298b0a2b6333943134779337d3a7cd:
> 
>    pseries: Update SLOF firmware image to release 20251027 (2025-10-27 08:09:51 +0100)
> 
> ----------------------------------------------------------------
> - Fix some measurements in the TPM code
> - Fix for compiling with GCC in C23 mode
> - Silence some initializer-string warnings with recent GCC
> 
> ----------------------------------------------------------------
> Thomas Huth (1):
>        pseries: Update SLOF firmware image to release 20251027
> 
>   pc-bios/README   |   2 +-
>   pc-bios/slof.bin | Bin 996184 -> 994176 bytes
>   roms/SLOF        |   2 +-
>   3 files changed, 2 insertions(+), 2 deletions(-)
> 

