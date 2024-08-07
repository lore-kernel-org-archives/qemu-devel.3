Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 527E8C3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 11:42:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbf2a-0006Fl-TM; Wed, 07 Aug 2024 07:41:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sbf2Z-0006C3-Mr
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 07:41:15 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sbf2W-0003BQ-Pn
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 07:41:15 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a7aac70e30dso189166966b.1
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2024 04:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723030870; x=1723635670; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ecJtrwPM/qaJJXagybzVYA5cneRACpB/XSuc2I/vBc0=;
 b=V+W5F/9hVajkrA/nEMLRqzQE2kI/H/eie01kPLhyjAHuZTOedthNp81od2RA05nk6K
 8QvOby55XhD/7j7PHWpXl367wtvCuqbW/BDZVwO1xAxyLAhFjxs3coYVvtEp6G83YZCr
 /dAdpM+V7ymJGblMOY70gDR4/fIfK2aAYD6Ua9SZoe2Y0M4NQcvRdXRfj5qaNuLLyxZt
 HeTdh0A2FgcUEkoS5+qH0cY57mWLL89VaaQdsBwclblojHdgLPcXA4kbuFYyIfZUbUcK
 1ivMIVZHwykxhfI/wKi8TMI9tdrUNQuQpOLoDRg86CWlKKJvWf16cW8EdVYD1cUZcDdh
 42aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723030870; x=1723635670;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ecJtrwPM/qaJJXagybzVYA5cneRACpB/XSuc2I/vBc0=;
 b=l3Q5s8vhuomucYgSp626fie/fMJJqYf9h34g1xwFM1NqRd9lLSvy10AFMoCWyEUwiK
 Dmh+2ex23k9lP7sRHbtQPjqCUwLKeZPV1xFJ2q0cGlPuycf8e7+yWFPO1BYPFBQ9mTT2
 0jXad0cN8BgBgxiOp+NM4+m6zvQMT3xSarrmgIkmXG4l4QXYgDrBELyQVLXRYvb3uriO
 0ccx7g6BvGfQMeeapIMdzK8yS2BbptEDNolm1bIqmFpp3TcNhMZ1Ew65stOUCZre4C00
 RkK032u11eLOSzhnirXclS0kR5X4ZX10xZA+oJkBgvaZmysxMG6EIrEWPJMrdoZKZNz9
 Kpbg==
X-Gm-Message-State: AOJu0YyAFHL5VQKCz4hmvdChRD7hUlkrvk6RamwDmhrULbJ1BGhYjW7c
 iyfJaNiLTxpCsR4xRcysTf/atUGWXJnxYPRzdKTLaPcpZz7pxOckjFKnF1e0BaY=
X-Google-Smtp-Source: AGHT+IEOYt7VVIUjvhLC8vzpDPBu0VfAGQ5siInhvEP4PzoOnY2VFTTgnyQh87leEedzB/JDgqk4HQ==
X-Received: by 2002:a17:907:98b:b0:a77:b01b:f949 with SMTP id
 a640c23a62f3a-a7dc507f325mr1308774066b.35.1723030869989; 
 Wed, 07 Aug 2024 04:41:09 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7dc9d4dd45sm632426266b.104.2024.08.07.04.41.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Aug 2024 04:41:06 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6EF755FA0A;
 Wed,  7 Aug 2024 12:41:00 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 6/6] scripts/checkpatch: more checks on files imported from
 Linux
Date: Wed,  7 Aug 2024 12:40:59 +0100
Message-Id: <20240807114059.2339021-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240807114059.2339021-1-alex.bennee@linaro.org>
References: <20240807114059.2339021-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62d.google.com
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

From: Stefano Garzarella <sgarzare@redhat.com>

If a file imported from Linux is touched, emit a warning and suggest
using scripts/update-linux-headers.sh.

Also check that updating imported files from Linux are not mixed with
other changes, in which case emit an error.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20240718072050.9503-1-sgarzare@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 scripts/checkpatch.pl | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index ff373a7083..65b6f46f90 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1374,6 +1374,9 @@ sub process {
 	my $in_header_lines = $file ? 0 : 1;
 	my $in_commit_log = 0;		#Scanning lines before patch
 	my $reported_maintainer_file = 0;
+	my $reported_mixing_imported_file = 0;
+	my $in_imported_file = 0;
+	my $in_no_imported_file = 0;
 	my $non_utf8_charset = 0;
 
 	our @report = ();
@@ -1673,6 +1676,27 @@ sub process {
 # ignore non-hunk lines and lines being removed
 		next if (!$hunk_line || $line =~ /^-/);
 
+# Check that updating imported files from Linux are not mixed with other changes
+		if ($realfile =~ /^(linux-headers|include\/standard-headers)\//) {
+			if (!$in_imported_file) {
+				WARN("added, moved or deleted file(s) " .
+				     "imported from Linux, are you using " .
+				     "scripts/update-linux-headers.sh?\n" .
+				     $herecurr);
+			}
+			$in_imported_file = 1;
+		} else {
+			$in_no_imported_file = 1;
+		}
+
+		if (!$reported_mixing_imported_file &&
+		    $in_imported_file && $in_no_imported_file) {
+			ERROR("headers imported from Linux should be self-" .
+			      "contained in a patch with no other changes\n" .
+			      $herecurr);
+			$reported_mixing_imported_file = 1;
+		}
+
 # ignore files that are being periodically imported from Linux
 		next if ($realfile =~ /^(linux-headers|include\/standard-headers)\//);
 
-- 
2.39.2


