Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6941C9830E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 13:05:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xA5bI-0004fQ-Gq; Fri, 25 Sep 2026 09:04:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xA5bG-0004fC-2e
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 09:04:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xA5bD-0002kr-LW
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 09:04:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790341461;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1GWq4pH4lflyk01hzi8zwbTm0ieRfdyoL7WRzAlbvJk=;
 b=Ntg5UqjJWL2r8yfgj2mQShfS25U713/Hh8fd7PBqyq/eEDhT98AvIccs3hUmtvKIl2/lGQ
 S4CV//HYdoQz4NapuJAIEMOgqXMZGYKfiaTIvPeINjo0PMCwUy5NZs8mt52H2zRJFze3ih
 aXGP0H94/ed25P0oT/HPJXAuqmzFUv4=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-524-Iqaou8pMN7GuflL1Q-Ds3Q-1; Fri, 25 Sep 2026 09:04:20 -0400
X-MC-Unique: Iqaou8pMN7GuflL1Q-Ds3Q-1
X-Mimecast-MFC-AGG-ID: Iqaou8pMN7GuflL1Q-Ds3Q_1790341460
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-939062ecda9so167069885a.1
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 06:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790341460; x=1790946260; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=1GWq4pH4lflyk01hzi8zwbTm0ieRfdyoL7WRzAlbvJk=;
 b=QrByyCZOxLwP72hgG5Kj+bq20nDrG2LZdC8VwtocX9V5wcPEI0draXiPYGL0hBGv/9
 k5UEeDDuPAt/l6D1LkTsOaZxWv+5kgSODX+DlyXMuA+tEHonoQrywTr1EMgEmzuoLEnB
 PH74erdCgRJdqTKXUE1vAfNeefMQ3tSNP4HXM1wUiWTKkejS0QP/cXZPjftLa+Af0GsX
 ueulPLyTleD80bp3kt1vuUfatdjtQHtTKQf+RH3QMakB6iqkd7poAitvqf4r5OC9IuWm
 wxJBahL7+G+7VLhTPnEWP2K6JT+qjG36jTFufuAS08A9/Mk4ICkFpjhE1i0uEwPvSVpt
 KHQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790341460; x=1790946260;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1GWq4pH4lflyk01hzi8zwbTm0ieRfdyoL7WRzAlbvJk=;
 b=JzfadxQknwNlo5bhE6x6nc8KxhYyiN9XGc7qg7hhrg/faQE8Mo4IlZnoDemQxeg3NZ
 a+fsDBm2xf+6U7GY1PhC4160Tf2TeFRbZ7mKRWFT3td0E8SqN+yLEgBvqYB2BKm2L+XK
 Eaahi6+jp8hyJhT5udWLz+BwQLCEV8t9QuULktgSiN5qpXnJIGLmSQ1751dRPre2EKt1
 tMXd46WP+8vzQi4sACz7Mf7hNjcEMQ6smKNxOyidvIuqSC3EMWNoTG7PJwhA6cD4tTsb
 vnxrUDCEVG8G3B2GFmxNrhePSfOXCLLUVGaHSuL913uF5NrxMv8DpPVD1MC0x0wxMus/
 CNuA==
X-Gm-Message-State: AFuF++lc0BkIPHFAzDPgDfPQUSJVmxxC2UsAP5upcONOwk+Aih5gL4dI
 NyCG9QyCmIpcOLakP3ym8GptLS/E7MjPEY8FMqTcPrRuvm23gmtpS1IjBqDNbdsSj4ac6ZJMtug
 4IpFcOgpxiwYqJ+vnkUJXF0Z80XvITXU027c3Ou1Tj5effol8u2h2zSIa
X-Gm-Gg: AYBFou3HQbpkQMZ8jP5BdUaNT478y4GXOrIVzL/EcAMDaEg5AhwUTfN+vKsaBbM7Iov
 46jNjtKSq0ozw3O2pWG59/R+1NBWEMQbYCjLZJKH8fLhB8A/dJwjb9C99FrhBdnmulQRpEc+iDD
 5XM/0IGfIK2sqdyjr0UJ3RJkwEXp/fAWw8bqnaqMLuItZU2e9B6H2efWWt0XdzQ1HcD96YOh6jb
 UwIAJU/tfTY7kj5/BN17j+Us3pTdwjJ50X/Ts7iPH9O+d1X3O9ua7DUvvE9SVIjZfE09BN70ydb
 F06K4j9SpYXW3kUjKDn+tf0BJ76aAWAFSycp3xzsxJJm8gg3wx8H1LnnxscOoq/FNKmVD2I=
X-Received: by 2002:a05:620a:4050:b0:937:5ab5:53f7 with SMTP id
 af79cd13be357-93c43dc8b4fmr422729485a.43.1790341459362; 
 Fri, 25 Sep 2026 06:04:19 -0700 (PDT)
X-Received: by 2002:a05:620a:4050:b0:937:5ab5:53f7 with SMTP id
 af79cd13be357-93c43dc8b4fmr422719585a.43.1790341458651; 
 Fri, 25 Sep 2026 06:04:18 -0700 (PDT)
Received: from localhost ([142.188.212.246]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93c448b0cdesm177547185a.14.2026.09.25.06.04.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 06:04:17 -0700 (PDT)
Date: Fri, 25 Sep 2026 09:04:14 -0400
From: Peter Xu <peterx@redhat.com>
To: Michael Roth <michael.roth@amd.com>
Cc: qemu-devel@nongnu.org, david@kernel.org, pbonzini@redhat.com,
 xiaoyao.li@intel.com, berrange@redhat.com, armbru@redhat.com,
 pankaj.gupta@amd.com, chao.p.peng@linux.intel.com
Subject: Re: [PATCH v6 00/12] KVM/hostmem: Support init-shared guest-memfd as
 VM backends
Message-ID: <arZxTrbF9ElYuVNu@zhexu-thinkpadt14gen5.rmtcaon.csb>
References: <20260925015700.1260501-1-michael.roth@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260925015700.1260501-1-michael.roth@amd.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Sep 24, 2026 at 08:43:06PM -0500, Michael Roth wrote:
> v1: https://lore.kernel.org/r/20251023185913.2923322-1-peterx@redhat.com
> v2: https://lore.kernel.org/r/20251119172913.577392-1-peterx@redhat.com
> v3: https://lore.kernel.org/r/20251215205203.1185099-1-peterx@redhat.com/
> v4: https://lore.kernel.org/qemu-devel/20260812201938.198915-1-michael.roth@amd.com/
> v5: https://lore.kernel.org/qemu-devel/20260908133151.836685-1-michael.roth@amd.com/
> v6:
> - Rename the hostmem property to 'x-guest-memfd' since initial users
>   are expected to be developers or early enablers (Markus)
> - Introduce accompanying 'guest-memfd' RST doc and reference it in
>   the QAPI schema documentation for x-guest-memfd (Markus)
> - Move all renaming patches toward beginning of the series for
>   consistency (David)
> - Fix mispellings in commit messages (David)
> - Drop ramlist lock in new ram_block_add() error path
> - Collect Reviewed-by's
> - Rebase on QEMU master

Michael,

Sorry, I missed your very last discussion with Markus..  only notice until
I saw the repost.  I agree we can mark it experimental, but just to mention
we should have moved to use "unstable" rather than prefix "x-", then we
don't need to bother with the ABI change, see:

    commit a3c45b3e62962f99338716b1347cfb0d427cea44
    Author: Markus Armbruster <armbru@redhat.com>
    Date:   Thu Oct 28 12:25:12 2021 +0200

    qapi: New special feature flag "unstable"

No need for another repost, I can manage that with two fixups when queue,
please shoot if there's any objections.  Attached at the end.

Thanks,

===8<===
From 94884f136d9d42044e3f4cfcf440df8016ad3e99 Mon Sep 17 00:00:00 2001
From: Peter Xu <peterx@redhat.com>
Date: Fri, 25 Sep 2026 08:51:13 -0400
Subject: [PATCH 1/2] fixup! hostmem: Support fully shared guest memfd to back
 a VM

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 docs/system/guest-memfd.rst |  4 ++--
 qapi/qom.json               |  9 +++++++--
 backends/hostmem-memfd.c    | 10 +++++-----
 3 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/docs/system/guest-memfd.rst b/docs/system/guest-memfd.rst
index f7cef19283..d62a214a91 100644
--- a/docs/system/guest-memfd.rst
+++ b/docs/system/guest-memfd.rst
@@ -38,10 +38,10 @@ exposed by QEMU command-line options.
 For non-Confidential guests, guest-memfd can be used in a manner that
 is somewhat interchangeable with a normal memfd. Currently, this is
 handled by using the same memory-backend implementation as memfd, but
-with an additional 'x-guest-memfd=on' option. E.g.::
+with an additional 'guest-memfd=on' option. E.g.::
 
     qemu ... \
-      -object memory-backend-memfd,id=ID,size=SIZE,share=on,x-guest-memfd=on
+      -object memory-backend-memfd,id=ID,size=SIZE,share=on,guest-memfd=on
 
 Note that the share=on option is required for guest-memfd, since it
 does not support anonymous memory allocations or COW-like semantics.
diff --git a/qapi/qom.json b/qapi/qom.json
index 602b17ad83..7423acea8f 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -780,10 +780,14 @@
 # @seal: if true, create a sealed-file, which will block further
 #     resizing of the memory (default: true)
 #
-# @x-guest-memfd: if 'on', use guest-memfd to back the memory region.
+# @guest-memfd: if 'on', use guest-memfd to back the memory region.
 #     See the "guest-memfd" QEMU documentation for more details.
 #     (default: auto, since: 11.2)
 #
+# Features:
+#
+# @unstable: Member @guest-memfd is experimental.
+#
 # Since: 2.12
 ##
 { 'struct': 'MemoryBackendMemfdProperties',
@@ -791,7 +795,8 @@
   'data': { '*hugetlb': 'bool',
             '*hugetlbsize': 'size',
             '*seal': 'bool',
-            '*x-guest-memfd': 'OnOffAuto' },
+            '*guest-memfd': { 'type': 'OnOffAuto',
+                              'features': [ 'unstable' ] } },
   'if': 'CONFIG_LINUX' }
 
 ##
diff --git a/backends/hostmem-memfd.c b/backends/hostmem-memfd.c
index a164bb659f..666593ff6c 100644
--- a/backends/hostmem-memfd.c
+++ b/backends/hostmem-memfd.c
@@ -59,14 +59,14 @@ memfd_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
 
     if (m->guest_memfd == ON_OFF_AUTO_ON) {
         /*
-         * NOTE: x-guest-memfd ignores seal=on/off because it always
+         * NOTE: guest-memfd ignores seal=on/off because it always
          * implicitly seals the FD by definition.
          */
         if (!backend->share) {
-            error_setg(errp, "x-guest-memfd=on must be used with share=on");
+            error_setg(errp, "guest-memfd=on must be used with share=on");
             return false;
         } else if (m->hugetlb) {
-            error_setg(errp, "x-guest-memfd=on doesn't support hugetlb=on");
+            error_setg(errp, "guest-memfd=on doesn't support hugetlb=on");
             return false;
         }
 
@@ -203,10 +203,10 @@ memfd_backend_class_init(ObjectClass *oc, const void *data)
                                               "Huge pages size (ex: 2M, 1G)");
     }
 
-    object_class_property_add(oc, "x-guest-memfd", "OnOffAuto",
+    object_class_property_add(oc, "guest-memfd", "OnOffAuto",
                               memfd_backend_get_guest_memfd,
                               memfd_backend_set_guest_memfd, NULL, NULL);
-    object_class_property_set_description(oc, "x-guest-memfd",
+    object_class_property_set_description(oc, "guest-memfd",
                                           "Use guest memfd");
 
     object_class_property_add_bool(oc, "seal",
-- 
2.55.0


From efb5a9d33373e0dcedbfec3dce28844164ccb8c8 Mon Sep 17 00:00:00 2001
From: Peter Xu <peterx@redhat.com>
Date: Fri, 25 Sep 2026 08:51:26 -0400
Subject: [PATCH 2/2] fixup! tests/migration-test: Support guest-memfd init
 shared mem type

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tests/qtest/migration/framework.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
index 93225e3720..b7aef6b21c 100644
--- a/tests/qtest/migration/framework.c
+++ b/tests/qtest/migration/framework.c
@@ -301,7 +301,7 @@ static char *migrate_mem_type_get_opts(MemType type, const char *memory_size)
         backend = g_strdup("-object memory-backend-memfd");
         break;
     case MEM_TYPE_GUEST_MEMFD:
-        backend = g_strdup("-object memory-backend-memfd,x-guest-memfd=on");
+        backend = g_strdup("-object memory-backend-memfd,guest-memfd=on");
         break;
     default:
         g_assert_not_reached();
-- 
2.55.0



-- 
Peter Xu


