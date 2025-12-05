Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81CAAD33992
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Dec 2025 16:42:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRYsF-0005YC-Fg; Fri, 05 Dec 2025 11:41:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vRYsA-0005Ur-SK
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 11:41:34 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vRYs8-0005jy-Gf
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 11:41:34 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4779d47be12so21323125e9.2
 for <qemu-devel@nongnu.org>; Fri, 05 Dec 2025 08:41:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764952890; x=1765557690; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q5nQL9AFafWp2zKlwaP3Dhs/6EXPtxqPJhY4Z+u/Jbg=;
 b=VdqbdQjFKl4W1oPjN1Ta3GDd/LFQeytEp+tA7Sp0dnGFSrSfVTorWbO6iQZveYimo4
 4dEdov0AowbTJrG2Q5bznPcUOa+h/S1GMTQ2vfPXkeO9fCclmBCEkiyNt91kYpHX8e+6
 SsPykOymd6xiMQ1dV2KEJyhM2MKNlawmNt51kp8cROhq2ZZ1tJYrImakhjWPx7f9ZmFe
 QmNOlyO7VVQVKPNMwVnUxhaaslXrDoJDImOD5YBTKhBDw4cz8LsW+z1/vC/wWekkVpXF
 TZCbuJkyHu4N1B6nX/0XFO0N1ECiAsLhEMoVzZk3nS9Po2lSuh6hzYFvhUuhIKttSU2a
 f6Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764952890; x=1765557690;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Q5nQL9AFafWp2zKlwaP3Dhs/6EXPtxqPJhY4Z+u/Jbg=;
 b=oBkXnr2lKYJkcT95zca79ZYKeVvP8XMCmdyEfnE0FZPpQgwuXva4uvWQM4j34LP7z3
 R8i0wbgNOaOIEo4haVkmIXi7vKgrhWX1WtUbXSGqTOk5tO4DKKBQo4u9Yviw2VlUadmK
 THh0EaKsX5AaNj+ck94ZvoQe3mD/Kab0o1Fm5EBajrflsBc5KU2grD6PJevg3wWGY193
 +yFcdLhjU1nrcBrS0cjFN+SQDWu9HBOnwykHNMPuEptNrbUWMbaDdLseMnFrPpyNr5bd
 UwAKV+DrjHcJ0Da7tYgSjkkdLAnX1Wv7IfCjLUQrhjI3QuQXGF3bPzLvHSQ+CyXoPRvP
 XdrA==
X-Gm-Message-State: AOJu0Yw4IhENAavBnA4s59cZMgeknYtC5wy/oBKAID5XY0CxOYi9zaY9
 LfhgHx6TfnNb62V7qaJ+Dws8+6+gT9oWuvymLz6myDN+1Am1cklfxHR6o5DoKDkrSHc=
X-Gm-Gg: ASbGnct8xMP4cspVp/aNnB+EO1pK50M9C5ZpJNCBVIQvEb4pavhaQP3MQTPBVM0e4qB
 I/h/2wAKKZOzhDCmcHR3YW8utwl8vZmq1nX3m7I6JiC9ZCBiCsGdgX6G1OaKAZKOOIGK1NI5DFE
 PrYwOPiw2iyzTowpjXd6+Qrbk3cVJqITYunQVLZuKRiVF9p9oEwF1G43R54g1rFiS4rXUsOyC58
 NXpqFUl9a68LdjnuWmC2gZbJ42MGd/i7GgKXAc44kXF7KyRTQMhxx08Kxd275R49gW3puvBF2Ql
 bMwcrGpfdifGiGkl3amfHwx9GjM31HWCOdqNOf6r+bC9LDYLJtBPzmOZVShZy2CLz+Ks/QQNvhb
 45lHt0WtsFCHwDMxZUrHmEIf2605yWbBOUT094Y2JqVanE9sLZmHbbKg8cXY25biCqhGlBm3bkg
 OsJW7SEYgBV+w=
X-Google-Smtp-Source: AGHT+IE9EF8MtNRvtsAj3f/ckcb/ln++PoUDvrXYb+Y3W0MD0zLpQHZQk00ifYwuRrw95J7EzClwHw==
X-Received: by 2002:a05:600c:198a:b0:477:63b5:7148 with SMTP id
 5b1f17b1804b1-4792aedfda1mr95145815e9.6.1764952890426; 
 Fri, 05 Dec 2025 08:41:30 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47930cb6a96sm89962285e9.15.2025.12.05.08.41.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Dec 2025 08:41:29 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id BA8455F909;
 Fri, 05 Dec 2025 16:41:26 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 08/14] tests/docker: drop --disable-[tools|system] from
 all-test-cross
Date: Fri,  5 Dec 2025 16:41:19 +0000
Message-ID: <20251205164125.2122504-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251205164125.2122504-1-alex.bennee@linaro.org>
References: <20251205164125.2122504-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32c.google.com
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

We use this container to build system images in CI which do not honour
QEMU_CONFIGURE_OPTS. Drop the --disables from the container so
developers don not need to jump through hoops trying to replicate that
on their workstations.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20251204194902.1340008-8-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/docker/dockerfiles/debian-all-test-cross.docker b/tests/docker/dockerfiles/debian-all-test-cross.docker
index 079942a1c56..1823233438a 100644
--- a/tests/docker/dockerfiles/debian-all-test-cross.docker
+++ b/tests/docker/dockerfiles/debian-all-test-cross.docker
@@ -89,7 +89,7 @@ DEBIAN_FRONTEND=noninteractive eatmydata \
 apt install -y --no-install-recommends \
 ${AVAILABLE_COMPILERS} && \
 dpkg-query --showformat '${Package}_${Version}_${Architecture}' --show > /packages.txt
-ENV QEMU_CONFIGURE_OPTS --disable-system --disable-docs --disable-tools
+ENV QEMU_CONFIGURE_OPTS --disable-docs
 ENV DEF_TARGET_LIST aarch64-linux-user,arm-linux-user,hppa-linux-user,i386-linux-user,m68k-linux-user,mips-linux-user,mips64-linux-user,mips64el-linux-user,mipsel-linux-user,ppc-linux-user,ppc64-linux-user,ppc64le-linux-user,riscv64-linux-user,s390x-linux-user,sparc64-linux-user
 # As a final step configure the user (if env is defined)
 ARG USER
diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
index c5e936112c6..9df607a55f8 100755
--- a/tests/lcitool/refresh
+++ b/tests/lcitool/refresh
@@ -197,7 +197,7 @@ debian_all_test_cross_compilers = [
     "apt install -y --no-install-recommends \\\n",
     "${AVAILABLE_COMPILERS} && \\\n",
     "dpkg-query --showformat '${Package}_${Version}_${Architecture}' --show > /packages.txt\n",
-    "ENV QEMU_CONFIGURE_OPTS --disable-system --disable-docs --disable-tools\n",
+    "ENV QEMU_CONFIGURE_OPTS --disable-docs\n",
     "ENV DEF_TARGET_LIST aarch64-linux-user,arm-linux-user,hppa-linux-user,i386-linux-user,m68k-linux-user,mips-linux-user,mips64-linux-user,mips64el-linux-user,mipsel-linux-user,ppc-linux-user,ppc64-linux-user,ppc64le-linux-user,riscv64-linux-user,s390x-linux-user,sparc64-linux-user\n",
 ]
 
-- 
2.47.3


