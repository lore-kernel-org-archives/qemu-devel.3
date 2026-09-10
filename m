Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E142C88E40
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 18:16:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4jIu-00047P-IB; Thu, 10 Sep 2026 14:15:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x4jIp-0003xj-Ky
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 14:15:15 -0400
Received: from mail-wm2-x10.google.com ([2a00:1450:4864:31::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x4jIo-00074f-0i
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 14:15:15 -0400
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49cc9f581c4so524055e9.0
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 11:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789064112; x=1789668912; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=eBsj2XhCEL/NhykBF8J7KXxpFhqb3kG+EJ/KbNIHCIg=;
 b=hPHZSi7cKxnas84gXIyF3THLjqpxUffNDNzQ5oLvn/8lLHPPkdaPtfIMhkkgG28/Lp
 DU9KX3XlzubcJIS8JtjToNeu+EDNgyFredASb4aSHwOr79GSShzx9aH6eBUPEgFqxU7S
 pia0m9kqRtA3ABji+kwoCVAonHlgzbfuJinLkjyQZ0wZRzkI9X/tTr3Yc9gmNQg8rSQw
 NJlj0eDQtiIuBkePU3nS6XcWvHpyVT8Xfgf75WpW6a33GFLudcD1Qb/7P7Z9+LMAq/M2
 e3LfqtNUSd4aquPwQQRrWvD0vUKMxI2Ee2DrF0GwGklYFEJQ26aICn/qKFo/PTv5D2TO
 NB6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789064112; x=1789668912;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=eBsj2XhCEL/NhykBF8J7KXxpFhqb3kG+EJ/KbNIHCIg=;
 b=I6qLUzmpfz/fxHC0fayOxv1/xH34o4VH5CTEe1jlxf+/hxZxv2nyOWGdmeBwosC+Yr
 EYl7KtLrk6nh5xXgbswtY/ystVcz5gWf+Ekhu130yMZDkbGy5zf1Hu7OYG/iQkBPfx6s
 sO8+FPQEhOjnWBVvc/qFiO1OAnDFAUmMytn6wVbL4zKsFmRFGpn/m9J6fyOobjEjIRNB
 w1MFoEQAeS4z3K/w9O9ivxtHzVaZmCSKoUAWVq08y7Mt9Xhsu3zFL58QQspnlBrP5XuC
 rLy6yIReTISCxHdZwpApur1vAQIWNhfJy06p7WgBQ2/5QnleCPWLsYTUL4OsxZETkPGa
 HGxA==
X-Gm-Message-State: AFuF++lKRrs5DXH5ZVvEvZqGgwQLZqgXzk610NNIx2ca13JlJzVieIlY
 VeZk88y50qbgu90dxVmfrp5t8LBacBpuEHUVRt3zzjb5EUcVKnk8buAjApxxHTM4tRs=
X-Gm-Gg: AYBFou0Z911W4m50KyOjQPg/yQXQTIpYVOinHe+zF0fEEv0Q2n8/+HQqJYDsZWgCwBI
 TneXKFsmVLtv9xoqqhPGGtuPA/H+eRaATPc7TifsUPWniA8iIGnXPYKma3bWi9eyaFCJHYE1NN5
 zYjREATFcwPlqslN1B2IWWOnpH9TUAYiCldmMrkTcMfcb8q4oLpIEjoh033sAXgF2a/0Okgk1gv
 EynwBvmcgU+1G8lpNbDbvk8U1XUlnNVSX6AZ6BBcl7cuQRXnWhGP7RV8UcwNHCYX3EpHFgFhhSp
 T0yHYMbYBtjneOPFKm96Dmx6HuJwmqiUymsqMoYbWFlFO4bIiy3J9FkDCOc04Xp+Lbq0g1yECEs
 0qUiaDj4J/0Ae4R0Io3XYKC49/YdZvrClRfdwPPL/xlm9fAlO8Qw8VvgdbBQAy46F3iU9xRKOVN
 U+kf8nRjdry04GxhRpw2ghmLb7u1/2GWDLwsPE/7BznvRugSSL3AqCX/4JmM72GNlYH0iTktfN
X-Received: by 2002:a05:600c:4683:b0:49d:1916:2133 with SMTP id
 5b1f17b1804b1-49e6106d393mr8154265e9.8.1789064112349; 
 Thu, 10 Sep 2026 11:15:12 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d20fce7a7sm320089145e9.4.2026.09.10.11.15.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 11:15:10 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 9EF605FCE6;
 Thu, 10 Sep 2026 19:15:05 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Brad Smith <brad@comstyle.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Song Gao <gaosong@loongson.cn>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>, John Snow <jsnow@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Thomas Huth <th.huth+qemu@posteo.eu>,
 Brian Cain <brian.cain@oss.qualcomm.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Kyle Evans <kevans@freebsd.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Cleber Rosa <crosa@redhat.com>
Subject: [PATCH 6/9] tests/docker: remove used _read_qemu_dockerfile
Date: Thu, 10 Sep 2026 19:15:01 +0100
Message-ID: <20260910181504.1010916-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260910181504.1010916-1-alex.bennee@linaro.org>
References: <20260910181504.1010916-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::10;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm2-x10.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This is no longer needed since the functionality using it was removed.

Fixes: 07056db1b50 (tests/docker: remove FROM qemu/ support from docker.py)
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/docker.py | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/tests/docker/docker.py b/tests/docker/docker.py
index 6090a9dc957..fd0cbdfe856 100755
--- a/tests/docker/docker.py
+++ b/tests/docker/docker.py
@@ -175,16 +175,6 @@ def _check_binfmt_misc(executable):
     return interp, True
 
 
-def _read_qemu_dockerfile(img_name):
-    # special case for Debian linux-user images
-    if img_name.startswith("debian") and img_name.endswith("user"):
-        img_name = "debian-bootstrap"
-
-    df = os.path.join(os.path.dirname(__file__), "dockerfiles",
-                      img_name + ".docker")
-    return _read_dockerfile(df)
-
-
 def _dockerfile_verify_flat(df):
     "Verify we do not include other qemu/ layers"
     for l in df.splitlines():
-- 
2.47.3


