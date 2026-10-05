Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80E62CA5FF5
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 12:16:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDhXY-0008Gx-93; Mon, 05 Oct 2026 08:11:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xDhVI-0005zU-89
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 08:09:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xDhVG-0004hU-FH
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 08:09:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791202149;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Vyu3AFg/uvFZq9zBba9+zCX/AMwxMobcoxANLVof+PQ=;
 b=aUJdXRKD2KcinJVyOWaIuAi9Bt+ttvs/9/0nq4fMR+z3tnu5a7RDVPDv7tImH5g8sBEfFP
 jpnopOFbdLXQqyd3hi44iR7K7cIWAfRy84RYzTdsAtlRfeK+J6tc6Z2bixI9j3kBDdgxmX
 4nkZOyC28uaArN4PcXuMg+NmAA+52Ls=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-39-_LEdkx3sOvyteES5clPiYA-1; Mon,
 05 Oct 2026 08:09:06 -0400
X-MC-Unique: _LEdkx3sOvyteES5clPiYA-1
X-Mimecast-MFC-AGG-ID: _LEdkx3sOvyteES5clPiYA_1791202145
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8AB241828B28; Mon,  5 Oct 2026 12:09:05 +0000 (UTC)
Received: from berrange.csb (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1F6A33001D29; Mon,  5 Oct 2026 12:09:03 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v3 04/24] hw/xen: replace "long unsigned int" with "unsigned
 long " for dtrace
Date: Mon,  5 Oct 2026 13:08:35 +0100
Message-ID: <20261005120855.421973-5-berrange@redhat.com>
In-Reply-To: <20261005120855.421973-1-berrange@redhat.com>
References: <20261005120855.421973-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

dtrace (or at least systemtap's fake "dtrace" binary) doesn't like to
see "int" and "long" together in the typename, it just wants the
bare "long".

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/xen/trace-events | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/xen/trace-events b/hw/xen/trace-events
index b67942d07b4..a31983ce1d3 100644
--- a/hw/xen/trace-events
+++ b/hw/xen/trace-events
@@ -57,8 +57,8 @@ cpu_ioreq_config_read(void *req, uint32_t sbdf, uint32_t reg, uint32_t size, uin
 cpu_ioreq_config_write(void *req, uint32_t sbdf, uint32_t reg, uint32_t size, uint32_t data) "I/O=%p sbdf=0x%x reg=%u size=%u data=0x%x"
 cpu_get_ioreq_from_shared_memory_req_not_ready(int state, int data_is_ptr, uint64_t addr, uint64_t data, uint32_t count, uint32_t size) "I/O request not ready: 0x%x, ptr: 0x%x, port: 0x%"PRIx64", data: 0x%"PRIx64", count: %u, size: %u"
 xen_main_loop_prepare_init_cpu(int id, void *cpu) "cpu_by_vcpu_id[%d]=%p"
-xen_map_ioreq_server_shared_page(long unsigned int ioreq_pfn) "shared page at pfn 0x%lx"
-xen_map_ioreq_server_buffered_io_page(long unsigned int ioreq_pfn) "buffered io page at pfn 0x%lx"
+xen_map_ioreq_server_shared_page(unsigned long ioreq_pfn) "shared page at pfn 0x%lx"
+xen_map_ioreq_server_buffered_io_page(unsigned long ioreq_pfn) "buffered io page at pfn 0x%lx"
 xen_map_ioreq_server_buffered_io_evtchn(int bufioreq_evtchn) "buffered io evtchn is 0x%x"
 destroy_hvm_domain_cannot_acquire_handle(void) "Cannot acquire xenctrl handle"
 destroy_hvm_domain_failed_action(const char *action, int sts, char *errno_s) "xc_domain_shutdown failed to issue %s, sts %d, %s"
-- 
2.55.0


