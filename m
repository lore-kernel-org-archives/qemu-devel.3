Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F2B8C25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 07:17:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCa1R-00033s-34; Thu, 30 May 2024 03:16:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sCa1N-000316-TZ
 for qemu-devel@nongnu.org; Thu, 30 May 2024 03:16:22 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sCa1K-00050S-AL
 for qemu-devel@nongnu.org; Thu, 30 May 2024 03:16:21 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-357d533b744so568366f8f.2
 for <qemu-devel@nongnu.org>; Thu, 30 May 2024 00:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717053376; x=1717658176; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=87ltmpgZOJK0YfB8d87dTNrYg88x4T5S2MlOeagZ5vs=;
 b=dMV4saXwjCmP1Tr+2U9mKurc2d1L+VLUO13fJ027av+5hjEOozHb1BAte5mIpFxYGe
 R/qeoLBOItb+U+Y8svXkib/d33NyTGz5Yt5x0Yqtd0srabHp4EeahDWQQIA/L86wFe2y
 DZmKMLYOAsNWi0Yt0/xsiFHT757jWc+7CcGKJCSah6uI/aylowRhpbU0vBG5TbSn5nGS
 iZtGONGDQ3H8PWXr0hEOUBFofCIvLw87Nj5+5SG71snWd+qj5Tvoq+Ku4BepwiFaeErR
 OvD0FGHJxE4mEP+4MAWVbJejEvotfUpecxLG3ivn0eoq3Okp99n9/6i0DAB0wUJks60f
 BFVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717053376; x=1717658176;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=87ltmpgZOJK0YfB8d87dTNrYg88x4T5S2MlOeagZ5vs=;
 b=eiK56yX0o8XOeCcath/8hJK+yJLu6Cy44EchoDsbjCOIcoBfZbTxZiQxJgmwbd24cv
 eETMgvM3UZ0v+EUOjZCUr1DoWHXUnub2vUmAttXHNKNqt0BW/EmpI493g97OLWq+3SAx
 0j3D5Lbj08GflfTuko2Ebir8LAq60OJ4uX+VtDp4F/JRFWtkrcjzPXCdlqfkIatcDu8O
 TO5hLPmbFaO+xn4MS1AW9UpI4FcGtOfMI7thcbOr78qopvebRaPhxuVmbzBYprGYbE4z
 VI8Eo7fO6Jwf0UIy9IMN6zbhI+VDosOjeOTMCj8eJBtbUAuX0FYUmPTDq6zRQTRSCwP4
 lIMw==
X-Gm-Message-State: AOJu0YwBYw0/lcxXjNXwif9I9DpDaoLE1tVf74N4+olNINz6cb9Lf4H0
 KRLbYXji9gxBHOjKds9Cztz+uxObiT6sQBHsGZwbKYOgQf3I6z+36ECsYo09b4sF5ZYEb/baYBq
 r
X-Google-Smtp-Source: AGHT+IEI/TjCtdPaqb71PcCD1oCeXvTBiMT9UEVGc7g6211Sa7JwkHh+v9gJlCfkPuKdNOSJlg2rIw==
X-Received: by 2002:a5d:50c2:0:b0:357:73ca:9c00 with SMTP id
 ffacd0b85a97d-35dc009a619mr770445f8f.32.1717053376213; 
 Thu, 30 May 2024 00:16:16 -0700 (PDT)
Received: from m1x-phil.lan (xbn44-h02-176-184-35-50.dsl.sta.abo.bbox.fr.
 [176.184.35.50]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35579d7db5esm16835193f8f.15.2024.05.30.00.15.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 30 May 2024 00:16:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 Nicholas Piggin <npiggin@gmail.com>, devel@lists.libvirt.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Mads Ynddal <mads@ynddal.dk>,
 Markus Armbruster <armbru@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Igor Mammedov <imammedo@redhat.com>,
 Greg Kurz <groug@kaod.org>, Yanan Wang <wangyanan55@huawei.com>,
 qemu-ppc@nongnu.org, Eric Blake <eblake@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PATCH 0/2] qapi: Remove deprecated events
Date: Thu, 30 May 2024 09:15:46 +0200
Message-ID: <20240530071548.20074-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Remove MEM_UNPLUG_ERROR and 'vcpu' field in TRACE events,
all deprecated since long enough.

Philippe Mathieu-Daudé (2):
  hw/acpi: Remove the deprecated QAPI MEM_UNPLUG_ERROR event
  trace: Remove deprecated 'vcpu' field from QMP trace events

 docs/about/deprecated.rst       | 16 ----------------
 docs/about/removed-features.rst | 15 +++++++++++++++
 qapi/machine.json               | 28 ----------------------------
 qapi/trace.json                 | 27 +++------------------------
 hw/acpi/memory_hotplug.c        |  8 --------
 hw/ppc/spapr.c                  | 11 +----------
 trace/qmp.c                     |  2 --
 trace/trace-hmp-cmds.c          |  4 ++--
 8 files changed, 21 insertions(+), 90 deletions(-)

-- 
2.41.0


