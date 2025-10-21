Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 116F5CCD1AA
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 20:48:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBJGS-0004nP-PO; Tue, 21 Oct 2025 16:47:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBJGQ-0004kO-IO
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 16:47:26 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBJGJ-000131-56
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 16:47:26 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-42701b29a7eso162192f8f.0
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 13:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761079637; x=1761684437; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=KBC6i3+MkunkUVGrLLzktXv08p0y8JKjQ+ZBub6zkz0=;
 b=u30Cdq++sWEtXvlyYu9N7XCiYxhnGUc/S3dDhVTjFNkstHfnaUb6UOTYbbqssWkULY
 4aLgxCRiVEpwDNA6BIxwUjcaJpYxDKWBzjlZmxOufWcrNqQUenqR/0usgWp/5hXofJ3Q
 iqW7UfTIxkJiDKxqlwLjZxgMqdmgl3GpKwcVwRwxSq1g0BNTZ3dyJ8nBoUSb+theAmSK
 sP9RmGNg3imwUixJjtmW4xql7mGrUwV+3pO4X9S4cTUdn++rKZYcWK8pIBVvKr5/l+1o
 DOS7tNTLaMn4UbJYo7y2CA2NhFGVOvRk3U5vpg0EeZN42Egs/yFFIYHNnEYOAHHhwF+8
 Sf0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761079637; x=1761684437;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KBC6i3+MkunkUVGrLLzktXv08p0y8JKjQ+ZBub6zkz0=;
 b=T6dZ9jGhZcSMLqgP23hE9hXD06m0Nn+bT3Jwxlo0NgIqg41lrA+nWVh2khLNOLiO0d
 CRzmbSgtNOVjo5O2PQeaoklpVeSGT3H9Thejw6cwA4UJFoCQGXEobEpVqLG1rsEIw+P1
 Cije2uCU3wFcZZbM1v9Di+Fhv0mZnPwEXtAfzA4Ew8MOA9+BA0mDtPfYpzdZNGUNdFXM
 2JAneduShKSDeGNu1AzUPFwCcldcHF9hxpD4KuzrUnq810T9JvKZQ0AF6eGo1WA3XWnr
 AN5rtFLZ2ULWLq+ppGdLF3ANgOypUOxsFbhk/dx69IsArR5PuiZkQ4t9TD5cwO6FWILE
 YLSw==
X-Gm-Message-State: AOJu0Yx5BcDAgp6YzUhGfRSm1SUgeOqQWG8cbPfnG0DR1ItJHeCWroZd
 Iz7QOhQZjR6eGlqeX724rnI39zDRI+RdtMmHM4DZkH7J5qod4UsTfXsJjy9PRi6b5MN3oTo6KPF
 VpF27U0c=
X-Gm-Gg: ASbGnctTwcK5UFMB2tjpt/KPgTP8rcsiANl3hrigqroaj8h5cjZWpTeJB1HsGEqg9Oi
 50ElV7xD/Y4KtpqgniOFQf4qPcBxsNAIiYYIG+7OiN8Wd+pEtB75yf1j9EAXd7WNqBWZKGmTnMx
 eRUMwOJTLPmfGg/9S55BM2hQI9u10iSku4bbBut4EmLV0zam0OcLmCgaTxzp+Niy3Zv3nsR+Y7D
 TEBXIBdww+BmwcCWhlHyrcRTn4LyubGY8VFv10Cpc8pbKPLzLGN25wqYGJPfEbvlUyVs3p83mXV
 Tw+Lbc4xtkn9hGGL62Cji5Zuj5gomoWrV1jNDFO8WvNUORpwaSt818IlFaV25NJ4CxMPw/1v2Wz
 azkWXriPMyBg2SJbLhO6CMSdkguHWcujAyZ9OB8zBl1M/1CPhukQZQKX7EuxJD7T7IPZ/2PXeeK
 x6PTOMrqxxr/27PaIk7T4OfrUdlZzDVpiq+JTltlZNtFs0SnVtpQ==
X-Google-Smtp-Source: AGHT+IHnLdnMmTbkUjNXGUHggtxg4iuU2A0hrWWQjX7MLFRqPTa2tri0jrlcUwU3+hAlbOQ/3FP9+w==
X-Received: by 2002:a05:6000:248a:b0:3e9:54d1:e708 with SMTP id
 ffacd0b85a97d-4285326f900mr656353f8f.20.1761079637046; 
 Tue, 21 Oct 2025 13:47:17 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-427ea5a102fsm21995469f8f.1.2025.10.21.13.47.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Oct 2025 13:47:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/45] hw/virtio: Compile virtio-mem.c once
Date: Tue, 21 Oct 2025 22:46:17 +0200
Message-ID: <20251021204700.56072-4-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251021204700.56072-1-philmd@linaro.org>
References: <20251021204700.56072-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Remove unused "system/ram_addr.h" header. This file doesn't
use any target specific definitions anymore, compile it once
by moving it to system_virtio_ss[].

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20250502214551.80401-6-philmd@linaro.org>
---
 hw/virtio/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/virtio/meson.build b/hw/virtio/meson.build
index 48b9fedfa56..affd66887db 100644
--- a/hw/virtio/meson.build
+++ b/hw/virtio/meson.build
@@ -57,7 +57,7 @@ specific_virtio_ss.add(when: 'CONFIG_VIRTIO_BALLOON', if_true: files('virtio-bal
 specific_virtio_ss.add(when: 'CONFIG_VHOST_USER_FS', if_true: files('vhost-user-fs.c'))
 specific_virtio_ss.add(when: 'CONFIG_VIRTIO_PMEM', if_true: files('virtio-pmem.c'))
 specific_virtio_ss.add(when: 'CONFIG_VHOST_VSOCK', if_true: files('vhost-vsock.c'))
-specific_virtio_ss.add(when: 'CONFIG_VIRTIO_MEM', if_true: files('virtio-mem.c'))
+system_virtio_ss.add(when: 'CONFIG_VIRTIO_MEM', if_true: files('virtio-mem.c'))
 system_virtio_ss.add(when: 'CONFIG_VIRTIO_NSM', if_true: files('virtio-nsm.c'))
 system_virtio_ss.add(when: 'CONFIG_VIRTIO_NSM', if_true: [files('cbor-helpers.c'), libcbor])
 system_virtio_ss.add(when: 'CONFIG_VHOST_USER_SCMI', if_true: files('vhost-user-scmi.c'))
-- 
2.51.0


