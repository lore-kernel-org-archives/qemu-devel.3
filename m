Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3DCAC982DE
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 07:53:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8Ypx-00084P-5R; Mon, 21 Sep 2026 03:53:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x8Ypu-00083g-T8
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 03:53:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x8Ypt-00071U-98
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 03:53:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789977192;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wnh7DOAB5IFUlWjBOen90LfFp13TtVsUBEpXEZu5ozI=;
 b=eLrip6ZK5ilKjyfHaYN0kdjeRwu0ZXI2+8KWlBJ2Wuow0Q92NuG4ZbjEd9p0CjmmBhwKGX
 naMjVhWosWQMsjw0sJeDY0mTtkdoRrdtF2EU8pvs3IggYT6HZB/+4OKa8JPbXty4hqFHR8
 1NTlESztowPY+xGpentkv1Pfq7/cc4I=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-567-SqcD0o03MSaEm8Tnml0KTg-1; Mon, 21 Sep 2026 03:53:10 -0400
X-MC-Unique: SqcD0o03MSaEm8Tnml0KTg-1
X-Mimecast-MFC-AGG-ID: SqcD0o03MSaEm8Tnml0KTg_1789977189
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-49cd83ca361so28930855e9.1
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 00:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789977189; x=1790581989; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wnh7DOAB5IFUlWjBOen90LfFp13TtVsUBEpXEZu5ozI=;
 b=WYWtzVCOiVi+M+039WWDiuYIdllqAfiVU4I6dQZuSUoxpryYoIR7vlub/Er2Ywmekq
 1QHvkzUtVMKC73zcZ6v11KtDuyAFjcxCPRVpANOpoUOOdtmyo5sraF0SYEmAFNgZdb9l
 OND67Zh7E21dlsl3t/oJtDGto6nisP5JNM6+HlpB59F9XshB35VOnp5DZ0DT+1SYg+f7
 f2V8K+xPzkncDMF0caLMo6ry/wiFohsl2PgQSvUxuOVxJRtSd6h5jcFSIjW497A07aIP
 xfPzHRF7q8mkgmLYhLmBkpIPQZDxz7lJgHpCmmmIQcFw/pYLDnDDdM0TC6fpESjp3822
 dASA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789977189; x=1790581989;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=wnh7DOAB5IFUlWjBOen90LfFp13TtVsUBEpXEZu5ozI=;
 b=oNHVF5yN9c8dMFcyKBuFZMcoN6lvkF/LVVi7s+G7Q8IsMW4Kcn11Y1rhm2NmNyhnsR
 bvrKGpARgrT8c4S/yoj0111YAwdJ/oDbvEplc0+k3OZR7vIQ1RR7Acua2R9k7i4fqJba
 XCKE46KHb0rlspsqaQ6puzflXcaM4mF8bfu1Iu96KG3ccWxMCcE03UIRo7LL8BYKlReK
 8dmotruw9zOfH7OVkIMaVDoWqaMNziZcjdo656dyYX9psreIFvRcsygw4L+Q9GsPi5s8
 FE3FHaC5R3RVvKAAZyLR0xQcAedd0C8k4kPfKi4KFCCmkjcp3Nbl2cbKvWXyaEsbyTjL
 gLwA==
X-Gm-Message-State: AFuF++l4APTm5WpfK/xcxzTlgqS/fRClNf7lnAigLBMQpOeynOG5Lhcq
 aVFTkSoXY1cFqFF9o6v1hw79x7k60Jpe1s/6gzh/qAO54VrVay7Nkz68XyP0+RgeU2JILyPyFin
 1fX8+J12iV/quUi4eHjYU7ljHZ+zlt2mdMpBNfm2EDpsrQU8cV3ySYl/7T7GIU+e6ZsaR7CDRDt
 Mmak70Ew4Wf9To0+gy1Llw8Sa29nfcJBsJ0Ty7v+GZ
X-Gm-Gg: AYBFou0AVRagBhSb08eV16fb6mW96grHFlVAEYWZ0kWdy9ygkdIeTzxswY1LelAxty7
 GlbpnWY6XauzCILqST6yeMjOpNw0u//b3g+D0sq5FYi05hOPoz8RUkaYJTheuy2qrRnWgcFqxow
 WbHScwmEQw1a8GSqgVRyuGFJXxET3X3km40l6d4wOFFLqS9uXxQPrb/Ur/cyoH5jsuWNitrScBb
 kZOPEZl39b/afzVrIgqE9NhT3lJvO2KI6/eXMeT4mo4XNJIOZi29ke2hLj5EUO09YoiN4JWsu5S
 0IEJlPPytF6JhLU9gUYZlDFUAjOkFAcXz77ah4uTk7M3QJl96z2vC8awXrsgGc7RgwYFeMCVELC
 +Q4t5NHvPDpQ7QndJ5Zl2bmAqalMcPLg030T069Ss9DY0MdhpLKRhRv7lQEDFqNECqmVIw+LpRF
 VxRD05
X-Received: by 2002:a05:600c:3b82:b0:49f:ce72:dfe7 with SMTP id
 5b1f17b1804b1-49fce72e040mr99349305e9.35.1789977189301; 
 Mon, 21 Sep 2026 00:53:09 -0700 (PDT)
X-Received: by 2002:a05:600c:3b82:b0:49f:ce72:dfe7 with SMTP id
 5b1f17b1804b1-49fce72e040mr99348705e9.35.1789977188850; 
 Mon, 21 Sep 2026 00:53:08 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.232.249])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fcd0eab91sm228887375e9.1.2026.09.21.00.53.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 00:53:07 -0700 (PDT)
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
Date: Mon, 21 Sep 2026 09:52:51 +0200
Message-ID: <20260921075251.12831-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260921075251.12831-1-pbonzini@redhat.com>
References: <20260921075251.12831-1-pbonzini@redhat.com>
MIME-Version: 1.0
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
index 816ba7646c1..cb3e6087ee0 100644
--- a/AGENTS.md
+++ b/AGENTS.md
@@ -52,6 +52,9 @@ QEMU's policy for AI-assisted work requires the human to develop in depth
 familiarity with contributions and disclose use of agents to write parts
 of the code.
 
+The golden rule: **The human should know the alternatives before
+implementation. ASK before choosing for them**.
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


