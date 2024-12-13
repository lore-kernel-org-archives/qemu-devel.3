Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D779E7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 19:35:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMBNb-0007nq-9n; Fri, 13 Dec 2024 14:31:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMBN9-0006nL-Ox
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:30:48 -0500
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMBN7-0004Gx-Tr
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:30:47 -0500
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-5401e6efffcso2355857e87.3
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 11:30:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734118244; x=1734723044; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ks6G+A84FfZ3IMwYe7rtmCGNogRG46Y1v4JaJo0a9Is=;
 b=coKITaza7OFlV7Wj1FaDTld/XPSQ9FenvQdK3wyYcyxTxCxDNV105hZ8xuhIXkEGB9
 OsP9hFBL42IYCdGKs+W20D/k9+98c/fJI/BVNSZwgKXyk3mawobHOQ/W9PJtxTc7VEEi
 v3yaZFndoaMlfBD2+DT9clAq7GutagD4bIDB6UYrYXSkBOmReNCHp33HiGGrrsSRsWnb
 n58AjJmyYzDvc+Wq1jND5EIH/3CV1t4cEhfDu0YidyOof698VUmTDfPU4j7C5yhTrP4k
 j8Z4KKHwF/Vqwi70rytz8ZX+lpWpJYRkg6PanGyboQBJB6tb+zAziqTamPgrrZIjWIsO
 azxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734118244; x=1734723044;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ks6G+A84FfZ3IMwYe7rtmCGNogRG46Y1v4JaJo0a9Is=;
 b=cN18L+NCkkWXm70/Bi8pq/Gi8vB+1NCoJA+nt92u6NppvDCfpyqx86yWO24HZwSsQ+
 OhEmzYN3OGyCYKUn6muIg41wjL/+lCj16pkTxWs5edSCo5qnVqmjPPcQEqAlZv/GcBXE
 Lq0paAnDwEqrzfkgALMY3Gr/tiec4nfiMFZsmLruj6SueIBFO5LUBxi1bA0LPsauvxPR
 ymXonYYzSRPoabnx1cauWzstMQ+5QRGenBhNn5iLqGE0GFzb0QUf1EVzjJJMVpzzr3Rv
 uaKY5rzkrGCN4KARxS42HDmvG0oe7jWpkyEMHr4ncBB+DeHEnaw/9O/Gx8LCFjZw3wW/
 T3/w==
X-Gm-Message-State: AOJu0YyEKSBjH6+Tk6YPw1ZYOjgJrMfggnaSCAJNHtwCVa0PfLAO9lhh
 Jmc7Ia2VMd+CFrHP4auyvPytqV/mwqqSLIeifHeNb9Yt9fPg8HH85eY23Cjr0q+d74zD28KApdX
 9LT0vQy2i
X-Gm-Gg: ASbGncvJbQa0LBivbAGXTfgo9+DrVTzpGB0+T5JyZYILmj5swfQvXpaTqGjyZrQab4V
 lTUWsq4cKj0wnzjrj3XZiR+Mxagw3fcHAXDKV9Z5YdNCYcdR/WhB7EKHoBvyi5hT1LAJkeRFKxi
 EnuF36qQUevYg0Ozemz08kLGZ6+wbJ2QK7ycGtIxV/0GNaxHOIGNtOPPQdaRbWaC85vQGZ3zKVk
 +8HEkNcKwsfzcuVFGTZZbbti+LGu1ajqu5ha521bRmGjlsHGUkYmIjZSM+g4g==
X-Google-Smtp-Source: AGHT+IFGZJIZIUb5LjrLjVc0WvQwaJBK5eY0K7njVad3ONjLROwm4SnNIJX99T953BtT5rEvxmgCfA==
X-Received: by 2002:a05:6512:3e07:b0:53e:2fdb:4de3 with SMTP id
 2adb3069b0e04-540905955ccmr1343488e87.44.1734118243635; 
 Fri, 13 Dec 2024 11:30:43 -0800 (PST)
Received: from stoup.. ([91.209.212.67]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-54120c01051sm6972e87.156.2024.12.13.11.30.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 11:30:43 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 xen-devel@lists.xenproject.org (open list:X86 Xen CPUs)
Subject: [PATCH 68/71] hw/xen: Constify all Property
Date: Fri, 13 Dec 2024 13:30:02 -0600
Message-ID: <20241213193004.2515684-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241213193004.2515684-1-richard.henderson@linaro.org>
References: <20241213190750.2513964-1-richard.henderson@linaro.org>
 <20241213193004.2515684-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x134.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/xen/xen-bus.c            | 2 +-
 hw/xen/xen-legacy-backend.c | 4 ++--
 hw/xen/xen_pt.c             | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/xen/xen-bus.c b/hw/xen/xen-bus.c
index 95b207ac8b..0d7defb8cd 100644
--- a/hw/xen/xen-bus.c
+++ b/hw/xen/xen-bus.c
@@ -1092,7 +1092,7 @@ unrealize:
     xen_device_unrealize(dev);
 }
 
-static Property xen_device_props[] = {
+static const Property xen_device_props[] = {
     DEFINE_PROP_UINT16("frontend-id", XenDevice, frontend_id,
                        DOMID_INVALID),
     DEFINE_PROP_END_OF_LIST()
diff --git a/hw/xen/xen-legacy-backend.c b/hw/xen/xen-legacy-backend.c
index e8e1ee4f7d..b15393e934 100644
--- a/hw/xen/xen-legacy-backend.c
+++ b/hw/xen/xen-legacy-backend.c
@@ -635,7 +635,7 @@ int xen_be_bind_evtchn(struct XenLegacyDevice *xendev)
 }
 
 
-static Property xendev_properties[] = {
+static const Property xendev_properties[] = {
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -674,7 +674,7 @@ static const TypeInfo xensysbus_info = {
     }
 };
 
-static Property xen_sysdev_properties[] = {
+static const Property xen_sysdev_properties[] = {
     {/* end of property list */},
 };
 
diff --git a/hw/xen/xen_pt.c b/hw/xen/xen_pt.c
index 3635d1b39f..557aa98be4 100644
--- a/hw/xen/xen_pt.c
+++ b/hw/xen/xen_pt.c
@@ -931,7 +931,7 @@ static void xen_pt_unregister_device(PCIDevice *d)
     xen_pt_destroy(d);
 }
 
-static Property xen_pci_passthrough_properties[] = {
+static const Property xen_pci_passthrough_properties[] = {
     DEFINE_PROP_PCI_HOST_DEVADDR("hostaddr", XenPCIPassthroughState, hostaddr),
     DEFINE_PROP_BOOL("permissive", XenPCIPassthroughState, permissive, false),
     DEFINE_PROP_END_OF_LIST(),
-- 
2.43.0


