Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2624C54E49
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 13:54:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhVEw-0001sK-M9; Tue, 05 Mar 2024 08:53:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rhVE6-0000yF-OJ
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 08:53:09 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rhVDt-0005yf-IJ
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 08:52:56 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-412e783c94fso13192975e9.1
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 05:52:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709646768; x=1710251568; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Qo1L26oNcI76C41AKC9KqnoX02ELXCqY0+XddiR1gdk=;
 b=Fd3pAAHCuNku85Ffdpd5V332juMm/Ul+/1O+FIc1ivmJGyEhCYo26NeERdPOg2eXGU
 3Hn/SArveE40vEIUISDkN3jEJRnPh5EArW6FlddK2IZeU/U95qD4qy5ETsysIU+Wr7wC
 7/r6cbmdg+hoUfWf8LTyw0z06t4GbuyET9sVFz2jX6Seocr6PtqP3jmQUp0zvt03sjMy
 cIzUMR8BId0hRMe0R8av9KNnyaFGF8wGtCujoE0eZYzh3EnnR34M0g+cXt4Rez2Kg6DD
 j3HamYT3gZV44sXLspheQIXLBeNBFtbOJC1s9ljPS/iSkY6dKNgQ92k6XUD+Ffncnnfh
 Yvmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709646768; x=1710251568;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Qo1L26oNcI76C41AKC9KqnoX02ELXCqY0+XddiR1gdk=;
 b=CyOhzsEAGRqxrVsxReZeuMkYsSgaKebXCvvIHgFMHniadaM+2t+DuAnY0i/UFoOYmX
 mcxVxe8A1fH8agQq2H0DKDiJJjfIwpAB8Pl4HnlyTQxJXdZ9g34NWIeB5RYI325D/Aok
 ng5jJQLB6paSd2yacHFqs+0QGuNjepXPnMKT+/vHkg65nvPyqIJyU3EggoeWnvw7rR2G
 HFmhjLPwU3XWbu16EX82I1gr5gxmyrKpU89BMhq08D59/m51W95LIbFtFW7UvL5XKIry
 oKCwD9yO4ttRihbg4iXCxa73WsSZLqBXPfMpEs22HsUi83Qw6LedmskM+ie9Q7HcLOZU
 q4qw==
X-Gm-Message-State: AOJu0YypXND3CDI8N2fdsiMTri/aPWaopnEuvGb/cQaO8cyyzAirVuAM
 8MdjdGMztuK9ooC2ub8UOMHlTvGnvjQFbhkvJr8h1qORMg7UmoVMAKYlJ+OO5Y6ATb3e5yqSxcy
 Z
X-Google-Smtp-Source: AGHT+IGDBzKouDiNBepXRThxi2xvp3tifkJjJqZSWYKvIg5mACroqcZ0+l/uaIB126kDSkJaBODy4A==
X-Received: by 2002:a05:600c:1c88:b0:412:e55e:8516 with SMTP id
 k8-20020a05600c1c8800b00412e55e8516mr3513452wms.12.1709646768214; 
 Tue, 05 Mar 2024 05:52:48 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 x3-20020a5d6503000000b0033e206a0a7asm11797532wru.26.2024.03.05.05.52.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Mar 2024 05:52:47 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 19/20] atomic.h: Reword confusing comment for qatomic_cmpxchg
Date: Tue,  5 Mar 2024 13:52:36 +0000
Message-Id: <20240305135237.3111642-20-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240305135237.3111642-1-peter.maydell@linaro.org>
References: <20240305135237.3111642-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The qatomic_cmpxchg() and qatomic_cmpxchg__nocheck() macros have
a comment that reads:
 Returns the eventual value, failed or not

This is somewhere between cryptic and wrong, since the value actually
returned is the value that was in memory before the cmpxchg.  Reword
to match how we describe these macros in atomics.rst.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Message-id: 20240223182035.1048541-1-peter.maydell@linaro.org
---
 include/qemu/atomic.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/qemu/atomic.h b/include/qemu/atomic.h
index f1d3d1702a9..99110abefb3 100644
--- a/include/qemu/atomic.h
+++ b/include/qemu/atomic.h
@@ -202,7 +202,7 @@
     qatomic_xchg__nocheck(ptr, i);                          \
 })
 
-/* Returns the eventual value, failed or not */
+/* Returns the old value of '*ptr' (whether the cmpxchg failed or not) */
 #define qatomic_cmpxchg__nocheck(ptr, old, new)    ({                   \
     typeof_strip_qual(*ptr) _old = (old);                               \
     (void)__atomic_compare_exchange_n(ptr, &_old, new, false,           \
-- 
2.34.1


