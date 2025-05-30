Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60BDAC3ABB2
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 08:46:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKvMe-0005AS-17; Fri, 30 May 2025 04:45:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1uKvMT-000541-BY
 for qemu-devel@nongnu.org; Fri, 30 May 2025 04:45:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1uKvMR-0000rF-U7
 for qemu-devel@nongnu.org; Fri, 30 May 2025 04:45:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748594705;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B5vtQo6scS2XCrA0t0y/9hjFqbhJ1P++sODcfsG33Xo=;
 b=EgwPkiaSZlekP3YNUhqnmlzKHC5HiYW8hCaC1Jwm+G3mlZkXErfT5F4a9L4Uo53+/HVaIX
 isQpo0JRQdzi0c5Bq6JpNdbWOBo/xXShKg/Ul9rauMNxjqT1RMSOUyIMq9tY4dY1J3sfF2
 +EGSl+C4eWI+be4BE/3FWCkUhOPcVb0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-458-5Tf5gHXXMCiaBy_s8-6XBg-1; Fri, 30 May 2025 04:45:04 -0400
X-MC-Unique: 5Tf5gHXXMCiaBy_s8-6XBg-1
X-Mimecast-MFC-AGG-ID: 5Tf5gHXXMCiaBy_s8-6XBg_1748594703
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-450787c8626so11223875e9.1
 for <qemu-devel@nongnu.org>; Fri, 30 May 2025 01:45:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748594703; x=1749199503;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B5vtQo6scS2XCrA0t0y/9hjFqbhJ1P++sODcfsG33Xo=;
 b=TimOMX6Qu05IhV40uNdnpmC/FVaBadhTL7vwu8WhK3DaM96TpOczy03EJQ2b9U6xuS
 tTXu49nkvzyXeGxIr7Wu0WrsoEu9oPInhiAeJF2gs0Sza+VoOAuwCup6cvlxHTJI3OPg
 MBlKYxtMgSznnYDhDI66r/P5h47DHvYFtIdEuWfUMrolq0/tSJiC7eKtgWNhvb3uLrko
 t1w94T1/BpoT2CZXt3MkJWnh5UMB+iurhrcailkywb5aRQKRO34mY1hSPqswBtgwcW7Q
 eRLBbg4p0sd3b/6use+a5/N6rdHb6/QmOqjg4fL2cJN7ibq/JWYkMrsg4VlgN7Hke4fi
 4DrA==
X-Gm-Message-State: AOJu0YzpblcRlfNOsM7HS/sNKyri3hxfYmO6HzXjMrJ05AxXc9fRHQdM
 qtmjO7GnqrQfv4/EOVl9hKnl+bMop//w3waQf9n6J+M3MMg/yOornpu22blZ/3lz8iQXrPpZ2BU
 I+IXAY/MGh4iiOuMze4X7UCcbYDvYLXOwxhGGjmAfDkTchVdFrW762kbj
X-Gm-Gg: ASbGncuLzgpIixxLt2yg9YTHV5Y/ANByo6U9LI2tb2qmUhXKLmq7Lq+pRNpErQZamwb
 pCovvfBODMVX+9ELBto3yXixEFQ0g4dBUcohs+5/0WP1ttM4t/AncOfRoYgu+Br8d4Qc6qOuaig
 17zUtO7j+1oMESqIjzn+LWhT7luWvzbOzDUGpI6/hkWwxTraYCi5xEy+WiabnqfOo+IjF3fomdC
 CwsH8GMqMeGeGsRZXQvOt1wSAQzTl+sx3hiWFeMvw+NgpLPaMwhViwbHWR52d1BUwc4TdFqLZuB
 /4CZ8HmkREVvVEVjJa2t5Jr0IJXkPLgkSf9tpkv7gC58SDtjFGMXXrOY+UhbkDxTleAWxw==
X-Received: by 2002:a05:600c:3b26:b0:44b:1f5b:8c85 with SMTP id
 5b1f17b1804b1-450d65344bamr23259565e9.13.1748594703087; 
 Fri, 30 May 2025 01:45:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFVjbyZ7ZFhtFnX0rvhghU4xb5jFGU0O+6HeOhKyYkCg6do+KmqwvvfPSS24GqWBIAe3ZNEoQ==
X-Received: by 2002:a05:600c:3b26:b0:44b:1f5b:8c85 with SMTP id
 5b1f17b1804b1-450d65344bamr23259335e9.13.1748594702749; 
 Fri, 30 May 2025 01:45:02 -0700 (PDT)
Received: from localhost
 (p200300cfd700f320acd9b9a35df3ddfd.dip0.t-ipconnect.de.
 [2003:cf:d700:f320:acd9:b9a3:5df3:ddfd])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-450d7f9efa3sm11764675e9.9.2025.05.30.01.45.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 01:45:01 -0700 (PDT)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Subject: [PATCH 2/4] qcow2: Simplify size round-up in co_create_opts
Date: Fri, 30 May 2025 10:44:45 +0200
Message-ID: <20250530084448.192369-3-hreitz@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250530084448.192369-1-hreitz@redhat.com>
References: <20250530084448.192369-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.902,
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

Use the now-existing qcow2_opts pointer to simplify the size rounding up
code.

Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 block/qcow2.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index b11cbfd859..988ebcf138 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -4064,8 +4064,7 @@ qcow2_co_create_opts(BlockDriver *drv, const char *filename, QemuOpts *opts,
     }
 
     /* Silently round up size */
-    create_options->u.qcow2.size = ROUND_UP(create_options->u.qcow2.size,
-                                            BDRV_SECTOR_SIZE);
+    qcow2_opts->size = ROUND_UP(qcow2_opts->size, BDRV_SECTOR_SIZE);
 
     /* Create the qcow2 image (format layer) */
     ret = qcow2_co_create(create_options, errp);
-- 
2.49.0


