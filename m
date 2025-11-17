Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFB6DCE8D6B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 16:50:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vL2Q5-0007Kx-MR; Mon, 17 Nov 2025 11:49:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vL2Q3-0007II-Dt
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 11:49:35 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vL2Q1-00024i-Ow
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 11:49:35 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-477563e28a3so31238985e9.1
 for <qemu-devel@nongnu.org>; Mon, 17 Nov 2025 08:49:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763398171; x=1764002971; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Dmn9MytAXQYPT+tXkBGeBTR/ijWFoF9yIkQyp+pUOl8=;
 b=Nf3+5hYIoUam0s4Hj8w2wQ6L1mWIGZrBxGT1JRQjnehnbjOjULJR4u4Ubxsx+8ESCh
 hcWUpaq3zsUZMc8spF0SlSH+sdwkH83b++HT4BJMBwWSTmnr9lYNs8lUA2rVNr71SqA+
 flyQJEcY3bufX3tn1HwgvtZAU4RPCfh3aKUTI5o3EMtV8NhOygj6JQpbnbHmKGjEVzlj
 B0g6QG5KsG/rz+iaHZdBG9egaVHwfmrAtpfkyB2JPz5LKpGcXDHGkgkWEHldqIoFEq23
 dU9eDoR/vqzauiYXKQ7KtOCbdSIl9IEcAj2DljHRfxmLBDIzvfxf1C776dljwzPCH/i1
 FTgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763398171; x=1764002971;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:to:from:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Dmn9MytAXQYPT+tXkBGeBTR/ijWFoF9yIkQyp+pUOl8=;
 b=kC6zuLUygsMawe37COQxJJ0bXFpuAUO6Cr7v15LzPzo2uV5drUBzXOF9so0p9s+7bV
 qLOmTxh2UED3tz4A18awmpVKb0gkT/b8lmiJT3j13GU9S/J6otcPaSCEVJnjDkPOiUX7
 wHDWj3OBdkNCphphsQZA4OtwqiNhL3jZu1YZo4JRa009r5hRXiGDmIc0TR3bGaxEW/sw
 R23s/jJjY2jnHwEKLlooq0AmCSLxv9CEx/6o/bs6QyMX/dBGoHRzNtgbXc+jHoeZyQbK
 pHRp37PU0pA9hGZDNdK1NU+hyUs4PMdQ3hxM8IOxNUDPUFhkmQNSg4iqtoVNLqkD5CCe
 a+7A==
X-Gm-Message-State: AOJu0YydKVwMAR7Gt2GZPGe9XyzJuqgXhzmPnIGse/VZnsrBCaaVnnQc
 nq0d8UgonMYdbuCQEpxCGmjGRJnCoqexJECMTlfW7XquVqyvb04KTbKd2pngnl/AvRD+uiCRTCI
 hlIAm
X-Gm-Gg: ASbGncupKlTwMBGewQDjFYASNRNvjPQjnIo6ukQEtV4A5GNfd/ez4oR+YmWAfHpyyOJ
 5jrkG/2Y13pVvKb+7ekpu5MivIiyf66kukCCeQFvo7T3esWZyB7YspBkBMp3wHCrGv/DGCwSTLO
 L0XsvWvtZcnFNikOu+OUC06pJpjuBUlG9yxBAyY13qGiCxjKcFAjT6SArbfff0ROZiQ9Sld6IcP
 GTxMKXY1AkQ5hfOvZVl+IqqsPKJRR/Rl/8VkHomiuw8rzOo+uEnzeqEBASrupZVIKLxUwFE5+xH
 83HOwYVAarBQQoHMKKFcBkcf6z0eKKHe8ntxS9SMEiXU8V/SqPZLoN/htZWqaL9ajZBPX1s7qOG
 UYF9d0bVBWwM7px7iuKY0flpEncbAO+mvgbwuKg08XbZeH12e2EqetCmCnNLicIDZYBM04u3Tsz
 NwMtcHpgbg8fc=
X-Google-Smtp-Source: AGHT+IEUOwdi9Xw4o7m3Y99TSxnD1BSGPjl4xdJX2ItVgbEm/aWKbyVnDTiX9RUskyZtK0GLjOVUaw==
X-Received: by 2002:a05:600c:6289:b0:475:d9de:952e with SMTP id
 5b1f17b1804b1-477a94ace2emr409715e9.1.1763398171305; 
 Mon, 17 Nov 2025 08:49:31 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4778bcfa2e9sm115778635e9.12.2025.11.17.08.49.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Nov 2025 08:49:30 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id ABD025F76E
 for <qemu-devel@nongnu.org>; Mon, 17 Nov 2025 16:49:29 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: Re: [PULL 00/18] testing updates for 10.2
In-Reply-To: <20251117154948.4122164-1-alex.bennee@linaro.org> ("Alex
 =?utf-8?Q?Benn=C3=A9e=22's?= message of "Mon, 17 Nov 2025 15:49:29 +0000")
References: <20251117154948.4122164-1-alex.bennee@linaro.org>
User-Agent: mu4e 1.12.14-pre3; emacs 30.1
Date: Mon, 17 Nov 2025 16:49:29 +0000
Message-ID: <87ms4kli3q.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x334.google.com
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

Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> The following changes since commit e88510fcdc13380bd4895a17d6f8a0b3a3325b=
85:
>
>   Merge tag 'pull-target-arm-20251114' of https://gitlab.com/pm215/qemu i=
nto staging (2025-11-14 17:59:05 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/stsquad/qemu.git tags/pull-10.2-maintainer-171125-1
>
> for you to fetch changes up to 11a4716211766af6058ad517d73da97f37475e39:
>
>   gitlab: add a weekly container building job (2025-11-17 15:43:35 +0000)
>
> ----------------------------------------------------------------
> testing updates for 10.2
>
>   - fix emsdk image for podman
>   - update lcitool and clean-up ENV stanzas
>   - include coreutils for io tests
>   - move a number of assets due to linaro changes
>   - add ppc64le custom runner
>   - rationalise the gitlab custom runners with templates
>   - clean-up the custom runner rules
>   - add a scheduled container build

Note I have sent a v2 very shortly after this one to address a single
typo....

  Message-ID: <20251117155237.4124861-1-alex.bennee@linaro.org>
  Date: Mon, 17 Nov 2025 15:52:37 +0000
  Subject: [PULL v2 00/18] testing updates for 10.2
  From: =3D?UTF-8?q?Alex=3D20Benn=3DC3=3DA9e?=3D <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

