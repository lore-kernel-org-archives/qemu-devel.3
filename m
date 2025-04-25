Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 861E1C369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 15:33:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8L1U-0004A0-PG; Fri, 25 Apr 2025 11:31:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8L1Q-0003rJ-4i
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 11:31:24 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8L1N-00042k-64
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 11:31:23 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43d0359b1fcso16277485e9.0
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 08:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745595079; x=1746199879; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=evCA5o+nULViIB5nSb9ef+sL0PEj4rUWEyxr5FIT2+w=;
 b=QmHmr4qR92ivuTbVyOrLLLL4luw94TbistGxtiqQuTP2HkhDJD8/ppDGa/08URhjn2
 LsIOhSYvCjDnusAoNlWX2tleKy9jsj/udpolqE4DMHw8W6fiuLNCS6pjZulVH7ui3jKe
 QoIQw5Q1RiJT+8XpdAo1EJpPDqqVo07kZ0mcKDPDYvsVatspSU9crq8zDi9uMzH5dAxG
 L0z8ckE5drBGoj7Qtv7WORHZUJPxeI7zZTrxBGtXa/HSc+y1v7uZsF+xQZcIv0mhXsIa
 O2SnEBR9eNRgZOGXrr16yBRRJKCKz/JiDLUakOdL1vBduspVuMy0UiCyF6Aacw2+MdH9
 tJtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745595079; x=1746199879;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=evCA5o+nULViIB5nSb9ef+sL0PEj4rUWEyxr5FIT2+w=;
 b=RTgcNP3Lrh/qseNL28Pbc5LlbwAnAB7GkW3a4Ew//JOBRk8/bXF5vOzAJAlj6hMXxS
 ALZjVmtqx8udOmX+0dV0NzHWGsE+bbOi4/I1tGKCd9Wiqbg62HiOCw1qVIDhi+G4Lorn
 flHzmczeBythpNtS3+9IXhKrWzMsGA5qBHCcLaOMxHtQAUPqzsAYt47d+vC1hIKCO041
 6YH3wMryrZZCO8thfYvcHPmurY00UD1cgui4ISnqquXPzPvKKw7JT/xDB8bpxLc65ei7
 mGVACjj6bpwHhHtuIk11mO5yxD8PTMSHUVW0Nq84YKVzkH2w+TV2odV6TrrljK89VkxE
 XdIg==
X-Gm-Message-State: AOJu0YxpF/95GN4PgDQ+AqISM5Rp2N3vUQTKiop7eNZMT4SEzAVPUHFR
 qsu8EQl77jiTT1LRx+mSZkCQJ2PRAl2sbSVThghN2AuRxnxDNt2wi1ari9YqnPYn7czqYOYiMnw
 u
X-Gm-Gg: ASbGncumVDbbCUyo44PupGn678mUYVzs7gKe7CjC7oijRAu7LxcDx+9i13++JAjLrEl
 2I+sUNnuj3a61+ax9eu+AdONIpq5G0jgxs7xWCuT1r7E5IVgIrFNBaRPcf7Iq4t6/WnfNVdJM06
 xc9owDERn6syNYr8GGXMOHE/kUmlFyfneixLg+heqaa3Du5HNlGS71PJnWWGPv8Nv7lMNMjkUmo
 bDt68hDtEQuPjh52KACkz6MviklF/IgRUbN4Ra94h7ZODXoB8TtojHJ9cXfPIVsrbmeWcplfGSN
 BZs2Gkr7dl340BkN6TIaBs03p460t0KnV0F56pPyNgU52ufjRIm77dkEdF0A2UvFfHJ9U02+iSj
 3ZbUDbI6LcY2/Lmc=
X-Google-Smtp-Source: AGHT+IH1Eh82p4xKXiBrWtJ3aOfMMIv42P7gYPblRZxnHhEtiMdmb3n2lPxM29ni5I6RXJIqKKRIkg==
X-Received: by 2002:a05:600c:4f52:b0:43b:c857:e9d7 with SMTP id
 5b1f17b1804b1-440a65cf326mr23064355e9.5.1745595078955; 
 Fri, 25 Apr 2025 08:31:18 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073e5e345sm2669744f8f.94.2025.04.25.08.31.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 25 Apr 2025 08:31:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Kohei Tokunaga <ktokunaga.mail@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Francisco Iglesias <francisco.iglesias@amd.com>
Subject: [PULL 31/58] hw/net/can: Fix type conflict of GLib function pointers
Date: Fri, 25 Apr 2025 17:28:15 +0200
Message-ID: <20250425152843.69638-32-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250425152843.69638-1-philmd@linaro.org>
References: <20250425152843.69638-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

From: Kohei Tokunaga <ktokunaga.mail@gmail.com>

On Emscripten, function pointer casts can result in runtime failures due to
strict function signature checks. This affects the use of g_list_sort and
g_slist_sort, which internally perform function pointer casts that are not
supported by Emscripten. To avoid these issues, g_list_sort_with_data and
g_slist_sort_with_data should be used instead, as they do not rely on
function pointer casting.

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Francisco Iglesias <francisco.iglesias@amd.com>
Message-ID: <4d47a75c5768c9a6dc5d8b3504e78837577ad70d.1745295397.git.ktokunaga.mail@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/net/can/xlnx-versal-canfd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/net/can/xlnx-versal-canfd.c b/hw/net/can/xlnx-versal-canfd.c
index 79ccc10098a..3eb111949f8 100644
--- a/hw/net/can/xlnx-versal-canfd.c
+++ b/hw/net/can/xlnx-versal-canfd.c
@@ -1278,7 +1278,7 @@ static void tx_fifo_stamp(XlnxVersalCANFDState *s, uint32_t tb0_regid)
     }
 }
 
-static gint g_cmp_ids(gconstpointer data1, gconstpointer data2)
+static gint g_cmp_ids(gconstpointer data1, gconstpointer data2, gpointer d)
 {
     tx_ready_reg_info *tx_reg_1 = (tx_ready_reg_info *) data1;
     tx_ready_reg_info *tx_reg_2 = (tx_ready_reg_info *) data2;
@@ -1316,7 +1316,7 @@ static GSList *prepare_tx_data(XlnxVersalCANFDState *s)
             temp->can_id = s->regs[reg_num];
             temp->reg_num = reg_num;
             list = g_slist_prepend(list, temp);
-            list = g_slist_sort(list, g_cmp_ids);
+            list = g_slist_sort_with_data(list, g_cmp_ids, NULL);
         }
 
         reg_ready >>= 1;
-- 
2.47.1


