Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8EAFCD98F2
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 15:43:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbgmk-0004k2-8T; Mon, 22 Jun 2026 11:42:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wbgmL-0004fu-W0
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 11:41:43 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wbgmJ-000687-BY
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 11:41:40 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-462342ac290so5067842f8f.2
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 08:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782142898; x=1782747698; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lm/EkmTZzZUIm1flwT8VMm5WScziV8Mn0QozyBxRF9o=;
 b=SrZVqMvt0Z91voIwjwjfh6kJTV5T2jNTFLQIcQLGXZT8238L+AwJ3TMA175eWHmyjk
 SRtZaUqbPnftGavRPLiBaTNN/Mcy5JL0xGXTa9YQ0f6JAFiu9Gq35Uie22Pw32z30Rrn
 sirYp/NXaT9bHP5Y17igWCyrzonFnoJOLiaM27lgtWE6wPUVlX4r9GXUk+CI4TOJS0FC
 mupIZlXofSKRUs+peNhfLIImd1Go9PLv4FhbVca6O3YNEqiTl5mFRzWNKqj65UyKZ1gw
 os40++isVOBun5OCsCLtvTB1vSUvaxguXXlENwarq5occ94K0WEmx7CyBZo7eRmrG5Pz
 9cXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782142898; x=1782747698;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lm/EkmTZzZUIm1flwT8VMm5WScziV8Mn0QozyBxRF9o=;
 b=YgFHMAIP6ju2fC7tPShe89ipSNEqzS71wt2tKlo10zgoDfRfDAHzRxgH23cu0iGLLJ
 USjF1iM2PT0aZDOZPe/komPACF2S6GYIdYMrp8BWpjlkHQRccomZH8g4PX4z5WncMjTh
 Df71/mjQvsuGaGXKC4JuC330K+3qqGIza1lAABj2Csbec0KC2C2Q44HP2Y+egQlqqmyJ
 0RAMCPlwDGImWO01B+IKtDXES1an4TQhGKJ2gxVi1e8xNWExRm2JqR0I15B3Sdwtc2TB
 zfmjQp3NaUWM2ZCyU/1JVAu+I1J4EREsrYGoc1GUBuc1xUznXmj9bBgzAdpwcVqHBL9I
 r/Lg==
X-Gm-Message-State: AOJu0YyHjX0lgK+7EKyPaXo0cTmgl6MMQF7ruVNk0wypWK9zaziryPod
 3s6khkWI5S+W0WcHIgUU3ajZJ88IAs6lKRoD/Qos8aMM27cTYi4XVHKyX6Is7pvJxi4=
X-Gm-Gg: AfdE7ckvWclIBvhdTDxbs/L49exbNyF9bKTWwsTszHkMQgsT2tM8BXRveCkCU9uD4+w
 528y25YxW2M0ZKRvYlJ33WQhMCCk6bV3TU/3y5Ey+zC6XsE92bO+yRV3QgepU3PHRN8woqyufnN
 lwOF3BX05b3bcVtt8XNBBR1eqOoebOQ11/ayKwiuPh5y9TUyAfsRdGbN2TXqrpIbasAn/w2crly
 wjW71ETfVpZz3wq3pi7kgpCw9+L1cskev71LBTil9120LCzU+EgV0ui9ycQfGnEbzidQU1D3UU1
 ZqRM7bLPCBz5/JmWvkipo7HL3NwfHrG6qSlI9Kcq/JagUS+noRP786W8IezQZmGE7tWvmbVTIp4
 wsVcq5AtkpCTZg9hKi9RK/np3q2SFdfOoSYATrY5VHjlGb+OYLXjPLx0JLJlahFY7UIs7rnLEYs
 km812bemUHZ96n
X-Received: by 2002:a05:6000:41c6:b0:45e:de0a:1773 with SMTP id
 ffacd0b85a97d-4656e9ae04fmr21601790f8f.33.1782142897932; 
 Mon, 22 Jun 2026 08:41:37 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46666c57a0esm25382427f8f.27.2026.06.22.08.41.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 08:41:35 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E04E75FAAE;
 Mon, 22 Jun 2026 16:41:32 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 7/7] gitlab: update bug template for sec issues & tool
 assistance
Date: Mon, 22 Jun 2026 16:41:31 +0100
Message-ID: <20260622154132.3166748-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260622154132.3166748-1-alex.bennee@linaro.org>
References: <20260622154132.3166748-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x432.google.com
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

From: Daniel P. Berrangé <berrange@redhat.com>

Warn that a security issue must have the "confidential" flag
set and that any findings from automated tools must be validated
before submission.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20260619123632.1276476-1-berrange@redhat.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20260619155657.944220-8-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/.gitlab/issue_templates/bug.md b/.gitlab/issue_templates/bug.md
index e20f586008d..faeeb002252 100644
--- a/.gitlab/issue_templates/bug.md
+++ b/.gitlab/issue_templates/bug.md
@@ -13,8 +13,9 @@ older than this should be reported to the distribution instead.
 See https://www.qemu.org/contribute/report-a-bug/ for additional
 guidance.
 
-If this is a security issue, please consult
-https://www.qemu.org/contribute/security-process/
+If this is a security issue, ensure this ticket is marked 'confidential'
+before submission. See https://www.qemu.org/contribute/security-process/
+for additional guidance
 -->
 
 ## Host environment
@@ -49,6 +50,12 @@ https://www.qemu.org/contribute/security-process/
 2.
 3.
 
+<!--
+Note: if this issue was discovered with the assistance of automated
+tooling LLM, static analysis, fuzzers), the reporter must disclose
+that in the description. The steps to reproduce, and any other findings,
+must be fully validated by the user of the tool prior to submission.
+-->
 
 ## Additional information
 
-- 
2.47.3


