Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E3DFC982D8
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 14:25:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7ZWb-00065B-11; Fri, 18 Sep 2026 10:25:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x7ZW3-0005l8-Cq
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 10:24:39 -0400
Received: from mail-wr2-x10.google.com ([2a00:1450:4864:30::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x7ZW1-0007pC-Ib
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 10:24:39 -0400
Received: by mail-wr2-x10.google.com with SMTP id
 ffacd0b85a97d-482f6356256so313081f8f.1
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2026 07:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789741476; x=1790346276; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=h93Ez9eMZuLiqa78/3gdqAuJAwQM1qafcTQGw9IZ92Q=;
 b=ocLW1Ox0jyhMyfhwyD4UAS3MRc+WMY5Tzv3ouuIVURwaklMgl09EKmduqw06n2ND7L
 /XCzOLIdQv87GkJMcGr96NuDT+nXIt7v6AeyLaYxjGUYWwXo29UElIsCDTaYGSER44/N
 5fQn6S9A4dWh/3p8beJ9O1TloNJe2hbjnHAPu8f8ee6saa0piuigWrF2qyQoyie53oyd
 xLQj3lJhAFKgp8qymNx6DYBMiYl0J4Tip3dVlu4iGt3ak69kKRVpyrBBghcwU0U8BPrP
 RPEmdatSqa1+mIo+WwyRD1YDWuw9L7eBGcboOrBOCkmnwPTo218PDgp9m3qloDe5q+dh
 qvzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789741476; x=1790346276;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=h93Ez9eMZuLiqa78/3gdqAuJAwQM1qafcTQGw9IZ92Q=;
 b=djPDQOgSjX9tG9L2XwVPrvvix1RlS5fxvBoBVrgq+Itxf8gJr4K82xzv89bbob/L9T
 L0t0lx1v2F5a2KijSkBOmkREDH9QUB41iOm0+uLwYhBl9n0Osici4Gbq/5tQkb2yx8hY
 zjas8t6lsFW7UvJDbVHJ3cChY4+TvLble7b1u4uX0t58bJF/fYfuxRMEGD8ofSIGtwWD
 Zx4vpCM9LtfoHNbuLmCeYrIUHvwjchyz+d6AoGm5k5y0hw17F+W/ztqYQtgFMfW0gQQ6
 dAHjc/OKxqt562oYKBObr2DIxfOf+EF6ehs9QYIBLXVPAvQ14/lzpM2SUGrAe9AiTrKl
 zA/A==
X-Gm-Message-State: AFuF++koNLmFepfAicOswBlcDV4V7noXzme0L8EKSIU+wYcvI7CUogEe
 8CXQ/+b8fxxgKlwpYnwyUTmOJ8rvcMxdJRCtwCwPGsjqQyUEWDIH8Tye0AfaNYLlDME=
X-Gm-Gg: AYBFou3Le2OjwiXsS3EMa6yTCbX5nYVI88a7jxPx2cq3OGn656v84O3ADQlDtEuwx2i
 1HWPBIt9d9zk4Qy6AzeQTexu36giHVtN4iT79NOJdjiD6PbbGXTzSfbCEuDcxbLfuflCxgP9Rvr
 UyEKVq9mUHsiN3WwnofXEe4eh1ZIeuReH0u27yGJNSQbCOL/+qQm5etZuEkt3hHiViziNCWT5y7
 F/Rpu36hguMaxw61AyXZeshtL6sbwIZ9DE2kw5Uzi1FTBmaNNFBTSGOKlNv3ndU7jCD1b+U5ALa
 atfGITEjN/G0gw5Up8vz9srOeCxqZJKSU8WQCgfnx6ZBGTXYIPzc83fN0kXB5dBb6SoXeacahWk
 XT0MkcwKVbS0FVHsCaNRU0BEdx/zQg3LGJJik1Ik8wcUe4aoKWMd68TBbLuQjeQB5K+ZOhtfEC1
 1sc6UUQHkpRVG9S8rggrSQRwFsg3LLiWPZEH5C+HOJ2IVvQwaD7ECRhd63PCi6bgTMRMmtetY=
X-Received: by 2002:a05:6000:40c9:b0:487:a87:24c9 with SMTP id
 ffacd0b85a97d-4871d98cc80mr4729666f8f.3.1789741476147; 
 Fri, 18 Sep 2026 07:24:36 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-487203f077fsm4131949f8f.26.2026.09.18.07.24.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 07:24:30 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E4FB05FA18;
 Fri, 18 Sep 2026 15:24:29 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eric Farman <farman@linux.ibm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Jared Rossi <jrossi@linux.ibm.com>
Subject: [PULL 03/17] configure: ensure it also honours container configuration
Date: Fri, 18 Sep 2026 15:24:14 +0100
Message-ID: <20260918142429.336497-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260918142429.336497-1-alex.bennee@linaro.org>
References: <20260918142429.336497-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:30::10;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr2-x10.google.com
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

This partially reverts the bits of 522b299ca43 (tests/tcg/meson.build:
implement ./configure containers options) so the configure script can
also honour the container config while keeping the plumbing to control
containers within meson.

Tested-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Eric Farman <farman@linux.ibm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
[AJB: untangle changes since]
Tested-by: Jared Rossi <jrossi@linux.ibm.com>
Message-ID: <20260917165602.3405537-3-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/configure b/configure
index 1973f023b1e..8f8fec4efc8 100755
--- a/configure
+++ b/configure
@@ -246,6 +246,7 @@ ninja=""
 python=
 download="enabled"
 skip_meson=no
+use_containers="yes"
 rust="disabled"
 rust_target_triple=""
 
@@ -722,11 +723,14 @@ for opt do
   ;;
   --disable-plugins) plugins="no"
   ;;
-  --enable-containers) # enabled by default
+  --enable-containers) use_containers="yes"
+                       meson_option_add -Dcontainers=true
   ;;
-  --disable-containers) meson_option_add -Dcontainers=false
+  --disable-containers) use_containers="no"
+                        meson_option_add -Dcontainers=false
   ;;
-  --container-command=*) meson_option_add -Dcontainer_command="$optarg"
+  --container-command=*) container_command="$optarg"
+                         meson_option_add -Dcontainer_command="$optarg"
   ;;
   --rust-target-triple=*) rust_target_triple="$optarg"
   ;;
@@ -1713,6 +1717,9 @@ echo all: >> $config_host_mak
 
 echo "SRC_PATH=$source_path" >> $config_host_mak
 echo "TARGET_DIRS=$target_list" >> $config_host_mak
+if test "$container_command" != ""; then
+    echo "CONTAINER_COMMAND=$container_command" >> $config_host_mak
+fi
 echo "SUBDIRS=$subdirs" >> $config_host_mak
 echo "PYTHON=$python" >> $config_host_mak
 echo "MKVENV_ENSUREGROUP=$mkvenv ensuregroup $mkvenv_online_flag" >> $config_host_mak
-- 
2.47.3


