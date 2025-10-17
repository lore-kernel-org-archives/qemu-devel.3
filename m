Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18D55CCD199
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 13:34:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9kZN-0000n7-F8; Fri, 17 Oct 2025 09:32:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v9kZ8-0000ji-IQ
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 09:32:20 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v9kYz-00089p-N3
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 09:32:16 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-471131d6121so15235365e9.1
 for <qemu-devel@nongnu.org>; Fri, 17 Oct 2025 06:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760707918; x=1761312718; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=uO7mYKt8IHdYhHEVKQzf4sCsKSeLXK5fOVq74VVC9b4=;
 b=Po/FQ5xg2yocLj/8fMyF3f/knhrpUSCJzDnRXOh3V0M1vKi/BrM4HOMTiAOgZ0dEgQ
 rWKT/JHcf/URMu3jm2PNthXp0OvNDwsKYl5w8V2GCBMxuGwqtnneqGPMKtqSWp87dxpc
 lmKZaPRrtG0CI1dCe0k8OAV7yGHEYCP0sEMY0JA9eH9OnZPhFJJQBSqg6MHaJMtVFMFY
 9UYsHikj/lxh0Vi8sY8sksS1zUVx2XNWChflC+QIG2/eVCH4bda0txrNgsiVM3AWENMp
 4HVxPO9JJ2uiWngk8JGqHJaF0qpRDOu0GwoqMzzFbhxauAGtmYHuBZKUa+Q1Zs7QXZNn
 xe/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760707918; x=1761312718;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uO7mYKt8IHdYhHEVKQzf4sCsKSeLXK5fOVq74VVC9b4=;
 b=I5asG89fPJbRvwHXuQcuLlgJDIx1kTHBP2G/MsK887YLkGnym+qPuWfA+FSkF3cjNS
 YZmEr2pt19omIj/8sk33BaqEZHSI+BcFyk7PprqTaZmsaR9SuXxIGCpK/OQGql/hLqRc
 wiwcaKPC11HywKX/0zidh7LfTx2GTTOtXH/I+XQZw6PN505Vd1ZcYrcCvmbiC4JkuNjP
 c4QMQdQIghpMQDWfAk7v4QQxtaiQBHCEO0809/ZSTKEaLMnrJKI1oko07UG4cUb/ruHC
 fLSXjycuuO98DN/KLcob7D0XouK5Kl4SJq5nyjBu4EbXKzooIQUYPVztmYt6B7qU+UrV
 fY1A==
X-Gm-Message-State: AOJu0YyEp58XDztCevjeIC7pNa/0WFUKm/rq4MlMgkUuQ+0qajqsifm/
 4K6TDoC7w3Z93FlwgStSE37CV3tXwpHQgy7hazo698z1M0cLvu24B9GavNw05vWBtCrZAb2wG3V
 HSr0X
X-Gm-Gg: ASbGncvEvd+8p2cPjeYTmQ4OVzpic8bsY7NGWS0AGDjo/hl3v9qPJAFI4/Z09RQa04z
 F4g6BCiT5vaB9I1ziQBlNnntwh1x5wPtFImAGQB37MVOcQJ3HRPKVZp8QqB79Z65ETw6dcRudw7
 yReDReCSFjlGuwJgqcsGnHwAFWdCu/jxl+OOLddipsgBVVsNIyBn/VHd5eISlr7NOqyyJ0gBo0g
 23vNy4YUYjpiwELw16Jd+abQ3LUhOlH9mzFwHPKmTbbA+U3xrDL0tjNE7+kW2hgCokCxgcZQnfb
 4Z/7Vgc3tdxjFjud9dBQwGIA+OaD39zHn7ycPnGfazEJLgYpOK0jXMO6/Zl7x66NiSTwYJOnPhL
 FvD+AUmDcPSyevKWEtliV5DWoR8ICXHbGODKadd+/BlIIN0eXFXSkBnlQTI7S4QyRVqoCpQKSqu
 +ycJRMiA==
X-Google-Smtp-Source: AGHT+IG52+HKn+pYvcR9v8R5/YTm5EDqrIPqT0HpcnaUKkazvjFKqkSflypy16LsART68HpbQo+vAg==
X-Received: by 2002:a05:600c:8b78:b0:471:d2f:7987 with SMTP id
 5b1f17b1804b1-47117902dbcmr24578985e9.26.1760707918243; 
 Fri, 17 Oct 2025 06:31:58 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4710e7050c6sm51535775e9.1.2025.10.17.06.31.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Oct 2025 06:31:57 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH] .gitlab-ci.d/buildtest.yml: Install 'file' for the Coverity
 job
Date: Fri, 17 Oct 2025 14:31:56 +0100
Message-ID: <20251017133156.926094-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

The coverity-scan upload job has started failing as of 30th
September:

[ERROR] Cannot find '/usr/bin/file' command, and no 'file' command is found in the PATH
        Coverity Capture uses this tool to identify the file type of executables.
        Please ensure '/usr/bin/file' is available, or add the 'file' utility to your PATH.

This seems to have broken when we moved our containers from Fedora 40
to 41 -- probably F40 indirectly pulled in 'file' via some other
dependency, but in F41 it does not.

Explicitly install 'file' for the coverity job, in the same way we
already do for curl and wget.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
I don't know any way to test this except by applying it and letting the
coverity job run when it hits upstream git... Possibly we might find that
it complains about some other missing dependency and we need to iterate
on this.
---
 .gitlab-ci.d/buildtest.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index 0502094b9aa..21f6d7e96fe 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -759,7 +759,7 @@ coverity:
     - job: amd64-fedora-container
       optional: true
   before_script:
-    - dnf install -y curl wget
+    - dnf install -y curl wget file
   script:
     # would be nice to cancel the job if over quota (https://gitlab.com/gitlab-org/gitlab/-/issues/256089)
     # for example:
-- 
2.43.0


