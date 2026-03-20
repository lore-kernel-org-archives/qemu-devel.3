Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4534D1099B37
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 19:30:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3fXJ-000279-7R; Fri, 20 Mar 2026 15:29:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1w3fXH-000269-PW; Fri, 20 Mar 2026 15:29:31 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1w3fXG-00034j-4A; Fri, 20 Mar 2026 15:29:31 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62KHaWmI1267653; Fri, 20 Mar 2026 19:29:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=FlsIP3
 5ZsIuNQb7MTjMO6yHzL1VNJ0BRilXADPIr3Oo=; b=bq8QXpwoGr/rX17GwHyNyM
 DuUXb09q8SthUI8/K4wOEVSUgfvvpCH3Ixj2FjMURYal6FTkVv1ILXqiczzSrswO
 /HcTneBzlBRQ/QtdEzuTAtFs9l8UYBZkxDoLE7ccKfnyOfpleg07eWoIvam+nd2M
 r0b71tXE+QZnlpk0jKvQ/1wtwlUjF6pJWuqV7FdE7onzn2r1T/tVcWYFhTJ6g8Z9
 lmivlPkxw6vnX4A4YHVv2t7j5wT+US3cwrYj8iG4PIio07EqCkSph/2dUlytlBI2
 8Q/4SkNk8+o2XT6SQPoMEnjVtaof4fAY6JW9RCeuGR1/zyNxuDaL8DEIvAQhrREw
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvybsn6yx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 20 Mar 2026 19:29:09 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62KG5sZZ005412;
 Fri, 20 Mar 2026 19:29:08 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cwj0srte1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 20 Mar 2026 19:29:08 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62KJT6xj30474838
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 20 Mar 2026 19:29:06 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4F77E58051;
 Fri, 20 Mar 2026 19:29:06 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D059B5805E;
 Fri, 20 Mar 2026 19:29:05 +0000 (GMT)
Received: from [9.61.145.197] (unknown [9.61.145.197])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 20 Mar 2026 19:29:05 +0000 (GMT)
Message-ID: <aa77dd3b-f57b-4e84-9c96-0ab0c5afeed3@linux.ibm.com>
Date: Fri, 20 Mar 2026 15:29:05 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mailmap: Update email for Nina Schoetterl-Glausch
To: Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>
Cc: Nina Schoetterl-Glausch <oss@nina.schoetterlglausch.eu>,
 qemu-devel@nongnu.org, qemu-s390x@nongnu.org
References: <20260319142048.917219-1-nsg@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260319142048.917219-1-nsg@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=MMttWcZl c=1 sm=1 tr=0 ts=69bda005 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=EUspDBNiAAAA:8 a=j8RhgVXbAAAA:8 a=1cGLs3X8AAAA:8 a=unkj71DYAAAA:8
 a=FS0upHgUAAAA:8 a=oCJs8q-oAAAA:8 a=KKAkSRfTAAAA:8 a=ggQks4fKAAAA:8
 a=lzDhS8hmAAAA:8 a=VwQbUJbxAAAA:8 a=gPJu0pBYAAAA:8 a=10XLf8JcLYE7KExxsLkA:9
 a=QEXdDO2ut3YA:10 a=3SzYsRL22XtqO3ZTpi69:22 a=d8ghUycwObenwynNfMyN:22
 a=5RyQM4v5J9L3wGZf4tZl:22 a=BQgJtduX4OmZBxSA4osX:22 a=qUF70SbvcHBaGhGVny9j:22
 a=cvBusfyB2V15izCimMoJ:22 a=6g8pSQqS8yRHbJHhMaLw:22 a=rigQk1bY_8VmChEzA3fK:22
 a=AlIIF0cMT2hfDT4axODj:22
X-Proofpoint-ORIG-GUID: kbHYLpNRDMJwK_KJzbRWCCd6Q2kGcCeK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIwMDE1NiBTYWx0ZWRfX/ab/4u4jnYn1
 vFW744zA0mzLYlM/AdQmvVv4bLPmeN2pRClHKBVvDj78Vd/BoaP+MyAvbOnP26OhCqiMLTVgl9+
 1x5o8k5nrc6qQhvsjhsrbNWv4wXaNU7JAwhyfcyE7nhmUtUMWJ8gQLGEGgHnpie1a2SL65Hdm4q
 y1kUx4MLcMiK0rNhgHp9TwS0gxCRAESn3QTylWisN28YK9VXGoxI7PqoAk22PPYlT0IgFsqYdUf
 jpxrwv6SFoht+SbQWWjgYmHSHQ33WfXjiTsyEjdLcNGS/dp2jh8zdzNn0AjviXkoMY0XiU8OQ8q
 mFALfWNDSNtBVA86WwYOFLSzcuTScNLiD06IKcjsMw5km7vrhkrHNNXaHqNOv/G9zwlzwa4RiF2
 NNuuX8tKj/mNvhYilYigYAHApjYZqDoj9+HGum6uY8YKpvqfpyRzil2fiyStFgsyECcTxq2Ht0J
 dAmU92e5b7ADROGwOAg==
X-Proofpoint-GUID: kbHYLpNRDMJwK_KJzbRWCCd6Q2kGcCeK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-20_03,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 phishscore=0 clxscore=1011
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603200156
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 3/19/26 10:20 AM, Nina Schoetterl-Glausch wrote:
> Update to my private email.
> 
> Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>

Thank you, Nina!

If needed:

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>

> ---
>  .mailmap | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/.mailmap b/.mailmap
> index 0690f7be34..383948400a 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -97,6 +97,7 @@ Leif Lindholm <leif.lindholm@oss.qualcomm.com> <leif@nuviainc.com>
>  Luc Michel <luc@lmichel.fr> <luc.michel@git.antfield.fr>
>  Luc Michel <luc@lmichel.fr> <luc.michel@greensocs.com>
>  Luc Michel <luc@lmichel.fr> <lmichel@kalray.eu>
> +Nina Schoetterl-Glausch <oss@nina.schoetterlglausch.eu> <nsg@linux.ibm.com>
>  Radoslaw Biernacki <rad@semihalf.com> <radoslaw.biernacki@linaro.org>
>  Paul Brook <paul@nowt.org> <paul@codesourcery.com>
>  Paul Burton <paulburton@kernel.org> <paul.burton@mips.com>


