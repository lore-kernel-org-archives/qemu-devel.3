Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A03F3C624D0
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 08:37:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1gSS-00047f-13; Wed, 02 Sep 2026 04:36:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x1gSO-000478-P2
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 04:36:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x1gSN-0005Zv-9a
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 04:36:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788338189;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=jtiE9yBfB0ZIgNcLdU2YjuvkyBaDXrjozS44UC4Ekgk=;
 b=U/sOiNtmp/aH/Fc8fJVafcSm+q6QipA7n55BPyXZkc/GnNmqnaAcRUAfC4elrhhsscmuUj
 TooASFvmYYEbaAtHNCxfSHtBTCXwdV4W/Clf5d2lj5611Hx5ELf4cBH6TiwN5NFL537glk
 /4WQvcL4+hQtF2gBMzks2sz0Lop4coc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-496-25eR1kxePBW0tIRS9hAAqQ-1; Wed, 02 Sept 2026 04:36:28 -0400
X-MC-Unique: 25eR1kxePBW0tIRS9hAAqQ-1
X-Mimecast-MFC-AGG-ID: 25eR1kxePBW0tIRS9hAAqQ_1788338187
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-49545071724so5522845e9.0
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 01:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788338187; x=1788942987; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=jtiE9yBfB0ZIgNcLdU2YjuvkyBaDXrjozS44UC4Ekgk=;
 b=BAu5h1XDuUO6pJCpFS7pGCOLAgCg7VeOR7q4cLzGDJSIYON3dPZI4eMrkLJBShgDNp
 MS+Gpmw+fiJC5C3WXcIjrOVpa8GbyuyBOXe9pmIT6tWCaNarTTD2AXiXloEX2ggJfqXU
 aWG7GzU7RquxtFEOeV0/R9lK282CvXBPo+OxVN4afhBQe+ujQ9mZREKHCi5d5FKJgdca
 KK6lqx/qt63/c3Q/abAnUFxAvXz5ZzjVM7b7bUznqhcF3UbVneCn6UbJ6mx0uW9tV4Wq
 dr2KL/f57ZxxWijT/lVdepKayOX+nrYnlREtC7h1i57ts13mvVat/Qhe/M+5zHgj19cq
 9YVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788338187; x=1788942987;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jtiE9yBfB0ZIgNcLdU2YjuvkyBaDXrjozS44UC4Ekgk=;
 b=M+VHG5/5EZJ9c9u4rhjJZLmhj1OfluG9KJYh5aTzONT0kIvOHh2ytTUY3j9+g72L5S
 2e5me4Q7PsgogX/G3sIx3PCE4Gj4Xw2K2jdll0U2DWdUXMt4EY4Ut39O3o/1CJAd2Uef
 Baeu4TgLt53yk7+WlpGF16oMEwoi7+RA2pLkBIMuXJoh879LsynFlwp2rF2RByOx2IGt
 bXi7hVZqVuzx3s26Zp5L6roZiQNNTJ5uFMNaLPYCN5w+UsLyh2PmQylhp7fvFWuID3ti
 2QQzLImTdEsBA+hd81h5daSQpRKrgUuQppTbwg86f102SyGrA51Szbu+FaSqdc5ZBLuH
 Nfew==
X-Gm-Message-State: AFuF++m5t17YxXWdDowJgPVY5XbWmp70HFJuSQ8pgHDDyMyszehx6sre
 HStPXh25yW0Ie9AMj/eQD18vx36E8iBEkUgguPvofT6REpfA72W/vcfgM+d44ig/NEZjAU0Qg/z
 tzxw2n6qkPEsTJN2EgHHDrPzrxKivsk+wXny3AyeoHGXMKz6o7UJX+A7+Ys50hOeWhAzQuGAjMF
 KFqqkI+zdNoEIwfE/B2GfmqkWXEgwmENg9tI4doznr
X-Gm-Gg: AR+sD10Bo76GiDdRWNYL7xE/YS7dXRcKcGFx1L0OCTp+vPviNOoo4evUZpiYJu+fsgV
 gPa8xZX5djSfVXbQICy8o2eanclH0yf+xaS+fL/Tu2BmjHhrUrfswZM7G+YfGFYfBwUcxzp1mgT
 GWcDLlka+8o0pAbG5/jf14wxlSPfTUpn9v8xyCnSN0DcYRE0i0+J5VRel2ly5nMexXS+QumFrGZ
 KaTKJ+sm/VdTvuFn4Yz/R16KJ6Z53PMTnoM2B+Rt8MTJEsimv1Q1WIhwEtcApe7wsiibL+PiPws
 ogmqf5EXA3Ao97wX5zhkOyxu40MF7ciRap9JvUQH9l+FH/LuMR262wyY1cL30rop1ofwkvg61EC
 vHccxeIo1MhzaV3Owyxpk9m6V6hkWo92fMKaXf+K5z4nbQTdtar77SIvvdCnGZtSZiFGe5APMVf
 WHYqk=
X-Received: by 2002:a05:600c:1906:b0:499:8b13:3a98 with SMTP id
 5b1f17b1804b1-49ce57e7a9dmr48554035e9.4.1788338186960; 
 Wed, 02 Sep 2026 01:36:26 -0700 (PDT)
X-Received: by 2002:a05:600c:1906:b0:499:8b13:3a98 with SMTP id
 5b1f17b1804b1-49ce57e7a9dmr48552985e9.4.1788338186541; 
 Wed, 02 Sep 2026 01:36:26 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.151.49])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ce4647472sm50949745e9.4.2026.09.02.01.36.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 01:36:25 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH] rustfmt: disable wrap_comments
Date: Wed,  2 Sep 2026 10:36:24 +0200
Message-ID: <20260902083624.419157-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

This was in practice not enabled until now, and now that it is
the results are not great.  Disable it so that the CI job
check-rust-tools-nightly does not fail gratuitously.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/rustfmt.toml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/rustfmt.toml b/rust/rustfmt.toml
index ebecb99fe09..a7d610bce21 100644
--- a/rust/rustfmt.toml
+++ b/rust/rustfmt.toml
@@ -4,4 +4,4 @@ format_code_in_doc_comments = true
 format_strings = true
 imports_granularity = "Crate"
 group_imports = "StdExternalCrate"
-wrap_comments = true
+wrap_comments = false
-- 
2.55.0


