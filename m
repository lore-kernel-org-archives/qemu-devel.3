Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FE2FC5B567
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 07:00:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu2w6-0006Ch-Bu; Wed, 12 Aug 2026 02:59:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wu2w4-0006CU-SB
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 02:59:37 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wu2w2-00006r-QP
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 02:59:36 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67C6252k2593470
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 06:59:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 FdJCKwYmMliwecfmmyMZeFIgAyYX34skY9HwVtfYTyM=; b=lAENUsahrTMLLRH1
 Dl4A5l32l2U0Dpdubk8zDDUP+FM4gy3MztROQxem28Q3n9PTXcioKErzwGB9Y/v+
 naarZbYotz00CgTS7B39EcWvpLaPg1XUmQ2LmSRUZ0VznaoOXMjVo9ynj9abI+9/
 IDB3buptFAvAbtBnqFIBxgq5kukEbRvXFv+uuisDWfVGm0lhI6B10+dDhhxDpjan
 HkDNtocJnYrPawNpwREFEFm73y5UUQJxRVRROthUPZmXw7SK7+mLJERY3ZVU0M3G
 +zeanZzRO3tGNxJRKtbZq2m6pV9q2rGnydgWYZ6fW4FOXPOvhUEQCUu4tQMyYNsp
 EcsfRQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g08jrjj5u-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 06:59:31 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93494cce712so49656285a.3
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 23:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786517970; x=1787122770; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=FdJCKwYmMliwecfmmyMZeFIgAyYX34skY9HwVtfYTyM=;
 b=iWqBP3MXbRGMwqoz1UjubH6mYI54uKuo21HNAfVBEKFwyVoZXd2wUqfmgD1H11fMot
 suwNI60uxkYnTKp6RsGOqpjX937nE351CsxVlLZegpmwwZ3h6xIkn5KJX61yKNZp77w3
 dJhxQrYLUBIfqVxvBwe3w0FUEUDQwrtWS/rwXKY+qHGWdvccMC9Hf80XuNzLEObdVaJr
 0RXfxXTBUoLEB/qadCV4d0HxB9DSHuOUrBLe4SUUtGGcJaroT7dCb4ZLg57umThu+Vdi
 tBBDIVuPs+AUqPd7UUs220ZWQC7N/XeYXmhTdiYE+FojRtk7aIXFjWo7eQuJ1Kr5FyhI
 AC4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786517970; x=1787122770;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=FdJCKwYmMliwecfmmyMZeFIgAyYX34skY9HwVtfYTyM=;
 b=o1Q5DfTLyBbIoxlqWE/PYJ2AQMyQwOvIFYJTq6i00fsqu2GunSbV04n6kc47sKGa09
 p+ImnqPjkTtiDdYIK+KGd4VgAxK04wklckLFg7/KL4jL0VlKfiQpyolFAkh6heFHRo2B
 L6RF+za9nsBsm657IhrTgr5FLJi0BA0r0VdTaRaSoIowHWtnx7Eovu3oIkEypqcrwEeS
 C+tE9X2OshZ7u8e3tXbGlFTyw2lJfKW/gjVdulMBfhBUlmfAPosfC5rieurqyimXsExT
 UzUmCjF6xcWfJIRNQKGUdS3sZQEnBc1HMqhdOAn1cf4gZxG697afwFbxoBhyZWLMu6pW
 B7dA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq2mFM3RetIjYtCmd5LShGILpMZdgiPyFWxgnrvS20Dqz9HgWO9br6AD1Gc2wvZqScgld8UdeGAczx+@nongnu.org
X-Gm-Message-State: AOJu0Yzc1qD+CNkg0oM9PIKjVnFUfzuj5zmRF9zX82zNgjA1G6fQy3s9
 2epPyPl4UC5ESY+8KqJUCrPuDba4hPDfGXShq7DVV2vglObV/o0Jr5ld9jAlX8k7Yx4AnEBTikc
 Vh5K4lZNgkpGxgXrktKA+2JbKcV0+2jMOGN28q0ogJMM3T+rOo0pRdAF4WA==
X-Gm-Gg: AR+sD11BO/7vGsRRhds2zgByyjWDJsLtUVP4c30oIBmz4jHaWFLNthFpL7XbQ3GbO4m
 q3DyvlYrcbnSgpfVwESYmuPFn8JyTYKVTyfoWQysUuIn3K/RuCFv2sp3+Bj9Y7rU4/VqeZGT1Bb
 Q5RvyQXQtyNZwN/ZWPc3Ik/1KBd2P0YVW80nKP3lJp0KUOw5f+Fwpzpi7+b94B7LkO2qr4QVvSF
 r03jzcS+6XzEFwNvsbbg0BS/2ryJ1YjtnnsptiVozBdmOS+ZiHWH5fpzeXPnil7G5eKfBsZzXSl
 j4E9y8b4AJNoVZFISr2/v57SJtf93Q77LJvhVie5AGUNMOUwidsWFBjePifpMTm3tQQqLI2/n3m
 bSih+i+LgAMZT3EqEW1FjSV5y+2wtGxNOaEI=
X-Received: by 2002:ac8:6905:0:b0:517:8711:d46c with SMTP id
 d75a77b69052e-52d64814423mr24152491cf.31.1786517970426; 
 Tue, 11 Aug 2026 23:59:30 -0700 (PDT)
X-Received: by 2002:ac8:6905:0:b0:517:8711:d46c with SMTP id
 d75a77b69052e-52d64814423mr24152341cf.31.1786517970046; 
 Tue, 11 Aug 2026 23:59:30 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4997abeba23sm45347395e9.11.2026.08.11.23.59.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Aug 2026 23:59:29 -0700 (PDT)
Message-ID: <6e5af230-346a-450b-b293-12898fee2cf2@oss.qualcomm.com>
Date: Wed, 12 Aug 2026 08:59:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] tcg/aarch64: Implement ctpop with FEAT_CSSC
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260812003143.225228-1-richard.henderson@linaro.org>
 <20260812003143.225228-7-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260812003143.225228-7-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: SXGTarZGryphzQjyPEV7XlcLdImSmuGa
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA1NCBTYWx0ZWRfX0e7pSWqb3Xcw
 JfDfsv6KloMwwf44R+/XC+8xcO6kzRRhLoZxyKdnb0gUtWfIi07Tio1rPZbWYmj/hhN4kDgN5su
 N+08fmspsxcxhRVk8VZZjcmqL1AQHsI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA1NCBTYWx0ZWRfX3MLYMoq9YZJG
 r+LDF1zAES7JDjs8cQpkPI9qGX51xFaPAd0urnu73M5YfWcsql7HO6NvEYPGO9mHA/SBHNq2Ih8
 ue6elZgP8VzpoUrD4jkisk7oW8QymgnI0zq6hTf8zz9m1uyfb4U6J/RwXvKAit5xh0UQkPGJ87o
 5H9RGOR9TOP63Gj7JB2UjcIBgz4IlAqqsytWOjvCUJ0FTgmPHlb9lylP9cXJjR8p1fvN1ThD3CS
 Mq9GEK21LwvIcBBiEbPAEjq4HD8gyj/dkZUlmWFxcXG9do6Gwbx3WHCokBY0NrCvcePJQpAOHeW
 z/BtsQr0j40jVc4Xyp//NdgHLcNLlD/5LwYO4XitP7D9MUwxEFIISfKoynXBwX4ubzfSA4nZOzf
 896UqfMHMCDvvI5ryRarQphyrMOoYy/gaHpVxxdNwm7JLPbUV0HNSg7OSRUV4QLlhFQ4H7Smcng
 1I6E9EKaKqigypO4+Og==
X-Authority-Analysis: v=2.4 cv=Z7Dc2nRA c=1 sm=1 tr=0 ts=6a7c19d3 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=F4whdlzREtsA:10 a=IoWCM6iH3mJn3m4BftBB:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: SXGTarZGryphzQjyPEV7XlcLdImSmuGa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_02,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 clxscore=1015 impostorscore=0
 spamscore=0 priorityscore=1501 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120054
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

On 12/8/26 02:31, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/aarch64/tcg-target.c.inc | 15 ++++++++++++++-
>   1 file changed, 14 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

