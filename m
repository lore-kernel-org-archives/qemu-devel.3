Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBF97EFCD9F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 09:45:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzteN-0007YF-OX; Tue, 10 Mar 2026 05:45:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vzteL-0007WU-8f
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 05:45:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vzteH-0001HE-Tm
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 05:45:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773135908;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oDFv6vUx7Yjbr97G4Bq7roWLeCshrRcn4NDJ9taS8BI=;
 b=OizFyFDPrUJ5qPV2D6LG+0Mba2Q6ppJvoB7/r+5+4h9OiUDDjRET49WqLv0WK95G8g+4zR
 5axL4R1M6DtBedwA1+/c2QzHeewg1PgBObxx1g5cb1i/b49CLkkFVsV4k9oAYSK+UOEQa+
 CNrIb46pD+Vjahh1m28qVS4xkKF5rfw=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-43-DjXr8Y4gPp6sksb4K-sOvQ-1; Tue, 10 Mar 2026 05:45:07 -0400
X-MC-Unique: DjXr8Y4gPp6sksb4K-sOvQ-1
X-Mimecast-MFC-AGG-ID: DjXr8Y4gPp6sksb4K-sOvQ_1773135906
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-82984468f85so2977934b3a.1
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 02:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773135906; x=1773740706; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oDFv6vUx7Yjbr97G4Bq7roWLeCshrRcn4NDJ9taS8BI=;
 b=h/3oKFyLcvTWC6Eq0lMHgp78MfzyNGJAVDr2szc2qlMtsF/kVYR3r0sMKUtJHpC1UB
 lLhWbBSlP1zDAy0n3BhiWy9awMj7/bs7Vx/8v4GJiqEjTAmAJJBJDF7zY8efxZxd3uUX
 T1EbWZDveSHxJajer9EO7wfLwtafMwbtiZorLliaHegfp7ko5BVNDWJSCPS1XipPmpIA
 fZW+wBWAOoqZXEY6eZHT/efpJJc/NKtW+N61HSMP49KMUlUF1Nbu1YnQjUHY7LB5/5Lo
 sK+aumX4I6z3ZNaBLM55BbAgFYuw9DKD0IjuYtmsgQFwkB5002lQvmLJRAxjffLBFChu
 H26Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773135906; x=1773740706;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oDFv6vUx7Yjbr97G4Bq7roWLeCshrRcn4NDJ9taS8BI=;
 b=Qt2ZU94+blW/8mJTbzKvkgRuWgzBGeN/46aZNL82+0o0GUovzK9J13eD6P9kkDfuDv
 ur0cfhoeptJ/bwKDNtHZ5YTBmTdrgdUMYR89pudFDCFkXzcN7703m+LKOYy+vwGG7zfY
 I6tCKAl3uPdP3StXFQYX3tPBw7x7qoqZ9KazsHmU/Ap8rmSBSIbbypUoivpTIMYcJR/7
 2fD40gyfwB/wgE32RejrMciONOGWHxHriMdvIDHua49HH1sV3Q10rbWwFQAHfwVBb5yM
 P6Wj6TK8xjehVNR3dj+/T+LD5XsrGNszvMgot+JBq2QZSROgaTE4UlOCmYQD9atIH9Z7
 BZCg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLw5UOwDHyzYvIxy96IMNjpP5KpG+C7+U/obbpoxl2VgmGG68/zwNct23W5RBz7/fcpDBBY5vVdFBQ@nongnu.org
X-Gm-Message-State: AOJu0Yzdf9iho4YIB0H8crp7ExYH7srJ8E57XkVOcbmhA3nfCP4zdgj5
 oTtQCntjmTWpD5844IMxMvYdI8n5c4k2TGjgoPj7CrkcSkQ9wOfehKvpLMHUQT682GCOklgvrkh
 sI3KsffMqKun7eqqYXxYVz2frJxMXjE4AFSrL9SkvrN08VfKyR6wIe7Zg
X-Gm-Gg: ATEYQzzjeSkqRhtb2Fz8u/alvrs6uzkBnVE/JM8RNkAIJ9DU587KzNI1/TwVzsaa2Kc
 MqmW/DX0/GPaaVUOfG2Dn0cD6wSpAzTpjs4s49T6sE14wzukN4aEQKM7m3NjpYsFfXQ67s8pqGw
 4u/YLagyQ7dJgyFVGGZ+YE0SG+XyNtq3Kzd6/oSB4Rd0QRkgpagmZNzozl6VxdnUy6piOXLEPZr
 ot9gLROiivW4blxSLzsMEqW6ViAiOHbA6Ou++wVLZjqe+c98pbtaRMp6XOimlHvMsOKelLuKPI8
 ruajff8olIv+DaZcmeeqB7idYxQfKyuowEpzwBYxEiiZTzG1tBYLv7/3U18ToLO8lFJ8PFpa4vy
 i5cIF/Qa7hKeLIWIIYcp2E5cRgjzBkRw/ugo7wHGo3TTNbL8hYJa2w98=
X-Received: by 2002:a05:6a00:8f0c:b0:824:9451:c1ee with SMTP id
 d2e1a72fcca58-829a2f92121mr12202186b3a.55.1773135905366; 
 Tue, 10 Mar 2026 02:45:05 -0700 (PDT)
X-Received: by 2002:a05:6a00:8f0c:b0:824:9451:c1ee with SMTP id
 d2e1a72fcca58-829a2f92121mr12202171b3a.55.1773135904947; 
 Tue, 10 Mar 2026 02:45:04 -0700 (PDT)
Received: from rhel9-box.lan ([122.176.129.56])
 by smtp.googlemail.com with ESMTPSA id
 d2e1a72fcca58-829a4636973sm16566142b3a.3.2026.03.10.02.45.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 02:45:04 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org
Subject: [PATCH for 11.0 1/2] runstate: handle return code of EOPNOTSUPP
 properly from rebuild_guest()
Date: Tue, 10 Mar 2026 15:14:48 +0530
Message-ID: <20260310094450.35861-2-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260310094450.35861-1-anisinha@redhat.com>
References: <20260310094450.35861-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

If rebuild_guest() accelerator callback returns EOPNOTSUPP, this means that the
accelerator does not support rebuilding the guest state. Handle this case
properly and separately from other error return codes.

Fixes: 4003e5e65fe0("hw/accel: add a per-accelerator callback to change VM accelerator handle")
Reported-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 system/runstate.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/system/runstate.c b/system/runstate.c
index eca722b43c..c1f41284c9 100644
--- a/system/runstate.c
+++ b/system/runstate.c
@@ -531,10 +531,12 @@ void qemu_system_reset(ShutdownCause reason)
         (current_machine->new_accel_vmfd_on_reset || !cpus_are_resettable())) {
         if (ac->rebuild_guest) {
             ret = ac->rebuild_guest(current_machine);
-            if (ret < 0) {
+            if (ret < 0 && ret != -EOPNOTSUPP) {
                 error_report("unable to rebuild guest: %s(%d)",
                              strerror(-ret), ret);
                 vm_stop(RUN_STATE_INTERNAL_ERROR);
+            } else if (ret == -EOPNOTSUPP) {
+                error_report("accelerator does not support reset!");
             } else {
                 info_report("virtual machine state has been rebuilt with new "
                             "guest file handle.");
-- 
2.42.0


