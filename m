Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F37E7CA6007
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 09:24:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEkLg-00083i-2c; Thu, 08 Oct 2026 05:23:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xEkLd-00082v-LL
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 05:23:33 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xEkLb-0002q6-W0
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 05:23:33 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4a1688d7769so31572545e9.0
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2026 02:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791451409; x=1792056209; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=BjccOuCbnIoSCjSCagogsG7qWonMcY6BChy8KmQg39U=;
 b=Fajfz0r96ttwOH01g5RDR6F2QYteRtC7+CWzrew/Zl65VFA0T3gHh3cx3GWK6Eh+XI
 HVHgPhbmhgSzxLKBYF13D+bvdJ5wEfRhLvWePU9vWpJjsrYXVytrM0IFGMyq3VTFAj/u
 80Zu5DNn+rFiiP0BFW/H6Kp4uu6DEhZ2uevbVchOMgxdRz7sJjZveQV1MtxfdeGGc2Oh
 idqQsp9JhAD3AeyBFlqWEBFbMxs4HdHEJV781fVKlCPFc50Uc9wXS4j36Xx4J39d5x1Q
 x0AGQ1MV+MwiTW0ptJvCAYSNYazc9bYZktiUnLGOChG/5UmpH/d6tpNMtX453Qv+cgoC
 aWtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791451409; x=1792056209;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=BjccOuCbnIoSCjSCagogsG7qWonMcY6BChy8KmQg39U=;
 b=jzKwTVxeqrtcKcwU+V+Z/nljobzGHEp5kutxegwAazaads5iLugWD6lGzQC63XM6sZ
 cd/U23or50prFu2bHMqn4iZxYB7MrTgy8V6BCEi7XYrddqd2ryU2YARy0aN5HpK6rXW7
 9so8nr7tqEJgP1tuZZHigJA4TGYtmKh0kooDw+QJiNQn/1lcjYM6wcsuL3JpH3lwafY5
 pweF1KBqA5jhU4LoXqVs0w0VbdB5J3AIbIULYRSC4mXFnWyhL1vE8Dvkwzi4ID5Fqkoz
 m5Lj+CIq/yeGa2zfXnkv4fhL2HqdqO+iJKN2inrvWF/yR6r0kRJtiFK/TJFNcM7vjr7O
 3GYg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwXWVilJ68c/itA73r+W/gowKoDga4evUNwUhsgLmFQT+mLi4hsvmPEmRnxhlfy67QNQttAeGXgNLxN@nongnu.org
X-Gm-Message-State: AFuF++luFQgLo9aKEWIzw4XJCtw+imDlS6oPklCp8qs6nmLKqV32d8Hp
 Zp3HCZiDHy3T8w87DrOErulNuCGqE5EE1RGCw4+PvKzGkrB/QMDkf5P4MN8zkz1xgcEklsZpFQc
 dRSpHW1A=
X-Gm-Gg: AYBFou2PV1gqQmkV/RzJN7h5DWirkcd1GlLS8Wi9HAPHJLxMIcPH6WO/ZT0946FO9FG
 nBrH6e3TO8DESII6a86PF4bCuchBZFOQZjb8U3rqQjqduxfqWsQZZi9S+DfmVYT+JWtbUZlVRU5
 oDNDH5UUlV4NG9mf6tsbRlc5xMmafhaF0LfPLlxOmxdApOtzlZNzQqg66XPj27QClInZ0tpcLtp
 d4i6FxHLoR36DuhNX1rOiSFjfUtte6arEPOxadUfgLkNjjvVtqyaKAUiTgh50NTMWt6N6uLshCY
 geOTVU1kJh8UfjFusmcV6zip6CRohM/XpKLAh28gMsFHPj8rdK5ikVDwNoUthtRN2jhSSq1YowM
 v2gSk9SZfUNFWPXAN4FA9bgIXs7NcV//iuGZhhVHJ2W21VanJ6t+876Tc0Mf9g9ZO/b8v5lqvN/
 dknvp6SdhHDZF/M7drvASOQG+lLgrI2olKJnlujqlZ9nJKVmc+GaJEGyH3n2jD639uBVOKIKcFn
 q21H+aHmk0PHprJJm78xxRitzxWFKoVNLsxY15kL46CkRp3JnWuuQH88bdtPwxn8RGituhHGw12
 Fx4=
X-Received: by 2002:a05:600c:810c:b0:4a1:7163:3e41 with SMTP id
 5b1f17b1804b1-4a1804234ffmr80152545e9.9.1791451409460; 
 Thu, 08 Oct 2026 02:23:29 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a181aeaea2sm108798785e9.5.2026.10.08.02.23.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 02:23:28 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH] hw/intc/arm_gicv5: Make IRS_IDR0 reads return actual value,
 not 0
Date: Thu,  8 Oct 2026 10:23:27 +0100
Message-ID: <20261008092327.4036856-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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

IN the code for handling reads of IRS_IDR0, we carefully construct
the correct value starting with cs->irs_idr0 and adjusting it.
However, we never actually write the final value into *data, so
the guest will always see zero.

We didn't notice this before, because Linux happens to not care
about this register value except to check for the presence of
virtualization.

Cc: qemu-stable@nongnu.org
Fixes: 405ad2e76f13254 ("hw/intc/arm_gicv5: Implement IRS ID regs")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/arm_gicv5.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/intc/arm_gicv5.c b/hw/intc/arm_gicv5.c
index 08878193dfc..ebfb0878af3 100644
--- a/hw/intc/arm_gicv5.c
+++ b/hw/intc/arm_gicv5.c
@@ -1433,6 +1433,7 @@ static bool config_readl(GICv5 *s, GICv5Domain domain, hwaddr offset,
             /* ...which means VIRT_ONE_N is also RES0 */
             v &= ~R_IRS_IDR0_VIRT_ONE_N_MASK;
         }
+        *data = v;
         return true;
 
     case A_IRS_IDR1:
-- 
2.43.0


