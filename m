Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FAFDE7719E
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 09:20:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWBAl-0007FI-SP; Fri, 10 Jan 2025 04:19:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tWBAf-0007Ev-TE
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 04:19:15 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tWBAe-0007IY-8M
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 04:19:13 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4364a37a1d7so19511515e9.3
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 01:19:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736500750; x=1737105550; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=a/AxyWs1Y5bhGbnkus8u7Nx/S+vH7hpMYXAl7Z6DYSw=;
 b=qqvnYuNdGSVfrBx6Vnb5xOUrPzJfo6bqgApATVw3Nz8/nZWRTOdoc0KjBJ9OXfrn9T
 WeaURI4yRi5HHCz8ev22cW0HJCb+0bXNY6wHvN70KCRwxiaYPI6UoY7K4vmAGYPuJhK+
 mxFAJAnrIcUAOvudKByAXfT/lZioesFvVz+QLC7ZpVY3aY6KHCpslpW97yOTDMEE+9od
 nsbDlUT7pYrkftnm4b3COjgFCtklie3g20cdXGZMaGciYqh+ny8c6YSPrvD2mR2lIJLJ
 vcccZMIq++hu1cZ+i8t97yJM80uRyG91mKKqGfJ0VsaeCtmUmiK1dugdGFGYX7wwrDDY
 qlRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736500750; x=1737105550;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=a/AxyWs1Y5bhGbnkus8u7Nx/S+vH7hpMYXAl7Z6DYSw=;
 b=rQ9Q4SUyM6yVkG+soe2OXarDOvsTiR1M1mPE3w01Smm/gRmUv20bZbeECkqsCTI9hM
 pwuNobM8KqPPBDpl71ouNU8gFcT3l4gywSEja8fJuiqZ5SsZEltuijgULfxYrobVoO0E
 EiW79jrpojjB7nGzXk6e9KDu8n2W/JY1AcRMyjsi5IxcSRx5tvNsl/xsR3tN/nznP1mL
 E6NeoP3B9MPtSVl0U4e8fIqj6ju00Dib7qmxy1pYyYeG5+bKTjBugv5RNb2hvsIzbzh7
 1NIs8AMEB8+oZcF8yaoCI+WcicZ8XRc42myLC5oF4w2O8i6EQpF6pY/eI7283HZEHdzH
 +MdQ==
X-Gm-Message-State: AOJu0Yz6hVzH5NbLf0TRRoAdnSy6BmxuX/wGXGhZFbiw/DP/69u/uESH
 7kyPYnrWwxRfNaLGKyGx81o3V6aNC528nBReeGfeqqmPh2gvKrqXYD9Iq7LGnZEW0GAS+Z/GH54
 Ukf0=
X-Gm-Gg: ASbGnctKR/rkjusm8lV5ej8qmUfo4xa6zqmRzVfWiysj94Eo2qd/Sod6OMkUX7Vugln
 0ElYPniR5TJ+04WpTKtKJxtMVTBlLuuOgklMt4Q4wpl5IHn1AkLU5IAIluk/y5E1asfta+HFxF+
 v8X5hTWMxzukQr2DfS8sQ4o2+D5vTbA4JlZMnjg2EE7TDgLYouoNU/ARlvJ2nMtkBAXIk0XlmQB
 LfPVuOTlZvNhL/NnG/PL6yPfEbCHJtx88tLkoAb/v5vYfaLx3vehvlCi7B45NCga4orOVl5GXLP
 iTpuK9D3X+psQfDl2eGBVT8daC9DHBQ0Y91D
X-Google-Smtp-Source: AGHT+IGD2pYUMDfWYyFff25N0Jt3dxnEBrGH7LenXLcY+Dv1vky40n7xkZKi27GVXZeUu7dQTNyVdg==
X-Received: by 2002:a05:600c:458c:b0:434:a684:9b1 with SMTP id
 5b1f17b1804b1-436e267fbb5mr89522935e9.4.1736500750028; 
 Fri, 10 Jan 2025 01:19:10 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e9dc895esm45856405e9.13.2025.01.10.01.19.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 10 Jan 2025 01:19:09 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 0/6] hw/core: Unify hotplug decision logic
Date: Fri, 10 Jan 2025 10:19:02 +0100
Message-ID: <20250110091908.64454-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

Akihiko's v4 patch was doing too many things at once to
my taste, so I split it to follow dumbly each steps.
https://lore.kernel.org/qemu-devel/20250104-bus-v4-1-244cf1c6e2aa@daynix.com/

Akihiko Odaki (6):
  hw/qdev: Pass bus argument to qdev_hotplug_allowed()
  hw/qdev: Factor qdev_hotunplug_allowed() out
  hw/qdev: Introduce qdev_hotplug_unplug_allowed_common()
  hw/qdev: Check DevClass::hotpluggable in hotplug_unplug_allowed_common
  hw/qdev: Check qbus_is_hotpluggable in hotplug_unplug_allowed_common
  hw/qdev: Check machine_hotplug_handler in
    hotplug_unplug_allowed_common

 include/hw/qdev-core.h |  3 ++-
 hw/core/qdev-hotplug.c | 42 +++++++++++++++++++++++++++++++++++++++++-
 system/qdev-monitor.c  | 37 +++++--------------------------------
 3 files changed, 48 insertions(+), 34 deletions(-)

-- 
2.47.1


