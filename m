Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AFF4CCF9F8
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 08:24:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vENwz-0003f0-Ge; Thu, 30 Oct 2025 04:24:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vishalc@linux.ibm.com>)
 id 1vENwx-0003el-AA
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 04:24:03 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vishalc@linux.ibm.com>)
 id 1vENwp-0003u1-0g
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 04:24:02 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59TM56ek025803;
 Thu, 30 Oct 2025 08:23:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=tCeAV/
 VZ30SfmckP5RQUE2JvXJM0peU8RcDQjj2YEtQ=; b=MfmHG/Z6BKT0Rtd0Ghxcca
 1SAvFiCxhRJEJAdchJ8NTUpIH1ZReZG8MLiYFYPHxoYhlhUOX1ZYkPaYrQ1GYt3S
 gj4E6PGNA2lFHGEFRZ6FCOqy2yUtACXb4mZ60g6rcAubRWZ2BdyIPpC+Qkt/F6ai
 GgPql0VjZBHWK8LWSkcz/YeAvV3vnJQG86suzh+Jw47Gbx86IgY9H2k8Hwj3YD6i
 Ix10JAst0sLqJQGKE7ds/8H1ffuclM+cuviJ4lfkQRA7v4aw3ZFikURhCxU3TVem
 nfM/FC8LIjQjlCu0fTi3lQOXwl5uFehFzjDTG0ZA2xISGMfdx0UEtdXuoQD4OW4A
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a34acqa3j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 Oct 2025 08:23:47 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59U8Nl93023110;
 Thu, 30 Oct 2025 08:23:47 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a34acqa3e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 Oct 2025 08:23:47 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59U63ino031709;
 Thu, 30 Oct 2025 08:23:46 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4a33w07j2h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 Oct 2025 08:23:45 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59U8NiSO30736834
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 30 Oct 2025 08:23:44 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 01BC020040;
 Thu, 30 Oct 2025 08:23:44 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EDEF820043;
 Thu, 30 Oct 2025 08:23:42 +0000 (GMT)
Received: from [9.39.29.245] (unknown [9.39.29.245])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 30 Oct 2025 08:23:42 +0000 (GMT)
Message-ID: <4c0a7894-3cba-4a07-ab56-1ed8f945fd67@linux.ibm.com>
Date: Thu, 30 Oct 2025 13:53:41 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] hw/core/loader: Fixup whitespace for get_image_size()
To: alistair23@gmail.com, philmd@linaro.org, alistair.francis@wdc.com,
 qemu-devel@nongnu.org
References: <20251030015306.2279148-1-alistair.francis@wdc.com>
Content-Language: en-US, en-IN
From: Vishal Chourasia <vishalc@linux.ibm.com>
In-Reply-To: <20251030015306.2279148-1-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=XbuEDY55 c=1 sm=1 tr=0 ts=69032093 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8 a=JF9118EUAAAA:8 a=zOOB0wJHYj3sPiX7G-QA:9
 a=QEXdDO2ut3YA:10 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-ORIG-GUID: YCSN8EMTK1Zd3BzxmCkwt1ZicfhEj2L6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDE2NiBTYWx0ZWRfXx2EEe/pol/ON
 Wco3Q+3+aOtVB9L+x7ZhistHBLwJWuBVCSfoN85lUFpMfHrJMgMZbUS+lcE8Op1ceqlwcRoUQtT
 IjBzkT9SaXlalDuSkRRuZaRSE/5lCZESJcVRAPZEybXPEa3c+Mh37B27cKaHefvpWcU+sCgLoWA
 bi627k+0xyzi3ku2KpQ1BpWWawOYJF7FFvtZB92lraX3bjXr8ZExBjbAw+R2uArdmh2uSobFCcr
 0xedxEcQ2nrr6w6hChHB5OJjISZGCnerYbPcy8/9Th02bYT+8fsZKd+f+k0nBgEu7AuGxX9rEte
 r67fxY4Fmmar0hJGxK45SAMIXf1z4q0bzdopb7ZRi9qSdfK45VnY98j8A4kcZZD5ahzNfmw5G4W
 JOp7rFEUzAkZiikF2h/PTFtHIuyanw==
X-Proofpoint-GUID: M6Qs6MyIoHSbO2W7c70SIXjLlA-knVS7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_02,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 bulkscore=0 spamscore=0
 impostorscore=0 phishscore=0 priorityscore=1501 clxscore=1011
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2510280166
Received-SPF: pass client-ip=148.163.156.1; envelope-from=vishalc@linux.ibm.com;
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

LGTM

Reviewed-by:Vishal Chourasia <vishalc@linux.ibm.com>

On 30/10/25 07:23, alistair23@gmail.com wrote:
> From: Alistair Francis <alistair.francis@wdc.com>
>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>   hw/core/loader.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/hw/core/loader.c b/hw/core/loader.c
> index 590c5b02aa..73564a2a46 100644
> --- a/hw/core/loader.c
> +++ b/hw/core/loader.c
> @@ -75,14 +75,20 @@ int64_t get_image_size(const char *filename, Error **errp)
>   {
>       int fd;
>       int64_t size;
> +
>       fd = qemu_open(filename, O_RDONLY | O_BINARY, errp);
> -    if (fd < 0)
> +
> +    if (fd < 0) {
>           return -1;
> +    }
> +
>       size = lseek(fd, 0, SEEK_END);
> +
>       if (size < 0) {
>           error_setg_errno(errp, errno, "lseek failure: %s", filename);
>           return -1;
>       }
> +
>       close(fd);
>       return size;
>   }

