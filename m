Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 780F6D2FEDC
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 18:55:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkoCq-0005rr-Cl; Tue, 27 Jan 2026 13:54:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vkoBg-00035T-B9
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 13:53:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vkoBe-0000kM-UM
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 13:53:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769539994;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hq+OcBvU/nIAaBDI0fi5KDSmQjBUYY4pgykw1erxlUQ=;
 b=O2keZM4hmQ3uQlvUnzac3KHeEk37lCqX6hp9ZgftTOrIwj7OlClrS9bMxsoX8dueX9Wh7Q
 fg3Yu0TQwrPKkb/jMoZNz94pL9yxAERIwIQ08vAsZFgE3uSSTc7PtY+rR1WMxsDEsjlt5b
 22+9mAD8lTaHRJoz7xPLlMaMBrGaYBo=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-107-3Au40x1tNe65cMURUhK6BQ-1; Tue, 27 Jan 2026 13:53:08 -0500
X-MC-Unique: 3Au40x1tNe65cMURUhK6BQ-1
X-Mimecast-MFC-AGG-ID: 3Au40x1tNe65cMURUhK6BQ_1769539987
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-5014c9ee70bso167953871cf.1
 for <qemu-devel@nongnu.org>; Tue, 27 Jan 2026 10:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769539987; x=1770144787; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hq+OcBvU/nIAaBDI0fi5KDSmQjBUYY4pgykw1erxlUQ=;
 b=d7K8N6p2c8msnBRdQiwQ6SvaNfU32i+Eahr8xufs13O1uat4qRQKVizhIRZWeo1lfW
 wUFgoPKfSGdw+IRB8t52NT5YrrhvNcTaB0zgbzF7dGJrKcUSnlbOGbqMMhL316xQSP0a
 D7m3SZeXx89g8oyMLSoDpcFSFEaXYA6kZvtxhpgtZrEKFhkA6rG9R7otQdFX+Z4RsWPh
 U3Rw8hnWNtEoyE+WkQ1iaCyPyTvqhzFbxiIsYYfTujhwmoFAR5UEVkcDjIGRpFwQT8y6
 eJKsu2lxUdwQcFGdyQVjtSadYObL0A0YNWow6eYb833hpjrEqRopcC4ZJjTqS+xirX0G
 uliw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769539987; x=1770144787;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hq+OcBvU/nIAaBDI0fi5KDSmQjBUYY4pgykw1erxlUQ=;
 b=biVSFKMSM8Q2OFeYv19PH2N9moad/K+66Oja1ywh+66osKP/sr0taDFk+P/XblhRwy
 Nf/fnlWz0biWxAKKfejieTnTgfPRF9Yi/yKoBMTsgtyIhQjz3T2k4F90Dzj0Brs8kjsY
 8tLlYVXDjquGXvVCugFLIhn/TdDKk/pWtgBBrhStRauAE2p+Fu1ZV/Zj759EZGF3PcAw
 kXDNfUTLWD4uhTWVymvL6QW7wHDYx6hJ3SeSJda3Edgri4zVsAEZqyhUhIFihkr+JYzI
 TwcsOXnzC954/fbcHuOTnZrLH1kPzsnHhlZHC8eE90EGa+RW0ge7OFjwa/QE3ohfshoI
 G8XA==
X-Gm-Message-State: AOJu0Yy/hyviGuNTfCoQkDvFbzBI/sfM27u4z1OCeVOJZS+EbXcV9l20
 iU8tCmp9x8O28py8aCHuuSaHI7Mj/xYahknwvq3FD+quIYr2aauD0+bcKqLE5PzQ8WkK72WUAKl
 rQpbcwTsMWY84rAhYB5F9EnjEeZJrJu2ALzQ8Rl24yIg8yabCCJDI1J/c8ogmCdScYehC0bvgZ5
 dbDMGJ5TcPz3Y/ZRW7KQz8D/o2VkP22X9MrgGE6w==
X-Gm-Gg: AZuq6aKWdA+UJ02rl+Cf25050jjuIYRGp1P/bFsjZTVc4E4cEGxbng2PEYBbrhG+1h6
 0SNgCGOLhYaFQ7E+bTBA/CiQvVaRnZi3JNLYGhGFAk4xmBoLLecp7TnOz4rmm6hGlh5yb4whEg4
 XpMvpsDn8oFBG6qacKT4J2XCB12/9lYJrFQ3yi9n2paj4QT8ThYKEnSiELKf3ZOPlqXSfedZHbd
 WZORbUQCCpY65O0XLhyzGWW2xl/ayaY/6QAmxBonDvWP+3aAufomFeETi16oUb+Qpj4V578tP9g
 o4J0XisecXo6HBsfEQh3NDzLelnUsg1FRzedOGmGhUlEPy4elBQlrZmiKQHBmH73+h4MSsRbrSU
 E
X-Received: by 2002:a05:622a:190f:b0:4ee:2510:198a with SMTP id
 d75a77b69052e-5032f8fc0d2mr33352051cf.39.1769539986966; 
 Tue, 27 Jan 2026 10:53:06 -0800 (PST)
X-Received: by 2002:a05:622a:190f:b0:4ee:2510:198a with SMTP id
 d75a77b69052e-5032f8fc0d2mr33351451cf.39.1769539986184; 
 Tue, 27 Jan 2026 10:53:06 -0800 (PST)
Received: from x1.com ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-894d3740e54sm2338466d6.35.2026.01.27.10.53.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 10:53:05 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Lukas Straub <lukasstraub2@web.de>,
 Prasad Pandit <ppandit@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: [PATCH v2 08/24] migration/colo: Use the RAM iterable helper directly
Date: Tue, 27 Jan 2026 13:52:38 -0500
Message-ID: <20260127185254.3954634-9-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260127185254.3954634-1-peterx@redhat.com>
References: <20260127185254.3954634-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

qemu_savevm_state_complete_precopy() has a weird parameter called
"iterable_only".  It's needed because COLO saves device states in advance.

To make dropping that weird parameter easier, let COLO directly use the RAM
iterator helper instead, which should make the code easier to read too.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/colo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/migration/colo.c b/migration/colo.c
index c344943173..f92803dd29 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -469,7 +469,7 @@ static int colo_do_checkpoint_transaction(MigrationState *s,
      * TODO: We may need a timeout mechanism to prevent COLO process
      * to be blocked here.
      */
-    qemu_savevm_state_complete_precopy(s->to_dst_file, true);
+    qemu_savevm_state_complete_precopy_iterable(s->to_dst_file, false);
     qemu_put_byte(s->to_dst_file, QEMU_VM_EOF);
 
     qemu_fflush(fb);
-- 
2.50.1


