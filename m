Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD15CC02185
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 13:44:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYmdq-0001lB-6R; Fri, 17 Jan 2025 08:44:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYmd0-00012G-8g
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 08:43:14 -0500
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYmcw-0002FN-31
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 08:43:14 -0500
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5d3e9a88793so3563345a12.1
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 05:43:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737121389; x=1737726189; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BweiGGrjQIGk1dVGD1ZKLAbH1Kswi6PYCPMuHmp0Q1k=;
 b=DDqAtGK7KP4hQCqPwlp85M/5Y+UYFxyz1aXhlkvYOks30v0xGzFOXt+4T9WxMltBAs
 OW0qNr9dsfwvl/mw2xfzW1M8QyJygLY1KFUaJ7aAWZtjTsa7JnsvxnL3ckM4VKN1Q1/J
 4hyDgfJx/ElkwuzVhIhhKGVpEsl1t0I7lzsDIYEnwQCLuxD1j0UOiTKZfIdI/+jMWo6G
 /Mk4CA2w8jqfTCdQFDBCB2tMS8TAWvrqoj04fd0ss/tpbwzrxZQ/vCSf78i81H83YB5c
 PIej6c23Di/I7HCScjm/8YNY4Fz0m80OYSmOzKn3/H9/R2g5Q9cFV6bextrmZxcnoyyP
 7dIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737121389; x=1737726189;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BweiGGrjQIGk1dVGD1ZKLAbH1Kswi6PYCPMuHmp0Q1k=;
 b=tV38+GA+XOWc3cu2fUJPX4a67VrAs/Gczed76jHhbUgHa5YZ0/hk/FJsOS8vHuqsAy
 DZMhsPTYehem5KBH4ulbaerrDZ5+fcRZUTwinobLlz0JPJ2n/vEPJKr0x++jVz6gaAEu
 1KvUHc+PXKOcTtz43KrsxkK/j4LyUY9KoX3+hW7+jiSWQWnwV1GsShlRz5LFUy7fcVNF
 ma0J/udXvuM54OT0AkpCepSa3P2NLmdVwKvXgyzIBvrObQipjEY3IPp/vRtXIp+NQlN8
 +e71MPFvKxsq+wJemgLcblMWy7D6A5rpGv4FACJuwepQaAmlWfcvM/m00Xb6xG73ZVoY
 dRoA==
X-Gm-Message-State: AOJu0YzmB+HxZQhdGKdNH8S1LtBMpV8APhN6nt+mHamiaO3RY+QwQheH
 8Q6nS7H/SK7op1x6UC5pwdXoucL0lF5M5na/NUyw6Kw5ibzrg4TWxmNtc00YVU8=
X-Gm-Gg: ASbGncvADERGFklDzaPQv/dzyYCv9vTrwTVTl/8WXvzJWMB9QNgcNMiJBWD6ry5TUgh
 sjHD2uC7Vz6fNsnX598QaCwnSTYD86twJD8sBFsWSxcfg/MfBAROHPe0/dZDCSv8hkb0QPvNlt2
 iAhQhDSh21+vA4H6I4uBOficVnalZYrqNFNo+Ftdi2OV8rqZg0r3pPVmBs7pMo7e1Fuv1yQsoQ4
 eKe5MLEa5nRvdTYqsLWwd5IM1RANc7bhI2o+UyeSs4oCu3npwzus3A=
X-Google-Smtp-Source: AGHT+IFk1+Oy1TOXGZ8g4I9xM1xsQPsj89hmeV58GbW3/ataKNaxDE91kPt5XlcrcA/iTVSlcKfpNQ==
X-Received: by 2002:a17:907:9450:b0:aa6:9198:75a2 with SMTP id
 a640c23a62f3a-ab38b3787ecmr244697766b.44.1737121388587; 
 Fri, 17 Jan 2025 05:43:08 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab384fcc926sm170193766b.164.2025.01.17.05.43.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 05:43:07 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 982D5608DF;
 Fri, 17 Jan 2025 13:42:59 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 28/37] tests/qtest: fix some copy and paste errors in kdoc
Date: Fri, 17 Jan 2025 13:42:47 +0000
Message-Id: <20250117134256.2079356-29-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250117134256.2079356-1-alex.bennee@linaro.org>
References: <20250117134256.2079356-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52b.google.com
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

A number of copy and paste kdoc comments are referring to the wrong
definition. Fix those cases.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20250116160306.1709518-29-alex.bennee@linaro.org>

diff --git a/tests/qtest/libqos/qgraph.h b/tests/qtest/libqos/qgraph.h
index 1b5de02e7b..81fbfdd0e2 100644
--- a/tests/qtest/libqos/qgraph.h
+++ b/tests/qtest/libqos/qgraph.h
@@ -355,7 +355,7 @@ void qos_object_start_hw(QOSGraphObject *obj);
 QOSGraphObject *qos_machine_new(QOSGraphNode *node, QTestState *qts);
 
 /**
- * qos_machine_new(): instantiate a new driver node
+ * qos_driver_new(): instantiate a new driver node
  * @node: A driver node to be instantiated
  * @parent: A #QOSGraphObject to be consumed by the new driver node
  * @alloc: An allocator to be used by the new driver node.
diff --git a/tests/qtest/libqtest.h b/tests/qtest/libqtest.h
index f23d80e9e5..fa08c7eca5 100644
--- a/tests/qtest/libqtest.h
+++ b/tests/qtest/libqtest.h
@@ -365,7 +365,7 @@ QDict *qtest_qmp_event_ref(QTestState *s, const char *event);
 char *qtest_hmp(QTestState *s, const char *fmt, ...) G_GNUC_PRINTF(2, 3);
 
 /**
- * qtest_hmpv:
+ * qtest_vhmp:
  * @s: #QTestState instance to operate on.
  * @fmt: HMP command to send to QEMU, formats arguments like vsprintf().
  * @ap: HMP command arguments
@@ -904,7 +904,7 @@ void qtest_qmp_assert_success(QTestState *qts, const char *fmt, ...)
 
 #ifndef _WIN32
 /**
- * qtest_qmp_fd_assert_success_ref:
+ * qtest_qmp_fds_assert_success_ref:
  * @qts: QTestState instance to operate on
  * @fds: the file descriptors to send
  * @nfds: number of @fds to send
@@ -921,7 +921,7 @@ QDict *qtest_qmp_fds_assert_success_ref(QTestState *qts, int *fds, size_t nfds,
     G_GNUC_PRINTF(4, 5);
 
 /**
- * qtest_qmp_fd_assert_success:
+ * qtest_qmp_fds_assert_success:
  * @qts: QTestState instance to operate on
  * @fds: the file descriptors to send
  * @nfds: number of @fds to send
-- 
2.39.5


