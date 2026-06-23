Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF5E9CDB479
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 12:49:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wc0YO-0004VH-Rh; Tue, 23 Jun 2026 08:48:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wc0YL-0004Ua-1Z
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 08:48:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wc0YH-0006zF-G8
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 08:48:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782218906;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H2BVHPyZHE2bjo0Z0lXNm9ZRKJa09Goy2Jb1Na43N7s=;
 b=ExBiTYyrRcSV5OXVnog55iclWfDbXnyeK7Bx+LTdzngFYbk8RAhvBPbWoqnG9ZXtwrN6q3
 DnC4egcUKsQ2zMkl2uVMWDhtmkGICpuUdvb6sfpNY7bbQw2IDxjjblAJzGJtsJ2yqezFSY
 Z82cOM5EOpZp5IyEEx/l8J7XDPg0kjI=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-500-ir7RCOLGO1GQ_BVtpSOTEg-1; Tue, 23 Jun 2026 08:48:24 -0400
X-MC-Unique: ir7RCOLGO1GQ_BVtpSOTEg-1
X-Mimecast-MFC-AGG-ID: ir7RCOLGO1GQ_BVtpSOTEg_1782218904
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-517c65c019bso140801591cf.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 05:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782218904; x=1782823704; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H2BVHPyZHE2bjo0Z0lXNm9ZRKJa09Goy2Jb1Na43N7s=;
 b=hsX/nrBhgrVwyOGinMaN2qo10nxzPTLZLiDRqGvy85B+7vfKnV9hESQNtcWSfjM+zU
 62sZL0q/HcoPH5wAIh6BvJ7QOyZv9WVCRPS9lZZxijZ7gW7x2ELGjpQ47I0ry2zhioWI
 3jLmC6AVcbFNp9VZunsIdqNKgHqRM7b8t56zyHL43n32Poj3ia/5WHCCe11P5yAkpPpQ
 RuSCUR60wr31UHfwVV+Atp4hvexzK82ebrTnK8lnZygc+a4Zn9JAc7mJz3lUaUqnnvrj
 bTEu3oVOte7a2Cel74DHN5opOpD6EbzutYX5TPc0hOJ2WFR1njwPgKk6sLqhfRLpcrIo
 ku3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782218904; x=1782823704;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=H2BVHPyZHE2bjo0Z0lXNm9ZRKJa09Goy2Jb1Na43N7s=;
 b=o7cyPAJeMjZXHhxWs5onX9aniwz1/ybAO8apqlqcnfszBqQa9fnQ6DB5iSZedYi3Ms
 NuqroL9Qyql8aBzBE4FW912vNVEqLyxvl1lKDnV/48WVmWe1v8Vs1dep7ufZ4Y/RMfXv
 dud16+2gyvO/EeTQhLBz7oH6Q1U+fbdcGXNYbTf976rXGL/biRsRvO5u6xeNOy+dhn/E
 i9A6nl4bUPe03+++d6nLns0AtRAfxfy66IOWwB06D4/FJV8DGJ6ZCPdZhyFVB1Jmc8Zm
 N1cVE5ACzIHqpZZceeREsvPpqgs7U6kx/28YeZ1Qc8TjXulPtnxmlrrj/FqLfry4i0Hy
 GXqA==
X-Gm-Message-State: AOJu0Yz3V8bghQNhYIAGvwffqET9VKder9HDIk2b6v2tIrIZUaZ/JD01
 Gtf7d6k8TfeI1MZiFBwFcLUC593kPnbnFEkJ6UBzQ8GbAwRI2VaFyTzFFfmih4wROogaBeMhI5E
 l09k+sdX4vJdlzvti2Cd2HSX4RX9+vW/GQUSZKlErHUkO/fR7uemvIG77P8mbDTAOw0AjybPvT4
 4bI5llyzY4r9UmGrOFBMfDvVue94yI6fDzndHf8A==
X-Gm-Gg: AfdE7cmBvPL2Crywbmfs7AuGSXKjVPqXb75fKR6RZqb45hZDDXCglhGxJOnGliuL3aM
 8KhiR0crl+Ou3oM1TpBmZmD6Bu1ltumOJ4bgeDvoHKJrryNdt29FXjU9eRxTcm/YNJ2pPmHpRYh
 vNs9SfATIVf3P1DaMuF+XzwhNZNoI08wjvDLfIJvhviSiyX0NrqwOkDDFbaNJQ6iZvAl6WXcCBM
 NRPcfuyLx76o8dYRa4di2k5lOlL1QLXflbD1Z/diwiwSye/9hYZ/imudItSnVRHz3n1vIcc6DA+
 yXLMJxjxAsEWRy+PWuyEk/tdQPgfx9N0Zhpbd4hE3kvDTEsobj41qF5t5dWhmOLf73HI+WroR5r
 CtA==
X-Received: by 2002:a05:622a:1a97:b0:519:899a:9b9a with SMTP id
 d75a77b69052e-51a562828f9mr31596001cf.51.1782218904068; 
 Tue, 23 Jun 2026 05:48:24 -0700 (PDT)
X-Received: by 2002:a05:622a:1a97:b0:519:899a:9b9a with SMTP id
 d75a77b69052e-51a562828f9mr31595311cf.51.1782218903326; 
 Tue, 23 Jun 2026 05:48:23 -0700 (PDT)
Received: from x1.com ([174.91.117.157]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51a51106a09sm22288351cf.0.2026.06.23.05.48.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 05:48:22 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, Gavin Shan <gshan@redhat.com>
Subject: [PULL 04/18] system/memory: Remove MAX_PHYS_ADDR
Date: Tue, 23 Jun 2026 08:47:45 -0400
Message-ID: <20260623124759.125399-5-peterx@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260623124759.125399-1-peterx@redhat.com>
References: <20260623124759.125399-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Gavin Shan <gshan@redhat.com>

Remove MAX_PHYS_ADDR and MAX_PHYS_ADDR_SPACE_BITS as they're not used
since the addition by commit 052e87b073cb ("memory: make section size
a 128-bit integer").

Signed-off-by: Gavin Shan <gshan@redhat.com>
Link: https://lore.kernel.org/r/20260608002303.851456-1-gshan@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/system/memory.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/system/memory.h b/include/system/memory.h
index e143c9c3f3..582de45c34 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -36,9 +36,6 @@ enum device_endian {
 
 #define RAM_ADDR_INVALID (~(ram_addr_t)0)
 
-#define MAX_PHYS_ADDR_SPACE_BITS 62
-#define MAX_PHYS_ADDR            (((hwaddr)1 << MAX_PHYS_ADDR_SPACE_BITS) - 1)
-
 #define TYPE_MEMORY_REGION "memory-region"
 DECLARE_INSTANCE_CHECKER(MemoryRegion, MEMORY_REGION,
                          TYPE_MEMORY_REGION)
-- 
2.54.0


