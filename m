Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30ACDC55179
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2026 11:41:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wqr30-000460-Pn; Mon, 03 Aug 2026 07:41:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wqr2y-000459-Dl; Mon, 03 Aug 2026 07:41:32 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wqr2w-0002n0-Ro; Mon, 03 Aug 2026 07:41:32 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 672LnWSb247209; Mon, 3 Aug 2026 11:41:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=nXxGcv
 ShCQ13G+7hVuAX++42RuwQ3nFfyUrJGl+1tR4=; b=hyV7QuRjcnPYNCnWp2mhaB
 JH0QccyVAN8HC4l1CZdtFtuTCp1lddU3A3Q48zTuHJB26Jdy6PtTnAGQYQVAi95A
 OT2BP1NmAeXEzjarTcwK+ybz6ufnXQ4IV966rzvd3Opzwio0tT4Jo1A9+PpdRyiB
 aJZjZxLyLynO2XgpCmOYTGzZhf8r303bA9kyWDkmAXn4h+ahD6JPSgUpN2bsGqqB
 Mi5Cb26gahVcnuORnydtru174kP3QShmi8l3O/xmV+XAPaBWdoEaG3QqhnD1EsdM
 Ez61OYybo4mZ8sB0r+6oe5Nep0+HpHVbkcZx5GKsy3eF+gKQw+P24zd6oFvsB0hg
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8h4rfn0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 03 Aug 2026 11:41:28 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 673BQO9H021506;
 Mon, 3 Aug 2026 11:41:27 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fsu4qdag1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 03 Aug 2026 11:41:27 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 673BfPfO26935646
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 3 Aug 2026 11:41:25 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5CC7D2004B;
 Mon,  3 Aug 2026 11:41:25 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1EF6E20043;
 Mon,  3 Aug 2026 11:41:25 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.111.49.55])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  3 Aug 2026 11:41:25 +0000 (GMT)
Message-ID: <64d3985d-6dbc-492c-9881-99bb87038e7a@linux.ibm.com>
Date: Mon, 3 Aug 2026 13:41:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/14] target/s390x: Convert op_ld16u to op_ld
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, philmd@oss.qualcomm.com
References: <20260731185628.23161-1-richard.henderson@linaro.org>
 <20260731185628.23161-5-richard.henderson@linaro.org>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20260731185628.23161-5-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDEwMSBTYWx0ZWRfXyuKhs1i4OY5d
 iIxDeOd/2CzHsIs7h+gVZyrZc/MOlilxwzTASXArTJFQUQqIOGKb/pLafCXh9SsqQ7s7Ht/gfG5
 FjaXkVVuIxgmpD51ZxPi4qtRUGwM3C4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDEwMSBTYWx0ZWRfX2ecv+vyIn/Tn
 NdSDwidlFgXIpTUdt3RpZ0FPjknhlz54pg3LPYClxb47qKH9EQyp7wwQ0mx68fKwXKUhMFapmYb
 l7WaoLDoTD9tb0VI3q6QkMh2xxPI8e9d2A8n+Sgb1BFFUQOgr3Mig6SYyYMsn8MksX6FjyY4udf
 wTxmtqJ2D98arB7/uQfm1qsAprPs/g165KrhG5R8pqQl7z2vyZm+2sKWS3ivQqYAARqfa1KNZQp
 v8j4Urf0i2rxCQo+3AQepfjX2TcEhVjW/801Fd8A7hSEVJUtQw6phOXku+e+Pf3x/CrFIwiFr2f
 39I3oRLgphnN1UupP2emTWM2JNopP+M+orZqD/4mTVqRdLs9SynodgMrtDCYUzopaUfZz6oMzw1
 gaWrPQgIbc7S/GsDFL2vOUg9dDjEl4aDs0TwZnpsUOdS3sepngKtSxIUQUbZ5GWcQQ3Npwg8gS1
 Xg0dCRzeeb0ntsNy1AA==
X-Authority-Analysis: v=2.4 cv=SI1ykuvH c=1 sm=1 tr=0 ts=6a707e68 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=KKAkSRfTAAAA:8
 a=VnNF1IyMAAAA:8 a=vtlFLEGkmGI1kn2-6cgA:9 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: 9pmbaXxb4opZcWEqmtK6LttPInMOCXqG
X-Proofpoint-GUID: 9pmbaXxb4opZcWEqmtK6LttPInMOCXqG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_06,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608030101
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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



On 7/31/26 20:56, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/s390x/tcg/translate.c     |  6 ------
>   target/s390x/tcg/insn-data.h.inc | 10 +++++-----
>   2 files changed, 5 insertions(+), 11 deletions(-)

Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>



