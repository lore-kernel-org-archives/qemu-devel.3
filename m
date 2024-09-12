Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9130EED618
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 16:12:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1somQV-0000Uw-Q7; Thu, 12 Sep 2024 12:12:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1somQS-00008G-CU
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 12:12:09 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1somQQ-0007QP-7T
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 12:12:08 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2d877dab61fso15746a91.3
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2024 09:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726157524; x=1726762324; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mKjZY38PTxGYr/WbE7V7KdYaVqXpGoHwAiqL2NqOWqw=;
 b=Ppn3uFL2XJz/kA0VUuTZcp7JGu6QKcQ1hhyJbJ4404B54hTqPsQ/+OioBemnzFzL2H
 V8wBRE4u8iOMSmj7auBewFq1GV68mPs4gBwaC4nOZ7A+LxrdHT7qcd4NxwRp4MeuYnXT
 j+nbCycMp15vOJZkWdj9bkI0OjRF/Xx2/A8UJZqQBJXGk2Tg4aFZJvTcxee7LjDd19QW
 iUs0VJzMHr+DavncZtIHelBLH6fZ/LOCgoucGkwkav9WEbVMVklM//Lbb6K5IXpXzYfY
 GWpkBsOWiHu372BZt3njsx1pG064BzpmrZLWvU+OfdbgqkBXO10Qm+V89Low36uuYgyt
 FSQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726157524; x=1726762324;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mKjZY38PTxGYr/WbE7V7KdYaVqXpGoHwAiqL2NqOWqw=;
 b=hm1HqMtCtFzk02/t/ibnb1+UpZX+TuLV1hC/5urhl6FrRAXBzbOwBD2c+5sskAYkKf
 4MlGdCaUAUcyOBBjshV40zj+237UoPAk25XNc2nw8CyLv3iFPLAbNkFmmfLsAn4BxMlq
 WmrMM/LIDbcmkrZQYs7Em3FQ06zTG/z20A4PFGtmtloeFgkKpFedpVw40pOBH7271mZl
 kzPfcAng8T6Yh8KwdDDgWSJXYnwDqV3ml61q6dgDfzm086U9nPVtzKr9qRVISisc1myF
 +AN9LfcF3BnEydmXQmNk72XnlUIsSZd3rk5bDkmnmjl1wyobLAzM0sZEWjkMWUSCtLbH
 LJZQ==
X-Gm-Message-State: AOJu0YzQItTZHVAu/hvzdyaiaUmjkDDdNcgTbOjLkqsDhTddjihv6dvd
 dNg694bYiJZUzb4Fgsvx59oAvntqdr8U7TxXpeXjuXKHMZjUAbzu1KTfF6b04G5AvlvzW/vvg6d
 Pl9pzKZO3
X-Google-Smtp-Source: AGHT+IH3CkARGmsVrMtj/+IMTS0f8rigieK5Yd9oJ8RDmtHm7l5KLlEuNod9V4EkxnpZeL5wBcsOHA==
X-Received: by 2002:a17:90a:9ad:b0:2da:5289:89a2 with SMTP id
 98e67ed59e1d1-2dba0092438mr3361278a91.41.1726157524497; 
 Thu, 12 Sep 2024 09:12:04 -0700 (PDT)
Received: from linaro.vn.shawcable.net ([2604:3d08:9384:1d00::9633])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2db0419aab4sm10868139a91.15.2024.09.12.09.12.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Sep 2024 09:12:04 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, Igor Mammedov <imammedo@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, Weiwei Li <liwei1518@gmail.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>, qemu-s390x@nongnu.org,
 Michael Rolnik <mrolnik@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 kvm@vger.kernel.org, Joel Stanley <joel@jms.id.au>, qemu-riscv@nongnu.org,
 Aurelien Jarno <aurelien@aurel32.net>, Fabiano Rosas <farosas@suse.de>,
 Eduardo Habkost <eduardo@habkost.net>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Peter Xu <peterx@redhat.com>,
 Hyman Huang <yong.huang@smartx.com>, Rob Herring <robh@kernel.org>,
 Peter Maydell <peter.maydell@linaro.org>, Kevin Wolf <kwolf@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Helge Deller <deller@gmx.de>, Jesper Devantier <foss@defmacro.it>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Fam Zheng <fam@euphon.net>, Klaus Jensen <its@irrelevant.dk>,
 Keith Busch <kbusch@kernel.org>, Zhao Liu <zhao1.liu@intel.com>,
 qemu-ppc@nongnu.org, Jean-Christophe Dubois <jcd@tribudubois.net>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>, WANG Xuerui <git@xen0n.name>,
 Laurent Vivier <lvivier@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Bin Meng <bmeng.cn@gmail.com>, Ani Sinha <anisinha@redhat.com>,
 qemu-block@nongnu.org, qemu-arm@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Jason Wang <jasowang@redhat.com>, "Richard W.M. Jones" <rjones@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Corey Minyard <minyard@acm.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 44/48] migration: remove return after g_assert_not_reached()
Date: Thu, 12 Sep 2024 09:11:46 -0700
Message-Id: <20240912161150.483515-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1030.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This patch is part of a series that moves towards a consistent use of
g_assert_not_reached() rather than an ad hoc mix of different
assertion mechanisms.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 migration/dirtyrate.c    | 1 -
 migration/postcopy-ram.c | 7 -------
 migration/ram.c          | 2 --
 3 files changed, 10 deletions(-)

diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
index c03b13b624f..5478d58de36 100644
--- a/migration/dirtyrate.c
+++ b/migration/dirtyrate.c
@@ -229,7 +229,6 @@ static int time_unit_to_power(TimeUnit time_unit)
         return -3;
     default:
         g_assert_not_reached();
-        return 0;
     }
 }
 
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index f431bbc0d4f..0fe9d83d44a 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -1412,40 +1412,34 @@ int postcopy_ram_incoming_init(MigrationIncomingState *mis)
 int postcopy_ram_incoming_cleanup(MigrationIncomingState *mis)
 {
     g_assert_not_reached();
-    return -1;
 }
 
 int postcopy_ram_prepare_discard(MigrationIncomingState *mis)
 {
     g_assert_not_reached();
-    return -1;
 }
 
 int postcopy_request_shared_page(struct PostCopyFD *pcfd, RAMBlock *rb,
                                  uint64_t client_addr, uint64_t rb_offset)
 {
     g_assert_not_reached();
-    return -1;
 }
 
 int postcopy_ram_incoming_setup(MigrationIncomingState *mis)
 {
     g_assert_not_reached();
-    return -1;
 }
 
 int postcopy_place_page(MigrationIncomingState *mis, void *host, void *from,
                         RAMBlock *rb)
 {
     g_assert_not_reached();
-    return -1;
 }
 
 int postcopy_place_page_zero(MigrationIncomingState *mis, void *host,
                         RAMBlock *rb)
 {
     g_assert_not_reached();
-    return -1;
 }
 
 int postcopy_wake_shared(struct PostCopyFD *pcfd,
@@ -1453,7 +1447,6 @@ int postcopy_wake_shared(struct PostCopyFD *pcfd,
                          RAMBlock *rb)
 {
     g_assert_not_reached();
-    return -1;
 }
 #endif
 
diff --git a/migration/ram.c b/migration/ram.c
index 0aa5d347439..81eda2736a9 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1766,13 +1766,11 @@ bool ram_write_tracking_available(void)
 bool ram_write_tracking_compatible(void)
 {
     g_assert_not_reached();
-    return false;
 }
 
 int ram_write_tracking_start(void)
 {
     g_assert_not_reached();
-    return -1;
 }
 
 void ram_write_tracking_stop(void)
-- 
2.39.2


