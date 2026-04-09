Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F2C8F364A3
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 17:29:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAtCH-0002pT-1a; Thu, 09 Apr 2026 13:29:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wAtCE-0002pI-Om
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 13:29:38 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wAtCC-0006I2-VO
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 13:29:38 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 639FeBx72247136
 for <qemu-devel@nongnu.org>; Thu, 9 Apr 2026 17:29:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 qi9BYaiTuOgUq+7oHLU3lhNCGKwhTJfsLVzhQKYYCyw=; b=gY3aY9BLCsaplnes
 5sy0rLqnLoEcCEWAlJWSq8q2b9K62tlfHnl3QCf4g/QqP1v6c8UZsGF7+5o9kmO6
 mOKuYFW/M/KZFMKKjyUvezrjXq2hJux8SJT2s1JQEE+PCB0aq2y3iXkJwE3QfVap
 3UCGWkqq8MrANKPRGrIQH9gm9jHGL5vpA7uLzUNPkrIcHakxxJS/7JOGgLejOMyc
 clvnOqTQiBQbxz7o3wyc2O5FGgx+1U9YUWwyDi9Muq63Rc89gs6kTflHl9j4R/ks
 OqEhRbZLQFAzNDkvFvkrR134UtaRy32fc7Aqm57RZus4k1aNsXySgSCGG7mJEXmm
 YkQw0g==
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4de3s6u7wv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2026 17:29:33 +0000 (GMT)
Received: by mail-oa1-f70.google.com with SMTP id
 586e51a60fabf-423145d81c7so2253500fac.2
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2026 10:29:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775755772; cv=none;
 d=google.com; s=arc-20240605;
 b=lhv7/4y+p7gjFSKId5t6pb7xG2XuBtSDvggS+G11AjCI/DWfLbBSrKOd+09tsFLeeF
 WkvpZhv4BMiaF5aZZkAUVruzB2QAyMf7DyMyzD4YdNZOXbf6aBgfokkSsPIML11Napsl
 xLsSCNJd946kk8e1PEyZOOl8KXn4nZP9UZ7DsyIRlTynK4p0Ln/5B1dCsBCxb4B+FS+X
 a5HoCiSUks7g0Vl+faEnQ8pVddPjYlOCfzZcsEcb3P2Xf9GKb54Ux+YgFTqFpZx9pASr
 dMvYns8D/flmHpTizUCOq5ufW31TYMq8ALqtanlwVGZoM772VfhPr1JEGpewDaXYSYiD
 Nm8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=qi9BYaiTuOgUq+7oHLU3lhNCGKwhTJfsLVzhQKYYCyw=;
 fh=GnmuetGqaJ1war6gxxmTGQNqKfwOxvG4yU92WoV01Vo=;
 b=IXtbcE96qhkejZeXZtuL21r1QqP+uxx7gBIIQzUl8I8QZJ58b5iY/2C5gEr8bTta4D
 +FPxcpfNRbrSgtWFpIfCo6sySRBEXLaU9IoKNFgi0z9wAm0R8iIZtTa5V6qWRsI5Wg9z
 zkY+e2p/a7v3Cw74jvUCWDh50FiIxJ5K5PKMPIYM8+d0/Qv6UkZSOWdtLmu2cnUYeTlB
 DUjUCAm9ZQbJ2Yi5KDR/NwWOPfOkmB7/0X4qMT/vgdifrcdWcauTK2Sk4PWpN/zp2Kiy
 hw/FiAW2wLstBgT1RqEx8CT4RCzcPJgqtGzhey/Yv7+gml7Bbtw6lh/H8HOA7fwdu7zK
 tW4Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775755772; x=1776360572; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qi9BYaiTuOgUq+7oHLU3lhNCGKwhTJfsLVzhQKYYCyw=;
 b=R7sbmOtO23JTy5Lpc3PHcb5Jp63Kd0nNe2WxPSuT2ZyX2svaUV7BTVtAC9gLyyVVBQ
 pQNaZY2VM0enRHWj8f4AHrKtiYtqSNvrMwRLeTRyeXhtzYumpWKfGLTM4W1/Nexe+whl
 7otEkdcZ4c8MeiUyl0Fy+bZjZZHqB9P209qftauNoVhStAhGb8MpIu/VaxOxfAxsSsOb
 4SV4xIVF/lOebqpBPQvUQ6DuqkA0LHGqU4bzkUFg/CEUlRmpjec+OWtTv51MB7u52cLr
 hbtxs9Ksh1+lcxZgZh2AtWXU4ED0oACFWPWqHFJrSK6OGSmZ8cMZ/ni2WDYwNBiiw9Iu
 7blw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775755772; x=1776360572;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qi9BYaiTuOgUq+7oHLU3lhNCGKwhTJfsLVzhQKYYCyw=;
 b=F/bszhU0J2f3D6RkS2fYMdz0iW9FkbAnhRIRR8aogHibBgr60ZVEgRUi9NsWdzasP8
 ssB7KhxZighmIglWk1UBM6S+VGkJvmpigvvwkK3zS70CTnyCK/OdF2KpsfJ2KYmd0zS8
 gDEqmRN4RSgTcoJONzwvcDoHvXnSQfScUMdex4NTH4PG7xDJuVgiIq1Gf7JFTCTmut9H
 XkhD4n/0ZBo2H4mECkbxkxCWRAZPmyTURcZC7pTz5IBGob5ezdzau5oyozyj0DOUzWWw
 +hhuYf/cByB48F7HU2YCY06/HGJ6Qp6suDxkpwUvH2QbNQBbtcDtZCVYXkB2x7UxcsWA
 Wp5w==
X-Gm-Message-State: AOJu0Yyy2CE6w/piHnx1K8bno5DvmzvYgTfxzeuNN5cNQFUAI62jv4Qj
 V5c5JIhZvJvhfEmIFKINGUhlmS/EqS0QcM9lvgl5ie/mLTTIE32fl/E3kHvcE3cg06Hnx5ZQmFQ
 kr6OSZxJ6h74SEGMRSNPmiD94hJxn32wM0CCUmFJyiliKoxL/LkKpDAHgEdr/Huu2bziALfeNVh
 vSE70QWaM8YSihqFxNL9i9E8myRBj8QflA
X-Gm-Gg: AeBDieuzPtUzmchCfyAioi4hfdAJfSkZwkqXvFTQDtlpYv4UORqgle2g8cUFl9XKu83
 RxaKVPCyQxkg8bFV9R+3LhG1vSZcvcxc3SxIAJc7MaayfFW+kiCDC770oscAR9UTKgSlsPOEs6i
 yeQpwYjdw8gj8hIO4PLsSCGYaDPcSi5O2Q06x9u7txAcO7VdVBiHNuabbIlNYTpR9RTfcwHNUqE
 5OI
X-Received: by 2002:a05:6871:780b:b0:423:29e1:909d with SMTP id
 586e51a60fabf-423bdb1307dmr2603576fac.23.1775755772397; 
 Thu, 09 Apr 2026 10:29:32 -0700 (PDT)
X-Received: by 2002:a05:6871:780b:b0:423:29e1:909d with SMTP id
 586e51a60fabf-423bdb1307dmr2603557fac.23.1775755771946; Thu, 09 Apr 2026
 10:29:31 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1775665981.git.matheus.bernardino@oss.qualcomm.com>
 <42b4b2d1c61637d9fd951f05371fad452d9af77e.1775665981.git.matheus.bernardino@oss.qualcomm.com>
 <CAATN3Nqb2kwrgjw_6axGmht8qPecCPG54arhdpe9OaUtTiYGtw@mail.gmail.com>
In-Reply-To: <CAATN3Nqb2kwrgjw_6axGmht8qPecCPG54arhdpe9OaUtTiYGtw@mail.gmail.com>
From: Matheus Bernardino <matheus.bernardino@oss.qualcomm.com>
Date: Thu, 9 Apr 2026 14:29:17 -0300
X-Gm-Features: AQROBzBBR02g8R6ZCQ-hcG0RhjltXBqYrSgbiwIdIm8VVREXFzJEI0p_S27MLD4
Message-ID: <CABrGZ+Gv3++hMts54tuM2QmWV-T83tF1x1+WZ1zkrELfUOCEdw@mail.gmail.com>
Subject: Re: [PATCH v3 06/16] target/hexagon: add v68 HVX IEEE float
 arithmetic insns
To: Taylor Simpson <ltaylorsimpson@gmail.com>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, ale@rev.ng,
 anjo@rev.ng, brian.cain@oss.qualcomm.com,
 marco.liebel@oss.qualcomm.com, philmd@linaro.org,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: -MIMKu4XgUjMCsrxXeAg4v2RMRiq51LY
X-Proofpoint-GUID: -MIMKu4XgUjMCsrxXeAg4v2RMRiq51LY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA5MDE2MCBTYWx0ZWRfX+ymByEtzjZGk
 gYZxydh5rPMZDrx2FxlcdYDc7QallUwuK/rM6YAXfQpQP//yP3EJvjmcLCQubiU+37KigROHqad
 MhRFij2jTTm6D4hGMPeYhecKkOg0loVkSbBYuqzKvGGDQQITu0fTrqIRfG1wf55Mf8LLMCPPTc6
 9ZStKRVA2AfasuU9qqHOt/roC2xUBSZbVddr3yrPXjf4nsA9/2Ckjd+91uQFsOy1lMJaiWd41ZP
 oIIq0WHJi2UsPri7I3m8DZAM83IcGnQNwgx2SmP3+H1QEijeINW24kYFxSUX3QzUlPld3li4wXA
 hKcrFWfHBC5F91NX+CB4BgV9yQfjvHcAbTEUImWgdN7CghsGaCaHMvN6oUkdb/ZolbEhcSOHnm6
 SWIddFg+Zq8VpSUCNH1JcONAcp77koF0b+9KrQg/lbz/P8AcSIjbUr+fhtJnTNvoV/2qDhzC4b3
 jyIVF7K0S4ZhcfK2TTw==
X-Authority-Analysis: v=2.4 cv=TZemcxQh c=1 sm=1 tr=0 ts=69d7e1fd cx=c_pps
 a=nSjmGuzVYOmhOUYzIAhsAg==:117 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=ct_1bP_sSNeK4Q7Ha9YA:9 a=QEXdDO2ut3YA:10 a=1zu1i0D7hVQfj8NKfPKu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-09_04,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604090160
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=matheus.bernardino@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Wed, Apr 8, 2026 at 7:12=E2=80=AFPM Taylor Simpson <ltaylorsimpson@gmail=
.com> wrote:
>
>
>
> On Wed, Apr 8, 2026 at 10:37=E2=80=AFAM Matheus Tavares Bernardino <mathe=
us.bernardino@oss.qualcomm.com> wrote:
>>
>> Add HVX IEEE floating-point arithmetic instructions:
>> - vmpy_sf_sf, vmpy_sf_hf, vmpy_hf_hf: multiply operations
>> - vdmpy_sf_hf: dot-product multiply
>> - vmpy_sf_hf_acc, vmpy_hf_hf_acc, vdmpy_sf_hf_acc: multiply-accumulate
>> - vadd_sf_sf, vsub_sf_sf, vadd_sf_hf, vsub_sf_hf: add/sub with sf output
>> - vadd_hf_hf, vsub_hf_hf: add/sub with hf output
>>
>> Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualco=
mm.com>
>> ---
>>  target/hexagon/cpu.h                         |   1 +
>>  target/hexagon/mmvec/hvx_ieee_fp.h           |  18 ++++
>>  target/hexagon/mmvec/macros.h                |   1 +
>>  target/hexagon/mmvec/mmvec.h                 |   2 +
>>  target/hexagon/attribs_def.h.inc             |   4 +
>>  target/hexagon/arch.c                        |   8 ++
>>  target/hexagon/cpu.c                         |   3 +
>>  target/hexagon/mmvec/hvx_ieee_fp.c           |  21 ++++
>>  target/hexagon/hex_common.py                 |   1 +
>>  target/hexagon/imported/mmvec/encode_ext.def |  18 ++++
>>  target/hexagon/imported/mmvec/ext.idef       | 101 +++++++++++++++++++
>>  target/hexagon/meson.build                   |   1 +
>>  12 files changed, 179 insertions(+)
>>  create mode 100644 target/hexagon/mmvec/hvx_ieee_fp.h
>>  create mode 100644 target/hexagon/mmvec/hvx_ieee_fp.c
>>
>>
>> diff --git a/target/hexagon/mmvec/hvx_ieee_fp.h b/target/hexagon/mmvec/h=
vx_ieee_fp.h
>> new file mode 100644
>> index 0000000000..75008deb3b
>> --- /dev/null
>>
>> +
>> +#define f16_to_f32(A) float16_to_float32((A), true, &env->hvx_fp_status=
)
>> +
>
>
>>
>> diff --git a/target/hexagon/mmvec/hvx_ieee_fp.c b/target/hexagon/mmvec/h=
vx_ieee_fp.c
>> new file mode 100644
>> index 0000000000..3367226998
>> --- /dev/null
>> +++ b/target/hexagon/mmvec/hvx_ieee_fp.c
>> @@ -0,0 +1,21 @@
>> +/*
>> + *  Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>> + *
>> + *  SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "hvx_ieee_fp.h"
>> +
>> +float32 fp_mult_sf_hf(float16 a1, float16 a2, float_status *fp_status)
>> +{
>> +    return float32_mul(float16_to_float32(a1, true, fp_status),
>> +                       float16_to_float32(a2, true, fp_status), fp_stat=
us);
>
>
> Use f16_to_f32.

We cannot use it here, as this macro assumes "env" is available to use
&env->hvx_fp_status. We don't have env here, and we do have an
fp_status to be used.

