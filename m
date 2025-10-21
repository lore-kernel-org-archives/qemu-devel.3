Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5893BCCD1A5
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 20:52:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBJHn-0008Qm-TI; Tue, 21 Oct 2025 16:48:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBJHl-00088q-7b
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 16:48:49 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBJHf-00019f-HG
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 16:48:47 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4711f156326so46973335e9.1
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 13:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761079699; x=1761684499; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=MIqpoD4tAWeMFdopoink0YdKGCEbz9DmSRX0eUBynUQ=;
 b=e6Bj4QwFMalRZPNI636gHuTO+ZkJCmiVFljgCZEvExZY6JqUSP65IRWCj9+3mH5a7c
 4XMAH54vvu3fNfrpZTOGssKQTorGX80Nc1bp49c6LskFWpAKfwz38vRRdXuybOnb8WLc
 hgvdtcUwg3yFlIi3g4sogcjNrqd3IB9nuITxbu6kObriIsG0yo+K80sn3pzMu/XeF16J
 +zbL79aZJMJ4vhCXmMcGcj9B0XMjHcQDZL1u5Bf6WDM+KjcQpQwpIt+4c9bnxccBncdX
 /3q5qEIHGjP79Mi1Aleo09dcpAedrSNq4GUMOuEC4cg2doDMXyuLnevZwMbD+GuHQjr7
 6PRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761079699; x=1761684499;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MIqpoD4tAWeMFdopoink0YdKGCEbz9DmSRX0eUBynUQ=;
 b=CFY3k0jR36iHoOiD6W/lEefTMiX9biQBxvEaHWe/7VMMN13MUCAlXOH/LZxe1GcIi0
 TL+Wy4yS4dQLy9Y5AF9+6oiTMVvaXfpBGLfczIzJSDgcI+HHtevaZdpriz5tTueGYSk0
 0omeI9dwr1Kq8ONsFzEyokOT6d0nMWq69x08AhQXUk5Ld2b3eUr7efUr4mnvBG7tPS55
 Azb6Xr7DyjTARfrXyjknl3vQFCbFLO6AryudJaaNNwaEEbssr5hFfqeOEvMFG7VWYyzf
 qqMd3djalYjXv4V2urK7+NOczfxGjnFdwxCSliOOp/3w/QiIfPi64Gj7M49Qy+QyAqqF
 6E1A==
X-Gm-Message-State: AOJu0YxIEcxM3u/zBRv/X6AB6/01umkDVshMEIcdCrDiEPmgq3Wl+Ktj
 TAysHAHhj0/GVXlJEIAQxITvN0z+BvWeLYUGIbmw1rkhEINfCaIkK9eK38JMr++qOVdGUyWW8El
 1b/ejP04=
X-Gm-Gg: ASbGncu1JXLzaTVJbtdV+JfwisipbbrWsC64pPuw+fcTwsBextwI2bZ/uQ3qQOnSBvU
 IV83AMAvGwWirH5LTp9e0w+40tuQR+33OlSiRNPnCMfaqSlyrdRBWbafYPTbeq4urNvjRyVjkL3
 93tCp7juJI84avGgJuf+vQnl4sYLRTgizzEKWz5P6A/7SVu7N2zS6HkS6cI7BTyfUEctciDynju
 YAqL+az0ISgCJ5ktsXo4mHzGWSV5YdliyM1XcA2JAQB+YR0lxVNNv0iWQIU+zP+xodOEh12VEw1
 DweHwp+qCHXn9ZcI5yEwvOIV9k/OX+T0jhrT7sV3bPvf14tPitHtK5NnZhTeqF6Pn553iqgtj7L
 9cImelIbQmOBfnfAal6qoQkvBMuOSdkBzJpBEE8lUw3YpAGO6wnjQS6Bec2PxBGopBDsWl/10Ju
 Fd0krDrYCqvV3c2b+OuMW/WrZwAzzB92C5ODWCOck0snKxLiHJ4PmOUZd+3dRI
X-Google-Smtp-Source: AGHT+IHwGlFup/+fggBxT4JWJGPof9Oe4dijyG6xB8tsiBjrnjm7r9vcGZUFnqFchanohQ9oPsH+6g==
X-Received: by 2002:a05:600c:4e89:b0:46f:b42e:e392 with SMTP id
 5b1f17b1804b1-47117931c1dmr125611325e9.39.1761079699035; 
 Tue, 21 Oct 2025 13:48:19 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475c427c3ecsm10312065e9.2.2025.10.21.13.48.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Oct 2025 13:48:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 16/45] hw/xen: pass PCI domain to xc_physdev_map_pirq_msi()
Date: Tue, 21 Oct 2025 22:46:30 +0200
Message-ID: <20251021204700.56072-17-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251021204700.56072-1-philmd@linaro.org>
References: <20251021204700.56072-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

From: Roger Pau Monne <roger.pau@citrix.com>

It's currently impossible for passthrough devices on segment different
than 0 to work correctly, as the PCI domain is not provided to
xc_physdev_map_pirq_msi(), and hence it's unconditionally assumed that
all devices are on segment 0.

Adjust the call to xc_physdev_map_pirq_msi() to pass the PCI domain in
the high 16bits of the bus parameter.  On versions of Xen where this
is not supported the passed segment will be ignored and assume to be 0,
no worse than the current state.

Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
Reviewed-by: Frediano Ziglio <freddy77@gmail.com>
Reviewed-by: Anthony PERARD <anthony.perard@vates.tech>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Message-ID: <20251017155136.16540-1-roger.pau@citrix.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/xen/xen_pt_msi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/xen/xen_pt_msi.c b/hw/xen/xen_pt_msi.c
index e9ba17317ab..df15ccf0d03 100644
--- a/hw/xen/xen_pt_msi.c
+++ b/hw/xen/xen_pt_msi.c
@@ -138,6 +138,7 @@ static int msi_msix_setup(XenPCIPassthroughState *s,
         rc = xc_physdev_map_pirq_msi(xen_xc, xen_domid, XEN_PT_AUTO_ASSIGN,
                                      ppirq, PCI_DEVFN(s->real_device.dev,
                                                       s->real_device.func),
+                                     ((uint32_t)s->real_device.domain << 16) |
                                      s->real_device.bus,
                                      msix_entry, table_base);
         if (rc) {
-- 
2.51.0


