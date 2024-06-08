Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2843C27C55
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Jun 2024 08:39:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFrXc-0000gE-1a; Sat, 08 Jun 2024 04:35:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sFrXa-0000fq-8T
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 04:35:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sFrXY-00004t-La
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 04:35:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717835708;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H3Z1uEV2vKX54vq7GANVQvFh33xm6QoUk8aodvBPmZQ=;
 b=BeLuE2yjBTsFSc6EPQ4d59gUpbneFlaFu6oT9C3YYDb4JAIxo0omGuV07YkMiUg0fZKYDl
 boPqZQd4BfKFAgIMrOcusmX+OPehcQXZFaTFsvFaVQjDRMhZMuAmTgEvOtamK5zfH+mHmM
 rlu6rrwY/dHpCbVimeMGyBrYe9MwCi8=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-139-b4ZLNAaEP3aEVNn_BV75lw-1; Sat, 08 Jun 2024 04:35:06 -0400
X-MC-Unique: b4ZLNAaEP3aEVNn_BV75lw-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-57c5d26a2d4so612038a12.3
 for <qemu-devel@nongnu.org>; Sat, 08 Jun 2024 01:35:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717835704; x=1718440504;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H3Z1uEV2vKX54vq7GANVQvFh33xm6QoUk8aodvBPmZQ=;
 b=NTwwPowAFSqO8b5o70Syo8kTdKZHFBWoeLjjcUBNdkf3Yuq6PP4zoYhuP0dY2cWuZk
 cXQ7dJ4+/IuQAHMcMMhEdosjHZsM/vmkE4HyDFShWR7rJyoGdYBgNI4n7+qnegP2hIVl
 WXZBE3SJBekJiD1t8BeTFO+Zvf8Z228tXi6Y2LFP66/VNQ37VQKS4XTcOcHQPE43AQs3
 7VgWu+hFRdPLch8tThuYXym7l1BXWL6d/g/scus76ujsyxh0m/udV1G9jybasyXiaAhu
 Wbk4GZPgxokXDTXyrv9PVdfKF2n8Cwy08pYCN8yzcPV/tjVikPS9uQx1vwlNJFf8CG7X
 z2jg==
X-Gm-Message-State: AOJu0Yza5F/70hlvYMeetn8RIytR0ycUMpUv1XDME5Vca6B/J+Fk0fJa
 9Jcz+YoRxokD8dGmmEm0XsOXtK4s4BJaX5jgsALpZEF8AGSGucRoQ4gcgGXoZF7Mc7YgTQ1Me40
 KfGxoPoDqWQQRvW5LztW8nE+7XqPcrIItS0MaHVJpFZT/YRBkSwOgJ/T5irFakNUpVPrqvjk2AK
 Jpt2yC7OKpbH5AJAoFhfm3Hr5QZ/BDo36/88wr
X-Received: by 2002:a50:c347:0:b0:57a:9405:786a with SMTP id
 4fb4d7f45d1cf-57c5084faa5mr2729945a12.5.1717835704377; 
 Sat, 08 Jun 2024 01:35:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFklPSQNTUKJcCSyYdZ7sYzBJxjnl6ofsHEFQEZUE39acSWehbXfVqDdQvZCZ5wHf3AEc4YzA==
X-Received: by 2002:a50:c347:0:b0:57a:9405:786a with SMTP id
 4fb4d7f45d1cf-57c5084faa5mr2729936a12.5.1717835704004; 
 Sat, 08 Jun 2024 01:35:04 -0700 (PDT)
Received: from avogadro.local ([151.81.115.112])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57aae202396sm3970434a12.74.2024.06.08.01.35.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Jun 2024 01:35:02 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Michal Privoznik <mprivozn@redhat.com>
Subject: [PULL 17/42] meson: Don't even detect posix_madvise() on Darwin
Date: Sat,  8 Jun 2024 10:33:50 +0200
Message-ID: <20240608083415.2769160-18-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240608083415.2769160-1-pbonzini@redhat.com>
References: <20240608083415.2769160-1-pbonzini@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Michal Privoznik <mprivozn@redhat.com>

On Darwin, posix_madvise() has the same return semantics as plain
madvise() [1]. That's not really what our usage expects.
Fortunately, madvise() is available and preferred anyways so we
may stop detecting posix_madvise() on Darwin.

1: https://opensource.apple.com/source/xnu/xnu-7195.81.3/bsd/man/man2/madvise.2.auto.html

Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
Message-ID: <00f71753bdeb8c0f049fda05fb63b84bb5502fb3.1717584048.git.mprivozn@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/meson.build b/meson.build
index d80203f1cde..ec59effca26 100644
--- a/meson.build
+++ b/meson.build
@@ -2556,10 +2556,16 @@ config_host_data.set('CONFIG_OPEN_BY_HANDLE', cc.links(gnu_source_prefix + '''
   #else
   int main(void) { struct file_handle fh; return open_by_handle_at(0, &fh, 0); }
   #endif'''))
-config_host_data.set('CONFIG_POSIX_MADVISE', cc.links(gnu_source_prefix + '''
-  #include <sys/mman.h>
-  #include <stddef.h>
-  int main(void) { return posix_madvise(NULL, 0, POSIX_MADV_DONTNEED); }'''))
+
+# On Darwin posix_madvise() has the same return semantics as plain madvise(),
+# i.e. errno is set and -1 is returned. That's not really how POSIX defines the
+# function. On the flip side, it has madvise() which is preferred anyways.
+if host_os != 'darwin'
+  config_host_data.set('CONFIG_POSIX_MADVISE', cc.links(gnu_source_prefix + '''
+    #include <sys/mman.h>
+    #include <stddef.h>
+    int main(void) { return posix_madvise(NULL, 0, POSIX_MADV_DONTNEED); }'''))
+endif
 
 config_host_data.set('CONFIG_PTHREAD_SETNAME_NP_W_TID', cc.links(gnu_source_prefix + '''
   #include <pthread.h>
-- 
2.45.1


