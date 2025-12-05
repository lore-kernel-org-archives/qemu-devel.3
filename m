Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AB11D33992
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Dec 2025 16:42:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRYsE-0005WY-8f; Fri, 05 Dec 2025 11:41:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vRYsA-0005Us-U8
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 11:41:35 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vRYs9-0005k9-8d
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 11:41:34 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-47789cd2083so15014675e9.2
 for <qemu-devel@nongnu.org>; Fri, 05 Dec 2025 08:41:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764952891; x=1765557691; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UgC1n9c0p0XafiXg1Pp+WyNc7po/v/NB3rG48EO9ToA=;
 b=d2UTO4pwyxPqpSpQjPukX84jshrnaEFTibtakqdkFQknqaCf2U6xW6lq7OZ4vObaCO
 gXbMMIDXYHZ2Ecur38Ny6KXEWDw9ZPjqk28JBmYcP8GXUHgjQAPW+x19XjKbe90BxwgZ
 E5sqf/dQLvVl8ljYaKK1rtu5gd8Nc+0qfNK9UK9wNRlA4JnDYrde3ryuMO9AzZlzdDqk
 SzWoolnAiuPTKtXlBcQg5p/A54RrfXcu420ddJUj958On/cOsxJ/XWt+FltjZRV/Oiz2
 ScHa6XRdwOJoEoaXPuQ9HPkplSfAPNVrEQoXV6OEG4pAZlJQ2l/HAoS/PyhP3TXyGM/9
 bERw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764952891; x=1765557691;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UgC1n9c0p0XafiXg1Pp+WyNc7po/v/NB3rG48EO9ToA=;
 b=PBDsN0Rj6S1ZZQ99KcBDXlng1Hwl3ct9moB42x+cKwBHFsnoQ2+XVH4WCKxYO1tgYp
 B9mwpmFcdc5hZkLmOND8vKRHCgolNkGTX9IiCmPGOql2jj2/WeGV+QNR6mLEpci1o3h6
 K17llPojlnAIVBpfXa0WEt57oilndw1wvw1LXIaYrPFwDZc03qd4SpyTPOPKFe6qS1sE
 no+yZv1wTFVFl1i/NL0dr3LW5x2dmV4jAaE+k0GW9r1jmXyxP1yFORPJLoWKt2ul5jwe
 Kqk3/3rmcT8+9hj8fOdwvxijbm96tDFE0bl4S6SfWIyJDii53QNjOKr62tJv0MGAfHpv
 LceQ==
X-Gm-Message-State: AOJu0YwiaOU3ihpgMbaLh4x5OLSrUX64kiGGuMFGzuvRb8TgSsFfpsOx
 Giu0KwA3Dt/AsSE375WXmY6LpIHbjVOcY25OQq/C60ykfhAVoHiQo0PYkDVG/ieQOd0=
X-Gm-Gg: ASbGncudjUlddlSm6oq7ymd8VCj/7niLrnSoUUnGl3Z9cih666y25R9LjQ8pH92ldny
 EHLE7obh1BXfdv1dTJQ8rHIxnvQUFjlBWUm/nG+N/dThGSGdrazf7DPkwTG9zJjqRuoPYp27KH9
 o1PqZYZ4F5rGoLiAi1pcHEDS/Eid5MTh48hkVLKHzEhSZP6maZkj92dpWX/U1mQuDpNTGV1evCw
 e3jtA6vmmPVrpDyVT8o195ymyvDY4cINC/W+8HCRurCnA2LpeBaGF7Bsibpy2K6ofWji92d9eZ2
 dm5bibKdwPeXCZ7OuuBVyeuj1uMjac/BVS8Bc204wWVPWsXnY8ARv+HH5BQI6RJHR9vHwefMrZC
 /TadEIWPQm96B6YSshgAz+V8kvB729VSkk8/sFSwKSijjjC38lIv12ws3HEJkr4OTjRzPEqkf0f
 WzAsSbcJChvuSWCMoXOXx6Ow==
X-Google-Smtp-Source: AGHT+IEKTCzqo1lcqGCt4z544PMM16ygqm+IsOpO7xWFbx86AYITyhEWBBr7XgxyPG+If0uxpUczgg==
X-Received: by 2002:a05:600c:4755:b0:477:63a4:88fe with SMTP id
 5b1f17b1804b1-4792aed9b2emr111134245e9.2.1764952891041; 
 Fri, 05 Dec 2025 08:41:31 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42f7cbfee71sm9475442f8f.15.2025.12.05.08.41.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Dec 2025 08:41:29 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 71CCD5F87C;
 Fri, 05 Dec 2025 16:41:26 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org (open list:Block layer core)
Subject: [PULL 05/14] tests/qemu-iotests: Check for a functional "secret"
 object before using it
Date: Fri,  5 Dec 2025 16:41:16 +0000
Message-ID: <20251205164125.2122504-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251205164125.2122504-1-alex.bennee@linaro.org>
References: <20251205164125.2122504-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
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

From: Thomas Huth <thuth@redhat.com>

QEMU iotests 049, 134 and 158 are currently failing if you compiled
QEMU without the crypto libraries. Thus make sure that the "secret"
object is really usable and skip the tests otherwise.

Reported-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20251205130014.693799-1-thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/qemu-iotests/049 b/tests/qemu-iotests/049
index ed12fa49d7f..a1b922060db 100755
--- a/tests/qemu-iotests/049
+++ b/tests/qemu-iotests/049
@@ -39,6 +39,8 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _supported_fmt qcow2
 _supported_proto file
+_require_secret
+
 
 filter_test_dir()
 {
diff --git a/tests/qemu-iotests/134 b/tests/qemu-iotests/134
index b2c3c03f08b..cc1e35eb161 100755
--- a/tests/qemu-iotests/134
+++ b/tests/qemu-iotests/134
@@ -39,6 +39,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _supported_fmt qcow qcow2
 _supported_proto file
+_require_secret
 
 
 size=128M
diff --git a/tests/qemu-iotests/158 b/tests/qemu-iotests/158
index 3a9ad7eed03..8fc4e986532 100755
--- a/tests/qemu-iotests/158
+++ b/tests/qemu-iotests/158
@@ -39,6 +39,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _supported_fmt qcow qcow2
 _supported_proto file
+_require_secret
 
 
 size=128M
diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
index e977cb4eb61..10d83d8361b 100644
--- a/tests/qemu-iotests/common.rc
+++ b/tests/qemu-iotests/common.rc
@@ -1053,6 +1053,20 @@ _require_one_device_of()
     _notrun "$* not available"
 }
 
+_require_secret()
+{
+    if [ -e "$TEST_IMG" ]; then
+        echo "unwilling to overwrite existing file"
+        exit 1
+    fi
+    if $QEMU_IMG create -f $IMGFMT --object secret,id=sec0,data=123 \
+                 -o encryption=on,encrypt.key-secret=sec0 "$TEST_IMG" 1M 2>&1 \
+                 | grep "Unsupported cipher" ; then
+        _notrun "missing cipher support"
+    fi
+    rm -f "$TEST_IMG"
+}
+
 _qcow2_dump_header()
 {
     if [[ "$1" == "--no-filter-compression" ]]; then
-- 
2.47.3


