Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82D12CD5BD1
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 08:39:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSWH2-0004VM-8r; Thu, 28 May 2026 04:39:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSWGz-0004Ud-OD
 for qemu-devel@nongnu.org; Thu, 28 May 2026 04:39:25 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSWGy-0005KI-6C
 for qemu-devel@nongnu.org; Thu, 28 May 2026 04:39:25 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-49041fb8c23so49003605e9.0
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 01:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779957562; x=1780562362; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=kkWCmDMklVl+J/GQPe/NPhqvd7XyaCNzedxPZjZBVF0=;
 b=oxrwfeujRS9Y86WkpWG5znTEgs4zmjIy4VaDp9RsLYER1Vd/LrmVeharh21+rrH3gm
 xv5G/ngl5SSP/vIzFeVlyy+H43Ib9LojmEpGUYRQEjNZhWfpFmJe6hVA9kHRtFJobpj1
 gj+nDkSSsOwK5TZpCEiSk/oPK8p5q9Rhb7FqRjeRcgYjfqTHbcsXsdUQMHjFJojY7443
 LZQrPHtAYAMESWpLvJTBUWWT+6QMpxwjpzMGGAPPq4YevsL/kXg7wWavFxyo1Asd8oNF
 7VSpcNG2tye82NiCjdBWy9nfGMu/Xe52Ehm2941u4Oe52TxwDCXPy0JUoJnulxVE8BZR
 2GiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779957562; x=1780562362;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kkWCmDMklVl+J/GQPe/NPhqvd7XyaCNzedxPZjZBVF0=;
 b=gLEYa368tPo17HpXG9TRD8PRUe6LuBL8aZHwkBZ23L8h5C1VQ8+0HX/tSWvZke3mZc
 AgQbhKKbuoPssgzIvjoQBwaxWSEKZKYoNqOVrA8XR/enhwTGjVPE1OtPc0qUQVEZC33o
 1N2hHt/ajjHHDZpmtCTV/0EU59GJVfA5TtgZOzFC+x3CW7gxxl58NEDBa0oZUr6juT+M
 4ShE6Dqfe5kfYjFokggXHTM7yu76OOF7lp7ktGB3c57rWj00HOSLQoM8sxnn5nLf/KWI
 QtROR0XJ2zCogg5zOOCOBAecM+kJDSgRw0GzPQ0xfg+VPrsx21P0yznKQTDbCjdeaafT
 ctCA==
X-Gm-Message-State: AOJu0YyQ/q0ENQS4hljrjCDImAJqZBJHIXEPla7Ii4dHEWRqNbRDvCiP
 o5BAKp+4KRk3QEGyXp2UrkcrYoCVALgn9Q1tdwtDw2M1sz2fDHe529mUTz5L6mlWAXPmOipP/Gu
 5RzX9hs862g==
X-Gm-Gg: Acq92OFJSIx8QT47H4+y/OnVfZxps9DLnjei3rhBWRwoN57rFWuKeEuROklVDpUzbs1
 kWKHQ1miz60Ftoohar8pcLVc3uFTWZKat6ypfAD1zoDX94cPoc79nRztTB7H4+BQix/2DurFZYe
 XoFfcwtTDk++oJypFYtHiuJH5jqKt4qoN4DIzPrgHjFDLJ2Q4EIXQZfRQaPD3RzSEO22XIc54WZ
 9UFj4L3vUrOAERFw/MGvoGRdXdKgDjHtz6PdkPblT1dRZA8QLEE44GZfxjAJVS4Y7rr/SK2x5UP
 bhzePIiMgMHL6Zm0z73HQFZMdDRI0v5qdNkhC1mFGmSWkJDZS7yBMJ6wSV0v+xbk5dE1fvxZKih
 tOwfRRIt3rJjJ/qe1MTS/w/sBj/kgufIUIVcj/LWIUauntmeFN2I5ULREWB2vL/w2sLMp1duuyq
 SPI70X05lJBsImc/cD0jkC2s/nQsD7IALtbmWqtx+Osdu0QqOw3ECvUtMzStfjB37xMw==
X-Received: by 2002:a05:600c:4ecc:b0:489:2005:b36e with SMTP id
 5b1f17b1804b1-490428c9564mr419979545e9.19.1779957562328; 
 Thu, 28 May 2026 01:39:22 -0700 (PDT)
Received: from m17.home (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45edb4bae01sm12022939f8f.0.2026.05.28.01.39.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 28 May 2026 01:39:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Andrew Jones <andrew.jones@oss.qualcomm.com>
Subject: [PATCH] mailmap: Update email addresses for Andrew Jones
Date: Thu, 28 May 2026 10:39:20 +0200
Message-ID: <20260528083920.33105-1-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

Cc: Andrew Jones <andrew.jones@oss.qualcomm.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 .mailmap | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/.mailmap b/.mailmap
index 6335fbd6c84..1ce5e6c5a14 100644
--- a/.mailmap
+++ b/.mailmap
@@ -76,6 +76,8 @@ Aleksandar Rikalo <aleksandar.rikalo@syrmia.com> <arikalo@wavecomp.com>
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com> <aleksandar.rikalo@rt-rk.com>
 Alex Williamson <alex@shazbot.org> <alex.williamson@redhat.com>
 Alexander Graf <agraf@csgraf.de> <agraf@suse.de>
+Andrew Jones <andrew.jones@oss.qualcomm.com> <ajones@ventanamicro.com>
+Andrew Jones <andrew.jones@oss.qualcomm.com> Andrew Jones <drjones@redhat.com>
 Ani Sinha <anisinha@redhat.com> <ani@anisinha.ca>
 Anthony Liguori <anthony@codemonkey.ws> Anthony Liguori <aliguori@us.ibm.com>
 Brian Cain <brian.cain@oss.qualcomm.com> <bcain@quicinc.com>
-- 
2.53.0


