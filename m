Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF27CCCD1BB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 15:09:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBaTE-00020x-GH; Wed, 22 Oct 2025 11:09:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBaSt-0001WV-1B
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 11:09:31 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBaSq-0001Da-6T
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 11:09:26 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-471b80b994bso53501055e9.3
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 08:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761145760; x=1761750560; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m3aV7y4YcVZL2/9uqMu4LmeCtyRFSnBcj1NtFojSaAQ=;
 b=mVqIaHGa2aJPN/JZj+ExEpHECZyGq6pxS8EAUC8B9iIx41NwyRDsloA1oHZ6j6OkZZ
 BLJkneXXpXVs0gwzs8Yu8c7H3HWH9PWLacsiUNvhX0KBr/nMRkPmrr95ow2E59GStPyA
 16xB5i4oWhpcJEbD1j9/p36+pwCXiLn6omQpVii1NtmtJ2yosui2W0hfarDWHB9KeUeV
 TvBjBkhURewzpXugI4DMgJlShJ+dP5/yZKq1YneL5ZTBlCMXaB6GK2ncfD1e2nM9BfXL
 JeZOhORSK2k0uBlEXLHx1+cGJzAQB77QWHhU+/iX9B/tqOz9jKN8mSW7llLmY/XyGQhH
 r/wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761145760; x=1761750560;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m3aV7y4YcVZL2/9uqMu4LmeCtyRFSnBcj1NtFojSaAQ=;
 b=LpQIQcNHKRQ4m8mNWfrM1uAWvSoIYvNXcHnMrZFNNDvYoqUTk87jcCNdczX7uBpkyj
 tSoJeLe1yhS5pj4suEUwxI8m0qHdZqcZEK1JxzRiUoea/4ObQmvgEQc7y753zXyw6DFS
 o1QcGsEi03jNaZXo1xK7xCB5zbhUp/doTprg0tPWSDTyuLULwYiS/xtP8AA3ZLPRnp6i
 HXbJ+EFN7r7B3EcBzRXu/PGBIJIAN7UqSMQWQBeS8VClEDWfkNUKV7n5hZ7x93z9pzc3
 4R0lpY//kLN/ULRcWiZ/PnB1m7mCNaqBVebwrsH4apSX7BvlbwLvLmy0ukq0psfezdzu
 Wd7w==
X-Gm-Message-State: AOJu0YzW13nFdfh+i5Aa+9izrPs9jHp+DOQVQAAxDpc8se8jR7Oln52L
 ISSNpngxB3I56X/f0uWorGMeO0TjA/HgQZc75OfCVKkrsa7YzWcfc2/x+YUPA8fyeYhu/al2h10
 erkgL7lQ=
X-Gm-Gg: ASbGncvjXNIh0F3CCZ5Cir6EDfbsmJ41woDM62gMprVICAitX/9NqfTvkWiUoc5aD5b
 xHLRu6Q8+achR4oCn0dX/uvbm9hF/j33SOL6dXMLhiji3mIP0Qo7vV57dQ8S4dU6aw+lBWt6v8F
 e21ASgpXc//Rcu5NmURfezCSw/cul97P1lFW2fp16t5Cc6761vC3xfwsCOhvLhS22cI27ynAWFP
 sAuM8VRLKiHQ22yFIgXggyjoVJxgnvpLdBYTu/uKPApcYXDnhOHmY+SHJp/kTp2VbjQhe80b9Vb
 4J8oFVG/+CJvsDORydaSVsrslZ7JNiQpzHWO4RuC09I5jRdRm3x3Eq2R4cUEQnh1Hk7k4y58I/9
 hWqrL/dHW0DP1FTkYBaItyH6Zd9vtbvtpKCetvSc3sJFOJYeIdOJrtMKeMhHYX5r/m7tCSgNMU9
 0sWjZdBPqVepa3KlpDnNiHdu4//WrYMYdW77MVhXxC9Ynj30qKa7CF9Hijiqgo
X-Google-Smtp-Source: AGHT+IHZTkyn/42k1QpoASnxIpnRuVbmrMEH5T+8YqNQhZwt6TdoxkPNnzfrhVdI2LMH31XVop9rpw==
X-Received: by 2002:a05:600c:1551:b0:46e:2801:84aa with SMTP id
 5b1f17b1804b1-471177b143emr158569685e9.0.1761145760568; 
 Wed, 22 Oct 2025 08:09:20 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475c42b4867sm47602865e9.14.2025.10.22.08.09.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 22 Oct 2025 08:09:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 8/9] chardev/char-hub: Retry when qemu_chr_fe_write() can
 not write
Date: Wed, 22 Oct 2025 17:07:42 +0200
Message-ID: <20251022150743.78183-9-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251022150743.78183-1-philmd@linaro.org>
References: <20251022150743.78183-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

When qemu_chr_fe_write() can not write to a backend and there
is no error, it might return '0' to let the caller retry.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 chardev/char-hub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/chardev/char-hub.c b/chardev/char-hub.c
index d0967c22336..4bbde9fb033 100644
--- a/chardev/char-hub.c
+++ b/chardev/char-hub.c
@@ -65,7 +65,7 @@ static int hub_chr_write(Chardev *chr, const uint8_t *buf, int len)
             continue;
         }
         r = qemu_chr_fe_write(&d->backends[i].fe, buf, len);
-        if (r < 0) {
+        if (r <= 0) {
             if (errno == EAGAIN) {
                 /* Set index and expect to be called soon on watch wake up */
                 d->be_eagain_ind = i;
-- 
2.51.0


