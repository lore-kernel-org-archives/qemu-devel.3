Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAE1BE9410C
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Jan 2026 06:46:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vbCRf-00072O-Nf; Thu, 01 Jan 2026 01:46:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vbCRY-0006xT-95; Thu, 01 Jan 2026 01:45:57 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vbCRW-0003G2-KL; Thu, 01 Jan 2026 01:45:56 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 6014SCHD005967;
 Thu, 1 Jan 2026 06:45:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=FIEUP8
 xgWGB5GA31Nrvr8a1WC4FC0h7rdeslxfM0yyQ=; b=otwsLdUJ4UmWHKzVM2EbqZ
 YwfkAPaXCOYtz9n6vIslOoMaQM7yZfGxhPWZQulQuVAlIsC57tlY4sD/uTmRr3u1
 tI7PlMdXor0cU0rdXZtxSbDyi/51P2llKDlpjnjHu2yOIFRUtL1zFcXOPl4yc5Wp
 dRUisiMBzeHka6Ba2skZomax2evmrnxA8XULqn5TOJbccqvorqeB8dK+7VU5OSKV
 pQEwVFq62Jk4L8HwvFgZbbD1tcwWiimeBzoUC2YgCHGpgAWKzOramFuA+WVLsOx/
 yQ5Na/t4wLyncBzuYx6kU370Ge3VFJwkSUDK9Qmknx4Fqw6dhiUuGNQHEXeQ2rZw
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ba73w0mvw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 01 Jan 2026 06:45:50 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 6016joF2020937;
 Thu, 1 Jan 2026 06:45:50 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ba73w0mvu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 01 Jan 2026 06:45:50 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6011Qm4q025077;
 Thu, 1 Jan 2026 06:45:49 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bau9khmdp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 01 Jan 2026 06:45:49 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6016jjWm38142254
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 1 Jan 2026 06:45:45 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 78F6D20049;
 Thu,  1 Jan 2026 06:45:45 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5CB1720040;
 Thu,  1 Jan 2026 06:45:43 +0000 (GMT)
Received: from [9.109.199.210] (unknown [9.109.199.210])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  1 Jan 2026 06:45:43 +0000 (GMT)
Message-ID: <41ece6d5-e211-4b32-ab87-d1fe5f359228@linux.ibm.com>
Date: Thu, 1 Jan 2026 12:15:42 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ppc/pnv: Add dummy MMIO support for OCMB chips
To: Caleb Schlossin <calebs@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, npiggin@gmail.com, milesg@linux.ibm.com,
 rathc@linux.ibm.com, chalapathi.v@linux.ibm.com
References: <20251224142249.1356424-1-calebs@linux.ibm.com>
Content-Language: en-US
From: Aditya Gupta <adityag@linux.ibm.com>
In-Reply-To: <20251224142249.1356424-1-calebs@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: P-MH_6H3G6OUuGiVVRJp-GKhtwrGuEgE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTAxMDA1NCBTYWx0ZWRfXy9CdgNW/iD73
 u/sd+uAHPlVSTVnfIRCLwQNyaUscKUX9xipK4OKRssZI1B9a8mWxtEyAHbzXp4SLrVDRYPqza1n
 LXDFBGON6/x7K0bqcsxmvYnQ6PzUcRI5lDbzSpqQzRpvw0XaGfV1/mazFf0YuA5nh45CO9vFv5E
 K4FKTCReFoWcV3uXZN1PHQswG7u9S1mXyPUFpKekczWkFwLq0TcADQzpwWZc+mpDxZWyuWsICbO
 /dEn6wxYM3ImvILgO6/BQa08Ei7vhRhtl8e6NvG0nBhcQk0mu7+8Hhr7qPcKY8D3EScLX7W5OyU
 tRC9yHaFJ7OnlXBeUHX1r9BY5/HHKPz/UQjzoi/9UfTeBnbgsAIC8S/yDf0FfGUa7hy7epzgNSq
 703FQ895DaJQKZQa5zgaasB+X5snaB2ItuTlYBZYpvGySP3340WCxEm//ro5o9zxXGkXh8+eT14
 Pe6WGBQSa/uRn/iP/NQ==
X-Authority-Analysis: v=2.4 cv=fobRpV4f c=1 sm=1 tr=0 ts=6956181e cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=D4yLe6ciAAAA:8 a=VnNF1IyMAAAA:8 a=N2-0zKC2n98ZbhYZ008A:9 a=QEXdDO2ut3YA:10
 a=RJBimmv2CioV9QQA5JKZ:22
X-Proofpoint-GUID: Xk6aFjhGekd_duXxppZOY93LziX-twGp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-01_02,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 adultscore=0 malwarescore=0
 spamscore=0 bulkscore=0 impostorscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2601010054
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
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

On 24/12/25 19:52, Caleb Schlossin wrote:

> The Power Hypervisor for P10 expects to be able to access certain
> Open CAPI Memory Buffer (OCMB) chip registers.  Since QEMU does not
> currently support these registers, several access errors are being
> posted.  The hypervisor is able to progress despite these errors,
> but it does create unwanted noise on the console.  Adding some
> dummy MMIO support for this IO region in order to suppress the
> error messages.

Hi Caleb,

If there any public document/spec available that documents these 
registers ? Can you please point me to it.

I don't find any 'ocmb' mention in any docs here: 
https://computeexpresslink.org/resource/opencapi-specification-archive/

Since a new TODO is getting introduced here to implement those register 
accesses, it can only be done if some public information is available.


Thanks,
- Aditya G


> Signed-off-by: Glenn Miles <milesg@linux.ibm.com>
> Signed-off-by: Caleb Schlossin <calebs@linux.ibm.com>
> ---
>   hw/ppc/meson.build        |   1 +
>   hw/ppc/pnv.c              |  10 ++++
>   hw/ppc/pnv_ocmb.c         | 103 ++++++++++++++++++++++++++++++++++++++
>   include/hw/ppc/pnv.h      |   3 ++
>   include/hw/ppc/pnv_chip.h |   2 +
>   include/hw/ppc/pnv_ocmb.h |  38 ++++++++++++++
>   6 files changed, 157 insertions(+)
>   create mode 100644 hw/ppc/pnv_ocmb.c
>   create mode 100644 include/hw/ppc/pnv_ocmb.h
>

