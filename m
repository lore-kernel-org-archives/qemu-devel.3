Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFD51C88E77
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 17:08:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6WdP-0005RS-RR; Tue, 15 Sep 2026 13:07:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x6WdI-0005PM-1r
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 13:07:48 -0400
Received: from mail-wm2-x11.google.com ([2a00:1450:4864:31::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x6WdF-0003V1-J0
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 13:07:46 -0400
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49b965f447cso386895e9.3
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 10:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789492064; x=1790096864; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=KrYU6RJmNOF/FoaJu3Mw98qt2feP2v6ZmgeL681rOpk=;
 b=jTmP1d/3kyJVngNx+HeprRdFsMdUJhcIUhnqQSo+HVgAyeLE64MPgbjKNj5erhBPxZ
 87SN4noZ4hLAUvRA/+DBFHi8JmN2o50E5E4BZG9BCuwL+fFIT7cabokdUeGAkefSQtUT
 Wu0rZNdfnovDRKK75/VHrm2PT9W63qitXJpDz9Ovh338Kf9UEN3BPrnD/SdhO0XuwXMC
 MKrCzXjqoGauD533+0o9bwMD1hRYpbTeXbckwTOHc7PfzjeIzcY9ne5E/W4j523WVNmZ
 kFknWggXAS/u83xVQ+FYWVnJMPP35biLzEFGRpWpF3V/a+iBT6juzQ5CLqgnbvrX8HfQ
 cl/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789492064; x=1790096864;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=KrYU6RJmNOF/FoaJu3Mw98qt2feP2v6ZmgeL681rOpk=;
 b=tHEkSKAyhZ9A5Zfoj6d5hBPJtzM3vdE4gzjL9LVM9H9biGU7JOv8MG8hplYsJIXwD8
 Xgt9138P1MTUOaT55lwWbQPHOSBZOKpjHyFZU+NaVTsQ3LlEar8IGYBGhUtgGLn0tGdB
 qhhAi4nduMAqhNIZo9HhFjQf5NXuIVh736ps+lRW/JXecY/SctuwlX7txbWCVFCHizj0
 rABTKLtVREjsH34HD7/wK7LNe1QxGMmJwPKPIv4KQhzbzU8ExHEIYMfnBOMBdfXUzQhk
 VXagu8MrpYVd1zy6cRor2qjlFllT5Sbpg6WfgZUuKk0wo4g7P7FuKSPtCsBSdbbJjIHt
 UwcA==
X-Gm-Message-State: AFuF++lu9AiEkSa73uPZC240P5MXa+PRJYi/HVHBsMQTHKFS8wjQMVlf
 TfvuyzqwZzo5CHDGdS4aXhiKh1EJF23z3CIBLwuA8JPzBq2kjpJdUbEAb+tFJN+uWydiIoDEAT5
 8xKmkBSg=
X-Gm-Gg: AYBFou0oMS+Q5grKsKxnAcYifm4d/vHHZ3qZfEWX8+Ipty08/0YINTT1eLjhFfCw0/Y
 k2iZ49MUkQg9bTf9zyGfRXfYWqn2HB3I2ie8fnABFAucdVWzSCFlG2EVcQPn8op9050jwVwVw1U
 g+adRJRj+PU6WOjckcGfHp2qkVHJ08YQ8kRKyCVt1NGjgb5AOS0AA8gAfCknX7LqObCq+9i5Vse
 N+xHPNn2qRFEASg9rro+AZ/ySt53WTBgR+7ousWT3Wz59SXqdKoIgDE4zM2SBIk4xLWPiLdp3iN
 2iIDR8OSHft9yMq1hFoXAAxrTOuz8yD2elAlsa1aFqiry1xKsFueu03bKkqZc4pBop2/iG7tRwg
 yYQ9uOnpPhXGDXa+LTMPSIs9tpRraZ9lqsPX42r2/8R1abmScUQkS5x+v7nNN5mOjKMvXz46th1
 4k++JYFKJVlNEDfRqtqL6X/H5DnNtc0BqoaSh/GR+zxm6OJMTc3/tS0OWpM3/uwNG0aV3fiTbVY
 y69EVZcc/1QFk5Z58Fdm0ZVyNbYbScimgKlZcuMwAXxYJZMNsM5WGvjDYRjS5nPqm7iRLlmlZsh
 l66X
X-Received: by 2002:a05:600c:4e47:b0:49c:fa20:cc02 with SMTP id
 5b1f17b1804b1-49e7a677cdbmr79686635e9.25.1789492064165; 
 Tue, 15 Sep 2026 10:07:44 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4870bf33e01sm431826f8f.23.2026.09.15.10.07.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 10:07:43 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/20] arm: gwdt: consolidate clear WS0 and WS1 on explicit
 refresh
Date: Tue, 15 Sep 2026 18:07:21 +0100
Message-ID: <20260915170735.425445-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260915170735.425445-1-peter.maydell@linaro.org>
References: <20260915170735.425445-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::11;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

From: Igor Mammedov <imammedo@redhat.com>

Current impl had logic scattered all over the place and WCS was implicitly
cleared on WCS write.

Consolidate clear action in one place under EXPLICIT_REFRESH condition.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20260902122646.2848464-3-imammedo@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/watchdog/sbsa_gwdt.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/watchdog/sbsa_gwdt.c b/hw/watchdog/sbsa_gwdt.c
index 7cc5609b83f..2aa44573a7b 100644
--- a/hw/watchdog/sbsa_gwdt.c
+++ b/hw/watchdog/sbsa_gwdt.c
@@ -105,6 +105,10 @@ static void sbsa_gwdt_update_timer(SBSA_GWDTState *s, WdtRefreshType rtype)
 
     timer_del(s->timer);
 
+    if (rtype == EXPLICIT_REFRESH) {
+        s->wcs &= ~(SBSA_GWDT_WCS_WS0 | SBSA_GWDT_WCS_WS1);
+    }
+
     if (!(s->wcs & SBSA_GWDT_WCS_EN)) {
         return;
     }
@@ -134,8 +138,6 @@ static void sbsa_gwdt_rwrite(void *opaque, hwaddr offset, uint64_t data,
 
     trace_sbsa_gwdt_refresh_write(offset, data);
     if (offset == SBSA_GWDT_WRR) {
-        s->wcs &= ~(SBSA_GWDT_WCS_WS0 | SBSA_GWDT_WCS_WS1);
-
         sbsa_gwdt_update_timer(s, EXPLICIT_REFRESH);
     } else {
         qemu_log_mask(LOG_GUEST_ERROR, "bad address in refresh frame write :"
@@ -157,14 +159,12 @@ static void sbsa_gwdt_write(void *opaque, hwaddr offset, uint64_t data,
 
     case SBSA_GWDT_WOR:
         s->worl = data;
-        s->wcs &= ~(SBSA_GWDT_WCS_WS0 | SBSA_GWDT_WCS_WS1);
         qemu_set_irq(s->irq, 0);
         sbsa_gwdt_update_timer(s, EXPLICIT_REFRESH);
         break;
 
     case SBSA_GWDT_WORU:
         s->woru = data & SBSA_GWDT_WOR_MASK;
-        s->wcs &= ~(SBSA_GWDT_WCS_WS0 | SBSA_GWDT_WCS_WS1);
         qemu_set_irq(s->irq, 0);
         sbsa_gwdt_update_timer(s, EXPLICIT_REFRESH);
         break;
-- 
2.43.0


