Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50FEEC677C4
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 14:10:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPM9f-0006wv-4i; Wed, 11 Jun 2025 10:10:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uPM9b-0006tE-R8
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 10:10:11 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uPM9X-0004Yf-H5
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 10:10:11 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-6077d0b9bbeso9358378a12.3
 for <qemu-devel@nongnu.org>; Wed, 11 Jun 2025 07:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749651004; x=1750255804; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y+5mNqitLQXjrhNVrkaJjeARd4IJxtnjUPTzhKB9klg=;
 b=TzKfBGP/if6jSEZks24d+PCp4cEVZ8CQZ4k4Y4bqVPfyWZgt/zlhNugC2U8Jl1/ug1
 jkeW6njmZ1uUg0mIonBoa68SN6j7CJGGpP4uTjY2ndmFteFYb6bOu+yvm+jzRPKShrOx
 MOl+qLFRiovfhxbtXMV8378l3yz/D56QCws9By7ITB/7NpL8EMAuDo3kGpDO1ACGwDC1
 oc9oECPuyOgvxu2eOTzDAAZlOxf6RrUe2yAZkw797wh4v2KLXwuRdCkoZ4gK7ofVBmGq
 9VeS3aX9B0mG4B2Xp1VCNXvr3SK5YM+vfjCnAQkOWK0Gb49Vz8c4uRkigeMvTsVPisrH
 zygg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749651004; x=1750255804;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=y+5mNqitLQXjrhNVrkaJjeARd4IJxtnjUPTzhKB9klg=;
 b=onXNKow8xqWuwTl6VnUEneMIU9OhVDQUOPQ8kHxgaKztJ6awUENNCD4pxPNAUa1cMj
 +6F7oiCGEHewZ5VGiM0YDEnInZEoEVNLErDZjbNWDXHX3dR5Fmcm/cNqVieGYVPyVkW8
 RiSYLtVq2tyUlfLm3uIpJlAnPPfVY90cJnEdPFF7lJ3Q4UXXqMHTAfC9q3i0qx3h+Jyv
 Hl1NKaPE8nJ0P+S5Y+IR9MpckCN/XfiGfZ9yVgO8LSBrvQGthe0AKtlFemNbM1gv/YNy
 Ceu2wxCQCqQrKcdThAfpZe0a9fuGkOnFIzez/Osq20923CxJqUQn3fETJ25AS+Djy2Jy
 TIIQ==
X-Gm-Message-State: AOJu0Yx+l3qH10VCT3v4dtmqUhv2x/wJhgzu2koa+spgTe7nZcvCA7W3
 9JhauFeeBJYGeE7NvFN/lTXMqpNxXGf/j5X2UnXSaH1mEUQtm94zibeJJ23Jc2P9HOY=
X-Gm-Gg: ASbGncv4ojfAYod2QG2FMvLj2yEoCv4joC0rciayEWXr/Aol4KC+s8QntkjhjItu3/y
 fxaN6IQGp9wxPKWkixU1qFMBuE9OPBd25NLNaOjGrno9UhEqVcinf5MM7PkzKes74AS9JZ0nyUS
 IU9tP7mbz7y9ttSCwol86xuFCeThSZSFFUWAuI2pEXpZHoB87UcvHazTs7tmsUb6xYbCbfpCvBh
 OVFVAwfkxWwR+IUIOvpJdMMrakMQZnHjorDz7yfYedWw3YUQx84zKvKTAJjodLZsF6DxboggMu6
 6HarayHk1afHVAWqM+qmwivDl8WBtdXP+npxDv2DHCkKjAK3t1yMEjfl88+C/7V0dg8VyGLtaA=
 =
X-Google-Smtp-Source: AGHT+IFecrFH5JXlWxzmFLWbx5K6s+CqyG/yuCMUHGbCQQu81Ekz2J0kjWwgqrClB4aBGPllQASeDg==
X-Received: by 2002:a17:907:1c0c:b0:ad8:9257:573d with SMTP id
 a640c23a62f3a-ade8c7a5bd1mr292055466b.24.1749651004119; 
 Wed, 11 Jun 2025 07:10:04 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ade44af8215sm708983766b.15.2025.06.11.07.10.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Jun 2025 07:10:00 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 67DDA5F7CB;
 Wed, 11 Jun 2025 15:09:59 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  Richard Henderson
 <richard.henderson@linaro.org>,  Pierrick Bouvier
 <pierrick.bouvier@linaro.org>
Subject: Re: [RFC PATCH 13/19] accel: Introduce
 AccelOpsClass::cpu_thread_routine handler
In-Reply-To: <20250606164418.98655-14-philmd@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Fri, 6 Jun 2025 18:44:12
 +0200")
References: <20250606164418.98655-1-philmd@linaro.org>
 <20250606164418.98655-14-philmd@linaro.org>
User-Agent: mu4e 1.12.11; emacs 30.1
Date: Wed, 11 Jun 2025 15:09:59 +0100
Message-ID: <875xh2jrns.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52a.google.com
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> In order to have a generic function creating threads,
> introduce the thread_precreate() and cpu_thread_routine()
> handlers.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  include/system/accel-ops.h |  2 ++
>  accel/accel-common.c       | 16 +++++++++++++++-
>  2 files changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/include/system/accel-ops.h b/include/system/accel-ops.h
> index 44b37592d02..a6535a07343 100644
> --- a/include/system/accel-ops.h
> +++ b/include/system/accel-ops.h
> @@ -37,6 +37,8 @@ struct AccelOpsClass {
>      bool (*cpus_are_resettable)(void);
>      void (*cpu_reset_hold)(CPUState *cpu);
>=20=20
> +    void *(*cpu_thread_routine)(void *);
> +    void (*thread_precreate)(CPUState *cpu);
>      void (*create_vcpu_thread)(CPUState *cpu); /* MANDATORY NON-NULL
> */

After this you start switching *create_vcpu_thread to
*cpu_thread_routine despite this being a mandatory non-null. You should
fix the comment and maybe the assert?

modified   system/cpus.c
@@ -682,7 +682,7 @@ void cpu_remove_sync(CPUState *cpu)
 void cpus_register_accel(const AccelOpsClass *ops)
 {
     assert(ops !=3D NULL);
-    assert(ops->create_vcpu_thread !=3D NULL); /* mandatory */
+    assert(ops->create_vcpu_thread || ops->cpu_thread_routine); /* mandato=
ry */
     cpus_accel =3D ops;
 }

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

