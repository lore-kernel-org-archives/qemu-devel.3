Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 653A2CD6E4A
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 13:46:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wV8OY-0002Ef-2W; Thu, 04 Jun 2026 09:46:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wV8Nw-0001cy-Gt
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 09:45:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wV8Nu-0000fF-Ev
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 09:45:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780580721;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oqupxWTIX5yPgysg6IEDJFTjLZcEKlZDanCawBFqwAg=;
 b=WW3rbOfCNNo81P9ODFuUjYgJy52B7TZyZFCavKoX7XIGPyF3QcY6yPDgFA4CmFWQnSZP2J
 RXofC3JBaL1TJjGKnmmXv/rPpe4vaUdQgBfnZJtEYhh4Mri5JxV7A4kXyW1WbXMAYRZ6bk
 6LzakwId5Abv/6SfS0+KbrUpVmljRNI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-522-4cS6VzVNOreDKCoOMiHX5Q-1; Thu,
 04 Jun 2026 09:45:18 -0400
X-MC-Unique: 4cS6VzVNOreDKCoOMiHX5Q-1
X-Mimecast-MFC-AGG-ID: 4cS6VzVNOreDKCoOMiHX5Q_1780580716
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6332E195605C; Thu,  4 Jun 2026 13:45:16 +0000 (UTC)
Received: from localhost (unknown [10.44.24.6])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1D58A195608E; Thu,  4 Jun 2026 13:45:14 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 04 Jun 2026 17:43:54 +0400
Subject: [PATCH v5 08/12] system/physmem: destroy ram block attributes
 before RCU-deferred reclaim
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260604-rdm5-v5-8-5768e6a0943d@redhat.com>
References: <20260604-rdm5-v5-0-5768e6a0943d@redhat.com>
In-Reply-To: <20260604-rdm5-v5-0-5768e6a0943d@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, David Hildenbrand <david@kernel.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 qemu-rust@nongnu.org, Alex Williamson <alex@shazbot.org>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>, 
 Fabiano Rosas <farosas@suse.de>, Mark Kanda <mark.kanda@oracle.com>, 
 Ben Chaney <bchaney@akamai.com>, Marcelo Tosatti <mtosatti@redhat.com>, 
 kvm@vger.kernel.org, "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Zhao Liu <zhao1.liu@intel.com>, Eric Blake <eblake@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1538;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=nqr3DSm+dfPDdioJsSfk7uqz6VCxaipCaowmGHTPhEg=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqIYExpJKPAltEoHR0AycDz6wXPYowJyhmgItD+
 pJnRKPtWBOJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaiGBMQAKCRDa6OEJdZac
 5ZVbD/9RXRL6kPcKr9tBpgbhBXOJb1mXRRVSgQowhljff63fZrCncrc96zBbrCDRjKBw3FJpFm6
 gKL4xh1oElSnyrPXmvAM3Jo6oQM+5ZbfV6bunKlyglq4BdGoDpfT864Dw98f+szgqgpfqkaR+vz
 uxnDKu3hKV5T/1Jz7UqSyy2q0v8FBAJ6Rt0MQREtmgzkcxVNQhnwFdtwKBHmN/jgHXeVOYcIg/e
 WgBEPIS4Zv72yqwggL6MZczKoE8s9QtOdmDJ06c67A8ANtzjm428fBSqBkSgGH4C77+c0bx+BAn
 9fZx6eDVA8mCvN8Dx+9l+ibIhqI5Iz2Ys13HNdKaHY1XlC8cwafN5K39HSiVR+q1aUTuibN1Itj
 nhefdefIRCPbvzmBkoZRLxG9s5A0UJU4pAyDu34zXUlfnw9a6yDx5XwwtdjCRB28iww4FMkpj0g
 Gr66kraMI8cl3zQp3b2WR9ckQw7Hy/Eo8GTwNiFOOQa7hSUEgQoH97CfzGl1UiwZ8Yp8de2768G
 dJFczf8S+0YwPlKav/Sll7iDRvG0LSlziyWf2zCtbelq+MWXDtFM8+y6C2RTEOKqVpbHxOzrFLq
 nqq0oYN6lA1G2oDbkjVF3qP/CgdMIi+/j2uo6E5Ilr+lH+xjA44QvsBJUQanUGzaVzfiIVzw+Ko
 zTs6FqVbjDbzUyQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

ram_block_attributes_destroy() was called from reclaim_ramblock(), which
runs as an RCU callback deferred by call_rcu().

However,when the RamDiscardManager is finalized, it will assert that its
source_list is empty in the next commit. Since the RCU callback hasn't
run yet, the source added by ram_block_attributes_create() is still
attached.

Move ram_block_attributes_destroy() into qemu_ram_free() so the source
is removed synchronously. This is safe because qemu_ram_free() during
shutdown runs after pause_all_vcpus(), so no vCPU thread can
concurrently access the attributes via kvm_convert_memory().

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 system/physmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/system/physmem.c b/system/physmem.c
index 7bcbf875736..ddb67ba2359 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -2583,7 +2583,6 @@ static void reclaim_ramblock(RAMBlock *block)
     }
 
     if (block->guest_memfd >= 0) {
-        ram_block_attributes_destroy(block->attributes);
         close(block->guest_memfd);
         ram_block_coordinated_discard_require(false);
     }
@@ -2612,6 +2611,7 @@ void qemu_ram_free(RAMBlock *block)
     /* Write list before version */
     smp_wmb();
     ram_list.version++;
+    g_clear_pointer(&block->attributes, ram_block_attributes_destroy);
     call_rcu(block, reclaim_ramblock, rcu);
     qemu_mutex_unlock_ramlist();
 }

-- 
2.54.0


