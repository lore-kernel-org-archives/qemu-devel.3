Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1489C67861
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 17:51:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtt7x-0001zw-G4; Mon, 08 Apr 2024 13:49:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rtt7r-0001vf-Tn
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 13:49:48 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rtt7q-0003cs-AJ
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 13:49:47 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-5d42e7ab8a9so2936997a12.3
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 10:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712598583; x=1713203383; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Lw/beNU1QugcC97gSnNNo3jFHiOgyIQNiC5qPkBLROQ=;
 b=gdha9oDZyg24GrzUH489QHcbJX25R8x2bQ5QY0iiWQZiHaKwq/q3B9IDxhLmpYyyL/
 itdnvpvDIHIIYn1pJ61Apwe9+7eXzFcz4PUb3HnLm0GnvGS7susk2MieSPVWDHXoj94Y
 XxYDSd6QviUh0fWV8DUsXjltRVMXSgYZn2OhymzDrdgH05lkfKApohKGuVixevt2O0tB
 0+akCmZVM5bkPU4K0bXKcWaack9D+3m6mbgNSiAvPsGgOmk8p/1znBuuWqR/Hk5taRK7
 wmo2o8SyvowvKwYakrKwaMSTFSe/tr5xmShi0ZHZWrjUwIaqmRLzEWHcqojZ/Rz7eTkZ
 URPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712598583; x=1713203383;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Lw/beNU1QugcC97gSnNNo3jFHiOgyIQNiC5qPkBLROQ=;
 b=DSqrQmpmWlR4ZtrhMJoUmfGXfXX0qIK4Qz/7Napp5PgL91iaDWnuasv45aNLO07mev
 62xfAp4HE7/TpF4QVm1RsvTyLUMZSkF0nh+RSx0ZlIFbudphZa/+7fVwA8eaCTwsXhLs
 TOaqJN7hYDTZX7wr7guJQBp6HyixAeKfMu0L5qawNl4uIbnLQaoPXrAQh19vwy4WsF9N
 ulznOFM1DjjSoAcqKqn9La5a1VWuoi8G7H30pvTvZxx/Yre8s37u+rUewtzfYPYPeBVX
 R3HZt29s3whkEaUs6gt0/UWib517G8bepYucRYBDNpbzK2l6Ah8bpq7VQ0d6Onc8vMrw
 yzig==
X-Gm-Message-State: AOJu0YxA8XHmGwvSauOCiiiWDD47FkmJUizoK96jmKTVUZkw3n/f4kRO
 sRP1HkauBboHBR7u4yD/vncqe3wch6ZlL3xISb11Iys8sUmmm549oOAvT/ht/JyaPvszxNAR2Zt
 4
X-Google-Smtp-Source: AGHT+IHyDsTVfWyZO8lfi2c0buKrh5URB59p0tIcsq+yaamjo6kXE1+YQEW4PuBKH8vM0lNOE8KZxw==
X-Received: by 2002:a05:6a20:5521:b0:1a3:600b:444c with SMTP id
 ko33-20020a056a20552100b001a3600b444cmr8425568pzb.36.1712598583546; 
 Mon, 08 Apr 2024 10:49:43 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 ga15-20020a17090b038f00b0029c3bac0aa8sm8658432pjb.4.2024.04.08.10.49.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Apr 2024 10:49:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Nguyen Dinh Phi <phind.uet@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 08/35] linux-user: replace calloc() with g_new0()
Date: Mon,  8 Apr 2024 07:49:02 -1000
Message-Id: <20240408174929.862917-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240408174929.862917-1-richard.henderson@linaro.org>
References: <20240408174929.862917-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x533.google.com
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

From: Nguyen Dinh Phi <phind.uet@gmail.com>

Use glib allocation as recommended by the coding convention

Signed-off-by: Nguyen Dinh Phi <phind.uet@gmail.com>
Message-Id: <20240317171747.1642207-1-phind.uet@gmail.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/main.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/linux-user/main.c b/linux-user/main.c
index 9277df2e9d..149e35432e 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -928,11 +928,7 @@ int main(int argc, char **argv, char **envp)
      * Prepare copy of argv vector for target.
      */
     target_argc = argc - optind;
-    target_argv = calloc(target_argc + 1, sizeof (char *));
-    if (target_argv == NULL) {
-        (void) fprintf(stderr, "Unable to allocate memory for target_argv\n");
-        exit(EXIT_FAILURE);
-    }
+    target_argv = g_new0(char *, target_argc + 1);
 
     /*
      * If argv0 is specified (using '-0' switch) we replace
-- 
2.34.1


