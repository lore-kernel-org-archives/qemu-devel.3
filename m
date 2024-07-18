Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0941C3DA60
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 07:21:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sULS3-0005nI-P6; Thu, 18 Jul 2024 03:21:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sULS1-0005bd-V6
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 03:21:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sULRz-0006Q4-TI
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 03:21:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721287271;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=qAqPrCeOYPNhd542Fw6myKMcE2pXClynTqDJiMXCNIA=;
 b=dBZBwgr+qnrG1tPO2RlUPulM2Q0nJjr2xM7QIAEu8n6hTzyWFMPx3+TixozRXeCXFC1ywY
 5fvFWsaEs4EoTlCiT1k2OpqiE5mSgrW/cXyjsHrapkyf+WWFSXH8l1cCad7pbvj7tkybfZ
 h48wFl40HdQOaPjA+kyGLZ6jqhrOO9A=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-45-3jJlzwk8NV6yLdcFxeG6Ng-1; Thu, 18 Jul 2024 03:21:06 -0400
X-MC-Unique: 3jJlzwk8NV6yLdcFxeG6Ng-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-5a0d4ce5d5bso254659a12.1
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2024 00:21:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721287258; x=1721892058;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qAqPrCeOYPNhd542Fw6myKMcE2pXClynTqDJiMXCNIA=;
 b=ERC966Zhrn7No+wINSScfVTZsy1AG6ifQLGlRIhll1WXaJt3ZbkuvFxZYAm5ml93fI
 2Vjn/viSq927sXo7GInvGWHF93wQ4H0m6xfis3t0x7Tp2sUhNRooi/n8yRA7SiRSuUoS
 +JI4RXyQM3VWdX5PvTGLRNjC44v6VR5vbzw2CR+k7hCwgi6lVvJrgSvrUQKj142+0jOF
 v7YCo7NtV8yEv2dBzZOyGBl8EmDI1LHVPt6hgrcI9RcmNVuLm10P7kUJ1bRNuteZEm16
 br0CSfGndNcpK/K+6tUa7xuilf7AHxhAJ2zyRPxbD5+kr2VFimzbqs1OrD+KONROAiHB
 v50w==
X-Gm-Message-State: AOJu0Yxr6VKFBeZ0rp7w65dHtdLo5Uka2xNR4NSRlOjr7BA/iUcRDu/+
 fAekufGz+Ko1DaiElNe/OIrASb882A2N+wjThzF0IffKkPSi+iG43qdnIWqEKkFHQURnhIo3v2H
 aIlnsG4C3Esmp7+S/4/jlMUNaiZNEvODkStpOfGQRHMp3xpphNH0/Fmjw5MaTGc/U2EmbnRW7AO
 dC0eMAlWQiqZtjl9kQjsOmL6ppZkdP5YPb/oeB
X-Received: by 2002:a05:6402:2685:b0:586:12f6:c0fe with SMTP id
 4fb4d7f45d1cf-5a05b417922mr3097676a12.5.1721287258297; 
 Thu, 18 Jul 2024 00:20:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGt4QFlJ4xUWvokpAzXDVyrJLUe2/6jQtFMkX/gobfXV/iTDfjEUGIQLOPv5GMrcA0Qy0sSFA==
X-Received: by 2002:a05:6402:2685:b0:586:12f6:c0fe with SMTP id
 4fb4d7f45d1cf-5a05b417922mr3097645a12.5.1721287257570; 
 Thu, 18 Jul 2024 00:20:57 -0700 (PDT)
Received: from localhost.localdomain
 (host-82-57-51-153.retail.telecomitalia.it. [82.57.51.153])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-59b24a770dbsm8050838a12.4.2024.07.18.00.20.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jul 2024 00:20:56 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: qemu-devel@nongnu.org
Cc: cohuck@redhat.com, berrange@redhat.com,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v2] scripts/checkpatch: more checks on files imported from
 Linux
Date: Thu, 18 Jul 2024 09:20:50 +0200
Message-ID: <20240718072050.9503-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

If a file imported from Linux is touched, emit a warning and suggest
using scripts/update-linux-headers.sh.

Also check that updating imported files from Linux are not mixed with
other changes, in which case emit an error.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
v2:
- added an error when mixing imported files with other changes [Daniel,
  Cornelia]

v1: https://patchew.org/QEMU/20240717093752.50595-1-sgarzare@redhat.com/
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
2.45.2


