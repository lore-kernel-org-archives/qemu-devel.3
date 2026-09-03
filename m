Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF137C61DD3
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 10:05:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x24JO-0001hu-Oj; Thu, 03 Sep 2026 06:04:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x24JM-0001hA-0d
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 06:04:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x24JK-0007sR-JJ
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 06:04:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788429885;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=auifhsw7/4Upua3iqRUfViD8a1QoFiI8TQChUs2imEA=;
 b=QDlr9KEwRpjPXhOM7Gp68SyY5KqffJXwqiKvj6fR7lbitOHU6Bvb0xowVYfQ2M2E0U7cwH
 qFvxBr5L9w/JERE6mizZ5SWvoMK1No6gDRTZpsFNnoiS2rqOqB39bG1eYq5hegzJKXrNap
 gcRx+LXweD2FT0aIiY0Id3HYS0inqQc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-54-5PLG8wvhOdOgM0fRJi9PTA-1; Thu, 03 Sep 2026 06:04:44 -0400
X-MC-Unique: 5PLG8wvhOdOgM0fRJi9PTA-1
X-Mimecast-MFC-AGG-ID: 5PLG8wvhOdOgM0fRJi9PTA_1788429883
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-47f2de3ba47so1412359f8f.1
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 03:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788429883; x=1789034683; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=auifhsw7/4Upua3iqRUfViD8a1QoFiI8TQChUs2imEA=;
 b=lniaZIKZQE4NxHUwCfkAXepfgZaABzaZSKT2b9rc1iRPBkWr7mcBQN4CPy9Vct1oBN
 5g0gpsAEoGqIEZ7HHCNPxb1SCVNp+a/qGZFksBLGEcjzbu6TWbynGK462Yg2NvH8cS/R
 UzmPGHUHnp8be1XKMDLrra6MO/fE0FeIDGpzjsjxAWpPzf5Wf5QWllB/gro5hQwlGE49
 UimTL91lgt5zY0s2JK8u3IP7yTh4g2SMtbwIro3sbLxjk8s7CI/1oLAENL8F0gR3gYqb
 a7YVEEKhZlzm9mHep7T4CBpbV6sM7O6pEUr12FyBxp+YWIdYwkvc9mXgrtQDnQZc9qjb
 dOnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788429883; x=1789034683;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=auifhsw7/4Upua3iqRUfViD8a1QoFiI8TQChUs2imEA=;
 b=DxvUQeSNf1fHUQKNLPDC2ctJgbNemnASXjFvpUXSMWdDwQN92J6qXpsc/NGzUjGdXl
 5zrATYXgbhRYl9JhaJa2xgjjgcOKnoBP3K/5infAe2+Dt5bNslJDRVMFCcRf1MRo3yHZ
 5EYBY+BMkGHhl8p6YIikwA4mHO9GxmVH7NxBw5P4gFaOFne+wozJ9vY01MTDCQwrmioe
 e2aexAac9oJmxDTO2KpLIx6rnlhkbHrPUFogH+tRWcibV8TIFzfKw62z89WWgToVPfOo
 STUXdCPJm+3TF5Cl5nlK7Y8GUa4G1rXvwVZx0ylaIyf13EM1wg2J9qyeKZ6/1PBsXKhc
 AzLQ==
X-Gm-Message-State: AFuF++nkad3H97ee6IolCMHnjPaxPd8M4yDuLQIePMNW9ufWzXZYrOdy
 /rBEs27wTm0tZALsGwIkWgFqI0U3LEmX9l3Su0ROfvVOBFPccDeKx9tIzu4Xi1eVv212yF4eYRx
 l2YlqLe9uensGvbZiStSy/kg/537/Jb46imxhbdLeOzvo9iGy0xZbw4U1f1fgr42dzfJ5lyF37S
 ZL5jlom6YQVtHDfDKHSkPDnnk1lwqqDBEDD0/asxIW
X-Gm-Gg: AYBFou3k9T1Mj2yE7KbkPMJckqSYbwPwisizUeq3aVPYcSvpMrsJiFMr60GQvDB79Vj
 cggx/6D9+Df0F3hdvy6jwd4OVfHgdJCJls+b8slgUNSIHOmLrPXJingKfyd1IkQo3JKtTrKyJMf
 wR0iCNosX15eJ7pAg/aoU6s04PXlc6Y2a7rQQ1m+zMV0xfZMZijCaydSoSutL+oqz5UMK2nHi28
 8PJfe184HAyl+wT9PPIIVMvPMAh1d9fdqU6sP7J6eX4ADsbw7RbMqSSVYeOjOgcBdkOraiWzfjP
 qyLUjw08dqpAg6ojFhi2RYEatmQiKJEGUN4LSt9LiLjGwaxCZ1OsPehCc3xfIW9zl7PEfeDf6nd
 jWPYgMvjjy8EBAoR0gwuiDWfKJlHqgTX6d4SSZmPDzlJNhs7lMBjAUAtPHIrPHwuJDJkVybzmOr
 GUa/E=
X-Received: by 2002:a05:6000:420b:b0:484:3313:fd86 with SMTP id
 ffacd0b85a97d-484914d9f92mr16306468f8f.27.1788429883358; 
 Thu, 03 Sep 2026 03:04:43 -0700 (PDT)
X-Received: by 2002:a05:6000:420b:b0:484:3313:fd86 with SMTP id
 ffacd0b85a97d-484914d9f92mr16306355f8f.27.1788429882736; 
 Thu, 03 Sep 2026 03:04:42 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.151.49])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48448e72d2asm11994056f8f.8.2026.09.03.03.04.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 03:04:42 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH] checkpatch: reject trailers that credit an AI agent
Date: Thu,  3 Sep 2026 12:04:40 +0200
Message-ID: <20260903100441.781277-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

The QEMU community has broad consent to not accept assisted-by and similar
trailers, and much less fake co-authored-bys, independent of any AI policy.
Implement this in checkpatch.pl already, so that there is another way for
contributors to discover the AI policy.

Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/checkpatch.pl | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 03f35e75012..90cb40dfe1f 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1811,6 +1811,18 @@ sub process {
 			}
 		}
 
+# Reject trailers that credit an AI agent.
+		if ($realfile =~ /^$/ &&
+		    ($line =~ /🤖/ ||
+		     $line =~ /^\s*(?:Assisted|Generated)-by:/i ||
+		     ($line =~ /^\s*Co-authored-by:\s*(.*?)\s*$/i &&
+		      $1 =~ /\bcopilot\b | \bchatgpt\b | \bcodex\b | \bcursor\b | \[bot\] |
+			     \bllama\b | \bgemini\b.*(?:pro|flash|ultra|google\.com) |
+			     \bclaude\b.*(?:opus|sonnet|fable|haiku|anthropic\.com)/xi))) {
+			ERROR("QEMU does not allow using AI for contributions, " .
+				"see docs/devel/code-provenance.rst\n" . $herecurr);
+		}
+
 # Check SPDX-License-Identifier references a permitted license
 		if (($rawline =~ m,SPDX-License-Identifier: (.*?)(\*/)?\s*$,) &&
 			$rawline !~ /^-/) {
-- 
2.55.0


