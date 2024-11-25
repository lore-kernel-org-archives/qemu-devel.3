Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2399DD59D72
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 21:24:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFgY4-0005EZ-Nr; Mon, 25 Nov 2024 16:23:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tFgY0-0005Cq-Iq
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 16:23:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tFgXy-0001Ew-5Y
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 16:23:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732569785;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nYEm2RS0ZdPoce+9zYia6MkhA7x3IFwCIT7jee4PpQ8=;
 b=hTarZWUy2Y4sH68UO7wCFHK3CC8yzXBt5iCRwysrxqvC0sg2y7+c/B6yfGebUXp4n60eXx
 p70ZGv1DWCvdlHLo6oZ/jTJY+LuA32pv3Uw/M8ZfnRgi2a4AgSOkOuFMMcYYB5j/Z5LSKk
 QtKkUGSKrnbb/YJa6wD9U8aYQDXbiOo=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-189-UimHkIpRPbCatpeoJDGlRA-1; Mon, 25 Nov 2024 16:23:03 -0500
X-MC-Unique: UimHkIpRPbCatpeoJDGlRA-1
X-Mimecast-MFC-AGG-ID: UimHkIpRPbCatpeoJDGlRA
Received: by mail-io1-f70.google.com with SMTP id
 ca18e2360f4ac-83aed4f24a9so536067239f.0
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2024 13:23:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732569782; x=1733174582;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nYEm2RS0ZdPoce+9zYia6MkhA7x3IFwCIT7jee4PpQ8=;
 b=SD+4mF0j82D4i1a1dwvLgDjSyLB32WYbeAenWpupdDnsyaFEyrznnerXjuNO43RASy
 MQ7Lh6lptsy6fbA60SiRx5WF7kkmJYZELcJnH3+tufnzK6M98GpZbrck97YtIAJNRbXN
 VFD2axoeYzKwmG9+Ki949yqVqp0Oip6Bu8P5gHz/tN5M1x2JGtrdzeuqjgCPwApOA9DU
 oAWaweZLCbgMYQ34Ane4ZGRoLmvCIgB0ra3Rn+xelpW11hvhB+pozp5MQC186WqK8gkF
 //vBd7ccpGTJLv877tW5fIpOX/iy/6UvIsmboXxKVopJNYiuS5SsNnw0hVoqJzmAmo0w
 f5+g==
X-Gm-Message-State: AOJu0Yw+jBiiOXCzdpcUjw/x0vxfIkCLVNmjGnRGyHTOSakxLnS4e8qO
 +r7w7c776H2wSB8xK/n10rnYUWMBnGAwPOMoRXIkWZyeu1j8hHIz+zJiauGUQtflQJKxahtBTBS
 8VW8lyOiA2s9o9jyB917dFTPOiaIdLfk3HVkz3w/B6sjn0WrPRLRMq8QJK7SUyOSr20PdZ1sqW4
 9JzPEogaG1y9S8I8kadVTTXKeWerKt0gBjug==
X-Gm-Gg: ASbGncvqdbI69tEonRZoER5fPCaFDm1dfXVbO3jI+fEfmn2WJoYidhUceNFb+KyDfM4
 31v1cTNxRhGsrfnt9+zaqzJc4zHUSwpkrptmBus4nqNREz+pTH4Z8DFq92myNY8+9hmEpGUY1aP
 2DJBx/0fj0s3EqGmzSjd9OkK3yrFiDMiBcd69zeAxVk6gt4mDaoPSk8uyLz2BforNT7zyRmMmpC
 fw3oeIK+irvLecMXgX1fyYeSVvGY+SWiXzUb8PBWlVC1ZZgxViGwudY+BSnrKiDvg0hL/SWgZkB
 t8urUXsh7uNUYARcngjjWALgQQ==
X-Received: by 2002:a05:6e02:190a:b0:3a7:93af:ef55 with SMTP id
 e9e14a558f8ab-3a79ae9d90fmr163556505ab.12.1732569782250; 
 Mon, 25 Nov 2024 13:23:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFgxBz6BuTxRidWxxJIf/tKEF6QwyeLUUatw5X4RQ1J+GuEJjqnqJFN9xBEjBD5kyDjGbTLQA==
X-Received: by 2002:a05:6e02:190a:b0:3a7:93af:ef55 with SMTP id
 e9e14a558f8ab-3a79ae9d90fmr163556275ab.12.1732569781877; 
 Mon, 25 Nov 2024 13:23:01 -0800 (PST)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a79acb7b6fsm18989815ab.67.2024.11.25.13.23.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2024 13:23:01 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Peter Maydell <peter.maydell@linaro.org>,
 peterx@redhat.com
Subject: [PULL 2/2] migration: Fix extra cleanup at postcopy listen
Date: Mon, 25 Nov 2024 16:22:56 -0500
Message-ID: <20241125212256.62608-3-peterx@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241125212256.62608-1-peterx@redhat.com>
References: <20241125212256.62608-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.93,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Fabiano Rosas <farosas@suse.de>

After fixing the loadvm cleanup race the qemu_loadvm_state_cleanup()
is now being called twice in the postcopy listen thread.

Fixes: 4ce5622908 ("migration/multifd: Fix rb->receivedmap cleanup race")
Signed-off-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20241125191128.9120-1-farosas@suse.de
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/savevm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index f4e4876f72..98821c8120 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2057,7 +2057,6 @@ static void *postcopy_ram_listen_thread(void *opaque)
      * got a bad migration state).
      */
     migration_incoming_state_destroy();
-    qemu_loadvm_state_cleanup();
 
     rcu_unregister_thread();
     mis->have_listen_thread = false;
-- 
2.47.0


