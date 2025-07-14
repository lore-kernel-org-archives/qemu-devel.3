Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FC1EC83F1B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 11:44:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubHDh-0006Jz-2Z; Mon, 14 Jul 2025 07:19:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubH1j-00027O-La
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:07:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubH1h-0002GV-R6
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:07:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752491236;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NvkNgqLKsXpfmLf4idce9IyO9fOJ2IHj3aUNZS4ffhE=;
 b=fjs2/fwzqELH4Jnjfh/L/hgO6FIWP/fNQCBjoEdMgUiLWY2Bh5ft15OiGK+BmqWiMfpFGc
 TAN6u8XIzfl3PdtBA9xqKOhopHBjHVxdmWq2JoYlSpAHfiuNdwtJvAfo+NhMOBHaXeMyn/
 JKslr5tVOdryaMn7GHMZTYPb8ccpBfU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-392-B87FIxF1PBmxo1N5lwCBAA-1; Mon, 14 Jul 2025 07:07:15 -0400
X-MC-Unique: B87FIxF1PBmxo1N5lwCBAA-1
X-Mimecast-MFC-AGG-ID: B87FIxF1PBmxo1N5lwCBAA_1752491234
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3a50816ccc6so2540679f8f.1
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 04:07:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752491233; x=1753096033;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NvkNgqLKsXpfmLf4idce9IyO9fOJ2IHj3aUNZS4ffhE=;
 b=CVvaniQXP2GPO2HjfNU2EpEdTa/uinEkysFPYWzJwI+VsksjrhgnIp8dxT60kL9s23
 NAQ8GO2/0ri8CzbLohmQfigiEIOenTgtxknE9j/hco4l911yvJsnNgqjg0gn83dY9R6s
 KhrLENZy9twvvVHlpNaK6+MW6Bf4METLV5/koViSU6p1jroAEbYNPpI/O1M/Ime6RhFg
 vJYezC/yLdyT6oOqcOq3FOM+/UPetBoqtmaOhysv0bhS/e1IXbVKS3kbpjE4cdzmQdmN
 hsGhNDqdnrxLfvJ2mhsIEPuFkR6A9DIZ8szi0o2y1bZqAFgIwYSjay0YmzbDjUDc8b0B
 DQ5A==
X-Gm-Message-State: AOJu0Yxx3f4ooYxNGIoPXtL6rzfLyqQhWrNlfgOeRr3C8C0dVgq1mLMK
 KIT0k0xTJz3ZyeHtRD8CM6/ZYQYqPZ4Uj7gRpMS5ehW6BGcpyjxa5699JWMsA2lL0kac0gM/JQb
 jpXofpfiHAhGX3mPm0SWwdd5RvIWWRn0UN0dUCXlTROSjd7QMurpWYIvH6BzJXPbBaTfSJ7wqMs
 F0h7MWjXxebY46XPKZTxaG9xWCM1Ua17Aa0bMKFr6N
X-Gm-Gg: ASbGncsCuEix7OTBejDj9h0FbxcBiI63Y6/3J5HfKsZwY9VITV1WQF/nNsBk3NUm1Qs
 JsFDtF2Nk/GAhuL5JYuWQLMAWCjLC3agY2XKMgIjs4ae6cUDQ0MTK2mzEI0E4v+EWzIkRcDKzUW
 +qGg6bCChyGsxtE4qxvNmfNWre18WxUVnUXV/sonEZPyej7M3H+kbrIm/h0whOGSsg8ZkI3chg/
 yR6jJUkfua6KfNLKnF6qpHIUM2cdhXZx7z+3WaGf/K+a/yE19PpSS/DMOkZ8AVjhLgz0cBhHUwM
 cmQNbbf427i1gAYkvprT4Y+5CIIGlZO8MKMPK/d2jis=
X-Received: by 2002:a05:6000:4287:b0:3a5:5fa4:a3f7 with SMTP id
 ffacd0b85a97d-3b5f2e5660cmr8970307f8f.58.1752491233294; 
 Mon, 14 Jul 2025 04:07:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFVlKj1cTmFl7iZN97hnbJaqg89IjhgkH6VkzL8I/8Dmm8PJN8xBXYvIjI67WyY/8UVR9Zbpw==
X-Received: by 2002:a05:6000:4287:b0:3a5:5fa4:a3f7 with SMTP id
 ffacd0b85a97d-3b5f2e5660cmr8970268f8f.58.1752491232745; 
 Mon, 14 Jul 2025 04:07:12 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.73.155])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8dc2464sm12386795f8f.38.2025.07.14.04.07.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 04:07:11 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 72/77] tests/vm: bump FreeBSD image to 14.3
Date: Mon, 14 Jul 2025 13:04:01 +0200
Message-ID: <20250714110406.117772-73-pbonzini@redhat.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250714110406.117772-1-pbonzini@redhat.com>
References: <20250714110406.117772-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/vm/freebsd | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/vm/freebsd b/tests/vm/freebsd
index 74b3b1e520a..2e96c9eba52 100755
--- a/tests/vm/freebsd
+++ b/tests/vm/freebsd
@@ -28,8 +28,8 @@ class FreeBSDVM(basevm.BaseVM):
     name = "freebsd"
     arch = "x86_64"
 
-    link = "https://download.freebsd.org/releases/CI-IMAGES/14.1-RELEASE/amd64/Latest/FreeBSD-14.1-RELEASE-amd64-BASIC-CI.raw.xz"
-    csum = "202fe27a05427f0a86d3ebb97712745186f2776ccc4f70d95466dd99a0238ba5"
+    link = "https://download.freebsd.org/releases/CI-IMAGES/14.3-RELEASE/amd64/Latest/FreeBSD-14.3-RELEASE-amd64-BASIC-CI.raw.xz"
+    csum = "ec0f5a4bbe63aa50a725d9fee0f1931f850e9a21cbebdadb991df00f168d6805"
     size = "20G"
 
     BUILD_SCRIPT = """
-- 
2.50.0


