Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B22606A32A
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Nov 2026 10:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Jh5bVGFV
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTd7D-00023I-Gg; Wed, 18 Nov 2026 05:42:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xTd7B-000234-DB
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 05:42:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xTd79-0007zX-8Y
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 05:42:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794998526;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J6nB5hNDDLFPyL6UC11z8wuXocmeP22ooCkXbT/lpYE=;
 b=Jh5bVGFVnweNHbBzzkb8FHZL7SrbhoL38Xa7nHTHh616vDMR+tErX2kL0hKLkBHF0K0MG9
 jQGfdb6WClWZmmznEFQ28gaKuthyLcgpeDinkfFClLRVvLqyE5E61pPRvZ84nTGctK5E8Y
 7mqRrBKbx/MAEmdcpdR+uK2N8N2OotQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-615-Mt3Itd6_OiOE71uXBe6ufw-1; Wed,
 18 Nov 2026 05:42:05 -0500
X-MC-Unique: Mt3Itd6_OiOE71uXBe6ufw-1
X-Mimecast-MFC-AGG-ID: Mt3Itd6_OiOE71uXBe6ufw_1794998523
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5E1CE1955D97; Wed, 18 Nov 2026 10:42:03 +0000 (UTC)
Received: from pbonzini-thinkpadx1carbon6th.rmtit.csb
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3F136195B3C2; Wed, 18 Nov 2026 10:42:00 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Kevin Wolf <kwolf@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH 2/4] AGENTS.md: let agents know what the participation rules
 are
Date: Wed, 18 Nov 2026 11:41:48 +0100
Message-ID: <20261118104150.599535-3-pbonzini@redhat.com>
In-Reply-To: <20261118104150.599535-1-pbonzini@redhat.com>
References: <20261118104150.599535-1-pbonzini@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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

Tested-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 AGENTS.md | 73 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/AGENTS.md b/AGENTS.md
index 284059832b2..d646d548535 100644
--- a/AGENTS.md
+++ b/AGENTS.md
@@ -8,12 +8,80 @@ is **a scarce resource**.
 There are strictly-enforced rules for you, the agent, to participate in the
 project.
 
+## Interactions with maintainers must be human-human
+
+The QEMU project has strict rules on what AI-generated material can
+reach the maintainers.
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
+### No automated posting
+
+Assume that you are *not* an "official project agent" and that the
+official agent exception in `docs/devel/llm-usage.rst` does not apply
+to you; no such agent currently exists.  Therefore, you **must not**
+use any API, CLI, or web UI automation to:
+
+- Interact on the QEMU mailing lists
+- Create, edit, or close **issues ("work items")**
+- Post **comments** on merge requests, issues or commits
+- Open or update **merge requests (MRs)**.  QEMU does not use merge requests anyway.
+
+Defect detection agents are *never* official project agents.  The permission
+to include verbatim agent output in an issue description does not allow you
+to create the issue; a human must review the output and file it.
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
@@ -34,6 +102,11 @@ the material.
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
2.56.0



