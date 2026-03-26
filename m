Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AE12106F311
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 09:21:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5gtm-0000oS-5F; Thu, 26 Mar 2026 05:21:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <silvan@quobyte.com>)
 id 1w5gtk-0000kx-NS
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 05:21:04 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <silvan@quobyte.com>)
 id 1w5gti-0000Kb-IW
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 05:21:04 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-486ff201041so6335725e9.1
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2026 02:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=quobyte.com; s=google; t=1774516861; x=1775121661; darn=nongnu.org;
 h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=1z7eWHRCKyrRx5GJTpNLhbk7ddlC+qA+Hu4CTwSuwZ0=;
 b=Y8bly2NbbTiFfHU1Pk+QI9sP8m3/h0cuyW8LX2OlT7dlBQp2GI6rvpBAUuKgjNfUqy
 TubablGhweLHFk4KVhOM3AKmW+6dxyvkI1UKd5EpAR0NZ3vOyaoxdmY7Y164k5egfI8G
 aaegaR/Pg7VlkOIi1w8N3vptpXjwNuuuGqstw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774516861; x=1775121661;
 h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1z7eWHRCKyrRx5GJTpNLhbk7ddlC+qA+Hu4CTwSuwZ0=;
 b=qIOOrOycCYXm7ctGdENGZz2eSg6aMjIGlf6PGy8CMOtbDgOcC6frbTLswMH22xbxpk
 9q8q5uLEeHQaeaovO12P/sZgPQF3zUTVbK6Frkx6y6Np3ZDwkijQ5YlGMr4FoMQOWqFe
 g5eQLnTJYfLrSOBmO/CJaaIKHK2OPUAyX7RnQ9IfQS60Y1765YfWXucBBH9PGxdjNAzu
 5n+AcH+qYObDl5awdYXxsKciMqxeZnwlLx1gTCGfgDYaL+NtAPCga5vF/UBz3JBTAk1H
 IvHhmglzQaFGkqn+QiaK4a2Xa3rohKQbnh5nOlZIUVrOyEwufR7mUah6TqBT9Zfgs6EI
 PB7g==
X-Gm-Message-State: AOJu0YwBIojQBDVyjqCC8BUvnMBCs6A4nnPBEYotyeJnFB6f8fIyg7xb
 NAti67A5F8bck/gEQYYdF5R8uBQrO1DlQqZ73/KFfx85JLUCrcst3zv5fIgTHU/lOmcC3CPJ2Of
 UcKIbDTtSfkZe56XcnIHBKyz4Xj6elDVvxyMhMxCXEJ0ZFl4fyUCJLCTxEvMSUXWt9TrM
X-Gm-Gg: ATEYQzwr3326L8c1Qprltf4hkrO+IMb6aCibS3o1jhtdmOvROIBxal2C1FYcckRuC7P
 f8BVaJ/jiMRb+XD+/azzD3BoTzZo+7lkOoIrTyRX9wnio3tRl554HzZrf6+ofRTHRF90zmX0reS
 koIvowCLRvCsctjB9JVi1XesU7w7XnlxMQHlEDYI7lo8OVhxhyaVAjRjpSTNIxZvwIojClrHS+3
 emaxHmX2/iJNyRfrDbSvl4eMRnDhehYya0DVKQgwgcGJYq8vtMBY3CBKJmBRaWZDbN54MJ55LXP
 SHf28Hw3FGEDmSS1GWGTsDP/7gJhL7pJ6f2r7YSp0wWaJKJbMpvk0SSjFooCkFIlSp0zwkIDcp/
 Z3AyZ/CWmw9xeAlzWpckK0v86M6K4f1SGclfhOFuIezhtJGEKpkiAilEQ6m7jGGxjv01lIhqXGA
 xVtdll3l0SLtPctxg7vxhHe6Yfk/JjH9wx6fDeOmyf5TabC30AsFvw/9iPtsv5BRfMYc/xtlBus
 nhyTM3nXsclyCxaACoy9EKQP4qZGihbxt7hWkeZjdTdujgtxxpvtUKhino=
X-Received: by 2002:a05:600c:8219:b0:485:ae14:8187 with SMTP id
 5b1f17b1804b1-48715fc3250mr91970845e9.2.1774516861066; 
 Thu, 26 Mar 2026 02:21:01 -0700 (PDT)
Received: from kaisers.corp.quobyte.com ([24.134.167.61])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48722c9506dsm16474295e9.7.2026.03.26.02.21.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 02:21:00 -0700 (PDT)
From: Silvan Kaiser <silvan@quobyte.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, hreitz@redhat.com,
 pierrick.bouvier@linaro.org, eblake@redhat.com, armbru@redhat.com,
 Silvan Kaiser <silvan@quobyte.com>
Subject: [PATCH 2/3] docs/system: Document locking=posix option for file block
 driver
Date: Thu, 26 Mar 2026 10:19:47 +0100
Message-ID: <20260326091948.194529-3-silvan@quobyte.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260326091948.194529-1-silvan@quobyte.com>
References: <20260326091948.194529-1-silvan@quobyte.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=silvan@quobyte.com; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Silvan Kaiser <silvan@quobyte.com>
---
 docs/system/qemu-block-drivers.rst.inc |  3 +++
 qemu-options.hx                        | 10 ++++++----
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/docs/system/qemu-block-drivers.rst.inc b/docs/system/qemu-block-drivers.rst.inc
index 384e95ba76..bdecbf39ca 100644
--- a/docs/system/qemu-block-drivers.rst.inc
+++ b/docs/system/qemu-block-drivers.rst.inc
@@ -882,6 +882,9 @@ the POSIX locking API will be used. In this case there is a risk that the lock
 will get silently lost when doing hot plugging and block jobs, due to the
 shortcomings of the POSIX locking API.
 
+To force the use of POSIX locks even when OFD locking is available, specify
+"locking=posix". The same caveats about silent lock loss apply.
+
 QEMU transparently handles lock handover during shared storage migration.  For
 shared virtual disk images between multiple VMs, the "share-rw" device option
 should be used.
diff --git a/qemu-options.hx b/qemu-options.hx
index 21972f8326..23502c5aa6 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -1540,10 +1540,12 @@ SRST
             default: threads)
 
         ``locking``
-            Specifies whether the image file is protected with Linux OFD
-            / POSIX locks. The default is to use the Linux Open File
-            Descriptor API if available, otherwise no lock is applied.
-            (auto/on/off, default: auto)
+            Specifies whether the image file is protected with locks.
+            'on' enables locking, preferring OFD (Open File Descriptor)
+            locks if available, but falling back to POSIX locks with a
+            warning. 'posix' forces the use of POSIX locks. 'auto' (the
+            default) enables locking only if OFD locks are available.
+            'off' disables locking. (on/off/auto/posix, default: auto)
 
         Example:
 
-- 
2.47.3


-- 
Quobyte GmbH, Berlin, AG Charlottenburg HRB 149012 B, Dr. Felix Hupfeld, 
Dr. Bjoern Kolbeck

