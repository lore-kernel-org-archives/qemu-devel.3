Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87EE6D11198
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 00:22:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7kp0-0007He-Al; Sun, 03 Nov 2024 19:19:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1t7kox-0007Dc-Ow; Sun, 03 Nov 2024 19:19:51 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1t7kow-0002J8-7a; Sun, 03 Nov 2024 19:19:51 -0500
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-720e94d36c8so635865b3a.1; 
 Sun, 03 Nov 2024 16:19:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730679588; x=1731284388; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J6g3+OIAh+PgGQYF5KfEAWhRtddu1l04lD2/5ytpiIU=;
 b=eMpcGYm0rBWie635C9dNeBPIISQ7zLqdushKQeY31HpWl3ftDZhWHLREeiMm3Nf+0g
 lKVD3XQpCagaWVDMW/ln5Pzj8WrJxRP7R7b+lw2VGz2HoRzfNBiBq0K0nVPyOnH8Jq6h
 /qxza2OgWvtuY80UHiJzmDNsHd6z7g6sx3j/BJv52kwGn4KddXs4ql/c66k+5zCNG+9r
 baR46Bp2b/BlWTo3fi99SAcxnLloKC9lLNVPbV+ngExgot03Y3QC0ZWobsyMhT9jrpX8
 9cy/38UZ3Q0BKBDMaFXsKi2PBZAv8SbDvVqd1krom2ulp2p9Ye9Po+huMCB52zhqInKP
 P4zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730679588; x=1731284388;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J6g3+OIAh+PgGQYF5KfEAWhRtddu1l04lD2/5ytpiIU=;
 b=lLiZ1r6Dhn/a7tVzwmv1mmjhMEXPzQIqt8lwoRQeS1h4M/R2eBSQHm2rrn2zV4em25
 DgD+LOaAWQqsGPYJ1/R8duvU+YEeDWTH2dHIZTgOUEbdHeE5m1Ze5ErHxj4gdu75FoCA
 Apvnrz/jRZBGNRhx+hpqPRz6FYsKT4jv0wRKyu4xLgERXyrspGu/Hag+mEE6h2Ivtn4L
 pBN0CMMnsqTwS8/yy7GiiCpBizZiCAgeiapxFirU9m81w2Txj7DOTIQ/uL+uLXECclb1
 FI5yHDuEFqZmUv5nTcfQdGVsVcmawgyVh5kmjp3V7T8/A/Nfec36VVUDGJf2PpGNg1c1
 oBWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUFSp89Fbtjy7jdM4V+OnBHzDn7ninO6ygfpVlwR+6gwIVGG+nKJeQ6A5K9MJDjoUQCREDZGOYjgA==@nongnu.org,
 AJvYcCV9nxLJmcdwKrJnpbPvOzZCQ6DXYYbzVQMgduaa1mR850n9RQ4hsQQQjJRlZ5/whGcK4niQKUgOcUo/EYg=@nongnu.org
X-Gm-Message-State: AOJu0YyNxPJf8jHKWCsWfgkhsdW1h0DG+S4OHMlW++7zAVKUuD4oOh7L
 CMqL9UNOGfNU38NsOJotWaQpsIFwbgPpcMUR8H2Q+REk9rxZtMpbui2Wqw==
X-Google-Smtp-Source: AGHT+IEW4g0BjDK8+LUYHDNNgIMaUw8Y2VXNoJ507p2NlP9/6oCFG05PviGm/g1OFFMgy+ZTJj3kPg==
X-Received: by 2002:a05:6a21:3296:b0:1db:d736:9429 with SMTP id
 adf61e73a8af0-1dbd736943amr3793070637.4.1730679587721; 
 Sun, 03 Nov 2024 16:19:47 -0800 (PST)
Received: from wheely.local0.net (124-171-217-17.tpgi.com.au. [124.171.217.17])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7ee45a0081esm5900648a12.59.2024.11.03.16.19.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Nov 2024 16:19:47 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 qemu-stable@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 10/67] ppc/pnv: ADU fix possible buffer overrun with invalid
 size
Date: Mon,  4 Nov 2024 10:17:59 +1000
Message-ID: <20241104001900.682660-11-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241104001900.682660-1-npiggin@gmail.com>
References: <20241104001900.682660-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x435.google.com
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

The ADU LPC transfer-size field is 7 bits, but the supported sizes for
LPC access via ADU appear to be 1, 2, 4, 8. The data buffer could
overrun if firmware set an invalid size field, so add checks to reject
them with a message.

Cc: qemu-stable@nongnu.org
Reported-by: Cédric Le Goater <clg@redhat.com>
Resolves: Coverity CID 1558830
Fixes: 24bd283bccb33 ("ppc/pnv: Implement ADU access to LPC space")
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/pnv_adu.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/hw/ppc/pnv_adu.c b/hw/ppc/pnv_adu.c
index 81b7d6e526..f636dedf79 100644
--- a/hw/ppc/pnv_adu.c
+++ b/hw/ppc/pnv_adu.c
@@ -116,6 +116,12 @@ static void pnv_adu_xscom_write(void *opaque, hwaddr addr, uint64_t val,
             uint32_t lpc_size = lpc_cmd_size(adu);
             uint64_t data = 0;
 
+            if (!is_power_of_2(lpc_size) || lpc_size > sizeof(data)) {
+                qemu_log_mask(LOG_GUEST_ERROR, "ADU: Unsupported LPC access "
+                                               "size:%" PRId32 "\n", lpc_size);
+                break;
+            }
+
             pnv_lpc_opb_read(adu->lpc, lpc_addr, (void *)&data, lpc_size);
 
             /*
@@ -135,6 +141,12 @@ static void pnv_adu_xscom_write(void *opaque, hwaddr addr, uint64_t val,
             uint32_t lpc_size = lpc_cmd_size(adu);
             uint64_t data;
 
+            if (!is_power_of_2(lpc_size) || lpc_size > sizeof(data)) {
+                qemu_log_mask(LOG_GUEST_ERROR, "ADU: Unsupported LPC access "
+                                               "size:%" PRId32 "\n", lpc_size);
+                break;
+            }
+
             data = cpu_to_be64(val) >> ((lpc_addr & 7) * 8); /* See above */
             pnv_lpc_opb_write(adu->lpc, lpc_addr, (void *)&data, lpc_size);
         }
-- 
2.45.2


