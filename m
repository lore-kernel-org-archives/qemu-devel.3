Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FCE1C531C9
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2026 14:01:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wncw2-0003fR-1y; Sat, 25 Jul 2026 10:01:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wncvw-0003cO-7K
 for qemu-devel@nongnu.org; Sat, 25 Jul 2026 10:00:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wncvu-00053l-U1
 for qemu-devel@nongnu.org; Sat, 25 Jul 2026 10:00:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784988054;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+TTlcmViaW/jr0GgH0ehJXptanXZXliFPnYWOw9ddzY=;
 b=iBDYGROvXbG/JGSAFI1jXLS2PmdZ4qy7bBjz9TuNZ22oY0RQsXEwxZwmm5D0nuUDWqwnTm
 KzlICp+B796/sBxiukTCBBXgYTZkOfHzsYCWyHp8Lp3MRoouf2VQjXemsnG/25kix4cMIF
 Zwq7YZpwLGbsn+jSvso5K6BJ3jlZFYs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-442-WH263RbIOW2pp-hkSTLwBA-1; Sat,
 25 Jul 2026 10:00:48 -0400
X-MC-Unique: WH263RbIOW2pp-hkSTLwBA-1
X-Mimecast-MFC-AGG-ID: WH263RbIOW2pp-hkSTLwBA_1784988046
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 56BDD19560BF; Sat, 25 Jul 2026 14:00:45 +0000 (UTC)
Received: from localhost (unknown [10.44.22.7])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 103BA1591; Sat, 25 Jul 2026 14:00:42 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sat, 25 Jul 2026 18:00:06 +0400
Subject: [PATCH 5/7] hw/core/machine: free machine->fdt in machine_finalize()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260725-fix2-v1-5-5c9a6ce7b96a@redhat.com>
References: <20260725-fix2-v1-0-5c9a6ce7b96a@redhat.com>
In-Reply-To: <20260725-fix2-v1-0-5c9a6ce7b96a@redhat.com>
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
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqZMFmXwTAgpjiHXIDQP2F6pFQaQP0mTaHjVngT
 nIkCxm+8KOJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCamTBZgAKCRDa6OEJdZac
 5d3oEAC1km7RbdV4XtCIKL8zA60V13xVkEzvtfqeWr/f9ALV+CqbVUN/wGdnv+8tnxmdT/YhVLx
 LifdyHD0stZaS22zhP+OIRFbMi/WKRzf7cYTyZsiyTpUm+ifAhxxpMUz/0u6wCy2f6EdJH9vDI9
 bkzHeqgDzYgcbCAFtcD9YOlJOm3BgLf9f3V3WZhmhPMWWAbXPy4NggSwma+M+I3J1M/atI/prZc
 W2ye63zNk41kC7h/41Kv6ieo7aDgJabx0Mz0b/rpjclfi4F+z5tQynn4b6/89PJC61VcHI91oWh
 XBxo5JhwG0g1hwnS5GK9vW8NJRr4Hg9TtLC+wpg72iVIOrAXqvBSF6RfELEurXtI8NcW6+eWHdp
 GFoNxVyTzfoavUfm4c54ZHNo2p3grXc2Wcp5d1TE2AEr5YzVqEV93zNkMnYEMElB4Xw556igetm
 KZ8m5o5RTd/HGzmOrbkhUGrUDaJJK295U+tJ0HKSwGb1IvFzMu2fSOf+VRfc8jTHPeMwcngOxQ/
 TM11p9NassLY1PbS4JmJ7MOr/DDvoMgY3UBELSzMS80dAmWb8CcLtx0crjPwJy8S/UEtUV2KwlP
 YO8ImD9hYIR6TtfFbJS60yMEIkMxIh/utU7BSF6o4hpgB0RrM5DDUS1bcm60Zj5/By8PUa3cZKc
 +HV5Oo7iwKniXAg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.419,
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


