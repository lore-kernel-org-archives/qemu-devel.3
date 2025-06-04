Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ACCCC5B543
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 13:29:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMoAb-0006u4-Pt; Wed, 04 Jun 2025 09:28:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1uMoAZ-0006sm-Qz
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 09:28:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1uMoAY-0004jI-EZ
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 09:28:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749043717;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7vKpmgPjmhYXTuu7BvlQEe4nDt+V2FcjCdZIcprXjuI=;
 b=iIKe9JVPBNXfSCb+fbJ8elT5OA7POjfUqPcTT3sE953z4talUzyzEC7UfFmSzDHNal3J55
 sCqYimBHZ8rUUX4qIyV8QiKKzMA8XAnPbyOykt1OgbXRweMTzIidTPFqOwZIvj+xSjqcYa
 F4ayaXaF7VmGrLCDZF5NyaZncDVN1r8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-319-PkYiQZ-BO7CrE__QlrKaFg-1; Wed, 04 Jun 2025 09:28:35 -0400
X-MC-Unique: PkYiQZ-BO7CrE__QlrKaFg-1
X-Mimecast-MFC-AGG-ID: PkYiQZ-BO7CrE__QlrKaFg_1749043714
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-450d021b9b1so28762675e9.0
 for <qemu-devel@nongnu.org>; Wed, 04 Jun 2025 06:28:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749043713; x=1749648513;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7vKpmgPjmhYXTuu7BvlQEe4nDt+V2FcjCdZIcprXjuI=;
 b=c39PUGJVWDM+E7QHx2o941EUukMlIRpEEPgPs1tD9MKd5NWYfNyoGDsKdcsMY9fppp
 Ph8EqtfW20MwQhwyFxUDHJu+RgIINw8Qn1W7PQP23v6+Ue/GI2r5IBPF4kF58go1hMyM
 htsw3AlfZstxA/AnVdNtjn0iJlH2z7X0VgSwZJCZ9ro5hU/3fO1BqVq7eMox8nhZ4xUw
 TQWnBdzxMYn0BTJSnjcWYPbbVjIQZKPfUZNoeV6IslCpVQX1ovbbCeiavV29QC+Rqg5K
 RmxD8d0mVxzAjUhYw8cqRbiWmfP9ctilVAPDjMvq7OrhqXB83jIhQS9/AF/0oOp5NyZb
 HSOw==
X-Gm-Message-State: AOJu0Yz/AhIGElyqHN8kwHuQ6On3nl0zZG0mK+XKuGzUSHeyqH3jcpQ/
 tEYMVr+zZ3Y2mOGititQtLs2TLamRudZNv9z3dhDnrELyBBHQfXAEawS8QoVmXkS/pD64pO6dTD
 aoTGbzWzWLaq8aBQuxfRuqAodF4euwqF/lJsfJIFAOAsEJNSHW558dB9t
X-Gm-Gg: ASbGncunG+duODGU1Hhb4WoksgjsaKzjJCo4vpuh+lrhgmgeD83SVJn084Izvlq+TCn
 mdini/KZe+CGpEG3TC0jL3egoeqLaVipIbe8LAzEiBB8nKQ8UQhxrPbqrMSLKAFU68KXQDRk2gc
 ScB4Bhqjx5MpFVruKy1mnfX5y+vOctFXtKpiENcP8+7KMN7DB9OuwsUgC0UKKli2heBSf4AuM/R
 ZKRio21xvxRYaeg+w1atFOH1E1AMfPKbHUXJzjwI+l65XPaxe9H4wNwvXX0qH/S/Z4ZRPTHsIzB
 ILwJCrRO+OTjpUbFN0tttlcOkvqy/UHI3YGoGtNacLt0nCpz70JVxzwKyNf1nmgcvMSMxg==
X-Received: by 2002:a05:600c:1986:b0:43d:42b:e186 with SMTP id
 5b1f17b1804b1-451f0a755c6mr26943585e9.8.1749043713519; 
 Wed, 04 Jun 2025 06:28:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJK0LWshRYFkg0cRC4ULrI049mGhGr5B9gQKECkdnvFbOwxQyLIl3Z7nBkbBgJRQZu5j1NIQ==
X-Received: by 2002:a05:600c:1986:b0:43d:42b:e186 with SMTP id
 5b1f17b1804b1-451f0a755c6mr26943405e9.8.1749043713177; 
 Wed, 04 Jun 2025 06:28:33 -0700 (PDT)
Received: from localhost
 (p200300cfd700f306503d3c798c1bf214.dip0.t-ipconnect.de.
 [2003:cf:d700:f306:503d:3c79:8c1b:f214])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-451ef77b467sm31791285e9.36.2025.06.04.06.28.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Jun 2025 06:28:31 -0700 (PDT)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Brian Song <hibriansong@gmail.com>
Subject: [PATCH v2 04/21] fuse: Explicitly set inode ID to 1
Date: Wed,  4 Jun 2025 15:27:56 +0200
Message-ID: <20250604132813.359438-5-hreitz@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250604132813.359438-1-hreitz@redhat.com>
References: <20250604132813.359438-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Setting .st_ino to the FUSE inode ID is kind of arbitrary.  While in
practice it is going to be fixed (to FUSE_ROOT_ID, which is 1) because
we only have the root inode, that is not obvious in fuse_getattr().

Just explicitly set it to 1 (i.e. no functional change).

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 block/export/fuse.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/export/fuse.c b/block/export/fuse.c
index a93316e1f4..60d68d8fdd 100644
--- a/block/export/fuse.c
+++ b/block/export/fuse.c
@@ -432,7 +432,7 @@ static void fuse_getattr(fuse_req_t req, fuse_ino_t inode,
     }
 
     statbuf = (struct stat) {
-        .st_ino     = inode,
+        .st_ino     = 1,
         .st_mode    = exp->st_mode,
         .st_nlink   = 1,
         .st_uid     = exp->st_uid,
-- 
2.49.0


