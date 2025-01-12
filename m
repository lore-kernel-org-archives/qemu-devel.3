Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 539DBE77188
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jan 2025 22:18:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tX6H4-0007SA-E1; Sun, 12 Jan 2025 17:17:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX6H3-0007Rw-7P
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 17:17:37 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX6H1-0006Nd-3l
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 17:17:36 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-385deda28b3so2105896f8f.0
 for <qemu-devel@nongnu.org>; Sun, 12 Jan 2025 14:17:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736720253; x=1737325053; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ywj2BAcQgFygxoktSFGKPUmNs77JhmrlY9uWsg78bmQ=;
 b=rxY+gcQE5smfc8QyToVvNI9WbOIXyZ+XQgGhMt8hMHVg/VCYsU5LXT5WF46AgtPYFM
 Cam1sOvmmDWSYMa3cHDkNC/nPhShTmFh+HBxcKz4yxd/aCEwnqC9J0AcOvehDGZ+SZYE
 9y9TCF9aSRuEY7eusVbW7s3gxMoZ1IkoeI6eTlGlzChfonGrVrlDCXHY3/S80l31b8YF
 hgH/WzG5OCSqwdW/XAgkItw7wRt138yML4Uxbd1hd3oHoyM42ib2nwyBOomnuw8ypZ9N
 earO9uiztUjmJKZjTu3zSPhxctBgx3OGDvrT91Xthrgwl5JAPo7BboyGZPMvkJ1aeMT6
 olwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736720253; x=1737325053;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ywj2BAcQgFygxoktSFGKPUmNs77JhmrlY9uWsg78bmQ=;
 b=mO4X3o2rF6sZoTZZAbIy4kKpgb4q/BSmPy7w20HosoiIqXdyuafsIhCti8YOTuf9t7
 1KciNv6FZdW8cixB75tdxN860ls1R2oKnKiiQmOlzMBOC/BEuGZsd465G82vDv8StyEN
 vxKet5frTP/b/QnjlPOgu7kPhVbomvTWkP2uB9J29AZRIkEOqPMHxiefkyYQOAUDBVK+
 hMw8eDqjXgNHG7A8MHMZ0qz0qyyj5fIZYVaginRNNkIGmqbTyKABqmd9foOcvpdbOdvz
 uV6owyxN6H6xbcQJvw9XmcHPBWRVv+UNJeXY1VV5hjHxbVsrG79fUgwuxOf+kvcxkaaq
 kg5w==
X-Gm-Message-State: AOJu0YyezVJ4QMhz99ttgocf03xfrZiCLQeiHp04Pwf//E3nwu1h++HC
 uOh1B3YoMIkG7fbS9k2KHODPsi7wCp6BYa6MN1/sJ9t0wgK6mlkrzY3PuGfo9ZmnTuhLYQQVyNT
 5hZM=
X-Gm-Gg: ASbGnctHcHnwJYYG++J7TH4I2ExElW3puCJ88+km12NYNHJbIMJ8Y9CF2ldP9SAoAa2
 ew6uHHmU8P9r7HuDJ+9pSWzLN9iqNjXKX+1RH2z7DVBdDYV9qxaczhBJ9dxAtXFsYi77WwCldcs
 CgFwa8HRExAmI4SD6H+BGIT1ef/TA+YVNr9A2pDbVUeim7ACL+7Abg8Ogeg4Ax6GTS/xjD/MS6Q
 OhqQGGm45y4CDKbCjgLTVFuK2g7aVWccJQFUL41zkf50jZEQyMVkBq5/9cTkYpWMOf9bQhXe3Dm
 cT4gg0UGzJo+fJ5oASRnaCI+s5kiqdU=
X-Google-Smtp-Source: AGHT+IGaE3Bpwd757Zm+qqnW0aT2AO5khrusut3z1pGWSgpcSUwdpEIwmtq6LbUEOfJvFThdAMMaHQ==
X-Received: by 2002:a05:6000:1ac6:b0:38b:da34:5915 with SMTP id
 ffacd0b85a97d-38bda34591bmr2232597f8f.23.1736720252865; 
 Sun, 12 Jan 2025 14:17:32 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e3838a3sm10654601f8f.33.2025.01.12.14.17.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 12 Jan 2025 14:17:32 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PULL 01/49] pc-bios/meson.build: Silent unuseful DTC warnings
Date: Sun, 12 Jan 2025 23:16:37 +0100
Message-ID: <20250112221726.30206-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250112221726.30206-1-philmd@linaro.org>
References: <20250112221726.30206-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

QEMU consumes some device tree blobs, so these have been committed
to the tree in as firmware, along with the device tree source used
to generate them. We know the blobs are "good enough" to have QEMU
boot a system, so we don't really maintain and rebuild the sources.

These blobs were generated with older 'dtc' binaries. We use the
v1.6.1 version since 2021 (commit 962fde57b7 "dtc: Update to version
1.6.1").

Since commit 6e0dc9d2a8 ("meson: compile bundled device trees"),
if dtc binary is available, it is directly used to compile the
device tree sources. New versions of 'dtc' add checks which display
warnings or errors. Our sources are a bit old, so dtc v1.6.1 now
emit the following warnings on a fresh build:

  [163/3414] Generating pc-bios/canyonlands.dts with a custom command
  pc-bios/canyonlands.dts:47.9-50.4: Warning (unit_address_vs_reg): /memory: node has a reg or ranges property, but no unit name
  pc-bios/canyonlands.dts:210.13-429.5: Warning (unit_address_vs_reg): /plb/opb: node has a reg or ranges property, but no unit name
  pc-bios/canyonlands.dts:464.26-504.5: Warning (pci_bridge): /plb/pciex@d00000000: node name is not "pci" or "pcie"
  pc-bios/canyonlands.dts:506.26-546.5: Warning (pci_bridge): /plb/pciex@d20000000: node name is not "pci" or "pcie"
  pc-bios/canyonlands.dtb: Warning (unit_address_format): Failed prerequisite 'pci_bridge'
  pc-bios/canyonlands.dtb: Warning (pci_device_reg): Failed prerequisite 'pci_bridge'
  pc-bios/canyonlands.dtb: Warning (pci_device_bus_num): Failed prerequisite 'pci_bridge'
  pc-bios/canyonlands.dts:268.14-289.7: Warning (avoid_unnecessary_addr_size): /plb/opb/ebc/ndfc@3,0: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
  [164/3414] Generating pc-bios/petalogix-s3adsp1800.dts with a custom command
  pc-bios/petalogix-s3adsp1800.dts:258.33-266.5: Warning (interrupt_provider): /plb/interrupt-controller@81800000: Missing #address-cells in interrupt provider
  [165/3414] Generating pc-bios/petalogix-ml605.dts with a custom command
  pc-bios/petalogix-ml605.dts:234.39-241.5: Warning (interrupt_provider): /axi/interrupt-controller@81800000: Missing #address-cells in interrupt provider
  [177/3414] Generating pc-bios/bamboo.dts with a custom command
  pc-bios/bamboo.dts:45.9-48.4: Warning (unit_address_vs_reg): /memory: node has a reg or ranges property, but no unit name
  pc-bios/bamboo.dts:87.13-154.5: Warning (unit_address_vs_reg): /plb/opb: node has a reg or ranges property, but no unit name
  pc-bios/bamboo.dts:198.3-50: Warning (chosen_node_stdout_path): /chosen:linux,stdout-path: Use 'stdout-path' instead
  pc-bios/bamboo.dts:87.13-154.5: Warning (interrupts_property): /plb/opb: Missing interrupt-parent
  pc-bios/bamboo.dts:100.14-108.6: Warning (interrupts_property): /plb/opb/ebc: Missing interrupt-parent

From QEMU perspective, these warnings are not really useful. It is
the responsibility of developers adding DT source/blob to QEMU
repository to check the source doesn't produce warnings, but as
long as the blob is useful enough, QEMU can consume it. So these
warnings don't add any value, instead they are noisy and might
distract us to focus on important warnings. Better disable them.

'dtc' provides the '--quiet' option for that [*]:

  $ dtc --help
  Usage: dtc [options] <input file>

  Options: -[qI:O:o:V:d:R:S:p:a:fb:i:H:sW:E:@AThv]
    -q, --quiet
          Quiet: -q suppress warnings, -qq errors, -qqq all

Update meson to disable these unuseful DTC warnings.

[*] https://lore.kernel.org/qemu-devel/CAFEAcA-WJ9J1YQunJ+bSG=wnpxh1By+Bf18j2CyV7G0vZ=8b7g@mail.gmail.com/

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: BALATON Zoltan <balaton@eik.bme.hu>
Message-Id: <20231006064750.33852-1-philmd@linaro.org>
---
 pc-bios/meson.build | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/pc-bios/meson.build b/pc-bios/meson.build
index 4823dff189a..b68b29cc7d1 100644
--- a/pc-bios/meson.build
+++ b/pc-bios/meson.build
@@ -99,7 +99,8 @@ foreach f : [
         output: out,
         install: get_option('install_blobs'),
         install_dir: qemu_datadir,
-        command: [ dtc, '-I', 'dts', '-O', 'dtb', '-o', '@OUTPUT@', '@INPUT0@' ])
+        command: [ dtc, '-q', '-I', 'dts', '-O', 'dtb',
+                        '-o', '@OUTPUT@', '@INPUT0@' ])
   else
     blobs += out
   endif
-- 
2.47.1


