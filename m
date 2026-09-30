Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9790CA5FC1
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 08:55:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBq5b-0001qJ-FU; Wed, 30 Sep 2026 04:54:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xBq5Y-0001pY-80
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 04:54:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xBq5W-0002m3-KC
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 04:54:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790758494;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4zb6j5g3eap32rc7OHohtJSqR8TqT7I9O20j5+utjB4=;
 b=YZvhJ7jIkBceFpsuWl5BFG2AtsC7VIESdMbixhDwR5tpevXo/cg6/YKCHi/hMtgGyUW72X
 ivpZsrwPy2/Kt1RsaY/YN1/YXLuNEp2JQiS1cndV2Ie7faZUeQva83xxQC2VGFWrTKV/nH
 1sjGGQPkcWyOzgKSg48YAUsIpWFOFzI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-494-EKX4MwLJNGyXApSBrSgN4g-1; Wed, 30 Sep 2026 04:54:52 -0400
X-MC-Unique: EKX4MwLJNGyXApSBrSgN4g-1
X-Mimecast-MFC-AGG-ID: EKX4MwLJNGyXApSBrSgN4g_1790758491
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-495689bfcc8so43326615e9.1
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 01:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790758491; x=1791363291; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4zb6j5g3eap32rc7OHohtJSqR8TqT7I9O20j5+utjB4=;
 b=qPCl9LrGV5IE96SlGgfh9qjsLnRfN9jhXhDosl0R3ScZWc4ubsoeq+7qbeg9RjGGSU
 MUksPRe8d/LOTZrytP9L+3T+IynpfXIeIqiYPNHOK2qy1ylrPZZycmlCxgPc2t+QbqNU
 kBRRmPdTn1MRP5dYEmvmSTnXTplEhz0pWfP1hLKqaByWYHuVQuu1TzPOppebnxYP4KDK
 ZvOcQ9S5wjBkvcARlWtA6akB9u7FE2+U6cVN7qOWrM1ms4fSuUou9T0P+chEQXaN4ou1
 1mbHDkU3EeMIKbpSfl1J9Pav8I1BIHzGExm/2HPa0dH6LBzgq2afl4jLHiQ4btce1tR3
 mX4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790758491; x=1791363291;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=4zb6j5g3eap32rc7OHohtJSqR8TqT7I9O20j5+utjB4=;
 b=Fw8wJwZPOOG4OmhYQ5YPu8mHq43ig35uzhqhhPwzAkHUt2ODe5Q3qvyef+O2SIY3bp
 xPcGVfdmShLpEksJxJM6GmPTFmBZz87JA+cIE42bfZqdLztlOlZQiGYdtsEuQUsTnSrO
 b/X2xSrugVMsXlElrlr6amgdAI6URFv+/KV6hsAIglDt2EFCSkHMOxYJ7g66EYlCvmL3
 NqAj3v9WgGYuK1pX/5BN2FtqGcUJs9oBkQO2Ix1HELD0BT+ugExiKgHZfPiuuG+zfMSz
 HsSkW/d4iwOLeVW4l5Snf0nXaPqQ+Ybyua9lINUvZekFxEcU8FK9WfX30bQtFQ6NzW/G
 RuJg==
X-Gm-Message-State: AFuF++n7JulCMN/F9y+RVNOLHG3mtaxOwAoC8N5i+fwMaiX3GxmG7+DV
 DKeKZjwwjjjviN5mljQqHIAnFWnYsSA6FClqis4jeGlDgwNfn1etRRN5MII0uF1DA+KabXvsJ7y
 k9O7fdEr+cUgphv9misCjKjMJebD8mp1z2I/zzNj9cDTS7rOYOwTbilTjthWaXvu22yFguNeVtp
 MNpS+gYFrltHqW+stVWD+vyNKNky8kddkKfLJVv1bl
X-Gm-Gg: AYBFou3LguisTZDtWGbRHl3TNdd+Sx6hxjYVb3iYLnIU6TlYSAcD7tRVU1oFh1JpH7O
 Gv7UAFYfsaFuPvGnuSC4rcJ748CASz7dF/icjZkQA3cHdF3kDfQJ3ygHrcZshP4004d6qPXhpO8
 q+Rd5n1OuCGwB2t97/mb6v0wMkXKX+oTzn71ZDXxpi6/le5vmM0cU6h4BqXMKSCYKWRfHddXDUV
 wsfpP45s3Aa3kMUvri/UYNeBX7PqJvvTHJ4x6gmh9sQjUHv3UV+QOuqPygVl/3jtMnXnknYYycd
 +r/KJfdRcgTNv//xFhACA9Z2UK1CvE0wFHzZ283nxBL5N4TLjxGWi+myjd6ANiYV0jXIauIXosB
 jwZ+mQtCAmEDBQDuYUmYrzEGAcRxTtKzv/FXGI0fPKiKWmDObvWw/fWpzsizRE/KuirmWwzPEPW
 +iTlXv
X-Received: by 2002:a05:600c:3486:b0:49d:1f32:c911 with SMTP id
 5b1f17b1804b1-4a01ad8edccmr10791765e9.3.1790758491307; 
 Wed, 30 Sep 2026 01:54:51 -0700 (PDT)
X-Received: by 2002:a05:600c:3486:b0:49d:1f32:c911 with SMTP id
 5b1f17b1804b1-4a01ad8edccmr10791435e9.3.1790758490910; 
 Wed, 30 Sep 2026 01:54:50 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.232.249])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a015abd9ffsm40265525e9.2.2026.09.30.01.54.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 01:54:49 -0700 (PDT)
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
Subject: [PATCH 4/4] AGENTS.md: make the human part of the design process
Date: Wed, 30 Sep 2026 10:54:33 +0200
Message-ID: <20260930085433.830743-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260930085433.830743-1-pbonzini@redhat.com>
References: <20260930085433.830743-1-pbonzini@redhat.com>
MIME-Version: 1.0
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

This came out of the experiment with the first version of the AGENTS.md
file.  This addition improved the behavior of the agent from the very
beginning.  The very first answer to the same prompt was "I'll orient
in the codebase first, then we should talk about design choices before
I write anything".

In fact, after thinking it pointed out from the start that this requires
pre-arrangement and asked two questions (how to represent the pressure and
temperature in the QOM properties, how much of the behavior to implement).
Even with a single data point it seems worth trying.

When asked to commit autonomously, the LLM also clarified that it
wouldn't add S-o-b trailers and that pre-arrangement was on me.
It included "Message written by an AI and to be rewritten by hand; not
for submission as is" in the commit message, a "handover notes"
section about design choices that were made without the user input,
and the umpteenth reminder that the work may only be posted if a
maintainer has agreed beforehand to review them.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 AGENTS.md | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/AGENTS.md b/AGENTS.md
index 8c7407b908e..8e18709ee50 100644
--- a/AGENTS.md
+++ b/AGENTS.md
@@ -52,6 +52,9 @@ QEMU's policy for AI-assisted work requires the human to develop in-depth
 familiarity with contributions and disclose use of agents to write parts
 of the code.
 
+The golden rule: **The human should know the alternatives before
+implementation. ASK instead of choosing for them**.
+
 ### Human must demonstrate understanding
 
 Staying familiar with what's going on requires constant effort on part of
@@ -72,6 +75,22 @@ In order to protect the project's scarcest resource, which is review time:
 - You must **tell humans about these expectations** at handover.  Even
   when they are engaging actively, remind them about the parts of the
   work they have not examined.
+- When handing over text that the maintainers may see, remind the human
+  that it is a draft and name any design choices that are still open
+
+### Make the human part of the design process
+
+In order to guide the design rather than providing an all-encompassing
+solution:
+
+- You must **discuss design choices in the main conversation**.  Delegate
+  research to sub-agents but not judgment, and do not treat your own
+  reasoning as a substitute for the conversation.
+- When you consult a subagent, **report what it recommended** and
+  possibly confirm the choice, rather than simply presenting the outcome.
+- Reinstate as visible text any design decision made while thinking.
+  Design decisions hidden within thinking blocks prevent the human
+  from building familiarity with the contribution.
 
 ### AI usage must be disclosed and/or pre-arranged
 
-- 
2.55.0


