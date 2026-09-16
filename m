Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B47C6C88E5C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 13:33:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6pkw-0005Jt-0H; Wed, 16 Sep 2026 09:32:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1x6pkl-0005JH-CO
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:32:48 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1x6pkj-0004ed-Lj
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:32:47 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68GCVaFv3753132
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 13:32:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=V46Kdo
 3AFgpilTcn2otCqSVAtL9T3M940/6Vk/k3W9I=; b=i+8SZCGWIhPn64R9H2lM1y
 fLJTqTfZCoKclVj+GH7oXMY87YCuL0PJy4HWXG+gui3rsTLdm0stsZMFKvmOGVnV
 nZqlofLmO+AFNc1n1xf8Ny/vhR02POSKNIfLk93DDexnMiRBnmtnfoaF+50CNZ3l
 bNMrpqRmf4ldd+D9+EhYJl7CRW7QyHa/eM0KgQFLwbc5mSXkq+mlQOZGBgy5/oW5
 UYAgxPgRaYfztTEEcVat9i8/P+5W4wsM/jKxfnAdGnk7dNgfLo5AoFo87ISE+/XB
 qUxLHDPBUW+nk85kacY1jHzm9vFFKg8PtJnnYxvIC2uVbxMYNsI6qxWZNIHk5qzQ
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmx83vstd-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 13:32:42 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68GCZSwN1404907
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 13:32:41 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gpyxsejpu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 13:32:41 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68GDWemW33555034
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 13:32:40 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 855B15805F
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 13:32:40 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 533C158059
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 13:32:40 +0000 (GMT)
Received: from [9.61.190.118] (unknown [9.61.190.118])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTPS
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 13:32:40 +0000 (GMT)
Message-ID: <3c9449f1-859e-4a4f-a55f-a62d566ab126@linux.ibm.com>
Date: Wed, 16 Sep 2026 09:32:34 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/17] Revert "tests/tcg/meson.build: implement
 ./configure containers options"
To: qemu-devel@nongnu.org
References: <20260916085341.1692742-1-alex.bennee@linaro.org>
 <20260916085341.1692742-4-alex.bennee@linaro.org>
Content-Language: en-US
From: Jared Rossi <jrossi@linux.ibm.com>
In-Reply-To: <20260916085341.1692742-4-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDE4MSBTYWx0ZWRfX1fbGRdK2XK+U
 PeqZfDYy1B/c3iVPlaYSMTeGlZsLEM1OHwDzw+qUHSGqS3fKZW1L4qi1J74yDoGSmxCxNFsApMG
 KZTDllq9i7GvJxKe2JILeslAmhjqS2Fhk87DnySogYXO2+DqgRBWfmhaB0gLkMYHC7VWZsMd038
 gW6nLM81E9ExpJYupj+4/H0FSyTiUxA8PaJI4zXOiSo+THU5VjSCO2Xj1TAZCCdFbSi94MQg5tL
 jSIzC8KbuCr5Fy4yrWs0NrXBcfFNUXbbbhe19TfhFND9qHY0N7BSGG9X81xBZqBsERq5KfXaqU6
 EvioruvyI75oQEigbwsmBvzdbjXtAIDHZXsBrX7/BUmchj6x8tB99CW1CzEFjvurmnluvjbOx6K
 YjV+PXEucoAQL6IB0ftLWQyQULuWafxi5dMYL0Ovq0gT45cgmlyZO/K6QcHr56U/IQVOr5LyGf5
 g96QZjUvkqtic4ob/nw==
X-Proofpoint-ORIG-GUID: VXQ9XfhL7Doz1EDIjB87lmsfk9WA5A1n
X-Proofpoint-GUID: VXQ9XfhL7Doz1EDIjB87lmsfk9WA5A1n
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDE4MSBTYWx0ZWRfXwOszt3BXmO73
 pPb9SBzzA1JSuJz6GGXhL0xjBaNZLz63fzTlQ23/DhspEBgoOSaaXhMl+j+QZq10cmw7wQDBmZa
 8dtM3yJ/QMaVjEzFyOYjLsDMZd0XZOQ=
X-Authority-Analysis: v=2.4 cv=cY9HPXDM c=1 sm=1 tr=0 ts=6aaa9a7a cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=KKAkSRfTAAAA:8 a=8rnvzito3NIrx3zvT80A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-16_02,2026-09-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 impostorscore=0 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609160181
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jrossi@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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



On 9/16/26 4:53 AM, Alex Bennée wrote:
> We want to keep the container configuration inside configure for the
> firmware builds.
>
> This reverts commit 522b299ca4316d8cad57f9496ffcba87dcc20719.
>
> Tested-by: Eric Farman <farman@linux.ibm.com>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> [AJB: untangle changes since]
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   configure             | 11 +++++++----
>   meson_options.txt     |  4 ----
>   tests/tcg/meson.build | 25 ++++---------------------
>   3 files changed, 11 insertions(+), 29 deletions(-)

I've verified the s390-ccw.img is building again on real s390x hardware with
the reverts applied. Thanks again.

Tested-by: Jared Rossi <jrossi@linux.ibm.com>


