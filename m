Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5F62CD1296
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 14:18:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtpoo-0001yU-Ih; Mon, 08 Apr 2024 10:17:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rtpoe-0001kF-Du
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 10:17:46 -0400
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rtpoO-0002vR-PM
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 10:17:44 -0400
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2d8863d8a6eso22685591fa.3
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 07:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712585847; x=1713190647; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tTrrjuqi39GdndcUSlrUx63rjA633KgDlIwvQVz3vGE=;
 b=WGeTUGUhvODhtajlGZ76s226esBCCTVLBYhh2QyRMAII8mqMgBFstaBMn+HX9bN5kG
 W/SzLgdKVhvZ+itiIH2vLx7n7968KUqeykzrC4/mvLOTTendne7lB8Qy4841dIhUZGmp
 flSnvZ3qjnD+2/Pu4ibGwW91HaGakuQ9teA5/z2+rvHSj0tuXr77V81CF6Fwb4Xj57CN
 V1X3dHh3/IsoiiZuxKbkvMI9XuIYmEfteeOwTljzAbj0U+CTmOujsXE+qLw3MVCQBHaw
 7lM0LdZs8Zo2rKa1VXj9V+Lgt48b+Y+FVTZWn5y013EDcz9eswmMPvt46qVFWC6V4Epf
 4S8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712585847; x=1713190647;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tTrrjuqi39GdndcUSlrUx63rjA633KgDlIwvQVz3vGE=;
 b=uRjoDgTYDJT6T676zLOZvtUxArvWHRSTOuCX714V7ogdM4JG0nQWZqFoyJmLKVup42
 P0aSnNe1X2U4XXUHDNsvrfLR7KxZB+7aJR2SpuwtrgGrQJp8Gk1Va4udlRnYa/QCuxcc
 nvY+10n1mAP9cq6NqyfyPK0qdZxDnuSDJs4se/iF2jSXhD/0DqjbusTh/GG1mO2yVLEF
 tqrarNkffNwsZ+6zRklJG+35UqhYJULOP3rm1ugIY68s10xlw+Sx30NZ4fyR6fhf9rQh
 ybGdP0tfgUQcUZOJRELWPObaGoPyL2x1PztbUv/iiSGLnrbZF2kEGfzylbNrGBv9SkqJ
 wbfw==
X-Gm-Message-State: AOJu0Yy2VDgr3GH3+dZyqOh+BK7S5EK5KyDgjIfEXf16tX4Vt3yX8CDj
 J+oFhg0zb6FKZIgkSItQvixpM55mDDGJaPx4Aof9KhNz5TYMk6I8cGgbviT3fEPNhQ4aiPMbVPQ
 y
X-Google-Smtp-Source: AGHT+IER0eGuBtQ8QPpa4Lzdb8EQlkRl12ao3NY9kXyi+sBCJUjtY0Sb0+eirU85eldpkQT92XdZew==
X-Received: by 2002:a05:6512:3c8e:b0:514:88df:88b9 with SMTP id
 h14-20020a0565123c8e00b0051488df88b9mr8747779lfv.45.1712585846534; 
 Mon, 08 Apr 2024 07:17:26 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.144.67])
 by smtp.gmail.com with ESMTPSA id
 ek15-20020a056402370f00b0056c3013485csm4115387edb.69.2024.04.08.07.17.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 08 Apr 2024 07:17:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bin Meng <bin.meng@windriver.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexander Bulekov <alxndr@bu.edu>, qemu-block@nongnu.org
Subject: [RFC PATCH-for-9.0? 1/2] hw/sd/sdcard: Avoid OOB in sd_read_byte()
 during unexpected CMD switch
Date: Mon,  8 Apr 2024 16:17:16 +0200
Message-ID: <20240408141717.66154-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240408141717.66154-1-philmd@linaro.org>
References: <20240408141717.66154-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x234.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

For multi-bytes commands, our implementation uses the @data_start
and @data_offset fields to track byte access. We initialize the
command start/offset in buffer once. Malicious guest might abuse
by switching command while staying in the 'transfer' state, switching
command buffer size, and our implementation can access out of buffer
boundary. For example, CMD17 (READ_SINGLE_BLOCK) allows to read up to
512 bytes, and CMD13 (SEND_STATUS) up to 64 bytes. By switching from
CMD17 to CMD13 (see reproducer below), bytes [64-511] are out of the
'status' buffer.

Our implementation return R0 status code for unexpected commands.
Such in-transaction command switch is unexpected and returns R0.
This is a good place to reset the start/offset fields to avoid
malicious accesses.

Can be reproduced running:

  $ export UBSAN_OPTIONS=print_stacktrace=1:halt_on_error=1
  $ cat << EOF | qemu-system-i386 \
                     -display none -nographic \
                     -machine accel=qtest -m 512M \
                     -nodefaults \
                     -device sdhci-pci,sd-spec-version=3 \
                     -device sd-card,drive=mydrive \
                     -drive if=none,index=0,file=null-co://,format=raw,id=mydrive \
                     -qtest stdio -trace sd\* -trace -sdbus_read
  outl 0xcf8 0x80001010
  outl 0xcfc 0xe0000000
  outl 0xcf8 0x80001004
  outw 0xcfc 0x02
  write 0xe000002c 0x1 0x05
  write 0xe000000f 0x1 0x37
  write 0xe000000a 0x1 0x01
  write 0xe000000f 0x1 0x29
  write 0xe000000f 0x1 0x02
  write 0xe000000f 0x1 0x03
  write 0xe000000c 0x1 0x32
  write 0xe000000f 0x1 0x06
  write 0xe0000005 0x1 0x01
  write 0xe0000007 0x1 0x01
  write 0xe0000003 0x1 0x00
  write 0xe000000f 0x1 0x11
  write 0xe000002a 0x1 0x01
  write 0xe000002a 0x1 0x02
  write 0xe000000f 0x1 0x0d
  write 0xe000002a 0x1 0x01
  write 0xe000002a 0x1 0x02
  EOF
  hw/sd/sd.c:1984:15: runtime error: index 256 out of bounds for type 'uint8_t [64]'
  #0 sd_read_byte hw/sd/sd.c:1984:15
  #1 sdbus_read_data hw/sd/core.c:157:23
  #2 sdhci_read_block_from_card hw/sd/sdhci.c:423:9
  #3 sdhci_blkgap_write hw/sd/sdhci.c:1074:13
  #4 sdhci_write hw/sd/sdhci.c:1195:13
  #5 memory_region_write_accessor softmmu/memory.c:492:5
  #6 access_with_adjusted_size softmmu/memory.c:554:18
  #7 memory_region_dispatch_write softmmu/memory.c
  #8 flatview_write_continue softmmu/physmem.c:2778:23
  #9 flatview_write softmmu/physmem.c:2818:14
  #10 address_space_write softmmu/physmem.c:2910:18
  SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior hw/sd/sd.c:1984:15

Reported-by: Alexander Bulekov <alxndr@bu.edu>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/487
Buglink: https://bugs.chromium.org/p/oss-fuzz/issues/detail?id=36240
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sd.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 807b5d3de3..16d8d52a78 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1826,6 +1826,12 @@ send_response:
         break;
 
     case sd_r0:
+        /*
+         * Invalid state transition, reset implementation
+         * fields to avoid OOB abuse.
+         */
+        sd->data_start = 0;
+        sd->data_offset = 0;
     case sd_illegal:
         rsplen = 0;
         break;
-- 
2.41.0


