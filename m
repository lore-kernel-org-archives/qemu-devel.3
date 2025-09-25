Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5497BCAC5B1
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 07:57:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1gqU-0006Si-C5; Thu, 25 Sep 2025 03:56:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v1gqN-0006SS-Og
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 03:56:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v1gqG-0003Uw-Qf
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 03:56:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758786995;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=SbWG7Zlr4yi8D4ornrvh5tBoQGWL7huHdsqWJWJpEro=;
 b=gdTvWDP2yI29Obl237ApRHTPOnwh1lBQFjyg6dnCZWH73t0MbExObqo8gc6AF0Y7Ll+GyP
 wOnmp3dDC4Nd/ThUe9UhsCjBdslz/OogxrJ/2JLnFcI0kAj/t02KoWP3ImFdJno32HerMj
 lLyOs4cNToSBdoBkZU8oLLsTMJBnGr8=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-FTl2qwa8N7OWhurdJG233g-1; Thu, 25 Sep 2025 03:56:34 -0400
X-MC-Unique: FTl2qwa8N7OWhurdJG233g-1
X-Mimecast-MFC-AGG-ID: FTl2qwa8N7OWhurdJG233g_1758786993
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-b28ae2e8ad9so57310666b.0
 for <qemu-devel@nongnu.org>; Thu, 25 Sep 2025 00:56:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758786992; x=1759391792;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SbWG7Zlr4yi8D4ornrvh5tBoQGWL7huHdsqWJWJpEro=;
 b=TNmIjMJl2uwNknSXz64a6rFMN2XZUCpfJiMQ0WLPj3FEj5RCx1IctXPZKNxMjIlKm/
 nOTphwl0VDqQonLlNA/uuhYaJGPdAoS1BNPpg24BGQYVtvGXlhMvTzJ1mAue1GcoG8xd
 gaGWqrbChdtiKLbxVWAVHtOdam22S9dbhhXcF75qzEClgr/NZvve4NxYc6mtIjXhuiCr
 2QsqqU+KB/8yo9/eLrNyVJ/t2HTndn7LYCBZ/HrBd/UqEUybT326FgQJfbNEFYyIBhDA
 8VfJxjC/JArdnWvOYBlxzy3fSfD61kyCRbTlwTpM5kKjRNUQiYBYiU4dv/9IYmGf25R1
 LwrQ==
X-Gm-Message-State: AOJu0YyphoVfFhT6PsAEMYCd8NYboGWrnGC756r4v6XVWiJ02Xf/oyVS
 eFyTMNBp+joHAK/nPdgQRLppMTPBUjCqsOHOxCxENMT989awhM/2pTvTYQJQsueC/BYwhdSVhcb
 7jiYZrZY4B4K5HICEDHd1Fq+CmT7DQ3ST7wGPHFOHjUWDyJRfSsswhwWOGWVJxOH71GPJOorXwI
 jQsTmIDrBFFgGW1C2S0z6S3c4aM5oLfS0qlUyxrxO+
X-Gm-Gg: ASbGncvfmIPDu5RWiFuTMQSWzzJfm1caTnXESsqVTzwsd5m9/UBlfxY4+aujwUG8ffe
 0R/BkJengb5tVqOgqfoz3f9DexO2nkFoQ2JG+eOqub9WBNN3Ixm3zgTlwkQf2WQX58dtg7Se/dq
 pJvbLBWqDf4/rFl0FQeQ972SpgncE/ophYju0oBXt/hJc3aN7LQ6fG0c5l8699zsYmi2BL36tIV
 4jPCgWhuJxLBubb6DkCmwC6rW3z0gq0rZKOoVS2kUBr9Q3b9goNKU4kRc26cqmws/T5L7yDC+tB
 2L6IwOToUKw0WUSqWdo/n5S3/nWgTUgB5vkIlkTdYBVuskzXos/wpSIxAzulN/gv2RcQ/C/qs7m
 o4GdFHin5/h7yiHu0M6/oxEG5vsPCXUIN8BREQ4fcsjiVTw==
X-Received: by 2002:a17:906:c14e:b0:b07:e04d:c89d with SMTP id
 a640c23a62f3a-b34be7cee18mr303512966b.48.1758786992488; 
 Thu, 25 Sep 2025 00:56:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHhmr9rZMslqHqv7SsR593thdpTmCpGneapmc0161yGNE3mOLfWcFb44PmkTUaHhXSInBE9ow==
X-Received: by 2002:a17:906:c14e:b0:b07:e04d:c89d with SMTP id
 a640c23a62f3a-b34be7cee18mr303509366b.48.1758786991938; 
 Thu, 25 Sep 2025 00:56:31 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.127.188])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b35446f76b4sm111777466b.64.2025.09.25.00.56.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Sep 2025 00:56:31 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, stefanha@redhat.com, berrange@redhat.com,
 alex.bennee@linaro.org
Subject: [PATCH] docs/code-provenance: add an exception for non-creative AI
 changes
Date: Thu, 25 Sep 2025 09:56:30 +0200
Message-ID: <20250925075630.352720-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

AI tools can be used as a natural language refactoring engine for simple
tasks such as modifying all callers of a given function or all accesses
to a variable.  These tasks are interesting for an exception because:

* it is credible for a contributor to claim DCO compliance.  If the
contributor can reasonably make the same change with different tools or
with just an editor, which tool is used (including an LLM) should have
no bearing on compliance.  This also applies to less simple tasks such
as adding Python type annotations.

* they are relatively easy to test and review, and can provide noticeable
time savings;

* this kind of change is easily separated from more complex non-AI-generated
ones, which we encourage people to do anyway.  It is therefore natural
to highlight them as AI-generated.

Make an exception for patches that have "limited creative content" - that
is, mechanical transformations where the creativity lies in deciding what
to change rather than in how to implement the change.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/devel/code-provenance.rst | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/docs/devel/code-provenance.rst b/docs/devel/code-provenance.rst
index 8cdc56f6649..d6e86636964 100644
--- a/docs/devel/code-provenance.rst
+++ b/docs/devel/code-provenance.rst
@@ -290,9 +290,11 @@ Use of AI-generated content
 
 TL;DR:
 
-  **Current QEMU project policy is to DECLINE any contributions which are
+  **The general QEMU project policy is to DECLINE any contributions which are
   believed to include or derive from AI generated content. This includes
-  ChatGPT, Claude, Copilot, Llama and similar tools.**
+  ChatGPT, Claude, Copilot, Llama and similar tools.** The following exceptions
+  are acceptable:
+  * **Limited creative content** (e.g., mechanical transformations)
 
   **This policy does not apply to other uses of AI, such as researching APIs
   or algorithms, static analysis, or debugging, provided their output is not
@@ -323,8 +325,9 @@ content generators commonly available today is unclear.  The QEMU project is
 not willing or able to accept the legal risks of non-compliance.
 
 The QEMU project thus requires that contributors refrain from using AI content
-generators on patches intended to be submitted to the project, and will
-decline any contribution if use of AI is either known or suspected.
+generators on patches intended to be submitted to the project, with exceptions
+outlined below.  If use of AI is known or suspected to go beyond the exceptions,
+QEMU will decline a contribution.
 
 Examples of tools impacted by this policy includes GitHub's CoPilot, OpenAI's
 ChatGPT, Anthropic's Claude, and Meta's Code Llama, and code/content
@@ -347,3 +350,19 @@ requirements for contribution.  In particular, the "Signed-off-by"
 label in a patch submission is a statement that the author takes
 responsibility for the entire contents of the patch, including any parts
 that were generated or assisted by AI tools or other tools.
+
+The following exceptions are currently in place:
+
+**Limited creative content**
+  Mechanical transformations where there is reasonably only one way to
+  implement the change.  Any tool, as well as a manual change, would
+  produce substantially the same modifications to the code.  Examples
+  include adjustments to data structures, mechanical API migrations,
+  or applying non-functional changes uniformly across a codebase.
+
+It is highly encouraged to provide background information such as the
+prompts that were used, and to not mix AI- and human-written code in the
+same commit, as much as possible.
+
+Maintainers should ask for a second opinion and avoid applying the
+exception to their own patch submissions.
-- 
2.51.0


