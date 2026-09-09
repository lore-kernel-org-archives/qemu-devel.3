Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89BDAC79FB6
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 15:58:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4KfP-0001hS-6S; Wed, 09 Sep 2026 11:56:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x4KfN-0001gq-OB
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 11:56:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x4KfM-0002rl-4i
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 11:56:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788969411;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3jG6dFno1yrYumOJTYmmgdFZqubuGsWYOjTX5yYtCFs=;
 b=WBiByz88YZ6mc0vqrJMMvDP/R88ask61wd78iNvYCSusTPDDJuZOSIUOnt/r2+XOespmyO
 mGaHt2Z2HfmB5as31WpVhUF8vqaimSPAzOSLJpeBGAPf/2KRaEGsNWr6bND9ELXc8Qi84R
 6jwjiSz4kSwmPW/2WYNTfAVGvaLqMxc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-446-U2aJy3OsOSOwONwiA9FSIg-1; Wed, 09 Sep 2026 11:56:49 -0400
X-MC-Unique: U2aJy3OsOSOwONwiA9FSIg-1
X-Mimecast-MFC-AGG-ID: U2aJy3OsOSOwONwiA9FSIg_1788969409
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-499b99a8a10so22815e9.0
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2026 08:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788969409; x=1789574209; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3jG6dFno1yrYumOJTYmmgdFZqubuGsWYOjTX5yYtCFs=;
 b=ocehkvHvjO2mt4sC/jf2UcXd5q8BMkuPOnK8qlkK53moFOZ/sYERx49oiifbMfK5Nx
 nQfKHquo1RCGROLRIj23x4WpaTEZ9b0CiyA4T1ko30xKk38ST3zWfLCRs41NWGBV5JAn
 US0OHJEWJt97oAqqRgWjCfdshkj1hZ3A8M3ntTb044El8XjeU87gHP3H4TdH6j3AvSrV
 4EtNWiLy2xZekFUx7TWZQXccoy9w1dD/XaqcJwhpYiPiQu4D05B+ifHTr3oJuVA3AqeN
 SqK85LE6w6B+N6gv5lrXu9kMY3mx69xj8HaQmGNzpR9r52QeSKQYYfIKbPh7+zxH8S5b
 0U9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788969409; x=1789574209;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3jG6dFno1yrYumOJTYmmgdFZqubuGsWYOjTX5yYtCFs=;
 b=e3aUM3u9XaA3+erjxsQwjKLjQuORlEIqWIfUZtDpju4J8N5CiE9j38SunLJKKDXx+N
 2xm7RJ8gJ7RgQ90Ah9j+huki7Lbr7nnHb8bTxuktkNebN7+/ev7CpS5vE2us6iGtlJ8B
 VG+jMgFpT3SouM75a836WXdHoGONNqWgMiVlS8Gu7eFrD4HcPQNah/VaioPRw/8S5jDa
 FJVTSbOh7JsWvDCkkMF0oMFuzSsImQhaYDXk1mnF3xyT9a2Al5/bCVTQ6+klzqOSNj1/
 b9dC+R2t7wN5Wxo1YWhW/2fxojb11BDN5dIQh25S3KnzDR7ehf2/I4QyNuKGh9QYn2W0
 h80w==
X-Gm-Message-State: AFuF++nA6wBnXOzLvq7ViCuimlJFPe5eubFT8pzq1VamgBHAef2fZ2nu
 +sGjRA9d9pmrew/a5gIMTdI9zT+fbJQKYY1cXqZ0OwAl5jZfLYy6a8gKJXhrmQx+TZTfGAbri5i
 R38quyHyJBOd6zrDJLGAMpuO/1LYkVMMM2aWlrhTFje5UKgPBXUtiRgJ2Fx6Lid9O2citKrnJc1
 eX5DauzltxBuKnRXvJL1C0sTR8i0zET2zWpJMNEbZE
X-Gm-Gg: AYBFou1zaeUDzieTeZhLwr2KlMK2CQaGgcbyIB0rU0r7pfr1uXX556Y5eruyEELPgOT
 dOtxqekXx92JfoF4p+dwmgGP+3WPc+AznG9DAakLFaQ4eo6qBvGWS1GfbR5dkf/lQBnhJ81J2S1
 r7nM+8bC2rVJGk9JFvKjLlXeq811uJR0MDZpoyOPH5PrMwjLlzB38O6OxYU8IGq5TVygtpnfwhZ
 dm1YPX8DP2MjP1MekAbe4ijLZ6gKyjETXtdD6Oxao2FnvODOEdXbJpWRFuQJm5vFx40uBidTiTM
 qXRbQGsBILTnJWvao/4s56+yW9SA7yENstIgcOxdDz0+EFlnI3+UANVrA4pW+MYyVNzY/ZoBzxp
 QJCaYeBjjHxYEWSTiPWYZOeibWq19t7iHOpYZ6M76hsApQ7mIG0HRM335sEjn20LzPb9jE2QEnR
 ZanTTq
X-Received: by 2002:a05:600c:c4b8:b0:49b:8f5e:51fb with SMTP id
 5b1f17b1804b1-49d17543be5mr154983145e9.3.1788969408676; 
 Wed, 09 Sep 2026 08:56:48 -0700 (PDT)
X-Received: by 2002:a05:600c:c4b8:b0:49b:8f5e:51fb with SMTP id
 5b1f17b1804b1-49d17543be5mr154982705e9.3.1788969408208; 
 Wed, 09 Sep 2026 08:56:48 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.232.249])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d26bfd04fsm499605e9.10.2026.09.09.08.56.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 08:56:47 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 08/12] checkpatch: reject trailers that credit an AI agent
Date: Wed,  9 Sep 2026 17:56:20 +0200
Message-ID: <20260909155624.1082893-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260909155624.1082893-1-pbonzini@redhat.com>
References: <20260909155624.1082893-1-pbonzini@redhat.com>
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

The QEMU community has broad consensus to not accept assisted-by and similar
trailers, and much less fake co-authored-bys, independent of any AI policy.
Implement this in checkpatch.pl already, so that there is another way for
contributors to discover the AI policy.

Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/checkpatch.pl | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 03f35e75012..547a59dcac5 100755
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
+		      $1 =~ /\bcopilot\b | \bchatgpt\b | \bcodex\b | \bcursor\b |
+			     \bgemini\b | \bllama\b | \bnoreply\b | \[bot\] |
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


