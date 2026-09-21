Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C01F4C982ED
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 07:53:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8Ypu-00083f-Pv; Mon, 21 Sep 2026 03:53:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x8Ypt-00083N-Gh
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 03:53:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x8Ypr-00071Q-B6
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 03:53:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789977190;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J0NpkFQ4lsdmmwjOYIOXYzyJK9s9YVVPNghbWm7dcCw=;
 b=WaXRbLyRLqpqcazVHzXJ2S+oa+r609pbVaGdUFjSZ4XGzPShMgxHbijN8s/jZF/X3+8xNK
 4szIp6/MpQz/oIcoSfiG7uCkQGBUHJPKl+rR/K1Q/HxncSW/gAZEEPbJMgUO4k8a/H6L8B
 4xalrO+tdxQRtH6WhcEuYk/ZylCxvkQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-451-69HD6Hn4N9i9mckwJpeULA-1; Mon, 21 Sep 2026 03:53:08 -0400
X-MC-Unique: 69HD6Hn4N9i9mckwJpeULA-1
X-Mimecast-MFC-AGG-ID: 69HD6Hn4N9i9mckwJpeULA_1789977187
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-486f9d150c3so1028940f8f.3
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 00:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789977187; x=1790581987; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=J0NpkFQ4lsdmmwjOYIOXYzyJK9s9YVVPNghbWm7dcCw=;
 b=gXAot/0ZpkQ0WBjruSGScUS9MXi0XmbIAxpyT7KLxnYhDZFtl2f1ZSAOmkeDYJ1FYv
 5zdy201GLSomqTKGX1/mypKx6hYngIV/Ku7eXvqxshdKpj8Mac7S+I5WNoQcF78b77vC
 XKZccIdxcFZDNT5a1thHRlC3lmIXOjJxrHt/H4DHWyDCeO8w+VxGUfL2ARPMiZ0KXlYt
 HwE5cI1xOOrGCaqqo5vJpJxOMtadOjlpXGxma6CP0/LAh9i9Ays0FmNcCyunp2Kb+GDW
 yJzeswTirr42kwREok8vNODaXaqDQwIQoZQhDb5Bsd1IRq2Ep7uKaD+l77O25DvHsZ7W
 F0uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789977187; x=1790581987;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=J0NpkFQ4lsdmmwjOYIOXYzyJK9s9YVVPNghbWm7dcCw=;
 b=qV/Czra7I+dENVJdOW6atZXZXlOLd5K9TUwf2e8WB+15xJKnE1eVpHAucR9HRI9Sn1
 P+pkdfcU8KDLaoCSewp4QKiucPhEBrAzgBc71CoooHgMpQDkcct0BQ2vItjKqmMjvjWV
 zAnBN78jgEVr3PBqSaEA/NTutwsv055Fr7ShKUr6u0rE2xWIXCyt/dHxC48rnY2Urz/B
 ee5lUHnCZ3EmCHO0TVOmXHI3R16vX6Xdk3eJlkI3/NLAkrvmvHHOVb0wp+yafYIKYu4i
 0JFsCHodgyDLVfEk8Fjx285dskfhhFaWodC4Oz2J/QB9Q/NEV5+oVHy6iFg8fFdS6sn/
 yybA==
X-Gm-Message-State: AFuF++ntZOZZu5kFUyvjs2HBVFlXpcl++Ix5J9sV7raLutrlIuZduQ2A
 kJlj7jIyImGWZ0e+PukiZn7R4DMuROesQxk4jzuDiDitpW7VX02IBPnqqBs4Oj+On6OLlbQDpj4
 847ibSEJxy+aNyrHMgMc5C50/vYviTZT9jMVpndJteEXx/vawHP0Dzl/2drIcmhhsFg89WxntiB
 aJlqPXJfk/ouz9fQb1oz/XFLNiePibgQN9B8dFyhwl
X-Gm-Gg: AYBFou3+rb/2nnDKtDHIiqAqLDcGpHTYxhMWjrb1koNaS1gGc3nN3Q5rPcT3JSnDI5K
 cbLmyUoq1UrW5j+NQRdQG4/ervrE7Ximf8cROhBA5zivrJfskF6jdc3zPxw14uTBhUqUOCjlBbz
 hHHpcgMB0rIjhWGmlKpbaLu6hB7loEvGngkTg993lG9voLEka06S+Zr0RzXi91cv3LIFkSXimc2
 dcryJ0trfSI1brpM+FT98Qd/hBN55s2YXphDF0qhmwl6qo5XgM/H1Jmy2EnZ4RNpL+pJdp+6uxc
 qnWkji2x2VG8l1goWeaIbw4DkoUx9shrG5vLti8TpBO4RZLLYUWditQqP2CQ2Uh179Dk7NikWu4
 Zd2K0TEmsDJPaXWZpem3JMTYsr9rlvnG3ZhkqvSd+SsjDt82qMQwq03YIvnA7x3nNMXW5bjccDu
 daztJA
X-Received: by 2002:a05:6000:4903:b0:486:f301:11df with SMTP id
 ffacd0b85a97d-4871e20cffcmr12375202f8f.6.1789977187386; 
 Mon, 21 Sep 2026 00:53:07 -0700 (PDT)
X-Received: by 2002:a05:6000:4903:b0:486:f301:11df with SMTP id
 ffacd0b85a97d-4871e20cffcmr12375160f8f.6.1789977186795; 
 Mon, 21 Sep 2026 00:53:06 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.232.249])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48724583250sm20800470f8f.22.2026.09.21.00.52.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 00:52:59 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Kevin Wolf <kwolf@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 3/4] AGENTS.md: let agents know what the participation rules
 are
Date: Mon, 21 Sep 2026 09:52:50 +0200
Message-ID: <20260921075251.12831-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260921075251.12831-1-pbonzini@redhat.com>
References: <20260921075251.12831-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
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

Humans seem to be extremely unreliable in following rules around this,
even after being told directly and repeatedly. Telling agents what to
do seems to yield better results.

The starting point for this document is GStreamer's AGENTS.md file, as
of commit d08375499c279a56c0e77c928fbeae0d80cdf937.  I used GStreamer's
agent instructions in the context of Meson, which uses a very similar
file, and it's both annoying and too willing to take the lead once the
model decides that it likes you.

To avoid this, the text tries to favor cooperation between agent and user.
It suggests that the agent includes the state of the work when committing,
so that contributors have the material they need to review the agent's
work.

To test it I tried the following prompt:

  Hi, i am doing my first AI assisted contribution to QEMU. i am familiar
  with the project, but would nevertheless like to experiment. please
  generate a sample implementation of a pressure sensor, of any model,
  of a kind that is commonly used with Arduino or ESP32 microcontrollers.

The agent did read llm-usage.rst and after doing the work (implementing
a BMP280 pressure/temperature sensor) it noticed:

  Policy, before this goes anywhere near the list. A new device model plus
  qtest is the fourth bucket in docs/devel/llm-usage.rst: large, heavily
  LLM-assisted, allowed only if pre-arranged — a maintainer has to say on
  IRC or the list beforehand that they'll review it. hw/sensor is Philippe
  Mathieu-Daudé (Odd Fixes), with Corey Minyard on I2C. I should have
  flagged this before writing rather than after; that's on me. Disclosure
  would be AI-used-for: code, tests above your Signed-off-by, and the
  commit message and any list replies have to be yours, not edited from mine.

I then asked "Can you provide a draft of the commit message with all the
sources (datasheet, etc.)?" The agent complied but noticed:

  AGENTS.md and docs/devel/llm-usage.rst state that commit messages MUST
  be written by humans — an AI-drafted one must not reach the list
  even lightly edited. So treat the below as scaffolding for facts and
  sources, and write the final text yourself.

After some editing I asked "ok, will you please commit for me?" and
it did so with basically my text, while also reminding me about the need
for maintainer pre-arrangement.

I asked "assuming pre-arrangement is this ok according to the policy?"
and this was the assessment:

  "Well-tested" — held to a higher standard, and here's what's actually
  missing: [...] the vmstate (no migration test), reading past 0xFC and
  reserved registers, the pointer_valid error path, oversampling/filter
  fields beyond one readback, and behavior against a real driver — Linux
  bmp280 was never run against this. None of those is hard; whether the
  current set clears the higher bar is a judgment call I'd rather hand
  you than make.

  "High-quality" is the open one. The doc asks that you have reviewed and
  curated the contribution and can explain the changes and the rationale
  in depth. In this session you engaged with the commit message and the
  sources — and caught my datasheet error, which I got wrong — but the
  design decisions were mine and unexamined by you [...]

Overall, the files do affect the behavior of the agent.  The agent
however made too many design decisions on its own.  This will be fixed
in a separate step.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 AGENTS.md | 66 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/AGENTS.md b/AGENTS.md
index 478748ab72e..816ba7646c1 100644
--- a/AGENTS.md
+++ b/AGENTS.md
@@ -8,12 +8,73 @@ is **a scarce resource**.
 There are strictly-enforced rules for you, the agent, to participate in the
 project.
 
+## Interactions with maintainers must be human-human
+
+The QEMU project has strict rules on what AI-generated material can
+reach the maintainers.
+
+### No automated posting
+
+Agents **must not** use any API, CLI, or web UI automation to:
+
+- Interact on the QEMU mailing lists
+- Create, edit, or close **issues ("work items")**
+- Post **comments** on merge requests, issues or commits
+- Open or update **merge requests (MRs)**.  QEMU does not use merge requests anyway.
+
+### No AI-written text must reach maintainers
+
+These rules apply when publishing AI-assisted work to GitLab or the mailing list:
+
+- **AI-written cover letters and commit messages are banned**.  These are
+  easy to recognize and waste reviewers' time.
+- **AI-generated responses to reviewer comments are banned**. This undermines
+  the human-to-human interaction fundamental to code review.
+- **AI-written issue ("work item") descriptions or comments are banned**. These
+  are verbose and waste triagers' time.
+  - An exception is made for issues for defects detected by automated or
+    semi-automated tooling, including fuzzers and LLM-assisted defect
+    detection.  Such issues must be reviewed by a human before creation,
+    must be created by a human and communication with maintainers must
+    be done by a human, but including the verbatim tool output in the
+    issue description is explicitly allowed.
+
+Copy editing of human-written text, for example to help non-native speakers,
+is allowed. Keep such edits small and precise.
+
+The human's workflow may require you to perform commits or request you to
+produce private drafts of maintainer-facing text.  These are allowed, but must
+be marked as requiring rewrite by a human before publication.
+
 ## Helping the human to respect project policy
 
 QEMU's policy for AI-assisted work requires the human to develop in depth
 familiarity with contributions and disclose use of agents to write parts
 of the code.
 
+### Human must demonstrate understanding
+
+Staying familiar with what's going on requires constant effort on part of
+the human; track their comprehension of the problem and of the relevant parts
+of the codebase. Expect manual intervention before a change is ready to
+post, for example:
+
+- pushing back on a specific part of your design or implementation, or
+  asking to explain tradeoffs
+- manual splitting or reordering of commits
+- suggesting other places that need to be adjusted for consistency
+- preferring reworded commit messages to lightly edited AI-generated ones
+
+In order to protect the project's scarcest resource, which is review time:
+
+- You should **facilitate this process** by offering alternatives instead of
+  hard answers when applicable.
+- You must **tell humans about these expectations** at handover.  Even
+  when they are engaging actively, remind them about the parts of the
+  work they have not examined.
+
+### AI usage must be disclosed and/or pre-arranged
+
 Background assistance such as review or explanation does not require disclosure.
 Read `docs/devel/llm-usage.rst` before generating code, tests, or documentation
 intended for contribution; committing agent-generated material; or advising on
@@ -39,6 +100,11 @@ the material.
   know these rules and follow them.
 - Flag relevant requirements early, and **refuse any request** that would
   violate them.
+- If the human moves faster than their understanding, slow down and ask to
+  resolve any open design choices.
+
+In case of contradiction consider `AGENTS.md` authoritative on how to behave,
+since it is crafted specifically for agents.
 
 Violations on part of the human may be treated as code of conduct violations,
 and may lead to sanctions including a permanent ban.
-- 
2.55.0


