Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 472A4E7719A
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 06:18:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVPOH-0000gB-Bo; Wed, 08 Jan 2025 01:18:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tVPOF-0000fi-GF
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 01:18:03 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tVPOD-0000Fy-0O
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 01:18:03 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2166360285dso245492365ad.1
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 22:18:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736317079; x=1736921879;
 darn=nongnu.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=KNHmz4n9fYXb4CxXWu3evTiRGsfEj2fs3Wplujdp9aI=;
 b=29VRspw6In5YxYR27FGhikVejlmqtnPX0N2O1QyfnU+fyjuelgy71bTMnohIyflj32
 RWofn7pWFfUF//XHX0j+mmDGJiOda44vrexxvDiD7jBSHrrLmmRrD3QeumvtA0/wHgvc
 sTDF41+bKJEQnwu5DRx3u6+mv/otBexuaWeb7xJq4q8HFw0r46wQMpDfbQcwlMf3lOmi
 v4rNVKwMMy4r4wEA+C2UdC4iLI/FunLTHkJDgNABwiiFxP00bIrxjM6xpTDmIvRm1n0K
 8AJgHNRDSdpSH/UBUyRav7971sER729YH6h9/GmWc9ocUDa8fs0LW23DIBKEb4HaM3fA
 MpyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736317079; x=1736921879;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KNHmz4n9fYXb4CxXWu3evTiRGsfEj2fs3Wplujdp9aI=;
 b=XfrSmhyQClzzMV7GMrSBYQwyjOD1Y+Exi3f40HAfh3IBqUddXnH2U8/R5sC3onnfxL
 KypEyjHaAthslwQ7yBpVMvwRyUvQeWWXY/AlkxyC9aB17I26HwvcyW9V98Rcsw80NVoA
 PKbZ6Itd9DuCvPXy1nnwq08T8H2x1MW68s4XOMHnjpAPo77UDNnsOjDXxDdC2AENssUV
 BpnSxfpooVTwmgUT7ZKBqXZ2NiuMMqi5G8Ib0AIqQDlV5f/DTTnsxlEydAph8UKomPaB
 hNG52+unlSQXYhhegzncUmO9/QfvX/zZEcxpPSyL2JeS3DYv9eeOKTNqclqc+cQk4Rbe
 cjYQ==
X-Gm-Message-State: AOJu0Yymhx2Jq/liG1dm1LP4xPUaw4KbGNN2zt7jsTYnFUUzPBJFvxyd
 Udh3LRszxIgPmtxmIT0/BoSacMAi43ETAn6bPr8DaCHTzm2I0WU62aJhP6DH24Q=
X-Gm-Gg: ASbGncugTr8DxWKcLHSPnP7T0XBDspVITweu9vJGQ7jht8cXVF9jke38SqjS2UeqhCo
 oft+CU2hPrvrBJTv/fhRj85RVRC76Msi83Fka8CrYBa2SLBDzuORcHTaZWkQXZTHn/1KSgE9996
 q1EGg6uGASUaf/vvYOIBKUygyfS6HeNvSxUscN90D2aaUErlKxAUy3K2J96/oDuWo43z6RKYvBg
 RB8tDCEMX3/oX+BgGhQsqWxSjMuDhVUQT42OwHeYb34zkSH04OkmI9S0dc=
X-Google-Smtp-Source: AGHT+IEuy+sMr70BSejD3s+Fyor9w0NVaht2/YkpqgdlqN/ikH7mp7tUG+hoj/BH3Gma0lx69spDqA==
X-Received: by 2002:a05:6a00:846:b0:725:df1a:285 with SMTP id
 d2e1a72fcca58-72d21f476b9mr2255874b3a.12.1736317079175; 
 Tue, 07 Jan 2025 22:17:59 -0800 (PST)
Received: from localhost ([157.82.203.37]) by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-72aad848020sm34411603b3a.81.2025.01.07.22.17.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jan 2025 22:17:58 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v4 0/4] virtio: Convert feature properties to OnOffAuto
Date: Wed, 08 Jan 2025 15:17:49 +0900
Message-Id: <20250108-virtio-v4-0-cbf0aa04c9f9@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAI0YfmcC/2WNyw6CMBBFf4V0bU07U16u/A/josIgs5CaQhoI4
 d8tJPiIyzOZc+4sevJMvTgls/AUuGfXRTCHRFSt7e4kuY4sQIHRSqMM7Ad2UmeGLDZQphWK+Pz
 01PC4hS7XyC33g/PT1g16ve4JsyeClkpSWddNbgtdlPpc26nj8Vi5h1gbAb48gLcH0bsBlgYwI
 5Xin4e7lyqtPnsYvQypydW2+usty/ICnwX67g0BAAA=
To: Jason Wang <jasowang@redhat.com>, 
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Luigi Rizzo <rizzo@iet.unipi.it>, 
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>, 
 Vincenzo Maffione <v.maffione@gmail.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 Yuri Benditovich <yuri.benditovich@daynix.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Lei Yang <leiyang@redhat.com>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This series was spun off from:
"[PATCH 0/3] virtio-net: Convert feature properties to OnOffAuto"
(https://patchew.org/QEMU/20240714-auto-v3-0-e27401aabab3@daynix.com/)

Some features are not always available with vhost. Legacy features are
not available with vp_vdpa in particular. virtio devices used to disable
them when not available even if the corresponding properties were
explicitly set to "on".

QEMU already has OnOffAuto type, which includes the "auto" value to let
it automatically decide the effective value. Convert feature properties
to OnOffAuto and set them "auto" by default to utilize it. This allows
QEMU to report an error if they are set "on" and the corresponding
features are not available.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
Changes in v4:
- Added patch "qapi: Do not consume a value if failed".
- Link to v3: https://lore.kernel.org/r/20250104-virtio-v3-0-63ef70e9ddf3@daynix.com

Changes in v3:
- Rebased.
- Link to v2: https://lore.kernel.org/r/20241022-virtio-v2-0-b2394236e053@daynix.com

Changes in v2:
- Expanded the message of patch "qdev-properties: Accept bool for
  OnOffAuto".
- Link to v1: https://lore.kernel.org/r/20241014-virtio-v1-0-e9ddf7a81891@daynix.com

---
Akihiko Odaki (4):
      qapi: Do not consume a value if failed
      qdev-properties: Accept bool for OnOffAuto
      qdev-properties: Add DEFINE_PROP_ON_OFF_AUTO_BIT64()
      virtio: Convert feature properties to OnOffAuto

 include/hw/qdev-properties.h |  18 ++++++++
 include/hw/virtio/virtio.h   |  38 +++++++++-------
 hw/core/machine.c            |   4 +-
 hw/core/qdev-properties.c    |  83 +++++++++++++++++++++++++++++++++-
 hw/virtio/virtio-bus.c       |  14 +++++-
 hw/virtio/virtio.c           |   4 +-
 qapi/qobject-input-visitor.c | 103 +++++++++++++++++++++++++++++--------------
 7 files changed, 207 insertions(+), 57 deletions(-)
---
base-commit: 38d0939b86e2eef6f6a622c6f1f7befda0146595
change-id: 20241013-virtio-164ea3f295c3

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


