Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3E7BC369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 20:38:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAEBj-0003ss-7C; Wed, 30 Apr 2025 16:37:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nirsof@gmail.com>)
 id 1uAEBK-0003o9-C7; Wed, 30 Apr 2025 16:37:26 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nirsof@gmail.com>)
 id 1uAEBI-00058b-1B; Wed, 30 Apr 2025 16:37:26 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43d07ca6a80so974155e9.1; 
 Wed, 30 Apr 2025 13:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746045442; x=1746650242; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FezD9o4HBtunhoJni0vWvvx8SujAmPTZFmcLMt03WcQ=;
 b=XOJ84g+kvGsI36MrpReIORv6mVSYt/gmaK4dshcNLJiWEd2ffO3m5+2CVpmvXCIOTA
 nnWOwHdq6oqPf9lvOC2TVzkteBXVT5osecFCQ0Fe+PQpqn332Rpg9wEADUem1k7mjBn3
 E0B47jkgwr8cOr9wTE2RHhUZ3vDTa6Fm5B/YrAQK3XB12C6GWHoADIEu8gKbjSem6Mpa
 PI0+Adgclt75SE11dHBl2zZ/dsj51Qlj5B0Qw1rc787ycd4AEVLHms6jRHXM4wvBmAag
 KZtunsDO6HeD5VBB8Ls2va4eCFyj91KivIGZStrAhzrsc/Nr5gUvaKolGhkPNTTvXlsg
 qA5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746045442; x=1746650242;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FezD9o4HBtunhoJni0vWvvx8SujAmPTZFmcLMt03WcQ=;
 b=QkKd5j9d6V7jVEyLUpcj/DUTmITWthT7uAhndyY7HfYADD1EIAgprgPP1SApY/yvKs
 pwULULGDnDNixfXvODWGDBryPG9GyHm3vmm5yRctY1CXFJUXEOr9yf7WplAa/DqckRfb
 IyUcv5DqKm7DLs6keDHQm3sry5jS3ubIW5ayaRg6MdI55wU+NEcT3b31fsEurxwSUwkl
 6/Yb2gYFRmo2kzz6kXkiTl74AoZsLRh1MB0H2u4JtAZzBatHm/SbNsOLhp6ttZv98MJH
 zT2mBZ6biLpEJsDtD1kmALhFjqjI30BonOdC2muCRErpf6NW01PDHlefiqur0ahOf0rs
 5leQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUxDNk66fSTcBSLOgKWVlzRcheCrnBKyTWyoB0MdPFwcMDcclzyu/xSNPWnc5DwKD621iKg1dDNGSee@nongnu.org
X-Gm-Message-State: AOJu0Yww0MoDOCGKXZV3Rl504euHqVOIvAA8dm8+LNbv620HA3Hagb7v
 A6zWsu9/8mg8UZkKyEusCVac5CGKngHhiTlt1AikQP2xZVLBVyE6QZDhCla9
X-Gm-Gg: ASbGncu6WHUUARts902RwolddagO/eLmp27zq+tlJYNCLOU6HWayr/uFi6N8MOsZOL0
 epUyJWx+CB5CsqiO8RyX5k130HcXj6sUYmP/XXRfiEj/obUhKFAqz6U+i9akAO2CKDVKDftCIDm
 k264VzeYG/tFAN+eqXzBXbQ8DeEp08y0FMgVsjY69P1dzMQtkm8dAriuHQDxmuMAmU1YiGcNYou
 QPfGQanfSIFefMIXkYrnmJEfVsH/qvdVzwmxlQA+QtTFazYcoCNSs6PaVpriyhl/GFlgz9SSnPh
 x6sPZ0AcfRRrQ0vQcjPsRw3T3pi0p7rqxJts6xIeZgS03RmaNVGsXTBjWqVu9MyWEhcu6hjOqwX
 IAbH9uxX7uQIFUxvj9rckW40=
X-Google-Smtp-Source: AGHT+IHEmwfEQrPKep3Dx2PdBnlv60yH/Y5sJltGVPPFWY4ekkPDHt+C7f3NiNRU+AB+0kyQyzsZCg==
X-Received: by 2002:a05:600c:cce:b0:43d:4e9:27ff with SMTP id
 5b1f17b1804b1-441b2635446mr37096345e9.7.1746045441639; 
 Wed, 30 Apr 2025 13:37:21 -0700 (PDT)
Received: from localhost.localdomain (46-116-102-127.bb.netvision.net.il.
 [46.116.102.127]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b2bb3f72sm35455665e9.21.2025.04.30.13.37.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 30 Apr 2025 13:37:21 -0700 (PDT)
From: Nir Soffer <nirsof@gmail.com>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Fam Zheng <fam@euphon.net>, Hanna Reitz <hreitz@redhat.com>,
 Nir Soffer <nirsof@gmail.com>
Subject: [PATCH v2 1/2] block/null: Report DATA if not reading zeroes
Date: Wed, 30 Apr 2025 23:37:16 +0300
Message-Id: <20250430203717.16359-2-nirsof@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250430203717.16359-1-nirsof@gmail.com>
References: <20250430203717.16359-1-nirsof@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=nirsof@gmail.com; helo=mail-wm1-x330.google.com
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

If read-zeroes is not set, we did not report BDRV_BLOCK_DATA or
BDRV_BLOCK_ZERO. This is not consistent with other drivers and can
confuse users or other programs:

    % qemu-img map --output json "json:{'driver': 'raw', 'file': {'driver': 'null-co', 'size': '1g'}}"
    [{ "start": 0, "length": 1073741824, "depth": 0, "present": false, "zero": false, "data": false, "compressed": false}]

    % qemu-nbd "json:{'driver': 'raw', 'file': {'driver': 'null-co', 'size': '1g'}}" &

    % nbdinfo --map nbd://127.0.0.1
             0  1073741824    1  hole

With this change we report DATA in this case:

    % ./qemu-img map --output json "json:{'driver': 'raw', 'file': {'driver': 'null-co', 'size': '1g'}}"
    [{ "start": 0, "length": 1073741824, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": 0}]

    % ./qemu-nbd "json:{'driver': 'raw', 'file': {'driver': 'null-co', 'size': '1g'}}" &

    % nbdinfo --map nbd://127.0.0.1
             0  1073741824    0  data

Signed-off-by: Nir Soffer <nirsof@gmail.com>
---
 block/null.c         | 4 +---
 qapi/block-core.json | 5 +++--
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/block/null.c b/block/null.c
index dc0b1fdbd9..7ba87bd9a9 100644
--- a/block/null.c
+++ b/block/null.c
@@ -239,9 +239,7 @@ static int coroutine_fn null_co_block_status(BlockDriverState *bs,
     *map = offset;
     *file = bs;
 
-    if (s->read_zeroes) {
-        ret |= BDRV_BLOCK_ZERO;
-    }
+    ret |= s->read_zeroes ? BDRV_BLOCK_ZERO : BDRV_BLOCK_DATA;
     return ret;
 }
 
diff --git a/qapi/block-core.json b/qapi/block-core.json
index b1937780e1..7c95c9e36a 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -3293,8 +3293,9 @@
 #     requests.  Default to zero which completes requests immediately.
 #     (Since 2.4)
 #
-# @read-zeroes: if true, reads from the device produce zeroes; if
-#     false, the buffer is left unchanged.
+# @read-zeroes: if true, emulate a sparse image, and reads from the
+#     device produce zeroes; if false, emulate an allocated image but
+#     reads from the device leave the buffer unchanged.
 #     (default: false; since: 4.1)
 #
 # Since: 2.9
-- 
2.39.5 (Apple Git-154)


