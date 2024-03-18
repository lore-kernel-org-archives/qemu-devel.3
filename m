Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6EA2C54E5D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 15:48:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmFDK-0004sJ-BZ; Mon, 18 Mar 2024 11:47:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1rmFDJ-0004ls-IX
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 11:47:49 -0400
Received: from mail-oa1-x2e.google.com ([2001:4860:4864:20::2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1rmFDE-0007vT-4E
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 11:47:49 -0400
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-222ba2a19bdso1130783fac.1
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 08:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710776862; x=1711381662; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1Yo6kstUG7IdEJmEbbwMKG5M1XxH4YUOFuFB6HSlPrc=;
 b=SvK3BRzWofyIPS8FSZLGZVIgVq6HCZZsytJwoQ4+92GZdIkeNZyU06CTbQZ/A2H7ZJ
 eIhBUwOAA+stGbvdd87GbU/aHNAYpKmv3w/gyYQa3V8yQT45oaPI9JWockTj266KWiFS
 oRoeyFfyFwgJGW3cm5d9Ust9qj79DC1jHzT4CMn/pyukTL06Kw59pkLravVFMmdqd8zO
 gR28AD5gWwjeWvULy6fZfaNkyd72DbAdqCYAQf4QloPidWFq0dGBXrEXtq07Wl+rsk2O
 0dtdfet8XhDUq4Tcb2chcmtNMxHZU0V0B6EF+ajUbrc+3/AccHDdVO8LBeEoPrvgngVJ
 j2bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710776862; x=1711381662;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1Yo6kstUG7IdEJmEbbwMKG5M1XxH4YUOFuFB6HSlPrc=;
 b=eNSpNyRuBwKsxoXga5dk/KiP29BEyLbMBCQJrS/mvRHDVYtlUq0YU/E9Wh3rbEXVcP
 tBt0YZ+gTw0H+6q954YieoI/mh7D38kx3fv8xPS+3kzMGwRbt0fth8RjWHLtNWkIhEMm
 TrsCkD9QC8dlR7Nm5W6RVfpmtSrPS3YjD8GuGheVEb+ADLmv+wSgISqSzcHNZq/zP3lo
 +xDyVJMLH6Q26r6R5eux1dow2JPQJhmwTNJkPSHy/olpq+gzojNw6G70qE+8NFGBlWO+
 bMMou7CdxQHlxrmKQHc7feeajoOrX4XGofh5AXqEyVXpaCs5YaQqgSDqub56aUYL6Fwg
 quFg==
X-Gm-Message-State: AOJu0Yw5Dj1nqdCXBw31+r/g+PRgA6MZIrsmTn3rKOfCF9yDA2Dcq0kU
 Et5LAAv0CI6xf6IympKAmf6TNxhLBBDivWqkN3grbzK/+9ODdAph+C6Y9lnPBjM=
X-Google-Smtp-Source: AGHT+IH+IwnNiNvlQCiSiva9/yzfqOpU/c2lNEBaIQAcEpu3btpL1kDwO+4g7/bqQgbBHcXolcriHQ==
X-Received: by 2002:a05:6870:648d:b0:21e:624d:56f3 with SMTP id
 cz13-20020a056870648d00b0021e624d56f3mr12881158oab.56.1710776862663; 
 Mon, 18 Mar 2024 08:47:42 -0700 (PDT)
Received: from wheely.local0.net ([118.208.155.46])
 by smtp.gmail.com with ESMTPSA id
 v22-20020a634816000000b005dc26144d96sm7332108pga.75.2024.03.18.08.47.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Mar 2024 08:47:42 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH v5 12/24] savevm: Fix load_snapshot error path crash
Date: Tue, 19 Mar 2024 01:46:09 +1000
Message-ID: <20240318154621.2361161-13-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240318154621.2361161-1-npiggin@gmail.com>
References: <20240318154621.2361161-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2e;
 envelope-from=npiggin@gmail.com; helo=mail-oa1-x2e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

An error path missed setting *errp, which can cause a NULL deref.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 migration/savevm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/migration/savevm.c b/migration/savevm.c
index 388d7af7cd..10c187dd10 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -3260,6 +3260,7 @@ bool load_snapshot(const char *name, const char *vmstate,
     /* Don't even try to load empty VM states */
     ret = bdrv_snapshot_find(bs_vm_state, &sn, name);
     if (ret < 0) {
+        error_setg(errp, "Snapshot can not be found");
         return false;
     } else if (sn.vm_state_size == 0) {
         error_setg(errp, "This is a disk-only snapshot. Revert to it "
-- 
2.42.0


