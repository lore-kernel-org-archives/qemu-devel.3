Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D37ACCD98E2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 14:32:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZrId-0006iq-5K; Wed, 17 Jun 2026 10:31:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wZrIV-0006hH-MD
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 10:31:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wZrIU-0007pL-3T
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 10:31:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781706676;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Na5jqss4vf3n0qekhSniNpQZT3LMSGPEY4Q2LCrMuwE=;
 b=U7iHa5u4AK1AP0Tku3j29lExe87xKP4XlwFmnkk5o28IOd7BznFeIIySFGyL4GK6Ti7cDy
 e4HeYGFmXKQ/EFlpWhXrMgPIv5YQtgFdN5O3ye7CCW4W/2rjoEAMDJp3t8YxoMYLXGmwOd
 yRv8rnvHXZQUygh5RFksdSYoHsvsV20=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-520-ssSxU4pLN6mWV9ph-H2eZA-1; Wed, 17 Jun 2026 10:31:15 -0400
X-MC-Unique: ssSxU4pLN6mWV9ph-H2eZA-1
X-Mimecast-MFC-AGG-ID: ssSxU4pLN6mWV9ph-H2eZA_1781706674
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-490bde3d239so39031185e9.1
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 07:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781706674; x=1782311474; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Na5jqss4vf3n0qekhSniNpQZT3LMSGPEY4Q2LCrMuwE=;
 b=KFKhoTM3sIjFFR3O18VSvpRTfJxrDP+7+JEkuPMmWLgHUvzryPXUozHxnP6G4CB+n6
 3ItPm6w5Rn7RS1VlsaVpNRsbUwTRMecR1t26skrZWN43o9XZcJmRoSct6ikCprsgAC6f
 ewK6EbNmkvv5oRWTHnTwYA8gKIcAGXLvCXH7hyr67to0T0YI8kySRvXuYOW/D7cPjt8p
 tMLrbvOmhiQHiZU5TiHRliF/S0nl0efgJKiPTCPhZSeap5Hsf/1GM6HEhD33ddJ3KlTw
 ZUBB4K4WR8ydcWj1LzT9y0v4qrKio6hN8q9Ieutc9K2m/MwuFX+tW2bv0S3omhGyFcvs
 r2mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781706674; x=1782311474;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Na5jqss4vf3n0qekhSniNpQZT3LMSGPEY4Q2LCrMuwE=;
 b=LczLnWzn7bWnSzWKDqM7SzJXspr60NvN/ucgkGosmD4fuO9OfBSZ8DdNG4/D8cXttw
 OjB8iID3h+lEiNmRyhdUIHfaD/jTaO+d22y1672TVsRIv7T+H/HjFJ1wDSxwnTevogu9
 vh0kfVjitTYXQck4FWiuVQZvvCATtk+ZqgupmF8VC2r6Of3TdFOPzHyPgTFx/XrDuL2L
 OrRxIDIuU0kAsoTyAur170AAJcLTgyuaTPygj1oPWqZwOzkBwwK453znUko5i9hJpFqK
 D2GRO3/uveUnTMJAwibiKLST8VF3mqp4eSQPD6pU8lfxRtTukHYUYUVIcJFQUKGBlLvp
 G2zA==
X-Gm-Message-State: AOJu0Yy9ioq+WITHBBKPt44ucQRiOXAHe8A9J4yxvaevipy0xfMTb6y5
 Q9BWX6cbJCLM95u39RK7W1RuhXc39WQ673xdymG0y1Mjv9o0ypwCyKDBPCmb72xJKkt9wQo+NHE
 BKP/FQ0I4MQOm8LT7764fP1LH4XwSSWFO+TZBp8GmLjihWstEa8cwPgD+A5pKerJ97JNbLLfK7W
 rZjgrWewkITB8mdBnvfVXCeGN9Akdew9fTo79hRgNp
X-Gm-Gg: Acq92OFk2fUsRSU2UHJ9MnfaCHNu2zZuNm7uQZssCdMXaXIKwjJv5Lh6k+j+xcJxuK/
 eUrUm9FiJOIpFeELpsDTvIXrllCuF0AGAYp+RAwIPD/mOWHNzg58QxfKSAh0KNf1qqkzGaFlFj1
 vMejtdf4+S0un/hRwqqYm69s9teZETRFO2PONrCSN1ZhkoyqhURJXo/+QOGnUEmFLZloWaxtTfo
 ibD3hdoI0wrIgbf+hVXqBfcGTVxELakyGuM0KaSGn/p8dQ1HcPl7O/Ohchwoc1iokx8s0bLdrx8
 cYceKco6TvR+QNpCNXr4DUJjzYLGg6e4fpeBQ+pPdYE7KLVyHUVEHJ23ZKyoA25u81tqDCbAVte
 0okaTAlYVBa6q/EiS6b2ed/M8EU9Te+kOQcR0t0BQFDWeN9KDcDzw8OwgnGWRCx7Y4q1Z5uRhIJ
 oiWfXtzXo8M1287bhn
X-Received: by 2002:a05:600c:1553:b0:490:d354:d15b with SMTP id
 5b1f17b1804b1-492334282b7mr68871825e9.29.1781706673582; 
 Wed, 17 Jun 2026 07:31:13 -0700 (PDT)
X-Received: by 2002:a05:600c:1553:b0:490:d354:d15b with SMTP id
 5b1f17b1804b1-492334282b7mr68871135e9.29.1781706673024; 
 Wed, 17 Jun 2026 07:31:13 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.156.160])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4922fa3a4easm184245415e9.3.2026.06.17.07.31.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 07:31:11 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Subject: [PULL 10/16] qga/win: Use swprintf instead of snwprintf
Date: Wed, 17 Jun 2026 16:30:40 +0200
Message-ID: <20260617143046.445322-11-pbonzini@redhat.com>
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

snwprintf is a Microsoft extension, and according to the MSVC spec,
it is called _snwprintf. MinGW defines both snwprintf and _snwprintf,
while MSVC defines only _snwprintf.

We can also use swprintf here. The only difference between
the two is the return value, and we are not using it. So change
the function to support MSVC build env.

Signed-off-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Link: https://lore.kernel.org/r/20260330113906.168002-2-kkostiuk@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qga/commands-win32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index c0bf3467bdd..2bf5581aaa7 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -1590,7 +1590,7 @@ static DWORD get_interface_index(const char *guid)
     ULONG index;
     DWORD status;
     wchar_t wbuf[INTERFACE_PATH_BUF_SZ];
-    snwprintf(wbuf, INTERFACE_PATH_BUF_SZ, L"\\device\\tcpip_%s", guid);
+    swprintf(wbuf, INTERFACE_PATH_BUF_SZ, L"\\device\\tcpip_%s", guid);
     wbuf[INTERFACE_PATH_BUF_SZ - 1] = 0;
     status = GetAdapterIndex (wbuf, &index);
     if (status != NO_ERROR) {
-- 
2.54.0


