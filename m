Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1DE4C83F03
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 16:57:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXNEI-0007vC-JX; Thu, 03 Jul 2025 12:56:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uXNED-0007ut-Bf
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 12:56:05 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uXNEB-0008D5-6b
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 12:56:05 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-60867565fb5so62129a12.3
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 09:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751561761; x=1752166561; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QI7+o1tREJe3qZjR9j+ygkNdK2CxMkJ8vpmr8RlkU7A=;
 b=MuClnQgYrjJ9HsbhFMOLWdxcQSNWh2X/Giy31V1Hic5ipwIuz9OXVAboJ5zSWwiAxM
 biMfFAxL5O8dB5ww2hbC1+4HnY/k+h0Zh8oG/rjgZukf7U8yU3aEv6j3QkdM3UFv4+Ji
 ubeUJ+VpmfbAgbSsa2PjE8xcG09H12y0VOKpvcM/ZK4e5L0OadCHuw7I3/9fNXG1e1I0
 Isdd69DoB7wNpGYTBBz1H/fcJBoWA1T0Q8L7EkUcVFCz0P/rQ4tUfsbqeXh+WmKlK9d0
 nOLwN3G3SJL22Zw3jU+FYxuf5nqK1VcTwV7u9/iKkJOMb2++J5NhF2dntNBJzXFwTpjI
 zr6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751561761; x=1752166561;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QI7+o1tREJe3qZjR9j+ygkNdK2CxMkJ8vpmr8RlkU7A=;
 b=bYWFwXeZYi/5xcNWEcFO9hZM7beci8QZ1LT+38yBBuiIzewmOvkvA2EJU0Kojid9K2
 NcHLnxhFonSua7PBNAHgkLwlktA0NcADDFA3O7GsgWbb9n9/+py15szHMuoidNmqfaUD
 FqEmYL0ZEfOPebjLusIGoZu/XMPe5dXzlZtFNxKk96G6VKGQoJ4WrRuxDedu9EUGaHCt
 oUOPC/Rz5w5PsKDx/Qm7HNyWXXsa49WoXDdGDxpg4cDH9REiQ6wqC+DZYPPCfq6ZqaUe
 Jim8xMwaQrD6X+T4NiD87FaCV0aYSKU7b6EZXcyfED367X465X+1XCsUgCtE863bCKQP
 VXDA==
X-Gm-Message-State: AOJu0YyQGgxtvDAbB3C701hVVe4a2ZS9k9mGknJeXuTd3KihCflLBixr
 VcibmkiKHrozic7MxA/dL69zPMm2OrUMViNUBu4RTaoqIMg9CyG0XMScmeKLnQ/VVhM=
X-Gm-Gg: ASbGncvVII3jQJS6PNnG1rV500M9qwwwSkPmEumZjR3MxZAWzozfN99AH+ooV1ObSqI
 MCuWMmBxtZz4TafNIqSzeP1FMyVPPOKmn+uXbcieVNfvq+WkZ+b/fGhszHV2PFZmhF05hvoh22z
 EgITaqzdsBZ4BlaotYntRZg5UtBoiC691VxzAdDoouuERxJSSofWZPqMfzmsDpveM3FIoeJxcqD
 L5i4wHLTRnflddVLBay0YgF6Pqchon1BXbGsPLtNSC6eGWDsOWEwlSTbbhsC1701nK5uoSPys3/
 NeEwre8kcg27sskKNIGaBk+4wAcHZ9ZlC3IqJ0drwtBjB5p5SHT7gtxEtK/V1Ns=
X-Google-Smtp-Source: AGHT+IEgzZyXuGj9IYibNia78cAn2f1Ptu4ULOGOUO1PSZXEHLVtbIP7OcZ7VImhREA2rRyiEZZGgQ==
X-Received: by 2002:a17:906:99c4:b0:ad8:9a3b:b274 with SMTP id
 a640c23a62f3a-ae3c2da6476mr701439666b.52.1751561760809; 
 Thu, 03 Jul 2025 09:56:00 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae3f6b64ebfsm5258766b.168.2025.07.03.09.55.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Jul 2025 09:56:00 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 34DDA5F8AE;
 Thu, 03 Jul 2025 17:55:59 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,  Richard
 Henderson <richard.henderson@linaro.org>,  Pierrick Bouvier
 <pierrick.bouvier@linaro.org>
Subject: Re: [PATCH v4 26/65] accel/tcg: Implement get_[vcpu]_stats()
In-Reply-To: <20250702185332.43650-27-philmd@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Wed, 2 Jul 2025 20:52:48
 +0200")
References: <20250702185332.43650-1-philmd@linaro.org>
 <20250702185332.43650-27-philmd@linaro.org>
User-Agent: mu4e 1.12.11; emacs 30.1
Date: Thu, 03 Jul 2025 17:55:59 +0100
Message-ID: <877c0pcixs.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  accel/tcg/tcg-all.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
> index ae83ca0bd10..d49d2b3b0fa 100644
> --- a/accel/tcg/tcg-all.c
> +++ b/accel/tcg/tcg-all.c
> @@ -239,11 +239,17 @@ static int tcg_gdbstub_supported_sstep_flags(AccelS=
tate *as)
>      }
>  }
>=20=20
> +static void tcg_get_stats(AccelState *as, GString *buf)
> +{
> +    tcg_dump_flush_info(buf);

This is failing in linux-user because we don't have a monitor:

  /usr/bin/ld: libuser.a.p/accel_tcg_tcg-all.c.o: in function `tcg_get_stat=
s':
  /home/alex/lsrc/qemu.git/builds/all/../../accel/tcg/tcg-all.c:244:(.text+=
0x194): undefined reference to `tcg_dump_flush_info'
  collect2: error: ld returned 1 exit status

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

