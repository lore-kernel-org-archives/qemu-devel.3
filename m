Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 069F6E9A047
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 13:35:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vshfe-0004Er-LZ; Wed, 18 Feb 2026 08:32:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vshfT-0003yk-O0
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 08:32:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vshfA-00053d-NF
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 08:32:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771421521;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OSXZAuWYpAshM63pW80TanRP4MfbiawAfcaxsHKGA1o=;
 b=X8Kqqtp3U+OR89948qfu3+Ic+L8i7cj1A0hfcjBU12GY88r5ocDCs8hixkKMGZmOX6xTJ7
 fCdSP+LMj1hbVyz25G+JyLlONCo6JEIdIFURlcwmpQznEzDjuo1HeknV8incBs/smqzGdK
 ykjuYYCo2pxazFkY/eE1uWdVq2mtYss=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-410-AcYpjjHsOu6HxrSpHx-wQw-1; Wed, 18 Feb 2026 08:26:54 -0500
X-MC-Unique: AcYpjjHsOu6HxrSpHx-wQw-1
X-Mimecast-MFC-AGG-ID: AcYpjjHsOu6HxrSpHx-wQw_1771421213
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4837b7903f3so47974845e9.2
 for <qemu-devel@nongnu.org>; Wed, 18 Feb 2026 05:26:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771421213; x=1772026013; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OSXZAuWYpAshM63pW80TanRP4MfbiawAfcaxsHKGA1o=;
 b=H2BcJRU6SFOe03Z00NrLZcPhhjAJ61rq8D3QxIf4yA7QYXtSSTQ06sUr+0GOIWHxfg
 P8hSed0UgFFbIyTNeuJeeMBkVEdI+V3kh2l9nuK0VduoAtbwW0uCk3JOhnovjR7Hcge+
 P6nbIyYxCqzHKKwp0mAys1t8LGa8Em2dfzT1sD83U7lgaNrTPg5/TunXFrXgY1hvklOz
 kagaK11axt9cWtAh+uKGwKsGZcGPbsQR/78XSq6sqPZBd4Y7ht/nOVBMrYXpNEQDYkS4
 8pTnretYyhJP+O7jB7DkrTi8crJNx+gNyXfaietA/rH+gmlk9xja30f3Mx7pUaHSoyIy
 hsHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771421213; x=1772026013;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OSXZAuWYpAshM63pW80TanRP4MfbiawAfcaxsHKGA1o=;
 b=uivkX7QZExNSJ38dBQK+A/cMNYqpl+SjB3DEWbC4rN4KNPrvzmYUYEMGuZclcEKdx9
 uMpsKB0wNm8P22lH86YV9cDMsveLn261aAGT1kcTTZmF9lQzI49PoNbJe+mbSjNWyHSm
 Kx+BKFjmua4kv4qSrnSQm0MFZNKEBpSovaLy6JfdUupkAShBB/eJ8WEkW+kXBSc6S+Lz
 pK8yYK1rrQsp5gz9A30KPyd5Af52dLru6il5p2ORyMjsZFapg8QDGuFiPxeYjwz5phMa
 wN6idSQ0YX9LMlgDJoRHeo7zaa0IgjoE4DHxAKHtn1ml2MYpD0Zmc124bJUKAf1DBX4B
 M55g==
X-Gm-Message-State: AOJu0YzswJTshlEbQwWZHsn6eIocU9V6oPtaaKeAhOwG83Gn7dWmYbwu
 VDLOwVq4eD+cILvKS6EK/eKIPpF0+nRa6FubPoykq5GupJdL6r3PmjJgFxN9xj0O5I8O9nrDs4u
 t0rrB4F3S1Hi1K2M0sDiHYGV418vhPjte9KXpubZ/h1M77MiYUjUicXin
X-Gm-Gg: AZuq6aI4Bnl5xjp+/y+naqWbexd+bHuCFYCF+YZkWGl00TYEqLmGEe9H5dGYWBN1H0K
 Aet4aOnuYHYa1O0KMOQwSM4YB/lTlE6LptkQpiV7f6XpLwm+VPEtsBGkpFtZOPj/URndtoRgz5t
 faCCFGwVRTFxQ40Uoa0YiGs4/2WijcEH93H1DP1CShqC/XFqmqEj882/YTJXDkDwSqCllfsJGhb
 /yXQOIOFCRKmXbVYwPRZkX6TWMvwQhY0iSs38tAqwm5h/WUppFDMIAF7+aqGefKntRRnDS/QNpN
 PiIWyCFs38tGZZ0QxTXugr5t/6xvCX6bOUIR9QoZUnAqVqM8RUDEeTLPUqejsulOz0RtL768Zlg
 e8MskazLy9Iwk9bITurZapYQBX40WRYQHX8kyLUalABbw9WSsVkpe1MqISy6+ldGFscSJa6ssCF
 FnIddu
X-Received: by 2002:a05:600c:19c6:b0:480:3bba:1ca9 with SMTP id
 5b1f17b1804b1-48398a65e5cmr33300645e9.4.1771421213161; 
 Wed, 18 Feb 2026 05:26:53 -0800 (PST)
X-Received: by 2002:a05:600c:19c6:b0:480:3bba:1ca9 with SMTP id
 5b1f17b1804b1-48398a65e5cmr33300315e9.4.1771421212695; 
 Wed, 18 Feb 2026 05:26:52 -0800 (PST)
Received: from localhost
 (p200300cfd737d029edef7b8da7441ac2.dip0.t-ipconnect.de.
 [2003:cf:d737:d029:edef:7b8d:a744:1ac2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796acffcesm38829881f8f.37.2026.02.18.05.26.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Feb 2026 05:26:51 -0800 (PST)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Brian Song <hibriansong@gmail.com>
Subject: [PATCH v4 04/24] fuse: Explicitly set inode ID to 1
Date: Wed, 18 Feb 2026 14:26:13 +0100
Message-ID: <20260218132633.29748-5-hreitz@redhat.com>
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
index 4cdf527d69..a56f645c05 100644
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
2.53.0


