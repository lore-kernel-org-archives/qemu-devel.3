Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3858F99C60
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 20:52:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDqAf-0006of-MA; Fri, 17 Apr 2026 16:52:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wDqAe-0006lZ-1n
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 16:52:12 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wDqAa-0001Ym-It
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 16:52:11 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63HG4NhY1985512
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2026 20:52:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 XgQZZ+RNoKBxawhypWAf0L46TkYprmTBzVd2HR/HMqs=; b=gPYlI1ZleMtEch/T
 aP4sA+x0GglIwrPD91FBcVxFtQszH6s1OSUPtfYB9TlFUHvP7Coo+V+HNAJmSnjU
 9jZtbs1ASKy7qCoC2O7RqUBUvxaUnFU3SBCCys5BisiWG12xNX2bCMKxfOegTsMT
 ACUcuih0IexIDBCIU6IQFjJMPl3+e+9zi9wR43lXn3jhIuoTLu7tRWljqqGYWlqS
 Tku+7URGcttzSrWEIxThKcM2cI28ZUAjHW5Qa8UdusbOyXI0QB5ZWQ9pbMSqOp4X
 Yc2jUW3nmNrMW50bP5+3r+FfXnp2z/VS07cNcGk8c2Qhguw+Uz4x1iN/3vfiKD5Q
 h8lD5Q==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dkfyqtthj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2026 20:52:05 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-1270dcd11c1so1765339c88.0
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2026 13:52:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776459124; cv=none;
 d=google.com; s=arc-20240605;
 b=Zf1MRSX4+fXg3QLoX+Z0K8DtQQvQXUPlhT1pCohubHf3xbsCL+dDhPhlaHIaN3unyj
 PmfFCsMu4v9a7Gph1wZUhw7E5sy9JQfHIT4WHCVgQmJEeRXDwlAzP+ljMXYZC5n07rF9
 r0lmnTmdSj0FXuE+VJbl5/A3LW2XskBwerapAsCMpydVjEIFH5FyfnA0JCaF4fWCLOTc
 UvfmGMuASv5VjivwjLRig1Nm0bk7tEt38y+WKQLVq+lLlw43zx7DAoI4RSpnNlWqx+PB
 DHQXjX+2613VR9R5eXP5PIPKnVv2Z3KJL3+hRp5vWomNjS8t1o3jjCR//au48p9BjpSV
 qRrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=XgQZZ+RNoKBxawhypWAf0L46TkYprmTBzVd2HR/HMqs=;
 fh=GWvQFnvgluS9XxOXx8Aj3eG17Oq+EZKzvZqSKBLhuHU=;
 b=Xq5WoQwnsOtG6DWRynFF5q7CYkbAKsHUzbhxIKoFKuW9fei/MhB8wXlxN9qOz2UU7g
 BryTVafdfS7Oi+zGpvdP79MmdAyLdkoO5X9BWWBSY39erbGP4lMIEa9Hwv0VYFdqGv36
 UrUQbBqkvBIpOUu/vqxhx9hvKAJ4Q/oXIlQkd2cQ5bKTDl8gYfBmTfn7towGQegp+4Uj
 8HRxVlIkNN/wrwdTA0mZFtdTAUcVTTLtMfV4Nhn7BU2C6JfsndMoFcO/xx+2Ld8JXp/x
 N8qAGxoKb/Mg79TNyplN7TVU7ZMQSQhdDWJh8ijQ+MDMfORWc0eM4dw2ECaEIB1xDOly
 gR0w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776459124; x=1777063924; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XgQZZ+RNoKBxawhypWAf0L46TkYprmTBzVd2HR/HMqs=;
 b=SYq+HoBaxIxiR51ImE/pCoOiRKBLEcAPxt0qha1QozsxHseiaSIyT72Mocs+FGeycP
 ktlBYxpDBIvbscMv3akUotIvBIGVdU8bNjps0uvsXOZbISqRN12kJJ+IIeDb86LpMwl2
 oGQOnuJkiCeoeOjBC/rvjABwDso82VrZ21uiJGQIGxBKvvCoDA8Eaf2I0feIeAtKObQy
 AhD21UptC9RpdSrApr+8ytHH0Vtl/bo6WjC2ERe7USQLlmOJD4evDHZnmzmQhIKcxkkh
 04luPVKaNamCOeTSNODgwQxrYBo1hIemaud0SNRXYglyqwG0IlQxIU5qHFDGt8l67H4o
 sWzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776459124; x=1777063924;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XgQZZ+RNoKBxawhypWAf0L46TkYprmTBzVd2HR/HMqs=;
 b=r+SZZaj1xeKVpuljSYV4v5AFXHFejyxLnfHz8tV/YfLYI4WHd7A6BYWRefUTwFQzp3
 rEdP69X2GIjOCSQ78AE37j/9H8vbj9iFTWcJS5P3J9jQc0m7h69nXwYspG5+8QWjzlVy
 wxrrJQ/REIQcpkGD08RJx3Op9orrYTPBnKSml7EIHgjU88A6dijac2F640ExWwCg1y3e
 LxmEQre0hDboX6GZAg/brkxqGen0Tjcbr+nIAvWOXdNlxy15zVvxg+uIIClLgjoEYGAA
 LvlVXME5iE4KUXwAVgUcPKbZAIHkBTvl5APG5ATN4Lyrn1yGG6cj+W/4rC/zAgl/ha/C
 XytQ==
X-Gm-Message-State: AOJu0Yxdcm0iHHb0cItLixxk+qHnhUPs3bRkDkE1Hs21wKaVexfLL5Gk
 UJLSob0XgL1rPeD1VAxaGe2/H3bmdTNHBH9TCeIpG97tOjkcktTPCaRp3znGOvkiVpUp5Npll6h
 Cco0kkkc5zqNkzOcKfy6yHfJJhFH9r9byM+jrosiF1qYEpkf0rxKzuoWrJ7W49iwzWeX84pnAhd
 NsKK4Kh5ukSK8rgHFzEqghvTUys37So3KL
X-Gm-Gg: AeBDieuu7TPLRmbtxFOA5nCsj19VtaDVE+hBJNt3xegNrqkk4MZNmtdBDhI1X2K1TGr
 z591Gpot57hQGWC7P+wRN2bg4797fux8xb8+IGY052oCPS/O3vsU03ZL+IpoKGf+A5J6G+4qVZi
 MdKB96bNr/7eFpKSNDYSiJKsxgOdCHdSgfumAUIuk6NAiazsKO8eJ3+cUKTd8cmK/cLccONBaj1
 Dlp7Q9mrusd4jomNc8=
X-Received: by 2002:a05:7022:6b97:b0:12a:6fb7:87e7 with SMTP id
 a92af1059eb24-12c73e2a4ebmr2067568c88.0.1776459124403; 
 Fri, 17 Apr 2026 13:52:04 -0700 (PDT)
X-Received: by 2002:a05:7022:6b97:b0:12a:6fb7:87e7 with SMTP id
 a92af1059eb24-12c73e2a4ebmr2067549c88.0.1776459123804; Fri, 17 Apr 2026
 13:52:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260417194606.39997-1-pierrick.bouvier@oss.qualcomm.com>
 <20260417194606.39997-2-pierrick.bouvier@oss.qualcomm.com>
In-Reply-To: <20260417194606.39997-2-pierrick.bouvier@oss.qualcomm.com>
From: Brian Cain <brian.cain@oss.qualcomm.com>
Date: Fri, 17 Apr 2026 15:51:46 -0500
X-Gm-Features: AQROBzAGOCjWIJoCZGUO7cDwH4ZE_RAxcO5zT1nB8XUeUY_9ju33tLelU4L-_bQ
Message-ID: <CAEqNhNbBfUNjtbT_OLdrEg1Ewj=oVjGePGDOeMV=-SLP1E3ErQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] target/hexagon/meson.build: simplify decodetree file
 generation
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, matheus.bernardino@oss.qualcomm.com,
 Marco Liebel <marco.liebel@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE3MDIwOSBTYWx0ZWRfXx+TRB3aRoD6S
 SoGqXz0AYuQ7Lo4V1kmbsigJt1ykJt6ZUzWGh4uBElunLlDAF+d56JiSoISvtR+47aiYqN6HPyd
 Hr5Oc1r9L0URmRT8JYiJ2ZR80dEjBr7+fh8dUgEYe+nX7sgH7k3krVJKMtJK+ii2Vlky97q2cwV
 F39DIq0s+XPtsdjCzwj8wnJ39djj1NdSjhioFWgKmdmqj6U0I4tjhh8Bzi4/S6z3n4bLzwdGdWN
 RnqK9GKWh/6qWltjWXkWjtMJrR8yXwgERWtlbpm6CvpX5FF+GSZiARPZbIx2MXNyy/wCAqcHkGe
 ld7j1XbNXv7TKb/PALKcoGzkm1L4FvQ+0Li+c8g5YgOfJWiIi5uSMmX5Cjf5Zj5vVh4WqFUxBWn
 AAeVFRONgnYi51azHJozRRh4neKaUSfaOsELIaN+629NphwFTfPKC2WyGehraqs8RIxqVIzF42I
 YLtNfttDAR+fMTEbGNw==
X-Authority-Analysis: v=2.4 cv=BZPoFLt2 c=1 sm=1 tr=0 ts=69e29d75 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8 a=gv8_YtWyk9yl9bUiPxAA:9
 a=QEXdDO2ut3YA:10 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-ORIG-GUID: vF2sa06g79kgn9xgP7tOa27_p9QfV67g
X-Proofpoint-GUID: vF2sa06g79kgn9xgP7tOa27_p9QfV67g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-17_02,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 suspectscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 bulkscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604170209
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
> Use a loop over instructions sets and decodetree generator instead of
> manual custom targets repeated.
> Modify included files accordingly in target/hexagon/decode.c.
>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---

Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>

>  target/hexagon/decode.c    |  14 ++--
>  target/hexagon/meson.build | 145 +++++--------------------------------
>  2 files changed, 26 insertions(+), 133 deletions(-)
>
> diff --git a/target/hexagon/decode.c b/target/hexagon/decode.c
> index dbc9c630e8..4de0541536 100644
> --- a/target/hexagon/decode.c
> +++ b/target/hexagon/decode.c
> @@ -67,15 +67,15 @@ static int shift_left(DisasContext *ctx, int x, int n=
, int immno)
>  }
>
>  /* Include the generated decoder for 32 bit insn */
> -#include "decode_normal_generated.c.inc"
> -#include "decode_hvx_generated.c.inc"
> +#include "decode-normal.c.inc"
> +#include "decode-ext_mmvec.c.inc"
>
>  /* Include the generated decoder for 16 bit insn */
> -#include "decode_subinsn_a_generated.c.inc"
> -#include "decode_subinsn_l1_generated.c.inc"
> -#include "decode_subinsn_l2_generated.c.inc"
> -#include "decode_subinsn_s1_generated.c.inc"
> -#include "decode_subinsn_s2_generated.c.inc"
> +#include "decode-subinsn_a.c.inc"
> +#include "decode-subinsn_l1.c.inc"
> +#include "decode-subinsn_l2.c.inc"
> +#include "decode-subinsn_s1.c.inc"
> +#include "decode-subinsn_s2.c.inc"
>
>  /* Include the generated helpers for the decoder */
>  #include "decodetree_trans_funcs_generated.c.inc"
> diff --git a/target/hexagon/meson.build b/target/hexagon/meson.build
> index d169cf71b2..d993e1b520 100644
> --- a/target/hexagon/meson.build
> +++ b/target/hexagon/meson.build
> @@ -93,135 +93,28 @@ hexagon_ss.add(iset_py)
>  # Step 4
>  # Generate the input to the QEMU decodetree.py script
>  #
> -normal_decode_generated =3D custom_target(
> -    'normal_decode_generated',
> -    output: 'normal_decode_generated',
> +insn_sets =3D {
> +'NORMAL':     ['--static-decode=3Ddecode_normal'],
> +'EXT_mmvec':  ['--static-decode=3Ddecode_hvx'],
> +'SUBINSN_A':  ['--static-decode=3Ddecode_subinsn_a', '--insnwidth=3D16']=
,
> +'SUBINSN_L1': ['--static-decode=3Ddecode_subinsn_l1', '--insnwidth=3D16'=
],
> +'SUBINSN_L2': ['--static-decode=3Ddecode_subinsn_l2', '--insnwidth=3D16'=
],
> +'SUBINSN_S1': ['--static-decode=3Ddecode_subinsn_s1', '--insnwidth=3D16'=
],
> +'SUBINSN_S2': ['--static-decode=3Ddecode_subinsn_s2', '--insnwidth=3D16'=
],
> +}
> +
> +foreach insn_set, decodetree_options : insn_sets
> +  decodetree_file_name =3D insn_set.to_lower() + '.decode'
> +  # generate decodetree file
> +  decodetree_file =3D custom_target(
> +    output: decodetree_file_name,
>      depends: [iset_py, semantics_generated],
>      env: {'PYTHONPATH': meson.current_build_dir()},
> -    command: [python, files('gen_decodetree.py'), semantics_generated, '=
NORMAL', '@OUTPUT@'],
> -)
> -hexagon_ss.add(normal_decode_generated)
> +    command: [python, files('gen_decodetree.py'), semantics_generated, i=
nsn_set, '@OUTPUT@'])
>
> -hvx_decode_generated =3D custom_target(
> -    'hvx_decode_generated',
> -    output: 'hvx_decode_generated',
> -    depends: [iset_py, semantics_generated],
> -    env: {'PYTHONPATH': meson.current_build_dir()},
> -    command: [python, files('gen_decodetree.py'), semantics_generated, '=
EXT_mmvec', '@OUTPUT@'],
> -)
> -hexagon_ss.add(hvx_decode_generated)
> -
> -subinsn_a_decode_generated =3D custom_target(
> -    'subinsn_a_decode_generated',
> -    output: 'subinsn_a_decode_generated',
> -    depends: [iset_py, semantics_generated],
> -    env: {'PYTHONPATH': meson.current_build_dir()},
> -    command: [python, files('gen_decodetree.py'), semantics_generated, '=
SUBINSN_A', '@OUTPUT@'],
> -)
> -hexagon_ss.add(subinsn_a_decode_generated)
> -
> -subinsn_l1_decode_generated =3D custom_target(
> -    'subinsn_l1_decode_generated',
> -    output: 'subinsn_l1_decode_generated',
> -    depends: [iset_py, semantics_generated],
> -    env: {'PYTHONPATH': meson.current_build_dir()},
> -    command: [python, files('gen_decodetree.py'), semantics_generated, '=
SUBINSN_L1', '@OUTPUT@'],
> -)
> -hexagon_ss.add(subinsn_l1_decode_generated)
> -
> -subinsn_l2_decode_generated =3D custom_target(
> -    'subinsn_l2_decode_generated',
> -    output: 'subinsn_l2_decode_generated',
> -    depends: [iset_py, semantics_generated],
> -    env: {'PYTHONPATH': meson.current_build_dir()},
> -    command: [python, files('gen_decodetree.py'), semantics_generated, '=
SUBINSN_L2', '@OUTPUT@'],
> -)
> -hexagon_ss.add(subinsn_l2_decode_generated)
> -
> -subinsn_s1_decode_generated =3D custom_target(
> -    'subinsn_s1_decode_generated',
> -    output: 'subinsn_s1_decode_generated',
> -    depends: [iset_py, semantics_generated],
> -    env: {'PYTHONPATH': meson.current_build_dir()},
> -    command: [python, files('gen_decodetree.py'), semantics_generated, '=
SUBINSN_S1', '@OUTPUT@'],
> -)
> -hexagon_ss.add(subinsn_s1_decode_generated)
> -
> -subinsn_s2_decode_generated =3D custom_target(
> -    'subinsn_s2_decode_generated',
> -    output: 'subinsn_s2_decode_generated',
> -    depends: [iset_py, semantics_generated],
> -    env: {'PYTHONPATH': meson.current_build_dir()},
> -    command: [python, files('gen_decodetree.py'), semantics_generated, '=
SUBINSN_S2', '@OUTPUT@'],
> -)
> -hexagon_ss.add(subinsn_s2_decode_generated)
> -
> -#
> -# Run the QEMU decodetree.py script to produce the instruction decoder
> -#
> -decodetree_py =3D meson.current_source_dir() / '../../scripts/decodetree=
.py'
> -decode_normal_generated =3D custom_target(
> -    'decode_normal_generated.c.inc',
> -    output: 'decode_normal_generated.c.inc',
> -    input: normal_decode_generated,
> -    env: {'PYTHONPATH': meson.current_build_dir()},
> -    command: [python, files(decodetree_py), normal_decode_generated, '--=
static-decode=3Ddecode_normal', '-o', '@OUTPUT@'],
> -)
> -hexagon_ss.add(decode_normal_generated)
> -
> -decode_hvx_generated =3D custom_target(
> -    'decode_hvx_generated.c.inc',
> -    output: 'decode_hvx_generated.c.inc',
> -    input: hvx_decode_generated,
> -    env: {'PYTHONPATH': meson.current_build_dir()},
> -    command: [python, files(decodetree_py), hvx_decode_generated, '--sta=
tic-decode=3Ddecode_hvx', '-o', '@OUTPUT@'],
> -)
> -hexagon_ss.add(decode_hvx_generated)
> -
> -decode_subinsn_a_generated =3D custom_target(
> -    'decode_subinsn_a_generated.c.inc',
> -    output: 'decode_subinsn_a_generated.c.inc',
> -    input: subinsn_a_decode_generated,
> -    env: {'PYTHONPATH': meson.current_build_dir()},
> -    command: [python, files(decodetree_py), subinsn_a_decode_generated, =
['--static-decode=3Ddecode_subinsn_a', '--insnwidth=3D16'], '-o', '@OUTPUT@=
'],
> -)
> -hexagon_ss.add(decode_subinsn_a_generated)
> -
> -decode_subinsn_l1_generated =3D custom_target(
> -    'decode_subinsn_l1_generated.c.inc',
> -    output: 'decode_subinsn_l1_generated.c.inc',
> -    input: subinsn_l1_decode_generated,
> -    env: {'PYTHONPATH': meson.current_build_dir()},
> -    command: [python, files(decodetree_py), subinsn_l1_decode_generated,=
 ['--static-decode=3Ddecode_subinsn_l1', '--insnwidth=3D16'], '-o', '@OUTPU=
T@'],
> -)
> -hexagon_ss.add(decode_subinsn_l1_generated)
> -
> -decode_subinsn_l2_generated =3D custom_target(
> -    'decode_subinsn_l2_generated.c.inc',
> -    output: 'decode_subinsn_l2_generated.c.inc',
> -    input: subinsn_l2_decode_generated,
> -    env: {'PYTHONPATH': meson.current_build_dir()},
> -    command: [python, files(decodetree_py), subinsn_l2_decode_generated,=
 ['--static-decode=3Ddecode_subinsn_l2', '--insnwidth=3D16'], '-o', '@OUTPU=
T@'],
> -)
> -hexagon_ss.add(decode_subinsn_l2_generated)
> -
> -decode_subinsn_s1_generated =3D custom_target(
> -    'decode_subinsn_s1_generated.c.inc',
> -    output: 'decode_subinsn_s1_generated.c.inc',
> -    input: subinsn_s1_decode_generated,
> -    env: {'PYTHONPATH': meson.current_build_dir()},
> -    command: [python, files(decodetree_py), subinsn_s1_decode_generated,=
 ['--static-decode=3Ddecode_subinsn_s1', '--insnwidth=3D16'], '-o', '@OUTPU=
T@'],
> -)
> -hexagon_ss.add(decode_subinsn_s1_generated)
> -
> -decode_subinsn_s2_generated =3D custom_target(
> -    'decode_subinsn_s2_generated.c.inc',
> -    output: 'decode_subinsn_s2_generated.c.inc',
> -    input: subinsn_s2_decode_generated,
> -    env: {'PYTHONPATH': meson.current_build_dir()},
> -    command: [python, files(decodetree_py), subinsn_s2_decode_generated,=
 ['--static-decode=3Ddecode_subinsn_s2', '--insnwidth=3D16'], '-o', '@OUTPU=
T@'],
> -)
> -hexagon_ss.add(decode_subinsn_s2_generated)
> +  # Run the QEMU decodetree.py script to produce the instruction decoder
> +  hexagon_ss.add(decodetree.process(decodetree_file, extra_args: decodet=
ree_options))
> +endforeach
>
>  #
>  # Generate the trans_* functions that the decoder will use
> --
> 2.47.3
>

