Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3372E77197
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 13:57:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVt2M-00015B-G6; Thu, 09 Jan 2025 08:57:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tVt2K-00014z-5P
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 08:57:24 -0500
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tVt2H-00063W-O4
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 08:57:23 -0500
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5d3d143376dso1164494a12.3
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 05:57:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736431040; x=1737035840; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QcO7UUrKziw6b66YCYsV+qYKHehaIeZyB0DKNBtslt8=;
 b=ZWfN1XW9rIb9nfip4z+PWs6Fmv1IAGNgi5UPl1+lmid0tq98X7zLZbsaQoBZrvLseo
 P7eWhhe7iFx3PZPSfBUJVUTECwBXXmr2xBI/V6SH3uPGy1TPh74x0B5Xi1SXFkFLIabv
 ip1u9BdOSRLJw3f6MShGm1oDeXTz7V4xYaaakxoJgmGvRz3q8qWm27Tga3FYoWpVRvjp
 u5eekPgeWo5vnerx8H4wCNtPuPoTZh2QDj9Jjp8iN6XlfnCni89mbTQvUeoqf0bP3CgZ
 u6slOYuFygBOJoLXwlkRHaC7Z5wk49RDw3BTWzqee9mu4WDdxnBs2CK11K/6k+gWqCOX
 5p7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736431040; x=1737035840;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QcO7UUrKziw6b66YCYsV+qYKHehaIeZyB0DKNBtslt8=;
 b=DQog8FR/8z+dW+Kza+CrBwxpOW0QqnfVTsqYYNUH/CHD9DftSn2s5FiM6w/UHrKUQ3
 g9N2SERDK/WZVO14LbixEAGnI1eJKCCpVWEDlg78uICb5VQvhwDdZEjIkX+8AR0cLFRQ
 aBeFBQvWGONWjoltDgTvy0aSy4FSluHy197G5ZtVc63T16it2ROoYZOgf4WmBMaciV+Z
 GXOzMmKugaLbMzdJTDk1tQ3VV+17C9DPwsuD0o9DFAxG5waBebQPGoZMxtQInf01NA7X
 LF7Ta9XcvUWx6ytYj+QOdMfjDNv1rXauvvXZbl5yj+yjd+Cm/oq2flC7sRioOERughlS
 dr4g==
X-Gm-Message-State: AOJu0YzJlrMKT7OhsZxKQKTf+jUy99nx59Zha41j3ei8D+sRUEKczUmJ
 tPAz2D7hOQaZMuar9smHkBWkFVrB5QcbLc2mpSN9VkFIqxrpqTeujGrbaJ8jLFc=
X-Gm-Gg: ASbGncunoIOnhKrAC06VO5n54N6MLTXxFYRq/0HmaMHea4LgkCjMw4hoJ1gEEkdpNSb
 yJrIwlYZRuTM8z0QV+2shWCi+/YJFo/IFSHncvW/Ww3aplOlQV5nXeRwrnxqTAYCdk51I6vyDKF
 cgmQfDwrJH8YGDHTKsisn06X7Lavs0nz2SAa6X7GhE9mgHL8qOV3wkdsT6R5bfPzhuvRUoH5N8p
 F/Z8GMKcDuxr1liLk1EeU4cdrLMOEcC78RvX5D6wSTQhLDeYdZFdSE=
X-Google-Smtp-Source: AGHT+IEhL2Dd+/o5Dcz2E/AyNPFIyZYuDdF5cSRYsnz8JjqhFTI9A8EYMnuGifa/T1h4L1eZKw4hxQ==
X-Received: by 2002:a17:906:dc8f:b0:aa6:a21b:2a9 with SMTP id
 a640c23a62f3a-ab2abde5fc9mr651709266b.57.1736431040008; 
 Thu, 09 Jan 2025 05:57:20 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab2c90d5c9asm74100966b.45.2025.01.09.05.57.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jan 2025 05:57:19 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C9FD15F75D;
 Thu,  9 Jan 2025 13:57:18 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Julian Ganz <neither@nut.email>
Cc: qemu-devel@nongnu.org,  Alexandre Iooss <erdnaxe@crans.org>,  Mahmoud
 Mandour <ma.mandourr@gmail.com>,  Pierrick Bouvier
 <pierrick.bouvier@linaro.org>
Subject: Re: [RFC PATCH v3 02/11] plugins: add API for registering
 discontinuity callbacks
In-Reply-To: <e4af8fed4cc5449a7be04fbbf026abf267dc189b.1733063076.git.neither@nut.email>
 (Julian Ganz's message of "Mon, 2 Dec 2024 20:26:43 +0100")
References: <cover.1733063076.git.neither@nut.email>
 <e4af8fed4cc5449a7be04fbbf026abf267dc189b.1733063076.git.neither@nut.email>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Thu, 09 Jan 2025 13:57:18 +0000
Message-ID: <87r05c6qf5.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x530.google.com
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

Julian Ganz <neither@nut.email> writes:

> The plugin API allows registration of callbacks for a variety of VCPU
> related events, such as VCPU reset, idle and resume. In addition to
> those events, we recently defined discontinuity events, which include
> traps.
>
> This change introduces a function to register callbacks for these
> events. We define one distinct plugin event type for each type of
> discontinuity, granting fine control to plugins in term of which events
> they receive.
> ---
>  include/qemu/plugin-event.h |  3 +++
>  include/qemu/qemu-plugin.h  | 15 +++++++++++++++
>  plugins/core.c              | 15 +++++++++++++++
>  3 files changed, 33 insertions(+)
>
> diff --git a/include/qemu/plugin-event.h b/include/qemu/plugin-event.h
> index 7056d8427b..1100dae212 100644
> --- a/include/qemu/plugin-event.h
> +++ b/include/qemu/plugin-event.h
> @@ -20,6 +20,9 @@ enum qemu_plugin_event {
>      QEMU_PLUGIN_EV_VCPU_SYSCALL_RET,
>      QEMU_PLUGIN_EV_FLUSH,
>      QEMU_PLUGIN_EV_ATEXIT,
> +    QEMU_PLUGIN_EV_VCPU_INTERRUPT,
> +    QEMU_PLUGIN_EV_VCPU_EXCEPTION,
> +    QEMU_PLUGIN_EV_VCPU_HOSTCALL,
>      QEMU_PLUGIN_EV_MAX, /* total number of plugin events we support */
>  };
>=20=20
> diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
> index 9c67374b7e..f998a465e5 100644
> --- a/include/qemu/qemu-plugin.h
> +++ b/include/qemu/qemu-plugin.h
> @@ -273,6 +273,21 @@ QEMU_PLUGIN_API
>  void qemu_plugin_register_vcpu_resume_cb(qemu_plugin_id_t id,
>                                           qemu_plugin_vcpu_simple_cb_t cb=
);
>=20=20
> +/**
> + * qemu_plugin_register_vcpu_discon_cb() - register a discontinuity call=
back
> + * @id: plugin ID
> + * @cb: callback function
> + *
> + * The @cb function is called every time a vCPU receives a discontinuity=
 event
> + * of the specified type(s), after the vCPU was prepared to handle the e=
vent.
> + * Preparation usually entails updating the PC to some interrupt handler=
 or trap
> + * vector entry.

The "usually" here is a bit of a weasel word. We should be clear what
the contract is with the plugin. Can we say the PC will be updated to
the next instruction that will execute after the callback?

> + */
> +QEMU_PLUGIN_API
> +void qemu_plugin_register_vcpu_discon_cb(qemu_plugin_id_t id,
> +                                         enum qemu_plugin_discon_type ty=
pe,
> +                                         qemu_plugin_vcpu_discon_cb_t cb=
);
> +
>  /** struct qemu_plugin_tb - Opaque handle for a translation block */
>  struct qemu_plugin_tb;
>  /** struct qemu_plugin_insn - Opaque handle for a translated instruction=
 */
> diff --git a/plugins/core.c b/plugins/core.c
> index bb105e8e68..a89a4a0315 100644
> --- a/plugins/core.c
> +++ b/plugins/core.c
> @@ -559,6 +559,21 @@ void qemu_plugin_register_vcpu_resume_cb(qemu_plugin=
_id_t id,
>      plugin_register_cb(id, QEMU_PLUGIN_EV_VCPU_RESUME, cb);
>  }
>=20=20
> +void qemu_plugin_register_vcpu_discon_cb(qemu_plugin_id_t id,
> +                                         enum qemu_plugin_discon_type ty=
pe,
> +                                         qemu_plugin_vcpu_discon_cb_t cb)
> +{
> +    if (type & QEMU_PLUGIN_DISCON_INTERRUPT) {
> +        plugin_register_cb(id, QEMU_PLUGIN_EV_VCPU_INTERRUPT, cb);
> +    }
> +    if (type & QEMU_PLUGIN_DISCON_EXCEPTION) {
> +        plugin_register_cb(id, QEMU_PLUGIN_EV_VCPU_EXCEPTION, cb);
> +    }
> +    if (type & QEMU_PLUGIN_DISCON_HOSTCALL) {
> +        plugin_register_cb(id, QEMU_PLUGIN_EV_VCPU_HOSTCALL, cb);
> +    }
> +}
> +
>  void qemu_plugin_register_flush_cb(qemu_plugin_id_t id,
>                                     qemu_plugin_simple_cb_t cb)
>  {

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

