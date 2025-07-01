Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2298AC8302F
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 11:50:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWZQn-0005YQ-2v; Tue, 01 Jul 2025 07:45:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1uWZQd-0005Tu-7V
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 07:45:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1uWZQa-0003ap-M6
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 07:45:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751370332;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/8UsRrHLeCoAGqBtD2jv+/jE3kcOvs7fn80vwhdcsKY=;
 b=fCoXsd9kdIyQ+Lt4N8/M7dqsxzYwD1hmudwx59fLOzXuCOmCRQbnPeFZBEVItzqBX/HMV7
 vx68ury9XkCMOM5GRQXgThvtCD9OC9xhKW5BxADzmUQ0NO++7n173x6mTDoMW0mbNIbtNK
 QozDHUdZoNm1O6LC0aMGi+hjIx7cedg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-110-iBbAUlEfOMas6X4NH-adSQ-1; Tue, 01 Jul 2025 07:45:28 -0400
X-MC-Unique: iBbAUlEfOMas6X4NH-adSQ-1
X-Mimecast-MFC-AGG-ID: iBbAUlEfOMas6X4NH-adSQ_1751370328
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-453a190819bso13758255e9.1
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 04:45:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751370327; x=1751975127;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/8UsRrHLeCoAGqBtD2jv+/jE3kcOvs7fn80vwhdcsKY=;
 b=E5lCQK5cb9T6+V0ESxnPBeBtCOrTovfoamwDB5izCFv4F8XgFnkVPtH3573ZzBCQ/O
 fzHjQtXJD+c3Karh1Lm+z8O3j/oF35twHq5H+4ruuoQdPnt5mxSURuQ/oUPuYoYkzaSN
 O0W/ZBsWzrIRd50ocxydSuXimzUp4capcpz/9rGOQo6I+aAF6cE0gQEPUMvby1cAzM8d
 DwuuM/h+PJLyYWfEIqueoprP//jkYQ8eJC62uRZzTlIweM9caoLFr5S+HaxZwCVV88vE
 FbhRH27kZz3zfrLe71hPd2uDqg5JIUGXu+2umKwcmCezmfq6tYpF+2fRjHMP4Bl2bQwp
 LyIA==
X-Gm-Message-State: AOJu0YzBzP1bFPlLCxwHO1Da2ZIbWNIC1wS74OVt98VPbWhEUDtz3DxC
 pRzTGhkHmYb52Tc5qcbEO0u4iOZd1kn+uAj2OfH3P0/NN2m1SNTVpUs9hT/fAlCe+k3UEU3wev3
 KloNYHSOcMvpDlsKQ2Y4uStAwC9TYoj5rNv9UY+U7wWeBf8fVhJsaLf3X
X-Gm-Gg: ASbGncuDN/F40xAQl/7tjB3bkXqUVvE1b2KjRf8Cw96AwpkcBiukrJKDfGomxfJ7A3p
 ft+l87077ZrH2U1MK74BPpO6IsHZ8i9SNZozth0Tt2gf3OMcoYmryZroluuK8KsUqAEOD4XwNWf
 SQ0/9wnq3C0NhMnNiasYwOu152vFNxIacVO+I5WBCWySs+wYhwYxGzJ0m5hM0BrorzfQF0Rc8LY
 o/x98Qv+QDV8thvZNqEyaJP0LIP7ipm6vrScfuCTDh3Y9gAdUVpfKjrWhVBHZidLLbP3iaBTWBD
 vK+Tw2VGipyqE9cLD86uQDQDR97aO+Gj5/qniRy4x60SfjoNVhr8eNCGffQPxHn348Guh020n37
 p+QE5
X-Received: by 2002:a05:600c:c11b:b0:450:cfa7:5ea1 with SMTP id
 5b1f17b1804b1-4538ee55a30mr159988435e9.16.1751370327397; 
 Tue, 01 Jul 2025 04:45:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF2KNQLfO/I2YRGw6uIVq7Qc1sCLdTSb0Zn2ydNII6jbq967DweV4cVUYr6ZYEx1I+pwCSCAg==
X-Received: by 2002:a05:600c:c11b:b0:450:cfa7:5ea1 with SMTP id
 5b1f17b1804b1-4538ee55a30mr159988065e9.16.1751370326919; 
 Tue, 01 Jul 2025 04:45:26 -0700 (PDT)
Received: from localhost
 (p200300cfd700f38d3df6a1ca7d40fe1f.dip0.t-ipconnect.de.
 [2003:cf:d700:f38d:3df6:a1ca:7d40:fe1f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a88c7facf9sm12913901f8f.22.2025.07.01.04.45.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jul 2025 04:45:26 -0700 (PDT)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Brian Song <hibriansong@gmail.com>
Subject: [PATCH v3 14/21] fuse: Reduce max read size
Date: Tue,  1 Jul 2025 13:44:30 +0200
Message-ID: <20250701114437.207419-15-hreitz@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250701114437.207419-1-hreitz@redhat.com>
References: <20250701114437.207419-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
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

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 block/export/fuse.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/export/fuse.c b/block/export/fuse.c
index 85ebc6bda8..8ea590ba67 100644
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
2.49.0


