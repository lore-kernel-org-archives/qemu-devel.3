Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E788C5DF85
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 15:03:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx4I7-0000ij-EH; Thu, 20 Aug 2026 11:02:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wx4I5-0000iJ-Af
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 11:02:49 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wx4I3-0007mj-O4
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 11:02:49 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67KE7oZi3220262
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 15:02:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=OrfwWrCfKES
 FnNdiUi7OARnWiyLEZTK5KQ40L8T6M5o=; b=hNCjoJj11LqJIWkOEEE1aP5M0TN
 uGsal4DKPtGq8yapk1oAURv5Z/oJFsUJO/ek2WLx96DIA+LA/omVnnkY7oz05UoL
 mGGEy5LeA+7KvbYOUql36zyEVuHCcWllNd609JGaJQc5B6MpQNpYiLnQRHKpVTH0
 5qlpIzMm+rgra1jWTYpV7/Hl2ZEQ/26TYrzmAcaQKl52w4312OxLHosBtDg3bXy9
 vPP9asciMkD5MSfSEsxpt3qOFh7uv6jP4VSSFOYISCyBkhhuFaUyKfhj3O1kd9pq
 tiPo4WSdY1hKt/6hPqvzrBft0PZ7msxMWJ/Irp3EukBEgXTESK3QMH23Krw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5x29hmcp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 15:02:45 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-38f97b3f853so3955638a91.3
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 08:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787238164; x=1787842964; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OrfwWrCfKESFnNdiUi7OARnWiyLEZTK5KQ40L8T6M5o=;
 b=C043gFKaj8Z8/sTy65RTsnUwJUgIODYLT2tODjfvw4H7vBEhbMA8rGjQJampSOgHnm
 feu1Lgcdd7u3KRCzPwObjHxusBRKQ2BvMMhSz/7ckYj3PQV+ZBaG4agQHBv66chcSFeq
 ivkR7Q7V9uZ5vfErBndrVRWAfVCOEiFajxunyYBtctX54FaiGVz6YJwwYy7zBKsGhIVm
 qZmaRYA/8ikOjtM/l+Cf3PBYJLWpH0bzvzY+IB9I8052330dOerY3Fs8MCvlu2z0H4c1
 wEYMbauFQw/IHwFgPqyouiafRZF05s0q03FtRKCs4wZX9+MwSjXJ8iPqDvciO5Sox18q
 h9sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787238164; x=1787842964;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=OrfwWrCfKESFnNdiUi7OARnWiyLEZTK5KQ40L8T6M5o=;
 b=E/XGEQJeI7y5iCd8pSUUoD/ZKCQNZ1eWyMeHZxEhwLQRvBGgHXcmOvqaxxrQ6ztGaq
 DIJCOuRC3aq8CmZ3dcDK6DFUY7S8scEhREnzaD53D7H3wJc0XIvCtanH+giW5FROsie6
 nPYSYSY/bz59Jn5s+hibo9BRn1D+D97qBlIqy/a73WVANXyhiIloOh3owV6Xd6SrVdeN
 vdC5w5WNH/ChFnaBjssgoGFjna/FdJqf2TcRyJ0VI1BBxqyVdi76AjTWGuiOT+FrHo5X
 SfI4iAAGYk/GiCJp0zOum4tq/5dePby7i1fjYv+PA7yLV2rmq0eslf/SQr3hquj1P4ES
 z2/Q==
X-Gm-Message-State: AFuF++lZo+imKr8kfvYoz9YC2aaRPZKppnSMXbrLikKAj8UtX3WIZ77p
 vkQsanWanKnG/ANotf2mLbYS+8Eh8O5jdedBgPPjSipzs8MoJS3FeeruwUvvzBK7u+crpDrmb8p
 Dx5BK/Wvcr3fg/dgpkjyqg9JBtBnhs1jSID86y47hWEPWo57g7qeZNbZzOg==
X-Gm-Gg: AR+sD13hpOEHO3MOKTadtkbGP7e+lqCiSW+qtJXQN5uQpXKRYHUuEhLyNs4Y954U3Hm
 ZWn7NUikNiCmdYj1yzEmTs8ibGJbGFbrvaVCm6fOH/x2xMQUNAVdFkc3LHsG6WpyiQIrve46M+5
 Zf+Ng5SsGqou6sDyAkNKUyTTIoV9r9b/9V7DF4XJqBCsUZTt/Aosumw3LiYKUZcVUk4DhP6NsTA
 04/ncc7T6cveVV6nt5ApvZMnT5Rf2huXgQvsGnOEyEWkrrQoCYrV0Srbmj7ap3aV0RZbmr5CgXi
 JK0Gfwzpb/ffgvQNHk4r5U3xlN6afhGTbVQTykmEh1Qs5bN6HD/KbVgDDaQeKDGSAcBwfup0kxr
 IFQ8BhQ6xXr8HKh4I14zhBkr40cW7evFflaZxrV/RKA1nrEHV6ar4jA9EvDy/e00=
X-Received: by 2002:a17:90b:5868:b0:38e:2517:5d1f with SMTP id
 98e67ed59e1d1-395810b4213mr25746157a91.9.1787238162900; 
 Thu, 20 Aug 2026 08:02:42 -0700 (PDT)
X-Received: by 2002:a17:90b:5868:b0:38e:2517:5d1f with SMTP id
 98e67ed59e1d1-395810b4213mr25746051a91.9.1787238162410; 
 Thu, 20 Aug 2026 08:02:42 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327bf10a94dsm17406481eec.15.2026.08.20.08.02.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 08:02:41 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: brian.cain@oss.qualcomm.com
Cc: qemu-devel@nongnu.org, matheus.bernardino@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, anjo@rev.ng
Subject: Re: [PATCH 1/3] target/hexagon: fix HVX big-endian byte access
Date: Thu, 20 Aug 2026 08:02:39 -0700
Message-Id: <20260820150239.3061104-1-matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20260819230939.466856-2-brian.cain@oss.qualcomm.com>
References: <20260819230939.466856-2-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: s6gJLeIjeI0ZL1dE_lWWwgv_5yOdo5yX
X-Authority-Analysis: v=2.4 cv=V8BNF+ni c=1 sm=1 tr=0 ts=6a871715 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=IkY0kWWqsKwzHyvBw5kA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDExMyBTYWx0ZWRfX/waJXoRWLGJJ
 azQ7VEgG68rys/1MEWCQCG7x2IusQIufHTpOGu8nLFl8uwgV5lDnxdGmwKVHU4FSeKVL8wmQsFc
 ktqRPeV2yvQJD4sd7fKbE4MrBoiKehPZNS8gGf0hv87jQnjqxsXQWm0sun+zJr2cEfUV/kkBwmH
 IKjB2vKEDqZNS2XCdfG7x7TujU9IOBXaqX2RO4/9yCvFql/2s9ZJ93CIhpEdWTJFCRWKK/JCg0P
 eQG4JVcbvc4ZhAZ6CbTbMa9aPnMTuiXn4+BWPsxzg0ir80kzwoHahRf+OW1+6/PjLl8Iji2MV66
 5WIICUOgf/0CuZkOauglMcZduVTuwj34bg88ZH5ISV/s5MWJKBs+cfHMI1UaDsLkfTqXYMWu11w
 /E3j/pRLiER05CITVvEFPOj32aWUT/ZljHs43dxUU110odE5FKB2QSHH/HRHL11Y9l7H9xjnezq
 1cBrNh3S3vY/Dt8aiog==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDExMyBTYWx0ZWRfX34PPYl6tz93d
 XRuu7ci4nGJDw+fpMcGjmkxAXZZY021cMRAWjj3jisHm32ki61J3WICx497L61YbySpX4KlWtlA
 W5+t6TsWg2kASIoRyWMKrHgbbcOk5GU=
X-Proofpoint-GUID: s6gJLeIjeI0ZL1dE_lWWwgv_5yOdo5yX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 bulkscore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200113
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=matheus.bernardino@oss.qualcomm.com;
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

On Wed, 19 Aug 2026 16:09:37 -0700 Brian Cain <brian.cain@oss.qualcomm.com> wrote:
>
> diff --git a/target/hexagon/mmvec/mmvec.h b/target/hexagon/mmvec/mmvec.h
> index 8e72f2f6ae7..a8a777812b9 100644
> @@ -69,6 +70,23 @@ typedef union {
>      int8_t    b[MAX_VEC_SIZE_BYTES / 1 / 8];
>  } MMQReg;
>  
> +/* Map architectural byte indexes over host-native HVX lanes. */
> +static inline uint8_t hexagon_mmvec_get_byte(const MMVector *v, size_t index)
> +{
> +    return extract64(v->ud[index / 8], (index % 8) * 8, 8);
> +}
> +
> +static inline void mmvec_set_byte(MMVector *v, size_t index, uint8_t value)

Should this be named hexagon_mmvec_set_byte to match the getter?

> +{
> +    v->ud[index / 8] = deposit64(v->ud[index / 8], (index % 8) * 8, 8,
> +                                 value);
> +}
> +
> +static inline uint8_t mmqreg_get_byte(const MMQReg *q, size_t index)
> +{
> +    return extract64(q->ud[index / 8], (index % 8) * 8, 8);
> +}

For QRegs, I think this should be:

 extract32(q->uw[index / 4], (index % 4) * 8, 8)

