Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA6D0C369C4
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 14:45:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u540q-0001DU-9d; Wed, 16 Apr 2025 10:45:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1u540l-0001BW-6Z
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 10:45:13 -0400
Received: from mail-il1-x12a.google.com ([2607:f8b0:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1u540j-0000bY-4V
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 10:45:10 -0400
Received: by mail-il1-x12a.google.com with SMTP id
 e9e14a558f8ab-3d46fddf357so23284425ab.2
 for <qemu-devel@nongnu.org>; Wed, 16 Apr 2025 07:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744814707; x=1745419507; darn=nongnu.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=j09gAotxdlMdRJiQRIJ8apf6JqT1CvStdxiLHjSWONU=;
 b=RUOl3np+tuGE7KBI29UZczcypxMr6IrPQBrl+9ct2CA0vneX0tmWSAdefEL46WlrXr
 /sW+wgshZcvFavDyrNLDLIpXk8VJd18/yEP5SDsa8t8Ndhsdam50sIv+dT4iTBCnzJmn
 zs+/NKBgyrLccuTe2KQjd5L/CXrw1sy9zo6nci2vnSMZo5UT4QQJhLQ/F/uBGlemJyLM
 ELpQKFhBamhG5xx/tr0vLLbCaoMfoDi84iO1VIoDowv2mQE3z6xVnlTpRuqwGVeL2EuM
 T1Hziqfymefxphhh3MoAtCABNHC+LjxWiw+TBL9VA3zr/QleQk0DLyZpflHzKiYkIZFD
 M8qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744814707; x=1745419507;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=j09gAotxdlMdRJiQRIJ8apf6JqT1CvStdxiLHjSWONU=;
 b=UAYeamK1xyI1qAHiILfAnRxPdCFMLCNcCgzQDIV8HZ+0IRajK1ZC+1TNy6Lxa0eWio
 DEXC4fq9FJWV4VwVTLE8TbBCtPqXR2kJFftTGG1gfu2yZenPFk3N5VkkVSGrvHGaRmqx
 KDLX5NmQca80zBl0ZZeZgkezVBg8BbjMUglFZjEma3WKuLMQuw6e5zl4Iki3bStcYPnQ
 lQd9ixHpnxjMQaMji6SGJ0SvKzXIG/piv/m0p4sKKKuI/ySiI/a4Vee5gLOvFPdMNJkm
 yqws4ykRx9IpHVWDnTlVeEeLPgmUGGBCq6IZLRwyYlpb4CAdcKd74KzoSXD2YWfmvr7W
 minQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXbP6LABmeJMrohbUGD3QnTvVYYHwKYuWb767/AFxTnHA5BEwxB7AW0tcASaIjwD8NeFE6iERA+Ytr8@nongnu.org
X-Gm-Message-State: AOJu0YxhNCWE81l2wX9lbUfWEY6uX5l8QdQpBbdJJJngPYYfCaUzIT1p
 7qv20WO+YglkOlg2Vm/QKlwsJU2F/FQ8xdQawXTOg8FI48UtlerK
X-Gm-Gg: ASbGnctzWGrE73derZ+B8lf2zk3OzVcIC6HnW9b2AzuhkpECn6/oangXL8eXhOIFotZ
 AaCUTQv/trXi0zBjnhsZjayL2TW41eeyiWtggyO2BQwh065mneq61jiH4J0n1w7kqTicJp1fJoe
 3aVHsdXGs1kZxBqOmYaB+zgbPruuYAORcy48c70bF5/ruwD+XJpXXWYY2YOVgP60L1DVBXXo6YR
 tfgjRLic1tSj/S/6JoHWUyGo9T2dkB29nj8dFMLqF63use5lLFjhcqWZYK0bVOLIaCv0qkAdRXJ
 4NGfHJ1uuoNQyRKM5TsxKKHCjP2+radd38u/709XeEaN1HC2VVPzrJXRY2+eC25quuqOTY71d/4
 =
X-Google-Smtp-Source: AGHT+IFqfFOi5tk3Ll+C92LBNc8IW/aUNWCQ8rjfrrpMwPA3ZOidtH1j175f/p0QqxoXtkUQlmkL8w==
X-Received: by 2002:a05:6e02:3087:b0:3d3:f9e0:709b with SMTP id
 e9e14a558f8ab-3d815b5e60amr21822105ab.17.1744814707214; 
 Wed, 16 Apr 2025 07:45:07 -0700 (PDT)
Received: from DESKTOPUU50BPD (c-67-190-160-7.hsd1.co.comcast.net.
 [67.190.160.7]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3d817b2693bsm1723625ab.42.2025.04.16.07.45.06
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 16 Apr 2025 07:45:06 -0700 (PDT)
From: <ltaylorsimpson@gmail.com>
To: =?utf-8?Q?'Philippe_Mathieu-Daud=C3=A9'?= <philmd@linaro.org>,
 <qemu-devel@nongnu.org>
Cc: <brian.cain@oss.qualcomm.com>, <quic_mathbern@quicinc.com>,
 <sidneym@quicinc.com>, <quic_mliebel@quicinc.com>,
 <richard.henderson@linaro.org>, <ale@rev.ng>, <anjo@rev.ng>
References: <20250415235542.71703-1-ltaylorsimpson@gmail.com>
 <c7588131-2c4f-4a66-8107-cba4df904278@linaro.org>
In-Reply-To: <c7588131-2c4f-4a66-8107-cba4df904278@linaro.org>
Subject: RE: [PATCH] Hexagon (target/hexagon) Remove gen_tcg_func_table.py
Date: Wed, 16 Apr 2025 08:45:03 -0600
Message-ID: <074e01dbaede$2516b720$6f442560$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKaLHs1ylS/ArO36JsiYcELWqd62wKrQYO0shQHBsA=
Content-Language: en-us
X-Antivirus: Norton (VPS 250416-2, 4/16/2025), Outbound message
X-Antivirus-Status: Clean
Received-SPF: pass client-ip=2607:f8b0:4864:20::12a;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-il1-x12a.google.com
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
> From: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Sent: Wednesday, April 16, 2025 12:18 AM
> To: Taylor Simpson <ltaylorsimpson@gmail.com>; qemu-devel@nongnu.org
> Cc: brian.cain@oss.qualcomm.com; quic_mathbern@quicinc.com;
> sidneym@quicinc.com; quic_mliebel@quicinc.com;
> richard.henderson@linaro.org; ale@rev.ng; anjo@rev.ng
> Subject: Re: [PATCH] Hexagon (target/hexagon) Remove
> gen_tcg_func_table.py
>=20
> Hi Taylor,
>=20
> On 16/4/25 01:55, Taylor Simpson wrote:
> > This can easily be done in C with opcodes_def_generated.h.inc
> >
> > Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
> > ---
> >   target/hexagon/genptr.c              |  6 ++-
> >   target/hexagon/README                |  1 -
> >   target/hexagon/gen_tcg_func_table.py | 66 =
----------------------------
> >   target/hexagon/meson.build           | 10 -----
> >   4 files changed, 5 insertions(+), 78 deletions(-)
> >   delete mode 100755 target/hexagon/gen_tcg_func_table.py
> >
> > diff --git a/target/hexagon/gen_tcg_func_table.py
> > b/target/hexagon/gen_tcg_func_table.py
> > deleted file mode 100755
> > index 299a39b1aa..0000000000
> > --- a/target/hexagon/gen_tcg_func_table.py
> > -        f.write("const SemanticInsn opcode_genptr[XX_LAST_OPCODE] =
=3D
> {\n")
> > -        for tag in hex_common.tags:
> > -            ## Skip the priv instructions
> > -            if "A_PRIV" in hex_common.attribdict[tag]:
> > -                continue
> > -            ## Skip the guest instructions
> > -            if "A_GUEST" in hex_common.attribdict[tag]:
> > -                continue
> > -            ## Skip the diag instructions
> > -            if tag =3D=3D "Y6_diag":
> > -                continue
> > -            if tag =3D=3D "Y6_diag0":
> > -                continue
> > -            if tag =3D=3D "Y6_diag1":
> > -                continue
>=20
> What about all these skipped tags? IIUC gen_opcodes_def.py doesn't =
skip
> them. If it isn't necessary to skip, please mention it in the commit =
description
> for clarity.
>=20
> Regards,
>=20
> Phil.




