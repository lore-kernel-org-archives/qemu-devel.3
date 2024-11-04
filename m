Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39906D11198
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 00:22:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7kpi-000830-Tt; Sun, 03 Nov 2024 19:20:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1t7kpR-0007qV-30; Sun, 03 Nov 2024 19:20:22 -0500
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1t7kpP-0002at-Cp; Sun, 03 Nov 2024 19:20:20 -0500
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-71e4244fdc6so2800680b3a.0; 
 Sun, 03 Nov 2024 16:20:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730679617; x=1731284417; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vu5eharWQk1FSB+e4LNRiM9r8Io0b0aJaOG1mXtUWgA=;
 b=cJkRwdIAjDrN/Ap1hryWLtH9HHStOEHVe8kWjDrhUPYP8li/vZiKrQk4VaYmO7T58E
 nyhCZ+m7BJnHvkbAB0131l3CDvpsdVwStDiWPheu4LhuYCNR3S4Sx5OzA4gdigyhLArr
 XKk3XV8IPDLJ2Q1sX7Iqy0HxlV0wxUH4RngnNWmzY1dXaFfzTeSTnETUqYo0HEHCxGJr
 6akJRYfRSAcKGdVx3Waws1pvvjuaBjbJ//ixd9gv7pOT1boNzvcvw1Ecu+wPzHEGdRJN
 19q1EyPQPEsS0Vt47ikntTjTI71Bg09gCK6FunndF7+X2m794lGGmjF8rbHFYNexzgNy
 xnJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730679617; x=1731284417;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Vu5eharWQk1FSB+e4LNRiM9r8Io0b0aJaOG1mXtUWgA=;
 b=ZSsHZJPNt3bn/AuGUmFPw+AA0/3Mwt9qdQY7rMXKrRvpZeCWZjzWYrdLxzLFyMQTnx
 G1r+sZzaf+0WqkBponY9ZMw0PJayudurl1zBTkJEY9+6QsAhnupPrCPZW1lbp6XHF0bb
 I98LXds7K1q1dlIuFSxOcBDE8mOcQUZjAHa7YMCAZXkajX6crun8pJw/y+MOnObxmANv
 vu0Gjuml/8cuD5/e+WccO6sR7fXCNmCqEuHzKeWsZdTVKNpgWvdHqa+XvcH4kgwkER9y
 8NNkhcQIo02n9X5Y6l2NakPiRjD2U9ZkJPMPi+jZYjJmAC0ccALF34ix6eQkBj4OXTOQ
 XeuQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXb3WPlKPupfUrkE+JSIBsHTRUyKMHHQjlVtrBQdW+Hv1B/HQe2hpRgXyGB5heW3FTzWjLLgramig==@nongnu.org
X-Gm-Message-State: AOJu0Yyb20kfVo7V4wkbrbahzt/oYB5a1THLWmf9dAwy7b7RzwPMCbai
 iZZpyIv/wZNlLGjV4RyoOd8ABbB1uibYRcCbhSt+Z7zsfTBXrFlAKF50Pg==
X-Google-Smtp-Source: AGHT+IHvimNOBq1Uf3FK4gZiGUFtap9S9eEnige7l0GV37VX4X9a9NUXhwjiK8/Mf5PPMBRWdT2wAg==
X-Received: by 2002:a05:6a21:1743:b0:1cf:2853:bc6c with SMTP id
 adf61e73a8af0-1dba55ab0e3mr15395975637.33.1730679617168; 
 Sun, 03 Nov 2024 16:20:17 -0800 (PST)
Received: from wheely.local0.net (124-171-217-17.tpgi.com.au. [124.171.217.17])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7ee45a0081esm5900648a12.59.2024.11.03.16.20.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Nov 2024 16:20:16 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 18/67] ppc/spapr: remove deprecated machine pseries-2.2
Date: Mon,  4 Nov 2024 10:18:07 +1000
Message-ID: <20241104001900.682660-19-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241104001900.682660-1-npiggin@gmail.com>
References: <20241104001900.682660-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42d.google.com
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

From: Harsh Prateek Bora <harshpb@linux.ibm.com>

Commit 1392617d3576 intended to tag pseries-2.1 - 2.11 machines as
deprecated with reasons mentioned in its commit log.
Removing pseries-2.2 specific code with this patch for now.

Suggested-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/core/machine.c   |  3 ---
 hw/ppc/spapr.c      | 17 -----------------
 include/hw/boards.h |  3 ---
 3 files changed, 23 deletions(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index a41d1dbe26..2bbfcd1ede 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -294,9 +294,6 @@ GlobalProperty hw_compat_2_3[] = {
 };
 const size_t hw_compat_2_3_len = G_N_ELEMENTS(hw_compat_2_3);
 
-GlobalProperty hw_compat_2_2[] = {};
-const size_t hw_compat_2_2_len = G_N_ELEMENTS(hw_compat_2_2);
-
 MachineState *current_machine;
 
 static char *machine_get_kernel(Object *obj, Error **errp)
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index e9518ff8b3..34d655d0b3 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -5364,23 +5364,6 @@ static void spapr_machine_2_3_class_options(MachineClass *mc)
 }
 DEFINE_SPAPR_MACHINE(2, 3);
 
-/*
- * pseries-2.2
- */
-
-static void spapr_machine_2_2_class_options(MachineClass *mc)
-{
-    static GlobalProperty compat[] = {
-        { TYPE_SPAPR_PCI_HOST_BRIDGE, "mem_win_size", "0x20000000" },
-    };
-
-    spapr_machine_2_3_class_options(mc);
-    compat_props_add(mc->compat_props, hw_compat_2_2, hw_compat_2_2_len);
-    compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
-    mc->default_machine_opts = "modern-hotplug-events=off,suppress-vmdesc=on";
-}
-DEFINE_SPAPR_MACHINE(2, 2);
-
 static void spapr_machine_register_types(void)
 {
     type_register_static(&spapr_machine_info);
diff --git a/include/hw/boards.h b/include/hw/boards.h
index 44d19e1ffc..7e849bb30d 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -825,7 +825,4 @@ extern const size_t hw_compat_2_4_len;
 extern GlobalProperty hw_compat_2_3[];
 extern const size_t hw_compat_2_3_len;
 
-extern GlobalProperty hw_compat_2_2[];
-extern const size_t hw_compat_2_2_len;
-
 #endif
-- 
2.45.2


