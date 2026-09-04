Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 255B7C61DD6
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 13:06:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2TaW-0006nS-Sb; Fri, 04 Sep 2026 09:04:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2TaF-0006YD-T1
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 09:04:01 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2Ta3-0003BX-Ty
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 09:03:52 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-c250c6a6a6eso132836366b.0
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 06:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788527021; x=1789131821; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=U7y/SyyYIbiLRfmtj7D11gXuwEFxs7AjnGg8HwNmBfU=;
 b=wwEEZJ9J4uKcm4epfLEPvC2NsVS4wEmjx+DkVAcGGhz1X5coJwBw9C5x4aGi44UqnI
 KegChHEFp+o3eYC/k9hbhQ+fKPPbQma6LRhY4lbLkj4oFUfWSRuWzmphA6GBgul9Y7zi
 /RlkGsTNohRsCo1mJz8NcR4r8aPmujGlcS1Y9q68hTot3YfMIHkXnkcUFPq0Tv7vsinf
 pQSKeHX1zIlnYwNwu6F9nKd316BSu8kheWur4rW6kU11cYawbLtntEyKQmeNkuaXPhmp
 DlYSYKG0bk1zd7RK1n3SB0Qy0sebRIrwhZyX6CgPG3yrbIG1aqxVqHK5tg+H4mxmTGk0
 ByVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788527021; x=1789131821;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=U7y/SyyYIbiLRfmtj7D11gXuwEFxs7AjnGg8HwNmBfU=;
 b=iZ0sAoTYnUpT374S31yB0zuAfOW/qfXLB0nmVcgvy9h+bRcQhBWqHqeL3PjXTqXn7A
 v8SRcg4vvF/myHsyO6dy7BwAft6E62dovf4+Bk8iJTmrn2mXdmxchFEkvwVrTUFmp2tM
 CCrQvd6z/ZH70510/fLqMy9sowoJwVOh3cVKxdPGUz94G55s5dOzfUD7fv6T6I9B890S
 w+blkhCwuFsx02F+WHUOH6vW1bFoWHDmnY9ZMgClkUYUhTZfcV1uhvAC6Q/OPItmTWgF
 bByzlX56/udMdF+36CWO2nL3wxZUDTXjYj2UBC33GiNoYWoKOYD8Ufb72p8S/mXV44jT
 jCDg==
X-Gm-Message-State: AFuF++mUFfBE2+mDfMVrprqAmSbDyGEwCevj/sRxMLkhvAOd3GScfWL3
 n7MoQkBdViMqs2WaVdPtDmRLxa5O71Mij/l1uqJ/91qCMMWFLr8pPNrzBB1EngmJL5Rg7FsHTMz
 ufJuATDY=
X-Gm-Gg: AYBFou0OS/i3naJ+/F+oQL0uko0DaMzZYtLtc9rmgCSQofGaTFM7K48gsEwWJ8yH4li
 B6yUikUjiyUXx281ioED2Pw/IrLFCTnM0TjHLOBXgWPXIt0dDwgQtQljQc68tWBNVGIQXqdCGIo
 eS8+SamBOHXYd8rdP0ALlitZLRFtchOjJF7de8GfHgNvnAJQPpBd5MSMFJSUj9GG8ng9g+BbOGK
 1ojbVrJVuMi6rZ6A3HE4705HT5ru0zem6a2vl8MbFKSwPoc1j1tpgMBJ4BDDw71UpHRmtaMp4sc
 CXLxOa8xif1aL/e5pUVW6uDJkwRByJhiOd2ZnrGj/fvinuz0GCjINZjIDKE4feVqybW//WExdZQ
 +Nbs55hqpduiHEdXeLH+/D4LInWvxDg3YTgfGZcACRbmiajVSUN9UOBzxotm2wAbupfYIiTz6CU
 aZaDyRWUTpadx5zQHkJ3KyKFxUYWpWdhRulT811DmiXdH7bQ==
X-Received: by 2002:a17:906:f596:b0:c24:47b8:ae5b with SMTP id
 a640c23a62f3a-c260cb464e2mr284942166b.22.1788527021435; 
 Fri, 04 Sep 2026 06:03:41 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485885b7bfasm6383480f8f.29.2026.09.04.06.03.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 06:03:34 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id AEA3661B78;
 Fri, 04 Sep 2026 13:46:10 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PULL 061/105] scripts/probe-gdb-support.py: add mapping for mips
 architecture
Date: Fri,  4 Sep 2026 13:45:15 +0100
Message-ID: <20260904124604.2207440-62-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260904124604.2207440-1-alex.bennee@linaro.org>
References: <20260904124604.2207440-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62d.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20260827221506.91574-62-pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/scripts/probe-gdb-support.py b/scripts/probe-gdb-support.py
index 43c70302873..da91c528ad9 100644
--- a/scripts/probe-gdb-support.py
+++ b/scripts/probe-gdb-support.py
@@ -35,6 +35,7 @@
     "Loongarch64" : ["loongarch64"],
     "m68k" : ["m68k"],
     "MicroBlaze" : ["microblaze"],
+    "mips" : ["mips", "mipsel"],
     "mips:isa64" : ["mips64", "mips64el"],
     "or1k" : ["or1k"],
     "powerpc:common" : ["ppc"],
-- 
2.47.3


