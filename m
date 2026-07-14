Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFAEEC43458
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 12:31:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjcIZ-0004Wl-Rf; Tue, 14 Jul 2026 08:31:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wjcIY-0004WO-8m; Tue, 14 Jul 2026 08:31:42 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wjcIW-00061D-UQ; Tue, 14 Jul 2026 08:31:42 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66EBfxF11195041; Tue, 14 Jul 2026 12:31:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=G8Dxo0
 MpK88fylkJIJ3K1mG8PcFruZu58aQIq+mV6Zs=; b=PZZcaEueBVZxIatdsZI6j8
 AFW+QETGoSytTKgnksjL5TEVys79CeIRFGMtAGrOGXQOcqY3377i/ETeSRQgKPnY
 cnK97R01JkkoOV0d3WdUlFqikSQCKhP/60rBkGuHf9aaY3U+EAeLMIUwiwXd9Vh2
 2Oolh1UJnlCYuqnuJ4jCescAv0rS8etRKi8T6g9v0WfdpeG4GdvcmAYXI5phl7tu
 YotZf2tJQtvSxefLjoVuor7B4R+ogtXJXNxoJL8TmlrzAOS1XkVKfTJRWEUFmeJj
 CgNcHboavsyzWptwFcvLLDprpm00e65KGFu+czi3iJYqNyyqJDbpoCnZhlJaN8wA
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbegbnn88-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Jul 2026 12:31:37 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66EC4cY1008454;
 Tue, 14 Jul 2026 12:31:37 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fc0hw2v7x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Jul 2026 12:31:36 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66ECVY7L57868776
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 14 Jul 2026 12:31:34 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BBEAE2004E;
 Tue, 14 Jul 2026 12:31:34 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7C74B20040;
 Tue, 14 Jul 2026 12:31:34 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.111.75.242])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 14 Jul 2026 12:31:34 +0000 (GMT)
Message-ID: <ab04cf16-78c8-4acb-b128-1ebb545f601b@linux.ibm.com>
Date: Tue, 14 Jul 2026 14:31:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/51] accel/tcg: Pass CPUBreakpoint to
 debug_check_breakpoint
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, jcmvbkbc@gmail.com
References: <20260710205401.836304-1-richard.henderson@linaro.org>
 <20260710205401.836304-9-richard.henderson@linaro.org>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20260710205401.836304-9-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=fOcJG5ae c=1 sm=1 tr=0 ts=6a562c2a cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=KKAkSRfTAAAA:8
 a=VnNF1IyMAAAA:8 a=DBjf2mWvJUT8b9tJvREA:9 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDEyNyBTYWx0ZWRfX/786Xynj0BA2
 7s9c3SO7SIRiOH+uhs8E/A0yg7YYxRFW9RgYLlBmgxLuxzaDYoXGlA1XM6CGQ99WYU9ETuZQ+jk
 Si8cskE0mrhfOmMivXguE3S0t44wXyFwOtpmJO6y2pN2lNDa7JEv8WwUf9aq5sXwP3smodi+VVG
 GMQxWWMBAOPYdWTV1rgp7KUGk87RvMchnVINUHKhRhJRe+nzPD9kLtfY/KNjCB7Rz9/fne8A0z+
 gBu9PF/QRezUyZi09cWRWG/2wLcR9RC/yOgUNtnNQTwJfh10fDfLQCUmc4o/3OiSDCNC4Pyrm8a
 7EaBrXb9v/odsFpAPwwMDj7VIffB1IyyBXlip6g3QxlXJFoRArTINvE4dHbBmvaNmhkwnXTwu8m
 qgQG+JY8+ag8wjSHgVi+qO7PFTbwQ47TEZgioWjOS32J2pUFA+X5KgW11aOMXirOfUDjpTprCO3
 ul4LBdLWWCy5UIRl+EA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDEyNyBTYWx0ZWRfX505xLkJxllzO
 ohzR680N2y2i3IOVrLndMr9W/Nvfpsw7bQAYjd7y4r+wc+XYaRwETY4azrboK2Yt5rm3MG4k/fi
 sVXqubM4BJAQg1vHltDgLuyIeICm9rk=
X-Proofpoint-GUID: 5DiA-J3iBAwOuRA8uHXvvvi9d74t0NwI
X-Proofpoint-ORIG-GUID: LLA9Bktz273eQnPq2dQc5MnEVatmtpn0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_03,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607140127
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 7/10/26 22:53, Richard Henderson wrote:
> Add the argument and ignore it so far in all targets.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/accel/tcg/cpu-ops.h  | 2 +-
>   target/arm/internals.h       | 2 +-
>   target/ppc/internal.h        | 2 +-
>   target/riscv/debug.h         | 2 +-
>   target/xtensa/cpu.h          | 2 +-
>   accel/tcg/cpu-exec.c         | 2 +-
>   target/arm/tcg/debug.c       | 2 +-
>   target/i386/tcg/tcg-cpu.c    | 2 +-
>   target/ppc/tcg-excp_helper.c | 2 +-
>   target/riscv/debug.c         | 2 +-
>   target/xtensa/dbg_helper.c   | 2 +-
>   11 files changed, 11 insertions(+), 11 deletions(-)

Reviewed-by: Ilya Leoskevich <iii@linux.ibm.com>

