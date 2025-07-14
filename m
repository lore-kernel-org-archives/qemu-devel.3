Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 981A1C83F22
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 13:04:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubIqN-0008HG-IJ; Mon, 14 Jul 2025 09:03:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ubHtN-00073X-P9
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 08:02:46 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ubHtH-0003rU-Sq
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 08:02:45 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-60c9d8a169bso7463098a12.1
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 05:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752494557; x=1753099357; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QiZnRDIM6/kZEbxqRnf//fPQu15IWBfB/VoqA6cAXpE=;
 b=viZ8meUO60XoxjQeBoF1ccsZvF9KXuAusyfFdZrmariqjBUXvs2jyIZ43nC3RE0iHs
 uYRB0/RcUEtMZ/q3dO62YnfPs0AiRF3iehsJA+kxHDp12XhBNjKFEQx8e1ZriM+JFoDJ
 FPpOzw3LNEJlXi7wpwpCEt9fx3N13rsTaSZpBuSzQMrLImNyN2wcvW4siRIDzM4a4Xos
 t7lDYNJW15VcAvXIGS3LfoV834zsX6HoJoAH3+5CDQ1nE3+nz/me25ruQhhUTZTEGfF5
 6ElHSRMDTpYcFvhUbkncZHnQx/aPzNcUpIYT6IyRSBWEfBFrYpVEyzJT/N7g9Jn7Rn5p
 YXBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752494557; x=1753099357;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QiZnRDIM6/kZEbxqRnf//fPQu15IWBfB/VoqA6cAXpE=;
 b=l7vRFeV1b2WrKRogPxhgKsQcK1b4v3xAdLAgjRQVXGdWREtILYokW6r7aaB/OR0fju
 sO7Z1vdH4OkMplbUyKOT1+TKJKgWaWxw56sq9+iQToE0Fs/9OcQwTPNtx/MU/E9NS4oE
 4MeQHQQLzpXK7IKrl37nEOWxrq5YMgqF9rEeardFZtnCwk2HnruFgNinOYuLS9O1czAl
 foD9YUv6o1jnpeAhJUSvcS/sbvk347k3HkMJSNJiJX/BZfjuqiaJA+p1Q01AZ64aY++1
 rnZiVXqPUQPoV8aBjULOCl5AvFhOS5fZZ4hTqHuSScz2qz6AjSXwbb3HL/WSX3AZZBdI
 N0IQ==
X-Gm-Message-State: AOJu0YwcklU+t2i8tOmAOyIC82j7iG6dJ9EjDh4/1rVwQD0mP9ji3CwI
 1dV63J42hjFyxtYQHqVv4uihMHcm+2aVoZ4u83CqoBHQ0HT+qVIsXm6K+aGyByFuMRI=
X-Gm-Gg: ASbGncvr1z7AbpVTm1y2mIjCgBu0mc4tZkKDFzVeK1TBB9OIKExWb4SiAIZBUgRGmrA
 WvBKIKEPu0l4OWCgMOR2AMA7Pp9/f9dQkgJwlqc36309D7cb/Z/OQaChTfnRVXR7mLZuFakYf+t
 Y+hl2F2OSmlqkKN2o5kVsXnU0c6le7JbAXQylN1wPCd4UVrp+Tn654a/X6SHlQL3C7OdDaC70az
 JI+vAdArL6py1CPAlhdSJT4wBKVvTLk+SKjykC6NS//xVfTrVTO+OP2jyrdn2X/p9cYjIJlfyX6
 VjJOiV1UCE87U5EYu/vgVcxnpdDWz2HbOw8cqoqXila9074g+K6UImQxk8AgZppBxjRrdKyTSyb
 JZEW7Y/OLcJYeoMgsX/8gAGQ=
X-Google-Smtp-Source: AGHT+IGe87kPbPhRwhjhjG8iP6popYMstJSM/pIvirnQQUVpwHchFlDLX8uNaln+LCbbd1pcAaRAKQ==
X-Received: by 2002:a17:907:72cc:b0:ae3:ce75:afd8 with SMTP id
 a640c23a62f3a-ae6fca6d396mr1218906066b.30.1752494557091; 
 Mon, 14 Jul 2025 05:02:37 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae6e82645fdsm820902666b.97.2025.07.14.05.02.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 05:02:35 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id DD19F5F89B;
 Mon, 14 Jul 2025 13:02:34 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PULL 2/8] gitlab: add -n option to check-units script
Date: Mon, 14 Jul 2025 13:02:28 +0100
Message-ID: <20250714120234.1524401-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250714120234.1524401-1-alex.bennee@linaro.org>
References: <20250714120234.1524401-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52c.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Mostly a developer aid for those who want to look at the full backlog
of multiple build units.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-ID: <20250710104531.3099313-3-alex.bennee@linaro.org>

diff --git a/.gitlab-ci.d/check-units.py b/.gitlab-ci.d/check-units.py
index cdc62ae5ee..cebef0e8be 100755
--- a/.gitlab-ci.d/check-units.py
+++ b/.gitlab-ci.d/check-units.py
@@ -30,7 +30,7 @@ def extract_build_units(cc_path):
     return build_units
 
 
-def analyse_units(build_units):
+def analyse_units(build_units, top_n):
     """
     Analyse the build units and report stats and the top 10 rebuilds
     """
@@ -44,7 +44,7 @@ def analyse_units(build_units):
                                 reverse=True)
 
     print("Most rebuilt units:")
-    for unit, count in sorted_build_units[:20]:
+    for unit, count in sorted_build_units[:top_n]:
         print(f"  {unit} built {count} times")
 
     print("Least rebuilt units:")
@@ -57,12 +57,14 @@ def analyse_units(build_units):
         description="analyse number of build units in compile_commands.json")
     parser.add_argument("cc_path", type=Path, default=None,
                         help="Path to compile_commands.json")
+    parser.add_argument("-n", type=int, default=20,
+                        help="Dump the top <n> entries")
 
     args = parser.parse_args()
 
     if path.isfile(args.cc_path) and access(args.cc_path, R_OK):
         units = extract_build_units(args.cc_path)
-        analyse_units(units)
+        analyse_units(units, args.n)
         exit(0)
     else:
         print(f"{args.cc_path} doesn't exist or isn't readable")
-- 
2.47.2


