Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8535BE7716A
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2024 19:11:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMtwo-0001gg-2p; Sun, 15 Dec 2024 14:06:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMtwk-0001Z7-IV
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 14:06:30 -0500
Received: from mail-oa1-x31.google.com ([2001:4860:4864:20::31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMtwj-0001Gu-1E
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 14:06:30 -0500
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-29e149aff1dso1087415fac.1
 for <qemu-devel@nongnu.org>; Sun, 15 Dec 2024 11:06:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734289588; x=1734894388; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/0TsJRbwZmNAO2qYlCgVoT7st3PUvmUAIcZpMw0bU28=;
 b=UCLon6q2zO/vod7nM6lgj623P1D6/3tF0JVSyKQF66Upze2t7Tc1NGrlR4NC6hkUmV
 ByMz/C3SO2Ce7l2DqPcVVBo0nmO9n2Bv2SBSRHXMP+I2SI/Y/lTOgjc6y73UqkDoTSsE
 ZpIuvlkoNdAbel7CA0WU2uQqmQ3XGcJwH5oJWKVGE7yJrwm07fAvCSfhlcQOR8plcpxD
 Lvx5FyQa3liyOL8SFtqtLWYCPNbkM6y3QiarB2ZToJMM8vYAdfoviaYigv8yPWlfB0/Y
 xZW9AVbVv+/vj/T1HeDxiunCz6N2QHQ5VPQWwcY3tRPQJldbSBg3COSi8lHpJgAi6PIN
 +A8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734289588; x=1734894388;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/0TsJRbwZmNAO2qYlCgVoT7st3PUvmUAIcZpMw0bU28=;
 b=lfFBtbKWWzuNS/R2OzkQ9dIptgKe47o5721jOwgr/pKCvcPsgTN5Zl9WnEay/M8aqn
 uFnkrHRBvKOzuamASQHZcK4kSWlqQ2P7VPPaJ7VE/7ZCOITycX2VmA141q1+g155Oqr6
 xXCmButbYHYaspag4meConTqbQdNcHK0Fz84ZZAErO1TnxJIBJ85TYwn+jMrNBisWUYB
 FgK9x1fP4QRVGixCcNHWlxYzqb4Z/clv8hA20gNmJjzNthzDl51maK6Xmi03qWt/Qsi+
 4znaCLKsoIVmMH9ePBJDmh7DB81f12pyBKOXxrbsT/MbHYFcRg3t9bV3ldx36I2kZ6tm
 nUUg==
X-Gm-Message-State: AOJu0YzMscp3bQae6XgrIqQ5U5Y7D+NEJLWHqy1/UIVqJtP7L43e2c5F
 PT4uo35D0Pl9Cw8owj9BLQ1qm/Vwsr9UQlN0cpwpxVbzcB/kdqyskTCzf5JLqzMFjh16Ww2bXdW
 6ktXeVepM
X-Gm-Gg: ASbGnctXu3vWReokL4wz7QPzAeBmedp0kHgpL6wH+c5KM/JnJ+U1T7HA3O2fZ8bFm/+
 CRms216SQ6uZMDJmI9LQGdKBUmw7513ETNif7vvQgWtRdEuKLZq7jZTtzsAK6gTrdYW0x/oxxAZ
 OEtvyag1TttMr0q19++SuF1GzqITMzaCaDgn1mB8W+fe1lHV2qhvOaACVQcCUl6Nh/7uLMdbloo
 iKXKU1QbXoJuDo0lZ6e+Hl48Szx1FB9zfJgerRB1yF5s1ZzRVMxBazP+ktMv2KW+eAytukK/15m
 Tfg5lxhZtJdEEZDmHAKoAFQhtUBJq4eeBTLelZv/OaA=
X-Google-Smtp-Source: AGHT+IEuM7cjgrs6zXdgbC21FMTiEtl03TSCxvQ4KLURz2gOl+OQrJbkOzAY4Nbq8u+EAeyek5Vg4Q==
X-Received: by 2002:a05:6870:781a:b0:29e:255e:9551 with SMTP id
 586e51a60fabf-2a3ac537783mr5486805fac.2.1734289587937; 
 Sun, 15 Dec 2024 11:06:27 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2a3d2914ac6sm1423214fac.39.2024.12.15.11.06.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Dec 2024 11:06:27 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 36/67] hw/mem: Constify all Property
Date: Sun, 15 Dec 2024 13:05:02 -0600
Message-ID: <20241215190533.3222854-37-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241215190533.3222854-1-richard.henderson@linaro.org>
References: <20241215190533.3222854-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::31;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x31.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/mem/cxl_type3.c  | 2 +-
 hw/mem/nvdimm.c     | 2 +-
 hw/mem/pc-dimm.c    | 2 +-
 hw/mem/sparse-mem.c | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 5cf754b38f..12205c4d32 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1216,7 +1216,7 @@ static void ct3d_reset(DeviceState *dev)
 
 }
 
-static Property ct3_props[] = {
+static const Property ct3_props[] = {
     DEFINE_PROP_LINK("memdev", CXLType3Dev, hostmem, TYPE_MEMORY_BACKEND,
                      HostMemoryBackend *), /* for backward compatibility */
     DEFINE_PROP_LINK("persistent-memdev", CXLType3Dev, hostpmem,
diff --git a/hw/mem/nvdimm.c b/hw/mem/nvdimm.c
index 1631a7d13f..10506d52e4 100644
--- a/hw/mem/nvdimm.c
+++ b/hw/mem/nvdimm.c
@@ -246,7 +246,7 @@ static void nvdimm_write_label_data(NVDIMMDevice *nvdimm, const void *buf,
     memory_region_set_dirty(mr, backend_offset, size);
 }
 
-static Property nvdimm_properties[] = {
+static const Property nvdimm_properties[] = {
     DEFINE_PROP_BOOL(NVDIMM_UNARMED_PROP, NVDIMMDevice, unarmed, false),
     DEFINE_PROP_END_OF_LIST(),
 };
diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
index 27919ca45d..49c5f9fd44 100644
--- a/hw/mem/pc-dimm.c
+++ b/hw/mem/pc-dimm.c
@@ -150,7 +150,7 @@ out:
     return slot;
 }
 
-static Property pc_dimm_properties[] = {
+static const Property pc_dimm_properties[] = {
     DEFINE_PROP_UINT64(PC_DIMM_ADDR_PROP, PCDIMMDevice, addr, 0),
     DEFINE_PROP_UINT32(PC_DIMM_NODE_PROP, PCDIMMDevice, node, 0),
     DEFINE_PROP_INT32(PC_DIMM_SLOT_PROP, PCDIMMDevice, slot,
diff --git a/hw/mem/sparse-mem.c b/hw/mem/sparse-mem.c
index 6e8f4f84fb..8d681adfc0 100644
--- a/hw/mem/sparse-mem.c
+++ b/hw/mem/sparse-mem.c
@@ -96,7 +96,7 @@ static const MemoryRegionOps sparse_mem_ops = {
         },
 };
 
-static Property sparse_mem_properties[] = {
+static const Property sparse_mem_properties[] = {
     /* The base address of the memory */
     DEFINE_PROP_UINT64("baseaddr", SparseMemState, baseaddr, 0x0),
     /* The length of the sparse memory region */
-- 
2.43.0


