Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5136C3ABAC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 13:02:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCHrT-0003QV-Sq; Tue, 06 May 2025 08:57:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uCHrO-0003Lj-RV
 for qemu-devel@nongnu.org; Tue, 06 May 2025 08:57:22 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uCHrL-0003p3-Bn
 for qemu-devel@nongnu.org; Tue, 06 May 2025 08:57:22 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5e5e0caa151so353663a12.0
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 05:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746536237; x=1747141037; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xmmx2H+LdPuwPpPfTDalf+G1CH5iRie4jXtiEjHdkxA=;
 b=tZs78EvooNHtfPJJaxiTgJ5RqoeQqYKoKTtycd9a2f/6oBMzU+YS0GDD7Fuetl2AUz
 HYKkfGUHb1G/om+gIplMBx+e2SzxfI3NRoL5xjG6V5OQiheJOJdlgT6swdIEI+3XNzPE
 8ocLKvxJXWAAXPeIMP//FHa1NRaxfh52GliRYgmA58hRkuHPUtFHbkLuPWdhxaeJaJDV
 CPhXXk2w0P0aJHQXenwyzpeHT4qnbFoor83dFLW8OeN/Kve8tkS4prg3JKStZVOtBjJa
 e6tZssy5w2Ou9o88eLBSghXkwg0C8+R5C4J2+YQLBFa4gZH/JUFaY5gixIBkm7t1COoJ
 i4gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746536237; x=1747141037;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xmmx2H+LdPuwPpPfTDalf+G1CH5iRie4jXtiEjHdkxA=;
 b=ZNG/GwifBWtlUkPUP7HDAtVvZCG3Cb0le3X2ADMASLqqgY/w1K5/5Piym/XjzAFxPN
 TeP/r0iMTVDxaNtUFjD5Zf2IHivkdoyrFCkzgEzNaWUPRSJxHeBm6CmH6VET6qSXw0IV
 3cYxgu/Khgm177JrOwFMV40HDUqsv3PU2FZh7NU6rTnbubMpCl7y4lRNGdJtB6aoTzR+
 UGMpvGBRaOLBke8R25IBpgLnxNDdLVyz5fCU1NaHy86Es058vyBhRRJnrpTqvQRX7nqa
 XU5skIQ7QseYfbpfBuzuIbsIDfq+L3SR82F6iPEVQoqKVZFfMXn4NLmD0yP3NF5E0hOT
 lwtw==
X-Gm-Message-State: AOJu0YwXRUcDOcT2YCGdoJXmekpaKCqXc+uT1Qyx3wjdDfIgLR4AJvt0
 tqG97L9FiFv8L3HtLWzQKlv6nR+g96mVb5UFiI5F+tuzcJ8AUSOwU4tNW1ymBXw=
X-Gm-Gg: ASbGnct4xxHEvdgbv9YOK8EDZzwHWpi2ltgKlb71+pb9L98ZVa95U/laTISHgwcZ7TJ
 07HJ7/fe9We06R01DK1vT7Sl4NkTOxjuX2Pi9QCK5FDpdSlbnPyz7hpqTje1rZCehfbuZlBTuyX
 upCjRK7z4oLVmxfFfgeRkH7B923/C176lRWeRUhNFvku5oaGYch+vj1z/BRf6KkIuKVk6c1DdZK
 WyZv8/Y/wEtJi2Un/izNV+PqQBf7N2CldM6FmBF82mpETFLmB30tKw2M6SjXDGpdTWrIgalXdSW
 tRtIS9Luk1fGxpCWVlZD0gMAiZd3TFpUvVvyc1mFw2I=
X-Google-Smtp-Source: AGHT+IGko9GfzrlLwI3TZ0Z4X3jop6RnSubKonMdlT8N6sh6w/haMXIrHhtaUDOzf/D5EaOxn7t62A==
X-Received: by 2002:a05:6402:13ca:b0:5e5:b388:2a0d with SMTP id
 4fb4d7f45d1cf-5fab057ac43mr8713854a12.15.1746536237215; 
 Tue, 06 May 2025 05:57:17 -0700 (PDT)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5fa777c5c3asm7512193a12.21.2025.05.06.05.57.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 May 2025 05:57:16 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 478CF5F9E0;
 Tue,  6 May 2025 13:57:15 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Hildenbrand <david@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Laurent Vivier <lvivier@redhat.com>, qemu-arm@nongnu.org,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 John Snow <jsnow@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>
Subject: [PATCH v2 02/14] gitlab: disable debug info on CI builds
Date: Tue,  6 May 2025 13:57:03 +0100
Message-Id: <20250506125715.232872-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250506125715.232872-1-alex.bennee@linaro.org>
References: <20250506125715.232872-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52c.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Our default build enables debug info which adds hugely to the size of
the builds as well as the size of cached objects. Disable debug info
across the board to save space and reduce pressure on the CI system.
We still have a number of builds which explicitly enable debug and
related extra asserts like --enable-debug-tcg.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 .gitlab-ci.d/buildtest-template.yml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitlab-ci.d/buildtest-template.yml b/.gitlab-ci.d/buildtest-template.yml
index d4f145fdb5..d9e69c3237 100644
--- a/.gitlab-ci.d/buildtest-template.yml
+++ b/.gitlab-ci.d/buildtest-template.yml
@@ -24,6 +24,7 @@
     - ccache --zero-stats
     - section_start configure "Running configure"
     - ../configure --enable-werror --disable-docs --enable-fdt=system
+          --disable-debug-info
           ${TARGETS:+--target-list="$TARGETS"}
           $CONFIGURE_ARGS ||
       { cat config.log meson-logs/meson-log.txt && exit 1; }
-- 
2.39.5


