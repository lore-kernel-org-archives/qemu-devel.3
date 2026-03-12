Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C42E9106ACEE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 21:04:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0nBe-0000eV-Qi; Thu, 12 Mar 2026 17:03:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1w0nBc-0000eC-Tu
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 17:03:17 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1w0nBb-0002Yv-C5
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 17:03:16 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-82985f42664so951499b3a.0
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 14:03:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773349393; cv=none;
 d=google.com; s=arc-20240605;
 b=bCtseVBrrdn4uvFtMc4KyW8UxB+8YcICCNBzkv4fdnqFu3RAsxpJkBznClxIfg0IWS
 0jjRTEAYG2LAQw7R8zF2gW5emIX7cJNtaLw+D4W9UXaDqP9oktlwZlgCkmvxYTq6HNaA
 qx/yCpawKeEaQbbRLQEIFTRauDevhTiI4bZ3KQHdOaAxuqcLFGec0xU9t8dGKeUoUkno
 Bym9LxXRb75pKUljYnozs7fJDBvlabJcDvAljqklLWHJRKFfYhxg3OmZUljHpQerxJgA
 pzTOKFCB84/b8yMZvOTPDQQ2eVdAxD5EzTTTUJ740EdcK1rqkCxnZDlEOJrj1LWp0l5N
 BRTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=02cCxBjHOLBGeFbg+lEMlFS/0IrnF3+RyyEqM+vc5n4=;
 fh=yiUwoBOEypY2fM3mHrz5u4mbHkIidyv/b4UPGcEpz+k=;
 b=Km/Y0Rpv4qoEfVwDwWDBeCnZDXG65KfFuHvwJrGrFrmqgDVNUVz0xIXpjxoxnZGgVL
 Qk0XHGFJyTGdxX2TWvOBsvKl18EAsg0rYtdAYbzEnyCDYHZ0APHmxfZ0VwcNt5Od8suK
 Xf/vu1i9D2SygzI39cj+6XBO50VyMUr1ullelCKz80uVmYBlFxIZO/0hfWkjT436TCYJ
 15xNsgGbEYKYxetk4kxe9s9E0j8Gxo4cf4Coo+2oyQNWsY4Bb7AyhmELHeuy8TUKs5sk
 s7sHt3KPvlKEa/7CLwYbNDMliAo9l8y2b2Q7X/LN9ziAx8zRInDW+4SrG+xDJ6RocHa1
 K8jA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773349393; x=1773954193; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=02cCxBjHOLBGeFbg+lEMlFS/0IrnF3+RyyEqM+vc5n4=;
 b=UxUVVGVW7iGkU44X/Od8GMvWzTNEUgCGcBZ8fGan63Rkuz4d5vqDO3U8xVVhCFvH9/
 1xhDLoGXjW6woWJuqc7qD/LNhReMs5dCBbxc8emHhBJXuhGoCYdvB9vrXsix/gWpbNai
 k3gCoGFD4mHVvEz+kqDojEVAp4lvjjPB3GIPp4OHjiWtDxEFRRw5S8wtiGVcvgrk6EN1
 WRpcdoaWkVQI0QKmUWc3nMEYKL0WGK3epm1ulBmftFvS1e/xzQNX+kYSRfZewAqZv5v2
 Qvy1a2ybMnvrtsqAr2qQ6l4kkqWL82StOvQo3+5jvrnOacYRBnAxC3YzbhuPJnk2btB4
 orlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773349393; x=1773954193;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=02cCxBjHOLBGeFbg+lEMlFS/0IrnF3+RyyEqM+vc5n4=;
 b=O6/6axG6kpj8A/oLCwVmOGh0D5QTCTjeTTaBTC1nX4xnDA2Hb0egwP45i7tlYwHl6x
 E9FTrbOAsxkWHWQrxakCmt/2Yzu750tMRT79BNuOXt2dydzygo3BZ00dfGZiqPBboRaa
 Of1P/7wzCHpbTWTurrVYjKlGQCiWijMQWJi3h/cmmbhmygNVLeusGyTJdbfvCAWKGpCp
 ST8O9T1bZNFMVnQRf5nUrp3AX+VHecfxzPILAOwK3DbL8cxTgO2Me7mIZOJm2W8Y4BAj
 W0buDk99hiHxaD6WYBU97WicZCLU8u/MI8RA7JO9hgOP6TjuNe+RWLNeJDzKydcylnIE
 +F9A==
X-Gm-Message-State: AOJu0YyHJ1R5GMRoW/QpwZZWTTfD3fjaJwXL4LN124A7BmpowTqF4zwM
 vV/oL3pB3d+tpwpL39P7E2OPmRFrO2wPWfFYEQFyq7u6e7EAMhK2p/UKf50oNP9giIBoEq5/yZZ
 z+qkp/rkzBsLeyQ4kUOT6aii+9KYuCBI=
X-Gm-Gg: ATEYQzw/RC0nrbP52jYtu4NppTxpuGw0NnX2ZW5TFbnZQINh2ZJMoAogyNKvBVdx8Mx
 CRd8onoNUN215L8AFPjpfL+MKaxRrUvtyltjXEhXWeit03Y7ulCyFKY1Bh7ef4ZlcWi4cN8PSVc
 4RbyALspFgw1Bgekb9tB7GSSl52ECRbqJhVPVyPo4SuRhjn0WHpqmp5lNOrvbA9MvAUvca+NlZz
 0O9PHxo5wlF9iwEVhIXMNiaajhvqaSidboIOGW+otvtiuL1Hqgo+4+tgawz7ZRhDm0t3m8a7q0l
 Y3v99IZJuc9wrn3o7/qOtjSeTxjMWanOkOTOlw==
X-Received: by 2002:a05:6a00:7703:b0:824:a1c9:8a30 with SMTP id
 d2e1a72fcca58-82a1971d215mr525086b3a.23.1773349393145; Thu, 12 Mar 2026
 14:03:13 -0700 (PDT)
MIME-Version: 1.0
References: <20260311034923.1044737-1-brian.cain@oss.qualcomm.com>
 <20260311034923.1044737-7-brian.cain@oss.qualcomm.com>
In-Reply-To: <20260311034923.1044737-7-brian.cain@oss.qualcomm.com>
From: Taylor Simpson <ltaylorsimpson@gmail.com>
Date: Thu, 12 Mar 2026 15:03:01 -0600
X-Gm-Features: AaiRm5399Bxy5r82DraAryPfpPdwB0XKmhiI8W3QHh_BM2ZsFBVWMTrnPL_zYWQ
Message-ID: <CAATN3NqZCgqb3b9hAW_0m1Ph-mpmeZ1pCJa3O4Homt2E4zwAnA@mail.gmail.com>
Subject: Re: [PATCH v5 06/35] target/hexagon: Suppress unused-variable
 warnings for sysemu source regs
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com, 
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng, 
 anjo@rev.ng
Content-Type: multipart/alternative; boundary="000000000000a42343064cda14fc"
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--000000000000a42343064cda14fc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 10, 2026 at 9:49=E2=80=AFPM Brian Cain <brian.cain@oss.qualcomm=
.com>
wrote:

> The analyze_read() methods on GuestSource, GuestPairSource,
> SystemSource, and SystemPairSource were no-ops because these
> source registers do not need read-tracking in the analyze phase.
> However, gen_analyze_funcs.py unconditionally declares the
> register-number variable (e.g. GsN) via decl_reg_num() for all
> registers that are read or written.  When building with
> hexagon-softmmu, the generated analyze function bodies are
> compiled (outside the #ifndef CONFIG_USER_ONLY guard), and the
> declared-but-unreferenced register-number variable triggers
> -Werror=3Dunused-variable under both gcc and clang.
>
> Emit a (void) cast on the register number from analyze_read() to
> suppress the warning.
>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/hex_common.py | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>

Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>

--000000000000a42343064cda14fc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Mar 10,=
 2026 at 9:49=E2=80=AFPM Brian Cain &lt;<a href=3D"mailto:brian.cain@oss.qu=
alcomm.com">brian.cain@oss.qualcomm.com</a>&gt; wrote:<br></div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex">The analyze_read() methods on GuestS=
ource, GuestPairSource,<br>
SystemSource, and SystemPairSource were no-ops because these<br>
source registers do not need read-tracking in the analyze phase.<br>
However, gen_analyze_funcs.py unconditionally declares the<br>
register-number variable (e.g. GsN) via decl_reg_num() for all<br>
registers that are read or written.=C2=A0 When building with<br>
hexagon-softmmu, the generated analyze function bodies are<br>
compiled (outside the #ifndef CONFIG_USER_ONLY guard), and the<br>
declared-but-unreferenced register-number variable triggers<br>
-Werror=3Dunused-variable under both gcc and clang.<br>
<br>
Emit a (void) cast on the register number from analyze_read() to<br>
suppress the warning.<br>
<br>
Signed-off-by: Brian Cain &lt;<a href=3D"mailto:brian.cain@oss.qualcomm.com=
" target=3D"_blank">brian.cain@oss.qualcomm.com</a>&gt;<br>
---<br>
=C2=A0target/hexagon/hex_common.py | 16 ++++++++++++++++<br>
=C2=A01 file changed, 16 insertions(+)<br></blockquote><div><br></div><div>=
Reviewed-by: Taylor Simpson &lt;<a href=3D"mailto:ltaylorsimpson@gmail.com"=
>ltaylorsimpson@gmail.com</a>&gt;=C2=A0</div></div></div>

--000000000000a42343064cda14fc--

