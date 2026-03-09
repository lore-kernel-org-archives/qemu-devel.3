Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81CBAEF36E8
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 06:45:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzUMB-0007uW-Pp; Mon, 09 Mar 2026 02:44:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1vzUM9-0007uJ-OD
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 02:44:45 -0400
Received: from mail-vk1-xa2b.google.com ([2607:f8b0:4864:20::a2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1vzUM8-00026o-B4
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 02:44:45 -0400
Received: by mail-vk1-xa2b.google.com with SMTP id
 71dfb90a1353d-56aff27dfebso2857454e0c.1
 for <qemu-devel@nongnu.org>; Sun, 08 Mar 2026 23:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773038683; x=1773643483; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mAku/l+conV0dggG+e6fwfk6f4KYUT5yoO6o2dEMQkk=;
 b=U9zn8q1FxhptkEjXF1bpXwJc0dMGzASNzeSzeJkj7SPhKllG2CsmYZpNI5BD9HWMzq
 21KUBaKNUKRPqLUnX6ccmrlNN3VLQ9PNldobSGsTDLBsuXG4eDQ59xoT2j0TFn+5iAIo
 yOCzYqri7kaYei6t+s/yUvm16CsaFcktVlqYdBabF8lNqRJ9SW/sR/Tz8BiTX/iNFY0f
 keRYrd4Eiix9lFCgzGFzu5gbpGl+Yx0TXHtYFsc03WnyXu58xu5X3Lvv5zi2982MdAaG
 PDug4bzxsRUhDQJ2aVqXsp6lpZ4yrcHffYmUdy1TI68r0mFYssZWCd8Xbk9drDEnLbVt
 wQlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773038683; x=1773643483;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mAku/l+conV0dggG+e6fwfk6f4KYUT5yoO6o2dEMQkk=;
 b=bU277sHCQEZZjyF1q8SlaCk0mA2UW1+kn4UwN3eFH8bUNBfDjCpsfLuMO/Op7l+tDt
 O30OqsVFt21/CtRGiEY8AleOMcsVlFwXZ/9vdmKLAjmMwLHbHksZ4oFs0dPsaD9JBaoG
 eMxLw3Ox50ziaieWkWgm73JdJ8mRzFoqmZSe8xjQ39wYSlbWK+HslmeFeDrxgdxlSOdY
 gHUz3ocUznBrwdMKZKeJcCdJhetl3dh8l1y3iYoW83cUBDWM5Pe499C5S9rDO0emac7u
 oQi1PrXxk9hOLsSRVqRoh8ldDRYm7ulhXDx3aPc5Xy/fqYCcLIVUclQ7szoNJZSuPg5j
 D1EQ==
X-Gm-Message-State: AOJu0Ywnt6uZELdoOyhxdz8MWYvHew/FHiqlYjHCS8vzd3DD4qVakCvK
 gLVbxdH7bB8EDxKyJ39wf7DoTV3Kx8FA7UVQCDoE5bR7DtaNGgdYvWhmiljfKrcG
X-Gm-Gg: ATEYQzy35VCDvnr9Nieh9K/P4EeB7SI+baNN/E0rFLkhuzR2iE7cH46r7cZRL5lWffk
 Z6XEmfNeEbSO0F9nUYF3FhP9iJjxWzPdF/cfYwu8FoegXPwaP23TvGgeWWQXI3lEiDkIL4xLyjn
 RWpwkH1oVnTBUG9lsTl0rNWNtViTN+2BfMI4VsW5wnA0HWGqwyKOIjgBAHJrVCfcwd7uBCU6gBY
 WO38No5oW+d53luzF6IyLp8obd3XdahpLN/05rdKoBtJziZRbSirjbkEwLKiYM7tg9Lp4wuCd1d
 y/hJbcap8VmkHW2kVdHOOJPTXl/FrtQifwPk/HDIGS8Jr6TMI+AmZM9YUtetl1bSXpBKJ4O6mPT
 0fhwicNaQVqkwjhPDpesD/kMo3yIHVJUAgyLDLOszpvzQ7Gen+fnMlRm0ukrpn4M9GIvD6Qufkn
 4qpwXDq3eDGkkUdIWgnpxqR+dC7aXnP5yI6SIIDVs+3kJ8oMwnhgfAywDZ5FrikR+gqCcD
X-Received: by 2002:a05:6122:e46e:b0:567:433b:e903 with SMTP id
 71dfb90a1353d-56b07d79ffcmr4232283e0c.6.1773038682868; 
 Sun, 08 Mar 2026 23:44:42 -0700 (PDT)
Received: from gmail.com (ip190-5-140-138.intercom.com.sv. [190.5.140.138])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-56b0f889ed2sm7456162e0c.13.2026.03.08.23.44.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Mar 2026 23:44:41 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: edgar.iglesias@amd.com,
	xen-devel@lists.xenproject.org
Subject: [PULL v1 1/5] xen: mapcache: Assert mapcache existance
Date: Mon,  9 Mar 2026 07:44:31 +0100
Message-ID: <20260309064436.51860-2-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260309064436.51860-1-edgar.iglesias@gmail.com>
References: <20260309064436.51860-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2b;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-vk1-xa2b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>

Assert that the mapcache was created prior to being used.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
---
 hw/xen/xen-mapcache.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/xen/xen-mapcache.c b/hw/xen/xen-mapcache.c
index 11115f6084..517e5171b7 100644
--- a/hw/xen/xen-mapcache.c
+++ b/hw/xen/xen-mapcache.c
@@ -464,6 +464,8 @@ uint8_t *xen_map_cache(MemoryRegion *mr,
     MapCache *mc = mapcache;
     uint8_t *p;
 
+    assert(mapcache);
+
     if (grant) {
         mc = is_write ? mapcache_grants_rw : mapcache_grants_ro;
     }
@@ -530,6 +532,8 @@ ram_addr_t xen_ram_addr_from_mapcache(void *ptr)
 {
     ram_addr_t addr;
 
+    assert(mapcache);
+
     addr = xen_ram_addr_from_mapcache_single(mapcache, ptr);
     if (addr == RAM_ADDR_INVALID) {
         addr = xen_ram_addr_from_mapcache_single(mapcache_grants_ro, ptr);
@@ -652,6 +656,8 @@ static void xen_invalidate_map_cache_entry_bh(void *opaque)
 
 void coroutine_mixed_fn xen_invalidate_map_cache_entry(uint8_t *buffer)
 {
+    assert(mapcache);
+
     if (qemu_in_coroutine()) {
         XenMapCacheData data = {
             .co = qemu_coroutine_self(),
@@ -709,6 +715,8 @@ static void xen_invalidate_map_cache_single(MapCache *mc)
 
 void xen_invalidate_map_cache(void)
 {
+    assert(mapcache);
+
     /* Flush pending AIO before destroying the mapcache */
     bdrv_drain_all();
 
@@ -776,6 +784,8 @@ uint8_t *xen_replace_cache_entry(hwaddr old_phys_addr,
 {
     uint8_t *p;
 
+    assert(mapcache);
+
     mapcache_lock(mapcache);
     p = xen_replace_cache_entry_unlocked(mapcache, old_phys_addr,
                                          new_phys_addr, size);
-- 
2.43.0


