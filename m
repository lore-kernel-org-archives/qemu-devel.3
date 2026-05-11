Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC0AFCD37BE
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 15:57:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMSzf-0002Rn-7P; Mon, 11 May 2026 11:56:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wMSzd-0002QJ-4g
 for qemu-devel@nongnu.org; Mon, 11 May 2026 11:56:29 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wMSzb-0004hc-Fn
 for qemu-devel@nongnu.org; Mon, 11 May 2026 11:56:28 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4890d945eb4so32174195e9.0
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 08:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778514985; x=1779119785; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=TSlN92p7Rzirpk7FHTtv89N3yiwoQYu+iTOhDNSW0Ec=;
 b=BO59SiWaPJKm1q9bHXbsBFNtFcSCcgE7G4zOL+qIyOmMHPI6BqWC+oETUYoA7C+5Cj
 BObiU5+z1Ybng+7mv+cQ65bFzl3KageTjclIw8R2c4uKwmIu5VrKcl0H/FF0YP+jOCey
 MrZXpFX6dorBM+r7ZRk6TCsay4BRAJsIi4y95nPhPguEnurKso/L0ICidWb5XxMVLBPN
 UTZ012zH0eML9q623gs5Wr6J76kKESINR150Lu+3edN6nMTzSdozhwI/O+BzpTgoq7Ol
 r+ejgsTCiJFN3okxxJJ1tGA2nBt88749OED56+K+6cWKJOUV8p/+BzpMlOA2AqYeIT/z
 ITEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778514985; x=1779119785;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TSlN92p7Rzirpk7FHTtv89N3yiwoQYu+iTOhDNSW0Ec=;
 b=DdezHoq7cjy2th0MomcaBfTwb5wo4IXYfcDuYTYhI3Qvp0HKugzuarLigKTwu69zJj
 0qOgCCEM8y4GXuL7Do3sc4++OK9xT5zXyhRcdS1fz7eIo+Tl8IDynofGwMJRe2D09o88
 DSEN+f+RdGPwdNubtkD87FlsFPR0ZaYN34mj5OBuWtJWRRYrvV78HOC2tN32kNWJM+LF
 polRYpfh6HdyjeyA+oFXjuma0c6T12DOjWllIDz0pL/0xm/SrDZNUABdnomP/xVaMUup
 OgBt5WaeHP90OaKG0B4lVUR5cdyNbPnMbHC6LaRx7ICVSQm0RjtE8SF6yItMRNZB2aiQ
 wz4Q==
X-Gm-Message-State: AOJu0Yw+pO3ei2yNJekIvRdBUjWibZ58q4EK6VQgkxyUEpru47TGNcUD
 dj3eRxj5x+h/bMRj4m8BEIgScoLziHD1NRqD4UOU2bKgA7yRWDVWNbtSAvhcJKWVHA8=
X-Gm-Gg: Acq92OGNam5aQvhEfdNkQitLdRMlw7je57qc9ZIEe3nkQXK5RkKj6OM3PDfsvuDo1ed
 BC+q0XT70fQplzkrGLbU3bz/gt9y+4wBCsGQtdb7Qnx4CCKyM5ekh+F3w51cELrZX7mBRvCQfya
 WLfka1yvFLcWP6ldtn3EUzCrqWp2mY6dEwi2sYTCwmxfyH0OSOj4jGiRbAAMuk9kk6ivXm+JcDh
 rwKEx/5HxyuEObVTr7hpDtyTqgjtI4hNkmN6Yi9XYTuEdlhSL9FppdRpYCifxV9L0n1PXW4PB2i
 XFnMOqJzAWf852MUwZ7Nc9s2xAGeiDcBvtQy+XIbvRuCH/0VpASOVUxLnNlOVYOCOiq5q86V/H3
 Rnu8gRgmyf9H+FOlfbTlgcWpNajslz6v6DjfjEUf6oro53t5rMjX57lqnPGOdHUK+KGF02ugIAn
 2FsIKID8VADzcBZYjGoNnxa8c=
X-Received: by 2002:a05:600c:c118:b0:489:1abb:5559 with SMTP id
 5b1f17b1804b1-48e8e1f906cmr1497295e9.5.1778514985435; 
 Mon, 11 May 2026 08:56:25 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e702e6d41sm249451145e9.7.2026.05.11.08.56.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 08:56:24 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id EDC6E5F7C1;
 Mon, 11 May 2026 16:56:23 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [RFC PATCH] gitlab: update issue template for binary test cases
Date: Mon, 11 May 2026 16:56:17 +0100
Message-ID: <20260511155617.99522-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32f.google.com
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

Binary test cases are sketchy because they can be vectors for phising
and other malware. Lets strongly hint that source bases tests are
preferred and binaries should have their provenance declared.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .gitlab/issue_templates/bug.md | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/.gitlab/issue_templates/bug.md b/.gitlab/issue_templates/bug.md
index 53a79f58284..cdb7ac1fe72 100644
--- a/.gitlab/issue_templates/bug.md
+++ b/.gitlab/issue_templates/bug.md
@@ -55,6 +55,10 @@ https://www.qemu.org/contribute/security-process/
 <!--
 Attach logs, stack traces, screenshots, etc. Compress the files if necessary.
 If using libvirt, libvirt logs and XML domain information may be relevant.
+
+If attaching binary test cases you should describe where they where obtained
+from preferably linking to the original source. We greatly prefer test cases in
+the form of source code that can be audited before compiling by the engineer.
 -->
 
 <!--
-- 
2.47.3


