Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDCC5D58B11
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2026 05:31:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w1e4F-0008PA-Sp; Sun, 15 Mar 2026 01:31:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aadhyar.cs24@rvce.edu.in>)
 id 1w1e48-0008OH-Dy
 for qemu-devel@nongnu.org; Sun, 15 Mar 2026 01:31:04 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aadhyar.cs24@rvce.edu.in>)
 id 1w1e46-0006pz-0j
 for qemu-devel@nongnu.org; Sun, 15 Mar 2026 01:31:04 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4853aec185aso28679845e9.1
 for <qemu-devel@nongnu.org>; Sat, 14 Mar 2026 22:31:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773552659; cv=none;
 d=google.com; s=arc-20240605;
 b=fCZa8XL2mWd7Pbq2rlaxc99WAUDh60naFR5veA0KaE2Gy2X7sRAusqrg6AMRnFWRWZ
 RKeIF+qR5DPqkfHnddYpcqjUuaf87S02Wx2ooaa17Kut8GluiCkj0ZwMQ1MIIHXOE0UE
 ldMJGwwWPYD4R3UZBvOsgfHvtHXfXWSU1TsmAZ6as/x2QZNwePiyMUz4psCLgOuOOpIM
 TC6ScygX3DJsxqYcrRTo7XnZOyARtSERdO5BI5OCiWmiinZAyyAiTQ9BKeiEnQP1MyiG
 vRcYEb0jNrAGBnHLDXvj9/PxhfaZYrxXmIZsVBOtLL8gs3NJHnpj3mu8S5fCoWStxzYM
 MgGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=CfyygR+sECrrOERmmBzcfpk+QvGnGA8OCfr7siflh38=;
 fh=dfx/BUzZk58VBi4dkwqAosHy/Z7rEQlpTCxf1qi7Rqo=;
 b=ADJ3Zeopp7Qmw5Nu1frpbFBGPdFAxzQyyJJTnT9sgmO9CBLSrKVKXUI9rLV/H24GO7
 s793jsNIedUtJUJCeSBL4xkChnsjLOHS/pu3sQ5QUdMhYZD3KqEp+FBQpvkZP/3w27Og
 H/KkVKZ410siByGgsIAydNcqliaIhwn1mXuxuGIyqazbB4vGGEBaVO2i5V4FEeC31taS
 U4Ens0geGaBKnDNWSjZm//YU+sbNCpn38BYs66iRy1uyNXR+CNiRlHFEhHVjHu3rkmdv
 BfAhMThAJjaz/mCdEEk6sLidL4OwhgZg6ZlSPDeilgj9YSchx2CBuUhoN7s9zYdWIUdM
 sBbw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rvce-edu-in.20230601.gappssmtp.com; s=20230601; t=1773552659; x=1774157459;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=CfyygR+sECrrOERmmBzcfpk+QvGnGA8OCfr7siflh38=;
 b=y7JmnPJSOB3Mn/lWk2kg5ORp6WmmQjR+5sFbU2NPJhQW+iDxyepptQWYXo6B/0HsqK
 gietdFmqSL8vEeMpYXQEh+ZYFhcuCjyOw/v58/nVDDVlIrNPdgSc9YNiIYJu9BCOgbif
 r5KxoiQGGRiiwqINILXs4zhoo0U1TQYjEZ6KZ2lZrkkS9+q4uBzWKiAdz97RAF77Bf/f
 KftTpwu25xbxv1fXnAMCZsBEyFJ96JDcYG8eEKP+hubIUZ1BfSHDJM5nfiOxrkunL1gF
 ycSHJMMB5lKtRWM7TlxuZiJ5bhGUlFSAEsbA+3oG74RwcY50azZWsBvyWnLTm53itk05
 1fhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773552659; x=1774157459;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CfyygR+sECrrOERmmBzcfpk+QvGnGA8OCfr7siflh38=;
 b=I9AllJSSjqVeWQmaEJmSUDV87Xyog+YfOy4KfHnSANGRQ+mnbANXHsKo7C/fAGJjmW
 t7nu1DDFhhUnUCos1OyV/Z1RWqWMoetmFfenKCsn1Iqby7YOaO8ck11pmcgpj+9UyfK0
 XIn6VoozgkFuGs6tZzh+0cS1y/yVHIN5ieeQPlI5diW1v07tSLh7ukkJeat4XtxM3akx
 wn8R2/0h2i1twM+K3s0z3kDZbKWMsIQgfa/k8U7TZ6VgFgJPUSEezjz4rV4hv/eojatX
 xyRTaTU4v4m3szrgGbK9CNljOEi3hL2BqVnu1IZzEMvdZEdFmMkeJ/5SWAyDc03OT7or
 pMxg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNu/QcIXzM1OhDTFS4KJZ68e69N/DsN5mSK7qNt/8sPD//vCtMxJNmOG5/h8e2+EJ8fxYOBCLaBGxP@nongnu.org
X-Gm-Message-State: AOJu0YxZtOiYSVjDfLOyQanSZNjKipvC+Be3G0V/bwCo5aF4SCpoi6CU
 +hXSjNBoQxdmaNuNTszXyqKQTv05gl9xQL5ki88BSibsELXgAllV9ohmJnaas+DOgorBH7ijkTk
 FCfZkftvgIuwX4y1Aghm8ivNqNrD4gEHlsEDqzndu7w==
X-Gm-Gg: ATEYQzxYqz168YvR1TbF6ig/OHU48hHZhhNNSYB7HmHmPUD1BluPqWdTmTBlU2DQUtL
 +qJGgkH8ISJK3PzBCwVI3qeilgZslyvNNOHfF0OejhKwwsd+CAZcOUO46bUNJunusTE4ZBWJWWU
 05YUPA4zqMfKJ/hJ5gHJ27NX2MxET/rTxGEVmD8MGMK0zcBuDJLJ0yEvIHTAaVq6jRGMm2jMpM0
 IJps4EajpwdrxevhUFdMyLfpBsjZ75WRejYV5V4R9ULOe4WreifN3EpTMBalb7AO7TYDpIjypS5
 yU06mj8OmkdZFi6Iwo5VUpY/dnwvW32/euyZfnQXU/TCqSOCEUxpqXGaJSgej3Th/i3FVCBHvmR
 W2YLCiTjIICj6cShraVZB/882wQ==
X-Received: by 2002:a05:600c:a46:b0:485:3bb5:92c5 with SMTP id
 5b1f17b1804b1-485566d52c8mr150093825e9.14.1773552658767; Sat, 14 Mar 2026
 22:30:58 -0700 (PDT)
MIME-Version: 1.0
From: AADHYA R <aadhyar.cs24@rvce.edu.in>
Date: Sun, 15 Mar 2026 11:00:47 +0530
X-Gm-Features: AaiRm51T85fm4nc5M48-zs4j7ctlFbYz9MPb-19UWK-zR_090tJcs5lWsQv7pu8
Message-ID: <CABHAK8MozZd5SkxsCQTxHR9xbGfWdJii7dAJEgCJS_yMVtN0+A@mail.gmail.com>
Subject: [PATCH v3] hw/audio/fmopl: Convert malloc/free to g_malloc/g_free
To: kraxel@redhat.com
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=aadhyar.cs24@rvce.edu.in; helo=mail-wm1-x334.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From 4311b6e7ea205c16a96cb7f4392b26db9e7b4d6f Mon Sep 17 00:00:00 2001
From: Aadhya R <aadhyar.cs24@rvce.edu.in>
Date: Sat, 14 Mar 2026 08:22:51 +0000
Subject: [PATCH v3] hw/audio/fmopl: Convert malloc/free to g_malloc/g_free

As per the QEMU coding style guide, replace standard C malloc()
and free() with GLib's g_malloc() and g_free().

Since g_malloc() safely aborts on out-of-memory errors, the
redundant NULL checks and their associated error-handling paths
have been removed.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1798

Signed-off-by: Aadhya R <aadhyar.cs24@rvce.edu.in>
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

 #define FREQ_BITS 24 /* frequency turn          */
@@ -607,26 +606,10 @@ static int OPLOpenTable( void )
  double pom;

  /* allocate dynamic tables */
- if( (TL_TABLE = malloc(TL_MAX*2*sizeof(int32_t))) == NULL)
- return 0;
- if( (SIN_TABLE = malloc(SIN_ENT*4 *sizeof(int32_t *))) == NULL)
- {
- free(TL_TABLE);
- return 0;
- }
- if( (AMS_TABLE = malloc(AMS_ENT*2 *sizeof(int32_t))) == NULL)
- {
- free(TL_TABLE);
- free(SIN_TABLE);
- return 0;
- }
- if( (VIB_TABLE = malloc(VIB_ENT*2 *sizeof(int32_t))) == NULL)
- {
- free(TL_TABLE);
- free(SIN_TABLE);
- free(AMS_TABLE);
- return 0;
- }
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
- free(TL_TABLE);
- free(SIN_TABLE);
- free(AMS_TABLE);
- free(VIB_TABLE);
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
- ptr = malloc(state_size);
- if(ptr==NULL) return NULL;
- /* clear */
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
- free(OPL);
+    g_free(OPL);
 }

 /* ----------  Option handlers ----------       */
-- 
2.43.0

