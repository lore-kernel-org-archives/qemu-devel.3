Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48636C5DF7D
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 16:13:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxRq8-0006ct-IG; Fri, 21 Aug 2026 12:11:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1wxRq3-0006b5-7d
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 12:11:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1wxRq1-0001bo-An
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 12:11:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787328684;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Zdltyd2KdCMXu+fgkLkbV6vgW6gMOcE7mbXXQPuJ/8A=;
 b=Y6OO20zn3iBQZJfC+t1MD+TzyRB7+nI6UtDUetYsCmv9sptH/kgaHTFYZnWpwgfDp74wQS
 ij25HrFq8AZn9oia9MoAMIQV2x4pS98Gjafa6Sq+GVZoQ/TvMQ3HfFxS/LfKDl92/Zt59s
 wo9RWfKM7r1qIc5SCDHUPITBlDLNgWw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-625--RqN4dEPNn21cyERIghkpg-1; Fri,
 21 Aug 2026 12:11:11 -0400
X-MC-Unique: -RqN4dEPNn21cyERIghkpg-1
X-Mimecast-MFC-AGG-ID: -RqN4dEPNn21cyERIghkpg_1787328669
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CDD591801332; Fri, 21 Aug 2026 16:11:09 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.48.30])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 63EA9426; Fri, 21 Aug 2026 16:11:09 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id B643C18009E1; Fri, 21 Aug 2026 18:11:03 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Xu <peterx@redhat.com>, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Gerd Hoffman <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Laurent Vivier <lvivier@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 06/12] backends/igvm: add a tracepoint for qigvm_cleanup_memory
Date: Fri, 21 Aug 2026 18:10:54 +0200
Message-ID: <20260821161103.3489298-7-kraxel@redhat.com>
In-Reply-To: <20260821161103.3489298-1-kraxel@redhat.com>
References: <20260821161103.3489298-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

From: Ani Sinha <anisinha@redhat.com>

Useful for debugging memory region cleanups.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
Message-ID: <20260817142010.80693-6-anisinha@redhat.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 backends/igvm.c       | 1 +
 backends/trace-events | 1 +
 2 files changed, 2 insertions(+)

diff --git a/backends/igvm.c b/backends/igvm.c
index 9b101c81824e..7b7bdc72b75b 100644
--- a/backends/igvm.c
+++ b/backends/igvm.c
@@ -1120,6 +1120,7 @@ void qigvm_cleanup_memory(IgvmCfg *cfg)
 
     QTAILQ_FOREACH_SAFE(imr, &cfg->memory_regions, next, tmp)
     {
+        trace_qigvm_cleanup_memory(imr->mr->name);
         memory_region_del_subregion(get_system_memory(), imr->mr);
         vmstate_unregister_ram(imr->mr, NULL);
         QTAILQ_REMOVE(&cfg->memory_regions, imr, next);
diff --git a/backends/trace-events b/backends/trace-events
index 009a25b0be96..9b7b9b7d6801 100644
--- a/backends/trace-events
+++ b/backends/trace-events
@@ -33,3 +33,4 @@ igvm_reset_hold(int type) "type=%u"
 igvm_reset_exit(int type) "type=%u"
 igvm_file_loaded(const char *fn, int32_t handle) "fn=%s, handle=0x%x"
 igvm_process_file(int32_t handle, bool context_only) "handle=0x%x context-only=%d"
+qigvm_cleanup_memory(const char* name) "freeing mr %s"
-- 
2.55.0


