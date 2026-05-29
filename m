Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03E07CD6E4A
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 11:18:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSvDl-0001ZS-Mt; Fri, 29 May 2026 07:17:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wSvDj-0001Sx-EV
 for qemu-devel@nongnu.org; Fri, 29 May 2026 07:17:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wSvDi-0008LT-4N
 for qemu-devel@nongnu.org; Fri, 29 May 2026 07:17:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780053461;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6K3XQqYyaBJEyhYGRQWW9UcrsUENmBwDbMiigmHod70=;
 b=BTGte6UGs5GIIFfp1dBsFJM57tz7yh0l4UjoOl4446MfLyPP2ZKLBt6bpBO6Hib2MwzUFg
 QFK8KvqN+EKH65ZoQ/hlKDAdIAgZPsU4mokKCdXAys299Vyy0LWC0pNToIb1j75OYGb3pO
 mhN52vuWtZinuDiQRqI8UoKlMlH+/1U=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-652-5A4RuWDUOn6Eit6yA7ba1w-1; Fri,
 29 May 2026 07:17:38 -0400
X-MC-Unique: 5A4RuWDUOn6Eit6yA7ba1w-1
X-Mimecast-MFC-AGG-ID: 5A4RuWDUOn6Eit6yA7ba1w_1780053457
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EC9491956056; Fri, 29 May 2026 11:17:36 +0000 (UTC)
Received: from localhost (unknown [10.44.22.6])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DA91A30001BB; Fri, 29 May 2026 11:17:35 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 29 May 2026 15:16:30 +0400
Subject: [PATCH 09/32] ui: stop ui timer when closing
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260529-b4-ui-v1-9-8db3068421ef@redhat.com>
References: <20260529-b4-ui-v1-0-8db3068421ef@redhat.com>
In-Reply-To: <20260529-b4-ui-v1-0-8db3068421ef@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Alex Williamson <alex@shazbot.org>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=738;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=YUzpFgJn1xd0cDCfwxua7PPmtRu9gxO8rB3nqbkqdZI=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqGXWPGqDqVgIA7MJNrgWiIzpODVWrg/A9meuyf
 2c5FVMWJpCJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCahl1jwAKCRDa6OEJdZac
 5XpjEACIGnxqyJqedzsgfRwo4Uh1+tYMzzei+CFirlKCbSIgrf1YXGvrJcMDXZwI/V/a3XbDqgf
 Z8bLR+NEtOE4ca1WXmOJWYeJjh3Sfv89RBzu5wdh3iNlR6PJQPxI/fnFrIoDpb3pzDDQby4p+/N
 hvsU85qFS/eytYmaGDAFyulGamVKxw9LcimJECMjR/Ym3RnMwn3AGFB+IGrjWyHObEMI7bSwXRd
 bCsfHfVbrMI5/6sz97pRlUutO1F+2PRnuYQvFe/YfUxuzwdbne8SlpYLLf8k99OTa1/X8NxkwLd
 b/NjQHK0IsRLxrMnCH/NahWyDgfrXh8ZEk/Wb9x8c0i0Rnax48Dime8pTJem6x86vBH4OUM4EzY
 8d1IYGhhxhe8G7k3HMJnKqHBCl4uAns9VNMW/gLL2WsH8k/5JQvj0a3WKAjpdHyY2bpgnFW37+G
 0/xAg78PCG/4PUQ2NN9f5HHFgMANv3kamFC47s8DvAohr98/TA6xnkJ4hifeeOMyjtN6seH42dT
 Ey7B9o7py3Cs/FLy6ZczQ9O1A7wIEjGo4KkBvtciD4GfMlrY6f0/F3agCTyE20FeYj0pT9E5aeV
 B2hxyStj7wcIlKl9fTysHvNYYVOl2vp3qwMBG4DY7xdHVdBMS+zsUjhTqFKbpmrjIVDEhVoTTDo
 dc9DqYXRvp+gH+g==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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

hwops is reset, so if the UI timer is pending it will crash.

Fixes: 9588d67e72 ("console: minimal hotplug suport")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/console.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/ui/console.c b/ui/console.c
index a7c977d0c44..436444723a5 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -1136,6 +1136,7 @@ void qemu_graphic_console_close(QemuConsole *con)
     trace_console_gfx_close(con->index);
     object_property_set_link(OBJECT(con), "device", NULL, &error_abort);
     qemu_graphic_console_set_hwops(con, &unused_ops, NULL);
+    timer_del(con->ui_timer);
 
     if (con->gl) {
         qemu_console_gl_scanout_disable(con);

-- 
2.54.0


