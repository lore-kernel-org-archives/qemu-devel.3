Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66EE6C282D1
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Mar 2025 10:32:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trDwY-0007zH-Cp; Sun, 09 Mar 2025 06:31:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1trDwU-0007yc-Nu
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 06:31:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1trDwS-0003zI-3u
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 06:31:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741516289;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SsvDN1gwhkxvwdyT20oUdLZoM+J5t+ejAH8C+7BX97A=;
 b=MRKZvolS5xtGezY+SyOfzQdopZ9JKcX8Zfmi3yfkhq01iEyRq+57ezNDBQyd4UN3V3W7iN
 BvYKNWXa0kS9vQLgTSDfAxrowOwFEPSm4/Yh/QCLvc9IgADkgtLTDE3rwkWb0O+79AcR3R
 z0/xJwBDFfjr0IVU10Gh/9AP3KPxwxY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-DEL9vmNbNDOd7s4YgR2iZA-1; Sun, 09 Mar 2025 06:31:26 -0400
X-MC-Unique: DEL9vmNbNDOd7s4YgR2iZA-1
X-Mimecast-MFC-AGG-ID: DEL9vmNbNDOd7s4YgR2iZA_1741516285
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3913f97d115so269458f8f.0
 for <qemu-devel@nongnu.org>; Sun, 09 Mar 2025 03:31:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741516283; x=1742121083;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SsvDN1gwhkxvwdyT20oUdLZoM+J5t+ejAH8C+7BX97A=;
 b=tnKgIWsigv5oyXKA/uzZ6a6uy7pjR5sHytPJPwfzNes4LwIsWKsmmZh0C1NGHmRolh
 waB69AASMXReviNE8Y5iO223j5cNanzMKVNxYkF6kOEfv0j1huFOZxbPB47uCBpIne+B
 u67CtWYVr1p+XxangMxdU/L6eIYMqLatmsoieewTjNZxt87nPnsfQ2tpocXCQ6GfspX7
 8jUeGbOvjFjJT5ZWmUiqilRrcgjR3mscx9mO9OnVR+AnMs/xOSZUnxfxExT9hehTVlEt
 eCuevg5rwA3MH5peJVHUtUeaxCZXAtRim7fBGuROmStNlSmKbzNof5jzSEqHjrcLgeQ2
 Jjxg==
X-Gm-Message-State: AOJu0YycKVTZ7pIR5TzTFJu5IW3It0TvqPYsPGjOvC78FABlk1LZtnjR
 myAkDNk9txsYB3CilC0LpLnkmJU96HLrZ5VYK66YTONqPhmD8h/Jged8Xp8fTSioCy6kaVbXEOw
 Aa7g2eHu21XKxZrW7rK4MbivuvSKDuzB8egyOLbW5M4mNK9EsPxUThFHHqgn/1aqmKrBMgnidSi
 y5EHdr+mTeqfSX7tDnxKdM3sU700lFtcY1vJSknRE=
X-Gm-Gg: ASbGncuFkHFskhGWxa5aXZG1CDwqjSEWbwtUoApBmb3aNSE7ez0PQUcsJ6J6TSg/oVJ
 xuE2LAmwVgVt3E/6x6A8lWvaDKo8+Rid/l6WnMXeqtNYVQzrDF0DDDKixF60hIJ+Ro6l5G6PXCd
 HYih1XMULq6UdAAzBmUPFqumbe5jv0QT1Q+Jd408BEA092I3DYgYLpew9manQOP0bTDapMlNW6K
 Tl8kD4xq/flJ+Irqv140fMzzSE/XmbHgkpsl76TCPRyCdxMIFwtTGBPjEJE0QOeBW2mg3EPpt8e
 5LUP/zrH60JgKZ76N5NeMw==
X-Received: by 2002:a05:6000:1567:b0:391:1199:22b5 with SMTP id
 ffacd0b85a97d-3913aeeee27mr3093572f8f.10.1741516283731; 
 Sun, 09 Mar 2025 03:31:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHnPLB17+OJadRP/lO3w7H8kpMKz4GrPxlGhHMWUEvxCua+y5byhEStnnZwTUHg9p2YpnsaWQ==
X-Received: by 2002:a05:6000:1567:b0:391:1199:22b5 with SMTP id
 ffacd0b85a97d-3913aeeee27mr3093558f8f.10.1741516283316; 
 Sun, 09 Mar 2025 03:31:23 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.122.167])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43cf86b1d80sm164685e9.9.2025.03.09.03.31.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Mar 2025 03:31:22 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 01/25] chardev: express dependency on io/
Date: Sun,  9 Mar 2025 11:30:55 +0100
Message-ID: <20250309103120.1116448-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250309103120.1116448-1-pbonzini@redhat.com>
References: <20250309103120.1116448-1-pbonzini@redhat.com>
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

chardev is using qio functions, so express that in the Meson internal
dependency.  (I found this when adding character devices bindings for
Rust; they initially needed the io dependency added by hand).

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index 8b9fda4d95e..67ec2b78319 100644
--- a/meson.build
+++ b/meson.build
@@ -4015,7 +4015,7 @@ libchardev = static_library('chardev', chardev_ss.sources() + genh,
                             build_by_default: false)
 
 chardev = declare_dependency(objects: libchardev.extract_all_objects(recursive: false),
-                             dependencies: chardev_ss.dependencies())
+                             dependencies: [chardev_ss.dependencies(), io])
 
 hwcore_ss = hwcore_ss.apply({})
 libhwcore = static_library('hwcore', sources: hwcore_ss.sources() + genh,
-- 
2.48.1


