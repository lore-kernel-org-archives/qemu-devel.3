Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DF14FD7072
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 10:29:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2ReR-00022j-Lp; Tue, 17 Mar 2026 06:27:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1w2Rdx-0001vh-Cd
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 06:27:25 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1w2Rdr-0006VQ-Jw
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 06:27:19 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-485392de558so33159435e9.1
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 03:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1773743232; x=1774348032; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wa1h6U50bGiB8meyYuSt02vtuuLdduSF5Ef9ithEKUc=;
 b=S6YoQYoHs99WZnpbUgmzayF8tEd3ntAKBAo+1WqcnlSMk3zePp9gDGTTkQY8rul3J1
 eeUtGnCUGTztY01FGgmPXxg/5QPKdnJi7hz5lU+wL0lI1M5+ZmNPwwpvfyYZxvHu9daL
 wKUn8YsQ2bTJnuBE4pHmHdXQ5rFra+/uvEBI4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773743232; x=1774348032;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wa1h6U50bGiB8meyYuSt02vtuuLdduSF5Ef9ithEKUc=;
 b=OmWEeAJyXN56s6NNiIcqq/X5au7I30k1zvqqwDDIjm0ILJmSUTnGtU4ZZzIaCPL+as
 C4R4auoIbxczwgljMjqWrQQrLW1RlfWPIOt2l4tfaHIplaaCPO3GtvCS/YskQYSUxmHO
 00/9sqbAFaPNTapRK9j7otSjXK+vC+mlfg+sOV6OiunMkTLCkf7bTOXQqSK7aSLxoucb
 SqBF7P2HjYgqPMQolaGZ+BB/JC5GoKkF/PM+ktkKRVphTlp0RgUjO5YDKgOJrA4FTSEU
 meU+jCx0R3XjTVJ1As2A7ymRtbQF9ng/yTEk6edYUdgajTQfPqSUgT7hFSSrEmncO5AG
 8C+A==
X-Gm-Message-State: AOJu0YxSleTZ5Blkq2eTxfrR4PUeyqXTOzaD1hDNS72S784CUgiUQ12I
 lHVdOiU6nQ1eeeMMQEmwqJ1K+g4VnylxlKuV5zTp/Rzpapl8t8a85vBZJBJ9lfFNxIkasYn5DhP
 JnUre
X-Gm-Gg: ATEYQzz00QYO9uJu378sLzsUz4cSTQMDwKd4kuA6aYndAAa94oM7pN3HFOtj/Taeu+f
 rDUgeAyFM1eBCeVFQ7ff3TWs9xpqivzumak5O+UwVOf1kmgtGiZgrYPz0xrDT+Uzdqg1kxnhmmJ
 LNdMIUe0fl68FnTPw2s45wlI3yrA8itjX9PSXrsRaRIctCfwifIM7fqT+chBx5wz9SIcJXgJUyr
 BGyHDXQIbtydPMwuX8GQZrOLP33uJmPZf5G4Ex8+dLng3lSeIe5e4vYkNxd869+JJYEioeG0FM9
 fZLcsmeyhpLuj6gAaBB0K8kDsodcTDCYTZcTQmryPkmehjkglV2tZ/yWQy6ylnExcgQcZnXQY4Y
 H83mYUlE45lAVgzE0RtXCKbjryJueZ7/Zjs3sVuccR2CaWva3ehNvy3PfXdaAB/SpePzozxCqAF
 FuN/8raH6VHg9czNHfDiF/1KEMtzVbVf12BXoe6lrgffCL/Xjm8iMjtUx7uZ95djlxA+3BN4HS/
 JL+Be9t8lnkjCLwK4vYYpA=
X-Received: by 2002:a05:600c:4e08:b0:483:8062:b2f with SMTP id
 5b1f17b1804b1-485566ca9b4mr264800365e9.6.1773743230899; 
 Tue, 17 Mar 2026 03:27:10 -0700 (PDT)
Received: from alex-laptop.lan
 (p200300cf57228c0051af80c54da1a9bc.dip0.t-ipconnect.de.
 [2003:cf:5722:8c00:51af:80c5:4da1:a9bc])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4856ea9c36bsm61977665e9.9.2026.03.17.03.27.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 03:27:10 -0700 (PDT)
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
To: qemu-devel@nongnu.org
Cc: Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Jesper Devantier <foss@defmacro.it>, Klaus Jensen <its@irrelevant.dk>,
 =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@stgraber.org>,
 qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Kevin Wolf <kwolf@redhat.com>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Subject: [PATCH v5 1/8] migration/vmstate: export vmstate_{load,
 save}_field helpers
Date: Tue, 17 Mar 2026 11:27:01 +0100
Message-ID: <20260317102708.126725-2-alexander@mihalicyn.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260317102708.126725-1-alexander@mihalicyn.com>
References: <20260317102708.126725-1-alexander@mihalicyn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=alexander@mihalicyn.com; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>

Let's export vmstate_{load,save}_field() helpers, they will
be used in next patches to support fully-dynamic arrays with NULLs.

Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
---
 include/migration/vmstate.h |  6 ++++++
 migration/vmstate.c         | 10 +++++-----
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index d4a39aa7944..7ed4a0742b2 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -1255,6 +1255,12 @@ extern const VMStateInfo vmstate_info_qlist;
         .flags = VMS_END, \
     }
 
+bool vmstate_load_field(QEMUFile *f, void *pv, size_t size,
+                        const VMStateField *field, Error **errp);
+bool vmstate_save_field(QEMUFile *f, void *pv, size_t size,
+                        const VMStateField *field,
+                        JSONWriter *vmdesc, Error **errp);
+
 /*
  * vmstate_load_state() and vmstate_save_state() are
  * depreacated, use vmstate_load_vmsd() and vmstate_save_vmsd()
diff --git a/migration/vmstate.c b/migration/vmstate.c
index e98b5f5346c..616eb310e61 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -161,8 +161,8 @@ static bool vmstate_pre_load(const VMStateDescription *vmsd, void *opaque,
     return true;
 }
 
-static bool vmstate_load_field(QEMUFile *f, void *pv, size_t size,
-                               const VMStateField *field, Error **errp)
+bool vmstate_load_field(QEMUFile *f, void *pv, size_t size,
+                        const VMStateField *field, Error **errp)
 {
     if (field->flags & VMS_STRUCT) {
         return vmstate_load_vmsd(f, field->vmsd, pv, field->vmsd->version_id,
@@ -485,9 +485,9 @@ static bool vmstate_pre_save(const VMStateDescription *vmsd, void *opaque,
     return true;
 }
 
-static bool vmstate_save_field(QEMUFile *f, void *pv, size_t size,
-                               const VMStateField *field,
-                               JSONWriter *vmdesc, Error **errp)
+bool vmstate_save_field(QEMUFile *f, void *pv, size_t size,
+                        const VMStateField *field,
+                        JSONWriter *vmdesc, Error **errp)
 {
     if (field->flags & VMS_STRUCT) {
         return vmstate_save_vmsd(f, field->vmsd, pv, vmdesc, errp);
-- 
2.47.3


