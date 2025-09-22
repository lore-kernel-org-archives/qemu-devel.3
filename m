Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C5A3CAC5AD
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 15:49:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0imj-0006uB-P3; Mon, 22 Sep 2025 11:49:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v0imf-0006tX-59
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 11:48:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v0imc-0003Vu-H7
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 11:48:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758556132;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nBYuctWmVpcS8rZDF2chLHZY36EbMeFS32RaY1TH6aY=;
 b=dsiAyJvAtEIIKizdqbYWeZtDxvz3YHJ3NmiXHvA4AAqdOx0TuahENkeo6V9SOifeWe/P2i
 C/nTG+8AKCJOYtdHrzMA+drdxobMlgHiIR5ZayJ6JgGoltWh1MfmvAVisY65KrK4LkOFFF
 8ep1zAkB/G09oEm622NLlIr2uItxzqo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-67-OboIW7TwPfO4rB-5WS2dww-1; Mon, 22 Sep 2025 11:48:49 -0400
X-MC-Unique: OboIW7TwPfO4rB-5WS2dww-1
X-Mimecast-MFC-AGG-ID: OboIW7TwPfO4rB-5WS2dww_1758556129
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-45f2b0eba08so32681775e9.3
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 08:48:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758556128; x=1759160928;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nBYuctWmVpcS8rZDF2chLHZY36EbMeFS32RaY1TH6aY=;
 b=uoB9KTNcM5C2OVEmC1b7B46H6oHqPwcn2H8AoAUFxMVTRG7ILxMZd3zWolQKBOyHMY
 ATT23gmNz3UcJWPmSBnpwdWv44TZPDko/bwBY6fdM+/5hegjWXIF6hQe+KxJ3ucJas+G
 JrZVdQo9rkni6YDyMZt/zEyqjR+hjkik6WaFoafQalMmneA6Pv3BpC1CPOwPHJjv2W3H
 +52wknAINTMxR0HW0Z30Xx4m9xjHbPDtzsPSvBkhUBhBi5iBuT8oHRk1RVzjwRNdDXuD
 y5FdfZn/HM6RgeNSaipL1yA6BmCB4dG8KS3XXXIXLf1TX3kzkw9gy2glKB7iWAbNkoII
 3AgQ==
X-Gm-Message-State: AOJu0YzLWfUTx0mjQv4LKwX874iG48IyuNzKaK436Kvz+TeKhKflIRHy
 7Qzpz609/vajxga46KFEdiKmwhhP9oVXwYyRd0Q2r2zWyj+XCKbnWREAH19C3VFLDit13Zqtiza
 4wl6s4uflVfU8pwJpxlh/8Z2+xixBDzD1WpyhUu0wRTV5G9X7GRD/NgXW3D93AsI9aSLxEL0llJ
 3VN1ZgoTzoz7ZWVrxGBFTJbQyMe+wC4dAbwPtgR3zz
X-Gm-Gg: ASbGncuIxR6XOJrGQUZhCo4nOlMtz1ipWkcr0yrAHC8vnQhAACeKFORhNe9n8wZ5SmM
 0NcDh7Qa/6S230heZPK+qvZ6K+E6A2oXWgGv3K5xhYxMxpqsJCuVyZgpbn+VLseeyYoINILaCya
 dCIOqI21SwP47Kc8j8hC6hYqXmHcEzudcDc/UXd7a4lJANdWnrDSlryI3pUw5xxIDgnWu/14kt3
 HwZBShFdhLFFTj+jQTsZW1zXf79ZFQEWK0oft+wozow9smkTJ43qfO2VrF1NLcs9YfKAv9Kmz9I
 p6LvGfYiWAngwQsiPe1mF6fsTrt1M8XY/JU5cjvIxw2k2vdkyF9UcaJX8TksU8QZORkJBTA1Rw0
 X2bRh7n3U5ifxGlTquMXS7jBunZrPbQ5PaOkkRVutwjc=
X-Received: by 2002:a05:600c:a02:b0:459:d645:bff7 with SMTP id
 5b1f17b1804b1-467e7f7d5bamr133570055e9.12.1758556128162; 
 Mon, 22 Sep 2025 08:48:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4uALIG5CoX2XKVrKHNPTFB8j+MGLTeLOY8QG07lK29rYYNEas8tEewIxKBeYdLUYcmMuNZw==
X-Received: by 2002:a05:600c:a02:b0:459:d645:bff7 with SMTP id
 5b1f17b1804b1-467e7f7d5bamr133569825e9.12.1758556127737; 
 Mon, 22 Sep 2025 08:48:47 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.47.123])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46cddcd0759sm28760665e9.0.2025.09.22.08.48.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Sep 2025 08:48:46 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH 1/3] docs/code-provenance: clarify scope very early
Date: Mon, 22 Sep 2025 17:48:40 +0200
Message-ID: <20250922154843.60233-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250922154843.60233-1-pbonzini@redhat.com>
References: <20250922154843.60233-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
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

The AI policy in QEMU is not about content generators, it is about generated
content.  Other uses are explicitly not covered.  Rename the policy and clarify
its scope in the TL;DR section, as a matter of convenience to the reader.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/devel/code-provenance.rst | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/docs/devel/code-provenance.rst b/docs/devel/code-provenance.rst
index b5aae2e2532..dba99a26f64 100644
--- a/docs/devel/code-provenance.rst
+++ b/docs/devel/code-provenance.rst
@@ -285,8 +285,8 @@ Such tools are acceptable to use, provided there is clearly defined copyright
 and licensing for their output. Note in particular the caveats applying to AI
 content generators below.
 
-Use of AI content generators
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+Use of AI-generated content
+~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 TL;DR:
 
@@ -294,6 +294,10 @@ TL;DR:
   believed to include or derive from AI generated content. This includes
   ChatGPT, Claude, Copilot, Llama and similar tools.**
 
+  **This policy does not apply to other uses of AI, such as researching APIs
+  or algorithms, static analysis, or debugging, provided their output is not
+  included in contributions.**
+
 The increasing prevalence of AI-assisted software development results in a
 number of difficult legal questions and risks for software projects, including
 QEMU.  Of particular concern is content generated by `Large Language Models
@@ -322,10 +326,6 @@ The QEMU project thus requires that contributors refrain from using AI content
 generators on patches intended to be submitted to the project, and will
 decline any contribution if use of AI is either known or suspected.
 
-This policy does not apply to other uses of AI, such as researching APIs or
-algorithms, static analysis, or debugging, provided their output is not to be
-included in contributions.
-
 Examples of tools impacted by this policy includes GitHub's CoPilot, OpenAI's
 ChatGPT, Anthropic's Claude, and Meta's Code Llama, and code/content
 generation agents which are built on top of such tools.
-- 
2.51.0


