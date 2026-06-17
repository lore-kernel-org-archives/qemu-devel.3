Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28B85CD98E2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 14:33:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZrIt-0006tL-U7; Wed, 17 Jun 2026 10:31:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wZrIs-0006py-5x
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 10:31:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wZrIq-0007tA-Kb
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 10:31:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781706700;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p4jJwByeLF3gSUl8NugBPEvBMXk9aV8zDdpQ1K1QTDU=;
 b=AdaqHIZd3nizKsjmetKNxisBbjdcKCUGv10vMFZIkrVY6ZxxQirHGon2Giv1FNkoE15Ynw
 Zyu3GlvtlblYVLBhDCeaBOyS8PcAdAmKf3WmAByH1VgKNe+S1iznLTH4j50DEp/NJwXQjh
 5W5I0HZy4F5x+IiFHObEz4dVWbx0Ois=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-186-itvxhKRUOvCzVfP6JomuKA-1; Wed, 17 Jun 2026 10:31:38 -0400
X-MC-Unique: itvxhKRUOvCzVfP6JomuKA-1
X-Mimecast-MFC-AGG-ID: itvxhKRUOvCzVfP6JomuKA_1781706697
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-461e0dad8easo1082229f8f.0
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 07:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781706697; x=1782311497; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p4jJwByeLF3gSUl8NugBPEvBMXk9aV8zDdpQ1K1QTDU=;
 b=fvUvyOn9KBzXVomXqr6y62kDc/if8Gb7cDAD6GqkX2zVTyeaalfq5+Dxplwe14JtsP
 o9K1J/Uuyl9y5jWiV/zVWGbNJZe1b0sJhhRDyVY/5Y6FTuQXglKVogrHR4gJ6EJuHkM7
 FmJFj1/MoIgJS7DxSB7AHKZ+viD7uUZnbTnQvTv1EPcNlBtof2zf7Y8AE1bPfEvwqIG6
 OuBYuDglxRMMYbM1xUy/zGLFcwIusbcW2M022zxPKFFXp3gcY5BE1s/jivTGro2Ins+v
 xDk7wkOum98BQmP60CqGzhTecfaC9aYOOB4mXQKFl2WbAPwNN/8wPAYqtIuUdj6yVFUE
 MkNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781706697; x=1782311497;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=p4jJwByeLF3gSUl8NugBPEvBMXk9aV8zDdpQ1K1QTDU=;
 b=MarhtxFHWS/jSRXkLmwliGCZC1U7WXixyRHjvYhD6iMILaqw0dY+NEmd/5/YIQC0Kx
 8tZ6NPEiUlrI1et4+uKM0LjUYaK3JkybX38mRpsmmIk0SD9d/iME+Lbi8aF+uAxN14hb
 Al1+4oqWbLEFY27Jx7kUsLZEW9wqknuJ9d8r6oVOdt9KvDCBa3pGXavcOLpX0Yc9mi+q
 9iAfmagUSmMH8EQ9sKrXfDtqK3G2BAFjHi9I6YSPDvFc1wO4r4CGScHDYvsXdt8vzvsi
 HD+GyzSDEv/UOsj4cu1OhoN2Q39+n/M8ldDIOJTGtZdDxJO2XiJQ9DKwMKmgsrOlmVBQ
 PwOQ==
X-Gm-Message-State: AOJu0YxKPKHMVz0fwLWnTU0bHdmBxTaAek8Hc6Y5578E3KtDIppG/tvg
 C62kxjUcguLiYNuElyzE0HLfkhrT9brBwpLP3ksUlqsIgacxR35foptVQKI7GJiE1/PTwFPiriR
 fqvoQkWXQHF3f6DFmLU7dMDg8WYxNeDBEVe3GJLiNMXT5D997g1fQhrNldWuZ+QYci66j2jJn2G
 UWAiGLIJcR6UO+31HZ8liU811WcyV6cT/uSoE7pSi3
X-Gm-Gg: Acq92OEPswVV6q3keFWbtwK1A7Rf/2b73YQ2fW3VChgj5FARGTbYCSUKdLrjRfCRwL6
 l6LdLRaqhCc7ZtsHXH7Do5ZgkDVbdHihi2jgy/UpcEyrY9BL9JhYM0LYJDAZ8ferlzuSTkfGkcv
 blahzK62rp13vXsi+cDRrXY6mYICvfRCwkNjqCavTSI1IGHzUc/uGorUEsH35aIBWK3ZihFKaec
 ev6S5f45YE+MMWy4FKikrFrNS+wu8SjUI84hhZTWEu9q4s+OAzU6EAEheJDqRFykLcwD/1Iw5Sl
 0Ps+BEkJ2XsZQNwwDqwIYd4XSOprOPY4Wu+zARTtO81zR9h/33PuM11IepfIfWzCqeMVLMjRe5v
 zR6XUaJItWtkYEJUkMYt7P5GkNe8MCl3GhQ4h6OFWapyMjVWvKUIB4clKD0eTw5XuSbtOkLM8ca
 0LuhE3ZysPuHVZRfao
X-Received: by 2002:a05:600c:c84:b0:490:b58b:a8ca with SMTP id
 5b1f17b1804b1-49234131ffamr53635215e9.27.1781706693926; 
 Wed, 17 Jun 2026 07:31:33 -0700 (PDT)
X-Received: by 2002:a05:600c:c84:b0:490:b58b:a8ca with SMTP id
 5b1f17b1804b1-49234131ffamr53630885e9.27.1781706690127; 
 Wed, 17 Jun 2026 07:31:30 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.156.160])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4619a041986sm29753244f8f.23.2026.06.17.07.31.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 07:31:29 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Subject: [PULL 16/16] qga/vss: Drop unused define uuid(x)
Date: Wed, 17 Jun 2026 16:30:46 +0200
Message-ID: <20260617143046.445322-17-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260617143046.445322-1-pbonzini@redhat.com>
References: <20260617143046.445322-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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

From: Kostiantyn Kostiuk <kkostiuk@redhat.com>

There is no place in code where we use uuid(x), at the same time
MSVC vss.h use it and this define broke compilation.

Signed-off-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Link: https://lore.kernel.org/r/20260330113906.168002-8-kkostiuk@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qga/vss-win32/vss-common.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/qga/vss-win32/vss-common.h b/qga/vss-win32/vss-common.h
index db849127c2f..5e993f9eda4 100644
--- a/qga/vss-win32/vss-common.h
+++ b/qga/vss-win32/vss-common.h
@@ -30,8 +30,6 @@
 #define __RPC__out_ecount_part(x, y)
 #endif
 #define _declspec(x)
-#undef uuid
-#define uuid(x)
 
 #include <vss.h>
 #include "vss-handles.h"
-- 
2.54.0


