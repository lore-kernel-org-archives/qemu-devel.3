Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69A32EF9008
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 16:51:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxpR9-0003xU-KF; Wed, 04 Mar 2026 11:51:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vxpR7-0003wk-VA
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 11:51:01 -0500
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vxpR2-0002Ry-53
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 11:51:01 -0500
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-6610bd5f322so1127533a12.1
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 08:50:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772643054; x=1773247854; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rD8sfDTiye3PlqSCB8qDZy6AtX8/oF36wNt1WbZ4BO0=;
 b=nUcp8nWEcwK2ONA8EK+rYXvTzRdUQ6SgGvrEfu4dxBnwW73F1H38HkAhhrmihMlfDg
 ixlTwlNLNBWoojXGYwHDSI12U5bAJOTioEHtL+biThT5zXTV6ZxR5wXLRF1stFBGQUBd
 Y/lbHjOYaOi9vFjvjwg80xZfud5ymVQLbwLZJVIUHXlsCW8UXyr6QYcPIYGpYDisFx17
 JyjBdRnnCWClYRFCG2pZwySsuSESPoJ1OVmjLjQcOAdWt5WtWm1hrtXjiYZQwnGTaOyq
 GbzHAvFPtsYPdKjdlbJciE7AvuqSJxHz31uM9bRThUwIAm4IprLBmj0LJUVRMVF+NdfF
 gHaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772643054; x=1773247854;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rD8sfDTiye3PlqSCB8qDZy6AtX8/oF36wNt1WbZ4BO0=;
 b=ulvrR6xfBpKklvljS2G/SbPwv+4/V2bCu6Uzor/KRR8zXe2BBi8dHes0sWX5qZ3dnW
 5V6Kse8lvzW4RE9m90oWEfbKXE4RHjs2ixYNb0JlwDMQAJFNJks0NdhITFy6JSiDsR7C
 6R9lOoqSWIKo8qtN7jMcQn5vrVkBGXr4pLUBJ0qvTaxpgpjWPKEMDXChGNQPTt4TOe+3
 HezjEikuBbX+wVvaHn8HoBcI+PT3QNj0EwSWdPqLgzs6uzQkpKrJH1SuSp8GrSKWrKHn
 ObIKVY7hU/YtBYfanY2CY7VmKwVPybk6t9icxLOQsWXpXdyI892skHuQwQ/ueehkOas5
 gXRA==
X-Gm-Message-State: AOJu0YwDEi5vql4aODPb38G43XQmdd+iy92EPiolAvGzmhfZiUpL40J9
 gm7oUzwcvR3izHSawp3r1Vs78WzIorbA0Qjj6gAcyM8U4BbPMRD9y7e8ZNk1eKCczq8=
X-Gm-Gg: ATEYQzwXTeVe3HivesnHrP7ZG24zsPp/KJowVn5arjcRf/qO8s8J8gfrz3dBZbxVAYy
 DMP3nBUDmbTdM5A60+dB/AEO3bB9uKZ0OuKG/w7+RL4U6WrdpMEdQr+dzI2LAHCQPFxqsyWfnIp
 kWOpGamJ/qhApImrXkcPXfqKR2rH1sdEpfMa0pwvPYbq2eJCT5e/l+FurSn7rdRROA+i5u5qssQ
 wuyaQZWfG+RGUsFfao+Iv+8XVeqQaeOhBbD5zpRrWL+QZDuAEs+gUcwBEfOBKQIjsypYaAzRdt0
 2w3g2+ovyWjwk4bGkCn2fgrWZFh06aMujvP4KYLukmPOI8zEtMQ3BCqvuPM4m85DVirfWuWkvCD
 A9T8f3/ry2EPUwSXCp9yIdEpax4DL1Roxv9qlYTlOwyrfa59PszNw5lOu9utU5Oo1Rj1USbNo2b
 ZIgHCC76m4DrhVa2QcrTp8vLm6FHpCCh3RKg==
X-Received: by 2002:a17:906:ef0a:b0:b90:6a9b:a6cb with SMTP id
 a640c23a62f3a-b93f1405d9bmr142983866b.30.1772643054147; 
 Wed, 04 Mar 2026 08:50:54 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b935ac51843sm791234466b.16.2026.03.04.08.50.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2026 08:50:51 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0477762D92;
 Wed, 04 Mar 2026 16:50:45 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Yiwei Zhang <zzyiwei@gmail.com>
Subject: [PATCH 14/20] docs/system: virtio-gpu: Update Venus link
Date: Wed,  4 Mar 2026 16:50:36 +0000
Message-ID: <20260304165043.1437519-15-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260304165043.1437519-1-alex.bennee@linaro.org>
References: <20260304165043.1437519-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Dmitry Osipenko <dmitry.osipenko@collabora.com>

Change virtio-gpu Venus link, pointing it at the Mesa Venus
documentation instead of the protocol. The Mesa doc provides more
information and also has a link to the protocol.

Suggested-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Acked-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Reviewed-by: Yiwei Zhang <zzyiwei@gmail.com>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Message-ID: <20260303151422.977399-13-dmitry.osipenko@collabora.com>
---
 docs/system/devices/virtio/virtio-gpu.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/docs/system/devices/virtio/virtio-gpu.rst b/docs/system/devices/virtio/virtio-gpu.rst
index 89153103b9f..ef5fb0401d5 100644
--- a/docs/system/devices/virtio/virtio-gpu.rst
+++ b/docs/system/devices/virtio/virtio-gpu.rst
@@ -83,7 +83,7 @@ of virtio-gpu host memory window. This is typically between 256M and 8G.
 .. parsed-literal::
     -device virtio-gpu-gl,hostmem=8G,blob=true,venus=true
 
-.. _venus: https://gitlab.freedesktop.org/virgl/venus-protocol/
+.. _venus: https://docs.mesa3d.org/drivers/venus.html
 
 DRM native context is supported since release of `virglrenderer`_ v1.0.0
 using `drm`_ protocol.  ``DRM`` virtio-gpu capability set ("capset") requires
-- 
2.47.3


