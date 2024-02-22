Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D95DDC5479F
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 15:29:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdB0H-0005Ao-Lj; Thu, 22 Feb 2024 10:28:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rdB0G-0005Ac-GF
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 10:28:52 -0500
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rdB0E-0000OC-Qj
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 10:28:52 -0500
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-512b13bf764so5919396e87.0
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 07:28:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708615729; x=1709220529; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FzD+99cgpDSrEBdy2lAUngKRLMF2vDH+vLkmhVJWYwA=;
 b=vCeWUuOaob3FHfRjZixcQjE+5hh6MknvbKoQQKNN3G3VZBwgpsPwC/IBtoaH7JLKce
 QKQHshrYvYP26OYrCKIz6hwACWMQEc5ehmzOeTDZzeLjzYuP1rAuP4fTowXDqRzp8qWQ
 PBSqTxNPht6PBPSwnppuRIGfrxO7MPJMcNNW7UJmSGB/ZxpR3/wtO7B2NshByLSJojxc
 37rSXRsfB4mMSo4kpKuESsHj0QNUvsq+rzYldA5i2TIy4Ifr9C76Qz0KhfilqReM5v+v
 vWD08RckmJzUta6oIWzTJEY/O5asQ1OlXR42sncOZL1lAHljgE3+D1+wVrGboOm2v4r7
 ULcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708615729; x=1709220529;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FzD+99cgpDSrEBdy2lAUngKRLMF2vDH+vLkmhVJWYwA=;
 b=lxC5tGLZS04hOBo99lK9fzvcPbcvGnsWhJ+muNp1pk6F1amd6CWoXeob/xKRwXUicS
 1H3DWIOk9A3KXinFZ+ZcgDiBFHTogxeyt7wjzbGMfEsnrDs0cvBXTYPRm8Cf1/vGVtxf
 VJAYaNZkNP3nBaC+81uhmC0guWq/0KR2Vegcht/2t7SlzQD8p5rcPmAAkzQ89XL0IDdh
 MQdgDgdo1Dr3ylVhKFdDz3Dxy0dsL1UJ2oZP+pQJ9JcEIzWVwBsnsEvWC/vY49b4rfgB
 Z69w3juKQFW++NNbFuRnpY6F4dVtBqKaHErwa45QwEaADWD8/U/tN17CEZzWQTU+dtbA
 Wzhg==
X-Gm-Message-State: AOJu0YyP6vieAy4roWHw0yAw5RveTIqPjzZ3RspLGdzXZiB5/+2G3g4h
 KlVfgXREMCMaSn8XHZzgEWATnfjC2y9IsYX9HAxDyyw+5rnZpwVahpOYqb7l3w90emwUZLL2fg8
 WTW8=
X-Google-Smtp-Source: AGHT+IGN64cIv1ZdEcZvkihXeOYxyeeeEj0D7zAhal2si+AVCfgcKSePB/G90qQrmymK1Uy0DuomtQ==
X-Received: by 2002:a05:651c:2125:b0:2d2:5cca:cf6f with SMTP id
 a37-20020a05651c212500b002d25ccacf6fmr3198721ljq.18.1708615728774; 
 Thu, 22 Feb 2024 07:28:48 -0800 (PST)
Received: from m1x-phil.lan (sto95-h01-176-184-18-96.dsl.sta.abo.bbox.fr.
 [176.184.18.96]) by smtp.gmail.com with ESMTPSA id
 u6-20020a05600c19c600b004128e757706sm765542wmq.36.2024.02.22.07.28.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 22 Feb 2024 07:28:48 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Dehan Meng <demeng@redhat.com>
Cc: Konstantin Kostiuk <kkostiuk@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 2/3] qga/commands-win32: Do not set
 matrix_lookup_t/win_10_0_t arrays size
Date: Thu, 22 Feb 2024 16:28:34 +0100
Message-ID: <20240222152835.72095-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240222152835.72095-1-philmd@linaro.org>
References: <20240222152835.72095-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x135.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

ga_get_win_name() iterates over all elements in the arrays by
checking the 'version' field is non-NULL. Since the arrays are
guarded by a NULL terminating element, we don't need to specify
their size:

  static char *ga_get_win_name(...)
  {
      ...
      const ga_matrix_lookup_t *table = WIN_VERSION_MATRIX[tbl_idx];
      const ga_win_10_0_t *win_10_0_table = ...
      ...
      while (table->version != NULL) {
                    ^^^^^^^^^^^^^^^
              while (win_10_0_table->version != NULL) {
                                     ^^^^^^^^^^^^^^^

This will simplify maintenance when adding new entries to these
arrays.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 qga/commands-win32.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index 79b5a580c9..87ce6e2870 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -2124,7 +2124,7 @@ typedef struct _ga_matrix_lookup_t {
     const char *version_id;
 } ga_matrix_lookup_t;
 
-static const ga_matrix_lookup_t WIN_VERSION_MATRIX[2][7] = {
+static const ga_matrix_lookup_t WIN_VERSION_MATRIX[2][] = {
     {
         /* Desktop editions */
         { 5, 0, "Microsoft Windows 2000",   "2000"},
@@ -2133,7 +2133,7 @@ static const ga_matrix_lookup_t WIN_VERSION_MATRIX[2][7] = {
         { 6, 1, "Microsoft Windows 7"       "7"},
         { 6, 2, "Microsoft Windows 8",      "8"},
         { 6, 3, "Microsoft Windows 8.1",    "8.1"},
-        { 0, 0, 0}
+        { }
     },{
         /* Server editions */
         { 5, 2, "Microsoft Windows Server 2003",        "2003"},
@@ -2141,28 +2141,27 @@ static const ga_matrix_lookup_t WIN_VERSION_MATRIX[2][7] = {
         { 6, 1, "Microsoft Windows Server 2008 R2",     "2008r2"},
         { 6, 2, "Microsoft Windows Server 2012",        "2012"},
         { 6, 3, "Microsoft Windows Server 2012 R2",     "2012r2"},
-        { 0, 0, 0},
-        { 0, 0, 0}
+        { },
     }
 };
 
 typedef struct _ga_win_10_0_t {
     int first_build;
-    const char *version;
-    const char *version_id;
+    char const *version;
+    char const *version_id;
 } ga_win_10_0_t;
 
-static const ga_win_10_0_t WIN_10_0_SERVER_VERSION_MATRIX[4] = {
+static const ga_win_10_0_t WIN_10_0_SERVER_VERSION_MATRIX[] = {
     {14393, "Microsoft Windows Server 2016",    "2016"},
     {17763, "Microsoft Windows Server 2019",    "2019"},
     {20344, "Microsoft Windows Server 2022",    "2022"},
-    {0, 0}
+    { }
 };
 
-static const ga_win_10_0_t WIN_10_0_CLIENT_VERSION_MATRIX[3] = {
+static const ga_win_10_0_t WIN_10_0_CLIENT_VERSION_MATRIX[] = {
     {10240, "Microsoft Windows 10",    "10"},
     {22000, "Microsoft Windows 11",    "11"},
-    {0, 0}
+    { }
 };
 
 static void ga_get_win_version(RTL_OSVERSIONINFOEXW *info, Error **errp)
-- 
2.41.0


