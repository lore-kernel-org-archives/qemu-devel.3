Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9492D46C16
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 01:41:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlGtG-00006t-9v; Wed, 28 Jan 2026 20:32:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vlGsx-0008Pt-ET
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 20:31:52 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vlGsv-00037O-SY
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 20:31:51 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2a09d981507so3056385ad.1
 for <qemu-devel@nongnu.org>; Wed, 28 Jan 2026 17:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769650308; x=1770255108; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H10OT/JmZdt1sJqFGtD71gnCPbtsRM0YrzZVFDAS0VI=;
 b=kVvqHRNKugNq8zqUoFWGe26W9qmlAe511W/5C3tgGW2qDRw6amEqnEmOEmyAIgndBg
 rmU+RQxaTLQiCA5xy57Tsr04K8uxcd8vv8PGo988CZVhRfa53POTdVlfEWgXq/vEXAfC
 5eRQSLJ8tZ2OqaLEdgC4lf0FhDzjIfCCxtWcfZ5iaCVl/MyVhf6KHiUIwjFCkEXlf+wt
 sLfH53evQWkFf1hzuU94wWO78g58KPxH82fM8EjuBgaZHGVSJtsgU5yMIVaz+qzm/ln9
 aLQmONMyNJMNmPvLhmAflS4PtkidpfkYcerV+uf0c2VPduqI/kSlonlosfOB6rnRPY6c
 Kqmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769650308; x=1770255108;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=H10OT/JmZdt1sJqFGtD71gnCPbtsRM0YrzZVFDAS0VI=;
 b=UHyNRN+GwVX07tm76cUXcGAXGVuEpKYnCySJgz5sGOF0hWbHfzI35KG/cohwp00MS9
 WM8lUrMDgyf9Q0fdY0MuX2rGkfozurZTqs59MXJy06mD7Cz+0iMZYXhYAJkWTOlUGiam
 +JCDXpLzEurbHDT782X4wOsmeiE7I/5eJ4dmmAmaSibCqxV5wKnxFc09+2QdKZX0dA4F
 ytrMvyZjDhqGhtP14T0OzqhMFpN4PN10GECTmBGcaZu63yxiswCzlcPcVoS39pUDEHVF
 Ebwkm2ooXYgzeVxx9I8PJvlWcDH6GfjaJXthaN2/t0HVTV/7OXpDOyHXj5Nd61c0K+Ex
 oeWA==
X-Gm-Message-State: AOJu0Yyec0MsQFDZpFQnortCyxe6iaBmPXraMbVz+Ffq/mjAoudSVlcQ
 mblv6hVDk86JtCMqHF1SEMYuN/7tVRqVJYt7mpvvX4l8LfWD0mjX+kk4caEP5WcR0WaIWZvIUzY
 hKb7x
X-Gm-Gg: AZuq6aJkB0L3emdQm45MwnMG466VExOz7PyaAbIKHcsJ/T8dmNCNhjl6LbHF6v8HBDw
 lLAF7PoAyvXJ9Y7SAuE5jsi77hrDyMIvlFnQVMWyyRkyQvraNv9oW5yEdAVEdaF5JdPvqAVh669
 N1HpswyZkDLpTLGARFscA1fjblvWbAohTBsaYmVLgr+dLpx1AkgZk0u34tt3dnvX+tS5xYJijk9
 RgMu7VKcwxdDKKzR8uetUqSznpQcCvSMOdYSazJlxTSS3RCK8ms9U+4EmW3vL/iEwjHEP1mwMEG
 ZObUu7LEBDkKnXz0bvLTaEzXlpZiw3rC7JvQi2pxSVaats7euCp8tO1FBifBeQesdzSnKXWN4Uz
 IHHceIEtoN8osHxIwirQn6pjUgsdWLeVcUI2FHYY4jPa4PmJ4b5ls7Ed5KtyQzK0Tn4yQ56x+Sl
 u00LtzBfIKWHKGYAE2+9FxpDC71OTcPBQjvRjV0rJkyuQSFjerly93ASOsuTfF1+nQ
X-Received: by 2002:a17:902:f686:b0:2a7:cb46:7069 with SMTP id
 d9443c01a7336-2a8bd51b6cfmr11545135ad.25.1769650308325; 
 Wed, 28 Jan 2026 17:31:48 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-353f61e0007sm6627143a91.12.2026.01.28.17.31.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jan 2026 17:31:47 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alex Bradbury <asb@igalia.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 03/20] contrib/plugins/hotblocks: Print uint64_t with PRIu64
 rather than PRId64
Date: Wed, 28 Jan 2026 17:31:17 -0800
Message-ID: <20260129013134.3956938-4-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260129013134.3956938-1-pierrick.bouvier@linaro.org>
References: <20260129013134.3956938-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Alex Bradbury <asb@igalia.com>

qemu_plugin_u64_sum returns a uint64_t, so PRIu64 is the correct format
specifier.

Signed-off-by: Alex Bradbury <asb@igalia.com>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 contrib/plugins/hotblocks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/plugins/hotblocks.c b/contrib/plugins/hotblocks.c
index cf4d6b8c363..40d8dae1cd3 100644
--- a/contrib/plugins/hotblocks.c
+++ b/contrib/plugins/hotblocks.c
@@ -87,7 +87,7 @@ static void plugin_exit(qemu_plugin_id_t id, void *p)
         for (i = 0, it = sorted_counts; i < limit && it; i++, it = it->next) {
             ExecCount *rec = (ExecCount *) it->data;
             g_string_append_printf(
-                report, "0x%016"PRIx64", %d, %ld, %"PRId64"\n",
+                report, "0x%016"PRIx64", %d, %ld, %"PRIu64"\n",
                 rec->start_addr, rec->trans_count,
                 rec->insns,
                 qemu_plugin_u64_sum(
-- 
2.47.3


