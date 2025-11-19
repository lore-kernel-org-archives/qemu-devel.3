Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AD2DCF397E
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Nov 2025 17:30:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLm04-0003BM-9E; Wed, 19 Nov 2025 12:29:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vLlzp-00031a-9Q
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 12:29:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vLlzm-0004Pj-2H
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 12:29:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763573369;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8LRdt+/CQiyd/RiqOaKeRjP93SY+POOdomSS9E7DfjY=;
 b=JAFrscHUPJDstiG5wtH4IV/+Q6SPQ8iMPFs40J+J8GQh+vNr6y3Ks9GNbp7nhiluAs71PR
 yEMwLItH/SRCyjZP8PthX4xdubRMjzfzO5uM3zSjyN+wktUhfQYNkTfdcQPsF/ZIUmVrQ1
 6uPNDSOUjXCixpr8RLOJtCqdHixNz3s=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-262-zosGknqNNA69M4f18179og-1; Wed, 19 Nov 2025 12:29:28 -0500
X-MC-Unique: zosGknqNNA69M4f18179og-1
X-Mimecast-MFC-AGG-ID: zosGknqNNA69M4f18179og_1763573368
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-8a5b03118f4so349463585a.1
 for <qemu-devel@nongnu.org>; Wed, 19 Nov 2025 09:29:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763573367; x=1764178167; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8LRdt+/CQiyd/RiqOaKeRjP93SY+POOdomSS9E7DfjY=;
 b=SCQYtY+sLY3bqgt5mNbeFuUUvDjjZk5bocXVKctHUZE8FldikfwH2RGK17hLBNEpnf
 9vS62xozpfVhtdqGCNVfsV5oyMW/a3w0EhiPoY3rPr1780ImSlxjDbDZE+ztBnaA7fVV
 JxQ1sDuZHkoqueJskf3pWE5eXgFgNY/V9ZpunRvKvejdGtMqG6VX63KJpfrACa2vt7jC
 mpyh9qTh21H1KmlL+Im/mPiTuXIr13Bsc1lUgpgMLji27ho4vcSp3ikLxisZSDb5J84S
 M9MOFDlojtBHOmga0b1Q8MjRiiWAsD9zQNA5nlkOPhNlK01Af98Wh1Au2VQ/EUseVXVj
 fk1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763573367; x=1764178167;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8LRdt+/CQiyd/RiqOaKeRjP93SY+POOdomSS9E7DfjY=;
 b=RZYDPcJaEH66c07DXj8uNiamix+J9gF1qrEFMWLc5mqkFWb/0070MzUIcrQla1bDpO
 sVQxSJaCIg2wLncyCi1tEnYTqtQmna0srtMvAuefPcKNh9N9a7y9jXoF5p7/vJ3dfIIH
 h8sUASs3AnAzFspWY7s65YxnZAPxmTI7twogiP9WzCxg8AygOOSNZEwvrXcKW7u+/xkd
 hFFTqSe4xxg/Ep4CGo2tZ7tCaU2wXU/Czt3NoIipLRm7bW2DfyQWZKQG6gPDyo0LW7iX
 w5SB28UERGdYIjWk2F5unhTLNqE5S9U0Avlj4+byas7MeizGUEXwL7PvcQFioYmOogAy
 +cHw==
X-Gm-Message-State: AOJu0YzgeBue73gfK6FOpZ+TmcGMzwXCj1vCB5/C2Rv2WXU7epnVwk/h
 ubXKl/9NCx6pC6dLoTbqJGNz2zLKs7kLuulJspBKuNVb6xM3XVPTt/e7SiT1GZVFd137iniw+nS
 TRES1mGSJCmzsJ68rd0aAKIyNOxxHqhqonfI4B2DbdQcBq2+Nk7VdBt7lrZBZ/1qE2t+tNMGXMC
 6a11Ta8RmnGEU7cuNzGflGPkMQBfrnG4TrMseB6A==
X-Gm-Gg: ASbGncuOmZHLPDUoD9T+sw2mXUEehe8SZ/5PPGChhwj0tsnFWEgDT9vIF7JVV93pD9u
 9iVWpc8VFEz0H5nO1mWsa4DWu2glKuL+Dt6qUZLIri0TNZH0Z/F8S0eM4UTIjaDvgTBvkiZkz46
 AgBsuOJnrK5ei8n2vJuLVtvjzqw860/yrGA+biAE9LguOdJZM7X4wijIApFIF26waMdP6MqEeeO
 sObUhIAah1UNbKOtuF6pW0fIR561rj0CjIbFlIZwkmjJpmTHxx6xsIynE9B/QKmyZ8SnW3RUd10
 1hCdMlbLRwDB+LAQOnmfE+7kY2UN9TGnMdw+kXjPo10+PrPrUMafXgw9Go7sr/w5Rg2aTmOPhE7
 a
X-Received: by 2002:a05:620a:19a1:b0:8b2:eebc:64bc with SMTP id
 af79cd13be357-8b31824d52dmr502022185a.35.1763573367398; 
 Wed, 19 Nov 2025 09:29:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGXVEBdcFMR3WZ1/JVFaDBaTSGWRg4nE21vY8bbvEdpxJpddHaeEZcul5FdnviirK7Efb5iyg==
X-Received: by 2002:a05:620a:19a1:b0:8b2:eebc:64bc with SMTP id
 af79cd13be357-8b31824d52dmr502017185a.35.1763573366801; 
 Wed, 19 Nov 2025 09:29:26 -0800 (PST)
Received: from x1.com ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8b2af042c9csm1444759485a.46.2025.11.19.09.29.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Nov 2025 09:29:26 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Alexey Kardashevskiy <aik@amd.com>, peterx@redhat.com,
 Chenyi Qiang <chenyi.qiang@intel.com>, Juraj Marcin <jmarcin@redhat.com>,
 Li Xiaoyao <xiaoyao.li@intel.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v2 9/9] tests/migration-test: Add a precopy test for
 guest-memfd
Date: Wed, 19 Nov 2025 12:29:13 -0500
Message-ID: <20251119172913.577392-10-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251119172913.577392-1-peterx@redhat.com>
References: <20251119172913.577392-1-peterx@redhat.com>
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


