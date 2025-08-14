Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3183ECA0EE4
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Aug 2025 17:15:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umbWD-0008LF-Jy; Thu, 14 Aug 2025 13:13:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1umbWA-0008Kc-Rq
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 13:13:34 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1umbW8-0001oX-GW
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 13:13:34 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-45a1b00a65fso6104125e9.0
 for <qemu-devel@nongnu.org>; Thu, 14 Aug 2025 10:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755191610; x=1755796410; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Neh9mAADoZDyd4Cs2hypuhX5IvgeEVyNjiT+RnLWFZY=;
 b=C9ETrMLNqzGwF1FYdjGsfP5JjTP3E7Pf1Y5cWJMQTc5qrG4gAiEQPCWDtcfO2J1v+r
 Ziy1GCudwvnGhQhWaLmd+Has9F61ZqPQrFxLNn3339o8IP3gQIMyiOLbLqxx1m+hEgZr
 GbpBegQnAq6hahvEWqdT4NldS6wniC+Wk5XcbgN/uI3jaOLbi8eCa118K75sfzfZhuY7
 loWZMtGoVfCbtDUwCC9ed1zYSDzq2/0SVC6YI1tucmmC+MgenyMXb+uuLw9vXv/q+UJm
 /xCRRZlQfS6f4zgPZw+Z8sC1UKxQsmu73q3jLzvshxV4VnrJgyelEOTwnM7AP4Endz8B
 jUtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755191610; x=1755796410;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Neh9mAADoZDyd4Cs2hypuhX5IvgeEVyNjiT+RnLWFZY=;
 b=oRXlMyqbpFmmfVOsNXfCoYfZeRE4WPJuyU3+i352QCYoWvn92uqQYnIQZL9qjeJmcb
 rl9neMcb7gBbKlq3g4SKOy9NgaQJt0Ta1ZJyKGze/wYaBN53bwi0TVwzxXsaga/auNUi
 BRNqn3AJjmdHh1bcGlSCbhvQmu31nYNYP6jmTLdOIpeY+kqehZDTiRN5UHHqc4BDAW59
 8idduw/BvnG5kdVC7MMJ2oKFxZRlAqAzLpcQAo5289PPOy5MsJnMPC1G73w5vEOMfJ9R
 /Xu62LeIrXZ12kKgtOhMqK2hFI/BN2rXgbkEOEOgJ4vmPGrbbDz6Y9Hw55PcnYyZGvG+
 wriQ==
X-Gm-Message-State: AOJu0YwCxKBwUdMOWvXrpJoxQ7sR/kbnpjTgoajhoP3xRCX7MhRqf3kb
 s452uKhjanYTgARg4L9fdod9v00xedauWbZk++pYxUd7M12EZSYdj4i1zBOtiKJLIwdtjjgA9eB
 50Y0e
X-Gm-Gg: ASbGncu3knelOZ+8QdI+oYwp3B+2ng9PagnrfCdgIPBGxhuwojZ74mL5fTr7q/RAnJT
 h5pWbEAMUVl8HpzE0oCgzISLEa2K2mHaRjlstgnGtV6uvm+AxuyGeLUz2w4cBa0f3NCoyaufWnp
 dNFjsgw9ofeEiFcJ+DofWddTXecSm4y6+dOY+QrjJZmYfVW6GociVearbD1Mwu0dPOv+BlFMxYI
 hqgl3ZYtJTJm2RqMpKXwpnTDkdEjFf8oU1wuiiVBGcGj628ZxQQZFuuIqprMeq92akFuDviU0MG
 K4znN+p6VCsmiKUf7Y7k0abK6xJBqD3IHUhoj7ugPteoHAjo/EkY2XQfvdenSE8TMgEDmKRRshr
 trJBXem0b9HDWQrvNu8hfdw/AEAhe
X-Google-Smtp-Source: AGHT+IGEzDHY9svbzgmFQm54ULenG4qYfSCxDV8gFj7YnQ5URQKfmLK9U7hz9MhNtpzVk8wx4TtkdA==
X-Received: by 2002:a05:600c:5486:b0:456:f00:4b5d with SMTP id
 5b1f17b1804b1-45a1b649a68mr29197455e9.22.1755191610368; 
 Thu, 14 Aug 2025 10:13:30 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45a1c76e9basm29489165e9.21.2025.08.14.10.13.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Aug 2025 10:13:29 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	John Snow <jsnow@redhat.com>
Subject: [PATCH for-10.2 4/8] scripts/kernel-doc: strip QEMU_ from function
 definitions
Date: Thu, 14 Aug 2025 18:13:19 +0100
Message-ID: <20250814171324.1614516-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250814171324.1614516-1-peter.maydell@linaro.org>
References: <20250814171324.1614516-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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

This commit is the Python version of our older commit
b30df2751e5 ("scripts/kernel-doc: strip QEMU_ from function definitions").

Some versions of Sphinx get confused if function attributes are
left on the C code from kernel-doc; strip out any QEMU_* prefixes
from function prototypes.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 scripts/lib/kdoc/kdoc_parser.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/lib/kdoc/kdoc_parser.py b/scripts/lib/kdoc/kdoc_parser.py
index fe730099eca..32b43562929 100644
--- a/scripts/lib/kdoc/kdoc_parser.py
+++ b/scripts/lib/kdoc/kdoc_parser.py
@@ -907,6 +907,7 @@ def dump_function(self, ln, prototype):
             (r"^__always_inline +", "", 0),
             (r"^noinline +", "", 0),
             (r"^__FORTIFY_INLINE +", "", 0),
+            (r"QEMU_[A-Z_]+ +", "", 0),
             (r"__init +", "", 0),
             (r"__init_or_module +", "", 0),
             (r"__deprecated +", "", 0),
-- 
2.43.0


