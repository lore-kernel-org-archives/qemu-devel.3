Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3727C67861
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 18:05:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruFqA-0005iP-3V; Tue, 09 Apr 2024 14:05:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruFq6-0005hl-6E
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 14:04:58 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruFq4-0005wA-5q
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 14:04:57 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-516d47ce662so7695987e87.1
 for <qemu-devel@nongnu.org>; Tue, 09 Apr 2024 11:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712685894; x=1713290694; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mofGccF6GnSbU8wqyQY2g5b/RzOdIGB1JJbsnR3/SSw=;
 b=X4PjtjuLASm80beU2roPf67RqUiB+nbmqzhPyELY6puH7PeDgC6EMolVUtTPdWu0xB
 nkfRcwsIp/IGnLdRzEotH443sNtHuaD2nop6a+4aGy2XjhGd/jd/wUUN2Ir1zj0Gt+ra
 G7BW25AMeJYsXm7ioFQZpem2qTETZdm6lr/iSccx7RUTysFKEkZ8hyCOMD3oJ0/Ydhay
 o0V0TveiR9gK1DoMAZzlJ3Wqh1/3xgV+vMW7SZpY4L68SJjbI4fo8Z1x09j0lsLBBdhf
 K7PLLx2XkGYdt09IEw2dDAupn2xwtjw0lTL23Em5l31eAbJeIJjvMKgL7MHvPbDZLV9X
 IkRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712685894; x=1713290694;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mofGccF6GnSbU8wqyQY2g5b/RzOdIGB1JJbsnR3/SSw=;
 b=Ga+jHn2BI/mmL79rgKVkqS/WEAdJASfvFq77G/arWXa4ePNAN2JWld6UqqwBBbWjNr
 q3NkeIMU7BuCXg+4CcjW4+xibte0CSCOQexmCfIZyueFrGLHIhLbVk3Cplp2WCKg+ltF
 hjD1ZIDagfEBecqtYp60t+1e8pD8r2U1qsXlaJE44JGwUb2OnWh0eyCTxUQfiD7zSeO7
 NDu+haM0kFWsiEXOz89Tkn+AtEqXPtbk/Q8uLf00Vqps6DHjoOelgjeCcMXo3W/NWJa8
 qMWedkSUCV9EQpL8ysHK2j4eEoq3bOvZfVTXH6ezBxv8sTidmCW2eWn1ZyV6wkNMTObE
 lSbw==
X-Gm-Message-State: AOJu0YxR1DYyZPSrKKcAxjsELhWNRuPM0AhxI7pHy/xaNpwteI7VKM1A
 eq4OCaPeljG+GoEyzq/pKja1HyIvEkIWDkog3cBQvX5wTLifYU6OMVNmipxTzRJv1gGHeycpO5/
 C
X-Google-Smtp-Source: AGHT+IHnU5Kj/eWxgrIgFK0BwwgyeP0kDwOAB5HsDu0K8diRbeZoBUDCX7YFjQwgU+6cVBbW2EaGYg==
X-Received: by 2002:a05:6512:539:b0:516:cec0:1fb8 with SMTP id
 o25-20020a056512053900b00516cec01fb8mr134094lfc.65.1712685893647; 
 Tue, 09 Apr 2024 11:04:53 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.160.134])
 by smtp.gmail.com with ESMTPSA id
 k12-20020a17090646cc00b00a4e3fda23f5sm5888577ejs.165.2024.04.09.11.04.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 09 Apr 2024 11:04:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Jason Wang <jasowang@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zheyu Ma <zheyuma97@gmail.com>
Subject: [RFC PATCH-for-9.0?] hw/net/net_tx_pkt: Fix overrun in
 update_sctp_checksum()
Date: Tue,  9 Apr 2024 20:04:50 +0200
Message-ID: <20240409180450.31815-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x133.google.com
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

If a fragmented packet size is too short, do not try to
calculate its checksum.

Reproduced using:

  $ cat << EOF | qemu-system-i386 -display none -nodefaults \
                                  -machine q35,accel=qtest -m 32M \
                                  -device igb,netdev=net0 \
                                  -netdev user,id=net0 \
                                  -qtest stdio
  outl 0xcf8 0x80000810
  outl 0xcfc 0xe0000000
  outl 0xcf8 0x80000804
  outw 0xcfc 0x06
  write 0xe0000403 0x1 0x02
  writel 0xe0003808 0xffffffff
  write 0xe000381a 0x1 0x5b
  write 0xe000381b 0x1 0x00
  EOF
  Assertion failed: (offset == 0), function iov_from_buf_full, file util/iov.c, line 39.
  #1 0x5575e81e952a in iov_from_buf_full qemu/util/iov.c:39:5
  #2 0x5575e6500768 in net_tx_pkt_update_sctp_checksum qemu/hw/net/net_tx_pkt.c:144:9
  #3 0x5575e659f3e1 in igb_setup_tx_offloads qemu/hw/net/igb_core.c:478:11
  #4 0x5575e659f3e1 in igb_tx_pkt_send qemu/hw/net/igb_core.c:552:10
  #5 0x5575e659f3e1 in igb_process_tx_desc qemu/hw/net/igb_core.c:671:17
  #6 0x5575e659f3e1 in igb_start_xmit qemu/hw/net/igb_core.c:903:9
  #7 0x5575e659f3e1 in igb_set_tdt qemu/hw/net/igb_core.c:2812:5
  #8 0x5575e657d6a4 in igb_core_write qemu/hw/net/igb_core.c:4248:9

Reported-by: Zheyu Ma <zheyuma97@gmail.com>
Fixes: f199b13bc1 ("igb: Implement Tx SCTP CSO")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2273
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
No clue this makes sense, but avoids the crash...
---
 hw/net/net_tx_pkt.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/net/net_tx_pkt.c b/hw/net/net_tx_pkt.c
index 2134a18c4c..6a8640157f 100644
--- a/hw/net/net_tx_pkt.c
+++ b/hw/net/net_tx_pkt.c
@@ -141,6 +141,10 @@ bool net_tx_pkt_update_sctp_checksum(struct NetTxPkt *pkt)
     uint32_t csum = 0;
     struct iovec *pl_start_frag = pkt->vec + NET_TX_PKT_PL_START_FRAG;
 
+    if (iov_size(pl_start_frag, pkt->payload_frags) < sizeof(csum)) {
+        return false;
+    }
+
     if (iov_from_buf(pl_start_frag, pkt->payload_frags, 8, &csum, sizeof(csum)) < sizeof(csum)) {
         return false;
     }
-- 
2.41.0


