Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86676CCF9F8
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 21:12:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vG1m0-00017I-VC; Mon, 03 Nov 2025 16:07:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vG1ly-00016J-0r
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 16:07:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vG1lf-0005QL-M0
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 16:07:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762204029;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=78QU1zLKtZBzhS+NWp1ZiPbFKbBWGfv4kQfel61XBDM=;
 b=LoPzSRocOYN5LmE7/hj+3XKTfO6l6LqiJ7P/6ZD5ruITksMzSUPAoF32nzIHT77SwgOwB6
 8M61pYRZ41S/M2jA4EE/XTu4LB56NdTSObmWp7Ee25+uW9TrDUIwR4Ic0aKZDD/101hCvU
 lDhOwHub6D8dGVwX56jbS6aCLYYNHtU=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-231--Ic1oF0CPEewRklV47pLsg-1; Mon, 03 Nov 2025 16:07:08 -0500
X-MC-Unique: -Ic1oF0CPEewRklV47pLsg-1
X-Mimecast-MFC-AGG-ID: -Ic1oF0CPEewRklV47pLsg_1762204028
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-8a4ef35cc93so1433974285a.3
 for <qemu-devel@nongnu.org>; Mon, 03 Nov 2025 13:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762204027; x=1762808827; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=78QU1zLKtZBzhS+NWp1ZiPbFKbBWGfv4kQfel61XBDM=;
 b=Vyt6ZzyauLVYn2XDT8V0VsSvqWiRn0lyuF2TQc/rYtCWcVQD8khyIumdGzjl/ZkpAc
 XpB4VXFGESCfJ0cImI8xLaYhUQkVOKE1xYSmMumZ5tw7/e1yZl0BkUVKX1rmPj9zIjeh
 nTuin34EJ9yNwm7bT3pmtDKvBRwb354F2sOqrIiU4ySve0xu8jleF4bJ91Ock+n51pxQ
 03EuKQgwv3FRfZv8bAwnYCkxdf6gIgp0lzWlZ3u8FTkGpQJdfLyZCXxHy4RFjK+bAAaG
 27+BwHvfJVCqhWIpdYiYSsyLZEUPEEzyIov58tmqA+STmqf/1ujNMZiyDedcfQ1DTHVL
 NvrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762204027; x=1762808827;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=78QU1zLKtZBzhS+NWp1ZiPbFKbBWGfv4kQfel61XBDM=;
 b=Qy2BSFtmC10X2DlYslbe3qcBCDtR+EiR19/GSPvFvNCbbRWYWHLbtNzOQLux3PWKzh
 HW7VUEHCtvvlB4/l8JQg/rPrbYNjLzwKKLFyK6Q6rUl+G7TeuZ1tmKlmRPt5uwRhKX31
 nd2qkYakdf2N6bYh65j2EE2/uqqS7+mXJ665DhfEVEXQvCDvsroKWIHjYajGMZl0blK0
 0RQ4BEGsP4Pd/YOuBVwWA5TdVPuDCyXubygsIpMD8xuFOhyGwIIIzXEClO28VPX0fHJr
 WnsaoAGy1AzTxeTAol3R5cZLVU7iDHwcLp6d1iM/BPslWGF14ZvxNvT+0mdD/q0QLQgu
 gC/Q==
X-Gm-Message-State: AOJu0YxuouKDNgdswltp+wFqtCQ6Uqdcgy7r2lQC0/vckrbq95X5/GTd
 kMRz0q8zDzJQREKUYn1ApFxPFze5+ci2wyNd+6aKTNxnRHs+V2zLMM2ZfX2jcJnCdT9R2ZYE78H
 vi9w5F5Q1yvkfG3qdKx43mNW2teIG1cBZ3xorFwHnscj1qQt/SErDNce6B9FEtN3QHkq0JDb/UJ
 hRJ4hOYx22rYT3spfzbGnsdO9pLI/2nnHv1yffEg==
X-Gm-Gg: ASbGncupe00GXmvNevY4TW231908SUpdnbjOpcfrOVugRnCpozvCJJgllma2ev6zbzg
 UexpA01ZTwgT7UJpIhIVyX+epRy3sni5oMKy7+ew+sDjP38I4oEamZap1PBwpEczs3rRGvlq7IU
 ohdtbqTVfpw6bTuIu1asF8WD1sVaDxPdKJsNgJyoII4avDN4BzEJt7CHnTVhQL5/ngbOadgj71/
 crCltzoQjIJVX277Bf04mkrIAoATPm7XYduO4jxu8Ep9OvvKt3zUB+JtsH5H0fy3r/DODgC0JSc
 bVDQU/11Y9SndthcRJ771V6jMnNnSwgZkHwM3rmWu+GdMEa+kkfGYHGjWkLPwuzS
X-Received: by 2002:a05:620a:4694:b0:89f:b32b:3416 with SMTP id
 af79cd13be357-8ab9abf941cmr1703194185a.75.1762204027133; 
 Mon, 03 Nov 2025 13:07:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF+UgFrud1VaU0z/9ZTengAcyb7EDZAiY2Z8Gat5ulsky5QroJbDs0wKWFeL7aHoXfJt4Tt+g==
X-Received: by 2002:a05:620a:4694:b0:89f:b32b:3416 with SMTP id
 af79cd13be357-8ab9abf941cmr1703188685a.75.1762204026408; 
 Mon, 03 Nov 2025 13:07:06 -0800 (PST)
Received: from x1.com ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8b0f5468968sm57428185a.19.2025.11.03.13.07.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 13:07:05 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, David Hildenbrand <david@redhat.com>,
 peterx@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 27/36] scripts/vmstate-static-checker: Fix deprecation warnings
 with latest argparse
Date: Mon,  3 Nov 2025 16:06:16 -0500
Message-ID: <20251103210625.3689448-28-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251103210625.3689448-1-peterx@redhat.com>
References: <20251103210625.3689448-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Thomas Huth <thuth@redhat.com>

The argparse.FileType() type has been deprecated in the latest argparse
version (e.g. the one from Fedora 43), now causing the test_bad_vmstate
functional test to fail since there are unexpected strings in the output.
Change the script to use pathlib.Path instead to fix the test_bad_vmstate
test and to be prepared for the future when the deprecated FileType gets
removed completely.

Reported-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Link: https://lore.kernel.org/r/20251030092638.39505-1-thuth@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 scripts/vmstate-static-checker.py | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/scripts/vmstate-static-checker.py b/scripts/vmstate-static-checker.py
index 2335e25f94..89b100e6cc 100755
--- a/scripts/vmstate-static-checker.py
+++ b/scripts/vmstate-static-checker.py
@@ -21,6 +21,7 @@
 
 import argparse
 import json
+import pathlib
 import sys
 
 # Count the number of errors found
@@ -382,10 +383,10 @@ def main():
     help_text = "Parse JSON-formatted vmstate dumps from QEMU in files SRC and DEST.  Checks whether migration from SRC to DEST QEMU versions would break based on the VMSTATE information contained within the JSON outputs.  The JSON output is created from a QEMU invocation with the -dump-vmstate parameter and a filename argument to it.  Other parameters to QEMU do not matter, except the -M (machine type) parameter."
 
     parser = argparse.ArgumentParser(description=help_text)
-    parser.add_argument('-s', '--src', type=argparse.FileType('r'),
+    parser.add_argument('-s', '--src', type=pathlib.Path,
                         required=True,
                         help='json dump from src qemu')
-    parser.add_argument('-d', '--dest', type=argparse.FileType('r'),
+    parser.add_argument('-d', '--dest', type=pathlib.Path,
                         required=True,
                         help='json dump from dest qemu')
     parser.add_argument('--reverse', required=False, default=False,
@@ -393,10 +394,10 @@ def main():
                         help='reverse the direction')
     args = parser.parse_args()
 
-    src_data = json.load(args.src)
-    dest_data = json.load(args.dest)
-    args.src.close()
-    args.dest.close()
+    with open(args.src, 'r', encoding='utf-8') as src_fh:
+        src_data = json.load(src_fh)
+    with open(args.dest, 'r', encoding='utf-8') as dst_fh:
+        dest_data = json.load(dst_fh)
 
     if args.reverse:
         temp = src_data
-- 
2.50.1


