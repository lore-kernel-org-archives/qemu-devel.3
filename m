Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F66CC5AD2B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Feb 2026 17:20:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtUAW-00057l-TR; Fri, 20 Feb 2026 12:19:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vtUAV-000573-0E
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 12:19:55 -0500
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vtUAT-0004cV-FG
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 12:19:54 -0500
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-b8fb6ad3243so373844266b.1
 for <qemu-devel@nongnu.org>; Fri, 20 Feb 2026 09:19:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771607992; x=1772212792; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=IRvKEquHoRhR9FTtoJbDGwgOdmk9XFImG/i1KpW6qVc=;
 b=fY1Fo0wnLFC000kwePhPqPczt+tVCwcXgBrYfhni0LwWKJ80JGXehMPid8K8up5fCd
 nBXwfs8D2vgqqddEK9umB2WnFzvc57QNz0157ozrb8fRoU17fs+AnOoRMTt7xiOMNIyL
 5X2oudyzTiX8Thvz8CyG87s2SNw3LjB7ZS+1txToMhxjRnNRpprp+QQwP31ub+t3EzXz
 /NgnyroMY21AAoZYY4QWxVaY5dhNTL7bXOumK+BZ14p4ntGfl6oc4bsDH+LvtpuzmnEZ
 XHI1KXV1fAG8QS5bctP2cQW3k8p+Ui8qTaSnBPf9ebMH1wIQG4H+r35iQBAULz1Ot0rb
 /jJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771607992; x=1772212792;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IRvKEquHoRhR9FTtoJbDGwgOdmk9XFImG/i1KpW6qVc=;
 b=Sf3GKKwb7ZYtCqNKppbgSyRqVQHTBDvBfCaPhkf9nNLEc9DuSJlXL9P14SjgCSom/I
 VrrVVmVOS0FAdke4oINyz8oOtpm1kjRQrd/IlX3F0IQqtxcrRO7MOOAyvamv8WlGq5Hd
 fkoIVbpoZ07iIh3Uni+gxxqXDotya8Wp/BPwJsa2x8VpE4iLHZkkbVpeuTu8H91GcTkP
 GS0RaF1lnNx2kelXpXxK+AJVhaQypgWzByZ8mYGRlpc87Wg4HNOMlV07Uxl/3+8D7lxq
 iyEkqDSBnZ9NVx0EtQyLAuK/JYHunpLDrUEnJ82WCcgOlO2vFzG5NfiYBKv3B7qE+53m
 dayg==
X-Gm-Message-State: AOJu0Yw8A/SJTsPqowzsLHOHXeKhnoQmfDyA680GkkXzbsH+TrTuXfhn
 +mSpXuc7l1gp+vgxssFUrL7W4pwp39Rq5qjMlxWjtYAAHIogovDfrNQSOQeqK0i1AffV/BWre+c
 ekIUN
X-Gm-Gg: AZuq6aL7V1Zk25eBF6SFV3ZLno0taTGZVUsqbir3iV7UqQQj+POXFgvuPgyHgjktE/E
 nd9SoJOKpwypaBGfk1hcJVnXOjP1bE8KjtCd5Lq1b3UJAVDyJnjX8Qcf3prjxMLCmifP2jbXklE
 bGQcQnAggSX4+wgGrmcY2bKahrE4hrili+RH8oFtye2D7GABoRJe1n7AZp+0BjF+V1RkHcj/2ZX
 POBtMXmuSs7eN7B5aUhC09pJi0Sh4dac7DHVDb7cgRbu8A7FfEuES64ueDWMYzQ+NVxkgbc4g9f
 dE+3sgL0GjGusgp2PqYH2TT8wsUGBYNPgMKjsGliWpeqkqoCmUicpn1In1tuNV9oXhgQfFdIsy6
 O1vtsJasZ3fvba2NYu3IVWOjnlYM0OcUxeDQAwh4/ORxt45Uab9A+zU0SjbsQ04OM8bujJiX8Vd
 1SCWMkOQ+qBYSjXospj540gzJuYcDcv3wKXQ==
X-Received: by 2002:a17:907:1c82:b0:b8e:9d66:f5fb with SMTP id
 a640c23a62f3a-b9081740d0dmr16747466b.0.1771607991738; 
 Fri, 20 Feb 2026 09:19:51 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8fc7385d99sm672175366b.17.2026.02.20.09.19.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Feb 2026 09:19:51 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 18DA55F838;
 Fri, 20 Feb 2026 17:19:50 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org (open list:ARM TCG CPUs)
Subject: [PATCH] target/arm: set the correct TI bits for WFIT traps
Date: Fri, 20 Feb 2026 17:19:45 +0000
Message-ID: <20260220171945.1065102-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x633.google.com
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

The WFIT trap should be reported as 0b10.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/tcg/op_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
index 4d708635068..aa14f15eb62 100644
--- a/target/arm/tcg/op_helper.c
+++ b/target/arm/tcg/op_helper.c
@@ -448,7 +448,7 @@ void HELPER(wfit)(CPUARMState *env, uint64_t timeout)
 
     if (target_el) {
         env->pc -= 4;
-        raise_exception(env, excp, syn_wfx(1, 0xe, 0, false), target_el);
+        raise_exception(env, excp, syn_wfx(1, 0xe, 2, false), target_el);
     }
 
     if (uadd64_overflow(timeout, offset, &nexttick)) {
-- 
2.47.3


