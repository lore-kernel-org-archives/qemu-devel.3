Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98A43C53209
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jul 2026 20:46:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wo5jF-0000C3-R8; Sun, 26 Jul 2026 16:45:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wo5ix-00005a-DV
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 16:45:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wo5iv-0004RC-RV
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 16:45:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785098725;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+TTlcmViaW/jr0GgH0ehJXptanXZXliFPnYWOw9ddzY=;
 b=aZFHpBTZgq50zpH5AKfpj5Jm1PaWEs5zovfkTt44vEozHCzzsSCAmNZFhWFdpX+h9QemUP
 iWsb3G6gT9o/klLfGonHtFGBht4gfxNi43q0HI+pw1PQcMgs/1tRF5yan5dezuKO3AlgQx
 VxQKAZ5QGNawzMnSsOZPTLbyCjAte2c=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-610-4FWo0WPTPb6Hu_l50vZDeA-1; Sun,
 26 Jul 2026 16:45:21 -0400
X-MC-Unique: 4FWo0WPTPb6Hu_l50vZDeA-1
X-Mimecast-MFC-AGG-ID: 4FWo0WPTPb6Hu_l50vZDeA_1785098719
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AA331195607B; Sun, 26 Jul 2026 20:45:19 +0000 (UTC)
Received: from localhost (unknown [10.44.24.5])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A9A3630001BE; Sun, 26 Jul 2026 20:45:17 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 27 Jul 2026 00:44:09 +0400
Subject: [PATCH v2 10/12] hw/core/machine: free machine->fdt in
 machine_finalize()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260727-fix2-v2-10-d0c4831ed7ea@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=816;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=sIBVNLsGCOna3Hd2Wy4wJ32pRVDvMFiol07f6gVUCMU=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqZnGXv6fr/VusynUuJj+7991gNH6KtKVK0aAzQ
 YHC1MBl1J2JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCamZxlwAKCRDa6OEJdZac
 5Z5QD/4wWnnfTAOKE1y1toBi/3+xqSlAbzCU1yNo25LhIFeg6ovEG7WRWFtpS1JS40df1o4yInL
 u7AWArOtmKtK4+t8eahOiXoYNo/xoE1P9MGX1pPIv8knrfCrNS2WLr/4mTy+gZVdWJDYkKMNxPc
 0wpRzr/a8VT9Mkmb03NFoPR8sNFYq0KpQmd26ItLvA39hBxcpzZjM02PRtg3tUH4EsQnoiv971g
 u+438RwibEet6RdZXNsaYn0/kzo3D1a6tKguF8mrk9q4zaP54UblrAbgl2jhtBYSunT+IFKlCDj
 fe3aRKKtNYYKXQEQ26YaoYAJVaupRiRUUNqqcdI4t/fvg/nFfwDsIrQcndIXyafN6DFn++DPnJC
 hBZILSGXx2rZoYC77dlYghbp53qgYPGzYB8O1R/OHhVUs5MJM2dA4wgoGwlDrrrTCPLzFMZI0fv
 Yjt/vtrDAjj0Q4NNVnWDnC/OOTcG4dRqBf07sXJS0EFFXN/kWUKVFIfDm4AavoxS+mTs4J91pUH
 yjQTnw5zTcpdVOldmjZm8Wzcujc2xZyovTdxEuhGkMlH/S3zvWcUSxE6kJLCZNYOjeTpSR+Uc9J
 hYDXC/aSs6wA/G9M7O8pc/ahqo98Y/BhIT7FozEnQ73laditARDQoPio9M2pSW1Q6SsjdtucKKD
 yUIrMAEUkf0q+UQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

machine->fdt is a plain g_malloc0() buffer (see create_device_tree())
that boards populate during MachineClass::init, but machine_finalize()
never freed it, unlike the other boot-time buffers (dtb, dumpdtb,
kernel_filename, ...). Free it for consistency.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/core/machine.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 805148678d57..2b24d711d76f 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -1301,6 +1301,7 @@ static void machine_finalize(Object *obj)
     g_free(ms->kernel_cmdline);
     g_free(ms->dtb);
     g_free(ms->dumpdtb);
+    g_free(ms->fdt);
     g_free(ms->dt_compatible);
     g_free(ms->firmware);
     g_free(ms->device_memory);

-- 
2.55.0


