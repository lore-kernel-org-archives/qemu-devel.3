Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA562D33994
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Dec 2025 16:43:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRYsA-0005Ue-4o; Fri, 05 Dec 2025 11:41:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vRYs8-0005T9-7p
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 11:41:32 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vRYs6-0005jN-BT
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 11:41:31 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-42e2e08b27eso1032132f8f.1
 for <qemu-devel@nongnu.org>; Fri, 05 Dec 2025 08:41:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764952888; x=1765557688; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CMQFgHx5wtT5EEQNKAZXug/Gj/RiLEh/WXlVrm4hK2U=;
 b=oYMnns56xyrz92R3hgmYqqw+DIQNaPtZuuhdltBRE4sjuargUPazMGkzbwznCPAme8
 /b0VitCKCBnRUlTEiD56zM0r4ey6IXap2Cw9Ps4fCQi0dPs4sfn/ojgtrfgGvxAnp8H4
 dcuDKv12besM5CeMHFiosFUneAXRiBwLnwExaoBe+Bd9uBlEAvX82rrYWsuTP7JjeZwn
 rp6NRxM/B5x5vrTFAMloTH9IfzTx486G7ahDvkZhPp8Ve76Fuk/u4AZQu/EzcUfNB+72
 MxLsp9W8PFllx4OHrrsB1swM73+6LMT+aplYj91Tqk1oRex9mgqSrEZzE8a92pEEzxDv
 BdnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764952888; x=1765557688;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CMQFgHx5wtT5EEQNKAZXug/Gj/RiLEh/WXlVrm4hK2U=;
 b=CgJNmkbDm7i4cjoWK6pr7n8XTAliy8B2SVBJZuk2kSpueGfi8eBl+dWs2n7Kcj69ZV
 JejW2HSOlFkI2FKnXZID8y1MEA9ziUC34u2n6PkIyWmt5bcRyPt4ER8DLAbrT0Zl5YLy
 MTdEyVlhOOQSV/jEEZNV26dTricX8dh9sNWH+neFJ3F+tUgGjt0MjfEID4zNYg4vI9fM
 gH0rJoeUZpOwFbpHeXE8pnmHhYMtWYUCpRl/t+wkiSNUdVyCxVcnPKSvwJv1ebg6a/36
 jUoc32VWI0t8swTD4j2EbKCzX8nVwdnEgILemSJbR6N8RRwDYu3tS/hHyOM8lxZXK77T
 n2bA==
X-Gm-Message-State: AOJu0YxN0KIECPVe7dK+ZA9RmWWy24DZxoddIAApdvZ7RxXYPa1PMH1B
 Y0wwVQO4X6H/sRQSffyhikfHozOjxCzXCVOSs60UMUTtjpE/2crR1qTVpKTnp3FsS7w=
X-Gm-Gg: ASbGnctIRHoGI0VWHGmv/oCVGymNGaVvMaVOwJ3Eao8DG0/zyG/gQSUk3RjSjN2H7TP
 jAn6eC7rXd2lRrtuOCLCaQmoNG/1CnNW13dkt7FB0CmzTWCVIJLd5Xl241LapPc9MPAWXv39laP
 dZDDiQJ7pj3vNOapzy5EsmEYVRIUCvwhVO8DS7eMMdjZwCuZcEkRkyew3NCIcbc3HpsFBk6n5RM
 oKccLDpL7PidQdmqfxhPxswakpbMkGG8RGpc6NlltVVob+5JzldFv8y30JBTRiBUR089ZlgK0DT
 tPtchQ4dhjANh86PuWSeVcnBV3n8X3raK/GMMT0Fm8YVG6wGZBvOuT6BXzu4ptvddpm3hUmZA9Q
 WrO+YQLZD93PkQfpKs2g8DL+4vfsD33Odgt1aOzDukH7NtdlTyM3laBzAv84WKWtQu+RlBjEv1T
 Qe2Ods+uIEEdU=
X-Google-Smtp-Source: AGHT+IGev49R0IxdN5veBcRV+UDotqZoy2dY9rhnUJOGMQ/BAxBYxkEhrImdiTo+wzIqVGyyvssl9A==
X-Received: by 2002:a05:6000:2689:b0:42b:3c8d:1932 with SMTP id
 ffacd0b85a97d-42f7317e474mr11244726f8f.23.1764952887792; 
 Fri, 05 Dec 2025 08:41:27 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42f7cbe8a7bsm9662565f8f.4.2025.12.05.08.41.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Dec 2025 08:41:26 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2AA615F839;
 Fri, 05 Dec 2025 16:41:26 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 02/14] gitlab: drop explicit pxe-test from the build-tci job
Date: Fri,  5 Dec 2025 16:41:13 +0000
Message-ID: <20251205164125.2122504-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251205164125.2122504-1-alex.bennee@linaro.org>
References: <20251205164125.2122504-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42f.google.com
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

This needs libslirp to run and as debian-all-test-cross will soon be
based on qemu-minimal we won't have it in a few commits.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20251204194902.1340008-3-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index 44df116139b..dfe954fe3ce 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -656,14 +656,12 @@ build-tci:
         --target-list="$(for tg in $TARGETS; do echo -n ${tg}'-softmmu '; done)"
         || { cat config.log meson-logs/meson-log.txt && exit 1; }
     - make -j"$JOBS"
-    - make tests/qtest/boot-serial-test tests/qtest/cdrom-test tests/qtest/pxe-test
+    - make tests/qtest/boot-serial-test tests/qtest/cdrom-test
     - for tg in $TARGETS ; do
         export QTEST_QEMU_BINARY="./qemu-system-${tg}" ;
         ./tests/qtest/boot-serial-test || exit 1 ;
         ./tests/qtest/cdrom-test || exit 1 ;
       done
-    - QTEST_QEMU_BINARY="./qemu-system-x86_64" ./tests/qtest/pxe-test
-    - QTEST_QEMU_BINARY="./qemu-system-s390x" ./tests/qtest/pxe-test -m slow
     - make check-tcg
 
 # Check our reduced build configurations
-- 
2.47.3


