Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 321CACA5FD4
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 17:58:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCL3A-00011i-3l; Thu, 01 Oct 2026 13:58:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xCL38-00011E-7M
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 13:58:30 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xCL36-0002a2-LV
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 13:58:29 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 691FsmMe2475492
 for <qemu-devel@nongnu.org>; Thu, 1 Oct 2026 17:58:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +zDwiz3U9PbN6KB65Ha7ZFBhYImvlyE1ZXTL7dmmh8A=; b=fXM1pRDm5qpQ+y68
 NRxrQUJGhavkRS3fJbsAh8Dm51erFZfLSG6+tXu5jnQCF6jLR4kyuYOhfYum0D0A
 KCE+YqYHZ2PKNE+O6bYdIytR19ycKJWSlhjFHQzM1HgII59hag6k70m/952qdNbV
 2uhbsbM8TB6rLDUMNsuiaL6XlUOgiLZElQBi2aZaOH8gT0ntTnI3rdXX7T4LjJ2s
 cpiszLWo6/7jpGQhXpF3gr6bdtwjbcdwBOQwXC0ZpStqK9L1qzfJq6hDQmZJQqY6
 wM6Mxh5OStccEchCUmXrUyY0Hs85aocNrDndBAswgRM+E5yuioSATXVoBY7fAy5N
 7mEKMw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h1tbg8nv1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 17:58:26 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-934956beec8so1378049985a.0
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 10:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790877505; x=1791482305; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=+zDwiz3U9PbN6KB65Ha7ZFBhYImvlyE1ZXTL7dmmh8A=;
 b=jPdOnNdfRAT1y0eYOfspAJ3ENlCT8sbQ4Z4aJrlDRV/rgFyG069+ILBVQThlpGJt/f
 3kANo87pZiQZOmc5LxQVdYvrbSchDBWYbM0qWkKP+T30wTo9DBFH71Jymfyhcjrcm6T3
 IC+zBupBD1ljI9EkliigB4vUdHQMq5JsZs1FEYvB4GmbjsC+MF/MML8BewHZRJ5cphdD
 /iktZ9296DyiO7uSrVnfjZj1L9w4zKB6uah1Qtwq3GyEYlwQTbWQjebpcV/KePITEE5E
 DzEQFXQbLM5/nPZT2RbPCV7vrhZjJ1RSC1r+arlzxpdLdo8o+az5WwCcfsLyyypTPdyL
 f3ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790877505; x=1791482305;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+zDwiz3U9PbN6KB65Ha7ZFBhYImvlyE1ZXTL7dmmh8A=;
 b=fYXemXzAS7KdX+lQHILeGST3B5AUDuLv1Mcwvo+iUzLmIdM+PN+LlrTj+loM1yHlLV
 3rZIoZ8IIfJEKST/vH9g0BoJpy6gocdwdxOpCsHP2IwQOg2WfDk32D6ZhDNjzi1zbcBj
 43PcxoMUtCmHIvI0soC2zR4R6UKckyzXhO++ox1fvBnOBgbznHgeEhykBh8/ZN07WvSX
 JCRUJywxpa6eihdPHrfaQRNZ+S4pfrsH+9Ydx/EcrZ4xXCgdsREtV8D+eIztUjJl6mlT
 eNHhwQJUTXT/kb2W+J4gCXmoQ+850zqjVu56Wle1fCLZQjztbw2+kK639KwI3ojePxdO
 ovUA==
X-Forwarded-Encrypted: i=1;
 AKwUvByGo5l2BtA+bLd1trhFR0xZr92dEaGMFDwys91YuJi7uI1OYzvO9x2Tw6G6Z//XCfbRXSyLoQi5rHyW@nongnu.org
X-Gm-Message-State: AFuF++mTvkYCKcfy9g+K0QhM9+1SDQSarDYVC9jjkrPjbfaT3iVAO3N2
 11RyNTWtRjewYfPOA5U6ou16+kIHufxGfFw3NJeJccLQCVsTII7Oyrr3Q1VPi6hTT+kkNPJ+iDx
 +UQloiS43E+dMwjiYRS25oqsl2xTsEBQy5sxrLFpNL9FGWiIjUGwVNwFlYw==
X-Gm-Gg: AYBFou0iW+Q8r5UkKjpaS9a2H4xvSr5uFY2Qtp3hrA91g8Um7U6UG1au1+DyseDBL32
 FIvq5t5CyylDFGhRZEuxkcIbKysGwY0JoIVrZ46DoNYDSYtjekewzZ6DyIRMuk2z18YHb15hGI/
 XAZ3jzW3tqgV4ndku52Wa86TEef9KIRWSa+DygqiSHO0SE3yBrIUgMGFXoOf+a+WmaYXhdPJvtu
 CJTCFOq6DH8PU3C6KE/Johheo4LwYMt043tjTFrFgzUC7mYMLsKSemMF3gtr5/NIOy9NuOLN418
 FnSL5XhgqlCEwPkG7tgjUWLAgCMHqPr2x/Rla5Uzjj9C/nUVbzjIk5DYPoFytgD5FzzN5gd+ula
 b17ERh51d1e2Hx+IiM4zwMg==
X-Received: by 2002:a05:620a:40d4:b0:93c:23e4:359e with SMTP id
 af79cd13be357-93ca982e719mr1044188785a.50.1790877505166; 
 Thu, 01 Oct 2026 10:58:25 -0700 (PDT)
X-Received: by 2002:a05:620a:40d4:b0:93c:23e4:359e with SMTP id
 af79cd13be357-93ca982e719mr1044184485a.50.1790877504704; 
 Thu, 01 Oct 2026 10:58:24 -0700 (PDT)
Received: from [10.111.137.66] ([212.136.9.21])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a027734b49sm6488095e9.10.2026.10.01.10.58.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Oct 2026 10:58:24 -0700 (PDT)
Message-ID: <47779886-acb0-465c-bf14-947e99d888d9@oss.qualcomm.com>
Date: Thu, 1 Oct 2026 19:58:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/20] trace: remove obsolete references to vcpu property
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
References: <20261001151228.3373747-1-berrange@redhat.com>
 <20261001151228.3373747-8-berrange@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261001151228.3373747-8-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA3MSBTYWx0ZWRfX3iJewv9umqt+
 CV1VpN5yKtOiQhxiEmP7uxdPHFfOJ84+ZemnmBPgMlHMq34rFSX82S4/LciqKpEsNUdU930Ah8/
 uJKDfsyKGttruRDPdPGx3ugclmAIpRg=
X-Authority-Analysis: v=2.4 cv=QY7zLcbv c=1 sm=1 tr=0 ts=6abe9f42 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=/bviTfK1dmy+WGcHzWQ0gg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=-cwBI3SRGJxVHsXT4kwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA3MSBTYWx0ZWRfX4EuJVHJgIhSe
 W9mndd+a8APx11N2YOk/UcH/gfUfoTl3QAtx1+tIse6Lq+hCAjxx5oW0BktzeI3pXXXoh9k1ZYd
 EcAeDyQ3FofslquqB9lGqbXckQcO6ePXYFk8VON1KpdoUQGpht9rNRvSxvydqk1cDCDPMYaUBAk
 L50E/NF1TCBwOaSOYBRXDTVp2YebyI585tftd4X7dSvnjA3qTvS6PHgauF8y86eiCFQhvdeM+CM
 NzFyVT0YuTXamDjAfpl4oYTDTYzg1jZV+h5mtnt4RQzSwLVdFPrYXBR9o6FTicnpbE50D3U4NJq
 XQxbdgpwoGGqIkVEoLafCACWhhEQX4ap+cZOvv6hBTm8PPcerH8miXdDQA2yOlFLSGssu8UgRXf
 BmCq5QeKo/UPciGJpoWymNNOXZ3DKJdYX8eYMq11Mxu5n3GVI8Q85tFtiG955t7bAj84W8B8FhJ
 guYDSgpuPV4NaihSf2w==
X-Proofpoint-ORIG-GUID: 56Ve9lwEH_pr-boHR0IxmfSMFFbsI8uK
X-Proofpoint-GUID: 56Ve9lwEH_pr-boHR0IxmfSMFFbsI8uK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_04,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 bulkscore=0 spamscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610010071
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

On 2026-10-01 17:12, Daniel P. BerrangÃ© wrote:
> The 'vcpu' property for trace events was removed 2 years ago
> but some mentions of it remain in the code.
> 
> Fixes: 7ffc4894a6(trace: Remove deprecated 'vcpu' field from QMP trace events)
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   trace/control-target.c |  6 ------
>   trace/control.c        |  6 ------
>   trace/control.h        | 12 ------------
>   trace/event-internal.h | 11 -----------
>   4 files changed, 35 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

