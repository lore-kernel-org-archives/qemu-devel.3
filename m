Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48F6BC79FB7
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 15:58:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4KfV-0001kj-Ja; Wed, 09 Sep 2026 11:57:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x4KfT-0001kH-Nh
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 11:56:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x4KfR-0002s6-S8
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 11:56:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788969417;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f0qHQiLEDbXcO0bIQYiBkbUoGUgUJLST3vazByy6udI=;
 b=KBfMbOalwvvKZXvkt8y9XLJstVQujZIg6sr948nYlBGj58JVx+JhhdhJ/Z/xC5jaeQc8c1
 2Fry47hPX4ni3pMW8nGo3DSs3nXeCN6iFCcBtJD1gi/TBxEpsPjTXD/kRjKA7WBOlSXlrH
 JeU+uFTYW+n1TE/0o1gWoQeUv/FScvw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-685-NZFnO17MMqe4CVEsnUsB4Q-1; Wed, 09 Sep 2026 11:56:54 -0400
X-MC-Unique: NZFnO17MMqe4CVEsnUsB4Q-1
X-Mimecast-MFC-AGG-ID: NZFnO17MMqe4CVEsnUsB4Q_1788969413
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-49ccb223bceso16805e9.0
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2026 08:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788969413; x=1789574213; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=f0qHQiLEDbXcO0bIQYiBkbUoGUgUJLST3vazByy6udI=;
 b=ddIhHkshOBCv1553InjRVhJfeNeM4PYeSsIq3iOFLw8XD9ZtOLztaur7wcQrlFmDWp
 a26AkQJh+SJCseqG40QvRVdzy15d9pu4+WsYtJvTV8NQWuGlVRs7mp0tEU/lx7qnIH8G
 lCZxwSGYuOB1KBNi7yQncFNy4vZ3p004rbp5GwlB0/bArB39G6s+vDY8nljGE0LnKq8G
 1GpjhkKgZ6m+bNxSTi4ffu8BifrenTkP/29XEh5/KhqSERUXoaPJhzqhXDi59pQnIDY2
 q6s2AYQ7xEXlXmn2tQnpUy6pOXS9lJ/dPGA9VrKzS3gB8XzfZfplPLcvGerXuwfGE6h+
 V2Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788969413; x=1789574213;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=f0qHQiLEDbXcO0bIQYiBkbUoGUgUJLST3vazByy6udI=;
 b=qmweagDbqnu2eO08PO633BBecIhv/GSCgMyosDwxSHNL9d1iHKrif0quBYaXfdN3LY
 4s2KfiCPWS8S7C1vRx/AX/j/3gX854QzO4frkoXPfvw5GVHMDxDQ6uTOLDdtGgc1HVHg
 DWW6QBIV5ktGS70+2Jp/SWdPxUte4LdJRvh/h3S0LVCvX5MoZLYzjOK71coAnA/Q1QWm
 nF2p7rMkwVEg7kijpCRbUV0MlH2WVddI9rUq90qTfvc41D0/YE0Jfpprn0NpDI0RWoej
 /8NE4gzjM/ATL0S4WddjlcauYklVe2hjuxvGrRK6I6DaCZ8WaNAau8wNrNuH2xTE+csd
 YQ1w==
X-Gm-Message-State: AFuF++k7h2y0ziqp5ZkcAodENUkB6knkwHT1Fp0Y9QtYHHNvPhHZT5L8
 s2nwtmAXl3bk7ponqnMkaxOR/I7gEGg9SLaXHqjHiebo/hHt1fJYsPH4sPokkuzS4byv7MwzFF+
 V2esrKJ8nZhH0B/Rxz04WmzxrN6JvnTARQDpdB+A3Bdwh7Io6mDRAOkIbHrOaYzPvSVtqo3NNoJ
 2/0fc4Gi3/j6A4/C2C+3lXM1uiaG7QhxQvdOx+vPig
X-Gm-Gg: AYBFou2GuOTiYBgqQMW2ZA8gReDEn+c7fxCKWA3CgQBWkNyEfXH7BnPHcfd1qeQAKSA
 RuGf4ReSS7RlEMw5W9opc5R5o6wu/2gbPS7TMcY+IBwh7jRD/UR9LymsKRBzfI4sMXKuljA3fA2
 InR+Ha0q8FkRPH6CY+jmjpxw74bucBheJjcmuXuDmjs8LsDxBD1AiCP/Rs174PUAUQpn59/Prlg
 e7eNWaXFrQ3/0JCJ4TLM0uBmyMJR5qgnKttE4J15JkfuYwpgHDJDa6gwE4c8iZANwzaMa0lxYgx
 g7qRXuo1LQv8pQph4bG8PaPtJ4Bm8K1k6zSlYohQ3Xk3GUbM+M2Hbz28EaTU1a6mi643/jUwLkh
 xRdiBW6lmJGW7PRhUvjXdP/oMspLHomBRQeOUbHoSVjz+3x1vFWcKpAF3PBIJ9k/5y77y/U3nAl
 iK1mtW
X-Received: by 2002:a05:600c:a01:b0:49d:1916:2133 with SMTP id
 5b1f17b1804b1-49d1916215amr120291895e9.8.1788969413292; 
 Wed, 09 Sep 2026 08:56:53 -0700 (PDT)
X-Received: by 2002:a05:600c:a01:b0:49d:1916:2133 with SMTP id
 5b1f17b1804b1-49d1916215amr120291385e9.8.1788969412567; 
 Wed, 09 Sep 2026 08:56:52 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.232.249])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d20fc23fcsm58829355e9.3.2026.09.09.08.56.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 08:56:49 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 09/12] scripts/checkpatch: warn on duplicate trailers and
 self-review
Date: Wed,  9 Sep 2026 17:56:21 +0200
Message-ID: <20260909155624.1082893-10-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260909155624.1082893-1-pbonzini@redhat.com>
References: <20260909155624.1082893-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Detect two common trailer mistakes:

- Duplicate trailers: any trailer (Signed-off-by, Fixes, Resolves,
  Cc, etc.) appearing more than once with the same value in a commit
  message.

- Self-review: a Reviewed-by, Tested-by, or Acked-by tag from the
  same person as the patch author, which provides no independent
  review value.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Link: https://lore.kernel.org/r/20260727161157.2112984-1-marcandre.lureau@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/checkpatch.pl | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 547a59dcac5..9838a641785 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1539,6 +1539,8 @@ sub process {
 
 	our $clean = 1;
 	my $signoff = 0;
+	my $author_email = '';
+	my %commit_trailers = ();
 	my $is_patch = 0;
 
 	my $in_header_lines = $file ? 0 : 1;
@@ -1795,6 +1797,14 @@ sub process {
 		    ERROR("Author email address is mangled by the mailing list\n" . $herecurr);
 		}
 
+# Extract author email for trailer checks
+		if ($in_header_lines && $line =~ /^(?:Author|From):\s*(.*)/) {
+			my $author_info = $1;
+			if ($author_info =~ /<([^>]+)>/) {
+				$author_email = $1;
+			}
+		}
+
 #check the patch for a signoff:
 		if ($line =~ /^\s*signed-off-by:/i) {
 			# This is a signoff, if ugly, so do not double report.
@@ -1823,6 +1833,28 @@ sub process {
 				"see docs/devel/code-provenance.rst\n" . $herecurr);
 		}
 
+# Check for duplicate trailers and self-review
+		if (!$in_header_lines &&
+		    $line =~ /^\s*([A-Z][a-zA-Z]*(?:-[a-zA-Z]+)*):\s*(.+)/) {
+			my $trailer_type = $1;
+			my $trailer_value = $2;
+			$trailer_value =~ s/\s+$//;
+			my $trailer_key = lc("$trailer_type: $trailer_value");
+
+			if (exists $commit_trailers{$trailer_key}) {
+				WARN("Duplicate '$trailer_type' trailer\n" .
+					$herecurr);
+			}
+			$commit_trailers{$trailer_key} = 1;
+
+			if ($trailer_type =~ /^(?:Reviewed|Tested|Acked)-by$/ &&
+			    $author_email ne '' &&
+			    $trailer_value =~ /<\Q$author_email\E>/i) {
+				WARN("$trailer_type from the patch author\n" .
+					$herecurr);
+			}
+		}
+
 # Check SPDX-License-Identifier references a permitted license
 		if (($rawline =~ m,SPDX-License-Identifier: (.*?)(\*/)?\s*$,) &&
 			$rawline !~ /^-/) {
-- 
2.55.0


