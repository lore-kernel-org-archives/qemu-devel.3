Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F97BCD5BB1
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2026 15:24:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRX9y-000478-Du; Mon, 25 May 2026 11:24:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wRX9x-00046D-Ea
 for qemu-devel@nongnu.org; Mon, 25 May 2026 11:24:05 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wRX9v-0004zz-Li
 for qemu-devel@nongnu.org; Mon, 25 May 2026 11:24:05 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64PBALND767582
 for <qemu-devel@nongnu.org>; Mon, 25 May 2026 15:24:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 9qsN6zxyqJCOfmLBee2J1XFDEDa5ldl26/e4OLIwdjc=; b=FixFFnLF3dMBNjs7
 +eowAwr6KItaivGXAoKbNmGwbw9w08cX5jRBMtyDvpi8GRHswNjZ7D4cXah9RXi0
 SPJ1dPafH9JZFUmT2Uv8LYs1PrZzgDeNS2vxKr3MFk1bXpmy7vJ9M94BEM7m0Ccg
 kw3TaeZNG56Hb7/R9ESWvCkpaILjt8aDKJc7cIphTS19Hu2qRL1GapH+Bwg7qAYU
 Qx1BSFPbAF91rVB0ZkXOBIUapTcYPUTPWwDzh9fsxy2U5HNnvxQ/i8GGTHUU59WW
 kCxgSdDe0rkjZzmrgoE9VNFa1E0wanwBm/3uHphV22CvYSftuKdD741+oH/DiXtZ
 ehKHVg==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ebba0xcts-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 25 May 2026 15:24:01 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-1370417c0bfso313730c88.0
 for <qemu-devel@nongnu.org>; Mon, 25 May 2026 08:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779722641; x=1780327441; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9qsN6zxyqJCOfmLBee2J1XFDEDa5ldl26/e4OLIwdjc=;
 b=LGG+HIqaRKRys6fF1AgMRBjdsOBMjx+WGHqcltvEZyH49k2nVuKzl1Cu/Sx0VgSJ20
 wkdBk25mzmcmqW9Ec9EGmw8uih90q5nx2XH8rcLG6YLUoXUp4aBQeJhbz4z/80e1TRud
 X1fowUqTuHtz4xQlFeovv+PQ6/UgrHEHLqi8ED8IrVUhD3XnrRHsxK+BtbqHm6QmxDZL
 IgnRS6mARm+R5BWNgZf5C19KKJJRGupyJILnCVhhBYq0JLs9nnw/ucoIcE3xw7kuGXvU
 LTFhAqd+3gOa4IQiY1vTUQREfn+17xhNU0gnKSKEr02cmXZu11czMkuH5WKyiMnU8XBv
 w9dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779722641; x=1780327441;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9qsN6zxyqJCOfmLBee2J1XFDEDa5ldl26/e4OLIwdjc=;
 b=jK38Md3FE4s0rBQz3uoz8IHxQ1OzW8txkT3ZKFVjtchAfjF0nVSzmrHKgzOtN9K+To
 2AVpebcrU4rIMrEe8pY8ykYNN5t7CoZcZ65ULeeSrnPUDanwoaxA2UlK3YVIO4FaSJDL
 o4i1fbZCcnqSwYjLhJ8HokfWLoEI8Dk0r3Af15ZqVSCRMtNmIQ4p7ankwi9y3SfJlg3s
 xScD7e8wj0wXtFkkBqCyXCEsnXK9ceM7KrX52oWK/MvODKD4Hq2sXQIPrE6GGHsr64+i
 TcNJcypR0JXrobJkDrRTg20T8HfF2ZbkjO5XzJClV1nH/T3Zn9acAsgQLpw8LURB4mfX
 2YUw==
X-Forwarded-Encrypted: i=1;
 AFNElJ90Nn1VGGa67JXqzQxYUn2gCqkPh0J5VybYdBdaR0CaTVlrNTVJFU33/QEdH5DluN57Nqhznwg+c+8b@nongnu.org
X-Gm-Message-State: AOJu0YxUQpgRoOBdqvJbrytKLeHO9mZSNJiHP9xCZSONOeryr6tGZI6s
 PedDz7ewDxWyN5abPOz7BN9CBjkdpHvkPf1qGvkaCbL7UzR4JSKvKETO4ccaxmqCM6UhAqqvxPn
 B8r46A7BWwJUxLgex5raZGmjq8skr2/tA8BdbJPwQkGWsDetvKRPzqYOPzxkZwHIXXQ==
X-Gm-Gg: Acq92OFtgg/0UZlVZ2NvB6KvNYLPwQ+EjYsfpWxM9WskYRbOsYUYGF7j7pDfpZtVE4J
 RxR+Uy9ZDRkLZsDl+tWDTXT97L4BOMxgTFYxgZNI7NNKAdp3xQ1J3rGrk7yj76BRD4ckX9NkVA7
 hVGDo4UE4iyJ4pgZss7RAwkPqYWmj1G1Os3JAYNt7lmch8bE82ksP/88VG7fqmaKu1AR12QTfYd
 dQ5Bos7BmZIhaj2RuWTmapskgO3SosDND44cvi85vXwRkcnuZN79yRpmP79/bps3EbYAZLLxMhI
 09K4niQUxRagYK44IXLrRlgbgBO18aREB5mdDkVJhWqYF9+SM9fenK8TsHFCqNCoGs1E3UsrC1f
 Y3rA6dUln6L5yb+XQFMv4ZsECuKRHXLdzWbI+MmzY/v5lokZMSsmbKUR4WY5UP2+6iifXy9Jn3i
 YK2Vc70eG1x5QXHg==
X-Received: by 2002:a05:7022:ed06:b0:135:40b2:ede0 with SMTP id
 a92af1059eb24-13633b6ccbcmr3838125c88.6.1779722640881; 
 Mon, 25 May 2026 08:24:00 -0700 (PDT)
X-Received: by 2002:a05:7022:ed06:b0:135:40b2:ede0 with SMTP id
 a92af1059eb24-13633b6ccbcmr3838118c88.6.1779722640238; 
 Mon, 25 May 2026 08:24:00 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30451ca2d80sm10153548eec.0.2026.05.25.08.23.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 May 2026 08:23:59 -0700 (PDT)
Message-ID: <e227ea9f-21bc-43eb-b5ac-21e613d7184e@oss.qualcomm.com>
Date: Mon, 25 May 2026 08:23:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs/code-provenance: Fix formatting of *-by tags
To: =?UTF-8?Q?J=2E_Neusch=C3=A4fer?= <j.neuschaefer@9elements.com>,
 qemu-devel@nongnu.org
References: <20260520-prov-v1-1-7a58af334b9c@9elements.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260520-prov-v1-1-7a58af334b9c@9elements.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: B8AOPx2Lhfn9wPfu-5x5EcsWpxXQ4slu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI1MDE1NiBTYWx0ZWRfX3TB6t76SdHdX
 vf8Ysjvg0Sqa8pWIrY7DZREZxzubqXerfb1d0TsDEJqPf7zvYoGObW23yN3jur92Soqv8d1txsk
 EDOnm4hmRJXC0lOwK+z4Nk7ZB8ddLWPslm6PUs3hzir1dthZqcRj5FC5ZuBdjEaBdWWIYv9LFDe
 b7mZXAytbred7YNGXI5PpTDvQHJkZ2PBBVRY1gPhKCvzlLkBaUSiMGbfrNycd9UIxsFQgyAnbci
 3qkKaPhsbQez25R/oHBcBGkIcu+DvT3a0ONYVX7ZmaAnEfRLoBksYs3gv55lx1q2D2Wz/21zYxK
 mg8hDVj0XT+g9NAzB3kc1ZjW310aWtGnh9yl49/j+3EElzDmYcGS0ZFFDgc2olha60eSF56gP/x
 M+RFO8NHZ6O1Eom4NU8Ba/v9b8neYhE8RFs1D4R8HcDm6joEmUA+JfW1cb//+gIJY8NqKPaotgV
 hhSnveKC8ZY+Y5hHaZQ==
X-Proofpoint-GUID: B8AOPx2Lhfn9wPfu-5x5EcsWpxXQ4slu
X-Authority-Analysis: v=2.4 cv=Xca5Co55 c=1 sm=1 tr=0 ts=6a146991 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=PzGKxP3WAAAA:8 a=_cXyswzYhM_X85Rk5ssA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22 a=zCCnohV0i-_k6euCn0hJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-25_04,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 adultscore=0 priorityscore=1501 impostorscore=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605250156
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

On 5/20/2026 4:25 AM, J. Neuschäfer wrote:
> Applying both ``code`` and **bold** formatting doesn't have the intended
> outcome, instead Sphinx emits the backticks into the HTML.
> 
> Use only **bold** formatting to fix the HTML output.
> 
> Signed-off-by: J. Neuschäfer <j.neuschaefer@9elements.com>
> ---
> I'm fine with either solution, keeping the bold or code formatting, and I'll
> switch to the other if requested. They just don't mix well.
> ---
>  docs/devel/code-provenance.rst | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/docs/devel/code-provenance.rst b/docs/devel/code-provenance.rst
> index 4e6a9afe0d672c544c069447a9978baa0b4a6212..65b8f232a08f6bc903c77fd0b1f7a5adad9fbe5d 100644
> --- a/docs/devel/code-provenance.rst
> +++ b/docs/devel/code-provenance.rst
> @@ -99,13 +99,13 @@ Other commit tags
>  While the ``Signed-off-by`` tag is mandatory, there are a number of other tags
>  that are commonly used during QEMU development:
>  
> - * **``Reviewed-by``**: when a QEMU community member reviews a patch on the
> + * **Reviewed-by**: when a QEMU community member reviews a patch on the
>     mailing list, if they consider the patch acceptable, they should send an
>     email reply containing a ``Reviewed-by`` tag. Subsystem maintainers who
>     review a patch should add this even if they are also adding their
>     ``Signed-off-by`` to the same commit.
>  
> - * **``Acked-by``**: when a QEMU subsystem maintainer approves a patch that
> + * **Acked-by**: when a QEMU subsystem maintainer approves a patch that
>     touches their subsystem, but intends to allow a different maintainer to
>     queue it and send a pull request, they would send a mail containing a
>     ``Acked-by`` tag. Where a patch touches multiple subsystems, ``Acked-by``
> @@ -113,18 +113,18 @@ that are commonly used during QEMU development:
>     maintainer wants to indicate they have done a full review they should use
>     a ``Reviewed-by`` tag.
>  
> - * **``Tested-by``**: when a QEMU community member has functionally tested the
> + * **Tested-by**: when a QEMU community member has functionally tested the
>     behaviour of the patch in some manner, they should send an email reply
>     containing a ``Tested-by`` tag.
>  
> - * **``Reported-by``**: when a QEMU community member reports a problem via the
> + * **Reported-by**: when a QEMU community member reports a problem via the
>     mailing list, or some other informal channel that is not the issue tracker,
>     it is good practice to credit them by including a ``Reported-by`` tag on
>     any patch fixing the issue. When the problem is reported via the GitLab
>     issue tracker, however, it is sufficient to just include a link to the
>     issue.
>  
> - * **``Suggested-by``**: when a reviewer or other 3rd party makes non-trivial
> + * **Suggested-by**: when a reviewer or other 3rd party makes non-trivial
>     suggestions for how to change a patch, it is good practice to credit them
>     by including a ``Suggested-by`` tag.
>  
> 
> ---
> base-commit: 6d17fd91f6cf88df5cb2205e578640d72605cc43
> change-id: 20260520-prov-73c69e4e979c
> 
> Best regards,

This was merged into master (cbf877d67a812be17a9ce404a589e1bdf722c1f6).
Thank you for your contribution!

Regards,
Pierrick

