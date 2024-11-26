Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C83ED6552F
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 17:13:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFz7u-0007CO-O0; Tue, 26 Nov 2024 12:13:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tFz7g-00078V-6U; Tue, 26 Nov 2024 12:13:13 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tFz7e-0004Hb-Cb; Tue, 26 Nov 2024 12:13:11 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-21288ce11d7so46378785ad.2; 
 Tue, 26 Nov 2024 09:13:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732641188; x=1733245988; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oW4RTaGV9Rp5u17+KtSXZQxBCwRUZA2L4Rf2kv6/KHg=;
 b=R1YXoF6iWrV0RAepwioawUSrIvYqY1TYgZe+XzhRps1swIXoMZZK/p4eNGn5IcQGal
 5yWSawY0/0RB2EBtHKA/qJQgQApMJagFUovLhh6DRStLviSl/H8ShSoNEgz+os3xb0Rv
 b37wXUQI0qq5StSbBmFnfp4qZhXM7LzRsnEilYF4V+a9yvlj4NiTi9saRJEw9lJu7hdX
 PwE1QAKIjVUZUvSlKrC54eOUtxJYJ/9GjYXQe273+UFI7j7IyNoHqgs1AtwWJeKLdOc9
 7uBs47LP7de+Xky2w5E0ffyvWYOuFeFPGyAX6TA4LWPHbxpa1esV1Vhyd74niTOjLOug
 CmXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732641188; x=1733245988;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oW4RTaGV9Rp5u17+KtSXZQxBCwRUZA2L4Rf2kv6/KHg=;
 b=H9nIsy5k6k2lUL3H2xXa9hbzFG0igYl/v38PQ963CrJ2fO5XVfhNO6kh3UhMd1Zjl9
 OSLYJenrsCak9dWXMEMh+TtXSBe+L4N9/FdJyGXBMU0Bjh6Uheobghkl2MRARkURmurs
 6ygEjJOBUUZ/36g1exRfBZs1xrQ2mBgHaBGhufsg2hyTLSAs2KDQCwz9ZDvxkJs5ABmV
 J81Hos6YRPGc14yvoFTDTYNvIoVrwksL1nDlE6j0fDmdhmKupGXDOqcoe3UrcvTJb5Ge
 u5LfC3uqMlY/vKzawMv3bgpE7n5BgVmmqjIMFJ1ebH/lW8EloFxAYPvMTN6MwF9WhGQh
 UdPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUAa9RFC+c8qDGLgB7Pgw5vx8jsSJ8DCg/an63ruqXGHonAzG1qtZrrZaSl8r4jPbABQNUYSlBO4A==@nongnu.org
X-Gm-Message-State: AOJu0YzzbYrVFrrVHSUb2meD8MpwOWOJJocMls48ChbvGVa7QKhq5ytv
 6II19cX+Hj12Vb8VDP45ufY8JE1evHU47POHCFcn7G9kBepuD0tKOAki0w==
X-Gm-Gg: ASbGncueuBPYgt0tPlBwWIFYQKrTyrzYoJylEtAQLlnySqWMngapzvkiEZfUSL+6GNL
 BfraOil/kpBlcgeKRJZcIfBsb1vw1iOb7PdftiBW8B5F5tRt5CsWssTYvMuCnhOGw+leNd0FE/j
 fTiUAaSndKusD3iBePIz6SV2FQX2HhGIr7nAe5hAydd2uqIBZTXaWuAOF94g6pmXQCgIEJdp5B0
 B1Ulyjh3A0RtBAlxWPySwx5ha9N2ONXF2C1Epa3gQtaS7NIFylQPsRMhoj9DwtZZXn7QRHhvrdU
 cFGB5w==
X-Google-Smtp-Source: AGHT+IFAC37WP3a3JcvI0LxPH+c2GDToSY1JtMkpFeEDEnteAxKhHGUL6BRNk854q/SO/a/tY6wsSg==
X-Received: by 2002:a17:902:ecd1:b0:212:67a5:ab24 with SMTP id
 d9443c01a7336-2129f28a626mr225521065ad.41.1732641188450; 
 Tue, 26 Nov 2024 09:13:08 -0800 (PST)
Received: from wheely.local0.net (124-171-72-210.tpgi.com.au. [124.171.72.210])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2129dc21c28sm87321175ad.246.2024.11.26.09.13.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Nov 2024 09:13:08 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Anushree Mathur <anushree.mathur@linux.vnet.ibm.com>
Subject: [PULL 5/6] ppc/spapr: fix drc index mismatch for partially enabled
 vcpus
Date: Wed, 27 Nov 2024 03:12:34 +1000
Message-ID: <20241126171235.362916-6-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241126171235.362916-1-npiggin@gmail.com>
References: <20241126171235.362916-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62f.google.com
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

In case when vcpus are explicitly enabled/disabled in a non-consecutive
order within a libvirt xml, it results in a drc index mismatch during
vcpu hotplug later because the existing logic uses vcpu id to derive the
corresponding drc index which is not correct. Use env->core_index to
derive a vcpu's drc index as appropriate to fix this issue.

For ex, for the given libvirt xml config:
  <vcpus>
    <vcpu id='0' enabled='yes' hotpluggable='no'/>
    <vcpu id='1' enabled='yes' hotpluggable='yes'/>
    <vcpu id='2' enabled='no' hotpluggable='yes'/>
    <vcpu id='3' enabled='yes' hotpluggable='yes'/>
    <vcpu id='4' enabled='no' hotpluggable='yes'/>
    <vcpu id='5' enabled='yes' hotpluggable='yes'/>
    <vcpu id='6' enabled='no' hotpluggable='yes'/>
    <vcpu id='7' enabled='no' hotpluggable='yes'/>
  </vcpus>

We see below error on guest console with "virsh setvcpus <domain> 5" :

pseries-hotplug-cpu: CPU with drc index 10000002 already exists

This patch fixes the issue by using correct drc index for explicitly
enabled vcpus during init.

Reported-by: Anushree Mathur <anushree.mathur@linux.vnet.ibm.com>
Tested-by: Anushree Mathur <anushree.mathur@linux.vnet.ibm.com>
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/spapr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 5c02037c56..0d4efaa0c0 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -701,7 +701,7 @@ static void spapr_dt_cpu(CPUState *cs, void *fdt, int offset,
     uint32_t radix_AP_encodings[PPC_PAGE_SIZES_MAX_SZ];
     int i;
 
-    drc = spapr_drc_by_id(TYPE_SPAPR_DRC_CPU, index);
+    drc = spapr_drc_by_id(TYPE_SPAPR_DRC_CPU, env->core_index);
     if (drc) {
         drc_index = spapr_drc_index(drc);
         _FDT((fdt_setprop_cell(fdt, offset, "ibm,my-drc-index", drc_index)));
-- 
2.45.2


