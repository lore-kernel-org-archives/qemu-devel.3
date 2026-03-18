Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8278107760E
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 19:45:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2woe-0005xB-3o; Wed, 18 Mar 2026 15:44:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qguanni@gmail.com>) id 1w2wgg-00042J-8b
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 15:36:14 -0400
Received: from mail-qt1-x829.google.com ([2607:f8b0:4864:20::829])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <qguanni@gmail.com>) id 1w2wge-0003KL-Oo
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 15:36:13 -0400
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-506251815a3so1689651cf.0
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2026 12:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773862571; x=1774467371; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=kxHv2vQshSzX2nvcK9cDy+jlEkeqRKn5NZJXLQavEwc=;
 b=lRTxrQXDeqs+Mgw23xH/JdDIzQx6BBosSus7x+Ub4hpywW23w9QUxftUJ7sjr8wdTW
 RWkrXvE0sjaLG/AgzoCbk1lznX6CcvVmxRfvQyl8dXlvfYNAIipfF/GaTR5Xb9nbAREE
 o5xKGTO07C/Qk/donpB9EgOZyEZCz/aHYO8N0tH9yo+gI+gpcX4UZjAkNMWW4Efdq93e
 xPlAUZnQJuOPyD0d2qrbyx/caN+FsS/stZAXtaWaGxKLcI6+NEWFanLOLpbuRiXFICej
 +PokFjI9BHmSw96TxadMA4TtPjKBx5YP7XGW5nsEaLDwu3xwMKP4nnnaoP6J+gnp7ozg
 JUww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773862571; x=1774467371;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kxHv2vQshSzX2nvcK9cDy+jlEkeqRKn5NZJXLQavEwc=;
 b=cKCTX6CunYcg69m95eJk+RIQKkO5uNxC1dulPCwWFFVtzemqbV7uehyLnkNJ/976Lb
 EwrnAiTnUwjiU5Tl8Ut2FiD7NbtokEvLpDSj2qwjnnrA6NRUdHAXyyu3u65lVZ/fyH2b
 4CAexmTQXY0dMlaizwr5MtASiEQzn3a8S1ow1ZsOTOAkBSOdqgH3sejAs8VhiW4c7LSH
 XZD6/JM+T2mYvkbaxFeLjb09mdGSTfSl8DfMDwcQwjS2KBK3YHZ057EtmIKPoXcPs1KD
 gLLKDjGl5QtaCdffhd+amqRmGQDuwX1vc4LEwMpQIBh8vqrucOoorIqJUg8yuB2ayuhC
 0saQ==
X-Gm-Message-State: AOJu0YwpqKz8+2cjUOp2/I4CqhZJdM+xMrWmfT1vN4Mb1YdL840CfLwp
 5qQutYjXVWIIRyThDGYX0LBFLJJdIYxGA/0nu3YoqjCmH9sm6YhZuq0V9awpcrONoaU=
X-Gm-Gg: ATEYQzzS7OVpWkKj8lMqNAgbaWTcPOhkTtj7DvdI40ZZctZVwZkkYjX4io181eSchS8
 S9nFwaykK4HsEd7qkGcOh/iml8T5mLhgwgcfwBb6oAswFBS0q1QJEnJfBy14Ed061sSsptPU1aS
 fs6D70qMeHcWk5I8qsR5qsRfRNUsXAgjmMG8TacF1raOGpCZbzSFvPa1Ob1MMh1zxRNpPJWXBIa
 Y5HmhCtCzVPhn9bPb+53DSDk1ti+RSNLVuFBvvr2nZwdFoR3UyJ+zGImjUd9PfzbuGWrIUx6+hs
 isBNJpLWWmoaYSURX0VYMC+QdIV+gs/vXHfGdoNKyraRE9rpCAYK3hlLeC2jzwcHtyU2vXWiNVm
 bozrk6luICJocPfkrR2iDnzlSpckpdDECGWb4JZ6CI/G0cj7ljBZgs4QLRMRJryDjWq3ffb/HVJ
 scKh3K4+aVTXaE8oF5L+Nuip8l6eepMPaveg==
X-Received: by 2002:a05:622a:1301:b0:509:14f6:9855 with SMTP id
 d75a77b69052e-50b14916975mr55932141cf.42.1773862571100; 
 Wed, 18 Mar 2026 12:36:11 -0700 (PDT)
Received: from 192-222-50-213.ll.local ([192.222.50.213])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50b135d6194sm29327321cf.28.2026.03.18.12.36.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2026 12:36:10 -0700 (PDT)
From: Jenny Guanni Qu <qguanni@gmail.com>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, mcascell@redhat.com, peter.maydell@linaro.org,
 qemu-security@nongnu.org, Jenny Guanni Qu <qguanni@gmail.com>
Subject: [PATCH] hw/usb/hcd-ohci: check for MPS=0 to avoid infinite loop
Date: Wed, 18 Mar 2026 19:36:10 +0000
Message-Id: <20260318193610.2043847-1-qguanni@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::829;
 envelope-from=qguanni@gmail.com; helo=mail-qt1-x829.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 18 Mar 2026 15:44:26 -0400
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

When a guest sets MaxPacketSize to 0 in an OHCI Endpoint Descriptor,
ohci_service_td() transfers 0 bytes per iteration. The Transfer
Descriptor never completes because CBP never advances toward BE,
causing ohci_service_ed_list() to loop indefinitely and hang QEMU.

Add a check for MPS==0 after extracting the field from ED flags.
If MPS is zero, call ohci_die() to reset the controller and return
an error, preventing the infinite loop.

Fixes: CVE-2026-3890
Reported-by: Jenny Guanni Qu <qguanni@gmail.com>
Signed-off-by: Jenny Guanni Qu <qguanni@gmail.com>
---
 hw/usb/hcd-ohci.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/usb/hcd-ohci.c b/hw/usb/hcd-ohci.c
index 1aeed9286f..b93a99593e 100644
--- a/hw/usb/hcd-ohci.c
+++ b/hw/usb/hcd-ohci.c
@@ -956,6 +956,10 @@ static int ohci_service_td(OHCIState *ohci, struct ohci_ed *ed)
         if (len && dir != OHCI_TD_DIR_IN) {
             /* The endpoint may not allow us to transfer it all now */
             pktlen = (ed->flags & OHCI_ED_MPS_MASK) >> OHCI_ED_MPS_SHIFT;
+            if (pktlen == 0) {
+                ohci_die(ohci);
+                return 1;
+            }
             if (pktlen > len) {
                 pktlen = len;
             }
-- 
2.34.1


