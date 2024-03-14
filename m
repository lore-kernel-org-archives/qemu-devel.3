Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C320C54E60
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Mar 2024 17:23:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkomh-0004iK-D6; Thu, 14 Mar 2024 13:22:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>)
 id 1rkomg-0004hW-0B; Thu, 14 Mar 2024 13:22:26 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>)
 id 1rkomd-0007VD-NP; Thu, 14 Mar 2024 13:22:25 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7E91721C11;
 Thu, 14 Mar 2024 17:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1710436941; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=48U569SFn8PKr5C1IaFwLU5+q6DQk0Z8+yLxOYUzkAE=;
 b=WYrixRrTHFuoZZbfIzI0PiPuO57SyYFuDpAn3u3iw+mwKCcDhNjvfUU+AnVWIwhJtPhbgd
 kZc+Pwax8gy/SrSisQrIECKRwrb3LPiwIP5L8GEbPv6bNLwEt/wXn/1/mJm6pAwNpEs/Z+
 B5YmbW/JdalTJG1hjPJls5alACow0Ao=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1710436941;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=48U569SFn8PKr5C1IaFwLU5+q6DQk0Z8+yLxOYUzkAE=;
 b=4IoCMp1NRoqK/84Xp124sBQ8zB7WoAGFntwPQVCjCjkUw3Um86e5v6MUwyBVX+L4eybfTD
 UrFJ58udF/EU3oAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1710436941; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=48U569SFn8PKr5C1IaFwLU5+q6DQk0Z8+yLxOYUzkAE=;
 b=WYrixRrTHFuoZZbfIzI0PiPuO57SyYFuDpAn3u3iw+mwKCcDhNjvfUU+AnVWIwhJtPhbgd
 kZc+Pwax8gy/SrSisQrIECKRwrb3LPiwIP5L8GEbPv6bNLwEt/wXn/1/mJm6pAwNpEs/Z+
 B5YmbW/JdalTJG1hjPJls5alACow0Ao=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1710436941;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=48U569SFn8PKr5C1IaFwLU5+q6DQk0Z8+yLxOYUzkAE=;
 b=4IoCMp1NRoqK/84Xp124sBQ8zB7WoAGFntwPQVCjCjkUw3Um86e5v6MUwyBVX+L4eybfTD
 UrFJ58udF/EU3oAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 31B071368B;
 Thu, 14 Mar 2024 17:22:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id aRf1CU0y82UxTwAAD6G6ig
 (envelope-from <cfontana@suse.de>); Thu, 14 Mar 2024 17:22:21 +0000
From: Claudio Fontana <cfontana@suse.de>
To: Thomas Huth <thuth@redhat.com>, Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Cc: Claudio Fontana <cfontana@suse.de>, qemu-devel <qemu-devel@nongnu.org>,
 qemu-s390x <qemu-s390x@nongnu.org>, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH] docs/s390: clarify even more that cpu-topology is KVM-only
Date: Thu, 14 Mar 2024 18:22:18 +0100
Message-Id: <20240314172218.16478-1-cfontana@suse.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=WYrixRrT;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=4IoCMp1N
X-Spamd-Bar: /
X-Spamd-Result: default: False [-0.51 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; DWL_DNSWL_MED(-2.00)[suse.de:dkim];
 R_MISSING_CHARSET(2.50)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; BROKEN_CONTENT_TYPE(1.50)[];
 RCPT_COUNT_FIVE(0.00)[6]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; MX_GOOD(-0.01)[];
 TO_DN_ALL(0.00)[]; MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 7E91721C11
Received-SPF: pass client-ip=195.135.223.130; envelope-from=cfontana@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

At least for now cpu-topology is implemented only for KVM.

We already say this, but this tries to be more explicit,
and also show it in the examples.

This adds a new reference in the introduction that we can point to,
whenever we need to reference accelerators and how to select them.

Signed-off-by: Claudio Fontana <cfontana@suse.de>
---
 docs/system/introduction.rst       |  2 ++
 docs/system/s390x/cpu-topology.rst | 14 ++++++++------
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/docs/system/introduction.rst b/docs/system/introduction.rst
index 51ac132d6c..746707eb00 100644
--- a/docs/system/introduction.rst
+++ b/docs/system/introduction.rst
@@ -1,6 +1,8 @@
 Introduction
 ============
 
+.. _Accelerators:
+
 Virtualisation Accelerators
 ---------------------------
 
diff --git a/docs/system/s390x/cpu-topology.rst b/docs/system/s390x/cpu-topology.rst
index 5133fdc362..ca344e273c 100644
--- a/docs/system/s390x/cpu-topology.rst
+++ b/docs/system/s390x/cpu-topology.rst
@@ -25,17 +25,19 @@ monitor polarization changes, see ``docs/devel/s390-cpu-topology.rst``.
 Prerequisites
 -------------
 
-To use the CPU topology, you need to run with KVM on a s390x host that
-uses the Linux kernel v6.0 or newer (which provide the so-called
+To use the CPU topology, you currently need to choose the KVM accelerator.
+See :ref:`Accelerators` for more details about accelerators and how to select them.
+
+The s390x host needs to use a Linux kernel v6.0 or newer (which provides the so-called
 ``KVM_CAP_S390_CPU_TOPOLOGY`` capability that allows QEMU to signal the
 CPU topology facility via the so-called STFLE bit 11 to the VM).
 
 Enabling CPU topology
 ---------------------
 
-Currently, CPU topology is only enabled in the host model by default.
+Currently, CPU topology is enabled by default only in the "host" cpu model.
 
-Enabling CPU topology in a CPU model is done by setting the CPU flag
+Enabling CPU topology in another CPU model is done by setting the CPU flag
 ``ctop`` to ``on`` as in:
 
 .. code-block:: bash
@@ -132,7 +134,7 @@ In the following machine we define 8 sockets with 4 cores each.
 
 .. code-block:: bash
 
-  $ qemu-system-s390x -m 2G \
+  $ qemu-system-s390x -accel kvm -m 2G \
     -cpu gen16b,ctop=on \
     -smp cpus=5,sockets=8,cores=4,maxcpus=32 \
     -device host-s390x-cpu,core-id=14 \
@@ -227,7 +229,7 @@ with vertical high entitlement.
 
 .. code-block:: bash
 
-  $ qemu-system-s390x -m 2G \
+  $ qemu-system-s390x -accel kvm -m 2G \
     -cpu gen16b,ctop=on \
     -smp cpus=1,sockets=8,cores=4,maxcpus=32 \
     \
-- 
2.26.2


