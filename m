Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48826C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 15:34:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjIeb-0000Dg-HH; Mon, 13 Jul 2026 11:33:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wjIeS-0008Uk-Nf
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 11:33:06 -0400
Received: from mail-wm2-x01.google.com ([2a00:1450:4864:31::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wjIeO-0001BZ-Ho
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 11:32:58 -0400
Received: by mail-wm2-x01.google.com with SMTP id
 5b1f17b1804b1-493b4af7976so26011555e9.1
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 08:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783956773; x=1784561573; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lKAMocpTV8X4I38gyaYAm08wo6o7waa7S4QxCfCs1Ls=;
 b=vVPc62G1YA80WIxZOGvNH/yUMOE/6EyELQgtQnYUMJZMeTs1DgMyy6hZ7CdQ1uSo9a
 vd9dToSjX2qFA8u95cuH7YGmgRkQ5zJ5V5cMRwInQaxK/Y0oxd2+8eImSCrD0AVvcrzs
 3rbvbjT6JZ019RDsAnH3V/Gu5Nb1L3hfYIa21ZimQBd8iq7tA6V8kBdbQxly0+9frRCP
 bkt8YtVN1OA8QV3Cmxf5K1JpSC+zl/wyblHJ/S7b08QLBLCodfXMUSyXmkZAkDbqZM3w
 hO1U0/c5grcpAM3V+yFrNUxPTt8rywgswoM0/6yvV3GJUWNMafQhLsRZRpOSQ06ExBd6
 vF4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783956773; x=1784561573;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lKAMocpTV8X4I38gyaYAm08wo6o7waa7S4QxCfCs1Ls=;
 b=IegaYu5bd3RIoZcb8jUkbDBMuX5vsygTwXet1bjVyqN25V3tkE1ofF6VvWQOPvWCPa
 mJ1z6b2TnDLTHM3fF6l1NWnhzV2dh6go3GWGGpOaxkwJfP6jPE3yMB43VSFFGan3LWVI
 F/TcqWHSNBbWMUiETHhi0NFiJh756E3/GiXTO9Y45tC+uWX6XiZOJBi4OPmZs4Vcoc8v
 JR/dj2YT4sKnsDEpCJ8yxIbn9hjbKzFeN0L0t406xJg0myCr6AMyAVLEKuHSjHu82UQj
 b7qa+eawlGAAbkzoTtkXlanPWErOrPOdMZXjQksOL7HiL4z2ehAqqHm5jN+oiL9gZ0NX
 A4sQ==
X-Gm-Message-State: AOJu0YzCHHsbyOkXk74VUv/okldOLmESTMJF+SMJPc5U0uOZ2UYw/RHL
 s3jIysBwIKaHA3a6hh0iw2s2wV07FNyxFJ6Iu52n1qGu8jgkDhvkHCut0DYEl/9suQlPGDxYXCe
 QiapOY3oLXyue
X-Gm-Gg: AfdE7ckAWIPL9Y0QwLZgNBRmm2RNEOVQKo3oy29gd8+xe9QcyCqjvvMyadBgsdqqblm
 /ufVS1f2SruPWSSRj8IbdY83EQs44cHhJqteKhv/6F0d7hfzLvDeYwraV/Daw3NKX6xW/QphEbp
 XCJVdL0V+77N3CgKKQA9Ud811c2dk+GyzNqKvtmSL1qXlRxUnpGrGVDxnbxOSjGW5evCrVkxVgD
 16BY0/fEB/mx48UtYrs4I4VpUVdtQu0nQcjpSb1kZgr8ICXdiRgd1+G/qY+S9rPIyHA6hb31YTF
 mCpQw94w3RImUC5aq+GF8GN7E5Gc8LFfm8p9jEB+VY4gbnOfKeofh6SiMXzoYYPAVpo+bPWPwsk
 zwaZHmEGYquV60UAfW6J0GaqC2QPVMEaDPDWO+Izg7yjFKoMb+Xf5zqfYcHfWGc2T4p4qCyJocS
 RA8CsVlj5OcxRcpTqTxbE34dK/vnQ9Cc69pLbpdj9BvWvRGpYGxZ7pVEiTuYxmKf4xtwYeh+YOZ
 9LTTJIbd+WSKULGUesIpw==
X-Received: by 2002:a05:600c:4ca4:b0:493:e974:41ac with SMTP id
 5b1f17b1804b1-493f87ebbf4mr60655775e9.16.1783956773374; 
 Mon, 13 Jul 2026 08:32:53 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49508727f7dsm3825985e9.4.2026.07.13.08.32.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 08:32:52 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 20/26] hw/net/vmxnet3: Correct bounds check on tx queue index
Date: Mon, 13 Jul 2026 16:32:27 +0100
Message-ID: <20260713153233.3391818-21-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260713153233.3391818-1-peter.maydell@linaro.org>
References: <20260713153233.3391818-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::1;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm2-x01.google.com
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

In vmxnet3_io_bar0_write(), we try to bounds-check the TX queue index
provided by the guest against the total number of queues.  However,
we have an off-by-one error: the valid indexes are from 0 to
txq_num-1, so we need a "<" comparison, not "<=".

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3780
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-id: 20260706175408.905362-1-peter.maydell@linaro.org
---
 hw/net/vmxnet3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/net/vmxnet3.c b/hw/net/vmxnet3.c
index 97156dd33b9..8569484b2f2 100644
--- a/hw/net/vmxnet3.c
+++ b/hw/net/vmxnet3.c
@@ -1079,7 +1079,7 @@ vmxnet3_io_bar0_write(void *opaque, hwaddr addr,
         int tx_queue_idx =
             VMW_MULTIREG_IDX_BY_ADDR(addr, VMXNET3_REG_TXPROD,
                                      VMXNET3_REG_ALIGN);
-        if (tx_queue_idx <= s->txq_num) {
+        if (tx_queue_idx < s->txq_num) {
             vmxnet3_process_tx_queue(s, tx_queue_idx);
         } else {
             qemu_log_mask(LOG_GUEST_ERROR, "vmxnet3: Illegal TX queue %d/%d\n",
-- 
2.43.0


