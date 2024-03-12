Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D93BC54E6A
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 12:44:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk1Ub-0002n4-FT; Tue, 12 Mar 2024 08:44:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rk1UC-0002Ip-Ua
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 08:44:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rk1U7-000071-MP
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 08:44:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710247439;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eSv1YqeGADcco7ZxgNGLXLtwuD3hZ+ULVdi/S+nqTWA=;
 b=KRx2Mc3y9BK9p7akUo+KBjhlYgK25IhF7sg+tekYJI0+wmZDXKA+/IUv9uCO+rB6bVByl5
 n+Ef2idhDj1RL77W7MYCDAOG5M4M/kDlkKZrJcDvmWJdVeRaFrD/mkP1/ww59rl/XvaB3M
 mLL5Zv1h+ORecGDlEHmyPRl+T6aw19c=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-306-z04nSDn8M3G3H6wuhKFrag-1; Tue, 12 Mar 2024 08:43:57 -0400
X-MC-Unique: z04nSDn8M3G3H6wuhKFrag-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 61217800274;
 Tue, 12 Mar 2024 12:43:57 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.69])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 76CD8492BD1;
 Tue, 12 Mar 2024 12:43:55 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>
Subject: [PULL 09/55] block: Fix missing ERRP_GUARD() for error_prepend()
Date: Tue, 12 Mar 2024 13:42:53 +0100
Message-ID: <20240312124339.761630-10-thuth@redhat.com>
In-Reply-To: <20240312124339.761630-1-thuth@redhat.com>
References: <20240312124339.761630-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Zhao Liu <zhao1.liu@intel.com>

As the comment in qapi/error, passing @errp to error_prepend() requires
ERRP_GUARD():

* = Why, when and how to use ERRP_GUARD() =
*
* Without ERRP_GUARD(), use of the @errp parameter is restricted:
...
* - It should not be passed to error_prepend(), error_vprepend() or
*   error_append_hint(), because that doesn't work with &error_fatal.
* ERRP_GUARD() lifts these restrictions.
*
* To use ERRP_GUARD(), add it right at the beginning of the function.
* @errp can then be used without worrying about the argument being
* NULL or &error_fatal.

ERRP_GUARD() could avoid the case when @errp is &error_fatal, the user
can't see this additional information, because exit() happens in
error_setg earlier than information is added [1].

In block.c, there are 4 functions passing @errp to error_prepend()
without ERRP_GUARD():
 - bdrv_co_create_opts_simple()
 - parse_json_filename()
 - bdrv_open_backing_file()
 - bdrv_append_temp_snapshot()

bdrv_co_create_opts_simple(), is an implementation of
BlockDriver.bdrv_co_create_opts(). There are too many possible callers
to check the impact of this defect; it may or may not be harmless. Thus
it is necessary to protect @errp with ERRP_GUARD().

Though the @errp parameters passed to parse_json_filename(),
bdrv_open_backing_file() and bdrv_append_temp_snapshot() points to their
callers' local_err, to follow the requirement of @errp, also add missing
ERRP_GUARD() at their beginning.

[1]: Issue description in the commit message of commit ae7c80a7bd73
     ("error: New macro ERRP_GUARD()").

Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Hanna Reitz <hreitz@redhat.com>
Cc: qemu-block@nongnu.org
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-ID: <20240311033822.3142585-4-zhao1.liu@linux.intel.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 block.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/block.c b/block.c
index 1ed9214f66..cf66c767a0 100644
--- a/block.c
+++ b/block.c
@@ -633,6 +633,7 @@ int coroutine_fn bdrv_co_create_opts_simple(BlockDriver *drv,
                                             QemuOpts *opts,
                                             Error **errp)
 {
+    ERRP_GUARD();
     BlockBackend *blk;
     QDict *options;
     int64_t size = 0;
@@ -1998,6 +1999,7 @@ fail_opts:
 
 static QDict *parse_json_filename(const char *filename, Error **errp)
 {
+    ERRP_GUARD();
     QObject *options_obj;
     QDict *options;
     int ret;
@@ -3585,6 +3587,7 @@ int bdrv_set_backing_hd(BlockDriverState *bs, BlockDriverState *backing_hd,
 int bdrv_open_backing_file(BlockDriverState *bs, QDict *parent_options,
                            const char *bdref_key, Error **errp)
 {
+    ERRP_GUARD();
     char *backing_filename = NULL;
     char *bdref_key_dot;
     const char *reference = NULL;
@@ -3851,6 +3854,7 @@ static BlockDriverState *bdrv_append_temp_snapshot(BlockDriverState *bs,
                                                    QDict *snapshot_options,
                                                    Error **errp)
 {
+    ERRP_GUARD();
     g_autofree char *tmp_filename = NULL;
     int64_t total_size;
     QemuOpts *opts = NULL;
-- 
2.44.0


