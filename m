Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC47BC9EC86
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 13:18:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfHnb-0002XR-8Y; Mon, 12 Jan 2026 08:17:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vfHlg-0001a5-Gm
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 08:15:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vfHle-0002cG-2B
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 08:15:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768223733;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1BBB0qFSJi0GhP/DTeqzyi1vrmJY0plBlAa5qkOZ0JU=;
 b=hd5bHZIPqhK1K95nHjUmg74dPkziHy9woaIO+5K0f1HIDGfZBOxlIltuQpv3hxFNLQ7b7Y
 nd3ruHpXa3bqZi+GEu2j+VG3aqG36WSD8ptQk9hERtiC/SrcjqUgvOPhurySoaoiUyZ59x
 ywAHz4wBKNkwZswsEOJU3lJd3zR+ziI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-260-8lnhfLrbMWe5xlkuqP8oHw-1; Mon,
 12 Jan 2026 08:15:29 -0500
X-MC-Unique: 8lnhfLrbMWe5xlkuqP8oHw-1
X-Mimecast-MFC-AGG-ID: 8lnhfLrbMWe5xlkuqP8oHw_1768223728
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D1128180061E; Mon, 12 Jan 2026 13:15:28 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.179])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4B74130001A2; Mon, 12 Jan 2026 13:15:27 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 12/15] target/s390x: Simplify S390_ADAPTER_SUPPRESSIBLE
 definition
Date: Mon, 12 Jan 2026 14:14:54 +0100
Message-ID: <20260112131457.67128-13-thuth@redhat.com>
In-Reply-To: <20260112131457.67128-1-thuth@redhat.com>
References: <20260112131457.67128-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Commit 1497c160661 ("s390x: add flags field for registering I/O
adapter") defined S390_ADAPTER_SUPPRESSIBLE twice, one when
KVM is available and another when it isn't. However both
definitions expand to the same value. Unify them, adding an
extra safety check in KVM-specific file.

This allows removing the target-specific 'CONFIG_KVM'
definition in "cpu.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20260107130807.69870-15-philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 include/hw/s390x/css.h | 2 ++
 target/s390x/cpu.h     | 6 ------
 target/s390x/kvm/kvm.c | 2 ++
 3 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/include/hw/s390x/css.h b/include/hw/s390x/css.h
index 0b0400a9d4f..d3326237c9f 100644
--- a/include/hw/s390x/css.h
+++ b/include/hw/s390x/css.h
@@ -238,6 +238,8 @@ uint32_t css_get_adapter_id(CssIoAdapterType type, uint8_t isc);
 void css_register_io_adapters(CssIoAdapterType type, bool swap, bool maskable,
                               uint8_t flags, Error **errp);
 
+#define S390_ADAPTER_SUPPRESSIBLE 0x01
+
 SubchDev *css_find_subch(uint8_t m, uint8_t cssid, uint8_t ssid,
                          uint16_t schid);
 bool css_subch_visible(SubchDev *sch);
diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index ba2bf177e8f..40bc1f0741d 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -39,12 +39,6 @@
 
 #define S390_MAX_CPUS 248
 
-#ifndef CONFIG_KVM
-#define S390_ADAPTER_SUPPRESSIBLE 0x01
-#else
-#define S390_ADAPTER_SUPPRESSIBLE KVM_S390_ADAPTER_SUPPRESSIBLE
-#endif
-
 typedef struct PSW {
     uint64_t mask;
     uint64_t addr;
diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
index bd6c440aefb..54d28e37d4d 100644
--- a/target/s390x/kvm/kvm.c
+++ b/target/s390x/kvm/kvm.c
@@ -2082,6 +2082,8 @@ int kvm_s390_vcpu_interrupt_post_load(S390CPU *cpu)
     return r;
 }
 
+QEMU_BUILD_BUG_ON(S390_ADAPTER_SUPPRESSIBLE != KVM_S390_ADAPTER_SUPPRESSIBLE);
+
 int kvm_arch_fixup_msi_route(struct kvm_irq_routing_entry *route,
                              uint64_t address, uint32_t data, PCIDevice *dev)
 {
-- 
2.52.0


