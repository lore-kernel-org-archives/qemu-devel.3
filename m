Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2E63E7717D
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 16:08:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM8Bn-0001o3-4u; Fri, 13 Dec 2024 11:06:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tM8BY-0001k5-A1
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 11:06:38 -0500
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tM8BV-0006fx-G8
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 11:06:35 -0500
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-aa67ac42819so318099866b.0
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 08:06:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1734105991; x=1734710791;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TLgf/hBtKPWGX+IefC929iFjKjT8oYxXZ2UyNeVgI20=;
 b=eMnDd/fBJkNxhXDWMwQpyChErFwycheJWR0E7Dz98qXlPk8FarZjK9inBfsZtVd27q
 zd1FJJCtZ+MUXnWijrXF5JeYN4mhzrB1ZuMN33xGauwPQ5/kSKRtjs8VD7pvhxJYS4J9
 /3ek37sxWQGNEql1NTY0KLkJBT6dDXHRyFGL9QDXoXMud5cuVtL+qWUzOsn/Wqr/h1l1
 2YLHL9S1LI7y9sQnwteBPMnfSPoG1mctqUYzRB0Hhdz4LaIYRIVOEMrdvcYtx7Dt/BlQ
 hiyov/z2bmyZGYlCqYoquSFY62DeBcqti7KdRzmUxmmC1J0wO1M5tMdw+OS+1A1WF/+X
 FgWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734105991; x=1734710791;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TLgf/hBtKPWGX+IefC929iFjKjT8oYxXZ2UyNeVgI20=;
 b=J2jYnhVfFOlntf1Clvcppajzb2gdswQ0nMEhaH4g6Endcr8aICti5ApcDQW/VSn5yi
 ek4oIdeDf/x0C0wmwwtlXNXO2/uSjKBfnLDarS0/OSRH/YlMh40u2AwkeQlOOD2HL70z
 JFTBBTPMlbl3pr8lappZHTUXhFPiLKj21HoLkGCPlfiORCcPJGqkx3TeltAYhu4XIoks
 oU9oFzA6yMuMl97JKuEFHqEZ8VP/NvvmCxnLGbBHwH0e3hnkPktfbMkesJivku0wZznW
 I7LpoQDvLL8Fh6YLmqwxQeBIKmc95rzR7GzIX/lDHvSrMD681XT64xhHUEJcKgXn7Gt/
 XdSA==
X-Gm-Message-State: AOJu0YxmXV6MwIXStxR/l1xxTiWQRHfMKtNNBchVtcADufRss6Q6bkzj
 6Xib9UqepieQKRkjce6RSJvBhPb65dBer9EXO2fYm+FXQ3RtLPki5lbgrKyLA0j6LH0Zxh3ogIB
 m9Q==
X-Gm-Gg: ASbGncv+9EIELw3OJzXmfsxR9sm7nl9kCrpu/hY8DrXHOqxscTvj2WGg7vefss4m2aX
 +lTtCk4Xrj/z21Tk45JJr92ySXjwIYTHdKJtOoDAG4EuUvlgwH2XKYRwsOPuabedb8ubdObEo+c
 sC1rYv1dGSznaptPIiORt5IW7+BC2brRlHUPB5mq4o9mEvlqHhtLQhP25hvMd1npKiVnbxmkiHc
 WaISUR8cS+t3hqBb48xKIt5qK13147cIRBv1NfVVn+5eqf5UFivA5zATW0Wa1PW4nBBqxuQvdU7
 J5fMV5vi9ubLDVhGt1VsU6vbAbMaOMYR
X-Google-Smtp-Source: AGHT+IHaw3W3f56M3kqBelZ34InNyOfGln+ODqqA2m0ooUtMCs6A1BxKnzI5uO0CA8otU6vZGdEHiA==
X-Received: by 2002:a17:906:a3cc:b0:aab:92bd:1a8f with SMTP id
 a640c23a62f3a-aab92bd1acamr41468066b.26.1734105989884; 
 Fri, 13 Dec 2024 08:06:29 -0800 (PST)
Received: from localhost.localdomain (h082218084190.host.wavenet.at.
 [82.218.84.190]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa667843413sm916683166b.24.2024.12.13.08.06.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 13 Dec 2024 08:06:29 -0800 (PST)
From: Phil Dennis-Jordan <phil@philjordan.eu>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, philmd@linaro.org, thuth@redhat.com,
 zhao1.liu@intel.com, imammedo@redhat.com, akihiko.odaki@daynix.com,
 Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH v2 6/6] hw/vmapple: XHCI controller's interrupt mapping
 workaround for macOS
Date: Fri, 13 Dec 2024 17:06:19 +0100
Message-Id: <20241213160619.66509-7-phil@philjordan.eu>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241213160619.66509-1-phil@philjordan.eu>
References: <20241213160619.66509-1-phil@philjordan.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: neutral client-ip=2a00:1450:4864:20::62a;
 envelope-from=phil@philjordan.eu; helo=mail-ej1-x62a.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NEUTRAL=0.779 autolearn=no autolearn_force=no
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

This change enables the new conditional interrupt mapping support
property on the vmapple machine type's integrated XHCI controller
using compat_props.

The macOS guest driver attempts to use event rings 1 and 2 on the XHCI
controller, despite there being only one (PCI pin) interrupt channel
available. With conditional interrupt mapping enabled, the XHCI
controller will only schedule events on interrupter 0 in PCI pin mode.

Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
---

v2:

 * Set the "conditional-intr-mapping" property via compat_props, not
   directly on the created XHCI controller object.

 hw/vmapple/vmapple.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/hw/vmapple/vmapple.c b/hw/vmapple/vmapple.c
index 66336942c8d..1732334c779 100644
--- a/hw/vmapple/vmapple.c
+++ b/hw/vmapple/vmapple.c
@@ -641,8 +641,19 @@ static void machvmapple_machine_init(void)
 }
 type_init(machvmapple_machine_init);
 
+static GlobalProperty vmapple_compat_defaults[] = {
+    /*
+     * macOS XHCI driver attempts to schedule events onto even rings 1 & 2
+     * even when (as here) there is no MSI(-X) support. Disabling interrupter
+     * mapping in the XHCI controller works around the problem.
+     */
+    { TYPE_QEMU_XHCI, "conditional-intr-mapping", "on" },
+};
+
 static void vmapple_machine_10_0_options(MachineClass *mc)
 {
+    compat_props_add(mc->compat_props, vmapple_compat_defaults,
+                     G_N_ELEMENTS(vmapple_compat_defaults));
 }
 DEFINE_VMAPPLE_MACHINE_AS_LATEST(10, 0)
 
-- 
2.39.5 (Apple Git-154)


