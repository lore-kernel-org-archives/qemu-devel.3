Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04A50C531D0
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 22:32:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wn1x7-0005AZ-Id; Thu, 23 Jul 2026 18:31:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1wn1wt-00054P-To
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 18:31:28 -0400
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1wn1wl-0001Tb-BL
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 18:31:20 -0400
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-81ed073fed0so11628757b3.0
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 15:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784845878; x=1785450678; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ylRn09y+xnzIXfbeVocInrK2nRf4OiszJaVCpi6B21A=;
 b=jxL0mPej/CmVNqf9dgJXGeOKWoZJkpzM5NFs8LkkTzsI8i1KwvESu7O6cjiEErf/c6
 CBA4rlDY9WbL55H8L2UlKyra2rusRlRjE5wdg46TiX+veT4kuc+bxX0DTdWDA9K1u0sm
 clrn1X6zFI+0JQDCO08JWhudx/85RMV8ooko1+yh36KtL4BeAa3W4q9twpOLoVTeeSQr
 VEk7w8TQrMoykNbA6FXN757bsxu3dCTTFxFpqL4JymUBkyHqhaWlWjR2h8AL/dewkocO
 NeCdfQ7WIgrjuXJQKXvwZhhl0RwAGcAODWaGs3EdcSAwxac+QNXyCLhrn3ZHEu2RPDxe
 uVjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784845878; x=1785450678;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ylRn09y+xnzIXfbeVocInrK2nRf4OiszJaVCpi6B21A=;
 b=NtEqzgttOIAVvsrAAl0jMvl3G3M6qWQfFnjeI85x+4M+onxwmzMAYXh2KPO2lyTe2q
 rLVMQPFTCrvXN57fxyu01LU+dzStQVOAnwnRw87nyQ2Bc+qqc0U3QlNdi8vHYkpsvK+9
 0rWDO07BNjtnNScfDujg2HJZs5h3Sp+mn4ZNrl370DjIJz3wt89G0uAvzjsgh/4YPkdU
 CHoHrmq7OsYAnb1nbrQDj0FzZTYiCY9QBVImtAx2Bdu6vJYfLPxyaCiGgUkNHgS6ciwX
 NJHHdIzPpTeAo19AlaGOgDqdzXsX0qgUcXMmkWp6KFn74rD5cJTVrPF0bPpP4V61wIQI
 D+sA==
X-Gm-Message-State: AOJu0YzPVXiUjTlm3guorCUFFN6KKJCujh/6lZJSMSTAtnjdn/cugZQ3
 UoM58afxpRehZi0VkMZ/D5tvWSlthw3Gt7HTLw70pFxQbJM+9UxhaYVu
X-Gm-Gg: AR+sD10pVayv++LwE3dSBHhFdTJB92IbisNEMkb44jYXYNRGeveP9Nr4aaEy5YnClFf
 kffU8SYgG4AnI69ly+WZ3cGdNeV7vhe4KGmaiP2Qwp/83F3hCxNtPOHfJXtG1JTInUmmCLx1eWI
 3pD7aKGhO4ejDFCsrnhcZOsS69X8NvAqYFl2uQMLv8QyB7E7+AJAZyv5+1Bc+4tHP+qCayY/fgA
 oL/akAho7bRvYNYMw1QeR+rxLksPCFBe1egmJHHrAT87LANEpGafmkZrRPDulVs2EBMkxmuhYRB
 +hRDLLVez9EC8m6SPnf9V67jfWB99CMdauBzenoQgnLmdoSL0Y1rNUCV4Nh0Sq0DwRgJxwMQoDU
 osZTV0USkbQIW1duZOj3pJqqrvatug89d37mnaYYpWtjSg0bZF84A1yahFFMlU/2WkvhpfGj4D+
 BFL65w45M=
X-Received: by 2002:a05:690c:3389:b0:81e:fd36:ff73 with SMTP id
 00721157ae682-81f4c15ffc8mr15595487b3.5.1784845878437; 
 Thu, 23 Jul 2026 15:31:18 -0700 (PDT)
Received: from [127.0.1.1] ([2600:1700:e140:14d0:446f:49ff:37bd:d45a])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-81f33c3c1c5sm35766777b3.17.2026.07.23.15.31.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 15:31:18 -0700 (PDT)
From: Connor Kite <connorkite@gmail.com>
Date: Thu, 23 Jul 2026 15:30:09 -0700
Subject: [PATCH RFC 10/15] hw/virtio/vhost-shadow-virtqueue: range boundary
 in translation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260723-vhost-user-isolated-memory-v1-10-6b97c439eb28@gmail.com>
References: <20260723-vhost-user-isolated-memory-v1-0-6b97c439eb28@gmail.com>
In-Reply-To: <20260723-vhost-user-isolated-memory-v1-0-6b97c439eb28@gmail.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
 Haixu Cui <quic_haixcui@quicinc.com>, Raphael Norwitz <rnorwitz@nvidia.com>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Milan Zamazal <mzamazal@redhat.com>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, qemu-block@nongnu.org, 
 virtio-fs@lists.linux.dev, "Gonglei (Arei)" <arei.gonglei@huawei.com>, 
 zhenwei pi <zhenwei.pi@linux.dev>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 Jason Wang <jasowangio@gmail.com>, Peter Xu <peterx@redhat.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Alyssa Ross <hi@alyssa.is>, Demi Marie Obenour <demiobenour@gmail.com>, 
 Connor Kite <connorkite@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784845839; l=1603;
 i=connorkite@gmail.com; s=20260723; h=from:subject:message-id;
 bh=04f7EERf9vN/x+nrTxJ0MQEJIkC9u9fbifj56dOif+M=;
 b=i0fxAoQx7q77vNmc1kVFBCgRpGEUX6uEbuCl2hfAM5HOMSgGi3rgs4fhCEYoklxivGZougSSo
 5KxRK6PnQIJCIWR78oY8lUaZCs3lbAecaSUbGRqQRgxdv8E1xNkqEzQ
X-Developer-Key: i=connorkite@gmail.com; a=ed25519;
 pk=xg/3N8AntFCYogaIgN5NC/KkT7UlZB6ktPIRliJ3hv4=
Received-SPF: pass client-ip=2607:f8b0:4864:20::112f;
 envelope-from=connorkite@gmail.com; helo=mail-yw1-x112f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

iova-tree expects inclusive range sizing when maps are allocated or searched.
Currently, svqs use exclusive sizing when searching their
vhost-iova-tree for a match to the region to be translated.  This could
lead to errors if the region to be translated is at the edge of an iova
region.

Fix this by reducing `needle.size` by 1 in
vhost_svq_translate_addr to bring then it line with DMAMap and iova-tree
convention.

Signed-off-by: Connor Kite <connorkite@gmail.com>
---
 hw/virtio/vhost-shadow-virtqueue.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shadow-virtqueue.c
index 9e3c359f50..20e5c7d2f1 100644
--- a/hw/virtio/vhost-shadow-virtqueue.c
+++ b/hw/virtio/vhost-shadow-virtqueue.c
@@ -104,14 +104,14 @@ static bool vhost_svq_translate_addr(const VhostShadowVirtqueue *svq,
             /* Search the GPA->IOVA tree */
             needle = (DMAMap) {
                 .translated_addr = gpas[i],
-                .size = iovec[i].iov_len,
+                .size = iovec[i].iov_len - 1,  /* Inclusive */
             };
             map = vhost_iova_tree_find_gpa(svq->iova_tree, &needle);
         } else {
             /* Search the IOVA->HVA tree */
             needle = (DMAMap) {
                 .translated_addr = (hwaddr)(uintptr_t)iovec[i].iov_base,
-                .size = iovec[i].iov_len,
+                .size = iovec[i].iov_len - 1, /* Inclusive */
             };
             map = vhost_iova_tree_find_iova(svq->iova_tree, &needle);
         }

-- 
2.43.0


