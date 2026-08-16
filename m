Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA05AC5DF66
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 19:14:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvgIg-0008Pv-Rm; Sun, 16 Aug 2026 15:13:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wvgIZ-0008Os-Jh
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 15:13:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wvgIV-0007MI-Jy
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 15:13:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786907610;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TjP6IZyL1wZfBA11ddnUfYEtbz1AdcHT+GDTQx9g4qQ=;
 b=KN2gN42ZsHtxWsFxU7UDckiqR+V8qwMZTsF3j4F4t+X6JbKluXNrPJXTJo8sIIuHdKJtYT
 cZA9CxqUvdkySHb2/GC9E9ZN++qWRiMts0QoVOoYFnwaJmsR5ZlMDUjBwVlYUSFhmwHqFY
 vgVpipojAuQuwH4EU3YGbIjdfq9Glho=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-325-VZJe16jSPVO0ycrvDK6Pmw-1; Sun,
 16 Aug 2026 15:13:26 -0400
X-MC-Unique: VZJe16jSPVO0ycrvDK6Pmw-1
X-Mimecast-MFC-AGG-ID: VZJe16jSPVO0ycrvDK6Pmw_1786907603
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 928BD195608B; Sun, 16 Aug 2026 19:13:23 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7F94A195608A; Sun, 16 Aug 2026 19:13:22 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 16 Aug 2026 23:12:34 +0400
Subject: [PATCH v3 07/49] system: decouple qmp_inject_nmi() from Monitor
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260816-qemu-no-hmp-v3-7-e53fc35bc550@redhat.com>
References: <20260816-qemu-no-hmp-v3-0-e53fc35bc550@redhat.com>
In-Reply-To: <20260816-qemu-no-hmp-v3-0-e53fc35bc550@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, 
 Zhao Liu <zhao1.liu@intel.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1181;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=I1/fzKLWiT+n3BHD7LJOXQzdIK2ISEvPZsiae/7j/8o=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqgguwvSwMDYDaej4u5U9kayz/8WRUR9E5khFPd
 IAWC7/JLDeJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaoILsAAKCRDa6OEJdZac
 5RI0D/9fetknzWA2oQvv3XSS4psa7S2GxcEDucsXB5F8m5i8gkTXH0XYG0W9yJeDfzRxMyIJ7e0
 0IH6rt3I7S+n7ds39mXJE+CXwSItR1jUWaHXpr0t2E5yPJfN6BXY4X5hYjVN4vKtLnUbvL6m6P4
 pB4FoPMKa1zD4NXArkC0zvkJAiu3ifX/CngjnVYUcDOC4aTXQzvSancbDC49P8NmuxJ3d8J7uPp
 hC2sbU27w1nt4u0pMtkxjOlT1IbBMaVPHg9JRX0K1X0X02mxsljV2nLYbHXHtH5UwpZ1l/+Qt5C
 U7X4EPSQOiIRCjCPTW2u531BMvi/dwWeVf1meZ/6nx4vv6iRPEQTUQs5L9kYk4hMpL7r5kNN/YJ
 EQFXEGmcmSZq2+XaBrKvUln4vKlqA+1m+5ihJhWMWWH7Zpc9lj9/MZeFf7x7sBhRDCVry1w2Ail
 rbytc/ICUq6D5rM4xCKz5fzPIFadByHCuoVc2goyGad3fyIxnHDabyYQ0dcXqnUYzbVn2LQ3ISv
 gHQYev/UCNxWq0QvUtbxG4tKdb7/RUBxavpIyhWSAlF0hNts9tnLrjc9XqbrxkM6iP/yhVyT8OJ
 bE8sJAvuzWI8iQp0+mjkBtx4JZZrKsAaTcSGVFnvW4zRouEXIyTyrew2H81H/DWek0sOnIhHarQ
 tm2HFnTxiRt2PRg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.342,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Use first_cpu directly instead of going through monitor_get_cpu_index(),
as this is HMP-territory. QMP doesn't have a `cpu` command, we should
add arguments instead when needed.

Update the inject-nmi doc to accurately describe per-architecture NMI
delivery.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 qapi/machine.json | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/qapi/machine.json b/qapi/machine.json
index 2d63c1bac3b4..29ab1cb9d7f4 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -432,10 +432,10 @@
 ##
 # @inject-nmi:
 #
-# Injects a Non-Maskable Interrupt (machine specific: for example on
-# s390x CCW only the first vCPU receives the NMI, but on x86 machines
-# all vCPUs receive it).  The command fails when the guest doesn't
-# support injecting.
+# Injects a Non-Maskable Interrupt into the virtual machine.  The NMI
+# is delivered to all vCPUs (x86, hppa, ppc64) or to the first vCPU
+# (s390).  The command fails when the guest doesn't support
+# injecting.
 #
 # Since: 0.14
 #

-- 
2.55.0.543.g5ebe2ebe4ea8


