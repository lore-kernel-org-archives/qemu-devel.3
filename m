Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0265BCAC5B0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 15:49:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4huV-0005Br-UY; Fri, 03 Oct 2025 11:41:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v4hty-0004qo-EY
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 11:41:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v4htS-0007eI-9d
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 11:40:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759506020;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gS7GKrXQ0RI9MMwftvQMZVK+iKaAD+p1YwZsewNeUdA=;
 b=f+GUzjBKM5kEpd4in2BIq1ya+oHJfcQxwD9HhNHr3pBHP9d+5uFBvNn0ttBtWNnBT6a6eY
 /80qtKqW62+FGL/jJAS3POFlddH00eR6RRv9y8ub/2gWxqH+cU0kUPXcZbpUReyCrj9Cj9
 aElvo9nw/eAXKPJ0d/oNpkY8GnsLudk=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-ZZMl4DDNMwKp6G9jg_T4jA-1; Fri, 03 Oct 2025 11:40:19 -0400
X-MC-Unique: ZZMl4DDNMwKp6G9jg_T4jA-1
X-Mimecast-MFC-AGG-ID: ZZMl4DDNMwKp6G9jg_T4jA_1759506019
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-70d7c7e972eso46661166d6.3
 for <qemu-devel@nongnu.org>; Fri, 03 Oct 2025 08:40:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759506019; x=1760110819;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gS7GKrXQ0RI9MMwftvQMZVK+iKaAD+p1YwZsewNeUdA=;
 b=orGEdIxNH0xKlejN9eLEHcgVcpZk0yrNZlxfuKRaNiVwt6L5lsjvDx8rEIAFFoXQbV
 rNIR0ggDXxbhmXXQuT4DsR3y8PoHkimLHro6Ote8qvvS5TLp2N/GlWkuFvGnXZd+MX18
 bK82V5scz414RAXA19bzB0XEOD8WwhQV8X38JL4XZ/Yl5GbecQkDCE2Dav6k+PP0a/gy
 NhV0KFv6OarYpob09mJNtIusKPvzufi5PhOrCimnc3rgNXvtRHj04SAArLAZXNOq+wPg
 swid02dVUuI/TckHMFdNGEmkdDzefG9HcrPu167cXOE/nyyUsViBhEAEoxoibVujWgIz
 KiJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXd3RfSIfStKHbBQAKVqu1vC28MHCWJyqhpgQyfcc2XHyG9FvwxncI32uIkShoitfX4yizDkJGsGarN@nongnu.org
X-Gm-Message-State: AOJu0YzPucYnDrmQGiYFMBMj+RTSz80p+7tA98PctoAnF0DdlAWDpU3P
 c7okUPdR1GHv7ylG5sxNtnmY3GLpYYYJh2EEkjTdQ8vFcXOawxJmfM+/5xo9uG8RAB9H6BdyfG/
 2PQKjhcJ7M76z0BG3NHQZHLbsn5lkEtcqrcpKVJaMQDAyHuKUlwEkOAeJ
X-Gm-Gg: ASbGncsGMTWNaWlq3AUzlq7TGW+iS1c1LGC5mlBa8pRUQApmcv4rHrxEueLiqIIs/BZ
 Ek0BwwkDOnjpJpt6HCG6/LfChX37syClyYjX9sckT9BcEWe/Z3TZoyeqU6wmZ04CEgznZIoj2nV
 mcr+z5DJPbH97flVAHXHmS928xKaATp9ZBmHc3qW1DjNyO3UadzWtg7mpsQLIG7D+cvoTE2QnCd
 RRf1/kOgABr1i3KNOt9+NZDMj4BQHrvM8KNiHg2KiEVk0Zo4CaTcWQwaBz4LQVUXnNox65IrR9A
 ALYmKa/tqc/nQto1U1VbOMQIW3zmgow/vErPHA==
X-Received: by 2002:a05:6214:1245:b0:72a:2cf6:76df with SMTP id
 6a1803df08f44-879dc87f52dmr55158766d6.45.1759506018583; 
 Fri, 03 Oct 2025 08:40:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF0KiuyVYjxRrm9dhR3R/bPv8LmUJVna7b6GGzsn0c5ySZufjdIGrqrEj5kueJEvGknaNnIAw==
X-Received: by 2002:a05:6214:1245:b0:72a:2cf6:76df with SMTP id
 6a1803df08f44-879dc87f52dmr55157156d6.45.1759506016920; 
 Fri, 03 Oct 2025 08:40:16 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-878bb53d91fsm40656746d6.23.2025.10.03.08.40.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 08:40:16 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, peterx@redhat.com,
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Arun Menon <armenon@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PULL 17/45] migration: push Error **errp into
 loadvm_postcopy_handle_run()
Date: Fri,  3 Oct 2025 11:39:20 -0400
Message-ID: <20251003153948.1304776-18-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251003153948.1304776-1-peterx@redhat.com>
References: <20251003153948.1304776-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.467,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Arun Menon <armenon@redhat.com>

This is an incremental step in converting vmstate loading
code to report error via Error objects instead of directly
printing it to console/monitor.
It is ensured that loadvm_postcopy_handle_run() must report an error
in errp, in case of failure.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Arun Menon <armenon@redhat.com>
Tested-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Link: https://lore.kernel.org/r/20250918-propagate_tpm_error-v14-17-36f11a6fb9d3@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/savevm.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index ce88f56498..f7947160fd 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2273,13 +2273,13 @@ static void loadvm_postcopy_handle_run_bh(void *opaque)
 }
 
 /* After all discards we can start running and asking for pages */
-static int loadvm_postcopy_handle_run(MigrationIncomingState *mis)
+static int loadvm_postcopy_handle_run(MigrationIncomingState *mis, Error **errp)
 {
     PostcopyState ps = postcopy_state_get();
 
     trace_loadvm_postcopy_handle_run();
     if (ps != POSTCOPY_INCOMING_LISTENING) {
-        error_report("CMD_POSTCOPY_RUN in wrong postcopy state (%d)", ps);
+        error_setg(errp, "CMD_POSTCOPY_RUN in wrong postcopy state (%d)", ps);
         return -1;
     }
 
@@ -2626,11 +2626,7 @@ static int loadvm_process_command(QEMUFile *f, Error **errp)
         return loadvm_postcopy_handle_listen(mis, errp);
 
     case MIG_CMD_POSTCOPY_RUN:
-        ret = loadvm_postcopy_handle_run(mis);
-        if (ret < 0) {
-            error_setg(errp, "Failed to load device state command: %d", ret);
-        }
-        return ret;
+        return loadvm_postcopy_handle_run(mis, errp);
 
     case MIG_CMD_POSTCOPY_RAM_DISCARD:
         ret = loadvm_postcopy_ram_handle_discard(mis, len);
-- 
2.50.1


