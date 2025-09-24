Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA626CAC5B1
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 07:04:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1JXC-0005tZ-S3; Wed, 24 Sep 2025 03:03:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hzuo@redhat.com>) id 1v1JX6-0005sa-Ln
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 03:03:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hzuo@redhat.com>) id 1v1JX1-0001S9-SA
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 03:03:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758697389;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=SmQuyhy4urAjHBqOzjoXrkln1eE9fCvNPTUDvnkFRC8=;
 b=CkZSZszBcTw3jRUuh2Af2/O5zcpyTwrToRtlj5MF+rTTHUJQEFFj1lwJ8JP+kFLyHDSq0b
 VRpn9cQxJmR/1UzfMkDkvoK03ZAhrfs7O01JMYbm82DM/MTuiL3wiyQRjeJFjDjBbo2lyH
 VhBZeO+WcM8OXr8JL96m0PcQpJMepEQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-7-WWYxMMHAMfy_KZiZg_YgKQ-1; Wed,
 24 Sep 2025 03:03:07 -0400
X-MC-Unique: WWYxMMHAMfy_KZiZg_YgKQ-1
X-Mimecast-MFC-AGG-ID: WWYxMMHAMfy_KZiZg_YgKQ_1758697386
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 48C84195604F
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 07:03:05 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.72.116.111])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8CE87180035E; Wed, 24 Sep 2025 07:03:02 +0000 (UTC)
From: "Houqi (Nick) Zuo" <hzuo@redhat.com>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, Cindy Lu <lulu@redhat.com>,
 Michael Tsirkin <mst@redhat.com>
Subject: [PATCH] net/tap-linux.c: avoid abort when setting vnet_hdr_len on
 invalid fd
Date: Wed, 24 Sep 2025 15:02:16 +0800
Message-ID: <20250924070216.1802043-1-hzuo@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hzuo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

When QEMU creates a tap device automatically and the tap device is
manually removed from the host while the guest is running, the tap
device file descriptor becomes invalid. Later, when the guest executes
shutdown, the tap_fd_set_vnet_hdr_len() function may be called and
abort QEMU with a core dump when attempting to use the invalid fd.

This patch removes the abort() call. If the fd is found to be in a
bad state (e.g., EBADFD or ENODEV), the function will print an error message.

The expected behavior for this negative test case is that QEMU should
report an error but continue running rather than aborting.

Testing:
- Start QEMU with automatically created tap device
- Manually remove the tap device on the host
- Execute shutdown in the guest
- Verify QEMU reports an error but does not abort

(gdb) bt full
        tid = <optimized out>
        ret = 0
        pd = <optimized out>
        old_mask = {__val = {10}}
        ret = <optimized out>
        ret = <optimized out>
        save_stage = 1
        act = {__sigaction_handler = {sa_handler = 0x20, sa_sigaction = 0x20}, sa_mask = {__val = {16929458408262392576, 18446744073709550848, 139737042419943, 139737042419943, 0, 94049703655600, 139737042419943, 139737042670528, 18446744073709550328, 77, 139705603579344, 18446744073709551615, 139737041472378, 139705595179568, 16929458408262392576, 94049679794864}}, sa_flags = 281695456, sa_restorer = 0xa}
        s = <optimized out>
        i = 0
        nc = 0x5589a730ab28
        n = 0x5589a72cfa10
        err = 0x0
        i = 0
        k = <optimized out>
        bad = <optimized out>
        vdev = 0x5589a72cfa10
        k = 0x5589a5c162b0
        i = 0
        vdev = <optimized out>
        proxy = 0x5589a72c7470
        i = 0
        bus = 0x5589a72cf990
        tmp = <optimized out>
        print_once_ = false
        access_mask = 255
        access_size = 1
        i = 0
        r = 0
        reentrancy_guard_applied = <optimized out>
        size = <optimized out>
        val = 6
        result = 0
        release_lock = <optimized out>
        result = 0
        buf = 0x7f1711da6028 <error: Cannot access memory at address 0x7f1711da6028>
--Type <RET> for more, q to quit, c to continue without paging--
        l = <optimized out>
        mr_addr = 6
        mr = 0x0
        _rcu_read_auto = 0x1
        result = 0
        fv = 0x2956
        attrs = {secure = 0, space = 0, user = 0, memory = 0, debug = 0, requester_id = 0, pid = 0, address_type = 0, unspecified = false, _reserved1 = 0 '\000', _reserved2 = 0}
        run = 0x7f1711da6000
        ret = <optimized out>
        run_ret = <optimized out>
        r = <optimized out>
        cpu = <optimized out>
        __clframe = {__cancel_routine = <optimized out>, __cancel_arg = 0x0, __do_it = 1, __cancel_type = <optimized out>}
        qemu_thread_args = 0x5589a5d72580
        start_routine = 0x55899a918850 <kvm_vcpu_thread_fn>
        arg = 0x5589a5d68b40
        r = 0x0
        ret = <optimized out>
        pd = <optimized out>
        out = <optimized out>
        unwind_buf = {cancel_jmp_buf = {{jmp_buf = {32, 8894544057743421332, -1288, 0, 140726164742416, 140726164742679, -8831356496486092908, -8844535456800460908}, mask_was_saved = 0}}, priv = {pad = {0x0, 0x0, 0x0, 0x0}, data = {prev = 0x0, cleanup = 0x0, canceltype = 0}}}
        not_first_call = <optimized out>

Signed-off-by: Houqi (Nick) Zuo <hzuo@redhat.com>
---
 net/tap-linux.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/tap-linux.c b/net/tap-linux.c
index e832810665..37a53416e8 100644
--- a/net/tap-linux.c
+++ b/net/tap-linux.c
@@ -206,7 +206,6 @@ void tap_fd_set_vnet_hdr_len(int fd, int len)
     if (ioctl(fd, TUNSETVNETHDRSZ, &len) == -1) {
         fprintf(stderr, "TUNSETVNETHDRSZ ioctl() failed: %s. Exiting.\n",
                 strerror(errno));
-        abort();
     }
 }
 
-- 
2.47.3


