Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E482CCF9E3
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Nov 2025 14:59:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJCJ8-00058z-1a; Wed, 12 Nov 2025 09:58:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@jiesong.me>) id 1vJCJ5-00058a-Tp
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 09:58:47 -0500
Received: from out28-78.mail.aliyun.com ([115.124.28.78])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@jiesong.me>) id 1vJCJ2-0005fR-86
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 09:58:47 -0500
Received: from Sun.localdomain(mailfrom:mail@jiesong.me
 fp:SMTPD_---.fKqlE-B_1762959463 cluster:ay29) by smtp.aliyun-inc.com;
 Wed, 12 Nov 2025 22:58:23 +0800
From: Jie Song <mail@jiesong.me>
To: berrange@redhat.com
Cc: armbru@redhat.com, mail@jiesong.me, qemu-devel@nongnu.org,
 songjie_yewu@cmss.chinamobile.com
Subject: Re: [PATCH] monitor/qmp: cleanup socket listener sources early to
 avoid fd handling race
Date: Wed, 12 Nov 2025 22:57:42 +0800
Message-ID: <20251112145743.15075-1-mail@jiesong.me>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <aRRN1pTjJCopPpS2@redhat.com>
References: <aRRN1pTjJCopPpS2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.28.78; envelope-from=mail@jiesong.me;
 helo=out28-78.mail.aliyun.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

Hi Daniel,

Thank you for your review and valuable feedback.

You're absolutely right about the concerns. Let me clarify the scenario 
this patch addresses:
The remove_fd_in_watch() function handles the client-side connection case. 
However, when the chardev is configured in server mode 
(e.g., -qmp unix:/var/lib/libvirt/qemu/qmp-xxx/qmp.monitor,server=on,wait=off), 
there's listener that needs cleanup. The socket_chr_listener_cleanup() 
is specifically intended to handle this server-side listener to prevent the 
race condition between the main thread and IOThread monitoring the same listener fd.

I apologize for the unsafe assumption that the chardev would always be a SocketChardev.
You're correct that this could cause crashes with other chardev types. 
To fix this properly, I’m considering a more general design. 
Would the following approach be acceptable?

  1.Add a chr_listener_cleanup callback to the ChardevClass structure
  2.Implement this callback in SocketChardev
  3.Register it in char_socket_class_init()
  4.In monitor/qmp.c, call it through the class method
    remove_fd_in_watch(chr);
    ChardevClass *cc = CHARDEV_GET_CLASS(chr);
    if (cc->chr_listener_cleanup) {
        cc->chr_listener_cleanup(chr);
    }

This would maintain type safety while keeping the fix properly abstracted
at the chardev layer. Would this fix make sense?

Looking forward to your guidance.

Best regards,
Jie Song 

