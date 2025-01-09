Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5E2AE77197
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 14:05:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVt9h-0004G2-86; Thu, 09 Jan 2025 09:05:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tVt9f-0004Fq-QH
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 09:04:59 -0500
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tVt9e-0007WF-46
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 09:04:59 -0500
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-aa689a37dd4so182918766b.3
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 06:04:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736431496; x=1737036296; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VvamQ8txAZIhmP2RZ/9rAZHqDsGdYsGNSUqRlON/wVY=;
 b=b1cMiUzLj3rTkNY+lrhAPtmPsmHnu5ICP4Hc5UT/cZG7SzehNrVjZ+7BfbUQgsEfSu
 uHpaFvhN6106pdUZnVzS75QVGkd+Zpl18g2LdY6WEHP0IhIzxF976qnUpV8hfglMPUwh
 0UjV+JVaAz6tOSwU1SdYMdQRhzGveL+HH4FWgNp6MLPghRuz7qOLR4+il2FSg9OHUSK1
 Z/b81l0hOcdX/csqjeu6ZutHLjxfneDAveKQTF604TJ+rdYHJA8T9M/+PmIfMqIL4UMM
 sf/yPaE2TOnq8VEwu9EzDmkGPCQOL46GoqU+wpZDG8UZe8oGsRQB1MoRFfVpDPB3Atpf
 caOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736431496; x=1737036296;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VvamQ8txAZIhmP2RZ/9rAZHqDsGdYsGNSUqRlON/wVY=;
 b=NiSAn8GADW50TZIKwnFtayNruxf/x9aXSn/fUyOaaYIwNKnwl1wsrIktvg6catgSbM
 VByaUlGoM1yvYISOeGNH2vIytakjot8OlKH8M7PxDeP/UaBHy8Ped0xLZ8rQLhOAVtSn
 nahtNUwlPnH/h/AOSNwnznLeoLDxEjidpvgcV7v2oBNtaS3p5+PiXD5xVs7Hyca80PyX
 PYoJ72Lc8QWeAZ+Vy0/G5iibHr3MJObeo6NiM8EuwVPOvereSbyA7rVchS6atC1B5NqX
 GxJT2jeiaDLohHR85zmIXfIP+8fGzzOWeb8Oyx8GTrlfRjKFRQms3iSaa/boqYVfX6g7
 /H7g==
X-Gm-Message-State: AOJu0YxYWLFFyRWrE3ktyQHi2+7aHVNviq1CjyJdpmUB/5Fzv5Wjayk4
 PlsHkeSpLsYFQgYOwWzpZArCVtagGTJ9VS5yqnGtwb+qDyl0K8K2MMhV5v+qaFg=
X-Gm-Gg: ASbGnctlIsey3OszFbUlJzMUY36nKaKQ9O+8Pc1ovFFixCw28JpS58Ea7OpqBcYyKkn
 cHscxX6V4+I4vOQ9s2Ce3YGUZ06wZSQaWZasjmr6oTPXOAs0g02FLTS35qUl+zWbPBrTigb9D2m
 Zy3UWRAVeXO2obTHBxf0NmrDtrH8dOa7AddPUrdRYli2AlreD67/l9axC5f5yB4G3XbftckDQqR
 K1Ll1DAr6bK475JEctuWidvVgGZfUH1FTPLaUzeQ9x0Gn34DcHB06I=
X-Google-Smtp-Source: AGHT+IGFOyWbdvC8d6uidbDTvj2Arm9pMZN6JtXdo5FqXmBpJ9oe2xDNzlLHReN0ntXSXZFHmH5qHA==
X-Received: by 2002:a17:907:809:b0:aaf:117c:e929 with SMTP id
 a640c23a62f3a-ab2abcb1440mr612464066b.57.1736431495948; 
 Thu, 09 Jan 2025 06:04:55 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab2c90d9ae0sm76579566b.68.2025.01.09.06.04.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jan 2025 06:04:53 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 71ACD5F75D;
 Thu,  9 Jan 2025 14:04:49 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Julian Ganz <neither@nut.email>
Cc: qemu-devel@nongnu.org,  Alexandre Iooss <erdnaxe@crans.org>,  Mahmoud
 Mandour <ma.mandourr@gmail.com>,  Pierrick Bouvier
 <pierrick.bouvier@linaro.org>
Subject: Re: [RFC PATCH v3 04/11] contrib/plugins: add plugin showcasing new
 dicontinuity related API
In-Reply-To: <fa02142d349ceb6c95e80301a7f5c57ae5df6329.1733063076.git.neither@nut.email>
 (Julian Ganz's message of "Mon, 2 Dec 2024 20:26:45 +0100")
References: <cover.1733063076.git.neither@nut.email>
 <fa02142d349ceb6c95e80301a7f5c57ae5df6329.1733063076.git.neither@nut.email>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Thu, 09 Jan 2025 14:04:49 +0000
Message-ID: <87frls6q2m.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62e.google.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NEW_PRODUCTS=1.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Julian Ganz <neither@nut.email> writes:

> We recently introduced new plugin API for registration of discontinuity
> related callbacks. This change introduces a minimal plugin showcasing
> the new API. It simply counts the occurances of interrupts, exceptions
> and host calls per CPU and reports the counts when exitting.
> ---
>  contrib/plugins/meson.build |  3 +-
>  contrib/plugins/traps.c     | 96 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 98 insertions(+), 1 deletion(-)
>  create mode 100644 contrib/plugins/traps.c
>
> diff --git a/contrib/plugins/meson.build b/contrib/plugins/meson.build
> index 63a32c2b4f..9a3015e1c1 100644
> --- a/contrib/plugins/meson.build
> +++ b/contrib/plugins/meson.build
> @@ -1,5 +1,6 @@
>  contrib_plugins =3D ['bbv', 'cache', 'cflow', 'drcov', 'execlog', 'hotbl=
ocks',
> -                   'hotpages', 'howvec', 'hwprofile', 'ips', 'stoptrigge=
r']
> +                   'hotpages', 'howvec', 'hwprofile', 'ips', 'stoptrigge=
r',
> +                   'traps']

I wonder if this is better in tests/tcg/plugins? We need to do something
to ensure it gets covered by CI although we might want to be smarter
about running it together with a test binary that will actually pick up
something.

>  if host_os !=3D 'windows'
>    # lockstep uses socket.h
>    contrib_plugins +=3D 'lockstep'
<snip>
> +QEMU_PLUGIN_EXPORT
> +int qemu_plugin_install(qemu_plugin_id_t id, const qemu_info_t *info,
> +                        int argc, char **argv)
> +{
> +    if (!info->system_emulation) {
> +        fputs("trap plugin can only be used in system emulation mode.\n",
> +              stderr);
> +        return -1;
> +    }
> +
> +    max_vcpus =3D info->system.max_vcpus;
> +    traps =3D qemu_plugin_scoreboard_new(sizeof(TrapCounters));
> +    qemu_plugin_register_vcpu_init_cb(id, vcpu_init);
> +    qemu_plugin_vcpu_for_each(id, vcpu_init);

Hmm at first glances this seems redundant - however I guess this is
covering the use case you load the plugin after the system is up and
running.

I wonder if you have unearthed a foot-gun in the API that is easy to
fall into? Maybe we should expand qemu_plugin_register_vcpu_init_cb to
call the call back immediately for existing vcpus?

> +
> +    qemu_plugin_register_vcpu_discon_cb(id, QEMU_PLUGIN_DISCON_TRAPS,
> +                                        vcpu_discon);
> +
> +    qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
> +
> +    return 0;
> +}

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

