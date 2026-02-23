Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA7FAE98E14
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 09:49:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuSXm-0004zX-UU; Mon, 23 Feb 2026 04:48:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vuSXe-0004hL-8v
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 04:47:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vuSXb-0006sG-V8
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 04:47:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771840063;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2klOYhoQ4fGAi4xB2sFPG+TEpv5+uqPlzGLBDNFYtXM=;
 b=Q0+E0mVLBpiAqbvoG5Dw+VtzVH5696GNfsGx77rwMa+HFvynY4oyvvaYotzdydHb/1hP+H
 23gVCdkOsGCHMpTRyJKHfQcNwvezZGWkfKxKmEh/d3OHZ06P8wun8pP7OrO9LzNwS0M/pz
 XeaSG1K4kSeM9kgtMbSjLqnb855nirU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-132-2x_zxLZSO_eRSd-_Ql331w-1; Mon,
 23 Feb 2026 04:47:40 -0500
X-MC-Unique: 2x_zxLZSO_eRSd-_Ql331w-1
X-Mimecast-MFC-AGG-ID: 2x_zxLZSO_eRSd-_Ql331w_1771840059
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8DCA71956095; Mon, 23 Feb 2026 09:47:39 +0000 (UTC)
Received: from localhost (unknown [10.45.242.25])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E4ED01800672; Mon, 23 Feb 2026 09:47:38 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL v2 17/85] util: add some extra stubs for qemu modules
 initialization
Date: Mon, 23 Feb 2026 10:45:35 +0100
Message-ID: <20260223094649.2005118-18-marcandre.lureau@redhat.com>
In-Reply-To: <20260223094649.2005118-1-marcandre.lureau@redhat.com>
References: <20260223094649.2005118-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.798, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.79,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Avoid extra ifdef-ery when optionally supporting modules, as done in
audio-test (and vl.c).

Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 system/vl.c   | 2 --
 util/module.c | 3 +++
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/system/vl.c b/system/vl.c
index aa9a1550417..3e341142a0c 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -2889,10 +2889,8 @@ void qemu_init(int argc, char **argv)
 
     os_setup_limits();
 
-#ifdef CONFIG_MODULES
     module_init_info(qemu_modinfo);
     module_allow_arch(target_name());
-#endif
 
     qemu_init_subsystems();
 
diff --git a/util/module.c b/util/module.c
index 1aa2079d013..09dc43f51eb 100644
--- a/util/module.c
+++ b/util/module.c
@@ -396,6 +396,9 @@ void qemu_load_module_for_opts(const char *group)
 
 #else
 
+const QemuModinfo qemu_modinfo[] = {};
+
+void module_init_info(const QemuModinfo *info) {}
 void module_allow_arch(const char *arch) {}
 void qemu_load_module_for_opts(const char *group) {}
 int module_load(const char *prefix, const char *name, Error **errp) { return 2; }
-- 
2.53.0


