Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAC84FEFB49
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 12:47:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvxFH-0006ue-FV; Fri, 27 Feb 2026 07:47:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adamhet@scaleway.com>)
 id 1vvxF7-0006sM-Oy
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 07:46:53 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <adamhet@scaleway.com>)
 id 1vvxF4-0001ep-Nd
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 07:46:53 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-4399dd8d7b3so585124f8f.0
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 04:46:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=scaleway.com; s=google; t=1772196408; x=1772801208; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6gaYJdfbi1zVa7h6egzBhs1mlyDjTkzG5UEwNdlb5xM=;
 b=GzX+Yj7j+t6kMW5R5FKr9cEaP7pkvtztx8Yez0/oWk2s2KcLauc12T6VQvdKXglxOE
 rlAXOyEJrUeRK6wYCWuaYytmplja07XH/QB0SRAKmCSBOPAIz3Q/ds4Tea8C9GqKBUBp
 lC/D1XftDylMaaNmaqDu1LCkBbNKXcs+NqOrFcbv2NMADqD0OeTwbMHks/kgIclomk9P
 5qYDsbCn1HsnnP8xqi1L0qLiKAGJcuXjs9MiqqUWxc5gTLESl0lvyVPR9uClFRHHHZiL
 1Drc5DvE3rd/e2Qbt4PC2QqERlebIrZh8iQtKTk7Fr4vHjQt0UkNQDQ5ITwnyqc7irYl
 mUVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772196408; x=1772801208;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=6gaYJdfbi1zVa7h6egzBhs1mlyDjTkzG5UEwNdlb5xM=;
 b=j5R5S1xdiTM2mAJ2ZhPoIy4NQL1UgeoCUDMKbRxzWGqCUC36A3/afil6PWYunn5Kus
 0fA40sGTR8DL9CezxzjIFaSXnaFL39qo1GsMPakO5jDhKPnRYfJ/pFhIdAGTeHd/KNIt
 1U3+NVncyomfB8esS0U/rmECMLrNE37vylb/+cd//84HDInsuoWbnF5NzV7PyQ6USwPo
 juDeqCGJLQo3gCA+BUEnvp9spTOiQhNSfQ8TQ26zilzkUXaUl/3jlo3bFkbKfIl93ula
 WCusCkXMCrrf3swuTXq0JTU+hpuIQcKZGVWg7tdk7/1iMnaHUwEWEg3mPH2XSZcSJP3Y
 P4eQ==
X-Gm-Message-State: AOJu0YyXGHq9CqC/3VoPKy38tqqy3QNqbsjnwSv3MlhQvxjKxw3yDRBn
 9nKQBvZWYllDW45B3HvBRqDMscWx8/S9ZjyMRq19hAbYPduuYko+0GzdPCyHeMsmfU0=
X-Gm-Gg: ATEYQzwoXVbEl5DFTPxbxvHDvnSJiMD7+FxyJaG4Bn4v5FwPlKilL5m660pm3Pvi1FT
 joAl5sFWC2MRx11ZsMM9ftS/vvsLmor+ENT3PS3zu0Y2Hj0tP5YbnE/Uuc9RWqQKs+J64AJmuYv
 M9OOSECxYtjgno8kCrl9ngiuuYtUKV4vapnwQRKkSK4WY+yYUPpgUQUeLP5JZrzu3z3m3pbR1Jx
 RJhWd5ztW9m6JDklYQONvK8vy6ARugMys/pMQq52yQK30zkzDQClxmi06yk1Zoc828+jViftMWj
 gQiLSiJwyaE4FCoIzebaJZOyPkPbq4OXlsb4Rx+ZNuhSnwCoGCVAb31+m9Qloc3qFepZb7sKxNr
 zw2OGJUb3WbNThSdJfVq9Gn6bJZk20yJH2HzYSNdPHm/3ywkYiJ1kpeORa+7xSgTd4X2AxkrXMg
 U2wdj/RYNuQ4XEGvYDm81UKONE2Jkee0ihcYC3w9whxZe1WhgZ
X-Received: by 2002:a05:6000:250e:b0:436:14fa:a3fd with SMTP id
 ffacd0b85a97d-439971fc709mr10542084f8f.24.1772196407804; 
 Fri, 27 Feb 2026 04:46:47 -0800 (PST)
Received: from localhost (710304585.box.freepro.com. [130.180.219.188])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4399c75b272sm6498399f8f.24.2026.02.27.04.46.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Feb 2026 04:46:47 -0800 (PST)
From: Antoine Damhet <adamhet@scaleway.com>
Date: Fri, 27 Feb 2026 13:45:52 +0100
Subject: [PATCH v3 2/3] qapi: block: Refactor HTTP(s) common arguments
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260227-fix-curl-v3-v3-2-eb8a4d88feef@scaleway.com>
References: <20260227-fix-curl-v3-v3-0-eb8a4d88feef@scaleway.com>
In-Reply-To: <20260227-fix-curl-v3-v3-0-eb8a4d88feef@scaleway.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Antoine Damhet <adamhet@scaleway.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1402; i=adamhet@scaleway.com; 
 h=from:subject:message-id;
 bh=ohTVUeEtivMPCvMY4Z1W58yowQAP11aeY+udzyn2cms=; 
 b=owEBbQGS/pANAwAKAdwJoy885Y8+AcsmYgBpoZIv/++BUr+amfRaChsOdBRP5d/awNL6WF3b8
 BtfHKiQLUKJATMEAAEKAB0WIQQCubVZtDHYaY6x8XzcCaMvPOWPPgUCaaGSLwAKCRDcCaMvPOWP
 Pp33B/0V+DhO9ljGe2Rwm19Zc6uyeBa/d7I0Z0gv7PHgSrdBCo1/TWxS5FAb21wi1SjHhwd9hlD
 dj4FiBXyXuHy1BWsjr/KtEYoKA7FzUiWGMfVmfKiF5hSt+j61wbeimjckyGBNQD6Tncl3JYOEE1
 nWEKGd3vjgvoCWxFTilTX/dH85lWSk3BoltQZZNBO3fBZHK1vWC6H3xDGRviybB9vzSQEjC7GqU
 UeVB6Nf3eZAhHYsdwPQ0hvbtOHvANQtAvWbDNg8a7w66YARMdKTAL5JRkvhzdMOw5T2VgUhV0k0
 4DXXcAS3d3p5IvH0o2eMUgmZNvav7mA2Yd4yZ3EwDmu7WBbD
X-Developer-Key: i=adamhet@scaleway.com; a=openpgp;
 fpr=4C3AEF45D70C65052D3F37E02A5F5236CFB70DEC
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=adamhet@scaleway.com; helo=mail-wr1-x431.google.com
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

The HTTPs curl block driver is a superset of the HTTP driver, reflect
that in the QAPI.

Suggested-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Antoine Damhet <adamhet@scaleway.com>
---
 qapi/block-core.json | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index b82af7425614..a7871705fa69 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -4595,23 +4595,14 @@
 # Driver specific block device options for HTTPS connections over the
 # curl backend.  URLs must start with "https://".
 #
-# @cookie: List of cookies to set; format is "name1=content1;
-#     name2=content2;" as explained by CURLOPT_COOKIE(3).  Defaults to
-#     no cookies.
-#
 # @sslverify: Whether to verify the SSL certificate's validity
 #     (defaults to true)
 #
-# @cookie-secret: ID of a QCryptoSecret object providing the cookie
-#     data in a secure way.  See @cookie for the format.  (since 2.10)
-#
 # Since: 2.9
 ##
 { 'struct': 'BlockdevOptionsCurlHttps',
-  'base': 'BlockdevOptionsCurlBase',
-  'data': { '*cookie': 'str',
-            '*sslverify': 'bool',
-            '*cookie-secret': 'str'} }
+  'base': 'BlockdevOptionsCurlHttp',
+  'data': { '*sslverify': 'bool'} }
 
 ##
 # @BlockdevOptionsCurlFtp:

-- 
2.53.0


