Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD2EEC7115B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Jun 2025 16:17:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSHwQ-0001eX-Us; Thu, 19 Jun 2025 12:16:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uSHvm-0001MN-Qf
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 12:16:06 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uSHvj-0003gL-Qw
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 12:16:02 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-7424ccbef4eso673483b3a.2
 for <qemu-devel@nongnu.org>; Thu, 19 Jun 2025 09:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750349756; x=1750954556; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xngZvcERBrHIiDDbzOPfea5jz0IsdaSOpmqYDGzty7Y=;
 b=aFzKdVhlnD6ovo9UuZnkoWxFyQWdnJaMkast3a9s7GJIlsq9heHZp7rR+9pbY58sDG
 NVk/iKVqVRtq930FwwLoqDa66q7X/KeaR5h/Th/aXEMmlu2o49KO3VXMkPlot125XQBY
 RKUie1+EBXe2vcKf4Sc7qgX4auyrDaXFcN8cCF+Db7w+XNhu+1/VYlL2qI86iuI02aQT
 XdAfMpuwBpk04PaxgJAfHqtx32/dq+E4LDnd7RooQZHw5nUUbyNAL43wZfmC9g+JgZwJ
 CjkoP9J831DyC/+kgUMyldHozVicKnHJOpJ0JV7LC1feoP6CAS2Ek0hNpuYsnPjUPmpj
 Nq8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750349756; x=1750954556;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xngZvcERBrHIiDDbzOPfea5jz0IsdaSOpmqYDGzty7Y=;
 b=O3j0LziwrgJk+682bkZR+wKXKK7Lfnqu/bIHN7j/VESQOGH9OvupqEIQaKOLH3mr2f
 G7BclNVdEO65MnaYoM2It6cyIy/aQLrviIc2O1gexouST1ZkS8dTZkNv2ze6IBiKlSUm
 /b8XXzxcq9waDCBrAbGQ/X34WLtWS09WfnQp1o9C644zAUmp3Dbz85wVC6WWwRnOp8KZ
 31umzp3tjpegb4oCn6dfCgflUIKEevevlSQc8PZhAjGZkMlZHop3v+Q3zKsFK2gMFe3p
 9/PmbWEPB8GJifhOCIT3E1UhLIsQSGwQ97JAizb4ryXXVNbTA1/1Xbg3h1JStTbB2rI0
 XIOQ==
X-Gm-Message-State: AOJu0Yxrf2LzIcG+wrLpRikRM7cI32MZKnxDIfZ+TmVOCRIirDbY/ph4
 u0Bkx0zsR1OpxT4EnhPnHA88QvKS8F53xY7ncYI51geVMLTWez+WP+6+ZKwvpv8c
X-Gm-Gg: ASbGncu7AxDTWRjIq7zkxzuG71Td69SoKEqMmM2knLAK8lBtigbMNpPSdM6vlo4oWVm
 r1ZhxDCp5HBdaaXE9Oe2/FbtLN/RwpCta52OA9Y7JONxIH5SMJrZLhoR5CJWZULJ+yNlR/rv5Uo
 pfCrLIiT5srBXEQwBNmmSNA04JYanLL99CDWHNqyIaNLbIWZ5vc+r++fR4owXO9FWtVGvSGikyN
 66qp2BHuNCT+ikU5ffIihn/ZNLSk6h6QAuQe3QpnhojtceUE1B9CtBr7+t9zKZyctuwnnzh13Ij
 9ZYxM7gPE7pQPopkbWag/mlsQ2B3JNOI+liVUnEvvFBYS5Qb9/VYmI2RWDTT7w==
X-Google-Smtp-Source: AGHT+IG8+hlY84oCE1sa8zWJJWx11QQl8AoPiEUBIawwtUrN/S1oVAb1Kuq4AmXSTxjv1RNeo2k06w==
X-Received: by 2002:a05:6a20:d04c:b0:215:e818:9fda with SMTP id
 adf61e73a8af0-21fbd67f904mr32317653637.27.1750349756331; 
 Thu, 19 Jun 2025 09:15:56 -0700 (PDT)
Received: from shemhazi.lan ([50.46.174.34]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b2fe168a0f8sm13168683a12.53.2025.06.19.09.15.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Jun 2025 09:15:55 -0700 (PDT)
From: Rowan Hart <rowanbhart@gmail.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Eduardo Habkost <eduardo@habkost.net>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, novafacing <rowanbhart@gmail.com>
Subject: [PATCH v13 7/7] plugins: Update plugin version and add notes
Date: Thu, 19 Jun 2025 09:15:47 -0700
Message-ID: <20250619161547.1401448-8-rowanbhart@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250619161547.1401448-1-rowanbhart@gmail.com>
References: <20250619161547.1401448-1-rowanbhart@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=rowanbhart@gmail.com; helo=mail-pf1-x42c.google.com
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

From: novafacing <rowanbhart@gmail.com>

This patch updates the plugin version to gate new APIs and adds notes
describing what has been added.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Rowan Hart <rowanbhart@gmail.com>
---
 include/qemu/qemu-plugin.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
index 5eecdccc67..c450106af1 100644
--- a/include/qemu/qemu-plugin.h
+++ b/include/qemu/qemu-plugin.h
@@ -65,11 +65,18 @@ typedef uint64_t qemu_plugin_id_t;
  *
  * version 4:
  * - added qemu_plugin_read_memory_vaddr
+ *
+ * version 5:
+ * - added qemu_plugin_write_memory_vaddr
+ * - added qemu_plugin_read_memory_hwaddr
+ * - added qemu_plugin_write_memory_hwaddr
+ * - added qemu_plugin_write_register
+ * - added qemu_plugin_translate_vaddr
  */
 
 extern QEMU_PLUGIN_EXPORT int qemu_plugin_version;
 
-#define QEMU_PLUGIN_VERSION 4
+#define QEMU_PLUGIN_VERSION 5
 
 /**
  * struct qemu_info_t - system information for plugins
-- 
2.49.0


