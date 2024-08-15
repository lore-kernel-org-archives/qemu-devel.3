Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D2B8C52D7D
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2024 14:56:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sebtw-0007jc-JY; Thu, 15 Aug 2024 10:56:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sebtp-0007Ry-VD
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 10:56:26 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sebto-00014U-4k
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 10:56:25 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5a108354819so1463705a12.0
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2024 07:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723733780; x=1724338580; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=En32C6zo6LeZ5uTVMpvZgvYVpJHuCehnEf43V3Hg1AQ=;
 b=OwGZ94Iur311OE06stnHDxZeOY1cx4qagGu/qWPg3uPaqp89vJ0aTWOeyupgLOdNgk
 CyNhfZLC7tg1sjFpp5s+s+WzVZPTko12ailpim6Hi/JDa1auGTwpEqeZTKYbiAKovEG7
 8Lp1zRK++J6BDim8hPyeqth6cHkSiGkDEWIWCIUWUN/tE+bB0+2MO5LYJeVJxbclsoN9
 gpwdQz4PrEm1Gn/xESd/wMMZlR5OaRRF+rV1tdsCTlzn7yygJCdHuC/n/4HCl0W4xcZJ
 n9HVOulhetybBTkwKv9dCrXHXULvABYbcUEGuqHybwgUig7F+Vdf5pnm4bJfsgPM7grg
 nTSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723733780; x=1724338580;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=En32C6zo6LeZ5uTVMpvZgvYVpJHuCehnEf43V3Hg1AQ=;
 b=joTRKE9s/r+KAfr5z1MkfrGIOpj6tckJVOsO7LcEdiAyIXk5uNFex1QCnEOL/nKCdR
 S3T1JFituX/sknbwyWeC2SG9XgbaGTSyBI7FMv/5tHp6WQTve/vk5d8zbWDkzov/k2dR
 vZ16OE1toCinoHvQ9NbMCrb4i/617omnBnigw+Vd3GkzxPkRaG+/mNtXGi/qK3xJVVWy
 FUkknH0FiykKSlrC64ABkgBgLLxk1ge+35nPt+V9jRf3NK5Tyyg4I8tjef6+qwH9ZcvL
 iMhpLmCjSFG6MjMDOjV2xOP6v8KKGiTBlaffiH9DI4kj3DYLhi7pKouG7ebakcysxgub
 JapA==
X-Gm-Message-State: AOJu0YyBPa5d7LLflnLoVdXKRhudpXUGM3oJm784qKnx5OrzA/Q/U1Hk
 cSDLMP8FreP5zDQaWIbN2t6pqyB32KlzVbF502P6nyNwr68mVYAPnO2PZUzBtYtxDCYOXIT1tSa
 W
X-Google-Smtp-Source: AGHT+IHG6SzE5+3gRWKDddS92cWtKaVDVLswkGSQNYH/QffKGbq+vzlIAI3YQr+uhM4b3GrkvfSQ+Q==
X-Received: by 2002:a17:906:eecc:b0:a7d:3ab9:6a5d with SMTP id
 a640c23a62f3a-a836705aae4mr404095266b.69.1723733779945; 
 Thu, 15 Aug 2024 07:56:19 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a83838cefe0sm113152666b.47.2024.08.15.07.56.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Aug 2024 07:56:18 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 646FF60295;
 Thu, 15 Aug 2024 15:49:13 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PULL 18/21] savevm: Fix load_snapshot error path crash
Date: Thu, 15 Aug 2024 15:49:08 +0100
Message-Id: <20240815144911.1931487-19-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240815144911.1931487-1-alex.bennee@linaro.org>
References: <20240815144911.1931487-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x536.google.com
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

From: Nicholas Piggin <npiggin@gmail.com>

An error path missed setting *errp, which can cause a NULL deref.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Message-Id: <20240813050638.446172-11-npiggin@gmail.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240813202329.1237572-19-alex.bennee@linaro.org>

diff --git a/migration/savevm.c b/migration/savevm.c
index 85958d7b09..6bb404b9c8 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -3288,6 +3288,7 @@ bool load_snapshot(const char *name, const char *vmstate,
     /* Don't even try to load empty VM states */
     ret = bdrv_snapshot_find(bs_vm_state, &sn, name);
     if (ret < 0) {
+        error_setg(errp, "Snapshot can not be found");
         return false;
     } else if (sn.vm_state_size == 0) {
         error_setg(errp, "This is a disk-only snapshot. Revert to it "
-- 
2.39.2


