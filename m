Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD390C3600C
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 16:08:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tx6og-0004qC-Qy; Tue, 25 Mar 2025 12:07:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1tx6oW-0004b7-QY
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 12:07:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1tx6oQ-0007TX-GR
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 12:07:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742918853;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MnjO46yBMjBY7w7qvkXPVZdDLv00zM5re/ygX/F9v4g=;
 b=TVA2HpEv2uX2SrHyJjuWaJznoGHpXg3T9++Qwmvo0OAhVnEpH3pcfzQyCtq1D/+hxZ/Fpw
 m3ZqIKu1tLD0cRaRPxCpmuCBHzE4Umn9AU3meqF9O0TmTaITVSt746KMri9mrcxzHbExkj
 EjqlgJWAIg23l7qlCHVNHCbuEr/aVvk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-363-GuwkQrU1P5WaN0-HW6SaOA-1; Tue, 25 Mar 2025 12:07:31 -0400
X-MC-Unique: GuwkQrU1P5WaN0-HW6SaOA-1
X-Mimecast-MFC-AGG-ID: GuwkQrU1P5WaN0-HW6SaOA_1742918850
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43ce245c5acso70113475e9.2
 for <qemu-devel@nongnu.org>; Tue, 25 Mar 2025 09:07:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742918850; x=1743523650;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MnjO46yBMjBY7w7qvkXPVZdDLv00zM5re/ygX/F9v4g=;
 b=X3Mjq9wutcew25IYpeAN24MJxEggpswSk9PbJERItmuuwkIAGKnTrwsew9yDbvSMDa
 vUjo4H3j5BQTWK4Ui8f/Xh6vrBzNu/QNeyu9ThL3pmJDDv9yuZ8MkV1LSegs6lFda0vt
 6iSnQRy4xGWlJaydd4TjJysr1MCKpk3rZCBjokDzcNSquaYG62xLDDetGiz+4++meEu0
 pG+Hr65+JIEGRnXoqpNygiug86sjfHP0UfH9JVPP4/olM52ry503zQL3wsoL9nO6CnaE
 EUDzda38V4j1bDCwSw/CxT6ykWET3pbf10ZVJmaBvWFmj03BCcuO5ZlAF8EQQLIpHocM
 D+Og==
X-Gm-Message-State: AOJu0Yz7rN1by/ibxC5Qp80yqTQR3xYHZJM3YfeTiJFplvdtmwYojgpM
 UeuvWIeteYvcagKqKSuJ0/VveZ+1UEOaCcwJrotS2Zr+5vu1MAoYYp+5ao9XY5j9eivMikzK5v4
 oiNJp0bXz4Z++IljuGpw+KSY1OVU35LL2EvZgCq4H8/eSI7t019Tl
X-Gm-Gg: ASbGncvqfungQFqVbIucquNNQUFo5mFLyQkOz1b8VD+98f9UfcxBvJqQfzZQuBTaOhW
 CF8Ksnzy3ouWMgZwFF3zoRz9FiHLdQ6A+QtEHSUDN+b60MD+ipI3gLMpLZHi6MdF/jL8nGTcohF
 LLByOtTFsxeF5PXd5q2w/H2Yoxpa9FPlIn0AznArjwNJF90FfCLGPqBEEvxqBXyL/d2q6MEw6Uq
 eb1wXf4sm1XIx/sj0fa2xddM1K4iPLyINq15+6MlHBolJJWdjLaRs+qC1mbjwDhJmW2/VZ/eBaE
 OZYgASdSxbva03J4dGaQBXg8uQyNZt06bIYiZZJflY9gItLOeGEXeFSakp56MC5J5jbxhaC55g=
 =
X-Received: by 2002:a5d:6d88:0:b0:391:29f:4f70 with SMTP id
 ffacd0b85a97d-3997f8f9259mr14403716f8f.3.1742918850003; 
 Tue, 25 Mar 2025 09:07:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGRKCCR7ui2hJfXVn80b2WgwZpO4zJA34xs25wUxnkWi9wEU8Ex++uETTJPfRX5Qh7/grq0uA==
X-Received: by 2002:a5d:6d88:0:b0:391:29f:4f70 with SMTP id
 ffacd0b85a97d-3997f8f9259mr14403667f8f.3.1742918849486; 
 Tue, 25 Mar 2025 09:07:29 -0700 (PDT)
Received: from localhost
 (p200300cfd74f9db6ee8035b86ef736e5.dip0.t-ipconnect.de.
 [2003:cf:d74f:9db6:ee80:35b8:6ef7:36e5])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9a325csm13976955f8f.22.2025.03.25.09.07.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Mar 2025 09:07:28 -0700 (PDT)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Subject: [PATCH 12/15] fuse: Reduce max read size
Date: Tue, 25 Mar 2025 17:06:52 +0100
Message-ID: <20250325160655.119407-11-hreitz@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250325160529.117543-1-hreitz@redhat.com>
References: <20250325160529.117543-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

We are going to introduce parallel processing via coroutines, a maximum
read size of 64 MB may be problematic, allowing users of the export to
force us to allocate quite large amounts of memory with just a few
requests.

At least tone it down to 1 MB, which is still probably far more than
enough.  (Larger requests are split automatically by the FUSE kernel
driver anyway.)

(Yes, we inadvertently already had parallel request processing due to
nested polling before.  Better to fix this late than never.)

Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 block/export/fuse.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/export/fuse.c b/block/export/fuse.c
index 407b101018..1b399eeab7 100644
--- a/block/export/fuse.c
+++ b/block/export/fuse.c
@@ -45,7 +45,7 @@
 #endif
 
 /* Prevent overly long bounce buffer allocations */
-#define FUSE_MAX_READ_BYTES (MIN(BDRV_REQUEST_MAX_BYTES, 64 * 1024 * 1024))
+#define FUSE_MAX_READ_BYTES (MIN(BDRV_REQUEST_MAX_BYTES, 1 * 1024 * 1024))
 /* Small enough to fit in the request buffer */
 #define FUSE_MAX_WRITE_BYTES (4 * 1024)
 
-- 
2.48.1


