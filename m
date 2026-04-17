Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0152EF99C66
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 20:52:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDqAw-0006sH-4C; Fri, 17 Apr 2026 16:52:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wDqAt-0006rq-Qo
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 16:52:27 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wDqAs-0001d0-09
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 16:52:27 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63HG4AfC2932850
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2026 20:52:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 9gQ8nxKYIf/4EH6ajlrHLijjyyVVFSIf9cgmdG8S6Gk=; b=luOQibEs9vv7F3wY
 T+ynQiimGMH3znNjPXnWAYenX38TCZYvUIoSNkFmoaDt8DR3oONImN68UPjeuM2G
 GYsC8KYf8/5g+Z0L35rZDzww41OVYhXFGprExzPqBIZ6qe1mqUyBdpDyGjvN6im8
 T84ZH8irASzJTtEAEg/PX/rHHw6LFb4arW6Dg3hnmeqVCu5e+GGWgnFGMvL2PAkG
 xwFm5l3pO3fbq3NJ7MbdQRF1yFjhGsiZMD5rk7RNrmIiLoWEpvy0Z/qpB5S7swgf
 Ft8FohCuHS5P9rZyHjs8QVnylQlD7r8FGxxC65P+pPZaAhUl6Zn62QVwSIhwaU6h
 eB0EEg==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dkhshab0y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2026 20:52:23 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-12c726f4019so1267161c88.1
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2026 13:52:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776459143; cv=none;
 d=google.com; s=arc-20240605;
 b=cu6L/B0lZrdOQhvDwkGzTUkV6IrwsddOKWgynNz0A7O5FWo69EY+3nQIzQSJwoLsP+
 24OqlQD+7lrb3whliKfKXBTJmkEYcPFNMDzjM9KSL+nN77ffFps11ZZCznbAGwQblyTU
 itx8JXtsjU/MvhXDp3Vw2uVvVx8pxzZPEbhGQfHmIaB0cCuFG1YcDHntuVPi+FqJf2ov
 If3NhrcH6SgKVqd4fRWAwG5mFTGeOU30GEq2zzsY3dSbzY4rKmgo1S+t+NHDB26XwETq
 JreGp0gnd7lqbZ56drxGPsyQUxPS94XSx7+Sxw1ZZPgUWyuDE2sCgX1SsXs41KVPBoPh
 GXUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=9gQ8nxKYIf/4EH6ajlrHLijjyyVVFSIf9cgmdG8S6Gk=;
 fh=GWvQFnvgluS9XxOXx8Aj3eG17Oq+EZKzvZqSKBLhuHU=;
 b=LjUCrvy55ZwePJuYFANQwdSNeLR9zkR0J7Re1K6O/LGSyyPFXxptAcspJpY9aEcXcX
 18fc7w0TGVsVS56Fse1FuryiA7X1dXn+Xihxw3CLocaoIzooQT5ybNRzHgZb9HeblS4b
 BGiGUucBT3Coe8c2U0pfQMkcT7RCws284X0wrZ8Qr+Mt9p76lvBUUYOud8OrnMJPwAlP
 6pPqipmIsavyE4t2anYbT9Hk8SiNOBHxYhEt5jUMKKRGtSQBef2vF3OjhyLqTh5+gJ8h
 ekCyWXrgHomm95CmCqnQ3+yeJXfYNkIa+s3adMRBiDKu4humwE+cXZ6HutTAu4TsBGA6
 eIzA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776459143; x=1777063943; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9gQ8nxKYIf/4EH6ajlrHLijjyyVVFSIf9cgmdG8S6Gk=;
 b=Gy1krhGsRt6xjid/SdJ5NUhILzpf+aWpHjh54epAQ0qy3z1c0xDx7cbOChDHFCBSoW
 2+Qv3R2fSAhmcFd14tanp9Vm6t23fpm6DtxVx0huhvujjvbMZqV70FVEpK9Lof6agLVG
 AsOcmbzjnwum4lUAfqCnZEWbqAnrQY8pf25bRDEsmQrUWnzxDU8p3Hktu9fLoRJDkFvC
 C/huDCiAdMEKXGLD7TYOZksNRGqznhLBdCZXga2nEEDz38NW/cGixmX6/8KrdA7ZFq6u
 L7vDeY12hS5qC2t0ZGm5o3ryRJVgjyQkfVGCzTVC/6J1lpxFq3s9DjYMRVnR55AW2jnj
 R6sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776459143; x=1777063943;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9gQ8nxKYIf/4EH6ajlrHLijjyyVVFSIf9cgmdG8S6Gk=;
 b=giE7+w8P8myPbtzwNQMUv/Mj2G2q6uM+7hzmTZpz8jlsZrT56QEVc4vlEozxC9hU6h
 zfG9HiorkDn7uaoaJtCfbGOlHrTVkHXj5egPQOQmpqacM0Q57XiVkdNFerUEjUSI77zp
 8DVNrvMZITRD5103hOJii37IHfKqnOVBAoqxlQZ6cTnHGLa4EC5mN+66V8TunwTHS3b2
 FG/ZWBea0GQE3VdNtgmqfiTdByr9afWjOt5u9MXdqyrUz6jrZ4JmtHhUxamB1pFidUR1
 8fPT+V2BSGcbSyzyUnDc9bD4Tfm9JooLD7voWw+l2N2yjs0ha3PNn1sxdUudB/alr1s1
 g/Qw==
X-Gm-Message-State: AOJu0YwdWbhhloqFnte+P6I9kYOp7J5W1iQuDjjFGOUrj0AO05Fy1dY+
 ufROTlR/FPsXwqCjOtMU+kg4Z0qrV056avCT9olD7cNjw7/4gu6SE39NogOnHM/4N/TBzMffsWa
 KFYlE6MvpH+Ms7g6LUEQ2RqRLMKevDHJexPuyjB/MRs9BIB8xiOFuScOS6OHXEm3UmBVUqh3RXS
 z1R0IxxKuObhnNGsmw/Hz1SXeaIawL5/cwLmL2a68DG+o=
X-Gm-Gg: AeBDiesEF7QKQOIFIT32Z0B7LKPKlizU2ND3XpBb04kq3r7PVBtnYkbGiiDv4/vBcZL
 BT24xIhBZL508iatMtGHH4eoxavMH6uUspqhyQ800Cx1lBH2EnSy6ly2qzusjUP/fnn8NQqZcKN
 H8XG0RCFszYNqS5zUH7wE7KWRAn5forWh4dYJySEyGsf9AYWv8iHlKufRHUQStwz2YSfXw8VsAQ
 khX1bf2ygwqU82aMOg=
X-Received: by 2002:a05:7022:f016:b0:12a:72af:83f5 with SMTP id
 a92af1059eb24-12c73f644a2mr1888133c88.7.1776459142692; 
 Fri, 17 Apr 2026 13:52:22 -0700 (PDT)
X-Received: by 2002:a05:7022:f016:b0:12a:72af:83f5 with SMTP id
 a92af1059eb24-12c73f644a2mr1888125c88.7.1776459142169; Fri, 17 Apr 2026
 13:52:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260417194606.39997-1-pierrick.bouvier@oss.qualcomm.com>
 <20260417194606.39997-3-pierrick.bouvier@oss.qualcomm.com>
In-Reply-To: <20260417194606.39997-3-pierrick.bouvier@oss.qualcomm.com>
From: Brian Cain <brian.cain@oss.qualcomm.com>
Date: Fri, 17 Apr 2026 15:52:06 -0500
X-Gm-Features: AQROBzCAn850jTE02IjeScISBEhxRFH9_nNLpHO2_H5PLluw1ud842e8WOmA9g4
Message-ID: <CAEqNhNaC3OOb_arWa=Yjhr1HVpCLzMvwAiq+UMmzej5kysQx+A@mail.gmail.com>
Subject: Re: [PATCH 2/2] target/hexagon/meson.build: simplify source generation
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, matheus.bernardino@oss.qualcomm.com,
 Marco Liebel <marco.liebel@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=d6/FDxjE c=1 sm=1 tr=0 ts=69e29d87 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8 a=r2ihebJaxEnmDMgX0roA:9
 a=QEXdDO2ut3YA:10 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-GUID: mNfkjPl344P1lmZNhngm9LYvD04-a5zS
X-Proofpoint-ORIG-GUID: mNfkjPl344P1lmZNhngm9LYvD04-a5zS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE3MDIwOSBTYWx0ZWRfXyuwILPhe8OYp
 TRwlm6GiFteDyLn3R2o4fYgC0I4oAMnauN1yjoF6wo9/wSCIMxQDSk8uh46L7sTa2aLiPuEXFcN
 exhyJeXDQ7d1+yyOcD8uLvKN/DxwmhJbj/nSlVJ/UBO7FfStdRBDqG4QiWUEi61EAn/qJpEthl5
 yZQBWJbpHuMu5HhXi9tkj/TEmuxCgOwFEVFx33za/YxkcLtiGUfBldf+NzWKXFmc7kXyXQTlH+O
 sTMhiEEqJYMXeuokds1GoL3CDymX7uv5KLKqh3ftX1iQWJogHvmnzmDJpmiqYufJd1nDoh/Vm8o
 k7fgo4g6DglftlwuyMk6Cupk+pbvW5Qvz1mv3BzEmeUr392kowxQxHE6+drZ3qqoi+7DwflOCPb
 uE1vIrjjxGHFCVd4ueCWsSYG7LCTFCiGXnZxXF3jcMjGZ+/oMkg0yKdLFYWPq6dg7DACnDOWqY0
 yUnIxRQymQtKPPfxmcw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-17_02,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604170209
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On Fri, Apr 17, 2026 at 2:46=E2=80=AFPM Pierrick Bouvier
<pierrick.bouvier@oss.qualcomm.com> wrote:
>
> Use a for loop with a dictionary instead of repeating custom targets.
>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---

Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>

>  target/hexagon/meson.build | 48 +++++++++++---------------------------
>  1 file changed, 13 insertions(+), 35 deletions(-)
>
> diff --git a/target/hexagon/meson.build b/target/hexagon/meson.build
> index d993e1b520..db3f3a5d32 100644
> --- a/target/hexagon/meson.build
> +++ b/target/hexagon/meson.build
> @@ -241,44 +241,22 @@ endif
>  #
>  # Step 5
>  # We use Python scripts to generate the following files
> -#     helper_protos_generated.h.inc
> -#     helper_funcs_generated.c.inc
> -#     tcg_funcs_generated.c.inc
> -#
> -helper_protos_generated =3D custom_target(
> -    'helper_protos_generated.h.inc',
> -    output: 'helper_protos_generated.h.inc',
> -    depends: helper_dep,
> -    depend_files: [hex_common_py, gen_tcg_h, gen_tcg_hvx_h],
> -    command: [python, files('gen_helper_protos.py'), helper_in, '@OUTPUT=
@'],
> -)
> -hexagon_ss.add(helper_protos_generated)
>
> -helper_funcs_generated =3D custom_target(
> -    'helper_funcs_generated.c.inc',
> -    output: 'helper_funcs_generated.c.inc',
> -    depends: helper_dep,
> -    depend_files: [hex_common_py, gen_tcg_h, gen_tcg_hvx_h],
> -    command: [python, files('gen_helper_funcs.py'), helper_in, '@OUTPUT@=
'],
> -)
> -hexagon_ss.add(helper_funcs_generated)
> -
> -tcg_funcs_generated =3D custom_target(
> -    'tcg_funcs_generated.c.inc',
> -    output: 'tcg_funcs_generated.c.inc',
> -    depends: helper_dep,
> -    depend_files: [hex_common_py, gen_tcg_h, gen_tcg_hvx_h],
> -    command: [python, files('gen_tcg_funcs.py'), helper_in, '@OUTPUT@'],
> -)
> -hexagon_ss.add(tcg_funcs_generated)
> +hexagon_gen_files =3D {
> +  'helper_protos_generated.h.inc': 'gen_helper_protos.py',
> +  'helper_funcs_generated.c.inc': 'gen_helper_funcs.py',
> +  'tcg_funcs_generated.c.inc': 'gen_tcg_funcs.py',
> +  'analyze_funcs_generated.c.inc': 'gen_analyze_funcs.py',
> +}
>
> -analyze_funcs_generated =3D custom_target(
> -    'analyze_funcs_generated.c.inc',
> -    output: 'analyze_funcs_generated.c.inc',
> +foreach file, gen_script : hexagon_gen_files
> +  t =3D custom_target(
> +    file,
> +    output: file,
>      depends: helper_dep,
>      depend_files: [hex_common_py, gen_tcg_h, gen_tcg_hvx_h],
> -    command: [python, files('gen_analyze_funcs.py'), helper_in, '@OUTPUT=
@'],
> -)
> -hexagon_ss.add(analyze_funcs_generated)
> +    command: [python, files(gen_script), helper_in, '@OUTPUT@'])
> +  hexagon_ss.add(t)
> +endforeach
>
>  target_arch +=3D {'hexagon': hexagon_ss}
> --
> 2.47.3
>

