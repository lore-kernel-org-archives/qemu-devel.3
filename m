Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFC9ECAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 11:33:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0emb-0006m6-JJ; Mon, 22 Sep 2025 07:32:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v0emY-0006lL-3I
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 07:32:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v0emU-0001mX-It
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 07:32:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758540748;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3ygR+TBxEysSyhAtQHJklwk6mtotPKGvbijBWQXyPuc=;
 b=iB81WCfAWz4KQtjTbu8YksQPd3kCNCbPhOUkcLqKtyU4rYNm/cttYwv0ZO4apPay/yGlKM
 aqD3sb0GaCtU0E27xXnsZmBBuDNyu77V9iFd1sEU+q/AeWBYNi/aBW53e2dG9IzD3aPWDP
 2O0wAsS84z96f83w8dCnH9yY62if0h4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-278-HhjTHkquPImGmib5hDVz6A-1; Mon, 22 Sep 2025 07:32:26 -0400
X-MC-Unique: HhjTHkquPImGmib5hDVz6A-1
X-Mimecast-MFC-AGG-ID: HhjTHkquPImGmib5hDVz6A_1758540746
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3ece0cb7c9cso3172333f8f.1
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 04:32:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758540745; x=1759145545;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3ygR+TBxEysSyhAtQHJklwk6mtotPKGvbijBWQXyPuc=;
 b=Fk4zuiVEf25Tilk0Enu1sX2caUrlQ4qgIw0BBcvrHbkRP8QbTpay6xYRu3XRC3ASRW
 CSHoeO3UE5gYJ1boyBS0yP4Wb/BKUAvANxy+L80Zl0usfT6bCtrYP7OL2gidbcSDItk0
 GbaA9oYkcB63O5e1tMGw0MtlLhgzkQtK9KlPsQ0wFdBqieAN7ewbmHFTYfanZVfwA3Sv
 83KAwOpq5E1bYYjGDIyMj14yHmYW55M+e0ZxNeoICHIYTdVkc/yrNaSJ5lKq7nzmGNBQ
 fe9glVp8t0LIR2/1Q9mOxipaeChZlRLLvXoMvEu+0mgPJn/fFCL7DfSodP+EFg+yVxqM
 PdIw==
X-Gm-Message-State: AOJu0YylYWSAmw2CWtuf82bLylu4CAovq6EifrtdUuREuuCVSSp9Lu+y
 uwqhTDhYpEHB4yR1pZcei6sna+F/GpEJ/7YIrn6QnaxGjE8qbH/lP79kjrrRbkEUdWVnkpf76fR
 7JZpTrdoh0d0l9ZbmsGoWOK4hD3icvG+gsV/whmTqiWwoBh2H+DRINHOsdEyF3gDJN6sJP1iS69
 2PTVqY7eCaS9VOw/hG5HlEy9kwYqWNCYfkxl714alH
X-Gm-Gg: ASbGncvlXYTwqQE5HrYJPaR43cmIYfkOZEqtT+21AoEoml7H0vSiF1ueU4bAz0K4iwW
 bSoNYN6Hb3z1HLq+3Z5EQqwECsRot8FcFvmppjibvxOqYI3XzFysYnialf8ty7tgWj6cx3SWgXN
 B/+99Fl8ioDYsXGHGrHpvzkWvJXiwvM64BpUVifU2yPOVgaCkLNbYS+JEqIKO1p0/HsCsTNTrZI
 VTUPUSNvx1YwmJKz2JlNn3loSPZ3elO1h8Su980RVp//cDejetqHl8YpgU5/nxRUYrkDA+a9kaq
 unyd4Jy/Xep5WZhSVxNVZoA/z5cJsIaeonMGY9azEIJJtvL5aBC6tSA1hGIDG5jdjN7E+t6EhYL
 UVZRV3OqKAIpNpkiyn8Txnk00QhWXHK2qenboG5XFkdU=
X-Received: by 2002:a05:6000:40cc:b0:3ec:d78d:8fde with SMTP id
 ffacd0b85a97d-3ee8585e38dmr10304890f8f.44.1758540744662; 
 Mon, 22 Sep 2025 04:32:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFtkmjwxG41JZQ26ueWqbgWb+OBEnHp+Q1/gCQU2FnuFPYdW1I62mAWq0nX9WY0OdtO7sCc6A==
X-Received: by 2002:a05:6000:40cc:b0:3ec:d78d:8fde with SMTP id
 ffacd0b85a97d-3ee8585e38dmr10304849f8f.44.1758540744073; 
 Mon, 22 Sep 2025 04:32:24 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.47.123])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46138695223sm241623805e9.5.2025.09.22.04.32.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Sep 2025 04:32:21 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [RFC PATCH 1/4] docs/code-provenance: clarify scope very early
Date: Mon, 22 Sep 2025 13:32:16 +0200
Message-ID: <20250922113219.32122-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250922113219.32122-1-pbonzini@redhat.com>
References: <20250922113219.32122-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The AI policy in QEMU is not about content generators, it is about
generated content.  Other uses are explicitly not covered.  Rename the
policy and mention its scope only as a matter of convenience to the
reader, in the TL;DR section.

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
@@ -322,9 +326,6 @@ The QEMU project thus requires that contributors refrain from using AI content
 generators on patches intended to be submitted to the project, and will
 decline any contribution if use of AI is either known or suspected.
 
-This policy does not apply to other uses of AI, such as researching APIs or
-algorithms, static analysis, or debugging, provided their output is not to be
-included in contributions.
 
 Examples of tools impacted by this policy includes GitHub's CoPilot, OpenAI's
 ChatGPT, Anthropic's Claude, and Meta's Code Llama, and code/content
-- 
2.51.0


