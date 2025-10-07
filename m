Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCC52CCA472
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 11:58:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v66IR-0002XJ-MD; Tue, 07 Oct 2025 07:56:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v66IH-0002We-GC
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 07:55:49 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v66I3-0001Iu-M5
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 07:55:49 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-46e6c8bc46eso40256175e9.3
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 04:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759838128; x=1760442928; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LC8sseS4YRt7zbmXv0lrK/8l6VQS3lJqjjF1eJnDljk=;
 b=hXbPS2U3hL83szqKlsD3YdMysyDpNhijZp7CcNOfzyBh91x4wfafnC8qc0WLppzSSU
 H7TyOiXm1j3BPagvM43vnxmib69bDQv3fhIlILtcht0dBvlYTP/XBuiqAVkLH/7V8kr4
 3l/VOlrc5gRtEBJE8oyvtnYXQYtblCQ14lydvy9ewadPwYnNJ8VrtBFlxOMzncPfp0K/
 vyBRXFBoDOy++FGbgKdhknXIdvZ+lI/dmK9RC+uCarpt6hAeCoG+sA2/RAbeGD4/gexV
 VijQXEU9siBn5n65+/9gKdy8JBaTrNMhwiY09wQJyiqF+JiCNpFAKdMwXClR44wRQ4Ms
 B+6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759838128; x=1760442928;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LC8sseS4YRt7zbmXv0lrK/8l6VQS3lJqjjF1eJnDljk=;
 b=cHawKLMTFnzkD3uX4GlqUSesS6Qbshr8hnpjzXCcSE0HyMd7xHken6HgZ0FK2+1lGN
 y1Koyma32TtFf3czb/ARYWQRFzmmMTs9GrPcBJ663wanYqZSIbY1Gv5Up5s4wusY8NwD
 VO4pr8p9faAFbKyCcOALGzIfqIGj/+LTzAp1lCuobfNN/Wv8RNxhdo2S0O99JUksTE+s
 oJjNbcPKnhvWdO1/3CUru1WufbOOwTaTpdR67IwgklhHcTQW2ZTsuCFyCAhujaTGUjOX
 LckyObe3LmYsGkVmFvy3icfoDS/tX2jhwdvPzepzDTeseBAgM2FcvgrLPYXDPmSJy0Ah
 RpiA==
X-Gm-Message-State: AOJu0YwKSt/3I8s6dmTwjh0QmGLlDrj2VSw/RjG912/5ugIcyHmylaTz
 L9CuXVj2tryYHFl7K36e90WbTxk06oVKbNul7nmL2uZlDPvxyW0bN8fuTGqJ7uXgrDU=
X-Gm-Gg: ASbGnct+oKUiSBmyH0elzOo+4JcHCgwWYlYNDKVRXfVef0Z4vrB1PfBgn+9wjebgi+9
 QksD0NmMbUkyDm8zR3ZtWVntTh9PDH3zBpz8/UU9GVJSBIR5fp31pV1NIB0JobU8eTu/ORzvQLD
 CIEESOaPmDP5KMnIDk/PDBES1ZemjNmR4nLjG6oUuee+3YTxjhoMQXkA+k480HMXhaGMe15D0PH
 wmWKWQocJeJ+SWim8vVFVQt6q9tS9Gq+RHkC6mD4hhC70awGjdHZCFHqucrzJDgOD1XTTDRmWO1
 9SvVEsHeQJWrk2UdBfvFlkl8s0H/KpvEH2GmG3KZZ4eyDOcrRK8lQbHOoZYXdsEyQcJ5lDoUPuD
 0mS+6FkxryVNpERTvPARB2rtUlqm5dAYWoJocAt5x6DYjbZnxaXM=
X-Google-Smtp-Source: AGHT+IGGc4qPojs97/k7gopcaMYZt2y2UMdc+GcXLh8NWVKD4A1mFELLoCN1G3jjZM3tSBAnlods6A==
X-Received: by 2002:a05:600c:3b27:b0:46e:3edc:2811 with SMTP id
 5b1f17b1804b1-46e7110f0efmr96481115e9.14.1759838128304; 
 Tue, 07 Oct 2025 04:55:28 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8ab909sm24662275f8f.19.2025.10.07.04.55.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Oct 2025 04:55:26 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 1A4B95F87E;
 Tue, 07 Oct 2025 12:55:26 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 01/17] .gitpublish: use origin/master as default base
Date: Tue,  7 Oct 2025 12:55:09 +0100
Message-ID: <20251007115525.1998643-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251007115525.1998643-1-alex.bennee@linaro.org>
References: <20251007115525.1998643-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x332.google.com
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

This is very much the result of my recent fat finger but I think it's
safer to assume that origin/master points to a recent commit (or at
least a commit a given branch is based on) than master.

Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-ID: <20251001170947.2769296-2-alex.bennee@linaro.org>

diff --git a/.gitpublish b/.gitpublish
index a13f8c7c0ec..a3adb21ffa1 100644
--- a/.gitpublish
+++ b/.gitpublish
@@ -4,48 +4,48 @@
 # See https://github.com/stefanha/git-publish for more information
 #
 [gitpublishprofile "default"]
-base = master
+base = origin/master
 to = qemu-devel@nongnu.org
 cccmd = scripts/get_maintainer.pl --noroles --norolestats --nogit --nogit-fallback 2>/dev/null
 
 [gitpublishprofile "rfc"]
-base = master
+base = origin/master
 prefix = RFC PATCH
 to = qemu-devel@nongnu.org
 cccmd = scripts/get_maintainer.pl --noroles --norolestats --nogit --nogit-fallback 2>/dev/null
 
 [gitpublishprofile "stable"]
-base = master
+base = origin/master
 to = qemu-devel@nongnu.org
 cc = qemu-stable@nongnu.org
 cccmd = scripts/get_maintainer.pl --noroles --norolestats --nogit --nogit-fallback 2>/dev/null
 
 [gitpublishprofile "trivial"]
-base = master
+base = origin/master
 to = qemu-devel@nongnu.org
 cc = qemu-trivial@nongnu.org
 cccmd = scripts/get_maintainer.pl --noroles --norolestats --nogit --nogit-fallback 2>/dev/null
 
 [gitpublishprofile "block"]
-base = master
+base = origin/master
 to = qemu-devel@nongnu.org
 cc = qemu-block@nongnu.org
 cccmd = scripts/get_maintainer.pl --noroles --norolestats --nogit --nogit-fallback 2>/dev/null
 
 [gitpublishprofile "arm"]
-base = master
+base = origin/master
 to = qemu-devel@nongnu.org
 cc = qemu-arm@nongnu.org
 cccmd = scripts/get_maintainer.pl --noroles --norolestats --nogit --nogit-fallback 2>/dev/null
 
 [gitpublishprofile "s390"]
-base = master
+base = origin/master
 to = qemu-devel@nongnu.org
 cc = qemu-s390@nongnu.org
 cccmd = scripts/get_maintainer.pl --noroles --norolestats --nogit --nogit-fallback 2>/dev/null
 
 [gitpublishprofile "ppc"]
-base = master
+base = origin/master
 to = qemu-devel@nongnu.org
 cc = qemu-ppc@nongnu.org
 cccmd = scripts/get_maintainer.pl --noroles --norolestats --nogit --nogit-fallback 2>/dev/null
-- 
2.47.3


