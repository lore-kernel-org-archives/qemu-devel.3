Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C8E606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 18:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=ur1e9dyx
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRZnr-0006AU-M7; Thu, 12 Nov 2026 13:45:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xRZne-0005ye-1q; Thu, 12 Nov 2026 13:45:31 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xRZna-0003Ql-AT; Thu, 12 Nov 2026 13:45:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1794509113; bh=aBEhcjk6o/6oQ4ewrGXzqDuryr/LtYKBeu3C+MTnkjs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=ur1e9dyxW7aq3+azCRopoQogMaxwZ6GpH+jeWxSzgybQ7wegLby7/B0DbeU/ob/5N
 zDEfXhjBnPibXXRjOkI+3D00X/THlzf4wk3SZgEvqzC7y4yCVtAeVPEfy8/pl6umgD
 mbY088YmapQ5S4mv2dtAZzh0Krw4RxrsUaBEciUcVrYjb0egiP+5Rm3yJNv7r8jQkn
 MQOeZETE3NlQpCLgf679l5Oe4g2LnHKTZiTmffSMHxOHz1RLKbxCZsrvhscdC+9Mw+
 qVIEcz5ljKtJZVsTZawRw442hZX+UvGJXET347+YMRHvIqkZn4VJMbOwL4ZJ4k0SwS
 zW3DSfgUGgzAw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 80D1E1E5D1D;
 Thu, 12 Nov 2026 21:45:13 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 7043C45AAD7;
 Thu, 12 Nov 2026 21:45:13 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 50F14B7C50; Thu, 12 Nov 2026 21:45:13 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Lucas Cardoso <luc.fast2004@gmail.com>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 2/6] hw/audio/fmopl.c: Convert malloc, free to g_malloc0,
 g_new and g_free
Date: Thu, 12 Nov 2026 21:45:05 +0300
Message-ID: <20261112184513.2324634-3-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261112184513.2324634-1-mjt@tls.msk.ru>
References: <20261112184513.2324634-1-mjt@tls.msk.ru>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Lucas Cardoso <luc.fast2004@gmail.com>

In accordance with QEMU's coding style guidelines, replace raw memory
allocation functions (malloc/free) with their GLib equivalents
(g_new/g_malloc0/g_free/g_clear_pointer).

Also removes the old generic error-handling code from
OPLOpenTable(), since the Glib functions abort the program automatically
if memory is exhausted.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/1798
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Lucas Cardoso <luc.fast2004@gmail.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 hw/audio/fmopl.c | 43 ++++++++++++-------------------------------
 1 file changed, 12 insertions(+), 31 deletions(-)

diff --git a/hw/audio/fmopl.c b/hw/audio/fmopl.c
index a63ad0f04d5..91fe806fd66 100644
--- a/hw/audio/fmopl.c
+++ b/hw/audio/fmopl.c
@@ -607,26 +607,10 @@ static int OPLOpenTable( void )
 	double pom;
 
 	/* allocate dynamic tables */
-	if( (TL_TABLE = malloc(TL_MAX*2*sizeof(int32_t))) == NULL)
-		return 0;
-	if( (SIN_TABLE = malloc(SIN_ENT*4 *sizeof(int32_t *))) == NULL)
-	{
-		free(TL_TABLE);
-		return 0;
-	}
-	if( (AMS_TABLE = malloc(AMS_ENT*2 *sizeof(int32_t))) == NULL)
-	{
-		free(TL_TABLE);
-		free(SIN_TABLE);
-		return 0;
-	}
-	if( (VIB_TABLE = malloc(VIB_ENT*2 *sizeof(int32_t))) == NULL)
-	{
-		free(TL_TABLE);
-		free(SIN_TABLE);
-		free(AMS_TABLE);
-		return 0;
-	}
+    TL_TABLE = g_new(int32_t, TL_MAX * 2);
+    SIN_TABLE = g_new(int32_t *, SIN_ENT * 4);
+    AMS_TABLE = g_new(int32_t, AMS_ENT * 2);
+    VIB_TABLE = g_new(int32_t, VIB_ENT * 2);
     ENV_CURVE = g_new(int32_t, 2 * EG_ENT + 1);
 	/* make total level table */
 	for (t = 0;t < EG_ENT-1 ;t++){
@@ -695,11 +679,11 @@ static int OPLOpenTable( void )
 
 static void OPLCloseTable( void )
 {
-    g_free(ENV_CURVE);
-	free(TL_TABLE);
-	free(SIN_TABLE);
-	free(AMS_TABLE);
-	free(VIB_TABLE);
+    g_clear_pointer(&ENV_CURVE, g_free);
+    g_clear_pointer(&TL_TABLE, g_free);
+    g_clear_pointer(&SIN_TABLE, g_free);
+    g_clear_pointer(&AMS_TABLE, g_free);
+    g_clear_pointer(&VIB_TABLE, g_free);
 }
 
 /* CSM Key Control */
@@ -1081,11 +1065,8 @@ FM_OPL *OPLCreate(int clock, int rate)
 	/* allocate OPL state space */
 	state_size  = sizeof(FM_OPL);
 	state_size += sizeof(OPL_CH)*max_ch;
-	/* allocate memory block */
-	ptr = malloc(state_size);
-	if(ptr==NULL) return NULL;
-	/* clear */
-	memset(ptr,0,state_size);
+    /* allocate memory block and zero-initialize */
+    ptr = g_malloc0(state_size);
 	OPL        = (FM_OPL *)ptr; ptr+=sizeof(FM_OPL);
 	OPL->P_CH  = (OPL_CH *)ptr; ptr+=sizeof(OPL_CH)*max_ch;
 	/* set channel state pointer */
@@ -1128,7 +1109,7 @@ void OPLDestroy(FM_OPL *OPL)
 	}
 #endif
 	OPL_UnLockTable();
-	free(OPL);
+    g_free(OPL);
 }
 
 /* ----------  Option handlers ----------       */
-- 
2.47.3


