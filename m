Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 496B1C3DA41
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 15:34:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPktv-0005dB-Ed; Fri, 05 Jul 2024 11:31:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPktq-0005bk-UC
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 11:31:04 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPktn-0000IM-Sj
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 11:31:02 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-58b447c511eso2379572a12.2
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2024 08:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720193455; x=1720798255; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ldyUH9Hn6Eww0iJRRhRb5soziQO77Zzr7htHiwXtIxg=;
 b=vcazQ5gK9cdfKbFtgkJ14zzr9+j84b462kAWPGDtM7GIgN4qS1s1N5saR0iNe+dkwt
 pSRqq8/2tVtkZe9EpFEgOCoG5F6hZSU4EskTYbI7yJR1I72umHCr2fT0ZdqJkLJ05QLp
 EvslcGMPD5enJaEl49PD96xuTMZLqboF0jHbkEdKlrNz9qEHecnci2Z+L7ARqGF6zXDa
 VJmjKW6mUKzzvhOOZ/YJalIvm3trLp5W1itxAVPgpyenXorjlAvKajnT3YzHk5HJjAUo
 rZaVB4bQHch6SF2tMek081MUtfbJZHRQuk+6DcrupIzE/X95psccYib4MDuRJgaeO/T5
 eeng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720193455; x=1720798255;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ldyUH9Hn6Eww0iJRRhRb5soziQO77Zzr7htHiwXtIxg=;
 b=Wmu+8Bd+FwYdZUiuPrpNEhMNE0rnptwhr2RJGOlV22J1seiU2qugYylTvnyHfPOcaY
 MplZf2fYVx2rKPqWRpccJocqW8+gZW5WZx5L73+uylUSes+CE9E/xxEY7SPKAeFHHmE9
 EoMnFlXKVe7C4/QmQV9BQ7Up6qkk6GT9DC4I0Dv0c51lZSypPVfznxNg/wQK4OJGibt+
 j3FhsjQegqFFY4zLG6VVrQs4xK2ip+Bu1qzhjTx+sPuGWISdeXyVKWzsiX0Py9EBoElm
 fbdAvQdqAChFxnoozXYAhgExR3cBRDTUm4vB/PgHnOW/sW0kY/5vMCudjq15eJ+ZLmPp
 rwZw==
X-Gm-Message-State: AOJu0Yw1oZmjM0byeGQkV/hCVcJlmZ2vKQGB8bE6nh8Hwc2SmqOeFs66
 vHInai8TqkW0PaKRkdaMMrOUUT3LMwHn7KITkhtV9s6S6zvYHRmb4g8DQgIfHKs=
X-Google-Smtp-Source: AGHT+IEfBcRLZhAWGhejHXED4dXSg1RWBn099gU0f+sUf8pNd+fwrtcxRBVpOGpZ/h/4ayl9vx38OQ==
X-Received: by 2002:a17:906:5acd:b0:a72:4402:9344 with SMTP id
 a640c23a62f3a-a77ba46ce62mr418927266b.20.1720193454358; 
 Fri, 05 Jul 2024 08:30:54 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a77d965dc4asm37874766b.87.2024.07.05.08.30.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jul 2024 08:30:53 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2401F5F8AF;
 Fri,  5 Jul 2024 16:30:53 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Subject: [PULL 01/40] tests/lcitool: fix debian-i686-cross toolchain prefix
Date: Fri,  5 Jul 2024 16:30:13 +0100
Message-Id: <20240705153052.1219696-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240705153052.1219696-1-alex.bennee@linaro.org>
References: <20240705153052.1219696-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52f.google.com
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

I guess we never noticed and tried to build with this cross image. Fix
the toolchain prefix so we actually build 32 bit images.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240705084047.857176-2-alex.bennee@linaro.org>

diff --git a/tests/docker/dockerfiles/debian-i686-cross.docker b/tests/docker/dockerfiles/debian-i686-cross.docker
index f1e5b0b877..f4ef054a2e 100644
--- a/tests/docker/dockerfiles/debian-i686-cross.docker
+++ b/tests/docker/dockerfiles/debian-i686-cross.docker
@@ -169,7 +169,7 @@ endian = 'little'\n" > /usr/local/share/meson/cross/i686-linux-gnu && \
 
 ENV ABI "i686-linux-gnu"
 ENV MESON_OPTS "--cross-file=i686-linux-gnu"
-ENV QEMU_CONFIGURE_OPTS --cross-prefix=x86_64-linux-gnu-
+ENV QEMU_CONFIGURE_OPTS --cross-prefix=i686-linux-gnu-
 ENV DEF_TARGET_LIST x86_64-softmmu,x86_64-linux-user,i386-softmmu,i386-linux-user
 # As a final step configure the user (if env is defined)
 ARG USER
diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
index b25e3ac4dd..ac803e34f1 100755
--- a/tests/lcitool/refresh
+++ b/tests/lcitool/refresh
@@ -167,7 +167,7 @@ try:
 
     generate_dockerfile("debian-i686-cross", "debian-11",
                         cross="i686",
-                        trailer=cross_build("x86_64-linux-gnu-",
+                        trailer=cross_build("i686-linux-gnu-",
                                             "x86_64-softmmu,"
                                             "x86_64-linux-user,"
                                             "i386-softmmu,i386-linux-user"))
-- 
2.39.2


