Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 132CBE9A02C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 13:34:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vshfD-0003tl-Pi; Wed, 18 Feb 2026 08:32:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vshfB-0003po-K8
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 08:32:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vshf4-00059P-Ir
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 08:32:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771421524;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FfndHSyArVwAQZsbpd1CUY8UJ74t3/0SFuGSjOnWRHI=;
 b=brFqyAmEuT7Nmd2vgCuqJZLWdttdgIe+6DvEb+n4t/pnmfLsd0RCoZrdLMHKr3zEWougt+
 ave2rZ1I1ceC+fMdCKlyRVatD8Vti8e58zMtq6Uj+qnhXRrRB0k2JVDEv0dAKEGZgMH0xi
 /E1fPdLvttFncmLc4lVpoT6j5OE/9GY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-153-xlGEiBKjNoq4TlYgOF-C1Q-1; Wed, 18 Feb 2026 08:26:59 -0500
X-MC-Unique: xlGEiBKjNoq4TlYgOF-C1Q-1
X-Mimecast-MFC-AGG-ID: xlGEiBKjNoq4TlYgOF-C1Q_1771421219
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-435af2d3144so3820864f8f.3
 for <qemu-devel@nongnu.org>; Wed, 18 Feb 2026 05:26:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771421218; x=1772026018; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FfndHSyArVwAQZsbpd1CUY8UJ74t3/0SFuGSjOnWRHI=;
 b=WaZ6f8MhkBLaE4tqIpqNUYmYBehM+x/KALuPbiZYOLhs2bkhSZpO+Uw9eDS1Gd1B6h
 vaGk4EBmdf/Qf9TJSSnp/jv0/NusH/yIa2mArI6ezNasZXb+GYYdGlK3Q5DwO/wjmVIG
 lnyjcd/3UJNqvIg5xKQTHjdr8rGhxEHt4oZMUOhmwxtp3wk4+rFxmuvISossCDS4AyLi
 4/UFqCTLFzG459UxmtsYQqFGHRiuUZl9fP2KPyyV4puTVBOJ/jrpi1v2y75SEYL55YT/
 NAXXy4ex4dl/it13ZwimCUVZyvIrZfHx7s1nqecNoo3//2TAt2U7Sl6o9LRqXmx7w2bE
 PwLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771421218; x=1772026018;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FfndHSyArVwAQZsbpd1CUY8UJ74t3/0SFuGSjOnWRHI=;
 b=JasgSR6HEKXUUTtbax4+6AhYT0ezaLNTBpbaGArYzSOj/9ROBcoKXJw76h6Ywff9fG
 ckaO0xaOX+Jmg2gRlEL+CmANcKgQaouk0V8JvK5arbvNUxCTH2fRG3TDxDUPcBTZSbH4
 gXjpzla32SYUv9l9AUQ4wNqtyueRABnZFL7Cl2evzmADSnFvlMAAreXkdsZyP+tNegjh
 pO1SxkLPl/R2y3Zlj/5WlG+aZuV6DEw+VJ8oSHpg0GnCn9qSYmuPKa9DsLKZ0qmbDox5
 1lpnNtglm2SCIhYSrOP8WObtYEKgevPTMYKSsDXcAGNYRXMlEfCwpVGM8OAjn+7w23To
 EDVQ==
X-Gm-Message-State: AOJu0Yxpsaq1itP5+b18MshIb4Q9fHzi/SyeTaMmCHrbVdVuAjfygZpG
 9ThGu+7zI7nuNU06t26A2g40YQ9wXM0RulsAdGPBDDfr9eDVytu4WN14XWpk73HcHI1ZipBf2PO
 B5/2JMLkKSi3M7MBOQtbspU6an19SA36Nn8ph/j8ZMQ/fUUZ8pSL6rfcG
X-Gm-Gg: AZuq6aLtKpTg0h4GoZgRQ5IM5iRVjWI73sdchPM/uWgjQ1uxCcaE3W+h71IGfEi58vh
 zo1Bt1GuGYVWBCEkG4TSSBsjsIz/Z6f0uOQRmfqw8WMpStdmF8HhlMXxf0ZBxJeuHUb14h8lzZv
 d+qEY6N73akcelFxIM2pDaX8V80WgAvZ+VfnUoCX58W7VeFkj44yqnPDpVNsnRbNHH4ffSnfQzb
 FSgXyerOJ4wZytcoxNIg0+jUUjrGyPJ9O9NYgBl6NqqWtNW8iFaimtqmjxtzNKxzF6AF2YB+UG5
 bdUKRn7PNsprQ8VvA6EtR7d1il2rx8x2e2ya3OUZ0/b5rBPn/527/VXnmkHDYkkD3vRi+7ncBZt
 Fly2jXFVxvYLI1kGQRkrKDMD5087eoplLCDcu9Et4uHGbpKsaLCtE6y6OUwpUAgzkaYArw42xV9
 w/7JYM
X-Received: by 2002:a05:6000:248a:b0:436:38a4:2423 with SMTP id
 ffacd0b85a97d-4379db66905mr26130217f8f.22.1771421218532; 
 Wed, 18 Feb 2026 05:26:58 -0800 (PST)
X-Received: by 2002:a05:6000:248a:b0:436:38a4:2423 with SMTP id
 ffacd0b85a97d-4379db66905mr26130174f8f.22.1771421218078; 
 Wed, 18 Feb 2026 05:26:58 -0800 (PST)
Received: from localhost
 (p200300cfd737d029edef7b8da7441ac2.dip0.t-ipconnect.de.
 [2003:cf:d737:d029:edef:7b8d:a744:1ac2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796abc9b2sm39075481f8f.21.2026.02.18.05.26.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Feb 2026 05:26:56 -0800 (PST)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Brian Song <hibriansong@gmail.com>
Subject: [PATCH v4 06/24] fuse: Destroy session on mount_fuse_export() fail
Date: Wed, 18 Feb 2026 14:26:15 +0100
Message-ID: <20260218132633.29748-7-hreitz@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260218132633.29748-1-hreitz@redhat.com>
References: <20260218132633.29748-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

If mount_fuse_export() fails to mount the session, destroy it.
Depending on the allow_other configuration, fuse_export_create() may
retry this function on error, which may leak one session instance
otherwise.

Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 block/export/fuse.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/block/export/fuse.c b/block/export/fuse.c
index 00bb2ffee4..82560ca071 100644
--- a/block/export/fuse.c
+++ b/block/export/fuse.c
@@ -270,11 +270,17 @@ static int mount_fuse_export(FuseExport *exp, Error **errp)
     ret = fuse_session_mount(exp->fuse_session, exp->mountpoint);
     if (ret < 0) {
         error_setg(errp, "Failed to mount FUSE session to export");
-        return -EIO;
+        ret = -EIO;
+        goto fail;
     }
     exp->mounted = true;
 
     return 0;
+
+fail:
+    fuse_session_destroy(exp->fuse_session);
+    exp->fuse_session = NULL;
+    return ret;
 }
 
 /**
-- 
2.53.0


