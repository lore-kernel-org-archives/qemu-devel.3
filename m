Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AD8AC53209
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jul 2026 20:47:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wo5j3-0008QF-41; Sun, 26 Jul 2026 16:45:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wo5it-0008Pk-B8
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 16:45:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wo5ir-0004QM-Ez
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 16:45:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785098720;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s7WPHlfybK9wgT6X16AjorCstp8vZ/94rL5kznfJWio=;
 b=IRsNaB2NxdlJXkSkSoIJxGqtDUqWAzAtPxuH0euCAylILUCu528p0e0iBC5RmHB4Htn4pP
 YW5dIlifn7xSFjlQx+BPn+Q9ChHQBh+65kC4myfMS3VPsN0Q9MCojjS7kNg0a4cLskBV4p
 PD7IOJXgF+qrK4VGcG5KIbkAlXnzD1I=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-665-sq1FeV81PO6gnCoRPG_YDA-1; Sun,
 26 Jul 2026 16:45:16 -0400
X-MC-Unique: sq1FeV81PO6gnCoRPG_YDA-1
X-Mimecast-MFC-AGG-ID: sq1FeV81PO6gnCoRPG_YDA_1785098714
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A82EB1956068; Sun, 26 Jul 2026 20:45:13 +0000 (UTC)
Received: from localhost (unknown [10.44.24.5])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B835A180049F; Sun, 26 Jul 2026 20:45:11 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 27 Jul 2026 00:44:08 +0400
Subject: [PATCH v2 09/12] hw/ppc: fix dangling fdt reference
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260727-fix2-v2-9-d0c4831ed7ea@redhat.com>
References: <20260727-fix2-v2-0-d0c4831ed7ea@redhat.com>
In-Reply-To: <20260727-fix2-v2-0-d0c4831ed7ea@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org, 
 Jonathan Cameron <jic23@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
 Fam Zheng <fam@euphon.net>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Zhao Liu <zhao1.liu@intel.com>, Roman Bolshakov <rbolshakov@ddn.com>, 
 Phil Dennis-Jordan <phil@philjordan.eu>, Wei Liu <wei.liu@kernel.org>, 
 linux-cxl@vger.kernel.org, Brian Cain <brian.cain@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1191;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=xVw6bhj6Lyb5iaDKjsHTyu75/0clDHHxVE1UNjqqjMw=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqZnGX2Y+rWTiYiQt1e+yf1EHsB+qZXRe7kZsoO
 SpPByrEy0mJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCamZxlwAKCRDa6OEJdZac
 5RB/EACr+9Kc6bCEszt9T3iHIwv94R/fghtv5Kp9Yh1KBXH0pg2Up9jaSZldWAwW3Uk8hkCs1YZ
 p3J864iaDVaiulOz91BUVcXWc+lf4i5J0CcldHsrMqNVEp5ugXAUnbIkHdFQ3IEYeqiCRzETpzl
 2jbjAIIABmyQyqp+QWG7w7fHnAl+BTWk3/NilkDd1UJFPUGLWtazpVrBkExzRm0Cn6mW3YNh+vY
 O4PEmtY6OxCkVx+c8HLg7y4uHS1daWlcC3QThwKl7ayMkL2D+eO8Kupom7OUAvpxrlTxkTQVPsv
 8vEB0jOXYriXcL7eazHDL0u/F/XU4zsQMevwM8B4/ZaacGIJDScRA4LTRCpH28t1wZF29aW0nIG
 7rKEYuGcTIW1+ZgIefsC5gXWcUeLGPSIzrEPZ+19JCgKKhGLwd2Om27/KLTvic3qoYoD/WeKbXP
 aDUk9jCQZss/2F3WoxR7w/wk4l4QfbjA7NYgiUmceBhWk/T+xGC/DTwq+vUGuEsFlS33wLAK2X6
 y7q8dlu/CWQQCAjafpoBdbVBq6hShuLeR4mISm01dM99TVtmTSHxnX44sWPXFn4QXHukX2+osk4
 qDx3OxmmNzlB/6QsnafaeVhIYJqSRnIIQLsjXe1aINRgwHAYwk0zZLKFntXG0Iii3145tIOcNbg
 /2/VKc7644O4fUw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
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

machine->fdt is aliasing fdt_blob. We need to make sure it is cleared
or updated when we free fdt_blob.

Fixes: d890f2fa9f1e ("hw/ppc: set machine->fdt in spapr machine")
Reported-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/ppc/spapr.c       | 1 +
 hw/ppc/spapr_hcall.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index b79828b4e90c..2fa4db3d493a 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2137,6 +2137,7 @@ static int spapr_dtb_pre_load(void *opaque)
     g_free(spapr->fdt_blob);
     spapr->fdt_blob = NULL;
     spapr->fdt_size = 0;
+    MACHINE(spapr)->fdt = NULL;
 
     return 0;
 }
diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 23bcd788daf6..2ed063279200 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -1511,6 +1511,7 @@ static target_ulong h_update_dt(PowerPCCPU *cpu, SpaprMachineState *spapr,
     g_free(spapr->fdt_blob);
     spapr->fdt_size = cb;
     spapr->fdt_blob = fdt;
+    MACHINE(spapr)->fdt = fdt;
     trace_spapr_update_dt(cb);
 
     return H_SUCCESS;

-- 
2.55.0


