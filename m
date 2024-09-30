Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66FD8CF6497
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 08:21:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svBck-0007Bp-9g; Mon, 30 Sep 2024 04:19:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1svBaU-0005eE-Ix
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 04:17:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1svBaS-0005tR-8B
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 04:16:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727684215;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xtGJwVXMrFzPBkMfLTJwPBwE9R7SBDoRTUi3pO0/Y7E=;
 b=dWGrVnP0GMBocT4irmiv5yMCh0py7AFUf8bzOiv7OysZJcZfsYAWwbqYjkNJtqkR8huCUf
 u6b5lKe4FBfeK5+ODFVxZyK3+wBeXZbuKXwChfC0eplU4NCzfXp9iHD8pXh/ETMXBehIXB
 PaDJS6f4u96ftJbScwET2eYe8HNqqKM=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-154-3T0HPuNQMMiFF_pTTiSmBQ-1; Mon,
 30 Sep 2024 04:16:52 -0400
X-MC-Unique: 3T0HPuNQMMiFF_pTTiSmBQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (unknown
 [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8F3B71935852; Mon, 30 Sep 2024 08:16:48 +0000 (UTC)
Received: from localhost (unknown [10.39.208.36])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 504091955DC7; Mon, 30 Sep 2024 08:16:45 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, Fam Zheng <fam@euphon.net>,
 Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, qemu-block@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Greg Kurz <groug@kaod.org>,
 =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 Fabiano Rosas <farosas@suse.de>, Eric Blake <eblake@redhat.com>,
 Hyman Huang <yong.huang@smartx.com>, Kevin Wolf <kwolf@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 John Snow <jsnow@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Jesper Devantier <foss@defmacro.it>, Peter Xu <peterx@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Klaus Jensen <its@irrelevant.dk>,
 Keith Busch <kbusch@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Yuval Shaia <yuval.shaia.ml@gmail.com>, Bin Meng <bin.meng@windriver.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v3 15/22] linux-user/hppa: fix -Werror=maybe-uninitialized
 false-positive
Date: Mon, 30 Sep 2024 12:14:50 +0400
Message-ID: <20240930081458.1926382-16-marcandre.lureau@redhat.com>
In-Reply-To: <20240930081458.1926382-1-marcandre.lureau@redhat.com>
References: <20240930081458.1926382-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.095,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

../linux-user/hppa/cpu_loop.c: In function ‘hppa_lws’:
../linux-user/hppa/cpu_loop.c:106:17: error: ‘ret’ may be used uninitialized [-Werror=maybe-uninitialized]
  106 |     env->gr[28] = ret;

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 linux-user/hppa/cpu_loop.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/linux-user/hppa/cpu_loop.c b/linux-user/hppa/cpu_loop.c
index bc093b8fe8..f4da95490e 100644
--- a/linux-user/hppa/cpu_loop.c
+++ b/linux-user/hppa/cpu_loop.c
@@ -43,7 +43,7 @@ static abi_ulong hppa_lws(CPUHPPAState *env)
         old = tswap32(old);
         new = tswap32(new);
         ret = qatomic_cmpxchg((uint32_t *)g2h(cs, addr), old, new);
-        ret = tswap32(ret);
+        env->gr[28] = tswap32(ret);
         break;
 
     case 2: /* elf32 atomic "new" cmpxchg */
@@ -64,19 +64,19 @@ static abi_ulong hppa_lws(CPUHPPAState *env)
             old = *(uint8_t *)g2h(cs, old);
             new = *(uint8_t *)g2h(cs, new);
             ret = qatomic_cmpxchg((uint8_t *)g2h(cs, addr), old, new);
-            ret = ret != old;
+            env->gr[28] = ret != old;
             break;
         case 1:
             old = *(uint16_t *)g2h(cs, old);
             new = *(uint16_t *)g2h(cs, new);
             ret = qatomic_cmpxchg((uint16_t *)g2h(cs, addr), old, new);
-            ret = ret != old;
+            env->gr[28] = ret != old;
             break;
         case 2:
             old = *(uint32_t *)g2h(cs, old);
             new = *(uint32_t *)g2h(cs, new);
             ret = qatomic_cmpxchg((uint32_t *)g2h(cs, addr), old, new);
-            ret = ret != old;
+            env->gr[28] = ret != old;
             break;
         case 3:
             {
@@ -97,13 +97,13 @@ static abi_ulong hppa_lws(CPUHPPAState *env)
                 }
                 end_exclusive();
 #endif
+                env->gr[28] = ret;
             }
             break;
         }
         break;
     }
 
-    env->gr[28] = ret;
     return 0;
 }
 
-- 
2.45.2.827.g557ae147e6


