Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C165D5B86E
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 20:54:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVFYv-0006ik-GT; Mon, 15 Dec 2025 15:52:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vVFYX-0006PV-8Q
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 15:52:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vVFYT-0005tB-2f
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 15:52:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765831947;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8LRdt+/CQiyd/RiqOaKeRjP93SY+POOdomSS9E7DfjY=;
 b=YojYklWRayaxD0zghTqDRxU5BAuD/UGDC8GbXz3MEoYwdWNjE1KELMRieQfGioN2fabxEL
 3PfEfltaNxe2aoFS+K87KLWny/R+94Rb/2auusof/ajMKS/90ES+DzzUH2mzw6oBm2Y2IW
 SWCNmXcnANJFcJpfg6WzuIjGbwzkdVQ=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-bZ-L53sXPtOJy7ZrlfWbbA-1; Mon, 15 Dec 2025 15:52:26 -0500
X-MC-Unique: bZ-L53sXPtOJy7ZrlfWbbA-1
X-Mimecast-MFC-AGG-ID: bZ-L53sXPtOJy7ZrlfWbbA_1765831946
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-8b8738fb141so869221885a.0
 for <qemu-devel@nongnu.org>; Mon, 15 Dec 2025 12:52:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765831945; x=1766436745; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8LRdt+/CQiyd/RiqOaKeRjP93SY+POOdomSS9E7DfjY=;
 b=ZP+acPRbzFvFh70d42Or1o56p6VE4WW4ld57fcS+TMDfzG/WXQ18auA6ADBIXFeY2b
 lOIQWgRY6pJdZBXd1SCYEDV9dCC0OQJdoCucUA3TkHi7ZFuryhvSHZ5GQ0Vl1tRAEBZJ
 +QiifM50zTgVMGNB5TYE22C6Y53om5C5Q5hcJCECbpoQLgk386i5BEjKzBYqzEDcRlfb
 vfnlmGyTd37qEPeBWlsUiPMpNNT3J4eduxpSWeULOJW3BFENitf6Wl9ozZdQ0qdZvsaF
 PpGQud6a6sRNgu0mSkXEU+cMeQl0cZ8naKcHutoiDMlEo9uheqxiwmfiwEcSRLKe5gHS
 ddMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765831945; x=1766436745;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8LRdt+/CQiyd/RiqOaKeRjP93SY+POOdomSS9E7DfjY=;
 b=luMgF5R0Dhq7cX5j2fU0UmLoPSPPgdAIzGr5Q59EJp87Kx5ZMLxViN08mhjRxSOjHd
 CtReulqs4wGVHJoAWg1ClzET4yslxD+TTlumOUh+Jhjucd7ccerokr20FyVJsIcdMnkW
 UspW7b3HtrZUQJ1leX3jUfaa8XaqnS5x88xNMLIZpusHYDkiviHPUqOZhfiEfiChLJ50
 QrAdtNt+E2bsmwDOajcICbWI1sD+kcffK90U4p3h56H7ftVb67JFR59ulldUR4rkOI63
 Wa6/2LVOOYutuziupFW21gvxVTC2UvpCZVYxQ7IO3mmWNIVJFjCSN+aw6VuKSMPlyVbS
 msgg==
X-Gm-Message-State: AOJu0YygD8vU5D2dVheWNeLdNBr1n/tuDmMX1HsyTPCZZCrQf/Lbw6f7
 TGhsTZe+hyjg+PzdP33Xphwc3jmw6+wjcgHN7mY0F491nsHdlUn5E5q9CS3ZJJJzQcKe3l9zyyT
 uquZL+Ji3hpEsJjKXPR8A++s/yHhad49cIm1KH4158W0apzwuxSBpJ7f2y25/tOupj+h7kSlLY4
 I0tKkCI5NqltBP7XZwsGDYfQJ8+UtfF/E24xCpPQ==
X-Gm-Gg: AY/fxX66vTrnXwglCsPSma4duAGZqPQxTUjTGA91IwvWHkuGHNpsbajq+sRxJfEBYPy
 +/u4xDwFT8dJ7SGbI+L/fbGpAOueLoP7Rl5ftUY6DjfED61Hjc/Leq0cgb+B6jdFcfl0tyVxB/t
 FQf7XQhvXJwdJgJfwQ3pD0n4d/VdpagXPd/QEh4ekm1y6fv2iY4N/L2e7oncbauHxXYkxgujnOv
 vaZfVUSqd1rY0jpv4Hc/6P/ntOWijIns1DzRxb1n0Di2iupkUyPUBoNeZVpLv3P2WqPG0CXIMxm
 Cmzliwv+QHurebBVcHD2YE01U52bfDzlb9pmwtyEGjkJvMSpNekM03zPIQsmdfuQfDwGhjuhEvz
 +
X-Received: by 2002:a05:620a:25d0:b0:8b2:eea5:3325 with SMTP id
 af79cd13be357-8bad3fafe5dmr2239878385a.14.1765831944079; 
 Mon, 15 Dec 2025 12:52:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEAyF4WCTaqPMSxxh76gAvuOjJd7gboiCINJudabLIO39fPUVgu3anrIUW+SzJ+XQUeNq3eeg==
X-Received: by 2002:a05:620a:25d0:b0:8b2:eea5:3325 with SMTP id
 af79cd13be357-8bad3fafe5dmr2239874185a.14.1765831943612; 
 Mon, 15 Dec 2025 12:52:23 -0800 (PST)
Received: from x1.com ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8899ea3621bsm58726236d6.36.2025.12.15.12.52.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Dec 2025 12:52:22 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, David Hildenbrand <david@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Chenyi Qiang <chenyi.qiang@intel.com>,
 peterx@redhat.com, Fabiano Rosas <farosas@suse.de>,
 Alexey Kardashevskiy <aik@amd.com>, Li Xiaoyao <xiaoyao.li@intel.com>
Subject: [PATCH v3 12/12] tests/migration-test: Add a precopy test for
 guest-memfd
Date: Mon, 15 Dec 2025 15:52:03 -0500
Message-ID: <20251215205203.1185099-13-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251215205203.1185099-1-peterx@redhat.com>
References: <20251215205203.1185099-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

Add a plain tcp test for guest-memfd.  Note that the test will be
automatically skipped whenever not supported (e.g. qemu compiled without
KVM, or host kernel doesn't support kvm, or old kernels, etc.).

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tests/qtest/migration/precopy-tests.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tests/qtest/migration/precopy-tests.c b/tests/qtest/migration/precopy-tests.c
index 57ca623de5..88d2627efd 100644
--- a/tests/qtest/migration/precopy-tests.c
+++ b/tests/qtest/migration/precopy-tests.c
@@ -215,6 +215,16 @@ static void test_precopy_tcp_plain(void)
     test_precopy_common(&args);
 }
 
+static void test_precopy_tcp_plain_gmemfd(void)
+{
+    MigrateCommon args = {
+        .listen_uri = "tcp:127.0.0.1:0",
+        .start.mem_type = MEM_TYPE_GUEST_MEMFD,
+    };
+
+    test_precopy_common(&args);
+}
+
 static void test_precopy_tcp_switchover_ack(void)
 {
     MigrateCommon args = {
@@ -1276,6 +1286,8 @@ void migration_test_add_precopy(MigrationTestEnv *env)
         return;
     }
 
+    migration_test_add("/migration/precopy/tcp/plain/guest-memfd",
+                       test_precopy_tcp_plain_gmemfd);
     migration_test_add("/migration/precopy/tcp/plain/switchover-ack",
                        test_precopy_tcp_switchover_ack);
 
-- 
2.50.1


