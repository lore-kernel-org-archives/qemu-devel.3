Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1FDBC3DA7F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2024 14:50:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sebnD-0003po-Bv; Thu, 15 Aug 2024 10:49:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sebn2-0003Ox-Bb
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 10:49:25 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sebmt-0000Bj-Vz
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 10:49:24 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5b7b6a30454so1374660a12.2
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2024 07:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723733354; x=1724338154; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j0KEoUGEE33PJpI6PwWgjdeA/8L5WleKbgGt33xqUss=;
 b=zZzJPTzarqNEwQ1RpQppA5Hxhc04MGgLELH5DmkUOV1xUlruwLJL7T4AwBQEoJrLAA
 H3pykXNMDzvqoRTqhCVz2LxeMwj+lHHV4zn7YemNI+5tdgPVrkXVRpP3ZLLdmGRw7Of/
 BHLXD3nmsyprNjGrlCRjXTJaK0n0A9Efymx5gD9PrHp+6p+wxKdWHslqqSs2GY/njkZg
 CQYOc+zB+mqIe4V0Ds04NGhksscmvrz/Rnlt4aqSbRbRUM0tmKty188GtR+TSb3zgrR5
 0cZLNLh62O3U28Gj5CoBLE5jj4829/Y9Ls4C5CIMQfr2jldkr0o9OY/UXv7kFlhafybT
 Hy6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723733354; x=1724338154;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j0KEoUGEE33PJpI6PwWgjdeA/8L5WleKbgGt33xqUss=;
 b=iUg+kxc44TXlwLupiPzzq8/B4q85+4qa91WLQdq03szchCKtY06SGmcu1jWe7isxH1
 guQh85MCVAf8vDy3qr0KJ2r7yZ9LA/2XMj++gnQJC3WXwThs8X7N/3hoWlCQ77h2+HdA
 TRBCmrSBW4J+hZalDzza625YhG5N05u/esboJ4RQlveYVYBeQxSonzJ8HWPCV2DJmVCS
 Y2H40iPBz6h8iU4JjJsXclTujgVnxBnypZ7XbmDMFH/zYmIT85sw/Runs91SIuL5I5rt
 +yhb9m5dB3RArxQduTMNJX0XHIKxvJIFWf3EF5rNUTXxriNIwhJn6HTok/yIks4US7iA
 mOaw==
X-Gm-Message-State: AOJu0YykscIzrfHBrOKFsdVr/hwIPuhopBicsxwnD+xdQbHrD4RxdSHo
 S8fmLg+LiWPtqNQ9fo8JpPJrxYyG/8ev1pFxvZzKaavoWsc7yEK6Tkya3nDcsrk=
X-Google-Smtp-Source: AGHT+IGKdq69hkmoiG6snSkiCE57U90qx4iYFUKG3dKt5o6BvfrnbhJ08qXws8zZKFb9wit1pxorgA==
X-Received: by 2002:a05:6402:550b:b0:58d:81ac:ea90 with SMTP id
 4fb4d7f45d1cf-5bea1cbcf1bmr3062504a12.38.1723733353852; 
 Thu, 15 Aug 2024 07:49:13 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5bebbde7cd4sm985090a12.39.2024.08.15.07.49.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Aug 2024 07:49:12 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 00CF15F90B;
 Thu, 15 Aug 2024 15:49:12 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: [PULL 03/21] configure: Fix arch detection for GDB_HAS_MTE
Date: Thu, 15 Aug 2024 15:48:53 +0100
Message-Id: <20240815144911.1931487-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240815144911.1931487-1-alex.bennee@linaro.org>
References: <20240815144911.1931487-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x529.google.com
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

From: Gustavo Romero <gustavo.romero@linaro.org>

GDB_HAS_MTE must only be set if GDB supports the aarch64 arch, so the
test if "aarch64" string is present must be against GDB-related
'$gdb_arches' variable and not against '$arch' variable.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Message-Id: <20240804161850.2646299-2-gustavo.romero@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240813202329.1237572-4-alex.bennee@linaro.org>

diff --git a/configure b/configure
index 019fcbd0ef..a3aa257fd3 100755
--- a/configure
+++ b/configure
@@ -1673,7 +1673,7 @@ for target in $target_list; do
           echo "GDB=$gdb_bin" >> $config_target_mak
       fi
 
-      if test "${arch}" = "aarch64" && version_ge ${gdb_version##* } 15.0; then
+      if test "${gdb_arches#*aarch64}" != "$gdb_arches" && version_ge ${gdb_version##* } 15.0; then
           echo "GDB_HAS_MTE=y" >> $config_target_mak
       fi
 
-- 
2.39.2


