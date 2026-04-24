Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A14EFDEE28
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 01:34:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wG5Qi-0007Cc-EV; Thu, 23 Apr 2026 21:34:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wG5Qg-0007CU-CH
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 21:34:02 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wG5Qd-0002Nn-Vj
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 21:34:02 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63O0pdYe2291547
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 01:33:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 AF0jOiI34wBSKxQYADIW2UT2u889BZJwbPPOmJQNy5Q=; b=oSCiC4v9w5sBvTLa
 LPSNV6ZKR28gdQ9yIQW6rqtdAX+pudF5vAQSmL48BhGKBjTD9kX6w0DZxAbWl/3y
 ruqPLU5pQoj7e9YrjUU+cV77wt7FwTmiaGo8LCog+LJJMlSfFDdaG/+90ircv1PH
 zc6PnjReNYIeRaoJ+7LaEsJfJuXeTeTGXsVt/VM5slxQhMbz1I/s8vrTJwe/UL7p
 WUHfX2F1oZ3El7Mv3B+X2IUjHy2YG8VkWodx/SQ1sXNLpui5IytM8VGDUAbcfJ/6
 itwsDQNlGyDquDiyiv/5j1VeHInSjGh5Ldjx3ZGh7Y5xTpZ28ZxzNIflMJ9dOQ2y
 MVMsFQ==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dqxbp8310-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 01:33:54 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-12db37213daso10236666c88.1
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 18:33:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776994434; cv=none;
 d=google.com; s=arc-20240605;
 b=fQGqPp+ma/G+2ULcbyj8o4/PZZJDcQFtbRBRFGCp2cFK2m8aG8jUXT1IZoxkalHERt
 k1gDnq78SqjGEoGW+LwiDOE/H89xRmrCaKffn/3dwiVyJyRomLbI1EyuA8T0H3XMbmiX
 DWFaA11XgxI4jC2Yk9Rnl6YQAzHYukmAjUNWdWOEFw/acMXDiB31gx481dstIEXn4yOD
 GZ2ao4EKFjj5yM6wk3zjjXXvVia2/XTXXSTGWhIt+GwdCEKS0+uXenn1Qm11sDzfx/k/
 lqmYXwsAfq7/CQfP8lvmcmZFbglDurPhkrRAv/30RZSsgHDyrlbCNT8j9y9Ye22sw45W
 RFIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=AF0jOiI34wBSKxQYADIW2UT2u889BZJwbPPOmJQNy5Q=;
 fh=mhaCdi0utY3C/9dqlRdTrTejHFjDI6FGeJFzKMad2oU=;
 b=CGE/C+QGyX2Yf9NNZFmuxGCMf2Kseq/M+e6YPY8SetupprTTwvU6G0S4PItQntdEiT
 i7QzqeYd6XPDWT4wnjC8yWP1XW+a3eg6xfvGUSpmv6kQHYS70SaoU9yVCRCzWdC8DVXQ
 s2+tqoJyCLzviTXjRNDwnzQUVJ/suhHG/HJNpgg2IhO19BVyOPTLyrwUUpYxj/bdVJYN
 MMfhfH7giVohVCy0uUzDX6GjBXuG7CPuUn9BSME9hzPcnkQtKZapA48axgZWHFTl7pm8
 kFP3R/ljOAokO6fiKChSuZ5MiVs8ChJW22BxrDcDhzn7okbIoO+AUGuRzfX/1wqGVRp8
 4FrA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776994434; x=1777599234; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AF0jOiI34wBSKxQYADIW2UT2u889BZJwbPPOmJQNy5Q=;
 b=bBCyHwll+CwM5DMxGVUkFPfI6Yj6sJN751kxJwV/FpWfsQUguuDhNZ3hvxu5+TeW9D
 HFGKiY+wCvMbKpnceA3Ezuia6J2ZPs1bHNxy3wpVD1umAv7edEXBFNQiYeTOaxzhU9a8
 nMHbJKaMlzDE6yMcHRyo2EL9MrU0yzqRfNJxcAVxOYKMLuNXWXy8H+1DYrKnLA7iDEWu
 jX7y/1VgtezRIsAkp4ElE8XHSd6ZzSYAJK1yf2Wb6KnuTx3gWidoMu3nKte8eDaBQO/P
 G5PWK+9H8a7JUZYo6NxbSdk1BTp5mI0+1b57MIoVVgrz1DW92Q/ksQIV7MCiZnePcj5Z
 8X7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776994434; x=1777599234;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AF0jOiI34wBSKxQYADIW2UT2u889BZJwbPPOmJQNy5Q=;
 b=YS02xbC+pfmpZLN0eUSIGKm60P61DyRff5JiWJCYGpb2newiSo8elqpqqa64KEqr9K
 zwjYJffjuQwsw4MvI6/OlIwFToUowGkNRsUH3+Nrtpr9DiwNk/jjibyX40L5LD9nDStI
 bz63Va3z0v5ycgmvnWVUKyWmDEuvrZ64msFGuKdVL1bXV3KIzunOlQwkwJ8icCShAI8o
 AJUYieixQkWTNJ2RxqTfahvxzuneCAuUcQOWfGR3aBuL34PcjlxTJq7soCPT9eeyugJl
 draROyvOdT+fUPF0bJkqlTZDrqheAAzbB+vHCOegmPnLifKufJziUkofulcpmZj0/uNt
 /cpg==
X-Gm-Message-State: AOJu0Yw/wNhf800myHGwx903Dp1tv1oPzgOEBQNGqU95FTxBeCTJrc+x
 CIc9ZtNIiNxDrWp4Bl5D7Hen25fEeWURJBb/VyUEZb7/Co+sL3Pu45olQUpzLUHEYEs6Z7DCRRc
 PsGYlClzsxWAWzxkaMxJuDyhziYqSY8Iq2VpXFIu+nNCWHFOS90H9TQTTFlBoycVnkGMM16AspQ
 zMhlY5vfKZtoIbjSUzkKI92TfYQ1+Lwk6Y
X-Gm-Gg: AeBDietA5InFakfj/K/i10cNwY0qmupyzqzJc2PVia7BPOZQ1jKUZlIEOrDDMhoVj3h
 q4pKVU3043ONo+JjOmgcPenHW+WerMx+OCvmD5Fsa0kUTyfaWwrXq+UBXo5kKSdodMo5GMXTl+P
 krAg3Y38YTv/BRuY1TfveHBK6dNGB+T+gZvTFKJRYMJcA4oqaJYKrISJQUkklba0aU3tONbrESw
 QiXaHwkYRFmXBUomw==
X-Received: by 2002:a05:7022:6ba1:b0:12a:b932:8221 with SMTP id
 a92af1059eb24-12c73f6c482mr16139851c88.5.1776994433788; 
 Thu, 23 Apr 2026 18:33:53 -0700 (PDT)
X-Received: by 2002:a05:7022:6ba1:b0:12a:b932:8221 with SMTP id
 a92af1059eb24-12c73f6c482mr16139829c88.5.1776994433233; Thu, 23 Apr 2026
 18:33:53 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1776339451.git.matheus.bernardino@oss.qualcomm.com>
 <e94d57178d464c517425391f2698efcd125f56c9.1776339451.git.matheus.bernardino@oss.qualcomm.com>
In-Reply-To: <e94d57178d464c517425391f2698efcd125f56c9.1776339451.git.matheus.bernardino@oss.qualcomm.com>
From: Brian Cain <brian.cain@oss.qualcomm.com>
Date: Thu, 23 Apr 2026 20:33:37 -0500
X-Gm-Features: AQROBzAfYInw13gaQ38-6DLJM8lImcoGo_3NpBfURnEUMF0odwsPlppXrHL7j-o
Message-ID: <CAEqNhNbeu5-yRiMMXRQDPtKDEMm7=ZtFr_GaSbfY+yRLHuz9mQ@mail.gmail.com>
Subject: Re: [PATCH v5 01/16] tests/docker: Update hexagon cross toolchain to
 22.1.0
To: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, ale@rev.ng,
 anjo@rev.ng, ltaylorsimpson@gmail.com, marco.liebel@oss.qualcomm.com,
 philmd@linaro.org, quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: Aj49mUVvJ9FZZQAdPOF7MZmBY93k7zvA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI0MDAxMSBTYWx0ZWRfX3WTPOXdMpLlY
 SJyAQYWl3EacJuIdWYQXAPyrzyJJA/OK0oPnrr/PMOHRl5+omXrKq75qT5/SN1EzxmTd1SFC3BF
 iMiR+ExXnvaGb12vCurNgf42wBpXGBaNfikQmu1MKDQ098lOy2tWucfmC1UKAvxCEZwX5uiu92e
 0g/72xjWTuj4jQCG++LDJwR6IXn+irE7b8U7ARg4adHhKsXCVjuQC/s36jnkUTW/dvB1dEIVZ/2
 pYTCK5XRNGxBahAONLwC8HMAh1pFjAxyGgSRIIJw/xQwlHa+tux0GKnDhc3C4O5ke1oZLle9rD7
 WOI/AE4nYkBZriqs/bAhZKNlBwrXO1SjQyHHFB1u2CpQQbKQR3FXGls6A8Fn4utR7HS69BFeoHh
 GyTF5cpqf5SgU1nyQft6qw4L88S3s5YjfsfHAwUMMP+kxINMpVNp2rGXtGZqaKzmgtvug5OWe8M
 5khW2uUSo1khvhpEntw==
X-Proofpoint-ORIG-GUID: Aj49mUVvJ9FZZQAdPOF7MZmBY93k7zvA
X-Authority-Analysis: v=2.4 cv=X+li7mTe c=1 sm=1 tr=0 ts=69eac882 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=ovJmrJClAAAA:8 a=qC_FGOx9AAAA:8 a=EUspDBNiAAAA:8
 a=KKAkSRfTAAAA:8 a=_ynGqkH91T0FmyWGEGIA:9 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22 a=brTEhlvMp4NY0_u118I2:22 a=fsdK_YakeE02zTmptMdW:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 clxscore=1015 impostorscore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604240011
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On Thu, Apr 16, 2026 at 6:39=E2=80=AFAM Matheus Tavares Bernardino
<matheus.bernardino@oss.qualcomm.com> wrote:
>
> From: Brian Cain <brian.cain@oss.qualcomm.com>
>
> Update the hexagon cross-compiler Docker container to use toolchain
> version 22.1.0, replacing the previous 12.Dec.2023 release.
>
> Changes to accommodate the new toolchain:
>
> - Add libc++1, libc++abi1, libunwind-19 runtime deps for the new
>   LLVM-based toolchain
> - Add zstd for the new .tar.zst archive format
> - Update artifact URL domain to artifacts.codelinaro.org
>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---

I was queuing this container change patch up but ran into some issues
with check_rev_gating failing, seems related to -mv66  vs v68 ELF
flags maybe.

Matheus - can you look into this when you get a chance?  Is it a
problem w/the toolchain or the test case, I didn't get to looking into
it yet.

>  tests/docker/dockerfiles/debian-hexagon-cross.docker | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/tests/docker/dockerfiles/debian-hexagon-cross.docker b/tests=
/docker/dockerfiles/debian-hexagon-cross.docker
> index 91d4b71ac9..636d0ca8a0 100644
> --- a/tests/docker/dockerfiles/debian-hexagon-cross.docker
> +++ b/tests/docker/dockerfiles/debian-hexagon-cross.docker
> @@ -19,7 +19,11 @@ RUN apt-get update && \
>          curl \
>          ccache \
>          xz-utils \
> +        zstd \
>          ca-certificates \
> +        libc++1 \
> +        libc++abi1 \
> +        libunwind-19 \
>          bison \
>          flex \
>          git \
> @@ -40,12 +44,12 @@ RUN apt-get update && \
>      dpkg-query --showformat '${Package}_${Version}_${Architecture}\n' --=
show > /packages.txt
>
>  ENV TOOLCHAIN_INSTALL /opt
> -ENV TOOLCHAIN_RELEASE 12.Dec.2023
> +ENV TOOLCHAIN_RELEASE 22.1.0
>  ENV TOOLCHAIN_BASENAME "clang+llvm-${TOOLCHAIN_RELEASE}-cross-hexagon-un=
known-linux-musl"
> -ENV TOOLCHAIN_URL https://codelinaro.jfrog.io/artifactory/codelinaro-too=
lchain-for-hexagon/${TOOLCHAIN_RELEASE}/${TOOLCHAIN_BASENAME}.tar.xz
> +ENV TOOLCHAIN_URL https://artifacts.codelinaro.org/artifactory/codelinar=
o-toolchain-for-hexagon/${TOOLCHAIN_RELEASE}_/${TOOLCHAIN_BASENAME}.tar.zst
>  ENV CCACHE_WRAPPERSDIR "/usr/libexec/ccache-wrappers"
>
> -RUN curl -#SL "$TOOLCHAIN_URL" | tar -xJC "$TOOLCHAIN_INSTALL"
> +RUN curl -#SL "$TOOLCHAIN_URL" | tar --zstd -xC "$TOOLCHAIN_INSTALL"
>  ENV PATH $PATH:${TOOLCHAIN_INSTALL}/${TOOLCHAIN_BASENAME}/x86_64-linux-g=
nu/bin
>  ENV MAKE /usr/bin/make
>  # As a final step configure the user (if env is defined)
> --
> 2.37.2
>

