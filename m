Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED52EC52D54
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 15:44:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZXyD-0006So-Jd; Thu, 01 Aug 2024 11:44:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sZXy0-0006Ic-Ff
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 11:43:49 -0400
Received: from mail-io1-xd2e.google.com ([2607:f8b0:4864:20::d2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sZXxy-0004vB-Vq
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 11:43:48 -0400
Received: by mail-io1-xd2e.google.com with SMTP id
 ca18e2360f4ac-81f94ce2272so271521639f.2
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2024 08:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1722527025; x=1723131825; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wmgSaVL8dhq5nP6b5OzdsZKAt0sQ4+L9Gnx6E+G/OOg=;
 b=JDMFkqj3zpf/48FLOo6RFHhZ+Z81ntIEf67K2RTLK5so+kLWl4pceEynevCHGCglkS
 S+R0UuJU/9wyYkuYShBNzMN4u0/JXxX4umSPdkup09R14JwCyGZBu9W3fW3jvdWAidDh
 SrV2kSMiE97Kgnwt+KVdo5Yc82LrbWv9Fy+CoEjBAiIAF95yz0/gKrL/GeDE6Q6het/w
 hTJOynGFHV1yQDstR43LLDVcqGk4vaudXhbooGmnFoWkVwY91YVn6bWSfcTuTjx4uuNq
 vNz0axSI8TuZRQJ1kNyzkU/H8hzHoHsPDSEuAXUoaeGfHWfOXZtxbT8x+9BSQtrGTXOS
 5xmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722527025; x=1723131825;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wmgSaVL8dhq5nP6b5OzdsZKAt0sQ4+L9Gnx6E+G/OOg=;
 b=vHn9vdX25qCksynx8MiycZ7fS7jCKVlLSpzUCszQovojd5pv2rpyE68kKj7jI1oZnW
 7TJjg7ri6ke1wDsSh2JdyVi7umrOMJXFFvW/5w3L2SmSNtAqfAijAnJlsPijnzbEfIfO
 l/W79CCDFD14sFfQF/2DStYze/j3V4OMcrFBZWsztvwVnC8LXGpidWBYNob08kNe0CH1
 l433krREWcVg6UGPQIHhxcXs45eolMIcyF0UQGMr7P7hb3WwYuZXcT35kAjC6rUX3Ydk
 elZBg0e4Nl8IwBD0ueg9Uwpu3s97253R04zzplbRStIrG4itFXIEHOGyhTZMycHmqrqg
 Q3yQ==
X-Gm-Message-State: AOJu0YzUapzCluQzEkcWzbvvr8AD+MTVkCIrlI6HW8V58UvniWeK4t5R
 jNE+oPzFXOsu8GKvUaTBJtNOK2q6yQy3LGRUeociETjF+dtgOYPPVewDLhoAA78fPL+c57prqQQ
 9
X-Google-Smtp-Source: AGHT+IHzyAeYJ3Uvstn1GJm9hScDb9jWMAVg631hWCE4vXOnxDrSLKzNr7XgXyOAc9tccsIH00hOHg==
X-Received: by 2002:a05:6e02:1d81:b0:37a:7662:7591 with SMTP id
 e9e14a558f8ab-39b1fb6c01emr9052535ab.6.1722527025076; 
 Thu, 01 Aug 2024 08:43:45 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com ([177.197.107.101])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7b762e9c650sm17183a12.16.2024.08.01.08.43.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Aug 2024 08:43:44 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 jason.chien@sifive.com, frank.chang@sifive.com, ajones@ventanamicro.com,
 Tomasz Jeznach <tjeznach@rivosinc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH for-9.2 v6 01/12] exec/memtxattr: add process identifier to
 the transaction attributes
Date: Thu,  1 Aug 2024 12:43:22 -0300
Message-ID: <20240801154334.1009852-2-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240801154334.1009852-1-dbarboza@ventanamicro.com>
References: <20240801154334.1009852-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d2e;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-io1-xd2e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Tomasz Jeznach <tjeznach@rivosinc.com>

Extend memory transaction attributes with process identifier to allow
per-request address translation logic to use requester_id / process_id
to identify memory mapping (e.g. enabling IOMMU w/ PASID translations).

Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Jason Chien <jason.chien@sifive.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 include/exec/memattrs.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/exec/memattrs.h b/include/exec/memattrs.h
index 14cdd8d582..e27c18f3dc 100644
--- a/include/exec/memattrs.h
+++ b/include/exec/memattrs.h
@@ -52,6 +52,11 @@ typedef struct MemTxAttrs {
     unsigned int memory:1;
     /* Requester ID (for MSI for example) */
     unsigned int requester_id:16;
+
+    /*
+     * PID (PCI PASID) support: Limited to 8 bits process identifier.
+     */
+    unsigned int pid:8;
 } MemTxAttrs;
 
 /* Bus masters which don't specify any attributes will get this,
-- 
2.45.2


