Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0409C52D7D
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2024 14:50:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sebn3-0003OV-Kb; Thu, 15 Aug 2024 10:49:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sebmz-0003D8-EY
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 10:49:21 -0400
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sebmx-0000Cc-AB
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 10:49:21 -0400
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-52efbb55d24so1813171e87.1
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2024 07:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723733357; x=1724338157; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XlVm4bFaARcVP1rknNRsQtAnzRUhJ++dQu53YaEvbis=;
 b=sfhJmv6AsHrQt/9f3ulpstXjZUq5Dre0ZzQsdk6WBeo04HVijLY5fz8IsdH8gpE/Mf
 bjbeBiiIbXpsg46ad3A8rsyeodmXD5IOzYIqzO4Bha/WmbcUo77xIsuxTHa8nCjZ5b40
 cJQE+2GRpOjGCvJicpEHlKYEvLfqGO5OJM2sSgBysgOK6Da3ITgPxuxmMx8zOO/xg3Bm
 i0TaGJhKYqPTUJFiuGTcLt4r2VDgYEiAGK/UALQ9Ct4ncaVKHLdwI+Kpl89NW3/Uy8wz
 UgEVRQqcJDTQMOe68AVrS7AyLpeCH1r5fl9UpDHiPIxF3+A7Fo+bsFwh7tMaBwkKDdHe
 S/Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723733357; x=1724338157;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XlVm4bFaARcVP1rknNRsQtAnzRUhJ++dQu53YaEvbis=;
 b=w+ielk/ihscMvLL2CplE6JBoYnJ9Z53Kz9CtTIGeohzR4wRgaDIAgzEtxf39upr22j
 8I1PDCTlC7CbBJZ+kNj8ZPNbBVb0CDhgCLUNZzEvqIz1gPuSlEH/Z4fwqL91iWx9jIxx
 4SonzEGFWmg3CZe4XQQ+HCg293HCsjUOTrDFv89K409DBJzUzMKnWa1hC1Snx9H6RyIA
 rQMRHmtqr+52h1fZ3fhIL9GgzBJoWfllBxWX39ofH4jl9vfZX91s9yvh40nhV+KCSoLA
 pSS9s5i6GDoQ03jV32vsOmakR+7e8BAGO1aSqYlpOZuMr44NQL8a8Xxosg2B2aW4dgQR
 5zRg==
X-Gm-Message-State: AOJu0YyjNs3WEeef9D1eZX+NiwORgK6/c4w9jc4RcKqE4NpR8SBHDiyh
 Fmf6bmyMxuWTki0Bu7Qaz28YePcRjUV0SvJduTMh7luPyI0MlhzJPWqz/EuIzlQ=
X-Google-Smtp-Source: AGHT+IHcL4qbC5MZgNQOgWzymD8gZCDlv44EIwf363GkVNkeKJ8rFhcRUCHGV8017F69yBZgax7Zng==
X-Received: by 2002:a05:6512:33c2:b0:52e:716a:1898 with SMTP id
 2adb3069b0e04-532edbd145cmr5432741e87.58.1723733356960; 
 Thu, 15 Aug 2024 07:49:16 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a83838cfac5sm111481866b.80.2024.08.15.07.49.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Aug 2024 07:49:14 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 4000B5F953;
 Thu, 15 Aug 2024 15:49:12 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Stefano Garzarella <sgarzare@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 06/21] scripts/checkpatch: more checks on files imported from
 Linux
Date: Thu, 15 Aug 2024 15:48:56 +0100
Message-Id: <20240815144911.1931487-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240815144911.1931487-1-alex.bennee@linaro.org>
References: <20240815144911.1931487-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x12d.google.com
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
Message-Id: <20240813202329.1237572-7-alex.bennee@linaro.org>

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


