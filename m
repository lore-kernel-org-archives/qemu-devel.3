Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0BA0C88E7D
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 17:10:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6WdU-0005Tj-JT; Tue, 15 Sep 2026 13:08:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x6WdM-0005Qb-0b
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 13:07:53 -0400
Received: from mail-wr2-x10.google.com ([2a00:1450:4864:30::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x6WdK-0003WP-B4
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 13:07:51 -0400
Received: by mail-wr2-x10.google.com with SMTP id
 ffacd0b85a97d-482f633ece3so425663f8f.3
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 10:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789492069; x=1790096869; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7bOBpnHgEIaL3h57/lrLuv8LkYqt2Daj/aaWZvKfaLg=;
 b=y6LXioGN8MUfR8kOaDGoFGH7mG1ig5aUmOVkOKc9XtvxpFoH8VRH+o0xxiBYsNt1In
 5wh4YUnJN7HK2aO2fIStryVOOwXnH9eUGA2fdNxhnezYe9/Wg+kmRYOUqgO7ixdZ1YZg
 hwfQK2yi8WE8PKcstakuv7/fxmEfx7LQODDAWPPDGSWpsVDKc4aCIt1OyuvPIYC6SrOb
 roShzzScI3kjnXrmuLUzjJ1ZUx7oeKjZBQjNOejY6sVNjfCiXlBXHs40paD/vQwg6EGU
 VGTe4qhScAWtounuh90Bt64qZTLzAkZmNOZ5nkvker3t8D2vsZVcH8uweBi4l+oQV5Zh
 /eow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789492069; x=1790096869;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7bOBpnHgEIaL3h57/lrLuv8LkYqt2Daj/aaWZvKfaLg=;
 b=nga6bRjZDdBoJye5DmHnXQGLKjvSGR3nBkF0Ono+2rEFxvQoPapZtxqa3Ya+52X2pw
 fkGzZ2esXm75WCFdwR+rwI22omVQXV+KwDFZLMeJ+pgTcJCcLTDPxlX4j7jhxKhTHObv
 52LJ7n54zvfcpD9oMpc7RFbw/nR3AKPVlCWHUMHUsr6OxTzhvk2960LDJVIagixA3ljC
 Sd7klo1hTeTPUtAtfKV8c6tcSBimEifKsov6M7qrxSGfTs/5fOEBY4vwI0cpjp/5KA4w
 0dqH5tJ1vFwPVZXW0g61aU0ktb7A0blQgMIitm7bzt8WTlkcoXgbGkbLD93NGUXCaJW1
 9M3g==
X-Gm-Message-State: AFuF++n/0il3pZhFWze9TdXK7UZdciK2AFCALFq91MioMJOpuCeW/MtG
 fn4EiazTJ1ISyYeaZDK7rtiPbdbCSta/dCqE4SLJib6crc/FbdAW/OUZgBLBS6jFoH9QLWkH7Qh
 7Hjd38aw=
X-Gm-Gg: AYBFou2peF2iUVVxyDaZeL99AIFlJsGXUs8HKcwxGGW2OeXE+6g99cLeBbkp2brZRlt
 W7YCDDpx37d+rWb9+o0jrhHHVvlPTwYgaUwpns5+hOqkr2XjlDFotNG+erL6LT+diqcdEzOGgvK
 LyhGLsIKQnG0S1SvpCMlS5BN3WUikDzSosrHf6k7EAxFWtql0Ie2I7KdsDe/R9OMPJ+H7ZdPWG4
 CDxJZpCeQtq91jRA74Gyw6EtXlLixKFJZseSnzSpXARha35nwukeHM073O5nE9domrk3r+wt3wz
 ps/UIMlkHXBwV8EPqK+rTSHxJIuohcABjAzQ/+ZQjmcfxryVzoSgvHGyW2V9Jq1RGY1hBXJsBJt
 PJ7yWvtJObXkWnhj7eTFyRRvxysvc/vCa4ODXQe4LPMAyyDjQAE4IBoq9nXuZMplt/E/3LGthWO
 hhdTBLVwBNqeGcNEis2X2SHEwNxxzzCUk5H1F5XeOQBIFwJnTuGWW2xx0Av5MvucUodO2Lyah1I
 ELznT65ixp/+IPKRjR2WHy9YPzHsAHigul2yzANlSF3LzdkJhb5rl3OFObeNYOaZNuJxdfBgeYW
 55qn
X-Received: by 2002:a5d:5d10:0:b0:487:456:659b with SMTP id
 ffacd0b85a97d-4870a9c8b72mr2100198f8f.30.1789492068921; 
 Tue, 15 Sep 2026 10:07:48 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4870bf33e01sm431826f8f.23.2026.09.15.10.07.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 10:07:48 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/20] sbsa-gwdt: reschedule timer on direct WCV load
Date: Tue, 15 Sep 2026 18:07:25 +0100
Message-ID: <20260915170735.425445-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260915170735.425445-1-peter.maydell@linaro.org>
References: <20260915170735.425445-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:30::10;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr2-x10.google.com
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

From: Igor Mammedov <imammedo@redhat.com>

According to spec[1]:

 "The compare value can either be loaded directly or indirectly on an
  explicit refresh or timeout refresh"

QEMU accepts writes to WCV but doesn't reschedule the timer,
which it should per the spec pseudo code:

 "TimeoutRefresh = ( SystemCounter [63:0] > CompareValue [63:0])"

Fix it by updating the timer on WCV write.

partialy[2] fixes Windows in GTDT mode, which never issues a WRR refresh.
Instead, it programs WOR to ~4 sec, enables WCS, and immediately
writes a large absolute value into WCV to push the timeout far
into the future. Without this, QEMU ignores the WCV write,
the short WOR expires, and the guest reboots unexpectedly.

1) Arm® Server Base System Architecture 6.0
   Platform Design Document
   DEN0029D 6.0
   "A.2 Watchdog Operation"
2) under KVM system counter (CNTPCT) as read by guest apprears to
   produce host's value, so watchdog timeout effectively gets
   extended on host uptime offset. But that's a separate issue
   to be fixed.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Message-id: 20260902122646.2848464-7-imammedo@redhat.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/watchdog/sbsa_gwdt.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/watchdog/sbsa_gwdt.c b/hw/watchdog/sbsa_gwdt.c
index c5e88bf3d36..1834dc8db83 100644
--- a/hw/watchdog/sbsa_gwdt.c
+++ b/hw/watchdog/sbsa_gwdt.c
@@ -154,6 +154,13 @@ static void sbsa_gwdt_wor_update_timer(SBSA_GWDTState *s, WdtRefreshType rtype)
     sbsa_gwdt_set_timer(s, timeout);
 }
 
+static void sbsa_gwdt_wcv_update_timer(SBSA_GWDTState *s)
+{
+    if (s->wcs & SBSA_GWDT_WCS_EN) {
+        sbsa_gwdt_set_timer(s, (uint64_t)s->wcvu << 32 | s->wcvl);
+    }
+}
+
 static void sbsa_gwdt_rwrite(void *opaque, hwaddr offset, uint64_t data,
                              unsigned size) {
     SBSA_GWDTState *s = SBSA_GWDT(opaque);
@@ -193,10 +200,12 @@ static void sbsa_gwdt_write(void *opaque, hwaddr offset, uint64_t data,
 
     case SBSA_GWDT_WCV:
         s->wcvl = data;
+        sbsa_gwdt_wcv_update_timer(s);
         break;
 
     case SBSA_GWDT_WCVU:
         s->wcvu = data;
+        sbsa_gwdt_wcv_update_timer(s);
         break;
 
     default:
-- 
2.43.0


