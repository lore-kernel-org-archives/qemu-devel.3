Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DA6FCEFD04
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Jan 2026 20:33:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdDkI-00084M-Ap; Tue, 06 Jan 2026 15:33:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vdDkF-00082f-1n
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 15:33:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vdDkC-0006nD-Px
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 15:33:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767731610;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=PgqmqW96IZF43vWiQ+4DLrmwHKPtIJbJoBjCYq16NQs=;
 b=As1i+b6wTjoyyOUF3f6X6HfgcZmbLTq2OTVT+t8cVkHOyTewCPHJ7vIXP6zgVfztV2hvkE
 4zXkqpdEo4KwwaxrLme3jrALFQVxxP2aaAH7xtRahKZHJJsEgmKmuHArm/+LeK07mACWDI
 21L3kaTyae2pnT7KxH44Nv/yO194yZI=
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-dgPr6aANMAqwh34AQy1_SQ-1; Tue, 06 Jan 2026 15:33:28 -0500
X-MC-Unique: dgPr6aANMAqwh34AQy1_SQ-1
X-Mimecast-MFC-AGG-ID: dgPr6aANMAqwh34AQy1_SQ_1767731607
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-2ae6ef97ac5so1785699eec.1
 for <qemu-devel@nongnu.org>; Tue, 06 Jan 2026 12:33:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767731607; x=1768336407; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=PgqmqW96IZF43vWiQ+4DLrmwHKPtIJbJoBjCYq16NQs=;
 b=f4/BEqNZBKz7yUdnRRD/SGeOGYwWUYYKGiRaebjLltnb75C5O24YPkgpC1dtBAJGj6
 9+BeLQnPxCO4/wqT25SFfglOzSL9bHOG1mPsAt2dlQHu93PQSy0DKXrCByk04kIvY6vD
 qAnawPN9fJlrCxfBNntcQ6tSJbKW1Jqp0QEKPOF42H0yEI3GERuiFOXIp6b4MP8M8i9L
 ryIJVEScQvyAE035OVSmeHacLJwnompnVIBw7zc1IGeSEXO2zeoRU1YfsPXP3qZhPHpG
 8j1qt5y/ewXd7Q0/oxBRz3FNQ74g+ITtiFYhYhn2B+g0+MwRCsJsXlderuBSAbN+lMUB
 kfjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767731607; x=1768336407;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PgqmqW96IZF43vWiQ+4DLrmwHKPtIJbJoBjCYq16NQs=;
 b=OeVGN24OrpgseGE6NS4bJSWYF+SMB3WNyIA61qT4VdN8iCFVpbBIr4hr5SagD4ruop
 BXSO4HIKeRrIjSeGmWf3zpfVnkDmEicLZSBglwg7aFs2DeV55TNV/pMc6qOnxg2VZUlg
 CMniQz541YVkd0FnpG7VSZogC24k5LIaEfyEs+3bWG53JpIuwK2O5dtYYs1qCem6/bkm
 GouhZosPPb+Q/QL8r97tvIP0eWpTwv8a2Iz+5ITe/mkAqKMGSxrQmOHDE/QeN91UgBlt
 TFVOBhOEg3lk5gyFE+y693XV/WHwH3vsTJ4bJswDLFGQhOb22a2brq86r6/BHW9mSHZV
 G0Mw==
X-Gm-Message-State: AOJu0YyxjGgYIw9xDJAOExxbs4cCgh1RQkLQvG0OBWDQ5KvFeQhiUH+H
 O1d+KAqoS/LfUAWNedSoIzPPfVAHNyZK45eFqN3YsV6WYfiJFSiuVvHKLzbhtZlY5RzQtdKAe2Z
 VB7QCfqAuDIyOE2BtS+5UlYKl7KqUkDGSmzLEKHNQLct8RwG/lqy1FZnsZr8JBEiZKJLDogjn09
 LOl9sPmEPA22kNQ8MKgFs4Z4osPjKJGodFbx4GBA==
X-Gm-Gg: AY/fxX6DKUy35ly/fv54azgZvhOlMBXyGkQn3abJPnJl+K+ZQKKYSdsgLnmz/J5ZKhX
 9BsfTDkRni21XPQ/gyeELYo89bvp0kau9pAyknNkkAHO+0AEgMlNuTFCjbvyiW5VYg8n8sLU6/r
 6ZvR8qccxdQqxPENmZj9OrzK9nb8vkdsdZexhWLBPkBmUygmB27hA2KtYVHJWLP6Ecc8ln3l3z6
 xIkNxka5K8wB/4WZ6j7jgqsr0DvH7t2gJx8K5ytLdtJ+FG4IF4R8m5dyXrFDKX4Ndaxxverq1dc
 4SZ1coAZUmKpWwUr02Px+BPUwX2hbcb1gVqFvbf9LnIpGChxbe3EDVn6F+grejXr/a2YS4hdYkG
 r
X-Received: by 2002:a05:693c:60ca:b0:2b0:5435:2e04 with SMTP id
 5a478bee46e88-2b17d266983mr212348eec.19.1767731607081; 
 Tue, 06 Jan 2026 12:33:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFhhDFVEYaatxdizWuHI7hWX72yYNzhckU5wmT30IFfkBCsPhJkOHglyihLqcDKZuL/RsXVvg==
X-Received: by 2002:a05:693c:60ca:b0:2b0:5435:2e04 with SMTP id
 5a478bee46e88-2b17d266983mr212324eec.19.1767731606555; 
 Tue, 06 Jan 2026 12:33:26 -0800 (PST)
Received: from x1.com ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2b17078dd84sm4819273eec.17.2026.01.06.12.33.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jan 2026 12:33:26 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Lukas Straub <lukasstraub2@web.de>,
 peterx@redhat.com, Juraj Marcin <jmarcin@redhat.com>
Subject: [PATCH 0/2] tests/migration-test: Small cleanup series on postcopy
 tests
Date: Tue,  6 Jan 2026 15:33:18 -0500
Message-ID: <20260106203320.2110372-1-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
Content-Type: text/plain; charset="utf-8"
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
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This series removes two unnecessary fields in MigrateCommon that was only
for postcopy tests.

Comments welcomed, thanks.

Peter Xu (2):
  tests/migration-test: Remove postcopy_data from MigrateCommon
  tests/migration-test: Remove postcopy_recovery_fail_stage from
    MigrateCommon

 tests/qtest/migration/framework.h      |  7 ++-----
 tests/qtest/migration/framework.c      | 25 ++++++++++++++-----------
 tests/qtest/migration/postcopy-tests.c | 12 ++++--------
 tests/qtest/migration/tls-tests.c      |  8 ++++----
 4 files changed, 24 insertions(+), 28 deletions(-)

-- 
2.50.1


