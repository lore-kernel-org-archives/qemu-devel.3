Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D572C38150
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Jul 2024 11:26:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQQ1I-0002SM-IY; Sun, 07 Jul 2024 07:25:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lrh2000@pku.edu.cn>)
 id 1sQQ1G-0002SA-MJ
 for qemu-devel@nongnu.org; Sun, 07 Jul 2024 07:25:26 -0400
Received: from zg8tmtu5ljy1ljeznc42.icoremail.net ([159.65.134.6])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lrh2000@pku.edu.cn>) id 1sQQ1D-00039I-5J
 for qemu-devel@nongnu.org; Sun, 07 Jul 2024 07:25:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=pku.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
 Message-ID:MIME-Version:Content-Transfer-Encoding; bh=qs+mRCS9Xv
 IDMiaCnaWXpyQGgXgHhCiT2BiBzQhadY8=; b=Xqhk2V5zXNdm9t+rpofx95ijfA
 6WLsTu7Al7PNR0N46g+KNhdeV6+xW2kqF44KfwWpmrbROm4n+QQruBSBiFTNClOM
 2CL5g1DzNTXbDJF0k7Tb0BvWUbs3amm3MMtLS+mvKHUwZRk+ytrkUnz4EWHYRoag
 Tz9T0EGqzeaUGRbXg=
Received: from localhost.localdomain (unknown [10.7.41.133])
 by front01 (Coremail) with SMTP id 5oFpogD30cgUe4pmAJH3AA--.51167S2;
 Sun, 07 Jul 2024 19:25:11 +0800 (CST)
From: Ruihan Li <lrh2000@pku.edu.cn>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Ruihan Li <lrh2000@pku.edu.cn>
Subject: [PATCH] char-mux: Don't overwrite the receive buffer
Date: Sun,  7 Jul 2024 19:19:42 +0800
Message-ID: <20240707111940.232549-3-lrh2000@pku.edu.cn>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: 5oFpogD30cgUe4pmAJH3AA--.51167S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uw4ftFy5Jr4fGrWDuF45Jrb_yoW8ur1xpa
 yYkFyUCr4DJFnFywn8CF1jgw1rAa95XayUG3Z8A34jvw15CrnYvry3Kay093yUu3yxGr1j
 vrs8ZFWrCF1qv3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUvK1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
 w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
 IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E
 87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1lnxkEFVAIw20F6c
 xK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2Wl
 Yx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbV
 WUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4AK6svP
 MxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_Kr1UJr1l4I8I3I0E4IkC6x0Yz7
 v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
 1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIx
 AIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI
 42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxh
 VjvjDU0xZFpf9x0JUQZ23UUUUU=
X-CM-SenderInfo: yssqiiarrvmko6sn3hxhgxhubq/1tbiAgEFBWaBhWQODAAYsf
Received-SPF: pass client-ip=159.65.134.6; envelope-from=lrh2000@pku.edu.cn;
 helo=zg8tmtu5ljy1ljeznc42.icoremail.net
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_BL=0.001, RCVD_IN_MSPIKE_L5=0.001, RCVD_IN_VALIDITY_RPBL=1.31,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

This commit fixes a bug that causes incorrect results when pasting more
than 32 bytes, the size of the receive buffer b->buffer, into the virtio
console.

Example (note that the last 32 bytes are always correct, but something
goes wrong just before the last 32 bytes):

	Pasting  abcdefghijklmnopqrstuvwxyz1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZ!@#$%^&*()
	Received abcdefg)EFGHIJKLMNOPQRSTUVWXYZ!@#$%^&*()EFGHIJKLMNOPQRSTUVWXYZ!@#$%^&*()

The root cause of this bug is as follows:

The mux_chr_read function passes the data to the backend via
be->chr_read one byte at a time, either directly or via another
mux_chr_accept_input method. However, if the receive buffer is full,
there is a chance that the mux_chr_can_read method will return more than
one byte, because in this case the method directly returns whatever
be->chr_can_read returns.

This is problematic because if mux_chr_read passes a byte to the backend
by calling be->chr_read, it will consume the entire backend buffer, at
least in the case of virtio. Once all backend buffers are used,
mux_chr_read writes all remaining bytes to the receive buffer d->buffer,
but the number of remaining bytes can be larger than the buffer size.
This does not lead to security problems since it is a ring buffer, but
it does mess up the receive data.

This can be fixed by having mux_chr_can_read return either zero or one.
This fix is not very efficient, but it is quite reasonable since
mux_chr_read also passes the data to the backend one byte at a time.

Signed-off-by: Ruihan Li <lrh2000@pku.edu.cn>
---
 chardev/char-mux.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/chardev/char-mux.c b/chardev/char-mux.c
index ee2d47b..5c6eea2 100644
--- a/chardev/char-mux.c
+++ b/chardev/char-mux.c
@@ -210,8 +210,8 @@ static int mux_chr_can_read(void *opaque)
         return 1;
     }
 
-    if (be && be->chr_can_read) {
-        return be->chr_can_read(be->opaque);
+    if (be && be->chr_can_read && be->chr_can_read(be->opaque)) {
+        return 1;
     }
 
     return 0;
-- 
2.45.2


