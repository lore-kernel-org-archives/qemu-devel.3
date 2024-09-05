Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDEF2CD5BC4
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 13:03:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smC71-0001KV-Tx; Thu, 05 Sep 2024 09:01:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1smC6v-00010k-R7
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 09:01:17 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1smC6s-0001kU-7e
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 09:01:17 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-42bbdf7f860so6198025e9.3
 for <qemu-devel@nongnu.org>; Thu, 05 Sep 2024 06:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725541272; x=1726146072; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Vp6jqJWQJM20UmlkjdFnqB0qa1tAd5oRc0QPjbGe4sk=;
 b=bC14IM1xtgss8rbVyCknxyQtHv/ns0JpGtO3sm7gT5rnWH+gjfhCDtRpVsruZkYn15
 mEjxNMnjc80+iaK1pwJXcedStcIGusU0UFV8aP31KKOfq25rrZGMi9NtevCRFn+USQ3l
 fltNyqOUtbH1YYIIy9jJy5qOsLPpX1aDBh5/u/TvN7JaPFviz4KmMmtQgPdwHyLfP/jR
 Bl2jFYIIgHu0VPduWalka5BzPsDA+MBf0eyJN3cNmcX40DJgqf+6eYDbpLbanfirk3z9
 a9YkkUbXJiHJeOtAjqkd2ZTUp5NbwjHMMsWeJjMLggqPRDp1zcganSKFVRQkpM0hdTQ0
 4pLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725541272; x=1726146072;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Vp6jqJWQJM20UmlkjdFnqB0qa1tAd5oRc0QPjbGe4sk=;
 b=GicmiCdwfs+YR3YLjpb2M4zJP1+2Hnp0NwavqEojidZL9w95C2cv0s68XUyJE+salB
 3QRSGFwUvnpP1tFhxHYElzHvItbSu0ziwrTDAQlmi0QurztlBzARPqbib477dBcRthxI
 /0izOpBeIBEJ6ASZH9kGewgh2b92EHuu5T7cGM6Klpv26LDX/WaxdOM9DyIKI/wdpgQW
 lbdp6cQUT0NWw56qx9QrnFyKAfAKENAITonBZlryok+cu9uF6MZzB4iRNLmeLM4jS5wI
 L7yjVp3Eq4/gcZc6VXPuZHK/HrsvQVPuDErcNdQf1LtTDIvdwzTWFcDd7C6R1Wv0ugdM
 6t+Q==
X-Gm-Message-State: AOJu0Yzd3Y8v+tkL2+U6Qdy4sC3rwvrLjq1xt1U46LsiOLb7jSDLWl5b
 KYQBEUqmVNujBwXd7TSR8uG2W+jkUCi3GzxzQYfvgcBR4u16IGSQg0OaQ+JMrEWr+ZVXobyLPd+
 1
X-Google-Smtp-Source: AGHT+IE1BejZOEQ7nuUIRc09DkQ9Z6FxKrluUHdn227Q+M23daOPJvIJHHne+mQHhhDVLsyMe91oaA==
X-Received: by 2002:a05:600c:1389:b0:426:6326:4cec with SMTP id
 5b1f17b1804b1-42bb01e6befmr169492095e9.29.1725541272463; 
 Thu, 05 Sep 2024 06:01:12 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bb6e355dfsm232251365e9.46.2024.09.05.06.01.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Sep 2024 06:01:12 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 14/25] hw/misc/xlnx-versal-cfu: destroy fifo in finalize
Date: Thu,  5 Sep 2024 14:00:49 +0100
Message-Id: <20240905130100.298768-15-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240905130100.298768-1-peter.maydell@linaro.org>
References: <20240905130100.298768-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Since the TYPE_XNLX_VERSAL_CFU_FDRO device creates a FIFO in its
instance_init method, we must destroy the FIFO in instance_finalize
to avoid a memory leak for the QOM introspection
"instantiate-examine-finalize" cycle:

Direct leak of 8192 byte(s) in 1 object(s) allocated from:
    #0 0x55ec89eae7ee in malloc (/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/asan/qemu-system-aarch64+0x294d7ee) (BuildId: 6d508874816cc47d17c8dd775e8f809ae520e8cb)
    #1 0x7f697018f738 in g_malloc debian/build/deb/../../../glib/gmem.c:128:13
    #2 0x55ec8d98d98d in fifo8_create util/fifo8.c:27:18
    #3 0x55ec8aa2a624 in fifo32_create /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/include/qemu/fifo32.h:35:5
    #4 0x55ec8aa2a33c in cfu_fdro_init hw/misc/xlnx-versal-cfu.c:397:5
    #5 0x55ec8ce75da1 in object_init_with_type qom/object.c:420:9
    #6 0x55ec8ce5d07b in object_initialize_with_type qom/object.c:562:5
    #7 0x55ec8ce5e91d in object_new_with_type qom/object.c:782:5
    #8 0x55ec8ce5e9f1 in object_new qom/object.c:797:12
    #9 0x55ec8d65c81d in qmp_device_list_properties qom/qom-qmp-cmds.c:144:11

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 20240822162127.705879-2-peter.maydell@linaro.org
---
 hw/misc/xlnx-versal-cfu.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/misc/xlnx-versal-cfu.c b/hw/misc/xlnx-versal-cfu.c
index 6bb82e51c15..2284b407eab 100644
--- a/hw/misc/xlnx-versal-cfu.c
+++ b/hw/misc/xlnx-versal-cfu.c
@@ -397,6 +397,13 @@ static void cfu_fdro_init(Object *obj)
     fifo32_create(&s->fdro_data, 8 * KiB / sizeof(uint32_t));
 }
 
+static void cfu_fdro_finalize(Object *obj)
+{
+    XlnxVersalCFUFDRO *s = XLNX_VERSAL_CFU_FDRO(obj);
+
+    fifo32_destroy(&s->fdro_data);
+}
+
 static void cfu_fdro_reset_enter(Object *obj, ResetType type)
 {
     XlnxVersalCFUFDRO *s = XLNX_VERSAL_CFU_FDRO(obj);
@@ -539,6 +546,7 @@ static const TypeInfo cfu_fdro_info = {
     .instance_size = sizeof(XlnxVersalCFUFDRO),
     .class_init    = cfu_fdro_class_init,
     .instance_init = cfu_fdro_init,
+    .instance_finalize = cfu_fdro_finalize,
     .interfaces = (InterfaceInfo[]) {
         { TYPE_XLNX_CFI_IF },
         { }
-- 
2.34.1


