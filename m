Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C700DE677E2
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Dec 2025 15:14:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vXhbd-0000mB-Uu; Mon, 22 Dec 2025 10:13:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bT.xz2j7lfh1i4qzc4=r4kuv71agyj8=wvwtwcires3uuy@em483429.getutm.app>)
 id 1vXhbZ-0000lb-Ac
 for qemu-devel@nongnu.org; Mon, 22 Dec 2025 10:13:49 -0500
Received: from a2i327.smtp2go.com ([103.47.205.71])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bT.xz2j7lfh1i4qzc4=r4kuv71agyj8=wvwtwcires3uuy@em483429.getutm.app>)
 id 1vXhbU-0005pS-Uv
 for qemu-devel@nongnu.org; Mon, 22 Dec 2025 10:13:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=smtpservice.net; s=mad0l0.a1-4.dyn; x=1766417311; h=Feedback-ID:
 X-Smtpcorp-Track:Message-ID:Date:Subject:To:From:Reply-To:Sender:
 List-Unsubscribe:List-Unsubscribe-Post;
 bh=1fQHjIB/Rg9sfRlGk3msWMuLmJ76rJ7TGiIaoIDiq3A=; b=EcmKSEyNC9jnvr17PYRJ/SXM2O
 6ZqXhojaX+5SNxr3UZvDVnIvwqds0MU7W1R0CNryhfehoqI9EOAO5vhorYHVjg4CYICdTX6bzdQDc
 qyerNFHByZrhDnYy8xbBP/FGNUDO1DUpNAo3R1xEkywGyp8WIsaysct+78XSdizuWhKAGcoLlNKNh
 Kx8KEwLssANxyBeVwcw13ZJepfZ72ZZFDeIqf2xIhdng9J//u7sIE5lQA+m1mMiQ38PmqpG4qwl1h
 nAd1mxAqoMQOVMrt5RADGz0/Di7htZSh75hK8OlIE9Kj7jSJ9lYgjdrzhIT9Rqy+RYnbBL9L8H6kK
 5LncIYqQ==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getutm.app;
 i=@getutm.app; q=dns/txt; s=s483429; t=1766416411; h=from : subject :
 to : message-id : date;
 bh=1fQHjIB/Rg9sfRlGk3msWMuLmJ76rJ7TGiIaoIDiq3A=;
 b=GI0zhWmBC4/0vcUFnIqri1hFh/xdJya4B4VVpkAcB0O2eNnym3aj6H+kwkyUmP7v0D0N1
 IBbBwlOr4bCv5wdDZ9/yFd9eWXewK+20UvXnxZ4uLseZ2OZvQA2IQvb7rqLrOqf6B2Y1d6f
 bpLLcfcbL0hrsnBJXCG1d3Gh9BM0niC7SaV3sgtS1vOFIvBISzcjR7zr3yjMjVJFgFehrVE
 CzStCqJe7wMQxoGTkjbcNmgUVMyx5Ixt631/4x+GRauHwR/p2wBFHGWoMQu3x4ft6HkrRi6
 88aCmNyt63ir9YGEeWutUuK+TZJK7D9wvaooPNVBWBqDWe80d0AiBInppIKg==
Received: from [10.173.255.233] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <j@getutm.app>)
 id 1vXhbC-pH9SJy-4d; Mon, 22 Dec 2025 15:13:26 +0000
Received: from [10.159.238.187] (helo=localhost.localdomain)
 by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA512__CHACHA20_POLY1305:256)
 (Exim 4.98.1-S2G) (envelope-from <j@getutm.app>)
 id 1vXhbB-FnQW0hPzNOZ-1gIU; Mon, 22 Dec 2025 15:13:25 +0000
From: Joelle van Dyne <j@getutm.app>
To: qemu-devel@nongnu.org
Cc: Joelle van Dyne <j@getutm.app>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH] virrtio-gpu-virgl: correct parent for blob memory region
Date: Mon, 22 Dec 2025 07:12:59 -0800
Message-ID: <20251222151259.3965-1-j@getutm.app>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Smtpcorp-Track: UJjV3YlGGqx8.zWENYiR-gfg0.-JJG0AdR_YV
Feedback-ID: 483429m:483429abrvJvs:483429siIlUfZLxO
X-Report-Abuse: Please forward a copy of this message, including all headers, 
 to <abuse-report@smtp2go.com>
Received-SPF: pass client-ip=103.47.205.71;
 envelope-from=bT.xz2j7lfh1i4qzc4=r4kuv71agyj8=wvwtwcires3uuy@em483429.getutm.app;
 helo=a2i327.smtp2go.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

When `owner` == `mr`, `object_unparent` will crash:

object_unparent(mr) ->
object_property_del_child(mr, mr) ->
object_finalize_child_property(mr, name, mr) ->
object_unref(mr) ->
object_finalize(mr) ->
object_property_del_all(mr) ->
object_finalize_child_property(mr, name, mr) ->
object_unref(mr) ->
fail on g_assert(obj->ref > 0)

Signed-off-by: Joelle van Dyne <j@getutm.app>
---
 hw/display/virtio-gpu-virgl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index 18404be5892..4109ff7932a 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -123,7 +123,7 @@ virtio_gpu_virgl_map_resource_blob(VirtIOGPU *g,
     vmr->g = g;
 
     mr = &vmr->mr;
-    memory_region_init_ram_ptr(mr, OBJECT(mr), "blob", size, data);
+    memory_region_init_ram_ptr(mr, OBJECT(g), "blob", size, data);
     memory_region_add_subregion(&b->hostmem, offset, mr);
     memory_region_set_enabled(mr, true);
 
-- 
2.50.1 (Apple Git-155)


