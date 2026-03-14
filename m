Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FAEB10706FE
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2026 20:16:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w1VOV-0007xi-Ah; Sat, 14 Mar 2026 16:15:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aadhyar.cs24@rvce.edu.in>)
 id 1w1UgG-0007LB-10
 for qemu-devel@nongnu.org; Sat, 14 Mar 2026 15:29:48 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aadhyar.cs24@rvce.edu.in>)
 id 1w1UgE-00066j-55
 for qemu-devel@nongnu.org; Sat, 14 Mar 2026 15:29:47 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-439cd6b09f8so2642187f8f.3
 for <qemu-devel@nongnu.org>; Sat, 14 Mar 2026 12:29:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773516581; cv=none;
 d=google.com; s=arc-20240605;
 b=EgO0JvNkWa4d21EmyWNLAw209owrTrJmyLqCRGYtFow5VmX8mf9gFAxqC/L+/OcaFE
 RY9iVGkIt5BRQBwEjqy4OdevS65wH2qjFXdaC92UV9a50U3uObtPYYPRhNSzxBnooM6w
 an8bw3m8UKVwzC0aSldbbuGcRjTdLCX6ZqVCvNEPKE8SjzKYO8U46UrTGlu0QiUwdSEW
 olcNQFy9tgPFfXbQoc9RkROaac86SDWjeDfGLVuRwye61xrzBGWPTzTzsXiDt3ATzrmD
 nO7+vfiokuvUCxcdFEqhdrV3LKgvKC1d6fNKH/w18kDynlX8bJOTAPU9OsTnpQD6r+1w
 gSkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=xLi4fHtc94ZOaV2+k4cXgPZo2Q77amdrgeIWUHhmgh4=;
 fh=yOUspLkTiWI5rZxuDdxS8UQ4P0ehasFaCWyM57erL08=;
 b=TQDwZkRTKvLOpjQvnmPEbY6GhT+fvxqA9pgzKz94zFescbJSSBM1I7OlBiSUoXQZ3A
 npW5p4m5YuGk9zlI4DzuypvoNCjliSK6Oqw1HP1Io8QC4iZQR+lOPWD4V8lO1tOE27hE
 C1YrLRl+EB7yp/sLDVhsgVAuHWP2rka3CJtHETa8yDO0/yLPflVY47AswazfjVrPJAcO
 ktdks5il3/neKC905YoPL3lP0BfS0AAcofzA2mQlmcM9JO25QEw5qHACH3joqGndtlpG
 2Z5gA4WbQsTLKC/fLKJsGjYjfWw628jbC6NqztDB5CX0boTsKO0nWQbQQS8mk7oDJEB/
 VF+A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rvce-edu-in.20230601.gappssmtp.com; s=20230601; t=1773516581; x=1774121381;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=xLi4fHtc94ZOaV2+k4cXgPZo2Q77amdrgeIWUHhmgh4=;
 b=K5eZzkZRr4Q2zvcLMU4VUCVHeS5zYpwSKtZyHxy3TAZ7oLD4mXqXcVSxBzLsxji7kM
 cwH68e68voAgHxGGEVFr3OSmdWyAg4ACiO01cXZ08h/fTEP0/vMnhT68gprZDGpuCi6+
 7eZTk3ElsbVZ/IuPoq5bNFXJ3/SSMIsa6AN2jZXs6ypcjN7npoq+JNgpZu1lghZeDES3
 +2sg8hyABPJQhf9uUvlkNHfX6xaBPs/iVPYhhzph7qnm2kj+Yd7Lh2Q+dpFYPYz5HYYb
 RXE31h63yzt9jny6gFpXUnYiMt/X+L8a32LQcH+8ku2LPI0I9MnFiiJ4bYkGTN9goAQD
 N9Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773516581; x=1774121381;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xLi4fHtc94ZOaV2+k4cXgPZo2Q77amdrgeIWUHhmgh4=;
 b=VMv/4YeskixRzln27lDqLbrCsj2nYf7WHLmIGkFJvdci2CZaWhP7597f1uy6x3s1pc
 xIZpswSPafitPf1d+/AqgutjIpqnKtk3s7IW5M54gXA+NhBOqXmS4WlGbwtc/V+9jlOk
 fIsd6Nb6ZiC2QTRt4Fhbks+vsnVjI82BN+sPxfMS5f3ErMyvgth40q1Xn90X1duqVeI9
 eWtR/AsFI4fE1bcsFGKoyDDAW2WPUb019nVPTI/Yf7tZjDU2B5ym3M/d1cmht/KG3V3o
 +pfODP/Sxsa/ee/YXyZCuCIF0j3eOxVCRbUYHCMG9yZj/eFIku7qTytP08Zyn5L5TC4c
 nvTw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxzocWDLjy0z7R+1wzgtbjF66dgOTgS9XfoWslhCC1wtgLkzg6vkk/+5VEOmcFJCrV1KvIKZvh1nnW@nongnu.org
X-Gm-Message-State: AOJu0YztUC0Yn3mF2YjEtLrptrujZq3PQFA5KB4e5rHJl0G0PPrqW/ms
 MVLn51FW+Rv51jVDIDRINQ8dSex1qrligoKnXpGt5vWITURxlDDMBhqQG/6zdiha4i24WYgF6A8
 AEDZMCsspxAnF4+QxaYcawRGvUXaaH6PrwiHP3kvrpg==
X-Gm-Gg: ATEYQzx1w06ig0Cs6V19KENRTACUNqoRfl34qUxwaEldCFkjrD0yFjlpRLSn+V1qBYX
 9TZ8ZXxINMdpyz6+djMSW6wpJV1B2q7hDGJqkSHKm6vEAoZvcK8939Ik5bZabn3kOZQrykV4O4t
 6tlolgeBEUOL5RgoMqqzhn0Ayy5onnv9S0gepP7TEFxvdwSbr/gJJBhvtw76J3FI9ES+dYMT7iV
 DSt/0+LRlKK+0nhRb3LAD+tojkdjOEUw7lmk7SGv3EtLpwLKyeU+3XhbEGuf/7b2qjRgCPHJEqu
 LnpN4PdDXxqB8hvpnoWXWLCpff3CXAioZi7bnsDYezFOutROf/aWKyOdofy2S655EOPEixMMKmb
 HFPYsvGSdRW14Vj6waU8iP7lghw==
X-Received: by 2002:a05:6000:1886:b0:439:8f32:8674 with SMTP id
 ffacd0b85a97d-43a04dc4bffmr13937757f8f.53.1773516581083; Sat, 14 Mar 2026
 12:29:41 -0700 (PDT)
MIME-Version: 1.0
From: AADHYA R <aadhyar.cs24@rvce.edu.in>
Date: Sun, 15 Mar 2026 00:59:29 +0530
X-Gm-Features: AaiRm52TMzBYo7nlhg_YzEbgquHeyiv6YT1kV9wMhbUtAT-Iheu9--vL1y1sK8M
Message-ID: <CABHAK8Nuabpy412TgdEqtNJ0tucrqqVupwnZCYrZGmfHFtH5tw@mail.gmail.com>
Subject: [PATCH] hw/audio/fmopl: Convert malloc/free to g_malloc/g_free
To: kraxel@redhat.com
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=aadhyar.cs24@rvce.edu.in; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 14 Mar 2026 16:15:22 -0400
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

As per the QEMU coding style guide, replace standard C malloc()
and free() with GLib's g_malloc() and g_free().

Since g_malloc() safely aborts on out-of-memory errors, the
redundant NULL checks and their associated error-handling paths
have been removed.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1798

Signed-off-by: Aadhya-R <aadhyar.cs24@rvce.edu.in>
---
 hw/audio/fmopl.c | 41 ++++++++++++-----------------------------
 1 file changed, 12 insertions(+), 29 deletions(-)

diff --git a/hw/audio/fmopl.c b/hw/audio/fmopl.c
index a63ad0f04d..79e43d5410 100644
--- a/hw/audio/fmopl.c
+++ b/hw/audio/fmopl.c
@@ -50,7 +50,6 @@ static int opl_dbg_maxchip,opl_dbg_chip;
 /* attack/decay rate time rate */
 #define OPL_ARRATE     141280  /* RATE 4 =  2826.24ms @ 3.6MHz */
 #define OPL_DRRATE    1956000  /* RATE 4 = 39280.64ms @ 3.6MHz */
-
 #define DELTAT_MIXING_LEVEL (1) /* DELTA-T ADPCM MIXING LEVEL */

 #define FREQ_BITS 24                   /* frequency turn          */
@@ -607,26 +606,10 @@ static int OPLOpenTable( void )
         double pom;

         /* allocate dynamic tables */
-       if( (TL_TABLE = malloc(TL_MAX*2*sizeof(int32_t))) == NULL)
-               return 0;
-       if( (SIN_TABLE = malloc(SIN_ENT*4 *sizeof(int32_t *))) == NULL)
-       {
-               free(TL_TABLE);
-               return 0;
-       }
-       if( (AMS_TABLE = malloc(AMS_ENT*2 *sizeof(int32_t))) == NULL)
-       {
-               free(TL_TABLE);
-               free(SIN_TABLE);
-               return 0;
-       }
-       if( (VIB_TABLE = malloc(VIB_ENT*2 *sizeof(int32_t))) == NULL)
-       {
-               free(TL_TABLE);
-               free(SIN_TABLE);
-               free(AMS_TABLE);
-               return 0;
-       }
+    TL_TABLE = g_malloc(TL_MAX * 2 * sizeof(int32_t));
+    SIN_TABLE = g_malloc(SIN_ENT * 4 * sizeof(int32_t *));
+    AMS_TABLE = g_malloc(AMS_ENT * 2 * sizeof(int32_t));
+    VIB_TABLE = g_malloc(VIB_ENT * 2 * sizeof(int32_t));
      ENV_CURVE = g_new(int32_t, 2 * EG_ENT + 1);
         /* make total level table */
         for (t = 0;t < EG_ENT-1 ;t++){
@@ -696,10 +679,10 @@ static int OPLOpenTable( void )
 static void OPLCloseTable( void )
 {
      g_free(ENV_CURVE);
-       free(TL_TABLE);
-       free(SIN_TABLE);
-       free(AMS_TABLE);
-       free(VIB_TABLE);
+    g_free(TL_TABLE);
+    g_free(SIN_TABLE);
+    g_free(AMS_TABLE);
+    g_free(VIB_TABLE);
 }

 /* CSM Key Control */
@@ -1082,9 +1065,9 @@ FM_OPL *OPLCreate(int clock, int rate)
         state_size  = sizeof(FM_OPL);
         state_size += sizeof(OPL_CH)*max_ch;
         /* allocate memory block */
-       ptr = malloc(state_size);
-       if(ptr==NULL) return NULL;
-       /* clear */
+    ptr = g_malloc(state_size);
+
+    /* clear */
         memset(ptr,0,state_size);
         OPL        = (FM_OPL *)ptr; ptr+=sizeof(FM_OPL);
         OPL->P_CH  = (OPL_CH *)ptr; ptr+=sizeof(OPL_CH)*max_ch;
@@ -1128,7 +1111,7 @@ void OPLDestroy(FM_OPL *OPL)
         }
 #endif
         OPL_UnLockTable();
-       free(OPL);
+    g_free(OPL);
 }

 /* ----------  Option handlers ----------       */
--
2.43.0

