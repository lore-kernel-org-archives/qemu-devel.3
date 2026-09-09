Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F10D6C79FB6
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 15:17:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4K2w-0003Ir-6w; Wed, 09 Sep 2026 11:17:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1x4K2u-0003Hr-Ck
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 11:17:08 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1x4K2s-0004Mr-JA
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 11:17:08 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 689CCp9q1401036
 for <qemu-devel@nongnu.org>; Wed, 9 Sep 2026 15:17:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 E1ZCYJPanKEUN5Fpup9LTVNtGhRs0b+VZRJpHuHAouQ=; b=SzpYO4Mym5dPmjwe
 EwXDHImXD+TP/ZAhxn49DiDrWOomJgQER169fs1Tg7pzpuZxmUb6HEj6D5r7vcRG
 Vxg1rawkp1m+o8hbSsCqtdgxPLchmHhBXvyZcovItcDbYFjZ1P2YTXM+RmZOY2YD
 q3CkNwfurPemjCeNjOuqowOhbywJZn1m4d3kG8GCkGpovvcrz4fwDQtktOzyeZG9
 MNCxPShKmVMyxeqM2bEll4NVV9tUpaqM+gJLw03sgUqfkDZBJzgBb6DcdqokGS5L
 ptDtvQ2PfDV8R3QOwI84eSNDGzkMz7OgRXNSUTkwbwVe0uIQhB/TmA1yEz6ZgfWa
 uouU0g==
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gk78x0ujp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2026 15:17:04 +0000 (GMT)
Received: by mail-oo1-f71.google.com with SMTP id
 006d021491bc7-6b1abf73d1fso3263707eaf.3
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2026 08:17:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788967024; cv=none;
 d=google.com; s=arc-20260327;
 b=AskiCSJ65SGTmIo1M/KaSTjgYcSIP6dWkWDkhID53Ua5l3pTEMCm+HjE2FTiii5f+V
 62oo6Uadkp7HLYdI3GPXfz36113b7aosGnQSc5X3hnrzAawaS6Sml55y7NHC1m1ne8er
 zCiLl6Mwko3kQFmDO+NirC7Cx/Rf6P7Cd4C3gzdIXuwkaVoMjdGmRsV4j/IV0rF+vdyu
 +860/s7vKhCFYFLwyWRAdkLf+r2URN/akVmBETrx60tnRCmab+Gea5i1Y5ch5K/jKrOv
 6V4pIHyD+1A4CGGfPLRlvoeQKIkKRo4buqP+qu5UdZuQdp8EODQbfRYzWGGNqWx+dgx6
 KaOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=E1ZCYJPanKEUN5Fpup9LTVNtGhRs0b+VZRJpHuHAouQ=;
 fh=JS/OgZbRfXQVDoN5rCEv3BGagEhB1TLJSS5HOGFUyfE=;
 b=K3JYqveZhx/r7I0+x1XBAoK89vfMvr38DN59TiNdNouTh2WwZB7jlbRRndY70VentV
 DagTOiJZ0bY/MAYwG7amV8ysFJpVR/Tm1BDi8nmUoB4h3riRudbNuIoog2Iu3i/Wzz3I
 3cLh14CL/jsW1Mrbpz8ojhkjdE4iqlruS7GCoJ9g8HeyRTgf5H8Fmy6B0n8Egl8hd+RB
 c0U7pqak4pT/Ii+c+nu7CcYLQkzQqxf3myGHRPeBIurEgtcdlx2Ru5b7oYvyHf32SXum
 QJ35Yzw26O4QwfxFtNQBYKiCX7nCYrGb+LB8o+V9EQxNwEiNHVcpnfBBZX7L86mM4dc4
 APsA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788967024; x=1789571824; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=E1ZCYJPanKEUN5Fpup9LTVNtGhRs0b+VZRJpHuHAouQ=;
 b=Axhs9gJJdJ5ToLMR3AzbUrPg1++jdxd6j1jXQ04HsITr3n238zRg7EVVOiqnbQ67oA
 d4gNo5EtQueP6P1i9FM6rY0CnAvTuNJALHbs3cpRiL/NK5/aBYFva7Nn3QiOOLufjx3c
 MGMQy0CPw/TV1Jv+ksCxfIEUPJK+wuKn3PziQv0Eb1CiSAY7XLvy6qMoovP2ZYrnpC/W
 r1hZgfLxY+p526zDGfqGbj0RNaqypv7YSDmbs/z1GZzpwjgBEOwd24sZeNvoJ0jrk5GW
 nT/Ce+zyckiw/uKL/ktC+ldhQIf8zHgJpbuJM/YtGhMxyCBSfycdsSojhA41QKDJqamE
 mNdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788967024; x=1789571824;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=E1ZCYJPanKEUN5Fpup9LTVNtGhRs0b+VZRJpHuHAouQ=;
 b=dQbL3/mn8llAS0OXWxhw5I4ewAzNcRouCBc7P5kgGDu/DnzumeJIKZ/1Yq00JXXwyR
 yfVoq0yzoxwz1fZRT1m8oX3rXaNA1tanKvxFbzIIlqfEjFE8zHdnIDngtSGMwIVIjex2
 XELtENBD2Ky4CXVATXizVmvx1ShwYzX1MurWbUFdBamZmHoPNOu8oGWQXb4DuxD1wfbP
 MuPZ/GGVwW9tFKRKNfIhG+TzdvQpBagm9lkqSck0bScjCySH5gkxs9dsX4muojC2rVzE
 ZWSs/4/GneltC89DsoF5IjU5PHeBztgva0FYmCBNRXzwV2r/y9jf4pEvkHevymhseJwU
 AO1w==
X-Gm-Message-State: AFuF++kYzLlPXHbzGeWaiVRGGY65PEH6cDOPvXCZD08TqG706F9R8zv5
 d/6pdaShPlgD8V7lAychOzi1FfK6GI899Bcosy32yM3Hun5GYGWH7fI86TNTgwxwnFMpeIqcDyA
 uIJI9zPv2cQng8emuFYQ4ybVUhWHLzKfQf1MjrRWGxOj5V59XGoSLQTr7nPgjMy/p/PYtTsaLyY
 ztF9LaRROyMnZYnET9GbQ15EXsgwbTuVZd
X-Gm-Gg: AYBFou3LbSadEV5iJ2NtwxnwzMl1dl0Sxf//Pl1Pa49GzF57asZP8cLhNfcKv4zrjTy
 5OzYajNC1wkA/SFObcr5KUcFe+UD0HX1oEYfUWeQmbG/HbozQPD/yrfCAmXOEVPPTFwCLWRF2cz
 PNbBTSa86Mqcy+4ldgk+NifoYwhpJRPAlnwblDX96fLNxUoo9uCF5ptOiTNhE=
X-Received: by 2002:a05:6820:80c4:b0:6b1:9f02:e2da with SMTP id
 006d021491bc7-6b6fd2d0770mr18576505eaf.20.1788967023664; 
 Wed, 09 Sep 2026 08:17:03 -0700 (PDT)
X-Received: by 2002:a05:6820:80c4:b0:6b1:9f02:e2da with SMTP id
 006d021491bc7-6b6fd2d0770mr18576475eaf.20.1788967023173; Wed, 09 Sep 2026
 08:17:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260909040137.3414132-1-brian.cain@oss.qualcomm.com>
 <20260909040137.3414132-7-brian.cain@oss.qualcomm.com>
In-Reply-To: <20260909040137.3414132-7-brian.cain@oss.qualcomm.com>
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
Date: Wed, 9 Sep 2026 10:16:52 -0500
X-Gm-Features: AcwNN1Wvw4agXiTBYl_162xNQwrUDAWJXn2jUYNl7m4iY3OW0mxYxRCA-91BTSg
Message-ID: <CAJ+KCYPU7V46TMCB7A8GDxaF52aVAhrPwRjm6ShkdLiLp4FO5w@mail.gmail.com>
Subject: Re: [PATCH v2 6/9] hw/hexagon: move "sim" alias to "V81QA_1"
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: kn8ztBNZvLQ6A8fYgdobTWv84jrd0rwR
X-Proofpoint-GUID: kn8ztBNZvLQ6A8fYgdobTWv84jrd0rwR
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDE2OSBTYWx0ZWRfX2GT8joCyfALt
 uzp4KG7LqwT0G441sSbDEG4RYaRqBp+8rD/xrY+OM/wxAmKsgiUxorIKSTpHwY/7bGrrWfUkc5F
 zM4DvkF+kcsrv5SY/5joaqJXaiG2YxA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDE2OSBTYWx0ZWRfX0U1QXMey5C5g
 zugjsCds7MUcXBEUiWaajrsRyyxW6YVplnmOCVAhnvtxWYe96/ErtpuqC3hAr6Hv0wV2Aue6Sl7
 vaWKOVDnHVIJ4YWNcxzy/WiqIgHKDYTC4u6WbA57Lj3JzRTReD1KsTPFZOlSMaWtX2FYkYZ0rol
 H4QZ3eVgfpHroj9crG2DBLDkbHjtpOzOEd04X2k9H0bMpxg3tm+kvF4rdlHVcs/Lx6OkM2HAL0E
 XrFHIcoiUPzfKrQ/tOHHWuKR+LrzBGhH1ONd+iMsYcw4ibq67x8R29UzTx60mBAaJOZJRm+h/RK
 N9kIZfBa4t2G5qFX7Jcz0IppK4hej99LNIwkFgNl+gYPSESp30SUjwuNAzrJI9M8DNwwZt4OTMi
 ewhXoVvEjmuErwYHKPKb/YJUpvMJHZUof0cZjDowQpXT3UhznAVU/b2rxiLYPPhHDIEeQ0GKkBn
 LYl9U93EaG39XKK/GVA==
X-Authority-Analysis: v=2.4 cv=SvWgLvO0 c=1 sm=1 tr=0 ts=6aa17870 cx=c_pps
 a=V4L7fE8DliODT/OoDI2WOg==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8 a=23d5uusTl2BlQtvlxwUA:9
 a=QEXdDO2ut3YA:10 a=WZGXeFmKUf7gPmL3hEjn:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 phishscore=0 bulkscore=0 malwarescore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609090169
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=marco.liebel@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On Tue, Sep 8, 2026 at 11:02=E2=80=AFPM Brian Cain <brian.cain@oss.qualcomm=
.com> wrote:
>
> The 'sim' machine name is an alias for 'most up-to-date/capable
> hexagon-sim-style-memory-map machine', so with new v81 machines
> available, we'll update the alias.
>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  hw/hexagon/hexagon_dsp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Marco Liebel <marco.liebel@oss.qualcomm.com>

