Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A66BCA0EC0
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Aug 2025 09:44:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulP4N-0007X8-MT; Mon, 11 Aug 2025 05:43:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ulP4J-0007Wj-Am
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 05:43:51 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ulP4G-0002tn-Vr
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 05:43:51 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3b780bdda21so3393379f8f.3
 for <qemu-devel@nongnu.org>; Mon, 11 Aug 2025 02:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754905423; x=1755510223; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=DBszhYKDJyGQ61hGjyZwJt6B5WU1RFKrIu3tVde7pzY=;
 b=oQotGLm0qba885BDn38b9CmC33iXhoPbofkfzh7QFxVFXOHzD4LnU5GWqbCnAmId7U
 EJhaN7CPQ1rFGQUkYzSzz5bsEbjiRVPQmzfCBN9+gNdeV+2a8fDR2fxHbepKIlHhNYDL
 sbnrRg341hDhER2qiLRKnP6LX81M3Imhwp9C1uqVacMTobaieP8mcp4bzvw9xgh3kVdt
 OX5X2FoFr7+cHfYalpExyjeIxf3okdlOr01a7nYwMQljKzS79TYwlh3JET+oTGRYZjDC
 Dh1NMNvJehSiwLmhTVskS57YOYwTyxlCzF3z2BD1xOdmkIRIrzZgMwH6O8qxsM22+SLJ
 ogpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754905423; x=1755510223;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DBszhYKDJyGQ61hGjyZwJt6B5WU1RFKrIu3tVde7pzY=;
 b=gs0KyR7H19+DiVwfIwbJpwkIocXL+RvUVJ6sbQvd0Eax+gtdzRGNn7nB6rFbhaFbYt
 V8BiiByfacaajTpeGhE0n2BefebZP1Dusvh2OqcnRlfqngKdoo+fU1UNGKH1s2ANSWuZ
 /ocKztCQugU0sPJ8ppNZQMDNTfs3V0BerAYQge3EQ2oEVCCtjO1Xe/p1v+8XXO/fqsF7
 rc4AqCg8cJOPDeLP474Le5qoe+561w3i74ytdbWRQ7NfXktPAvUA0sBB8/bgt5dShxlt
 MMRzenPjGezLVkRSw8MQBLH0EfgwtKJQjprqNCtaiQqKsPedV/oqVoFzRIGXrHIuydBU
 DWLg==
X-Gm-Message-State: AOJu0Yx3Kz7kKaYbBqtfCPWAFLgpLOHjGcmJR50aEHaKDQmuZQC52WUf
 xjnq9ToXg0ga0QH7Yv1gXTX9LNkD9LPR7B9nOB1djDZvZuLm5H5i/fgMnzY3TUEOUqM4Bd4OaRI
 KWWdW
X-Gm-Gg: ASbGncsLQhXFsmMjim/XFeMPVKjR46pAJvoAlFNcmk/a0HQPaFghvFfZgdJy1QB/kMt
 UcOCNFsY3Q1bGd/wCt1FTPmh1Vza6Vu2IH+mFRLvtQ5gi1WwGHQVdz3Ng1G03E682Lw8VRPlLQZ
 XtjC74Rb8X3Kp0kB9ONi5qtiVgI5GycY6lfkpR5WwbvTka84tr56ty3hpsR/dopUka0UeR6/luj
 HdMOWrGJa9F4hShgZw/u4WAZsKsT8grO5mmA7z2ROBwi3Z5USPQ2MjfhUQ6KU5FeMgNOX4AhNWa
 34trpA76hdS0WFDkfJHq9eG7kp4/i9oXX2jXrKxSolr742ZGb73gqp5lBZo+g8B8FQ/hIUt4pC5
 b+T8rQlZ+0lXyI3966z029qR3e/mO7D9iREv5Eg5EWmSzjh3XEq8NHxPbWAd8sW1vYMoZOSEDLQ
 MN/Ba+w04=
X-Google-Smtp-Source: AGHT+IEEgI43zGiWMGmhqJr2+eJ2vkv6qQaOnhPa1LlXmpGoVArx7R4XRCC31dOSwc58VDg9RJhRkA==
X-Received: by 2002:a05:6000:1448:b0:3b7:9d87:97ad with SMTP id
 ffacd0b85a97d-3b900b735d4mr8606844f8f.37.1754905423106; 
 Mon, 11 Aug 2025 02:43:43 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c3b95f4sm39879714f8f.23.2025.08.11.02.43.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 11 Aug 2025 02:43:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Alexandre Iooss <erdnaxe@crans.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] scripts/coverity-scan/COMPONENTS.md: Add a 'plugins' category
Date: Mon, 11 Aug 2025 11:43:41 +0200
Message-ID: <20250811094341.91597-1-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

Cover the TCG plugins files under their own Coverity category.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 scripts/coverity-scan/COMPONENTS.md | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/scripts/coverity-scan/COMPONENTS.md b/scripts/coverity-scan/COMPONENTS.md
index 72995903ff9..95805b536bc 100644
--- a/scripts/coverity-scan/COMPONENTS.md
+++ b/scripts/coverity-scan/COMPONENTS.md
@@ -147,6 +147,9 @@ tcg
 system
   ~ .*/qemu(/system/.*|/accel/.*)
 
+plugins
+  ~ .*/qemu(/contrib|/tests/tcg)?/plugins/.*
+
 (headers)
   ~ .*/qemu(/include/.*)
 
-- 
2.49.0


