Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5883BC25B10
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2024 17:31:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s57an-0001ki-SQ; Thu, 09 May 2024 13:30:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1s57am-0001js-NI; Thu, 09 May 2024 13:30:04 -0400
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1s57aj-0003h8-PR; Thu, 09 May 2024 13:30:03 -0400
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-51f0602bc58so2101790e87.0; 
 Thu, 09 May 2024 10:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715275798; x=1715880598; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GCUy9HbKYqkB8J3c8ehjTn+z8ZMWUL+bdITYZiFkB6s=;
 b=Fhl+/+QoPrwjJ5KE3A7eJORofZo6WgaEpTEIyO9/V7iIBm3L1gdaDHidPUX/lPMqII
 R/BOKjpCU3TfagI/faYyfkDbnXZjkA1c8EHpcS7Lmv+q/hsdypSHgGVUfmQHAUSWayeW
 8+xpCGnFk/pakjI02FwpRhdR+vLsEvqIqX+hQF2jh71Z1oZgRrSOnPw4hRCk3mGllN/M
 nhX8qRChFoFDNRW7SxNXqj5sYbasCMD+EYstMp4Ex3cZNXDcIaDhWbvC+GD/UuRo+FdT
 AJumhVhFNw62gtZLnaNT5udqTX1UGQ1a5tMPqPVz0Ury+aE+rO+/HUqdixO7vm+ZmbmX
 Vj9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715275798; x=1715880598;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GCUy9HbKYqkB8J3c8ehjTn+z8ZMWUL+bdITYZiFkB6s=;
 b=jhmphQKPy6vhUUFVVSykST6RBCtIYGD3KLcvoaOzX5BFkzMScbmu4rCs+FdFfpqOaq
 ecd+0WlrPwnQqYElbw/qU9MFX0hKmHPe35dD9cFOq8XVDkCXM4pFAKsCvjSI131p1SKh
 SF8dC5gdnHDo4ut9fdYa3ORWVvuCqfu9eGUmS5XZoSUFhlYCD3/pSAgYJRfLFQItyDFj
 Iy7pl6/OhaWfECFcslePrJSs0bvCyGtVNzTBiVcm8vNhySWjee9wQVkVge0xmAsXXSBn
 SXtYk8Ye4REvEAWEDx5KM9Mi8LwOlkQZ48GQ9g9giBbM65jd+Es/w/EfvIbNW9QMyrPg
 oCEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUir7rYbuwD58ezy+63MRPBECoE7so3mESvoJ77RbQ0XB0i5+B7c/2GfnIYbUZykBY32iGY+XqfVeDyx8U9joN+Ivr6
X-Gm-Message-State: AOJu0Yz0LQyiPuzYI7kDXBmZ64vHcQ0M3U8hThmtjYRH1BhEX1vEMJt0
 7YDBO1DN7GyJoJtjcc5rNFaUuI+1QMKMmuJ8UXY5R05zlTBFkC7UCsJJkWw1
X-Google-Smtp-Source: AGHT+IGBzE5dVAV1Ul4e7HTYuKxRYaKWBiiH51eBw1ONPVttMICUtiQ6DPvb1ADZM1iRQ7/DYJVm4Q==
X-Received: by 2002:a05:6512:138b:b0:51f:4134:b277 with SMTP id
 2adb3069b0e04-5220e68c1a1mr107788e87.28.1715275798464; 
 Thu, 09 May 2024 10:29:58 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-521f39d3321sm371586e87.301.2024.05.09.10.29.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 May 2024 10:29:58 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Cc: edgar.iglesias@gmail.com, sstabellini@kernel.org, jgross@suse.com,
 "Edgar E. Iglesias" <edgar.iglesias@amd.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Subject: [PATCH v5 8/8] hw/arm: xen: Enable use of grant mappings
Date: Fri,  3 May 2024 03:44:49 +0200
Message-Id: <20240503014449.1046238-9-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240503014449.1046238-1-edgar.iglesias@gmail.com>
References: <20240503014449.1046238-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x135.google.com
X-Spam_score_int: 13
X-Spam_score: 1.3
X-Spam_bar: +
X-Spam_report: (1.3 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_96_XX=3.405,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
---
 hw/arm/xen_arm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/arm/xen_arm.c b/hw/arm/xen_arm.c
index 15fa7dfa84..6fad829ede 100644
--- a/hw/arm/xen_arm.c
+++ b/hw/arm/xen_arm.c
@@ -125,6 +125,11 @@ static void xen_init_ram(MachineState *machine)
                                  GUEST_RAM1_BASE, ram_size[1]);
         memory_region_add_subregion(sysmem, GUEST_RAM1_BASE, &ram_hi);
     }
+
+    /* Setup support for grants.  */
+    memory_region_init_ram(&xen_grants, NULL, "xen.grants", block_len,
+                           &error_fatal);
+    memory_region_add_subregion(sysmem, XEN_GRANT_ADDR_OFF, &xen_grants);
 }
 
 void arch_handle_ioreq(XenIOState *state, ioreq_t *req)
-- 
2.40.1


