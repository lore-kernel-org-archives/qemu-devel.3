Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7341ECAC597
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 14:07:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uy9po-0005z6-Qn; Mon, 15 Sep 2025 10:05:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1uy9ph-0005yT-8M; Mon, 15 Sep 2025 10:05:29 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1uy9pY-00055e-Ay; Mon, 15 Sep 2025 10:05:29 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58F9Oqix017396;
 Mon, 15 Sep 2025 14:05:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=qgWSX9
 9VZFRhWhIB2ZDF6xfHfLDWlM0aqT+PbWrj+w8=; b=LMPguguKddgOxnOZL/Gn8/
 6gjgU50VB8LKmxgG7g/CXbKrYG8ZAYDs1iIfT9O6uwjIv7u2spLg0gTL/MpHCOvc
 6lFbPBHrLOVasszxM9vQjmaME1nwaiX80nL7JD2R6zA6F4YLPUUJZZvXxMI8cppr
 NPXpdTnroTNA+9l6JjxdPtUbj3HjHq/5cxvYBK3iFaLV9AzGlhfYttvnGceXzn7B
 wS9pbX3607mvk3DmZ4yFlv10ADDErmrDcnMyf8y+Qf8D3uvP13M4Gk3i5BrEK5nX
 d7Alh5DZj86uT/dJCuUoIidlXh7Gn6rt7Tfl67UeyuEfuF6wJGBK9wkkNvVuvfjQ
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 496g531e89-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Sep 2025 14:05:00 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58FDrtoN008785;
 Mon, 15 Sep 2025 14:05:00 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 496g531e85-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Sep 2025 14:05:00 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58FAkOnh005929;
 Mon, 15 Sep 2025 14:04:59 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 495jxtxyhq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Sep 2025 14:04:59 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 58FE4xOx30212810
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 15 Sep 2025 14:04:59 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0A08B58059;
 Mon, 15 Sep 2025 14:04:59 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C2E1B58043;
 Mon, 15 Sep 2025 14:04:56 +0000 (GMT)
Received: from [9.124.211.248] (unknown [9.124.211.248])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Mon, 15 Sep 2025 14:04:56 +0000 (GMT)
Message-ID: <2a190136-e530-4527-a7b6-be7b66d31ceb@linux.ibm.com>
Date: Mon, 15 Sep 2025 19:34:53 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/ppc: use MAKE_64BIT_MASK for mcrfs exception clear
 mask
To: Denis Sergeev <zeff@altlinux.org>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, npiggin@gmail.com, harshpb@linux.ibm.com
References: <20250915080118.29898-1-zeff@altlinux.org>
Content-Language: en-US
From: Chinmay Rath <rathc@linux.ibm.com>
In-Reply-To: <20250915080118.29898-1-zeff@altlinux.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: pzRmrmH3ODXStZbmaA7AmoXe3EB7kWdC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE1MDA4NiBTYWx0ZWRfX1YSLGkVZaKEw
 9DgDqcI2JF+pzqTez0ZBno7J5B72IK5A40LX4okzQOfxksvxAp8SnIL/a8jOPG9h21brxPVW4Q7
 Ub2BmyKA+cdByz9aiMV5PnLioyJMm+I/UEZJgjvWiCN7Lubje7+kAK0Lq6NLDVzqQ7nSCFnIY7L
 b81EIlSHjhkewfXIG4/0Dep6Wfw00KYGYMBKc6Yy4391Q09i2iiL2w2E5GZZ5jpWFHQlKQfaly3
 vDd/wImyiTPEHvYXTkLs4Fd0mq2voOdOe5DGLq/EyFNREqX3zr9NRywdSZRLXQUGP7J2ePy16dh
 4tw1ZL9461txbsqpz+g+mExh9eonG+Sfm6RjDYtOl4qQbA5+/FPQt2JxXOuxgFf86XBxbyqgo9u
 v2xQVXi8
X-Proofpoint-ORIG-GUID: JIlM_jWxHCMsKv2q5px5iLNlAxijhBzP
X-Authority-Analysis: v=2.4 cv=UJ7dHDfy c=1 sm=1 tr=0 ts=68c81d0d cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=HH5vDtPzAAAA:8 a=bH78PYQqAAAA:8
 a=VnNF1IyMAAAA:8 a=Ep-lmh4anQmmBnzUv6oA:9 a=QEXdDO2ut3YA:10
 a=QM_-zKB-Ew0MsOlNKMB5:22 a=TrXR8j8ql9YpJ1_1srv2:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-15_05,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 impostorscore=0 spamscore=0 priorityscore=1501
 clxscore=1011 suspectscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509150086
Received-SPF: pass client-ip=148.163.158.5; envelope-from=rathc@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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


On 9/15/25 13:31, Denis Sergeev wrote:
> In gen_mcrfs() the FPSCR nibble mask is computed as:
>        `~((0xF << shift) & FP_EX_CLEAR_BITS)`
>
> Here, 0xF is of type int, so the left shift is performed in
> 32-bit signed arithmetic. For bfa=0 we get shift=28,
> and (0xF << 28) = 0xF0000000, which is not representable as a 32-bit
> signed int. Static analyzers flag this as a potential integer
> overflow.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Signed-off-by: Denis Sergeev <zeff@altlinux.org>
> ---
>   target/ppc/translate/fp-impl.c.inc | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/ppc/translate/fp-impl.c.inc b/target/ppc/translate/fp-impl.c.inc
> index a66b83398b..d01c0b5aba 100644
> --- a/target/ppc/translate/fp-impl.c.inc
> +++ b/target/ppc/translate/fp-impl.c.inc
> @@ -479,7 +479,7 @@ static void gen_mcrfs(DisasContext *ctx)
>       tcg_gen_extu_tl_i64(tnew_fpscr, cpu_fpscr);
>       /* Only the exception bits (including FX) should be cleared if read */
>       tcg_gen_andi_i64(tnew_fpscr, tnew_fpscr,
> -                     ~((0xF << shift) & FP_EX_CLEAR_BITS));
> +                     ~(MAKE_64BIT_MASK(shift, 4) & FP_EX_CLEAR_BITS));
>       /* FEX and VX need to be updated, so don't set fpscr directly */
>       tmask = tcg_constant_i32(1 << nibble);
>       gen_helper_store_fpscr(tcg_env, tnew_fpscr, tmask);
Reviewed-by: Chinmay Rath <rathc@linux.ibm.com>

Thanks,

Chinmay


