Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CD6BC35FFA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 15:59:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuvoQ-000694-5u; Wed, 19 Mar 2025 11:58:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tuvnt-0005ym-6i
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 11:58:01 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tuvnd-0008CV-Hc
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 11:57:54 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-aaf900cc7fbso1356264566b.3
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 08:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742399863; x=1743004663; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E0gbNa3VR7W4aKt0OVxklSFGkSZFxAGz8ywwGvivXvE=;
 b=jscZfe1qtU46HG5J9IVtLfXmDIs8SUYljvvlT9Gt8brgebcisGVifLQPVFj4USuHcq
 IqsSe+rJPwmXKAR+pDGleaN/HXb9iCOzloCwQ8RWIXIxHrpC468IMcSHURtVPBaBMssu
 AqRhkITSOn3R+ua/+XFAieMkwq9cMZu9zz6IIGKCSygJ49kMIidNuHSYcPXFjCQpvRxI
 CMMhdjsEqFu8Ym+J1XUFwLqa/eKPKg2PcdSraCVVbz1jxFyC20Ur2zoB6IGffyeTqaZJ
 7Xh+QWLYLnoCVdniG2EJasDzUq8q8DZDvVzGnVf7BM5uuLSxwZZKrYVDL0P5J/JYaBoT
 fYqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742399863; x=1743004663;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=E0gbNa3VR7W4aKt0OVxklSFGkSZFxAGz8ywwGvivXvE=;
 b=PdGvZiPCSN33+rUuYf4YAqbW+5HWBxWXsv2IIGpRLHUNqjVMN7nS8WJ3ycKmWKULrs
 +9jIRVqyiakAFkmJbCDMwCVBBw8zqjP5Hpprnm/OYI3FN7gox/gMo75SYdmIviNhdlUC
 6L2mlayywyv1dEVPs67MH3j6AqDG2k4Mfv3zsqKg3eQJcbK1frfIh4HYBcuPakT73XWm
 Lp7l0NBt0i/v7l2uN44mWiyF5hJJin9iYpAz5UOSzNt7SSE7HFuVUkOautN5Ni0Ki6Ul
 /nAOIkBHN5HJ3PwwiLMjY695RZRYyUlQHadXi/FbSA9x9llvX4GmMNiUVxy09hCKmsTB
 WJwQ==
X-Gm-Message-State: AOJu0YyvbiA9gFKVOUH+E9kl6IvjmICYdtNbKzjZ/FJxMk0q02ZVJpWI
 RZJylk+cnc49chwAHQThBL5OMXn3Pe7CCvkWLGj1w1MvKx4WAv5fR42eSHKUAwQ=
X-Gm-Gg: ASbGncuBFpWy5OjUemoIXrOhRdkEncA6emkg/33Q+QEbQNPu4NTvIm+1wCUH+kLEqV6
 Yk4ZhfPJm36AmYtv2ZgeOL5srpdadvOZHaaKM++f1Vcl7roFV4ShipWt7Sd6FeQeq8gr2gsccPL
 eoLpTLovruEZNy28V+sVdCmTj0+Jzk4YPWtW0Y5WmiJsjmRFWpJqV1rq8Y5/3r1iFqEA4m1l7ej
 la3mwNFfyoHNZj+6zJIZtJpTiDOl0TppzLiO7d3KLsIOyBp/1Os3vaB1HWvms9A/TInuJ1EdnAK
 XRicUhgPNy1midP4L9OpPQRkyJcgFrr0Upkc1VjB4VH1RIH+NJW2YIDNTg==
X-Google-Smtp-Source: AGHT+IFx5Ysj9BJKKGG6O8FDKAkx3HpvydC2qtpdFfaczcN9Co0w3nwY27wPqGfWKqIuoo+T7Agtew==
X-Received: by 2002:a17:907:d2dc:b0:ac2:8784:4bea with SMTP id
 a640c23a62f3a-ac3b7a9662dmr399757966b.8.1742399862843; 
 Wed, 19 Mar 2025 08:57:42 -0700 (PDT)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac314a40eadsm1020530066b.138.2025.03.19.08.57.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Mar 2025 08:57:42 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6E8C35F93F;
 Wed, 19 Mar 2025 15:57:41 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Polzini <laurentpolzin@gmail.com>
Cc: qemu-devel@nongnu.org,  qemu-arm@nongnu.org,
 millian.poquet@univ-tlse3.fr,  clement.aldebert@univ-tlse3.fr
Subject: Re: Raspberry Pi 3B energy consumption
In-Reply-To: <CABsFrshLGcmBEBXCMrOdDv213c1q6GB6pDs4JDLQGKrTzqvkYQ@mail.gmail.com>
 (Polzini's message of "Wed, 19 Mar 2025 13:38:57 +0100")
References: <CABsFrshLGcmBEBXCMrOdDv213c1q6GB6pDs4JDLQGKrTzqvkYQ@mail.gmail.com>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Wed, 19 Mar 2025 15:57:41 +0000
Message-ID: <87ecytm2ru.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x636.google.com
X-Spam_score_int: 3
X-Spam_score: 0.3
X-Spam_bar: /
X-Spam_report: (0.3 / 5.0 requ) BAYES_00=-1.9, DEAR_SOMETHING=1.973,
 DKIM_INVALID=0.1, DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Polzini <laurentpolzin@gmail.com> writes:

> Dear Sir/Madam, My name is Cl=C3=A9ment Aldebert, and I am a third-year c=
omputer science student at Paul Sabatier University.
> Together with my teammate Laurent Polzin, we are working on a project sup=
ervised by Millian Poquet. Our project focuses on
> reducing the energy consumption of QEMU=E2=80=99s Raspberry Pi 3B emulati=
on, as we have observed that power usage is quite high
> even when the system is idle.

Can you qualify that a bit more? What are you running the emulation on?
What power usage do you see?

Power consumption of the emulation is really just down to computational
efficiency of the emulation and if we ever get to a point that QEMU can
go idle giving the host system a chance to reach a lower power state.

> Ultimately, we also aim to enable emulation on a single CPU core.

If you want to run all emulation on a single core you could use -icount
to do that. It is less efficient though.

> We are reaching out to
> inquire if you have any advice, resources, or suggestions for implementin=
g power management in QEMU, particularly for the
> Raspberry Pi 3B model. Additionally, we would like to understand any cons=
traints or best practices regarding adding new
> code or features to QEMU.

What documentation that exists can be found in the developers section of
the manual:

  https://qemu.readthedocs.io/en/master/devel/index.html

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

