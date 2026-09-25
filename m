Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FC43C98325
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 16:07:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xA8Rl-0006rV-Rj; Fri, 25 Sep 2026 12:06:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitrii.omelchenko@ionos.com>)
 id 1xA8Dk-0007vw-Qq
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 11:52:21 -0400
Received: from mail-wm2-x11.google.com ([2a00:1450:4864:31::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dmitrii.omelchenko@ionos.com>)
 id 1xA8Dj-00060a-6c
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 11:52:20 -0400
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49b912d37b5so6542755e9.2
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 08:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cloud.ionos.com; s=google; t=1790351537; x=1790956337; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NTTOBszhae6b65tYdYeG+YHSC5v2PqdRKV+Vycg+4ck=;
 b=M0Ko1r3XnVO6cGVVkrTP9IO1rF7t2ruT04vWIneWpWfvPVsoeJsAyae/JSXXjowm4j
 qd21Ki4XKqFb7e1VRJ5k9UhMtY5sWhhiloCqO440nNPqnDX+KSs0VeykEa39qmf/NFJI
 s448aDs4WxrBWLEVcK9FES2jLVc6xIWwbIFcUx5ZEC7mHqPB+kf4gWJnHH/wLQyvFY8H
 0aR52MflHDLRjFZxDV3iJeYMIJvguj3W86vakEIo6v46H2Zy/lyijJtr/Y6vV4yfH4Gg
 mhVfTVvyZmtIHjf2i6kVhIe3dikwxjR3ieQSkBnfz1EPPRHhFgJPLJ70Cne//OD9zHhj
 6XKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790351537; x=1790956337;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=NTTOBszhae6b65tYdYeG+YHSC5v2PqdRKV+Vycg+4ck=;
 b=e0/sBuGGUr6o/WzqE80gPH2fijVHXZcVM4n0mebbxH1vF1Yu7K4s8bgkXR3I47jdrc
 yyIlzWOTrz3HzAwBNUlbBNIfn/lNEOpMWIJwSJfQZD0WSV4mCHTjHLSiwbKGIMZnCceE
 ndyeUK8tbLq/NxXU5/3V9YYyZWA3CdGEoqhwJLX8QKvny66vFHWcomtoEoA53i4VBlR/
 dXHSPxs6TJ5LRl+IM+bI/L9vNo1gPiYPPznAt38c+kVyCvm2VcLV2NW6rzWOMIT/7TM3
 WbNE3KUGOEtsuhxvbNZlQDGaiwLRS0E02UwMhRPUwn5oGHA3wN3l26iAN4p4O1dL6dnQ
 ZYYA==
X-Gm-Message-State: AFuF++nvB4GzxsDV7wmmZa+a+jJ+2Pd7tD3G+XXKll3G8/GQkQHgW//A
 t9MNEBW+uq0sZIICu0hxR51AkIlvDRW/dCF7Mv5Ik39Txrcy7YlYLYkV1Sayk0wAyh6ES35B8KT
 VfRuce2K19w==
X-Gm-Gg: AYBFou1bMw/GYVW6jzW876CHb6EekJPZDTbjl1T0sVXZeaJeukQs2dT06Vg31KPIz1w
 g6pA3HGPuiEqm9QGVeOmpZ+UcLedjhB1QOnpF7zJrrThF3IRrGEk+nQThrJoodpNQVlB9GZONl8
 NQekXBNG8SppYYOhmB07gT73p/nv3kxu6qwkDhsm6I5tdeQfBed/20wVmElHfLtXtDP3oGvMlQd
 ur/PpkYPfB17gRnKFdXeCwNo4+QmR0a6yArQQMDZqW4hjrnVqxmttKDdMcZThWorqhMGnRUNp7+
 GJr8QgUg+FwsFctLnaxBdbITUiT6f/CMWevA1p5k5E3VOcpqWcFBXHagafxdZTB9/g94c0g8FWQ
 xDPopVyzeG6ehGCL6N2cByuJG+hzfUUN54t+PPZudXS7SrDaWSl3o+LNYCHNC6kNuLL4dhFgpjk
 qsKEV4M5nOfnCz6LjJRrJtfWYvJvruE4cGVNjTKOY8fYjXW03VvaDJ6UeswxoxclWUijex91yfo
 l8dYmI06V9q8LMwuSTXGH91od/VOKAdCi53uYlTHoE=
X-Received: by 2002:a05:600c:1c25:b0:49f:ce78:3561 with SMTP id
 5b1f17b1804b1-49fe66f19demr121022405e9.18.1790351537568; 
 Fri, 25 Sep 2026 08:52:17 -0700 (PDT)
Received: from PF-5Z7P7F.fkb.profitbricks.net ([212.227.34.98])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ff0f1f2e3sm112435875e9.0.2026.09.25.08.52.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 08:52:17 -0700 (PDT)
From: Dmitrii Omelchenko <dmitrii.omelchenko@cloud.ionos.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Li Zhijian <lizhijian@fujitsu.com>, Yanfei Xu <yanfei.xu@bytedance.com>,
 Jinpu Wang <jinpu.wang@cloud.ionos.com>,
 Dmitrii Omelchenko <dmitrii.omelchenko@cloud.ionos.com>
Subject: [RFC PATCH 10/13] migration/rdma: size reg_resp.len by the register
 request count
Date: Fri, 25 Sep 2026 17:51:45 +0200
Message-ID: <20260925155149.843870-11-dmitrii.omelchenko@cloud.ionos.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260925155149.843870-1-dmitrii.omelchenko@cloud.ionos.com>
References: <20260925155149.843870-1-dmitrii.omelchenko@cloud.ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: permerror client-ip=2a00:1450:4864:31::11;
 envelope-from=dmitrii.omelchenko@ionos.com; helo=mail-wm2-x11.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 25 Sep 2026 12:05:02 -0400
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The destination assumed repeat=1; set reg_resp.len to one
RDMARegisterResult per requested chunk so a batched REGISTER_REQUEST is
answered in full.

Signed-off-by: Dmitrii Omelchenko <dmitrii.omelchenko@cloud.ionos.com>
---
 migration/rdma.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/migration/rdma.c b/migration/rdma.c
index db1f1e3fc6..bffc7d33ef 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -3870,6 +3870,8 @@ int rdma_registration_handle(QEMUFile *f)
             trace_rdma_registration_handle_register(head.repeat);
 
             reg_resp.repeat = head.repeat;
+            /* one result per requested chunk (source may batch registers) */
+            reg_resp.len = head.repeat * sizeof(RDMARegisterResult);
             registers = (RDMARegister *) rdma->wr_data[idx].control_curr;
 
             /* Making sure the register buffers to read are valid */
-- 
2.39.5


