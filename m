Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E944DCCF9F8
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 08:29:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEO0d-0005gu-Rv; Thu, 30 Oct 2025 04:27:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vishalc@linux.ibm.com>)
 id 1vEO0S-0005MY-6q
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 04:27:40 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vishalc@linux.ibm.com>)
 id 1vEO0F-0004cZ-L2
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 04:27:36 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59TLCjHY031318;
 Thu, 30 Oct 2025 08:27:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=VbwqFx1XzJj6X9Cwc5cBaUtMf85k7m
 0gAr/0fAcfhLI=; b=Cbb5yju70Dpk2r2bdKK/dgiBhNZp+oZn5jK1/SPFl5w1eW
 Ph1yHxOOyuHYr0jrVOG4qDK1KiWsoIE5aSSTQU6z3vr3rcyg66hZfrrRRtJmukUm
 6F9FyBLVywKm2MOSETUJELg3Wu3Y1bFTE2LtjOAbdFb0ikgX7DFcCyFFORJEVMDN
 Dnu3cwKNhviPxVae1/3giuKb8gtcQxjNTgs22AAg4YYiDfvdBsGt1E4YKXl4tosm
 hf17g+4I46slIqW3ER6Zmuqsq0P4VC7YoZGTofwKZNNBZhb6id2OJfLk2UORHEu0
 HNPaB3kpsQGlsy+Hx948IfXVYHKZTB3a9qa2clvg==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a34ajq3tf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 Oct 2025 08:27:23 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59U8KbHF006625;
 Thu, 30 Oct 2025 08:27:23 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a34ajq3td-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 Oct 2025 08:27:23 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59U5jTRd030817;
 Thu, 30 Oct 2025 08:27:22 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4a33wwqjx3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 Oct 2025 08:27:22 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59U8RKB135062204
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 30 Oct 2025 08:27:20 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7DCBB2004D;
 Thu, 30 Oct 2025 08:27:20 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 453AE20040;
 Thu, 30 Oct 2025 08:27:19 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.39.29.245])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Thu, 30 Oct 2025 08:27:19 +0000 (GMT)
Date: Thu, 30 Oct 2025 13:57:16 +0530
From: Vishal Chourasia <vishalc@linux.ibm.com>
To: alistair23@gmail.com
Cc: philmd@linaro.org, alistair.francis@wdc.com, qemu-devel@nongnu.org
Subject: Re: [PATCH 2/3] hw/core/loader: Free the image file descriptor on
 error
Message-ID: <aQMhZI6IbW0xtQrv@linux.ibm.com>
References: <20251030015306.2279148-1-alistair.francis@wdc.com>
 <20251030015306.2279148-2-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251030015306.2279148-2-alistair.francis@wdc.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=C/XkCAP+ c=1 sm=1 tr=0 ts=6903216b cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=pGLkceISAAAA:8 a=JF9118EUAAAA:8 a=VnNF1IyMAAAA:8 a=Z_iCKnEW5LszyYjgeLUA:9
 a=CjuIK1q_8ugA:10 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-GUID: JN7iyJtylqIIaoApmF2nbkkvXTCMEzPt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDE2NiBTYWx0ZWRfX24XPCpkfyn4o
 7Qkr5tWtmAjNh/3fvkjBKdhcMDfuoTtIVTdFHl9qwRCg4TbpjAumVXnMwMWp4HX0VH0u0ou09dt
 bx/VLIdioVcpNrCNzhvnPuOh0d1XvLi2CAQXfjMcO5wM/IXX+tEZhRR8xD2KThsMN32HbxP58Au
 BROedqbs8vViEXDvmsD4Po+pnMcnYvhmxg7haGaYOO6YWemBkPnWNekUC71w/E8/g7h9CFii4wg
 2TOwhJvK7f6fCGFr22ePDu9z0/7HJhPc1f2fJN299+vV7NGjvPR+oEw8N57MpViJlMtBrtBTBfw
 02IC7IzbdJx06hPhC63k6xemNJRCgXzze9NHHAGpFSRMW+Qpy5xGgFXI/O2YUsnjk464VNT8/MT
 sK41yY+bBjKY79KIb9jqMNwj8jecfA==
X-Proofpoint-ORIG-GUID: IU3LBihIxQsFnOu-J2aMKHkt6_MQv1sU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_02,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0 suspectscore=0
 spamscore=0 phishscore=0 malwarescore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2510280166
Received-SPF: pass client-ip=148.163.158.5; envelope-from=vishalc@linux.ibm.com;
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

On Thu, Oct 30, 2025 at 11:53:05AM +1000, alistair23@gmail.com wrote:
> From: Alistair Francis <alistair.francis@wdc.com>
> 
> Coverity: CID 1642764
> Fixes: f62226f7dc4 ("hw/core/loader: improve error handling in image loading functions")
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  hw/core/loader.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/hw/core/loader.c b/hw/core/loader.c
> index 73564a2a46..1598dca03c 100644
> --- a/hw/core/loader.c
> +++ b/hw/core/loader.c
> @@ -86,6 +86,7 @@ int64_t get_image_size(const char *filename, Error **errp)
>  
>      if (size < 0) {
>          error_setg_errno(errp, errno, "lseek failure: %s", filename);
> +        close(fd);
>          return -1;
>      }

Reviewed-by: Vishal Chourasia <vishalc@linux.ibm.com>

>  
> -- 
> 2.51.0
> 
> 

