Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68C23C88E5C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 08:55:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6lOw-0007sk-Ln; Wed, 16 Sep 2026 04:53:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x6lOs-0007oY-U4
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 04:53:54 -0400
Received: from mail-wm2-x11.google.com ([2a00:1450:4864:31::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x6lOq-00050f-GX
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 04:53:54 -0400
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49e620fa473so4086495e9.1
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 01:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789548831; x=1790153631; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=985RXYgmuubKbGZhm5YGlCDe8xIWjFc7WGyDS1rZ3h4=;
 b=b3Mq85InVk6BCUI9loUer04DfUaMnoq19/5LIhiiy7Dm/ns/tHn63sqVzIGMPh07DC
 N/paqraDdWLFH7eiyyDXDBZe5VcxQZFShm5wQAYGpS/lBDHaDmWb8H5WDgPcvLAavq6/
 XEyYNC8B0kuQCuqvqMSM+DMGJJskQKE+G+8mtO9pk2H7f5jtmOEL35WOMmcjUTv7G7yJ
 RRojd1RC65nojzLozdyZBliMDIopEe8sqymkxIrZZm0F9ufX9DPRuOKSDBUG+Nnr+SmT
 mnvhEovdDsiJ5n3G8pyLbbeTSo3lYcaQlFaKOtvR7t1OKOCMocJyM5LHMWBs0TsqacqM
 +zlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789548831; x=1790153631;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=985RXYgmuubKbGZhm5YGlCDe8xIWjFc7WGyDS1rZ3h4=;
 b=ktyeliLvUummWEr7SqJuB1PBnSWWxJquKAZyV/jr8vFWV/VidvMtLMNlwhNrIFC1/q
 54dwM8zHtt6ZEDX0C/7zvtrE/6a/8LOMtJUKtaW+6KAlDeLhhMC/G1D3omezo6QcrSvM
 UbBi89irvr9mdFCnupzIdkqMNmq8wpLJOLjiz90Kh+woIIIxMYnp8aTdQC/hzXV6ucH/
 n6a0yRn89k4r0X3iAae65VnxWAUna6dLNQziBIDHx9VjQVwe5qZ4YAvTRkHLyWXiU3s3
 W4v9tit7lIb4geid2oF3J7SvuIljbrBlaonAUFYkTt0Qt+pUkRvYKmVOo0I0OL9ec2uU
 ZW7w==
X-Gm-Message-State: AFuF++nEYmsp6h292x8gyyUHy04JlO9ZlzwLkt3YuSKGnmzpeVN+Jpuu
 9BfjnGVGDBZ6F4PCd2hIZfigEqd0cs/g1NTPseI9ouwa+WRkip5qlHP/9iZvVr5E9jI=
X-Gm-Gg: AYBFou21jpeLLkY8VOkyuMa55G1Y9mV6VZYte3kB9U2TxF1e+ncvqKgapqpbRhtlgXs
 h23hrPLoRDvNlTysziZAVuTuv+VsDyIupzLW+YuFQYxKqbN281oMite9pQfP39ScFBM0GI9ai++
 Me/thmIPBgwZFplFzCJlP6UNVgIWFREAKAwDeHhYEIhmpTY1fx5V6QXchS2yIgPW+Qixju5K6OU
 a1A7+Poc+1N8ZBGbSBYhplF8D28PpZvc38CnzA+vlaPJ/AYq8lznYfo4VTDPQFhbz6d3M/3qYS+
 a5P5N96hnE1Jq+5mQX+iV+kAFBjIF8OIfpr+CYzAFi0Q5zM6FosW34e+qxEWs2rlNK1W8QQlTQO
 e9X/j7/jC0XdDk5xI2mGb/84/mIZjyTbDul0EVR4xofWkWtIL2IRJH4nNBpgSlRGCeHAzW5R4ZR
 DfJoV7NGgDOQqePYGref/H2zZ2+g+A8FjQxTyDs2ei7OI5y8iuXIlieVKUaC80F/khJW0ykpE=
X-Received: by 2002:a05:600c:3ba1:b0:49c:fc6c:bdfc with SMTP id
 5b1f17b1804b1-49eb7322ea4mr22019875e9.19.1789548830330; 
 Wed, 16 Sep 2026 01:53:50 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fbbd83e39sm3585475e9.4.2026.09.16.01.53.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 01:53:45 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8286E618F9;
 Wed, 16 Sep 2026 09:53:42 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Helge Deller <deller@gmx.de>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <th.huth+qemu@posteo.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 Brad Smith <brad@comstyle.com>, qemu-arm@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Warner Losh <imp@bsdimp.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Song Gao <gaosong@loongson.cn>,
 Kyle Evans <kevans@freebsd.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Eric Farman <farman@linux.ibm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v3 10/17] tests/docker: remove used _read_qemu_dockerfile
Date: Wed, 16 Sep 2026 09:53:33 +0100
Message-ID: <20260916085341.1692742-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260916085341.1692742-1-alex.bennee@linaro.org>
References: <20260916085341.1692742-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::11;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

This is no longer needed since the functionality using it was removed.

Fixes: 07056db1b50 (tests/docker: remove FROM qemu/ support from docker.py)
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
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


