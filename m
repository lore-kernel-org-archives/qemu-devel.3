Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 809CDC5DF8C
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Aug 2026 12:42:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wy7WO-0001y8-SU; Sun, 23 Aug 2026 08:41:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dalbirrana838@gmail.com>)
 id 1wy7Mo-0000iy-Tx
 for qemu-devel@nongnu.org; Sun, 23 Aug 2026 08:32:04 -0400
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dalbirrana838@gmail.com>)
 id 1wy7Mm-0004ba-Ti
 for qemu-devel@nongnu.org; Sun, 23 Aug 2026 08:32:02 -0400
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-4b21f71613fso2041426b6e.2
 for <qemu-devel@nongnu.org>; Sun, 23 Aug 2026 05:32:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787488319; cv=none;
 d=google.com; s=arc-20260327;
 b=XezX+I1mWQ1FYGf81m7PnC5PqvfzLy6GYeFbzLiz+6zaUEnZa9Vf8sb4/6h9Gsyt0X
 p9jrfKWhhohxrZQzLq6RuAXL9LBg+yKEAXjVcSzChyEKPEOELY8UuT+FSQxOpEDknkLw
 QE/M/N1+sUgD3+RLVxXb/B3mCFbyb4Yv8ohCDUQ9ct1j5WzMYOwGMw1YjRlJc6fB0rRV
 gTF2XaVU+2eJ88Dxp6XnOJKTZiQQJlJ/tfjZLfCjjSE9E5/owjwpW0rRO/0mQ8KGlWhg
 saYXnt39GjulggKxssd1rZyhv8/XuITFRNwr9fu/4jtahRusNHAlAmBigxxkjiP6okis
 stKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:dkim-signature;
 bh=nEjd8kG6IByuzJWfla1jXzfGJ8iGxpcgKjRef6ulQ2I=;
 fh=fnhDM2yALDWkMN9snfpmIQwjkL4j8bTEeUhvQ3WIbvA=;
 b=TZnxMIpUFbkJncK0B/QtJfUpfy+tI0IPVr/VA5nDfnGI96t2oKvpimCuNwpmxUZQmN
 hDV9hIR4V5YKFbTPMnx2jKxxWFt9GFFf6rM68I27NLGAv41d1RPMt3sWiUBhu8H7th/o
 I4DVTKCbe5fzL/YCTdGu/WfacXZ+GFhTpdJoASWURuRs5Qi1wPBr5eJdXcFH39Ok1OaC
 mVwPl3M8wp3dU9ZDs1aXAWQ1qOKwCrxD964KATOjG+aEMgKUCswtmXBgGgjA7QHh7I/p
 6dDvd8ZzTR0Fi/aNBvBsyVZ4sZDvgwdQQyGy2nZQJ7p0llkb/qBDUf4vDlnSC99XYUoq
 aw+w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787488319; x=1788093119; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=nEjd8kG6IByuzJWfla1jXzfGJ8iGxpcgKjRef6ulQ2I=;
 b=VYVOgUUeKnVsEoYalGQjnrXw/tamTeUhRsIIWJjz3zfLNpFKMP5iRTHgwKvXlOEmsU
 isLkuW+kF362JnQYaLKu2UcrDURShOZk7u9iz3pBi6/KYQzrI4LInYQkArycuY17T7mQ
 w+TlGNhFXJnm4uNKTnWozgSmvSH38ct43NMXi09XpfUuOap4gBnRVT2BZ978SCvjUdr9
 cj549n45dKRfWe+dJTjXScOS9pQvd83J/SFTpv+6ISb82H9OmGdZO2lRZaQ6C2z3f200
 VTaQMvD9iJVRLbDgTHIAritQrmFVVeG3NXAng+MwzFpMsZZvgSRMGvV3mCdTuhvTuMC3
 DIyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787488319; x=1788093119;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=nEjd8kG6IByuzJWfla1jXzfGJ8iGxpcgKjRef6ulQ2I=;
 b=d5iyJB0ElEhQEkOBTOQamweiYWstpDw5lfcmVc6/yl8VFQSkFAz7c6a2369ekR4FwX
 G4b2AnXOHjsuFGkjrjHUKo9R1gsMocHSRCGYVd0Ry2hmkagnoinQjppv6Qe/UWBQlPbS
 r7m2JBcuKj1s1fKl7ddF24w8mFV6YrxMotXSNgvlT3aUBzmVrERoIHzOujENGqXN4ul+
 71yPjJtzpCglPLHykpkQfasKrGGAiHSbR8JOn1JxLU6zf6+WqOJuvyqTHOVlD00smXAs
 31AkkqJVfteGu/Zr3UcejtmSfF8g49t1WcqOtrogvhuxhCtX/EOIwOOBfZwolyOOOPUd
 n31Q==
X-Gm-Message-State: AFuF++kgC7FqOOgXtTSdy6VDoMekE5WKF74eA4zc0+zVEBVcJAzGOl1U
 eP0cb0573T9zJvQr+xDhNL7KAVr5HorX4tOQ21BYUlU9dzL8RRs2F3ykuesSA+5hoSoPa6+Mh4f
 6rLdc/n8dok/x0KWh2cWrwEk+EpWJ3rSnQ7dBTmlDYg==
X-Gm-Gg: AR+sD11/m7m8X5L6Ari75S3CVugkxojNMAUEPzPmpD9A+VlbwhjPAolfCxK8gTcf5Be
 YsHxFToau/2ALP9yrXLxNFxj3vX4txYO9at5AeMKcziqDXrZTF4yVY5zlEzb4hGphKRcEcF+3fl
 hERGZ/FiEdafqPEFN42teHe1Ic+avrj+reqQkTKDeLNaoy+YQU9kYnW9Wm9LMbLj3MIwrMrqodG
 hiJ/e/HCr5yhT3N1W+0oV7oRTMl7tSalU/mmiIJy+/uXxdtQAmiTcqXcaZ0eBBUtQYTFmezRDlr
 Tq5nvQRaSQRI93lcg0GHwMJ1YOd6ojhykWRlWYew/cRudAZZ5cVG4xkE6zrDre+njgWofCGAwYp
 XsoBZHF1CKnxOD6mWFObu99nX6WOmDi+8LrujjA3f7TSeGin4z9lqx3dISbH8fRRC
X-Received: by 2002:a05:6808:c414:b0:4b2:67f1:11d7 with SMTP id
 5614622812f47-4b2ef4cce63mr19036805b6e.17.1787488319315; Sun, 23 Aug 2026
 05:31:59 -0700 (PDT)
MIME-Version: 1.0
From: Dalbir Singh <dalbirrana838@gmail.com>
Date: Sun, 23 Aug 2026 13:31:48 +0100
X-Gm-Features: AcwNN1WXdw4g6uzGq7RF2nx1wQf-hL28TVIUkDaYtHTpue22eUlpnKTb8qefsPY
Message-ID: <CAAJFZSZ+2tzVSyfe983Q=d14Xcmu0a3H41-2NdNvv0pDqUViLA@mail.gmail.com>
Subject: [PATCH] plugins/lockstep: document plugin logging requirement
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, pierrick.bouvier@oss.qualcomm.com, 
 erdnaxe@crans.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::231;
 envelope-from=dalbirrana838@gmail.com; helo=mail-oi1-x231.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 23 Aug 2026 08:41:55 -0400
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

plugins/lockstep: document plugin logging requirement

qemu_plugin_outs() output from this plugin =E2=80=94 including the
"No divergence :-)" summary and any divergence reports =E2=80=94 is routed
through qemu_log_mask(CPU_LOG_PLUGIN, ...), which is silent unless
QEMU's own logging is enabled. A user running the plugin exactly as
shown in this file's own usage will see no output at all and can
reasonably conclude the plugin is doing nothing.

Document that -d plugin -D <logfile> is required to see any output.

Found via manual, reproducible experimentation (deterministic guest
binary, controlled single-instruction divergence, TB-address and
instruction-count cross-checked against objdump) with AI (Claude)
assistance in the investigation; the missing-output behavior and the
fix were independently verified by hand before this patch was written.

Signed-off-by: Dalbir <dalbirrana838@gmail.com>

diff --git a/contrib/plugins/lockstep.c b/contrib/plugins/lockstep.c
index xxxxxxx..xxxxxxx 100644
--- a/contrib/plugins/lockstep.c
+++ b/contrib/plugins/lockstep.c
@@ -7,6 +7,12 @@
  * introduced a subtle and hard to find bug.
  *
  * Caveats:
+ *   - qemu_plugin_outs() output (including "No divergence :-)" and any
+ *     divergence reports) is routed through the plugin log mask, so it is
+ *     silent unless QEMU's own logging is enabled, e.g.:
+ *         -d plugin -D /path/to/logfile
+ *     Without -d plugin, the plugin runs and compares correctly but
+ *     produces no visible output at all.
  *   - single-threaded linux-user apps only with non-deterministic syscall=
s
  *   - no MTTCG enabled system emulation (icount may help)
  *

