Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D166F3C9A1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 15:54:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuuj6-0003jQ-Pv; Tue, 24 Feb 2026 10:53:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adamhet@scaleway.com>)
 id 1vuuj5-0003i6-4q
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 10:53:31 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <adamhet@scaleway.com>)
 id 1vuuj2-00086Q-HK
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 10:53:30 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-4359a16a400so5028909f8f.1
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 07:53:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=scaleway.com; s=google; t=1771948407; x=1772553207; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J99vWbO+OMptFve7tCC13Qkd2jDgRuTvSKUDgtl9bDs=;
 b=hO+otsLQSi8sSBBSN+ZCa04LIjkcNM9fZCASKUfBScZbQS2srC0c3dbvGfwWyx4Q0E
 NkfgJmIjqzisSJbJp3NJ1DtUsUpzldsgKQY1IUfIEU/h1e+yL4D1QHpv+hG+/EnxDfHK
 UxvNE7lfVodcjtjlI63My5vEtbfEGq4s/Xi2jRp+f5WBTpwUhpD2J8Ywf6wov8OVMo7l
 +EfdtQ+DpVV2NRrXccYw6Dd8jdmgN8/4coeAKAPe/y2E3EXR9J5qVpqdGFWoafmCCdW8
 fy1n9NSD5RIjswLT0SNKER7x8OQZSWx5odpMMkWs44tk99YUSfIsW2oLOLQsGsvM2qKj
 kRsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771948407; x=1772553207;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=J99vWbO+OMptFve7tCC13Qkd2jDgRuTvSKUDgtl9bDs=;
 b=fyBKF27MUYf9AS1s+ezoyxT75r4zWgiVUOG5TjWY7UT8JeMJuVzFOCqv3SVb7z/Ns+
 8XmvpTEITlUaQe/Zzu4ssTOmgaySWwkQqeVi4AkRCw8/Uz5MlqGno4wGTYjEsMa1kpNR
 5hlCXXggrSc8Ta2ACs0OS6SG5AE9aiBKKxQ4SHMJ4JZQyKsbPDTpnQk+hIIyzA+d5UWx
 ltp7MiNt8asm+p+RLwsq94iQexI4XUOVzbTQ+uGH6EUe3DE+kmu32DUmShCbUdcJ7bWp
 dWrvftrdIL7dKZalmEeREN6BxtCjfBooKarQf8sHNLkfWv+KCUZac3v4cqeemT+v8wkq
 waaA==
X-Gm-Message-State: AOJu0YxtXtJwK4qi9EVtq0g13RlHV7XCoSz3fdIxBIgTuqs/eZFPJTHK
 bL2g1KrfhpbthTIFVNjYxKI3Fw1bYeNr+GDpICiOf2ViPD1rMehRh7C9qkfrIRHClJ/B5EWMN50
 gZCUh
X-Gm-Gg: ATEYQzwTd2/raSPAiR0EDQtHZOAkoet4lHMGZ/RTtadwjbfgCnWhwpvdQxntv1cnUKu
 ND3Vi0exnjFBI7ZVUiZIhLkTm0b1j3dusG1q5mYqdtOd1+5+Q6Vsbw/APDe80COiB6dRiNBzPuy
 BI6fGoXXDjZe/jjyHpHgZwgqDhWM7030TdFy9EIsWZrstyDNtajdoIKyRvSbrPqoCpzQ9iB6PO3
 Sk93/2N6Xiw/5UzI0B129adVAeuRPYhFfxLT3c38oiz+B0VMJxSH+YnRE6MdVnmVZYoSzwCPXZu
 g2YG9RbCZxFuAN7LJUUvdMEGWgtVVdHQiiUmkSQ5kVDvkgXdY/Gj5JKVMWJ93cTIS6yAGLTJ/Cj
 ZVK1whIz6p09mALux6W2alUxK+AM7EMr7OewRqrgiqs9FrZyfhSXIvRjEqvNK8rW34/C1CauSey
 jhVfHn9XtK+lTXcUZRVVoQ3I8=
X-Received: by 2002:a05:6000:3107:b0:436:34d9:4627 with SMTP id
 ffacd0b85a97d-4396f17baf1mr22792013f8f.37.1771948406945; 
 Tue, 24 Feb 2026 07:53:26 -0800 (PST)
Received: from localhost ([2a01:e0a:e9e:c3d0:7a5b:f76a:6cf6:aac2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43970d4c96csm29621730f8f.30.2026.02.24.07.53.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 07:53:26 -0800 (PST)
From: Antoine Damhet <adamhet@scaleway.com>
To: qemu-devel@nongnu.org
Cc: Antoine Damhet <adamhet@scaleway.com>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
Subject: [PATCH v2 2/3] qapi: block: Refactor HTTP(s) common arguments
Date: Tue, 24 Feb 2026 16:51:30 +0100
Message-ID: <20260224155314.1658988-3-adamhet@scaleway.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260224155314.1658988-1-adamhet@scaleway.com>
References: <20260224155314.1658988-1-adamhet@scaleway.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=adamhet@scaleway.com; helo=mail-wr1-x42f.google.com
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


