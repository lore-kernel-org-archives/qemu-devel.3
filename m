Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBEA010D14AC
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 12:44:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7ByB-0003Ze-62; Mon, 30 Mar 2026 08:43:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1w7Bxe-0003WE-Ey
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 08:43:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1w7Bxc-0000Hi-0a
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 08:43:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774874594;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FYwLR3GgX+Ye3iUWaFjRjfsbK6gNISvyQ1hn9Dx/s98=;
 b=FbEMXDHmI2tZB8nc/fp65kqWlnx6Ol8T5mA7TBYFCKeFQ0eIb6d45epIljdAdsb9HQcyNz
 OU4EP6eXVPfODjyY6h0dLlev6ntJCXjYZm1WIo92zmLwORLPNykNckp9B7uDw+6pwxmfvO
 nsotNLuh9zo9yNX2barIL7ffT8tC57E=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-FGXM6XwMPW6MGwU0AyOzvg-1; Mon, 30 Mar 2026 08:43:13 -0400
X-MC-Unique: FGXM6XwMPW6MGwU0AyOzvg-1
X-Mimecast-MFC-AGG-ID: FGXM6XwMPW6MGwU0AyOzvg_1774874592
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-43b91b5dd24so2444058f8f.2
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2026 05:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774874592; x=1775479392; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FYwLR3GgX+Ye3iUWaFjRjfsbK6gNISvyQ1hn9Dx/s98=;
 b=jF7ytXhl2EPFv3MWz6HNGvCL4yAuGiEpPYoda49m31rnb1S7U33mprf67d/XDAUEw+
 xRl64POsjMgXQy6qjBwVQPjLqYA5PCL5yTnMR1F+/+0uXIvQY36ohvnXN8pBxkc8vvPS
 1JUmpvBOvmPtYCasFqzOhfVYCRSSUOEFiRCU4EWwM4eCszQ3Cnp4a7jbwGWJa360+t1N
 mF3U5a4Q74EjY/HqG9KkMt6me23iMSImjZga8QnRPSMpA1oAZWPiFRRHxA1HEwjp4oFI
 oJS53uVi5dMdpFYYNsCFOMmwyqafxMiTE5Bmi3ntzNWWZlrV+5M41MBZj3fbHj52NXM6
 QaWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774874592; x=1775479392;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=FYwLR3GgX+Ye3iUWaFjRjfsbK6gNISvyQ1hn9Dx/s98=;
 b=F/c8fj6L6vUTO49WhvflzZwwPAFY/ZHWI8uZnUH1PddTJxICik0FfaCKaXQ8rRqIFz
 wWSMdn2tcSDiWvxRhelTkJpOPgdqWJxjwImdEp3x/XwMcKPKzLWlZRVqFzYecfwQQ7DZ
 qG/3lfETHI7Wv7Ep/tLEsf6pcJdNv2NNM+Md6Wr7LWAisJ134e5PKf/kZokIUGGdln4Y
 S3ZIrg/xLiX0MmgvQ6Oyb/+n3ZA4S2UaUR9RLBl6+aY9j5tSLQgxowny0A4v+1GAZ5Qm
 +8GVwwr5VNCrHxs3EvLFraIhIaHien2PX2gV0L9v2rpKs4zrpP2kp5IhNfxAtW/q2gRR
 yRRw==
X-Gm-Message-State: AOJu0Yzm49S17BuStckCngi9H5ItCLOnVExmMU9H8Nk7e+oMMN1lTU1P
 Ptz76MQalCgbX1TPqRZfG9I2kbXaX0fxmd/2VqI3AoATA7AtO7NDgIHkhbEcs5wq1CVsvlIb+jj
 9onnjes447OoBjU5D1htkaWETb2PeW5ElZaal72WXoyRcWSIS1kR0FGkb
X-Gm-Gg: ATEYQzwrXkU3i2rXE/l3Ybfho7sRMsP6baltTxELxdDYNJ27/uVOr6hNv9tW2B24zP7
 4cY2UMP3X2a4Oq5UlU0vD3HWcI+YtFx5OOo6ZWpWuQUjvHcgEeAxy6VSE8jhQ2EM0P3NKrGhhjt
 mo5CtTpn3l4lfcbDUFSTtugt6WaDKswyDmBB176FfQ2Cqg964R+QseChZzZAQARHlTilo03vrqz
 n67vNVqGqw/Yy+uFdwgbWU/uomiDa3S+A6jWRVj5T4JSt013jqsnAy1fW1JnBolKNyCB/zZvR4f
 YfBuL8+XG3Tbk0VYLLaWhsjMBumW5tGsqueAPh7cChBc1u5eie5wDHPY5l4gS/dOWtzpevPrrbm
 TxYsK56X0WmSfs3dv5ziBfqjy5WuUexQGmEBAePfcniXj6rBOccecG79Jh0Yl
X-Received: by 2002:a05:600c:3513:b0:486:fa9c:185 with SMTP id
 5b1f17b1804b1-48727f235bamr200649135e9.31.1774874591850; 
 Mon, 30 Mar 2026 05:43:11 -0700 (PDT)
X-Received: by 2002:a05:600c:3513:b0:486:fa9c:185 with SMTP id
 5b1f17b1804b1-48727f235bamr200648675e9.31.1774874591346; 
 Mon, 30 Mar 2026 05:43:11 -0700 (PDT)
Received: from lleonard-thinkpadx1carbongen13.rmtit.csb ([176.206.19.176])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-487306996cbsm165319385e9.13.2026.03.30.05.43.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2026 05:43:11 -0700 (PDT)
From: Luigi Leonardi <leonardi@redhat.com>
Date: Mon, 30 Mar 2026 14:43:09 +0200
Subject: [PATCH 3/3] igvm: fix parent object type in IgvmCfg struct
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260330-igvm_fixes-v1-3-03587a5a808b@redhat.com>
References: <20260330-igvm_fixes-v1-0-03587a5a808b@redhat.com>
In-Reply-To: <20260330-igvm_fixes-v1-0-03587a5a808b@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Ani Sinha <anisinha@redhat.com>, 
 Oliver Steffen <osteffen@redhat.com>, Luigi Leonardi <leonardi@redhat.com>
X-Mailer: b4 0.14.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=leonardi@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

IgvmCfg is defined as an Object but, currently, its first member is an
ObjectClass.

Replace ObjectClass with Object.

Fixes: c1d466d267cf ("backends/igvm: Add IGVM loader and configuration")
Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
---
 include/system/igvm-internal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/system/igvm-internal.h b/include/system/igvm-internal.h
index 76ae1bc3be9249cc1796bd7eec77dd9084358f98..7f131c4d0392214e4d53ca84d60713b3c1493334 100644
--- a/include/system/igvm-internal.h
+++ b/include/system/igvm-internal.h
@@ -19,7 +19,7 @@
 #include <igvm/igvm.h>
 
 struct IgvmCfg {
-    ObjectClass parent_class;
+    Object parent_obj;
 
     /*
      * filename: Filename that specifies a file that contains the configuration

-- 
2.53.0


