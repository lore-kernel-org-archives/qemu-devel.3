Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27AFDC5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 07:06:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu331-0005Kc-PX; Wed, 12 Aug 2026 03:06:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wu32z-0005HD-9L
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 03:06:45 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wu32x-0001nr-OO
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 03:06:45 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67C62RPF1720190
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 07:06:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 9ik7vDT63SE+u+tvO90o84cnj+el66YfATuY/qgz5vM=; b=ND5dL2Qx5DjzRi7v
 AzEimbmSkXCTade/nGyFk3iISmOm0/+yMCppWqA/buH+hTAg1WgJ7CAueRUAy+S+
 36gB0fBAhlgzh5pBW51U2uNbuwp8guOQWLtHoJFtMVTFotqLS0Q6Qlxwd308m2rb
 zo/UkFfQuFP06bYa27utnNLeBYa/hk2VNFUU3csbx3s/RbdxMpER+gRIMqlmC/Gx
 Dso/aeqnbtjQ8/Ro7hKlPJ7ik29Y80bj4dbEaXZwULCQDMrHMut4WgJ3Qw8nQfOQ
 nS0b/BeBP4Qj/OzdgF8XUn0TTd7DYfBoxPy68VeJ9ITAEVFQ3o6u5fw+BbMTQErG
 oyNwUQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0hfw0m2y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 07:06:42 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51bff5c7035so12643641cf.2
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 00:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786518402; x=1787123202; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=9ik7vDT63SE+u+tvO90o84cnj+el66YfATuY/qgz5vM=;
 b=LsZ3+JZxJoXpKZBDcGPtW63uMG/uPnEddZagErI+gc7Keh8zGHaV/aXK6xPFQfXesS
 cVIp0BBxMr4CyiW5q5RNVvPUnzmChMg3EF1++e/IsK5ND9EzvWmdHy1FzgU9rz9khOxi
 9nApI5wLE1hBGWdccWMAP6rbKFhPdDWfvdt+xIpN+HXFTHEiiQJ2PnHILt0huM+cSiec
 v3n1SeFlXDzT1p3VxFcu85OiM1DSvVOSiPwW8QGFNHlfCucNFQf/54Wbn/OEoxtOTkUe
 MlXfO3CQuvb5rB6fKw32W3+ET6ByvObF3mYLTBoD2P2f/G/stjy+qBMklqKn+uf/BCHA
 Ucnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786518402; x=1787123202;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=9ik7vDT63SE+u+tvO90o84cnj+el66YfATuY/qgz5vM=;
 b=nX1R1xYS9YxqF28guwY5meKj5JDnv//moxtHuOI0llxxAV9gXAYVvgsGIX6kHSuzpO
 WFIGoY2tqmeKjduGy2r2JtdtlPbiNy6XzIMXXToyYK+ShtcfhUzSLUaMS0UqRm0JLQhx
 FukQSm6h1KQZW8vVkmKKkznmnxfaDCIgnyZoqCm5PnkroIJeOidbd7qb+JyUPRO/rUqQ
 jj3NgePyjyE1DR4rF/9YIz9/BDBC+UjE6vMAtn0Ja6SE3+Wvq6iSfeVKSnDD2Xv9ejGd
 HB9468G8zGJ0LsIQXS2iilUheQ0ZynUXUcLMn8m1zu/OF+gtk/qPhb0j5YbPTh4nXMNF
 tOUQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpFL/Um/P6HJn7GkeENkl+m39rqUGntEEu9sgFup2U/AZdwfyp361MTTKQxPBt7GgnjyZmvB0O3AcS7@nongnu.org
X-Gm-Message-State: AOJu0YzJ0nDr8SWwdaz+S+jdoXRR0ofP/7pJP5601bLQKYIxIyy0uwsh
 gFpP9QUuY/2VVhWPr494bZsuxOZf/KexP5pQYCoolIVaq5WsCw+NURSmMsr5F+O8eDwbPo1aVoj
 aoy3RsoM2YiBgG4soA8W5bWD2gErRocJTbIpCftrKF5uXkzlkak5B8HDJ3A==
X-Gm-Gg: AR+sD10+W8k5p6J0N5VvNTFLaWqv5i0lRWfIfRO7CJkO3IUw9ZOfr4KzD+ii/p7LbmZ
 15szA9zEcJqCfRNX+SZyNh/gQyJSD5zEc4GEhU6hpP7lCF9uIq81XQmdIZI5KgYAQUDO6c9ue6S
 1hPUriUMlMOwU+aWFj/DSrfrxhUoxmqUsPWKfSxS/cM/HeHtJzYFWdU9uU3zwOKHggDnjHgWy1m
 LDEjGdJK0MFC44wVOFJtsHEtNPirpOUyYHgNQgI6/J0sGOYczPejOZAKbFMmmYNio0SPj6u1xqC
 6rim+2/wTxFNuhaBRpceH8D41CcqRYIzFzvB+xvOXN0p6HORdMlKYhtkCALUyWU99HDdfDNQbSF
 zdbPR7eOtngwXUMA0mFDHd3Ya/1XIhoQ/Shg=
X-Received: by 2002:a05:622a:191c:b0:52d:5e88:4246 with SMTP id
 d75a77b69052e-52d64707c9dmr25786801cf.16.1786518401959; 
 Wed, 12 Aug 2026 00:06:41 -0700 (PDT)
X-Received: by 2002:a05:622a:191c:b0:52d:5e88:4246 with SMTP id
 d75a77b69052e-52d64707c9dmr25786591cf.16.1786518401638; 
 Wed, 12 Aug 2026 00:06:41 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4997abf8fdcsm105828465e9.12.2026.08.12.00.06.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Aug 2026 00:06:40 -0700 (PDT)
Message-ID: <2f9a705d-c587-43b2-9af0-e852fd8d5ba1@oss.qualcomm.com>
Date: Wed, 12 Aug 2026 09:06:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] tcg/aarch64: Use CTZ from FEAT_CSSC
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260812003143.225228-1-richard.henderson@linaro.org>
 <20260812003143.225228-8-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260812003143.225228-8-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA1NSBTYWx0ZWRfX+Dw8I+4O9uYV
 zHUtmfhzzfkuZmdwdU4/VcLqOzX3ChR5x4IzaaMu8W+smyTRAvkNs7eFS/0e/wcrCsIHMrge1+N
 Zazi/7T2O/XwcEHPWReycHPAARxaOcE=
X-Proofpoint-GUID: ayKmGgDcsx50hVkU2GpSPakCnZK5jnhg
X-Authority-Analysis: v=2.4 cv=fpDsol4f c=1 sm=1 tr=0 ts=6a7c1b82 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: ayKmGgDcsx50hVkU2GpSPakCnZK5jnhg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA1NSBTYWx0ZWRfX5Bo3v7oDc8zS
 LJHOFgcA4tJHG6o3Fove/ou1cc7GpZiobGos3V86ZQcsHpHQJvxhwakItgDX+4Atxb63/BQl7dT
 f1tPVBkAmq6Fnca/DrXP6suSMmXTRCcDsav8IflR4QrJlTiiwfFKrzAuukC4DHoQiWWisTvQ/oo
 Qr7Tejbsh3pxMFrDiNK0cTjXxKmFB4Zv0Ew4Xxv4kb7ECzexQOm7XoRwKgOGSfL+WzaZQycIe6L
 KdSJVEcebUVcDVH1/P3zMnGuzbDC9/YkZ1Ra1M/Mxad/IgLHDqdDym+qo97w1Fhq8oL9jj6nzou
 KS1b1REIp1vIfxqoJmB9AZrDDB2zoayrxSEFf6Qbrd8H+A5BvZPVRJvo96ndaFOcDkKaSCvMGf8
 3FJZbD3VuQNZzabySU7CiUZY+rmm9Cy7GRXI4QbKXYJnQ4QBW3nxKLVwmcZhzkIJUc/Y2U3rjol
 jgkiKA8hXaPNq1C10vA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_02,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 malwarescore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608120055
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
> We already have an expansion of CTZ using RBIT+CLZ,
> but use the new insn with FEAT_CSSC is present.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/aarch64/tcg-target.c.inc | 43 +++++++++++++++++++++++++++---------
>   1 file changed, 32 insertions(+), 11 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

