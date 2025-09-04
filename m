Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD1E3CA1002
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Sep 2025 12:28:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uu94B-0006lk-Ud; Thu, 04 Sep 2025 08:27:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1uu947-0006kl-SG; Thu, 04 Sep 2025 08:27:47 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1uu942-0000xg-SC; Thu, 04 Sep 2025 08:27:47 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5845Wt34007509;
 Thu, 4 Sep 2025 12:27:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=O3nS0z
 JbOzPPZzTnYrr98CIRWqcEXdWe/4Em7Gzhpc8=; b=a+SArT/6gi6EHTG4fpUmQa
 nddUHZj00uxbl/DPiO8j4IdsRr61Icup0sQi6658xEgq4EtFj8RLigInph7OdySB
 PLZZLwyvCsesjObXycJ2PKTS9noPUI44I3bECsRAnE1+by123bqTfD5syoTZr1zR
 02sMOJGyjGIEX4iOli/Gck+U73s9cwsNknvabfoMCkWqQDwoP+iGXE7Z8+/YbU8g
 I1ZrB+RiachvfvJxjBoSJGbsSVR7PC1xgs5PiGn1UFtdgQBdCouF6WUpjwpJfmKj
 GMJsewnZwqSQ3rd2lyRu4Vd9UMYVXougX6ysAIme3ZZPbbMtg1erAtZ7PDM/4PVg
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48usua9jqm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 04 Sep 2025 12:27:36 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 584BxfF9001750;
 Thu, 4 Sep 2025 12:27:36 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48usua9jqk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 04 Sep 2025 12:27:36 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 584AmBAL017612;
 Thu, 4 Sep 2025 12:27:35 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48vc10vhu7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 04 Sep 2025 12:27:35 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 584CRZc530016018
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 4 Sep 2025 12:27:35 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 397AC58059;
 Thu,  4 Sep 2025 12:27:35 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2C97A58058;
 Thu,  4 Sep 2025 12:27:33 +0000 (GMT)
Received: from [9.124.217.170] (unknown [9.124.217.170])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Thu,  4 Sep 2025 12:27:32 +0000 (GMT)
Message-ID: <34a07eb8-aa60-4a2d-ad6d-2d01c8c52a7d@linux.ibm.com>
Date: Thu, 4 Sep 2025 17:57:15 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] target/ppc: Move floating-point compare instructions
 to decodetree.
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, npiggin@gmail.com, danielhb413@gmail.com
Cc: harshpb@linux.ibm.com
References: <20250619095840.369351-1-rathc@linux.ibm.com>
 <20250619095840.369351-3-rathc@linux.ibm.com>
 <7857ae80-63eb-4d18-9618-d6c94cdd0c17@linaro.org>
Content-Language: en-US
From: Chinmay Rath <rathc@linux.ibm.com>
In-Reply-To: <7857ae80-63eb-4d18-9618-d6c94cdd0c17@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 0ohFY4OtpA37cJe2UeNF-nn2_mMLqtTf
X-Authority-Analysis: v=2.4 cv=U6uSDfru c=1 sm=1 tr=0 ts=68b985b8 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=KKAkSRfTAAAA:8 a=mlNPLL8VfqrMOjWHYDEA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzNCBTYWx0ZWRfX0pOH+RES25sj
 9IknuyJC/gJuvgd+kC5B7qxEGfrh4IBBepPbcoXIONJCEHSx/p70aNctHLuRVyHRtHT6RkIJkKs
 806EuTnPStVr5HtEc9npxPFd4UtFDbsIsapTeKZhnKHnEOHT/GqiLNGRThz+3hXP5pWc6pwagzl
 lsduzReZK3FW8CGlVdlpMScDgnGAEvboifDzB+1/RzRddRNCCTNL/sy2hOiLDtSKLOeikN6dRpT
 tNunMB4YujkuTSf3KestUp45LGp5IImRB7a2VHLrfm65gHz5OeEoK5tVp54kWfOkH0jI0mbTicd
 ohz/aSb81+FTXdeEN+uMfFsWuW6cLBwUb1zI5rBET/uQc58eux/OTnPk6y1eWT+DrdIeqMbBGaH
 SjOd1BrP
X-Proofpoint-ORIG-GUID: 6vHVtv6nXF931W442KMs6LXkVaLHl4ot
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_04,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 adultscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 spamscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300034
Received-SPF: pass client-ip=148.163.158.5; envelope-from=rathc@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


On 8/27/25 12:49, Richard Henderson wrote:
> On 6/19/25 19:58, Chinmay Rath wrote:
>> +static bool do_helper_cmp(DisasContext *ctx, arg_X_bf *a,
>> +                          void (*helper)(TCGv_env, TCGv_i64, TCGv_i64,
>> +                                         TCGv_i32))
>> +    REQUIRE_INSNS_FLAGS(ctx, FLOAT);
>
> ...
>
>> +TRANS(FCMPU, do_helper_cmp, gen_helper_FCMPU);
>> +TRANS(FCMPO, do_helper_cmp, gen_helper_FCMPO);
>
> It's probably better to standardize on TRANS_FLAGS even though the 
> flags checked is the same for both of these.
Oooh yeah, should absolutely do this. My bad I missed.

Thanks,
Chinmay
>
> But anyway,
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>
>
> r~

