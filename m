Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42E41CA5FA2
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 13:04:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBB0f-0005Cq-5B; Mon, 28 Sep 2026 09:03:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xBB0X-0005Af-1P
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 09:03:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xBB0U-0004Mf-NJ
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 09:02:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790600577;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p9uOK4ZxCgaduhAR0lyAPeCRyDZQ+mx+ZW9SXrz1HTw=;
 b=B68xhlJiLBTlMKoZdPYdReSLponEDe2Qjvx027Q/nccaU5RWSFkHoJApdMmdOzMCmC3c99
 F2VLrUsHVms7kZ+0/8vmyFbPmvbdnjtD/vyYQ/pSuh1lkyU1VnzmoyLDa8gCdFR8KU4W/x
 pnUTaKcMr/Kk8LZHWayE+JKfxY2jXoQ=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-580-Pd-wnObNNFeAC3nBoBEJBA-1; Mon, 28 Sep 2026 09:02:55 -0400
X-MC-Unique: Pd-wnObNNFeAC3nBoBEJBA-1
X-Mimecast-MFC-AGG-ID: Pd-wnObNNFeAC3nBoBEJBA_1790600574
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-c210c66672eso430872866b.2
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 06:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790600574; x=1791205374; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=p9uOK4ZxCgaduhAR0lyAPeCRyDZQ+mx+ZW9SXrz1HTw=;
 b=cJgVLCSih3jE8vLzhM63FbIKEo9vQktKuuZgB5QaLS50uiiWvPKAaM0A5FrWIFNwiW
 PA+q0ogPg/leYltVzlznzH7+TpOtEMP3PxP3nT3lOeTOpVu+LiRbgGvs4m93eGZkv/dM
 pp1Q1zGf70hr2iMroaeUVmAAXcS383M9+b9rVdI7G4OKGV1PWEHzKvse5DZPEkWO96yS
 SEufk1dMCzy0jDJC22A3rZvNmXUcf9w4hESJR0XMTnWR3+0rlhTWcM+a4Tu3ydLjgnBL
 Gz2tyKziNBc2HfLn/PhF8LS3YwnKq4OopR+GRifbj3m5M6c/3hou5ZVYuUIIFy+Oqh02
 W55g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790600574; x=1791205374;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=p9uOK4ZxCgaduhAR0lyAPeCRyDZQ+mx+ZW9SXrz1HTw=;
 b=UngIx32HY3gqywhHF3f3mh/rgBqDxJEPZQAE2DRBoGDYEwTJDnAdhmypPQzypJaP5e
 DygRAjREtDztnxQ1/wiSX1RFivWHDMZO1stP1fnXj1fMYlWczS/BFZLlvMTtqSm7ypt3
 e7gXNk+W1dCARhmnAnahQa2O8DqJ40I2UNL6HAhNCMBSP/8MkVHjnliqNMFR8dAcyB0I
 ZRhIf1O3JnxrtVjhr6ssgMjDKv7Wp8kXshe6ZR03e6E9uGHqcmOCrtuSMhYzj9nuwu+S
 Vcq6N1RwIF51HhowYaRmXt6V7ZtsH8q1AI+f3bPjtsxBZK5F8r709/WG/xNZtxW9Vz44
 tjOQ==
X-Gm-Message-State: AFuF++l0+5t3xDr03oW3laX3gE2e4A1NrTosTZhnA19N5n88V4E398Hl
 9laL28F+9+z1cG31PclzGmL9PoD86rQiqg63YfqStr7AUjrAFwcsfKrNXbuBpgXFAFXFxfsdP5a
 YLZw16cZtJSs5RPng3pfShThqYq86d+vrVVK6LCIEHTN4HKD8p3dazmnJQI5QSVpuIYFxT3NVHJ
 hwuo4KDS2GqOhUfF4Uup/PassPLX5ewBMQWERiUDSx
X-Gm-Gg: AYBFou23HNW8jgkm//dTunhQtTR11Kq0g+vBQGW51tfz4FdXFSvra1FBnYvP1VsADyh
 q53DOw/43q95kLJNiamlw0Uy4LwYiutZeSab+g7v16AdRmw3TPFArrvwjCel5etDlwi5f9XRpbJ
 DUpXLpTIyoyvk5+0CLQU7DDqtN0OddHpGZYTyVbw2/yrxOXE+tR4P5LFFwtjCgz3ocQeJAPYGpA
 vUsG/Xrhxt7TyvlDZhuyhcGeNOMW+lY7agfIQj3uJQxC+7HK2uNmIS7Dupp92ghx9SsmHFfr+jU
 t+lWyhxycuQk45no89se0FoZ38zHji6ao2bN8WoxsnQhj6XZ+Og4nb3uU3QGFZymn+DWV9A9o3n
 OQ+UiiPki5SBJDODoGut68LAZQaMWgBwc7qXG2+XO8ilTZyHLGMwa0b23Gl3GJ4QMqimtHlWCPK
 G9nbV1
X-Received: by 2002:a17:907:c24:b0:c29:f5d8:9c7d with SMTP id
 a640c23a62f3a-c2ac22cad65mr1156324866b.44.1790600574063; 
 Mon, 28 Sep 2026 06:02:54 -0700 (PDT)
X-Received: by 2002:a17:907:c24:b0:c29:f5d8:9c7d with SMTP id
 a640c23a62f3a-c2ac22cad65mr1156319666b.44.1790600573398; 
 Mon, 28 Sep 2026 06:02:53 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.232.249])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2af74d6dc1sm379445866b.54.2026.09.28.06.02.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 06:02:52 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 08/30] target/i386/tcg: JO/JNO can use flags directly if it is
 in CC_SRC
Date: Mon, 28 Sep 2026 15:02:06 +0200
Message-ID: <20260928130228.877003-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260928130228.877003-1-pbonzini@redhat.com>
References: <20260928130228.877003-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.238,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 3cdc458f95b..7fa2604a220 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -988,6 +988,10 @@ static CCPrepare gen_prepare_eflags_o(DisasContext *s, TCGv reg)
         return (CCPrepare) { .cond = TCG_COND_NE, .reg = cpu_cc_src };
     default:
         gen_compute_eflags(s);
+        /* fallthrough */
+
+    case CC_OP_EFLAGS:
+    case CC_OP_ADCX:
         return (CCPrepare) { .cond = TCG_COND_TSTNE, .reg = cpu_cc_src,
                              .imm = CC_O };
     }
-- 
2.55.0


