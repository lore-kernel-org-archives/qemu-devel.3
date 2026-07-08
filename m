Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ED11C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 13:48:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whSd5-0000X8-1Y; Wed, 08 Jul 2026 09:47:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1whScv-0000T6-Iw
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 09:47:53 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1whSct-0002Ak-Oy
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 09:47:49 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-493ce08a75bso2861565e9.1
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2026 06:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1783518466; x=1784123266; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=uZc2nZ+Tmr5Dz8gM2fz3iabghKBK/nbqVsMhdHW8fV4=;
 b=MdN9l14nrlZIyC4OmkkifHeCnNQul1VVR1VQ+FfxTNvbaCbse9H6IRWtKwkSCEo3yf
 U6JJVhn2Fl/QbUTyCAINGuuSSpFixdwF8JpS2xZYUHFhG1TOKoCsT23mUXgX+ohCQpZ3
 D9SV8AXbiHIz2PjVpVJM0siijHhX1aHTCBQtw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783518466; x=1784123266;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uZc2nZ+Tmr5Dz8gM2fz3iabghKBK/nbqVsMhdHW8fV4=;
 b=RqcLNFCagMCeA7zuOm2QcH/XtfjVPGoNsvmtX1TaDlH0IVusvazv+PnlATXdCZJbc4
 fZxHYWo4mxAmX9AtBM5FrcftmMM/sHwq8WoMYb4enf846o0A4ES5Hxcu8qxz9EjZ0wwG
 wnAmhbSxTEObZoPUKEumObG07/CFBSVrYuPtjoRTiFmjL/bs3xFiol2OgtZUKUR3Keyc
 /1/yzHL4WPDkZGyiqCbz7O+tHVmmjJhNa30cFqauUpMFrrUCFfxzkwp8xf8NWB2WCGBs
 Yz5Y8hVQTj7l4snZAxZf9Dv4wQrowh9480jtnp4lgoamctBF17yCAev0WTza0DrlUzMe
 W5HA==
X-Gm-Message-State: AOJu0YwA3DRdOlreyrHW1M1tTvIMLuDa9Pl0aeevxQvwGUYZyBCqfXNT
 do8fFu9XlARo8wwQy5VwNLLMVXGfRog/jiwjnMNZE7jqZyZN8fKUCYxOQRHq4mf4hLBrKWgrmAh
 9JZyRIJAFUQ==
X-Gm-Gg: AfdE7clbh98alljWCx+2YlInEHSK6C+6mV9GYXlZduF9tSJOFqa4nREtdMyyUmmkClg
 9aR2xdB8wWkm2+wqbIdD7mzsXjP2qq/uNJwAOpfSW7tH1nZQb2u+VgfoKkE4tMQd/tnQsUTF+fr
 sy68m3l3+QDkBf2HI6QeN4HuVdjCGKgz02ch1H05dqdv7I/gRsoTFgd+nbbsbbL5FVBR6ISL5Xa
 uwfF3ELo9669wE/nsRy1fPSWDLlU4n7HBkxR81rCVN5UItYxE2ydxGLnrOZoAkH7oKqDvObiVy3
 MPhQzuTn9TczsBNVTlANFPQYvSgkWCWjGzukTeTQoWfaBuN30Iy3nJazhfIqcMla+ciGSGB+cad
 7brMo77otkxStGGWVtTHgOO4XKHrnBmqufU7Et4NB3WFm1r7+pK9KMoqVDmbrBLYJ74qz4hO2Ag
 xuJk16K1LXrno8g0Kp3k9JCyURzv11YDl21WlchO8f0tLOwtl3FNr5zcOjhaJ3sKffBM9Sivy4i
 +oKKk5QRro1
X-Received: by 2002:a05:600c:a010:b0:493:cfe8:5b36 with SMTP id
 5b1f17b1804b1-493e683c3ddmr30512195e9.8.1783518465627; 
 Wed, 08 Jul 2026 06:47:45 -0700 (PDT)
Received: from alex-laptop.lan
 (p200300cf574a7200d0fdb767a004b9aa.dip0.t-ipconnect.de.
 [2003:cf:574a:7200:d0fd:b767:a004:b9aa])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493e0f43912sm160910525e9.7.2026.07.08.06.47.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 06:47:45 -0700 (PDT)
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
To: qemu-devel@nongnu.org
Cc: Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH] mailmap: add email mapping for Alexander Mikhalitsyn
Date: Wed,  8 Jul 2026 15:47:44 +0200
Message-ID: <20260708134744.169452-1-alexander@mihalicyn.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=alexander@mihalicyn.com; helo=mail-wm1-x329.google.com
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

From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>

I use my company's email to sign-off patches, but send them from my
personal email cause it's Gmail hosted and works much better than Outlook.

It causes some misunderstanding and inconvenience for maintainers sometimes [1].
So I would like to add this email mapping to clear out all possible confusion here.

Link: https://lore.kernel.org/qemu-devel/CAAjaMXabXNmh1UZ5wnpX4wucnC+yWvMo2-jr2XBTby4zqf6CTA@mail.gmail.com/ [1]
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
---
 .mailmap              | 1 +
 contrib/gitdm/aliases | 1 +
 2 files changed, 2 insertions(+)

diff --git a/.mailmap b/.mailmap
index 593b6c2c534..0663cd7bd0e 100644
--- a/.mailmap
+++ b/.mailmap
@@ -122,6 +122,7 @@ Stefan Weil <sw@weilnetz.de> Stefan Weil <stefan@weilnetz.de>
 Song Gao <17746591750@163.com> <gaosong@loongson.cn>
 Taylor Simpson <ltaylorsimpson@gmail.com> <tsimpson@quicinc.com>
 Yongbok Kim <yongbok.kim@mips.com> <yongbok.kim@imgtec.com>
+Alexander Mikhalitsyn <alexander@mihalicyn.com> <aleksandr.mikhalitsyn@futurfusion.io>
 
 # Also list preferred name forms where people have changed their
 # git author config, or had utf8/latin1 encoding issues.
diff --git a/contrib/gitdm/aliases b/contrib/gitdm/aliases
index e26b00a71d7..f838768792a 100644
--- a/contrib/gitdm/aliases
+++ b/contrib/gitdm/aliases
@@ -33,6 +33,7 @@ malc@c046a42c-6fe2-441c-8c8c-71466251a162 av1474@comtv.ru
 
 # canonical emails
 liq3ea@163.com liq3ea@gmail.com
+aleksandr.mikhalitsyn@futurfusion.io alexander@mihalicyn.com
 
 # some broken DCO tags
 yuval.shaia.ml.gmail.com yuval.shaia.ml@gmail.com
-- 
2.47.3


