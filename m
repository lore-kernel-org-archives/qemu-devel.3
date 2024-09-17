Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2B65CAC5AB
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2024 21:56:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqgAk-0007GA-9d; Tue, 17 Sep 2024 17:55:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sqgAN-0006fb-J3
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 17:55:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sqgAL-0004t2-Fe
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 17:55:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726610118;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w4/INXL/PVn5TMqQnxTEKZfK/Si8TZmajwPGuc+4jWg=;
 b=b67fgO63h2sce1KVP2b4E0V4sas3bVdpSoEHZgcUuw+X0wI4sH9stgbBJRomgZnvMl1XRU
 6gRne43jBht2Io/3he9nKhAAzxEboxzwY+7ljiJ91rOMIspZfBHmf2utzcBr3AJTGr/KvA
 bNzyGG0WGizW08UNw//Cs6Ae1KPOCKA=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-463-suaYEBHfPOiWrD1SG2zn0g-1; Tue, 17 Sep 2024 17:55:17 -0400
X-MC-Unique: suaYEBHfPOiWrD1SG2zn0g-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7a1d0b29198so1374602785a.2
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2024 14:55:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726610116; x=1727214916;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w4/INXL/PVn5TMqQnxTEKZfK/Si8TZmajwPGuc+4jWg=;
 b=uDPBK6vqXczL+dVKZWDkwl/02pkkjJC+1WGYa8Hd3BY3o91CpoF08FxNdpDSdr3Efh
 qE4WX+eh09UUzmpvviPPp6eIRVnA6y7MdimB6nG4hywvdUzmjNVJ1zXlBBTRQvFQrGP9
 lFxkh9LYkfxT9dGORtCoUs6Z08OtPalpnLXyL7iI4Q4bGjappQ5sVrWb+os329WNX6Af
 bGpPWVJCMTUl/bZajVbfjYDgbMV+Kq1aHqpoQdjmscPiy2Vz7w2M7SxO5F/wOkpb2CyO
 ATno7AlArOr4RWxp0l93EGA5e3iT5jDlSU9vqsgFt5o/oDXeEk3QPmEFZvGlOZUQDQNv
 zkzg==
X-Gm-Message-State: AOJu0Yym+vvg1PnbIFP9cfTKS/lyHsNg4PXfShViS/Kc/KWmgzHltyo/
 gBZFoTHy1XGdMHbhEz8UsNZ9MoYwALd/ivNPhGr1AvGMs2F/c2mtFeQ4FFnmSKZfWyLxSqhtuzn
 EXBMPFTHVWnIQohWIvpAWxyDnju9pCB8LBhV/Vy4uaxkx4g+gpkbU5cYN7QKTPiBltLe37wAfRr
 4HADnH7eSGfNEHMt4WUfgsvq1N8JUemNTVOA==
X-Received: by 2002:a05:620a:4013:b0:7a9:bd68:462e with SMTP id
 af79cd13be357-7a9e5ef6732mr2798297685a.20.1726610116619; 
 Tue, 17 Sep 2024 14:55:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEhtYvqJwDzOTsDK6yi5bgA/PvlgQRsE6/BHv5sXkoub+pWaENuY2uuPMbZ0QGBcc0hpj2Z6Q==
X-Received: by 2002:a05:620a:4013:b0:7a9:bd68:462e with SMTP id
 af79cd13be357-7a9e5ef6732mr2798296085a.20.1726610116249; 
 Tue, 17 Sep 2024 14:55:16 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7ab3e97c9fasm402869685a.28.2024.09.17.14.55.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Sep 2024 14:55:15 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, David Hildenbrand <david@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PULL 5/6] migration/savevm: Remove extra load cleanup calls
Date: Tue, 17 Sep 2024 17:55:05 -0400
Message-ID: <20240917215506.472181-6-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240917215506.472181-1-peterx@redhat.com>
References: <20240917215506.472181-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
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

From: Fabiano Rosas <farosas@suse.de>

There are two qemu_loadvm_state_cleanup() calls that were introduced
when qemu_loadvm_state_setup() was still called before loading the
configuration section, so there was state to be cleaned up if the
header checks failed.

However, commit 9e14b84908 ("migration/savevm: load_header before
load_setup") has moved that configuration section part to
qemu_loadvm_state_header() which now happens before
qemu_loadvm_state_setup().

Remove the cleanup calls that are now misplaced.

Note that we didn't use Fixes because it's benign to cleanup() even if
setup() is not invoked.  So this patch is not needed for stable, as it
falls into cleanup category.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20240917185802.15619-2-farosas@suse.de
[peterx: added last paragraph of commit message]
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/savevm.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index d500eae979..d0759694fd 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2732,13 +2732,11 @@ static int qemu_loadvm_state_header(QEMUFile *f)
     if (migrate_get_current()->send_configuration) {
         if (qemu_get_byte(f) != QEMU_VM_CONFIGURATION) {
             error_report("Configuration section missing");
-            qemu_loadvm_state_cleanup();
             return -EINVAL;
         }
         ret = vmstate_load_state(f, &vmstate_configuration, &savevm_state, 0);
 
         if (ret) {
-            qemu_loadvm_state_cleanup();
             return ret;
         }
     }
-- 
2.45.0


