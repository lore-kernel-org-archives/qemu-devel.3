Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F9CDE7717D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2024 18:33:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKiXR-0002XJ-PO; Mon, 09 Dec 2024 13:31:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tKiXL-0002T9-Fl
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 13:31:15 -0500
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tKiXI-0006th-Cr
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 13:31:15 -0500
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-7259d6ae0c8so3963269b3a.0
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2024 10:31:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733769071; x=1734373871; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G1VOR+XcM8CwYRfbqrbxazmYwC9oKrYhK/MN/rkEn/Q=;
 b=zmtqe8GW5ta8RlCwnEZA3M7ZKbPyR17VUuvFkfGEavVzk71//1g+zxyPVTjPaJIWOY
 9ql0Knhb1ZjQTGTW9BAEKAYr7et5dhnw+IkxnnNCWNRINJPtPfvUKjxbN1oxueC8P4F3
 lTKXRo38UIj8ma8iOZ96JJXoAcE1edSk/jR3GCHg9vm+Lo+VWSD95/oiEM9XE8StLKFm
 oHj6+jkYXpJ/rgqMYPbDxGBxzXNsRwt73spUqdnxjr9ff+RdqXjf1NxvfNzbEDooQopn
 kZKdWy60Ef/Y8RwlOBBO1gjuo26+QEjx0y7FozNRbIO1Whb4YYXNMJzkR/EhLE11QUzy
 GRyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733769071; x=1734373871;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G1VOR+XcM8CwYRfbqrbxazmYwC9oKrYhK/MN/rkEn/Q=;
 b=fvSQJ4g7T4SaO53V/zxwTHbdsvCxCiIyeMDICnbKZWnxUta2fzFww+g42fNnC5MNI5
 nATM9eyxzg1nOWOWOw7JOpe+tv3ZWtrV+uwNPT2Jc55l4rBgwICPVt7okzUhApEBZ4bJ
 TGVCXosMOfIuGt0f2ET2N+rlped0kTesPzjlOP3/w9WF/o8RY28vB+UrOfyKlyFMp6G+
 6NgsTIq9mz6BNnUdF7cpiyUOKUwMgMTnB404wOlPTo8Zqkl0EjFKN9Ej/BbTXUr0NZ9v
 g+TlNmOG+Izly2iosb3hF/bEiK6JOXgz2rEvB4xr/CalOagTu0MDscHLBFs1BNFRpCmF
 bFUg==
X-Gm-Message-State: AOJu0YyJIFINZ4JclQ4BTTK+XevUALDS1m1kWCrTwFRDZlmCDq/lZePr
 stFl1J+XxirYoDaA79hwSHlwXHP/UAJoW8vDTR3b0nbsOPBxlr6Lvu2JqXY/mo3pEIuCtZ6kFgw
 tm0g=
X-Gm-Gg: ASbGncsuMEJQjh2UB6WlF0GWARh3NT0lzYh31wGndUmC9xSyI6gF67i1rwActIWWrL2
 4yXd8oabtjlUiHivpzxs6IXMhNTLE/DTqd6bMUc7RyPOSwBWBshQFabKJCbs0DrRUbSV/O/H7Yt
 v6dovB8A8wkUfXFfndkGVH4Qe8ceSOiBz5yonHl7sgL0tGiOe/2wG6WKpCT/I+OqW66NngkepXW
 DrW7XOl2VZwRVyncuAceV0qQ62lortJNvzT6hGatM6udmmDR4yEq4mwrKzLsaj9nBevoG8rU1OG
 //MtJDs7nLeH
X-Google-Smtp-Source: AGHT+IEXRHQmFLOcJlksi4NjoGEt2qTEb+UNr9ZNna4mBykL2R6hP0+kn6KJCVsSIaIz7h2XZ+rUlg==
X-Received: by 2002:a05:6a20:3d87:b0:1d9:c615:d1e6 with SMTP id
 adf61e73a8af0-1e18700f9d8mr20290552637.0.1733769071164; 
 Mon, 09 Dec 2024 10:31:11 -0800 (PST)
Received: from pc.. (216-180-64-156.dyn.novuscom.net. [216.180.64.156])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-725e2388d37sm3322821b3a.73.2024.12.09.10.31.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Dec 2024 10:31:10 -0800 (PST)
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
Subject: [PATCH v4 3/6] docs/devel: add b4 for patch retrieval
Date: Mon,  9 Dec 2024 10:31:01 -0800
Message-Id: <20241209183104.365796-4-pierrick.bouvier@linaro.org>
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 docs/devel/submitting-a-patch.rst | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/docs/devel/submitting-a-patch.rst b/docs/devel/submitting-a-patch.rst
index 69df7682c5e..65c64078cb3 100644
--- a/docs/devel/submitting-a-patch.rst
+++ b/docs/devel/submitting-a-patch.rst
@@ -433,6 +433,20 @@ For more details on how QEMU's stable process works, refer to the
 
 .. _participating_in_code_review:
 
+Retrieve an existing series
+---------------------------
+
+If you want to apply an existing series on top of your tree, you can simply use
+`b4 <https://github.com/mricon/b4>`__.
+
+::
+
+    b4 shazam $msg-id
+
+The message id is related to the patch series that has been sent to the mailing
+list. You need to retrieve the "Message-Id:" header from one of the patches. Any
+of them can be used and b4 will apply the whole series.
+
 Participating in Code Review
 ----------------------------
 
-- 
2.39.5


