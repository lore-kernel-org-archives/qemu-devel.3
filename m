Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC9F3C25B7E
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 15:12:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sD3uP-00007g-Uj; Fri, 31 May 2024 11:11:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mprivozn@redhat.com>)
 id 1sD3uJ-00005T-7S
 for qemu-devel@nongnu.org; Fri, 31 May 2024 11:11:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mprivozn@redhat.com>)
 id 1sD3uE-0005Ws-VU
 for qemu-devel@nongnu.org; Fri, 31 May 2024 11:11:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717168254;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eWFEZPJLxFkfdJj/hxUHX1WoKkd0uHs84B70Eu9I1Mg=;
 b=VuXUUxV4JW90Bg7uByrp5hL93UN89xtwsNjrVfbtFHp819ghlvFkz0qczU2qZy0nQua/14
 jPUpYQ5WqBVo/jdBB+5aMgSuqjkW6/sxrDWHzmg7uivp3GVW2R+CHPiokZhQe5y2r5LBMY
 wxsu8HoK58Lt3Htf25FLRq+9xJgeAlw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-oND1riytOx634X8Dy4lUMw-1; Fri, 31 May 2024 11:10:51 -0400
X-MC-Unique: oND1riytOx634X8Dy4lUMw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A43EB101A52C
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 15:10:50 +0000 (UTC)
Received: from maggie.brq.redhat.com (unknown [10.43.3.102])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 500503C27
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 15:10:50 +0000 (UTC)
From: Michal Privoznik <mprivozn@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 2/4] osdep: Make qemu_madvise() return ENOSYS on
 unsupported OSes
Date: Fri, 31 May 2024 17:10:45 +0200
Message-ID: <6d59250d75cf5c6411c50075102a750104d5de91.1717168113.git.mprivozn@redhat.com>
In-Reply-To: <cover.1717168113.git.mprivozn@redhat.com>
References: <cover.1717168113.git.mprivozn@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mprivozn@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.085,
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

Not every OS is capable of madvise() or posix_madvise() even. In
that case, errno should be set to ENOSYS as it reflects the cause
better.

Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 util/osdep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/util/osdep.c b/util/osdep.c
index 1345238a5c..4a8920ba93 100644
--- a/util/osdep.c
+++ b/util/osdep.c
@@ -71,7 +71,7 @@ int qemu_madvise(void *addr, size_t len, int advice)
     }
     return 0;
 #else
-    errno = EINVAL;
+    errno = ENOSYS;
     return -1;
 #endif
 }
-- 
2.44.1


