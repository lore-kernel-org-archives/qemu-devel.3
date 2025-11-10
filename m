Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC943CCF9E3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Nov 2025 11:30:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIQ65-00010N-GY; Mon, 10 Nov 2025 06:30:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vIPnb-0004yT-2s
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 06:11:15 -0500
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vIPnY-0004Kv-Sr
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 06:11:02 -0500
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7c69476dd8cso1664242a34.2
 for <qemu-devel@nongnu.org>; Mon, 10 Nov 2025 03:11:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762773059; x=1763377859; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lvsOBqCyaXq+KZ7HS8bgLDho+xbN9ehkciU1Z30bu94=;
 b=KlgB0P3Ahlm/hTNSiQxwUZPd0/VjUSFyjTv1RsYUcg6eI21//GB01gz+v0wlmVCxT3
 bMWhCOKGZxAv69mr5bj8k6agQPRSRizMP0Cd6AaKaziDAjpPzaiift465hs0vhsUHCw/
 nH3Oa0DYGn27tmAxulWeXiiC1R6E6iLUaS59QbjYWjkNZV8tAvhwPY+nSbJqbEdJOyXg
 T4MZJ6wPf5sDxkRFzqekSWYuoYnSwb9/McZ0KDSpd7Ro56h8t094cDX/QPKrm1Yb9LeJ
 aNIgvAAJABeHP2YW0vN/REv9X8v97YlOBBsGwY3nJUxKK1iB8aSM7PHv/GyWNdtrqsiP
 g1ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762773059; x=1763377859;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lvsOBqCyaXq+KZ7HS8bgLDho+xbN9ehkciU1Z30bu94=;
 b=JuoGHAHzvDVOqqUByIWIpPiUolnjunMWe4BFHk92BTFIYs2hr6y31x1KTdjD0ILW1i
 8x7oSb4fenrR9yUzOOZUg5q/LTnJhEfdTqAo7mJSj7fbjaUWhzIR/+bCTIt28bIUcJ5R
 yJ/3jE1sJSyL+nOiTe1NhrdRJUA9eQbi42sKvrDeDveuWHArWZZzFMTySwXM6WMQjCXD
 Bd3nWvkIP/2qaoCi5nIBlcgpz9iNltbV0OONe8V/eM/mfG7lohJq2mJ+f2SRXa6JGUB3
 HPDIwD7G/j901l1TXmO4lz16WpfcV4XGnKZLbHm2ns2YGMWCEPgpWU52gR/3mkO4MyOg
 Gvsg==
X-Gm-Message-State: AOJu0YzSkzMzj0O4hE4t2yLYUyfemqMqG/2PYL/+wecA41h96VUbrotS
 q4MfXHx/Npt0niW1olhAffVuB5L94gorJieAOUYzYkoGCVZ94k6cnr5dD1IqTkl2zcAFX/MalRf
 sfkvw
X-Gm-Gg: ASbGncs/+mOqlwWUE9WAUc/pLQFkPtwZNhn8wV3onJZUlSK5syDkvDZ2PFYpMUSQl8u
 KrExhaTAIqmolbg6V++ZJweZPv2zggOdunlnzxxp4tYHdn8D7zF+WDIrGDnHrGTUHuNF3dYPi6n
 htnnomBLIst8K+TkUNSh3zLrQD7bZ3pD9x26gDc+2UNeopb3f2uH1nlVZpPqh8Nz/lDW8GynsWK
 23FYO8aPLmjc7ChLAb9hVTSdUBdGNk7sM5GzK/Bhhg4vU4zPvOeVFx8eAQ8CW47F2e4JDF9amSg
 ouDf65p/UcOh6ie2kPrbTmWFM9enZER46iqjbz5RATWMQeGl+/C68wc+gfF9sYpL6e+ybWxKwgy
 0+X7N6Ymfnv0mIER6u3dp71h5xdB7aSUuO+fbHNeCVJNx4F0wT2w26g49nCkEZ5bH+YFNKL8+CB
 lMMTH2Zhm8Eo8VxMZsCtK7EYxXv8+lR59p2Nw1157/KNwG5+bvdfE=
X-Google-Smtp-Source: AGHT+IHF88HkT2jwJom7SfDisN674Csk560vQZ/Dpnb1Zgc+ulvOjwULMHhLu1uM17bmaMnRQIY8Tg==
X-Received: by 2002:a05:6808:1803:b0:450:47fc:f21f with SMTP id
 5614622812f47-45047fcf6e3mr1778338b6e.37.1762773059594; 
 Mon, 10 Nov 2025 03:10:59 -0800 (PST)
Received: from stoup.. ([172.58.183.226]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-450426be56dsm1603412b6e.18.2025.11.10.03.10.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Nov 2025 03:10:59 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 4/5] tests/functional: Mark another MIPS replay test as flaky
Date: Mon, 10 Nov 2025 12:10:44 +0100
Message-ID: <20251110111046.33990-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251110111046.33990-1-richard.henderson@linaro.org>
References: <20251110111046.33990-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32a;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32a.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

When disabling MIPS tests on commit 1c11aa18071
("tests/functional: Mark the MIPS replay tests as flaky")
we missed the 5KEc test.

Reported-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20251104145955.84091-1-philmd@linaro.org>
---
 tests/functional/mips64el/test_replay.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/functional/mips64el/test_replay.py b/tests/functional/mips64el/test_replay.py
index 05cc585f85..e9318448fa 100755
--- a/tests/functional/mips64el/test_replay.py
+++ b/tests/functional/mips64el/test_replay.py
@@ -40,6 +40,7 @@ def test_replay_mips64el_malta(self):
         '75ba10cd35fb44e32948eeb26974f061b703c81c4ba2fab1ebcacf1d1bec3b61')
 
     @skipUntrustedTest()
+    @skipFlakyTest("https://gitlab.com/qemu-project/qemu/-/issues/2013")
     def test_replay_mips64el_malta_5KEc_cpio(self):
         self.set_machine('malta')
         self.cpu = '5KEc'
-- 
2.43.0


