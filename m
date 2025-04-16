Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97B83C369BA
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 17:56:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u56yO-00065i-AX; Wed, 16 Apr 2025 13:54:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1u56xp-0005tq-JU
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 13:54:21 -0400
Received: from mail-io1-xd2b.google.com ([2607:f8b0:4864:20::d2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1u56xn-0006t7-R5
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 13:54:21 -0400
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-85dac9728cdso150322239f.0
 for <qemu-devel@nongnu.org>; Wed, 16 Apr 2025 10:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744826058; x=1745430858; darn=nongnu.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=/ldgKTvO9cpgIzyi8W7yr7mgigQLLRiG3P0bpBc924g=;
 b=FxFyR5H8loOuQy2/vCCD7IaKSs6qXvjef6pbZBV54/EizPHEoJ1qL4Q3+2UMEfloUk
 1zuv8LQdZvTbs2MMrYAsBO22k6/knWSV4D6PYI11z5UO1mcWCOiz5PlchsNcCyLQ2HxP
 XDnwhP+ieyDOthRuoaYh0wANMBNu9GlvYsTpUS78jQVphqv3zpf6NrgFiARGLbCj9FeO
 +aajkxdRNDQKwvVWLGnNaGowahrQ4m4SORmC97S/Mlu5VeUD+Xv6W4rN8t+k/WIEy4ao
 kifm2zk8vKeoi9/LX+66NUsHaBkKJbk6SSlHNnJzMl0Ezr8MkpleI7kGJdvbUwWzocS6
 yNzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744826058; x=1745430858;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/ldgKTvO9cpgIzyi8W7yr7mgigQLLRiG3P0bpBc924g=;
 b=ptx2gxbpaDwToX7hAiD9+3qeWbPd4MKOT3o585es/ii/8iFyYUmIZ14cPsilRmV+5P
 r/3Cm7mcnwrgtUw92SEHv/VoewSvAotgxedSSbFhjZT8EHmBkrCJ971t1k/KfWTPzrcM
 6gxvxeujIFCeSyikbf82RLLVnmpVwdS89rVnStffFJCimKDRQPhuDRrE3fmcZqbN2wto
 Ls1h7asang/W1Ay3jZKyGPlyR0bGICQgcZWxa8oUFvCElU4A9hD549C0zAnjEssBDwm7
 nYT5j9fUViRX3KJYuOJT2QQF5598m0w3Fp7f43TxL1/BpMq2ZNXUglAkmSuTN4UPkbs+
 GgUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXVcwtHdes6bKKLA4Yar/+7uWHZvUr5yKdUOtjtSfS/PT+Ju/DeuOTpZuAUWCRMnPKyFpLwjC8WseY6@nongnu.org
X-Gm-Message-State: AOJu0Ywc/Go9Of1eOhwnFg8B5922buxMVfKiDMRD4ZhXmoc0PPwZtxlz
 w1O6sh1RqLVqQBNQiRrkjYtXs5WJCG4PvTki8guHYstJ+lZpwkXQ
X-Gm-Gg: ASbGncvqi0QRxNKqOK6U1Ag3wax0U4+LsNhzkItkEM3Apo9xEg+092bezNsV0uXaXO9
 C1uDviMqyAyXzcwvYoSuj1xGNqVJdsmWxQFdXZpvEGG5z78iTifD6O2klCnNtEW0xYzEZpXsMiV
 NDiJkDipKswAb6DOu/nK9HvutqbaM2pfUmFo0vvNVIR0FfruVp5MpUrnObaC7q5M3FwIEZQQO0A
 hAY2PHof4a63oqPM8FSNKDQDEFXRThXH67OCnjDYqcugDbUyApw6eHpSZW+0jshtY4M1s5dn3T+
 NFCXkC4gC/c4NDBk25vXHxL658YQP4B9y2a4iULXxBj3y9rw6TDdtEXHAqkkSaMrH7fHbl9gLQw
 =
X-Google-Smtp-Source: AGHT+IEm5m7Ve4XiL+43LIyUDzHOoqoC0kwydh0cysAasRyAYnXASSuulDfRURWPyV2HEoW463TE3A==
X-Received: by 2002:a05:6e02:144a:b0:3d5:8922:77a0 with SMTP id
 e9e14a558f8ab-3d815b5e58dmr32515815ab.18.1744826056805; 
 Wed, 16 Apr 2025 10:54:16 -0700 (PDT)
Received: from DESKTOPUU50BPD (c-67-190-160-7.hsd1.co.comcast.net.
 [67.190.160.7]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f505d188absm3766304173.53.2025.04.16.10.54.15
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 16 Apr 2025 10:54:16 -0700 (PDT)
From: <ltaylorsimpson@gmail.com>
To: "'Brian Cain'" <brian.cain@oss.qualcomm.com>,
	<qemu-devel@nongnu.org>
Cc: <richard.henderson@linaro.org>, <philmd@linaro.org>,
 <quic_mathbern@quicinc.com>, <ale@rev.ng>, <anjo@rev.ng>,
 <quic_mliebel@quicinc.com>, <alex.bennee@linaro.org>,
 <quic_mburton@quicinc.com>, <sidneym@quicinc.com>,
 "'Brian Cain'" <bcain@quicinc.com>
References: <20250301052628.1011210-1-brian.cain@oss.qualcomm.com>
 <20250301052628.1011210-4-brian.cain@oss.qualcomm.com>
In-Reply-To: <20250301052628.1011210-4-brian.cain@oss.qualcomm.com>
Subject: RE: [PATCH 03/38] target/hexagon: Add System/Guest register
 definitions
Date: Wed, 16 Apr 2025 11:54:12 -0600
Message-ID: <079301dbaef8$91e8ff10$b5bafd30$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQERX/uiI+LG127bCFnOJB03IqEGrgIkiLuRtSoMM+A=
Content-Language: en-us
X-Antivirus: Norton (VPS 250416-4, 4/16/2025), Outbound message
X-Antivirus-Status: Clean
Received-SPF: pass client-ip=2607:f8b0:4864:20::d2b;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-io1-xd2b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



> -----Original Message-----
> From: Brian Cain <brian.cain@oss.qualcomm.com>
> Sent: Friday, February 28, 2025 10:26 PM
> To: qemu-devel@nongnu.org
> Cc: brian.cain@oss.qualcomm.com; richard.henderson@linaro.org;
> philmd@linaro.org; quic_mathbern@quicinc.com; ale@rev.ng; anjo@rev.ng;
> quic_mliebel@quicinc.com; ltaylorsimpson@gmail.com;
> alex.bennee@linaro.org; quic_mburton@quicinc.com;
> sidneym@quicinc.com; Brian Cain <bcain@quicinc.com>
> Subject: [PATCH 03/38] target/hexagon: Add System/Guest register
> definitions
>=20
> From: Brian Cain <bcain@quicinc.com>
>=20
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/gen_analyze_funcs.py |  21 +++-
>  target/hexagon/hex_common.py        | 163
> ++++++++++++++++++++++++++++
>  2 files changed, 181 insertions(+), 3 deletions(-)
> diff --git a/target/hexagon/hex_common.py
> b/target/hexagon/hex_common.py index 758e5fd12d..db50defeb6 100755
> --- a/target/hexagon/hex_common.py
> +++ b/target/hexagon/hex_common.py
> @@ -33,6 +33,41 @@
>  overrides =3D {}  # tags with helper overrides  idef_parser_enabled =
=3D {}  # tags
> enabled for idef-parser
>=20
> +
> +def is_sysemu_tag(tag):
> +    return "A_PRIV" in attribdict[tag] or "A_GUEST" in =
attribdict[tag]
> +
> +
> +def tag_ignore(tag):
> +    tag_skips =3D (
> +        "Y6_diag",
> +        "Y6_diag0",
> +        "Y6_diag1",
> +    )
> +    attr_skips =3D (
> +        "A_FAKEINSN",
> +        "A_MAPPING",

Add A_CONDMAPPING to this list.

> +    )
> +    return tag in tag_skips or \
> +        any(attr in attribdict[tag] for attr in attr_skips)




