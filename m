Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED1DEC3600C
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Mar 2025 12:58:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzEhz-0006BW-D8; Mon, 31 Mar 2025 08:57:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tzEhx-0006BG-Lr
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 08:57:41 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tzEhv-00016t-79
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 08:57:40 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-225477548e1so78701055ad.0
 for <qemu-devel@nongnu.org>; Mon, 31 Mar 2025 05:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743425858; x=1744030658; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V7VglsTdvAJ0yyYfaKfMQi2cxaNHZX7+PMSNo4t/v9o=;
 b=fwMjUCvoDtXw2UD1seT3C2Mq5kB6ve3ODvWucWn7L4ubdJCVfpUfWIP/9w3oPPWSja
 JpRJUihzTqdxS0gf5aXNWCKfnMiYvMQd9AJruJ+g9RZTKUEj9wrgdM6h0Qp8HyMJJut7
 D8Uq3oqbt+yFiSxqkObPf2hbWDRfjmrxJp5S6bqz0uI20n2Yf6uqqRuNHvYjxhtqIZj1
 hp2PfIXymMgKBKf8QYYcnCdHn9pA0HTGYdZEZQhq2lRBeKhO/4GqoVyg6fdX2fgZ3x6Z
 pDgr+twU2z5RVjpviTxuCmW9O/TaD/QWtLKFtHqj4QW9M++qsVPstFcg5iq1709nzJXr
 jK0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743425858; x=1744030658;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V7VglsTdvAJ0yyYfaKfMQi2cxaNHZX7+PMSNo4t/v9o=;
 b=pZ6BFJixsma5iEtx8h0z8t+BvL1CaFmO3wepUD/fciZ27iDSm6cy/7TDq0ObCghRzI
 1yJBfdrG2/o+NY9UfetV01/S8iPfdISDgXg1OUlfDTdRj1ztm1mABHqIZoMRtr0hDiLI
 sLefx/9DsrMV2NJy5sZ86G9B1yZ/zaSWP3HBhxEGH4TIbA3kgIuEIW8hjz7/OH5JF1ll
 PgZHQWx7vnhF3nfJxGxE9bluIFM8cyElqWPJDJEIH+6yzFDkGJ4BB+aSo9vvTWaVyIvg
 VqAV3vdep3j6cyzhxs1NCyZ2sUTi/WoXOV/GyD3shZNQsd2MMUtFLE6Gcmd8CUESybFu
 fV+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4mzaWvf7KP83IJAaIrmmS7/XJX6m7OxOZp+6cnGio5lG2fs7VCpnOiaT6gqwJkWEZJhMcUBTu7xkP@nongnu.org
X-Gm-Message-State: AOJu0YwaCAclcoPYDEKdlqWMQbkW8MS9jMPERdKWDgVo78nvJyabuVvO
 DHJHBlKn5TWikMrrKv5sX6NloQd/+woYxPqcCA0fnBS28u3+0F1Tbf8Cgw==
X-Gm-Gg: ASbGncuDLcJYgCraSeO3gvdeHl2zPIBD7mc0Q0NqWTDl338+j5gmOWbSfwsWjg5J0Gm
 Zj6Ybi38nG9sHdPF/ghDmFu5V6tDbWWxmMfyi3vYhZUDW+GU5TiK6Zk8IgTHM5w/MoCACvKTJQ9
 olBkt0d5dhf5213LjrscHtX4kRfIvNDdq1S+03tXJt8s8TVzelH3EcrVWEQ4moC6ihpV1bmEgJn
 14vq4idT0pvhpmrquhTFcGYiaP0/TN4dzBWP1f3eAnn3RFYntRDmSFLjQ4gFk0eTJsaGyYT/GSQ
 bF+U3hdP85k1Ed22XWWen2U+kB0o27aP6/n2wKTcfblbbhBd/YMxU3XrQHSa
X-Google-Smtp-Source: AGHT+IGEFejaOzxyFlVlo8ntpv7G36C8f+7Cf7n9V3rlDlcfWl6fnau4ywGiqOTdJ4qin/eQ90jvnA==
X-Received: by 2002:a05:6a20:43a3:b0:1fd:f8dc:7c0e with SMTP id
 adf61e73a8af0-2009f5f725dmr14638115637.12.1743425857878; 
 Mon, 31 Mar 2025 05:57:37 -0700 (PDT)
Received: from wheely.local0.net ([203.185.207.94])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af93b67dc0fsm6324016a12.16.2025.03.31.05.57.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Mar 2025 05:57:37 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Corey Minyard <minyard@acm.org>
Cc: Nicholas Piggin <npiggin@gmail.com>,
	qemu-devel@nongnu.org
Subject: [PATCH 2/3] ipmi/bmc-sim: add error handling for 'Set BMC Global
 Enables' command
Date: Mon, 31 Mar 2025 22:57:23 +1000
Message-ID: <20250331125724.607355-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250331125724.607355-1-npiggin@gmail.com>
References: <20250331125724.607355-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Mask out unsupported bits and return failure if attempting to set
any. This is not required by the IPMI spec, but it does require that
system software not change bits it isn't aware of.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ipmi/ipmi_bmc_sim.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/hw/ipmi/ipmi_bmc_sim.c b/hw/ipmi/ipmi_bmc_sim.c
index 32161044c0b..8c3313aa65f 100644
--- a/hw/ipmi/ipmi_bmc_sim.c
+++ b/hw/ipmi/ipmi_bmc_sim.c
@@ -234,6 +234,7 @@ struct IPMIBmcSim {
 #define IPMI_BMC_MSG_FLAG_RCV_MSG_QUEUE_SET(s) \
     (IPMI_BMC_MSG_FLAG_RCV_MSG_QUEUE & (s)->msg_flags)
 
+#define IPMI_BMC_GLOBAL_ENABLES_SUPPORTED 0x0f
 #define IPMI_BMC_RCV_MSG_QUEUE_INT_BIT    0
 #define IPMI_BMC_EVBUF_FULL_INT_BIT       1
 #define IPMI_BMC_EVENT_MSG_BUF_BIT        2
@@ -930,7 +931,14 @@ static void set_bmc_global_enables(IPMIBmcSim *ibs,
                                    uint8_t *cmd, unsigned int cmd_len,
                                    RspBuffer *rsp)
 {
-    set_global_enables(ibs, cmd[2]);
+    uint8_t val = cmd[2];
+
+    if (val & ~IPMI_BMC_GLOBAL_ENABLES_SUPPORTED) {
+        rsp_buffer_set_error(rsp, IPMI_CC_INVALID_DATA_FIELD);
+        return;
+    }
+
+    set_global_enables(ibs, val);
 }
 
 static void get_bmc_global_enables(IPMIBmcSim *ibs,
-- 
2.47.1


