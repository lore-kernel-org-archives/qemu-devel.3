Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC500C282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 20:55:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqIEu-0003sx-Db; Thu, 06 Mar 2025 15:54:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tqIEq-0003sP-Qf
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 15:54:41 -0500
Received: from mail-qv1-xf36.google.com ([2607:f8b0:4864:20::f36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tqIEp-0007IH-0q
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 15:54:40 -0500
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-6dd01781b56so12593256d6.0
 for <qemu-devel@nongnu.org>; Thu, 06 Mar 2025 12:54:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741294477; x=1741899277; darn=nongnu.org;
 h=thread-index:content-language:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=CnYHucooGaAXY2064xNbGWLhCt1uNxUd/BhYmJqcNHA=;
 b=UF4dhqjWST1MRM+Bau0+kk4VwmZFixxYGsDuEy6JoubiF68H1PulwVvcpAMImCVXOZ
 p2Uw2ystNA9CEDNr+o0YGQHIdcOnLIPWIog1Np9BeluiI6WgMmFKlIBmnIsoZHGBo+Al
 DxiyKPaVvRaX+XGKSUABZlNqyPPzsUVjwufGMgvwgx24MnX5Cya38ozWTbOJ3tLqv1DJ
 1ZY0MVGpOjm5x6qNAlYybvk/uro6yThhDeiMXEUQkIauelL3zWbqF4VlWfOr/JwqnlI+
 tZdvSxVKAkIjvZwgUWCdyPRI6OsOzOcToUo+9n0bMYit8+L6AChoGT+5PDWryCgSeim+
 u+DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741294477; x=1741899277;
 h=thread-index:content-language:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CnYHucooGaAXY2064xNbGWLhCt1uNxUd/BhYmJqcNHA=;
 b=qh8kbwdfXBQXAhDeESl1kRl9Mcl5S8LppIam6OKRx/WYvAntQ9/tk4BJFr6HMu9GmR
 o7sy+HmGX5EBXPfIkSS1NlA2bn1otWmPcEPUQH0hza/NYvnvSLRQ8pVBPGnU7bHT/Mkv
 GZ9HL3XYbAj4fRa+CKGZLNYUJIkvNMuHKtYOp6JD0vsX4hx7gVufR3bsc1glxJEHQQh9
 lIKcA2jGJWYAmjqf8xPZcgMs/69WS0H055KMGskunQx63y/v+EmCSX9XaM6ImXXMJgqC
 xcehY3a46N4psWpRXBfpEoYk7CONXPKE2u1VHDzCSRg0+E6p2aHzeMGTalyY76Wc2TS9
 IKkQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWGcw+zyf80APEfaPOKontTr2p+mGPc1Jk+DCaYjhygYsSqp9S1gwLzxqjxKVSqOZvQemTQ0hEhynC@nongnu.org
X-Gm-Message-State: AOJu0Yx2xxENozSKU1eDTckm5tSfV2N2xuGKoiseorCS3bvnqwlo0UGA
 kMuEW+HT443iMGwiXf+qU8E19RS9dV25GJawrtiULzmlY11l7N8G
X-Gm-Gg: ASbGncv9MlMPL2WiZTLUyJxDczi1Co9CLL+YsrDg4cmWtCIv9waZXZs1ddinnff5ozC
 GaTdeqipDvd9mSymFLlEfhRU83VMpNvoSBdBZh0Zhhuh5AP5tXTGlklyXJPIPyzZWpAKps1kFVL
 mW3gijverMilCod9jxUEE5LHfCMQzOj/Aux+fO3Fzh3m4beYZlP+xfWfAeGJBUgglODjinSPLoB
 XQUqkCm/XA6z8tDUbp0ciEH0dPuMzIl/SDU1ajetDneF/iDltTC1LewBlHpdCa9dMvMpUIp4FfI
 MHVgZSo05gdzNrWuxNvT8eOyv3tHqqczL3hbnLXND9GQa/fdWEewSfKM9i0YAY0=
X-Google-Smtp-Source: AGHT+IFiP1+JJLXgAeIyyJAhPRnb+caemP+uNitSreYsfJFpP9htjRzl8hHdpUqm6oW6W6XA/JVUbA==
X-Received: by 2002:a05:6214:cc9:b0:6e8:fa38:46aa with SMTP id
 6a1803df08f44-6e900675184mr7455906d6.33.1741294477356; 
 Thu, 06 Mar 2025 12:54:37 -0800 (PST)
Received: from DESKTOPUU50BPD ([2603:6000:a500:306:f449:4838:1970:9d05])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e8f7090cc1sm11049626d6.32.2025.03.06.12.54.35
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 06 Mar 2025 12:54:36 -0800 (PST)
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
Date: Thu, 6 Mar 2025 14:54:35 -0600
Message-ID: <022901db8ed9$f8ae1fd0$ea0a5f70$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AQERX/uiI+LG127bCFnOJB03IqEGrgIkiLuRtOnIhjA=
X-Antivirus: Norton (VPS 250306-6, 3/6/2025), Outbound message
X-Antivirus-Status: Clean
Received-SPF: pass client-ip=2607:f8b0:4864:20::f36;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-qv1-xf36.google.com
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
> Sent: Friday, February 28, 2025 11:26 PM
> To: qemu-devel@nongnu.org
> Cc: brian.cain@oss.qualcomm.com; richard.henderson@linaro.org;
> philmd@linaro.org; quic_mathbern@quicinc.com; ale@rev.ng; anjo@rev.ng;
> quic_mliebel@quicinc.com; ltaylorsimpson@gmail.com;
> alex.bennee@linaro.org; quic_mburton@quicinc.com;
> sidneym@quicinc.com; Brian Cain <bcain@quicinc.com>
> Subject: [PATCH 03/38] target/hexagon: Add System/Guest register
> definitions
>=20

Based on the subject, I was expecting to see the register definitions in =
CPUHexagonState.  A better description would be
target/hexagon: Handle system/guest registers in gen_analyze_funcs.py =
and hex_common.py


> From: Brian Cain <bcain@quicinc.com>
>=20
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/gen_analyze_funcs.py |  21 +++-
>  target/hexagon/hex_common.py        | 163
> ++++++++++++++++++++++++++++
>  2 files changed, 181 insertions(+), 3 deletions(-)
>=20
> diff --git a/target/hexagon/hex_common.py
> b/target/hexagon/hex_common.py index 758e5fd12d..db50defeb6 100755
> --- a/target/hexagon/hex_common.py
> +++ b/target/hexagon/hex_common.py
> @@ -33,6 +33,41 @@
>  overrides =3D {}  # tags with helper overrides  idef_parser_enabled =
=3D {}  # tags
> enabled for idef-parser
>=20
> +class GuestRegister(Register):
> +    def gen_check_impl(self, f, regno):
> +        if self.is_written():
> +            f.write(code_fmt(f"""\
> +                if (!greg_writable(insn->regno[{regno}],
> +                    {str(self.is_pair()).lower()})) {{
> +                    return;
> +                }}
> +            """))
> +        else:
> +            f.write(code_fmt(f"""\
> +check_greg_impl(insn->regno[{regno}], {str(self.is_pair()).lower()});

You can indent this, the code_fmt function will handle it properly in =
the output.  Are you worried about making the line too long for =
checkpatch?

> +            """))
> +
> +class GuestDest(GuestRegister, Single, Dest):
> +    def decl_tcg(self, f, tag, regno):
> +        self.decl_reg_num(f, regno)
> +        self.gen_check_impl(f, regno)
> +        f.write(code_fmt(f"""\
> +            TCGv {self.reg_tcg()} =3D tcg_temp_new();
> +            gen_read_greg({self.reg_tcg()}, {self.reg_num});

Do you need this read if it's a destination register?

> +        """))
> +    def log_write(self, f, tag):
> +        f.write(code_fmt(f"""\
> +            gen_log_greg_write(ctx, {self.reg_num}, =
{self.reg_tcg()});
> +        """))
> +    def analyze_write(self, f, tag, regno):
> +        f.write(code_fmt(f"""\
> +            ctx_log_greg_write(ctx, {self.reg_num});
> +        """))
> +
> +class GuestSource(GuestRegister, Single, OldSource):
> +    def decl_tcg(self, f, tag, regno):
> +        self.decl_reg_num(f, regno);
> +        self.gen_check_impl(f, regno)
> +        f.write(code_fmt(f"""\
> +            TCGv {self.reg_tcg()} =3D tcg_temp_new();
> +            gen_read_greg({self.reg_tcg()}, {self.reg_num});
> +        """))
> +
> +class GuestPairDest(GuestRegister, Pair, Dest):
> +    def decl_tcg(self, f, tag, regno):
> +        self.decl_reg_num(f, regno)
> +        self.gen_check_impl(f, regno)
> +        f.write(code_fmt(f"""\
> +            TCGv_i64 {self.reg_tcg()} =3D tcg_temp_new_i64();
> +            gen_read_greg_pair({self.reg_tcg()}, {self.reg_num});

Read needed?

> +        """))
> +    def log_write(self, f, tag):
> +        f.write(code_fmt(f"""\
> +            gen_log_greg_write_pair(ctx, {self.reg_num}, =
{self.reg_tcg()});
> +        """))
> +    def analyze_write(self, f, tag, regno):
> +        f.write(code_fmt(f"""\
> +            ctx_log_greg_write_pair(ctx, {self.reg_num});
> +        """))
> +
> +class GuestPairSource(GuestRegister, Pair, OldSource):
> +    def decl_tcg(self, f, tag, regno):
> +        self.decl_reg_num(f, regno)
> +        self.gen_check_impl(f, regno)
> +        f.write(code_fmt(f"""\
> +            TCGv_i64 {self.reg_tcg()} =3D tcg_temp_new_i64();
> +            gen_read_greg_pair({self.reg_tcg()}, {self.reg_num});
> +        """))
> +
> +class SystemDest(Register, Single, Dest):
> +    def decl_tcg(self, f, tag, regno):
> +        self.decl_reg_num(f, regno)
> +        f.write(code_fmt(f"""\
> +            TCGv {self.reg_tcg()} =3D tcg_temp_new();
> +            gen_read_sreg({self.reg_tcg()}, {self.reg_num});

Read needed?

> +        """))
> +    def log_write(self, f, tag):
> +        f.write(code_fmt(f"""\
> +            gen_log_sreg_write(ctx, {self.reg_num}, =
{self.reg_tcg()});
> +        """))
> +    def analyze_write(self, f, tag, regno):
> +        f.write(code_fmt(f"""\
> +            ctx_log_sreg_write(ctx, {self.reg_num});
> +        """))
> +
> +class SystemSource(Register, Single, OldSource):
> +    def decl_tcg(self, f, tag, regno):
> +        self.decl_reg_num(f, regno);
> +        f.write(code_fmt(f"""\
> +            TCGv {self.reg_tcg()} =3D tcg_temp_new();
> +            gen_read_sreg({self.reg_tcg()}, {self.reg_num});
> +        """))
> +
> +class SystemPairDest(Register, Pair, Dest):
> +    def decl_tcg(self, f, tag, regno):
> +        self.decl_reg_num(f, regno)
> +        f.write(code_fmt(f"""\
> +            TCGv_i64 {self.reg_tcg()} =3D tcg_temp_new_i64();
> +            gen_read_sreg_pair({self.reg_tcg()}, {self.reg_num});

Read needed?

> +        """))
> +    def log_write(self, f, tag):
> +        f.write(code_fmt(f"""\
> +            gen_log_sreg_write_pair(ctx, {self.reg_num}, =
{self.reg_tcg()});
> +        """))
> +    def analyze_write(self, f, tag, regno):
> +        f.write(code_fmt(f"""\
> +            ctx_log_sreg_write_pair(ctx, {self.reg_num});
> +        """))
> +
> +class SystemPairSource(Register, Pair, OldSource):
> +    def decl_tcg(self, f, tag, regno):
> +        self.decl_reg_num(f, regno)
> +        f.write(code_fmt(f"""\
> +            TCGv_i64 {self.reg_tcg()} =3D tcg_temp_new_i64();
> +            gen_read_sreg_pair({self.reg_tcg()}, {self.reg_num});
> +        """))
> +


