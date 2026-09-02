Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 071D8C624D3
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 13:42:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1lEO-0002tV-PP; Wed, 02 Sep 2026 09:42:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x1lEM-0002r9-9p
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 09:42:22 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x1lEK-00018c-Ge
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 09:42:22 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4998b5a63e2so10695495e9.1
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 06:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788356539; x=1788961339; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=48zrh2LliEkMC8LYdcngefR+Q9cAIh2c+po09OVEZQU=;
 b=ypczvTIOhLFitkTAnpkiRZqr4MQwrSxT6svyt0NB/3xk75wdk8i9qDHsLaFJwrX41x
 aH5IZvks2MUPZYHuQ4XdW+cc9aWQkKW2Z3zXNlMF1VsxDt6w1Nf1yHwImOi4/c6gRPQI
 MRCbrUZSbxLIUc0dPIv/bLYJKOSFyyXzRWuHPgQlae3f3M94Z9/sxb2EMJZB3jGHLEW8
 R9YRFO2UYFvE8gxOQ1GJpEti0H5OikPDTIO+GQfh8uOQaStRAVAVia/ARyQQ9pH2nKW+
 Q6wizNl/ERENU49Q3zCKhZTGcTnrxRcFv/vD1ExHZubUPoreCDsmDjBDVlrDRSThW76c
 v+PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788356539; x=1788961339;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=48zrh2LliEkMC8LYdcngefR+Q9cAIh2c+po09OVEZQU=;
 b=JFTxlLXD//LklAVdnCoOhjNLyHh6qbP5GeiMsTiosJ8AZ7Y+uorXiFzrWOLyF4UkIJ
 f/xPHaGX/5tJxbl5a/IQvyIKwpmiTpJ66Ek/MKOylenicgd1QVgWQklhTde7HM3+2hwR
 TgaKQpeDlHkmEEACIXR/OcuzObvX4XFpvtF5R1Tq1yNUwRELz8XWj0trZtR8ZDEsIK9L
 4LyV7CDG3aX5KDXC8m3EOs8EZCQpwOffGopauWTFp2/du8q/xqfCxytAkBMD6mA1ncBz
 5G9Q4oeZfZ4atqZ2Lnh72d+z8hN42Fz5F6qgQX8+cDwve/5zCVLEq7JtMporaC0/6YiA
 WgSQ==
X-Gm-Message-State: AFuF++lUcHHZPaIlrEuhFDZ/41HGAOA1FZ+nbjTkcF9PApmT0+FjL0w9
 h0rYG2SPL0NNFzjIVMwpUR+orT/fyOaH+bicVw1eiq2LrVLMENNsq+drxBch4FufKJ8=
X-Gm-Gg: AR+sD104S3mcj6i9x65OvBiJQ6l0IR4tKPIdlDo25+c3auaeH2ysBASP0DKQrPb9Qfj
 WtpZayl3KvupMUkrFvvQBl2XghKo6KhW1YkPFdfNmocR36jkDFX9G5Gh9/KNKFku/dOqUkOl+tS
 uLQvAAaJlhGN0a1oovnAoVmOuSHXmdY7p/QWiQZOCa0XGkN5M5xqNvkzSyvGyw8RszAFJ2h5baA
 KrLHEgGWaINYr+SNuoD4MHwn5hNjncoWHf8UOLZ51ev+SyaTT80Ek134usuDVj3ClristiPBWzi
 AylaeMFRqNFd4h3iX5iDMLbzNRjOLYZcYYzeYjI6t2jzrkJ2fTENAxRZ5DbBkkZEnp37rnB9KlE
 ED/CDuJMkwL0mkAISAfZ4O0cL0FMMR2AHzpEYtRsfguKaLJD7du20iDQpps7i9gB69w62P8Yb5G
 88WeAK+ZGKCfYfBTXaHleesUEfRz3NKe6b2/SnFjz6c7RN9rQeYB0rRBCPYo8Q
X-Received: by 2002:a05:600c:1f88:b0:49c:ee01:8c53 with SMTP id
 5b1f17b1804b1-49cee018c5cmr2079585e9.2.1788356538370; 
 Wed, 02 Sep 2026 06:42:18 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ce3c86a0asm79816035e9.9.2026.09.02.06.42.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 06:42:17 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B2A855F85F;
 Wed, 02 Sep 2026 14:42:15 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,  "Michael S . Tsirkin" <mst@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,  BALATON Zoltan
 <balaton@eik.bme.hu>,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Fabiano
 Rosas <farosas@suse.de>,  Kevin Wolf <kwolf@redhat.com>,  Peter Maydell
 <peter.maydell@linaro.org>,  Warner Losh <imp@bsdimp.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH 2/4] AGENTS.md: Let agents know what the participation
 rules are
In-Reply-To: <20260901161422.314581-3-pbonzini@redhat.com> (Paolo Bonzini's
 message of "Tue, 1 Sep 2026 18:14:20 +0200")
References: <20260901161422.314581-1-pbonzini@redhat.com>
 <20260901161422.314581-3-pbonzini@redhat.com>
User-Agent: mu4e 1.14.4-pre1; emacs 30.1
Date: Wed, 02 Sep 2026 14:42:15 +0100
Message-ID: <87a4pzrcqw.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x329.google.com
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

Paolo Bonzini <pbonzini@redhat.com> writes:

> Humans seem to be extremely unreliable in following rules around this,
> even after being told directly and repeatedly. Telling agents what to
> do seems to yield better results.
>
> This document is based on GStreamer's AGENTS.md file, as of its commit
> d08375499c279a56c0e77c928fbeae0d80cdf937.  However, GStreamer's agent
> instructions are "effective" enough to require an explicit carve-out
> for maintainers.  I actually believe that such a carve-out is a sign of
> going too far, especially given the good quality of some suspected-AI
> contributions we've received.
>
<snip>
> diff --git a/AGENTS.md b/AGENTS.md
> new file mode 100644
> index 00000000000..8fb96ebfc38
> --- /dev/null
> +++ b/AGENTS.md
> @@ -0,0 +1,100 @@
> +# Agent Guidelines for the QEMU Project
> +
> +QEMU is a cross-platform emulator and virtualizer. Due to the complexity
> +of the domain and codebase, and the interactions therein, the QEMU
> +project relies extensively on the effort of **human reviewers**, which
> +is **a scarce resource**.
> +
> +There are strictly-enforced rules for you, the agent, to participate in =
the
> +project.
> +
> +## Interactions with maintainers must be human-human
> +
> +The QEMU project has strict rules on what AI-generated material can
> +reach the maintainers.
> +
> +### No automated posting
> +
> +- Agents **must not** use any API, CLI, or web UI automation to:
> +  - Interact with the QEMU mailing lists
> +  - Create, edit, or close **issues ("work items")**

The others I'm fine with but I currently use an agent to do triage on
un-tagged issues. It only updates labels and occasionally posts a
comment when more information or a human input is required.

That said with a minimal patch to agents to inform it of the
qemu-issue-triage skill Gemini didn't stop itself:

  The `qemu-issue-triage` skill is now loaded. Please let me know how you w=
ould like me to assist with triaging QEMU GitLab issues, keeping in mind th=
at all triage tasks must be performed by spawning dedicated sub-agents as p=
er the QEMU project's strict rules.
  triage 4930, 4391, 4392, 4393, 4394, 4395

  qemu-helper-agent: triage issue 4930 (2 steps, 21.7K / 1M) =E2=9C=85 8s

  qemu-helper-agent: triage issue 4391 (6 steps, 31.9K / 1M) =E2=9C=85 30s

  qemu-helper-agent: triage issue 4392 (5 steps, 27K / 1M) =E2=9C=85 35s

  qemu-helper-agent: triage issue 4393 (5 steps, 27.5K / 1M) =E2=9C=85 47s

  qemu-helper-agent: triage issue 4394 (5 steps, 26K / 1M) =E2=9C=85 51s

  qemu-helper-agent: triage issue 4395 (4 steps, 25.7K / 1M) =E2=9C=85 15s

  The requested GitLab issues have been triaged using parallel sub-agents. =
Here is a summary of the outcomes:

  *   **#4930**: Not found (404).
  *   **#4391**: Triaged and labeled as `Kind::Bug`, `Workflow::Triaged`, `=
Binary =E2=9E=A4 qemu-img`, `Storage`, `HostArch =E2=9E=A4 32bit`, `TestCas=
e`.
  *   **#4392**: Triaged and labeled as `Kind::Security`, `Device =E2=9E=A4=
 USB`, `Migration`, `TestCase`, `Workflow::Triaged`.
  *   **#4393**: Triaged and labeled as `Kind::Security`, `Device =E2=9E=A4=
 VirtIO`, `Device =E2=9E=A4 Network`, `Audit Tooling::Sanitizer`, `TestCase=
`, `Workflow::Triaged`.
  *   **#4394**: Triaged and labeled as `Kind::Bug`, `Target =E2=9E=A4 X86`=
, `HostArch =E2=9E=A4 AArch64`, `TestCase`, `Workflow::Triaged`.
  *   **#4395**: Triaged and labeled as `Kind::Bug`, `Workflow::Triaged`, `=
Emulation =E2=9E=A4 Softfloat`, `Target =E2=9E=A4 X86`, `HostArch =E2=9E=A4=
 AArch64`, `TestCase`.

  All issues (excluding the non-existent one) have been successfully proces=
sed, labeled according to project standards, and verified as complete. No f=
urther actions are required at this time.

I guess arguably it is hard for a random to use the API anyway as we
control who has API keys for the project.

> +  - Post **comments** on merge requests, issues or commits
> +  - Open or update **merge requests (MRs)**.  QEMU does not use merge re=
quests anyway.
> +
<snip>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

