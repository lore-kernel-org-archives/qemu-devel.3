Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74388C98318
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 16:24:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9mEy-0004eQ-3B; Thu, 24 Sep 2026 12:24:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x9mEw-0004e1-1R
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 12:24:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x9mEs-0005ZL-SJ
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 12:24:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790267041;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l1jyfS2ObZFH6uXOZamIZkfAHdmaQ5mzTXExOg+3qiw=;
 b=AO1/BFSGL0DiObXTTeKI8NZ3L93KvulIzx8vVtuacjHO8jxt23onVc292ArCy7m45IPnyi
 IrJzLjZ7IUoPMdeHvFBsO5NtKZ5gKTkHll7PWNKl1NCAbpbNmGyweF65d/1gTaqaxNUGyS
 6nLiaQFMeOldQq0M7P5ExjuJv19GzLw=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-223-Zqe7benNOOyHNpDjnTWLWg-1; Thu, 24 Sep 2026 12:23:59 -0400
X-MC-Unique: Zqe7benNOOyHNpDjnTWLWg-1
X-Mimecast-MFC-AGG-ID: Zqe7benNOOyHNpDjnTWLWg_1790267038
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-c29c391bd2fso214239566b.2
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 09:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790267038; x=1790871838; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=l1jyfS2ObZFH6uXOZamIZkfAHdmaQ5mzTXExOg+3qiw=;
 b=mmcoiemF6raiW2HvU7KN4A7MzHpfh073wvoJTK5LPEWW3Mx8b9+m/EVvN5lcZoarya
 6B128WPlbFVkr0u1ZoQgOy9qsTRnn/xfzyUR+sPU/9BE/xzsM0idjz5ksDDwGg4BoHIF
 qAZsxjU6tttIL3fDWP+ZO+DTBZ0gn3SD1X0vl9HUtiufDFv1fsne5AI/FfyWsjTArNvE
 DJKmz0o3xG1KT0Vcu0MV8tuSBz+Nmd44ryCVf5CaSJFu68opF4/HZSam074HULPpG725
 gCAMad/pHDKzxzEl8ezwo2xf56wwG+Ivgxi3N86zII4oDSYP8i8TnXE8RNx10X/wNp4w
 Uz7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790267038; x=1790871838;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=l1jyfS2ObZFH6uXOZamIZkfAHdmaQ5mzTXExOg+3qiw=;
 b=ig686DjHVcMIMd4clngjmbZN29RDBYQIll+0DWQaYMZrcG2O+mlxkDIUuzcprT5N+2
 /JN8TW+6KUDMHSO4hOgsW0f/PkoYNDYevu6kNZ6RxzxWfkQ9fwNvsiJzOcKzydlatULn
 vSUBmHa38AxsKbWFPY0slW/mlrPFY8jd4gpDJRj6i8T1KZPt4faL8uI0mW+kVE50+C51
 uR7fVKytq/RxAvMAlH5NtdH1ZHqjmLYa3LmfR+y/siV1orj7sw2AW346NtH7UBRd0BPF
 gaOmVBQdzdfIjmoXrjBZD7YisRL1uwkIrEgSeeMprIczcwEBh/FzrYllFMg9Hg0R8MWV
 LQHg==
X-Gm-Message-State: AFuF++ntAcqR3Y6DzVJ4SsVw0tet01WE1dS+aAvlDo2P9/QEplM+zLSU
 sialUwD2zu9bMz+TTcLpDGnN4nQOQbXEKQegXf00S5LvPw7io17jC3tAZK/oRp+XvKVQsr46ZqD
 0KHqDxDnuJZAEcOhOD6Us68eUepB1QX8PxPQOh0lEtqQ+nEDYp71n1zJL
X-Gm-Gg: AYBFou3tVN7P0JiKBVcpjsXStom1tLZCiYufy/nN6yRLJD2muayPT0oFot5y+NS4gDH
 KQ0OU+m1Ycbv+/qSVXxxBUXlCvOvc3AIqnK4ng9GYF3jyUl694pL7I8tP9JxAjluGBZ5bK68Swr
 58IMWdqy5i+wMsRSH9zHfCII+TBc7EBf71TaV03vdHklUds9mwtH6LMlMFA70efoZzxjp7jGLLS
 K+m86lXH5bf7GQlKUG/pbaaWg07vkIlLgzK3JZnk1CG6lKeFOn3PqnpQn8CKOglp0nj52X5uwL8
 gdPUK8BFH0PcottugxhF4EYSN7bCPX6zSS82QvU8SL5FJaKiWuyAbmUJeqMC1151J+MBWXJvjrQ
 iWwrZB1UA32DEndrJTZtZXBj6uxA/LRLMvfeEoYCtX01iXw1nh8fx/l0hY01VJbN/Hg==
X-Received: by 2002:a17:907:6ea3:b0:c29:5420:cf84 with SMTP id
 a640c23a62f3a-c2ac53c84c5mr234100266b.36.1790267038295; 
 Thu, 24 Sep 2026 09:23:58 -0700 (PDT)
X-Received: by 2002:a17:907:6ea3:b0:c29:5420:cf84 with SMTP id
 a640c23a62f3a-c2ac53c84c5mr234096766b.36.1790267037663; 
 Thu, 24 Sep 2026 09:23:57 -0700 (PDT)
Received: from redhat.com
 (2a02-ab04-0158-f000-2548-f3bd-8b42-b18f.dynamic.v6.chello.sk.
 [2a02:ab04:158:f000:2548:f3bd:8b42:b18f])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2aae63dc17sm334751266b.33.2026.09.24.09.23.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 09:23:57 -0700 (PDT)
Date: Thu, 24 Sep 2026 12:23:55 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Kevin Wolf <kwolf@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Warner Losh <imp@bsdimp.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH 3/4] AGENTS.md: let agents know what the participation
 rules are
Message-ID: <20260924121843-mutt-send-email-mst@kernel.org>
References: <20260921075251.12831-1-pbonzini@redhat.com>
 <20260921075251.12831-4-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260921075251.12831-4-pbonzini@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

On Mon, Sep 21, 2026 at 09:52:50AM +0200, Paolo Bonzini wrote:
> Humans seem to be extremely unreliable in following rules around this,
> even after being told directly and repeatedly. Telling agents what to
> do seems to yield better results.
> 
> The starting point for this document is GStreamer's AGENTS.md file, as
> of commit d08375499c279a56c0e77c928fbeae0d80cdf937.  I used GStreamer's
> agent instructions in the context of Meson, which uses a very similar
> file, and it's both annoying and too willing to take the lead once the
> model decides that it likes you.
> 
> To avoid this, the text tries to favor cooperation between agent and user.
> It suggests that the agent includes the state of the work when committing,
> so that contributors have the material they need to review the agent's
> work.
> 
> To test it I tried the following prompt:
> 
>   Hi, i am doing my first AI assisted contribution to QEMU. i am familiar
>   with the project, but would nevertheless like to experiment. please
>   generate a sample implementation of a pressure sensor, of any model,
>   of a kind that is commonly used with Arduino or ESP32 microcontrollers.
> 
> The agent did read llm-usage.rst and after doing the work (implementing
> a BMP280 pressure/temperature sensor) it noticed:
> 
>   Policy, before this goes anywhere near the list. A new device model plus
>   qtest is the fourth bucket in docs/devel/llm-usage.rst: large, heavily
>   LLM-assisted, allowed only if pre-arranged — a maintainer has to say on
>   IRC or the list beforehand that they'll review it. hw/sensor is Philippe
>   Mathieu-Daudé (Odd Fixes), with Corey Minyard on I2C. I should have
>   flagged this before writing rather than after; that's on me. Disclosure
>   would be AI-used-for: code, tests above your Signed-off-by, and the
>   commit message and any list replies have to be yours, not edited from mine.
> 
> I then asked "Can you provide a draft of the commit message with all the
> sources (datasheet, etc.)?" The agent complied but noticed:
> 
>   AGENTS.md and docs/devel/llm-usage.rst state that commit messages MUST
>   be written by humans — an AI-drafted one must not reach the list
>   even lightly edited. So treat the below as scaffolding for facts and
>   sources, and write the final text yourself.
> 
> After some editing I asked "ok, will you please commit for me?" and
> it did so with basically my text, while also reminding me about the need
> for maintainer pre-arrangement.
> 
> I asked "assuming pre-arrangement is this ok according to the policy?"
> and this was the assessment:
> 
>   "Well-tested" — held to a higher standard, and here's what's actually
>   missing: [...] the vmstate (no migration test), reading past 0xFC and
>   reserved registers, the pointer_valid error path, oversampling/filter
>   fields beyond one readback, and behavior against a real driver — Linux
>   bmp280 was never run against this. None of those is hard; whether the
>   current set clears the higher bar is a judgment call I'd rather hand
>   you than make.
> 
>   "High-quality" is the open one. The doc asks that you have reviewed and
>   curated the contribution and can explain the changes and the rationale
>   in depth. In this session you engaged with the commit message and the
>   sources — and caught my datasheet error, which I got wrong — but the
>   design decisions were mine and unexamined by you [...]
> 
> Overall, the files do affect the behavior of the agent.  The agent
> however made too many design decisions on its own.  This will be fixed
> in a separate step.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  AGENTS.md | 66 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 66 insertions(+)
> 
> diff --git a/AGENTS.md b/AGENTS.md
> index 478748ab72e..816ba7646c1 100644
> --- a/AGENTS.md
> +++ b/AGENTS.md
> @@ -8,12 +8,73 @@ is **a scarce resource**.
>  There are strictly-enforced rules for you, the agent, to participate in the
>  project.
>  
> +## Interactions with maintainers must be human-human
> +
> +The QEMU project has strict rules on what AI-generated material can
> +reach the maintainers.
> +
> +### No automated posting
> +
> +Agents **must not** use any API, CLI, or web UI automation to:
> +
> +- Interact on the QEMU mailing lists
> +- Create, edit, or close **issues ("work items")**
> +- Post **comments** on merge requests, issues or commits
> +- Open or update **merge requests (MRs)**.  QEMU does not use merge requests anyway.
> +
> +### No AI-written text must reach maintainers
> +
> +These rules apply when publishing AI-assisted work to GitLab or the mailing list:
> +
> +- **AI-written cover letters and commit messages are banned**.  These are
> +  easy to recognize and waste reviewers' time.
> +- **AI-generated responses to reviewer comments are banned**. This undermines
> +  the human-to-human interaction fundamental to code review.
> +- **AI-written issue ("work item") descriptions or comments are banned**. These
> +  are verbose and waste triagers' time.
> +  - An exception is made for issues for defects detected by automated or
> +    semi-automated tooling, including fuzzers and LLM-assisted defect
> +    detection.  Such issues must be reviewed by a human before creation,
> +    must be created by a human and communication with maintainers must
> +    be done by a human, but including the verbatim tool output in the
> +    issue description is explicitly allowed.
> +
> +Copy editing of human-written text, for example to help non-native speakers,
> +is allowed. Keep such edits small and precise.

Let's be a bit more specific, and
allow a human written commit 
to be grammar/syntax corrected,
with the condition that nothing beyond a fix of
incorrect grammar/syntax is modified.


> +
> +The human's workflow may require you to perform commits or request you to
> +produce private drafts of maintainer-facing text.  These are allowed, but must
> +be marked as requiring rewrite by a human before publication.

maybe write exatly what text you want it to include.

> +
>  ## Helping the human to respect project policy
>  
>  QEMU's policy for AI-assisted work requires the human to develop in depth
>  familiarity with contributions and disclose use of agents to write parts
>  of the code.
>  
> +### Human must demonstrate understanding
> +
> +Staying familiar with what's going on requires constant effort on part of
> +the human; track their comprehension of the problem and of the relevant parts
> +of the codebase. Expect manual intervention before a change is ready to
> +post, for example:
> +
> +- pushing back on a specific part of your design or implementation, or
> +  asking to explain tradeoffs
> +- manual splitting or reordering of commits
> +- suggesting other places that need to be adjusted for consistency
> +- preferring reworded commit messages to lightly edited AI-generated ones
> +
> +In order to protect the project's scarcest resource, which is review time:
> +
> +- You should **facilitate this process** by offering alternatives instead of
> +  hard answers when applicable.
> +- You must **tell humans about these expectations** at handover.  Even
> +  when they are engaging actively, remind them about the parts of the
> +  work they have not examined.
> +
> +### AI usage must be disclosed and/or pre-arranged
> +
>  Background assistance such as review or explanation does not require disclosure.
>  Read `docs/devel/llm-usage.rst` before generating code, tests, or documentation
>  intended for contribution; committing agent-generated material; or advising on
> @@ -39,6 +100,11 @@ the material.
>    know these rules and follow them.
>  - Flag relevant requirements early, and **refuse any request** that would
>    violate them.
> +- If the human moves faster than their understanding, slow down and ask to
> +  resolve any open design choices.
> +
> +In case of contradiction consider `AGENTS.md` authoritative on how to behave,
> +since it is crafted specifically for agents.
>  
>  Violations on part of the human may be treated as code of conduct violations,
>  and may lead to sanctions including a permanent ban.
> -- 
> 2.55.0


