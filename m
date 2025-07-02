Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A90DC83F04
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 10:46:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWuwe-0006h9-9g; Wed, 02 Jul 2025 06:44:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uWuwU-0006ev-Qa
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 06:43:55 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uWuwK-0001J1-EA
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 06:43:54 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-6088d856c6eso12323871a12.0
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 03:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751453022; x=1752057822; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9LuknGbyHpYfn5Myg53J+fZFSmGacyw10WuAzgbETa8=;
 b=QP7fEqBvXrGeZYODn0r+t1b0nkxIjB+sgs33h/uNjmn0KMZxMkVPTsbQ0c/lgP9VZr
 KOLvqKO2H6Z7PqCq9uZBL/6lZ0lm2jh5mbcX4m5TMeSIrDygsahmhrDG/BUWP6b7H3oX
 XAyva7VUIVYjbGm4sIsmtE4BWkuYHHI9r7//fkGkfHZdTyZLfPbWQHDxNyEiWBFb4g09
 ZJ6+VeA9hJySW3BhbCabsalfKE3Gs+4QGQ1P0zrstskYahyRRXgoxFiMKrVgmqDfJSSt
 DVt2k5NM/iIIIaTO2gIIYmpfTgBZrMy4df2jlg7JNGNMUeANi12UXywo3dx2cljTkBS2
 Mpaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751453022; x=1752057822;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9LuknGbyHpYfn5Myg53J+fZFSmGacyw10WuAzgbETa8=;
 b=q/2wh1qcjU2GiicU21JmVOiDMuoiQlWQFV7FPEVvmXDafj+f2TnAb/JONgw0vo7FDh
 hJqz4ZGl4RaZ+n7fdLD749FbUPqhKStEdsNa8a37QNmPoKYUEBnpJAYAJcy1HSmacoUY
 i9MDbnNvoOTBwPu4E+3Qc6WQCBTe4ZlIcXhYy/575ZQVB5mSJj0+LXO+OblAn2KZZs9I
 mWlu8bVkLpxs0jAMf+uFG5w9QkOpk0r+aVJ3hLMqUT8o+Z4zY6uNAfmrgk6bISIQEnnR
 9NrkEJ4j5JEMDlwss2/FDm7ZA+qDvXr0TJii6JQiUTMKICCXfXfo/sYNlPMS+WzBNlmP
 xyeQ==
X-Gm-Message-State: AOJu0YxBK5MqvOu+GyE27h2YhiDYID/3s64q6zFNiTc7Dbhehv0LMysq
 tQibJ3oNCKPQl95abvOw+3dPX6eJk9NxIuimg9GCJnfdOh0qmq+vFBFhLeV75B8XQwY=
X-Gm-Gg: ASbGncvc4/6l7HUW2xdURlQm8Kni1vF/cmijUkEeaaHPNLc7mx7PtnixiAj4Mw+LK80
 RzhfA1aK8smoY6W8IkzFojhuujwzx9NDGHgmL4vPpQjU+JWh84YrLDahaoiEdW388bVeoNXrizH
 2HT76eD1iZRC+FfBzFIs69WdOSpw7vFUom0XqtkQowGeuqT3Xz9Ta+E8stgVqrKqI7l4N5sP2QS
 ciQqKNBfzOjd50pdfyoZAc5MXXMieJtQoHSO6P4Op+NuU3GVLWYVVYEAnhoeOTnl90AeRbvQ6Nj
 BGEuCzG0cesQ0EuGVlApFFYdb92V9XNS/ePsC6H/inh9jYadtLoa4glmpjWWqaSCw8HNm6nvwA=
 =
X-Google-Smtp-Source: AGHT+IF0tOnMmKf/ocwsM5eet0OQrJ62ChLN6abOD8xCYaRNWgEBvFHfyii7SnXtpoTf2ZHtLACezA==
X-Received: by 2002:a17:907:1ca3:b0:ae3:6d27:5246 with SMTP id
 a640c23a62f3a-ae3c2ce1f13mr218559766b.48.1751453022319; 
 Wed, 02 Jul 2025 03:43:42 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae35776d0ebsm1042583466b.155.2025.07.02.03.43.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 03:43:38 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 25FA05F8D8;
 Wed, 02 Jul 2025 11:43:37 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 04/15] semihosting/uaccess: Compile once
Date: Wed,  2 Jul 2025 11:43:25 +0100
Message-ID: <20250702104336.3775206-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250702104336.3775206-1-alex.bennee@linaro.org>
References: <20250702104336.3775206-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, TVD_SPACE_RATIO=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250526095213.14113-3-philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-ID: <20250627112512.1880708-5-alex.bennee@linaro.org>

diff --git a/semihosting/meson.build b/semihosting/meson.build
index f3d38dda91..b1ab2506c6 100644
--- a/semihosting/meson.build
+++ b/semihosting/meson.build
@@ -3,15 +3,12 @@ specific_ss.add(when: 'CONFIG_SEMIHOSTING', if_true: files(
   'syscalls.c',
 ))
 
-specific_ss.add(when: ['CONFIG_SEMIHOSTING', 'CONFIG_SYSTEM_ONLY'], if_true: files(
-  'uaccess.c',
-))
-
 common_ss.add(when: 'CONFIG_SEMIHOSTING', if_false: files('stubs-all.c'))
 user_ss.add(when: 'CONFIG_SEMIHOSTING', if_true: files('user.c'))
 system_ss.add(when: 'CONFIG_SEMIHOSTING', if_true: files(
   'config.c',
   'console.c',
+  'uaccess.c',
 ), if_false: files(
   'stubs-system.c',
 ))
-- 
2.47.2


