Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 792CBE7717D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2024 18:32:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKiXL-0002TL-MQ; Mon, 09 Dec 2024 13:31:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tKiXK-0002SN-9C
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 13:31:14 -0500
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tKiXG-0006tC-79
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 13:31:13 -0500
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-7259a26ad10so3814230b3a.1
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2024 10:31:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733769069; x=1734373869; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KJHfvwnJg5sZrvdjrL2PvGyTWu88t+rIUYQX6WpdBU0=;
 b=uF9rfbcB0FydaEX23+7mulF5rWb8FqWuB5OLO60rRbDq7+fXK6ZFwo+c4yDO3m5z3Z
 MoQ2Ep7QGxWV8HGr9AO3KNvp2zxqrMrvdtNYv5IRmbP4/jxbDUhO8f0ApqOoTaHwjaZD
 OswsE1ujaY9ukFe7EqHqLA/vsEAafUma/AbQ8BmZ+uFMgiLIQivthHtH7RqeTyt3toZj
 LIr66vaizIVRE9RPv9aQZF09JUxHWRD983HfscZS56eeeCgl/qLwmnKgh3pN3yu9cUHW
 Hh+6DQ+arGNbv8GKd6PI47Pvj93Mbz945DmohBc7yXVx1czjhwS1hkgweMqhbu6fTdSD
 abvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733769069; x=1734373869;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KJHfvwnJg5sZrvdjrL2PvGyTWu88t+rIUYQX6WpdBU0=;
 b=jaD5TUXOs/PwBiFLR8nXG64RZhsIjVd8BClYSO7VI0BE+7I4txD4Dq5FgZdYIIvuGe
 DGbBi5/62vv74CIu8a8DdfDqs+xc9bxeqXHtUjePv14dSWrrFKNbsqL+UllIHJC2Bkha
 jgrQV2tCzpBzXETiOrcyNVxjTfiQllHS4PZIEGzIQ3iTFaogbJpuWN9F+3XHdadote72
 OWk2rkwMsahi9gBJzLCMtMndtbpFJ/894QTuntFsUItUj2NMLHlbMXf7nTkhpCrL7YHQ
 jReh7Objm2p+fewa9vhs9WPULU5ANHQaoi/6OmZZ77yTwa8KONJPibv+dGGTAazPpFvo
 9lpQ==
X-Gm-Message-State: AOJu0Ywi1gQGkTUb1mCpDHNC9g+Wjqargn9F8mZoIdXl8K2EMHFEv57S
 cwcO+qv9Xy0UUYmeUtBZqgIY/fKMeWMa3jCkkeObdYe26CRbewwB+I6RwvqZUSpOFmp19BTJdWX
 WrPg=
X-Gm-Gg: ASbGncsvKt8z7ar4FOI4B8R9Ti5yoNNR98yvx9KFkW/wA9WVb8d3BmAqNff+7K1Tjpr
 pJhJQisY9C9ueuzPVubO2/gvDvmzcp8hTinJRU7w0o10bFcfnwbfVZuMUymQncQF3Qx1MnMhLlY
 kocBKWdCrYz9mVmpDsO8toqE/nxK1moI0QoaxWr7O1zkvr8riVA4IUPL2nrmBtj3EL09Rf6c51l
 D7I5DsEtQlBwKcj6HPEH3RR1kPDaoTq3WDh12piFAHbhNYQsUwLScWKIIMstefZMxNIclNd38co
 Az0QR9FVF7/g
X-Google-Smtp-Source: AGHT+IH0W32vCMU/REHgWwitNQj0RdYViGRDdgZtnn1QKAsNMZMXRkehKM+GP8TM3mJLL1QW2KCPyw==
X-Received: by 2002:a05:6a00:4513:b0:725:4a1b:38ec with SMTP id
 d2e1a72fcca58-7288810e22fmr752631b3a.3.1733769068840; 
 Mon, 09 Dec 2024 10:31:08 -0800 (PST)
Received: from pc.. (216-180-64-156.dyn.novuscom.net. [216.180.64.156])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-725e2388d37sm3322821b3a.73.2024.12.09.10.31.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Dec 2024 10:31:08 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: manos.pitsidianakis@linaro.org, Andrew Melnychenko <andrew@daynix.com>,
 Thomas Huth <thuth@redhat.com>, Michael Roth <michael.roth@amd.com>,
 qemu-block@nongnu.org, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Kevin Wolf <kwolf@redhat.com>, Peter Xu <peterx@redhat.com>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 philmd@linaro.org, Fabiano Rosas <farosas@suse.de>,
 Konstantin Kostiuk <kkostiuk@redhat.com>, Eric Blake <eblake@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Markus Armbruster <armbru@redhat.com>, gustavo.romero@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4 1/6] docs/devel: remove dead video link for sourcehut
 submit process
Date: Mon,  9 Dec 2024 10:30:59 -0800
Message-Id: <20241209183104.365796-2-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241209183104.365796-1-pierrick.bouvier@linaro.org>
References: <20241209183104.365796-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 docs/devel/submitting-a-patch.rst | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/docs/devel/submitting-a-patch.rst b/docs/devel/submitting-a-patch.rst
index 10b062eec26..03b2ac298aa 100644
--- a/docs/devel/submitting-a-patch.rst
+++ b/docs/devel/submitting-a-patch.rst
@@ -252,10 +252,7 @@ patches to the QEMU mailing list by following these steps:
 #. Send your patches to the QEMU mailing list using the web-based
    ``git-send-email`` UI at https://git.sr.ht/~USERNAME/qemu/send-email
 
-`This video
-<https://spacepub.space/videos/watch/ad258d23-0ac6-488c-83fc-2bacf578de3a>`__
-shows the web-based ``git-send-email`` workflow. Documentation is
-available `here
+Documentation for sourcehut is available `here
 <https://man.sr.ht/git.sr.ht/#sending-patches-upstream>`__.
 
 .. _cc_the_relevant_maintainer:
-- 
2.39.5


