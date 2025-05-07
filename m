Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32D51C3ABBF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 13:39:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCeys-0002vj-FM; Wed, 07 May 2025 09:38:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uCeyq-0002rG-9M
 for qemu-devel@nongnu.org; Wed, 07 May 2025 09:38:36 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uCeyo-0004RN-4u
 for qemu-devel@nongnu.org; Wed, 07 May 2025 09:38:35 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-ac2ab99e16eso567103866b.0
 for <qemu-devel@nongnu.org>; Wed, 07 May 2025 06:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746625112; x=1747229912; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=abUIGekY0M+yHm10Wb5faGO2cpyDSSRRHEFzns+9RIA=;
 b=PTa6zI5eUKclhy2zY+R7Zfv/HgnaeC/E7+ABZTCk1Bfit4tFdPB/gz3ytUWEpPqoHv
 fTPmDjc8DBjK4lOtTjpE3tU/PMOuZu9Pmrp8/pSi7S84SMTHtnbcaZqUk0pysPi5fde7
 frrvpeonVj1+FJOvXQ8ripdIS0uJW68md9pkorZoxiNDrwRUJNvn7J/0I+9c19cAKOVG
 u9/yFmA4xtvLoTJzXQHYzwXch5RkHoEW+pu2JaYaAVR/15y/YJJRLCupVNIomz9NtQaO
 NZnXzJSySI7jUmu76VEymv1CKGP3IH63d5sVtOB55OQixd4WdSrzDZCXpREri79bGOm1
 RTAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746625112; x=1747229912;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=abUIGekY0M+yHm10Wb5faGO2cpyDSSRRHEFzns+9RIA=;
 b=aWdw5olulR+/OaGmKDLoqVaPrzCBEPIdXqvOgnH4o6ndLeQr6PBJ+W5m1iWb+6lfnF
 aqpg386Kw9J1rUVF/fj0DK8l1SLHmQc2lMtbrwdZQ619/SW98VUnA40uUneB8iFoX+Of
 jICDIZf9FIOygJ37MH3l9KJN9ka2GeZIsiiuvunwRSIDSeHYXfLYrgXm5KlTY1ArpEth
 NJdUmEIj7MNdNeVSY/uVhr+i70OY0p6gCzDW9SGwukPbvcr2CrSKYrVsE/CUCcDk4jn3
 QXAwQXiOKbyCjLp07bwkiDN5Sbhn9VIQiFWflfZXXqNIcQ/71sEjVoTAv1BlcRlLChdR
 wJQA==
X-Gm-Message-State: AOJu0YyKBSHzhAAXwmxz/kMlOErhF5bggc8GUYY5KpMdWifiEBccTAVf
 GzrVS0nGVqJCtZ9PJSG7VLoHx8gTzvtrZRpbFy9bR6h/P73PPabZJRlzJfdXmA0=
X-Gm-Gg: ASbGnctAKVdJvwoNUYGAVELGiC1pNuhT6yatdmndZtK0YpuTNbu/nJTsHaGQ6gU21T7
 iY+XEpe9wQZR+IpKYTxZUbZSZUPFLEi9/zPWoCXAES+y/rz7n6c4GvwqeMfVQkaZfKiXpyODtbP
 yFZadgtIJCrq53ZK7s0nvcmyhCmv6EfbGIj904M4DZxQAAnRXgX8x8J2FNo1FqzW1+dMrLj4wp0
 gO0vMWRPk/Dde9Ge1i6Z1rAmbzr8uvLG3sUYkYSeoRrpYJY/ir2jGsJFkwhnjRKz+/ERFEMuMCT
 RoapODo1rXVUEJmigrjufXlyPN/CxtVUCUchkxOMoSY=
X-Google-Smtp-Source: AGHT+IGtogAlqbRa4xcxChSZ2bTAkRk5OkGBYPrfXwWEW9O6MhWw46d/AukWWI5IRAfLFBcpU1XC+w==
X-Received: by 2002:a17:907:d510:b0:acb:b966:3a8f with SMTP id
 a640c23a62f3a-ad1e8cd6eb0mr315838566b.39.1746625111492; 
 Wed, 07 May 2025 06:38:31 -0700 (PDT)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad189146a01sm897077366b.5.2025.05.07.06.38.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 May 2025 06:38:30 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id F12795F858;
 Wed,  7 May 2025 14:38:29 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Dominik Czarnota <dominik.b.czarnota@gmail.com>
Cc: qemu-devel@nongnu.org,  gustavo.romero@linaro.org,
 richard.henderson@linaro.org,  philmd@linaro.org,
 manos.pitsidianakis@linaro.org,  "Patryk 'patryk4815' Sondej"
 <patryk.sondej@gmail.com>
Subject: Re: [PATCH] gdbstub: Implement qqemu.Pid packet
In-Reply-To: <CABEVAa1WSYFjxJ-am6UNzZD+JCbyyPmawQhD+-oSxcNkVsQoGA@mail.gmail.com>
 (Dominik Czarnota's message of "Wed, 7 May 2025 13:26:24 +0200")
References: <20250404102603.59936-1-dominik.b.czarnota@gmail.com>
 <87ecx7w3qk.fsf@draig.linaro.org>
 <CABEVAa1WSYFjxJ-am6UNzZD+JCbyyPmawQhD+-oSxcNkVsQoGA@mail.gmail.com>
User-Agent: mu4e 1.12.10; emacs 30.1
Date: Wed, 07 May 2025 14:38:29 +0100
Message-ID: <87msboo816.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x634.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Dominik Czarnota <dominik.b.czarnota@gmail.com> writes:

> Hi,
>
> We need the `qqemu.Pid` packet only for the QEMU system part in order
> to figure out the page tables and to do it efficiently.

Page tables of QEMU itself or the page tables for the guest its managing?

> We do have a fallback to using `monitor info mem` but it is slow, (iirc) =
doesn't provide all the necessary information and
> (iirc) isn't implemented on all architectures.

That can be fixed. If it's useful information to clients of QEMU it
would be better to have a well defined API for accessing it.

This is a gdb monitor call and not an HMP one right?

> Also, is the QEMU own pid leak such a problem? There are worse issues tha=
n that available with current features though I
> believe they are not really security issues. I will detail this in a
> private email to you.

Sure - enabling gdbstub inherently gives the user quite privileged
access to QEMU's guests - including the ability to execute arbitrary
syscalls on behalf of the remote.

My main concern is adding support for a non-standard packet that is used
for a hacky workaround when a better solution might be possible.

>
> Best,
> Dominik 'Disconnect3d' Czarnota
>
> On Fri, 2 May 2025 at 15:18, Alex Benn=C3=A9e <alex.bennee@linaro.org> wr=
ote:
>
>  Dominik 'Disconnect3d' Czarnota <dominik.b.czarnota@gmail.com> writes:
>
>  > This patch adds support for the `qqemu.Pid` packet to the qemu
>  > gdbstub which can be used by clients to get the QEMU process PID.
>  >
>  > This is useful for plugins like Pwndbg [0] or gdb-pt-dump in order to
>  > inspect the QEMU process memory through the /proc/self/{maps,mem}
>  > interfaces. Without this feature, they have to rely on doing an
>  > unreliable pgrep/ps output processing.
>
>  That seems a little thin a reason for QEMU to expose its own PID. For
>  user-mode you can already get that detail through anything using
>  gdb_append_thread_id().
>
>  For system-mode leaking QEMU's own pid seems like an information leak at
>  best. There are modes like semihosting which give a remote even more
>  power but you need to at least opt in to that.
>
>  >
>  > This patch has been developed by Patryk, who I included in the
>  > Co-authored-by and who asked me to send the patch.
>  >
>  > [0] https://github.com/pwndbg/pwndbg
>  > [1] https://github.com/martinradev/gdb-pt-dump
>  >
>  > Co-authored-by: Patryk 'patryk4815' Sondej <patryk.sondej@gmail.com>
>  > Signed-off-by: Dominik 'Disconnect3d' Czarnota <dominik.b.czarnota@gma=
il.com>
>  > ---
>  >  gdbstub/gdbstub.c | 10 ++++++++++
>  >  1 file changed, 10 insertions(+)
>  >
>  > diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
>  > index 282e13e163..a077c2c5ed 100644
>  > --- a/gdbstub/gdbstub.c
>  > +++ b/gdbstub/gdbstub.c
>  > @@ -1746,6 +1746,12 @@ static void handle_query_qemu_supported(GArray =
*params, void *user_ctx)
>  >      gdb_put_strbuf();
>  >  }
>  >=20=20
>  > +static void handle_query_qemu_pid(GArray *params, void *user_ctx)
>  > +{
>  > +    g_string_printf(gdbserver_state.str_buf, "F%x", getpid());
>  > +    gdb_put_strbuf();
>  > +}
>  > +
>  >  static const GdbCmdParseEntry gdb_gen_query_set_common_table[] =3D {
>  >      /* Order is important if has same prefix */
>  >      {
>  > @@ -1902,6 +1908,10 @@ static const GdbCmdParseEntry gdb_gen_query_tab=
le[] =3D {
>  >          .handler =3D handle_query_qemu_supported,
>  >          .cmd =3D "qemu.Supported",
>  >      },
>  > +    {
>  > +        .handler =3D handle_query_qemu_pid,
>  > +        .cmd =3D "qemu.Pid",
>  > +    },
>  >  #ifndef CONFIG_USER_ONLY
>  >      {
>  >          .handler =3D gdb_handle_query_qemu_phy_mem_mode,
>
>  --=20
>  Alex Benn=C3=A9e
>  Virtualisation Tech Lead @ Linaro

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

