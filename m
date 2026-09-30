Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D980CA5FB1
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 08:55:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBq5a-0001pv-Qd; Wed, 30 Sep 2026 04:54:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xBq5W-0001pP-UY
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 04:54:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xBq5V-0002lq-0q
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 04:54:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790758491;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Mx7owpQM1HPMgGroKCLt8EhMJ4lf1I/jRCMpBagBOqw=;
 b=e7Dtiel5mFfY/89gaLN4dolwWYsESYsMIls1jpHGo59ZQcPiOEMKl28d/aJoG0XAbdr+Dh
 Bn0nxEBmHnEd2wosZcXFP09++QmCyzD6noMI2TlNd0/DgcnKDl6gHqxdtjyVsjIczQZfU3
 oTnzKSRkxV+Py/iDXUZJ9k+/Ww7OcCI=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-E6nZheZHMAigfwg0yyw1bQ-1; Wed, 30 Sep 2026 04:54:50 -0400
X-MC-Unique: E6nZheZHMAigfwg0yyw1bQ-1
X-Mimecast-MFC-AGG-ID: E6nZheZHMAigfwg0yyw1bQ_1790758489
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-c293e604f0eso489617166b.3
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 01:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790758489; x=1791363289; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Mx7owpQM1HPMgGroKCLt8EhMJ4lf1I/jRCMpBagBOqw=;
 b=PyWqyCurXRxtMs9B8koRZqCP848zU/IxfL60BaGRNhr4VIcqlhCob5DKabE8s8VvqV
 OtWPopmNaXLjJGyiLFRHvSI9h9Sgvs6KUR4ASGjbA8LAbDx+UHeRh9VFdzMcUb85Qn5j
 CPTGgCRs+igIMyG1b7HOxgJOy7eQVrH+zrilY7pshMQTyTC0ZoPggYQvxj5fnicS7wUj
 4FqLhJxmc35yOGzr5P0xRog9p/rRIcPtlQVeA2SGIsXCFvLYNLD2RFdPLvGmfZgX+ooW
 dbpwZHSjOFbyZ79oaJYlaIFWfHmu6+V24ZxS/h1Uo7aF5wN/zkAk8PKl2tV1HSanTLin
 6D+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790758489; x=1791363289;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Mx7owpQM1HPMgGroKCLt8EhMJ4lf1I/jRCMpBagBOqw=;
 b=ZTOUmIVp8rgIjYjso8TxnMaz0fpeEGK61LVGiFScc/DVCuCIBg0q0K0g+2NW/MVqzV
 Zrh7XTOLF5FqJb9bB28H+UKH2je/MR+BBDHoRVGvjo5KipJptE81Ydy4bVO43dck2v4V
 YhMYq3vqhSae9xg8bIxFel/B+qQHwlFaq7IkSTTVvAn2V2HaU3tGjfg392n4QNpX/Xya
 z+3xAXB9XisQaFbpwhLlARSzxVrq1KW6bGCWxSTKCSgQDtVrVwB9qjV9Bo0Qiny14q/z
 KEkq/CzAJ+OTaiAqKTawljOD5g9HXxAf/cXKsKqSVJha4eQnWCj1tk9NDjy3wZJq55Lm
 4Z5g==
X-Gm-Message-State: AFuF++kj6eL2kfPhmCY5G3E1P4OaAAF8rFmphqlUe4uNjCrXQdd9chXB
 hyyF7vO7SNGNt3wPkJjJR6NP1kMtLcrLH53xxrypCrqsJjxzjgSBEl7pt/Ha+aUiAbTRFQKB47I
 5aB2viZ8OhtiDnLwC8JBgmvt/m/mG7nZnnPoSkvG5tvW4hJvgpuH5yq77Nvz8z3jalrnRDuogQY
 14pAWYoihQtQ+KoOHdIAtc+uFlG0xrvust/QpUGyjU
X-Gm-Gg: AYBFou3PPWt9SCTinU3VwKgMxvTnmHObSNB8yz0cTTZXQLLpoMcAYlwgEIYIeZAIcqd
 QcXJErdMggW1giGQ7kACABPxgpRdkj1Pb7nernkqZToKKIQ0WU37oLhX5FMmDdmhGDHrL12DKnP
 C4LxNimQQ/JKdjkKGEcip3GY8Y40C8nPq8YtulYcSXPAAAbweKsRvKbiP3Kc77zwlYB2q5TKyvU
 hSZ8UixeoDZ30csBpAFF33SFkn038tGtpW6+9ANv/HBDryULrXwvKj/+5MDH+v/2zWh2GGTz//k
 S6glZLcrgofdsz8mvA8JTM/X9M6o1AkHmSDn0D5lozIB4khejrsFh0ISuADe+QZEEOF6slMTyc4
 jlHwMlKeQt4H50n3p6RXQ3p7ckT74dqm5ddV1ky8miAarGyQQ6wyMLLtqz/XW6HbnMIEsetijA0
 90WfZE
X-Received: by 2002:a17:907:9708:b0:c29:5b0c:1b44 with SMTP id
 a640c23a62f3a-c2e23d9d0fcmr54323266b.37.1790758488737; 
 Wed, 30 Sep 2026 01:54:48 -0700 (PDT)
X-Received: by 2002:a17:907:9708:b0:c29:5b0c:1b44 with SMTP id
 a640c23a62f3a-c2e23d9d0fcmr54320866b.37.1790758488250; 
 Wed, 30 Sep 2026 01:54:48 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.232.249])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2e22fce6e6sm29757366b.71.2026.09.30.01.54.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 01:54:47 -0700 (PDT)
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
Date: Wed, 30 Sep 2026 10:54:32 +0200
Message-ID: <20260930085433.830743-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260930085433.830743-1-pbonzini@redhat.com>
References: <20260930085433.830743-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
index 6d2c7e1580b..8c7407b908e 100644
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
 
 QEMU's policy for AI-assisted work requires the human to develop in-depth
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


