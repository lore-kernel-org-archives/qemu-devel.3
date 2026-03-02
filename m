Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12196D58E7F
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 08:58:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwyzZ-00075x-Vb; Mon, 02 Mar 2026 03:51:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwyxx-0003mv-FO
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:49:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwyxu-0002Jv-60
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:49:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772441361;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Zmf9RGYgcG9fpX+Du8LFdn3cLSYkIIzBakMQhwNPfJE=;
 b=cjb3vx+hDJ7vV2rS0v6dZoTCLD4uBZ77/mNajLeXhoICAr/CMLLpVetH1QliVMuzKUZxAv
 9VcM4tJlrJpNYpw455w7DXqbaFoDPepNOu1WaZNQnBVSO3ipovks7yWAAb66WK09EMsseQ
 DD6E9tHwWtTpr4wEF9zfxWnCT8x4fNc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-kezrGW8rMOiZFl4qBhH8HQ-1; Mon, 02 Mar 2026 03:49:20 -0500
X-MC-Unique: kezrGW8rMOiZFl4qBhH8HQ-1
X-Mimecast-MFC-AGG-ID: kezrGW8rMOiZFl4qBhH8HQ_1772441359
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-4398eac51b3so3500927f8f.0
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 00:49:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772441359; x=1773046159; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zmf9RGYgcG9fpX+Du8LFdn3cLSYkIIzBakMQhwNPfJE=;
 b=QBZB8eBxXF+m8WV5kk4JtJHL6r0qVm+DRArMrKAV+AtOAKeDhzZx3I0uw2IPs0rEpH
 jCa4w/l0pvvOKsEkMlmQOMaOAfb2Klk77pXgImwdLQhqwbRqf3lzgT+CcK/Pl8HNGeuw
 uW0OtucaT0cicpi86hCXMHOkvGHRjrpznOh+g5p3lwIoW9IKUPvS1Mbvo3QVWJnf+Zv5
 +3A6iwMBHXdwBN/bwm7ddgr4E9f4WIOcVrysPv8boT61pM2GDDI/2BCJdTyCRIV9nv/H
 y6e+a3/4EHLkeI/+SVpYkFnzraHyulm5PAcZxgskzo83qypEwSae7mghfl/t/VMo4g+c
 3WvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772441359; x=1773046159;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Zmf9RGYgcG9fpX+Du8LFdn3cLSYkIIzBakMQhwNPfJE=;
 b=Wm6V9gKDGetZ4tKLscfoGAxAViXeVPd5o8k8PBopkx+MGlLjit5VPTJJfDgBD9vouw
 0XZoR/apiZF0uF97THKn4h3wbk8pgUhdxm/XNNLYfmunvr2QOJlmbWUrRc9TgblI/aAg
 sPIb+CllIkcNMfKABwnOMso+VK9DMb7ljNefp48JV+jxxlnHiNfiCKov1tkjTr2F2ai4
 +wU+ANCmTE62teHZIW0k+o8sPYJ+abfzRtpcLRzLPt0R0j1B8gwBGaGXmWxbFsBNreF3
 w6GlnjCHxSxENYRTuK66z4HzsHz3Eva74RUcnFFLfg9a+fh3+VfPMy4g8ty9tzhQrymd
 jw4Q==
X-Gm-Message-State: AOJu0YxIzFJDPGFCpdfHW+YuCojUApRRZabhNj06MVxVBaEh25VKVLYs
 8tHfdMVvBDdL6+K/LtyMlCxtdSA/nRguvBT6vVDB2Q9SmKvKr6W2LOctQpGl+A+03AMUy96hyyL
 DrFIMMt83fQ93ZzCVZlOTWkD/yUW/7R6RIvqHvW4Imy2MoEOCa/xy1PS1d8v3lUG2E5cn5rQAeM
 /HPFUZ8XXq7KM2UC0a8yfvP6eAEWpW5UcJq2NpMxx2
X-Gm-Gg: ATEYQzw3r5imNC28QXQ1SXj9t8bp/QKGxBE6F6tyfmuZMeOPysoE4uwDvcOxs47AdHX
 yRhhaGTy6eo0b/RJve4BrrHXP7P1KzriH16hLkWruXawNGCcENw9A/d/XBntjl0j35hLCJzSHj4
 WnqwDyBKa5fZng2yTmXtKFJr2KbMUgmtj6QdSd8zb0ITpOVIfiRrnnT0Q0P38mB6JPGhIeVGBgV
 vfd6ZEGKmQqaSQxVI11eYnnTJ/ZoR9/qJ+3VVg8c2oi2+LLE5RIUWWdSAb1iwsdKVeMFSsFeCiY
 LofSvE7LouLZcHfBXkfOL23xbASQY7GQO1mmWk51MfMNL+54kA9sZgGpZpd2eOSeTdDKu521VMq
 ZqRi08MqmBz2CMQRQgT1tpvkzHQ30XJz2mjuCdurf/TL6R+YeNYHK3CwWrPvLysd0m/HKmXnc8t
 +ok1uPZVtsa5+wW9Pw/NLLho5rfQ4=
X-Received: by 2002:a5d:5c0f:0:b0:439:b62d:be9e with SMTP id
 ffacd0b85a97d-439b62dc877mr4830948f8f.12.1772441358856; 
 Mon, 02 Mar 2026 00:49:18 -0800 (PST)
X-Received: by 2002:a5d:5c0f:0:b0:439:b62d:be9e with SMTP id
 ffacd0b85a97d-439b62dc877mr4830908f8f.12.1772441358344; 
 Mon, 02 Mar 2026 00:49:18 -0800 (PST)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4399c75a523sm25615542f8f.19.2026.03.02.00.49.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 00:49:17 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PULL 102/102] target/i386: emulate: fix scas
Date: Mon,  2 Mar 2026 09:47:48 +0100
Message-ID: <20260302084749.474955-36-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260302084338.473368-1-pbonzini@redhat.com>
References: <20260302084338.473368-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012, RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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

From: Mohamed Mediouni <mohamed@unpredictable.fr>

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Link: https://lore.kernel.org/r/20260228214704.19048-9-mohamed@unpredictable.fr
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/emulate/x86_emu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/i386/emulate/x86_emu.c b/target/i386/emulate/x86_emu.c
index 6c4ccc45383..55b1a68eb6c 100644
--- a/target/i386/emulate/x86_emu.c
+++ b/target/i386/emulate/x86_emu.c
@@ -745,6 +745,8 @@ static bool exec_scas(CPUX86State *env, struct x86_decode *decode)
 {
     decode->op[0].type = X86_VAR_REG;
     decode->op[0].reg = R_EAX;
+    decode->op[0].regptr = x86_reg(env, R_EAX);
+
     if (decode->rep) {
         string_rep(env, decode, exec_scas_single, decode->rep);
     } else {
-- 
2.53.0


