Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D4A2C87FD2
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 08:31:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukIV5-00013Y-4a; Fri, 08 Aug 2025 04:30:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangyuquan1236@phytium.com.cn>)
 id 1ukIUy-00012X-Lj; Fri, 08 Aug 2025 04:30:48 -0400
Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net ([209.97.181.73])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wangyuquan1236@phytium.com.cn>)
 id 1ukIUt-0001ZZ-7B; Fri, 08 Aug 2025 04:30:48 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwDHJeKntZVo2nb9BA--.49389S2;
 Fri, 08 Aug 2025 16:30:31 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAfwBH0gmNtZVoag0NAA--.18908S11;
 Fri, 08 Aug 2025 16:30:26 +0800 (CST)
From: wangyuquan <wangyuquan1236@phytium.com.cn>
To: tangtao1634@phytium.com.cn, qemu-devel@nongnu.org,
 Fan Ni <fan.ni@samsung.com>, Peter Maydell <peter.maydell@linaro.org>,
 mst@redhat.com
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-cxl@vger.kernel.org,
 linuxarm@huawei.com, qemu-arm@nongnu.org,
 Yuquan Wang <wangyuquan1236@phytium.com.cn>,
 Itaru Kitayama <itaru.kitayama@linux.dev>,
 =?utf-8?q?Philippe_Mathieu-Daud?= =?utf-8?q?=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v13 1/5] hw/cxl-host: Add an index field to
 CXLFixedMemoryWindow
Date: Fri,  8 Aug 2025 16:29:57 +0800
Message-ID: <20250513111455.128266-2-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250513111455.128266-1-Jonathan.Cameron@huawei.com>
References: <20250513111455.128266-1-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-Patchwork-Submitter: Jonathan Cameron <Jonathan.Cameron@huawei.com>
X-Patchwork-Id: 14086646
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384
 (256/256 bits)) (No client certificate requested) by smtp.subspace.kernel.org
 (Postfix) with ESMTPS id 73AE9244669 for <linux-cxl@vger.kernel.org>;
 Tue, 13 May 2025 11:15:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
 t=1747134932; cv=none;
 b=RFQozbWnCG4HgYZ1BY9ZHb5+wk6od07pH8/tOW19WAKPs6Wsl4Tx97jaoQ18naqZ0bBDD48qlGIV5MfUfP5cLMTMvQGDt1CF3keZYJxpgRbjy1o5oW1NG8c0s/McNXSQO9xNHppIJOGXazLSE/yDXQ/eiNJ8tDKcdNuC4K8Kx88=
ARC-Message-Signature: i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
 t=1747134932; c=relaxed/simple;
 bh=QrlUL6ksvmHFzyBFbponr1B6MIoULBZBLeJlHSYQf8I=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References: MIME-Version:Content-Type;
 b=hULxJVWtnNPbo75dEmcwuFxBEUTZCR4BW0IJLAxYAVqHr0puqFR0aOxx6Qy9Ur7VHWSled98FAIBD3ZuAjPJIC4fpQPE3u0xjtnhhBYXRU+fvEfLZC2Dm4Zy8/5+CZXd4WREA44d5CTvcE46DXhxWYGM+bgst1jI/JdnySmBDGI=
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com;
 arc=none smtp.client-ip=185.176.79.56
Received: from mail.maildlp.com (unknown [172.18.186.31]) by
 frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZxYm15Khsz6GD81;
 Tue, 13 May 2025 19:14:57 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71]) by
 mail.maildlp.com (Postfix) with ESMTPS id 1854E1402A5;
 Tue, 13 May 2025 19:15:28 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 13 May 2025 13:15:27 +0200
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
MIME-Version: 1.0
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 frapeml500008.china.huawei.com (7.182.85.71)
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwBH0gmNtZVoag0NAA--.18908S11
X-CM-SenderInfo: 5zdqw5pxtxt0arstlqxsk13x1xpou0fpof0/1tbiAQAQAWiU-30C6wAEsD
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=wangyuquan
 1236@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW7ur43Cw4DtFWDXw1UZFyDGFg_yoW8Cw1kpF
 4kurW2gF18GrZYkF40qa9rtwn5Ww4DWFsxCrZxuwn5A3WUtrW7tFnxKa9rAa48CrZ5KF1r
 GF1S9rn0qa1UtrUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=209.97.181.73;
 envelope-from=wangyuquan1236@phytium.com.cn;
 helo=zg8tmja5ljk3lje4ms43mwaa.icoremail.net
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, MAILING_LIST_MULTI=-1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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
Message-ID: <20250808082957.vHpYIyTubuONPz03XR98J28_t6LuSw1hbl-LfyBpNRA@z>

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

To enable these to be found in a fixed order, that order needs
to be known.  This will later be used to sort a list of these
structures that address map and ACPI table entries are predictable.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 include/hw/cxl/cxl.h | 1 +
 hw/cxl/cxl-host.c    | 9 ++++++---
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/include/hw/cxl/cxl.h b/include/hw/cxl/cxl.h
index 75e47b6864..b2bcce7ed6 100644
--- a/include/hw/cxl/cxl.h
+++ b/include/hw/cxl/cxl.h
@@ -27,6 +27,7 @@
 typedef struct PXBCXLDev PXBCXLDev;
 
 typedef struct CXLFixedWindow {
+    int index;
     uint64_t size;
     char **targets;
     PXBCXLDev *target_hbs[16];
diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
index e010163174..b7aa429ddf 100644
--- a/hw/cxl/cxl-host.c
+++ b/hw/cxl/cxl-host.c
@@ -24,13 +24,15 @@
 
 static void cxl_fixed_memory_window_config(CXLState *cxl_state,
                                            CXLFixedMemoryWindowOptions *object,
-                                           Error **errp)
+                                           int index, Error **errp)
 {
     ERRP_GUARD();
     g_autofree CXLFixedWindow *fw = g_malloc0(sizeof(*fw));
     strList *target;
     int i;
 
+    fw->index = index;
+
     for (target = object->targets; target; target = target->next) {
         fw->num_targets++;
     }
@@ -325,14 +327,15 @@ static void machine_set_cfmw(Object *obj, Visitor *v, const char *name,
     CXLState *state = opaque;
     CXLFixedMemoryWindowOptionsList *cfmw_list = NULL;
     CXLFixedMemoryWindowOptionsList *it;
+    int index;
 
     visit_type_CXLFixedMemoryWindowOptionsList(v, name, &cfmw_list, errp);
     if (!cfmw_list) {
         return;
     }
 
-    for (it = cfmw_list; it; it = it->next) {
-        cxl_fixed_memory_window_config(state, it->value, errp);
+    for (it = cfmw_list, index = 0; it; it = it->next, index++) {
+        cxl_fixed_memory_window_config(state, it->value, index, errp);
     }
     state->cfmw_list = cfmw_list;
 }


