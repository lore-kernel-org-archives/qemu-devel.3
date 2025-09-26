Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B20BCAC5AE
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 08:21:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v23ap-0001vD-0Y; Fri, 26 Sep 2025 04:14:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v23a3-00011R-S8; Fri, 26 Sep 2025 04:13:31 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v23Zv-0000pd-DD; Fri, 26 Sep 2025 04:13:27 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 877DB157D5E;
 Fri, 26 Sep 2025 11:10:32 +0300 (MSK)
Received: from think4mjt.origo (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 98808290C42;
 Fri, 26 Sep 2025 11:10:33 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Glenn Miles <milesg@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.1.1 22/60] hw/gpio/pca9554: Avoid leak in pca9554_set_pin()
Date: Fri, 26 Sep 2025 11:09:50 +0300
Message-ID: <20250926081031.2214971-22-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.1.1-20250926101857@cover.tls.msk.ru>
References: <qemu-stable-10.1.1-20250926101857@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Peter Maydell <peter.maydell@linaro.org>

In pca9554_set_pin() we have a string property which we parse in
order to set some non-string fields in the device state.  So we call
visit_type_str(), passing it the address of the local variable
state_str.

visit_type_str() will allocate a new copy of the string; we
never free this string, so the result is a memory leak, detected
by ASAN during a "make check" run:

Direct leak of 5 byte(s) in 1 object(s) allocated from:
    #0 0x5d605212ede3 in malloc (/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/qemu-system-arm+0x21f1de3) (
BuildId: 3d5373c89317f58bfcd191a33988c7347714be14)
    #1 0x7f7edea57b09 in g_malloc (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x62b09) (BuildId: 1eb6131419edb83b2178b68282
9a6913cf682d75)
    #2 0x7f7edea6d4d8 in g_strdup (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x784d8) (BuildId: 1eb6131419edb83b2178b68282
9a6913cf682d75)
    #3 0x5d6055289a91 in g_strdup_inline /usr/include/glib-2.0/glib/gstrfuncs.h:321:10
    #4 0x5d6055289a91 in qobject_input_type_str /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../qapi/qo
bject-input-visitor.c:542:12
    #5 0x5d605528479c in visit_type_str /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../qapi/qapi-visit
-core.c:349:10
    #6 0x5d60528bdd87 in pca9554_set_pin /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../hw/gpio/pca9554.c:179:10
    #7 0x5d60549bcbbb in object_property_set /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../qom/object.c:1450:5
    #8 0x5d60549d2055 in object_property_set_qobject /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../qom/qom-qobject.c:28:10
    #9 0x5d60549bcdf1 in object_property_set_str /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../qom/object.c:1458:15
    #10 0x5d605439d077 in gb200nvl_bmc_i2c_init /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../hw/arm/aspeed.c:1267:5
    #11 0x5d60543a3bbc in aspeed_machine_init /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../hw/arm/aspeed.c:493:9

Make the state_str g_autofree, so that we will always free
it, on both error-exit and success codepaths.

Cc: qemu-stable@nongnu.org
Fixes: de0c7d543bca ("misc: Add a pca9554 GPIO device model")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250821154459.2417976-1-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
(cherry picked from commit 3284d1c07cfd8d42aa27d1cf83d3e65fcd62e35e)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/gpio/pca9554.c b/hw/gpio/pca9554.c
index de3f883aee..eac0d23be3 100644
--- a/hw/gpio/pca9554.c
+++ b/hw/gpio/pca9554.c
@@ -174,7 +174,7 @@ static void pca9554_set_pin(Object *obj, Visitor *v, const char *name,
     PCA9554State *s = PCA9554(obj);
     int pin, rc, val;
     uint8_t state, mask;
-    char *state_str;
+    g_autofree char *state_str = NULL;
 
     if (!visit_type_str(v, name, &state_str, errp)) {
         return;
-- 
2.47.3


