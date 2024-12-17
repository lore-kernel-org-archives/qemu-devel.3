Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFE11E77188
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 22:45:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNgHl-0004NJ-LS; Tue, 17 Dec 2024 17:43:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNgHj-0004M9-Nr
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 17:43:23 -0500
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNgHi-0001Bb-1o
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 17:43:23 -0500
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-7292a83264eso2468954b3a.0
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 14:43:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734475401; x=1735080201; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jgxR9arESI3Aidanx+cexjGed292D3H2X6RqwRpaLC4=;
 b=B/Eee2/BQZ6S80+QlreecIwlDk6/dbBNBBjqgkezvwtqEpcnmTEv791tAaDcAiLSkw
 30pOxW1Jj8KbxGOU/FOQTrf0RUNNyIaI79nrNkVncJnhFwLONAUPXAaMuLvBDk8EI+2M
 hMn7PiFIpWF9ay/rgbJ1bL14Waqo+qDzLewjTJBvT2wgj+9x8FRXa4dwrweViD32XCh3
 4cC/P8wisHxF4B2ZuWed+shYtql8xxYh69Oa+kDpmTdkWmEEdzwu8jTKuchJm9lXfXg/
 PR8xDDyzh159dsAYt4Izb9fh3LrpIMJ5JvndqnKytH413Dm7uF6EKfHun/OJGgjuBPqw
 8Idw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734475401; x=1735080201;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jgxR9arESI3Aidanx+cexjGed292D3H2X6RqwRpaLC4=;
 b=IOt8pi6ORp4MI+FzTxjZI2xGnatoBrA01ysYEmJRjoOkMLGBIHRAiE9Mel78Lkj3m9
 oUYl3NZbx+XBx4MXFbnaopglA+RtA3od/qBVV6dhWJZ37M+k6zp9pRWSaiZrl3Nt6T97
 Pzn475U25a1+AwLBlcnmg2eEoHNMRyIiq+z7bzDClSSEhZUi4xCIFwChYr9BmCoLJvSh
 YdQzBEiiGgd9Gm4oYhQIzWboBIjTBSAd/7My8V7rZHJ5+doD/AuvbkOHv78jUrkMG8D0
 OXdcmixOd9PNTLTSYhHHyu/oHpcV7xOrkkqZsdcd3NH4+HfIWGSLDJSFsTaKI3f5Bi9r
 DwrA==
X-Gm-Message-State: AOJu0YzdXZXLcq431zl2Fl5hmz+XZ3S1r+IboPs5wuHGVEd5UQYBa5Nk
 Vs5bfyw2yqCRn2LGSsbQ+F93fKyAsY09tjM463mNtB0DaqRDJRnATX+ik8r4BMQf04CqigSZbz/
 /9HA=
X-Gm-Gg: ASbGnctAYUKq2jceSpZWucifDkx4JTaGxv14N99KfYxGhcOTMSBQxuwbrWBVylbVdMW
 Oiyecs4xktnaS6p5zo/7SNe2y/1mVpBnV1Zph3M+TNuQN3tQrqm9abbpTVZRC62o6WxYx9nABFh
 uhrTcEuQ7PHtPXQcdm6tnz58s8YdJyWc0t16VXNlYuxKMVPZFMLlb5keSrPEqk5INeqStRriG+7
 +BPHjVpPmanHtnMsOD38fOVjKPq3LDZni6joUdiSxZWAe+0DUL8EYq9
X-Google-Smtp-Source: AGHT+IGN6BduqgEMB5ckD0vOMFunG6nxzDmBNpQZSvK87izGm+GAny8oGTFSVPrUOI3ohevVDfFeag==
X-Received: by 2002:a05:6a00:2906:b0:724:f86e:e3d9 with SMTP id
 d2e1a72fcca58-72a8d260780mr971134b3a.14.1734475400871; 
 Tue, 17 Dec 2024 14:43:20 -0800 (PST)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72918ac53f3sm7463214b3a.27.2024.12.17.14.43.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Dec 2024 14:43:20 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, philmd@linaro.org,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 11/11] configure: reenable plugins by default for 32-bit
 hosts
Date: Tue, 17 Dec 2024 14:43:06 -0800
Message-Id: <20241217224306.2900490-12-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241217224306.2900490-1-pierrick.bouvier@linaro.org>
References: <20241217224306.2900490-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x434.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 configure | 21 +--------------------
 1 file changed, 1 insertion(+), 20 deletions(-)

diff --git a/configure b/configure
index 18336376bff..02f1dd2311f 100755
--- a/configure
+++ b/configure
@@ -528,25 +528,6 @@ case "$cpu" in
     ;;
 esac
 
-# Now we have our CPU_CFLAGS we can check if we are targeting a 32 or
-# 64 bit host.
-
-check_64bit_host() {
-cat > $TMPC <<EOF
-#if __SIZEOF_POINTER__ != 8
-#error not 64 bit system
-#endif
-int main(void) { return 0; }
-EOF
-  compile_object "$1"
-}
-
-if check_64bit_host "$CPU_CFLAGS"; then
-    host_bits=64
-else
-    host_bits=32
-fi
-
 if test -n "$host_arch" && {
     ! test -d "$source_path/linux-user/include/host/$host_arch" ||
     ! test -d "$source_path/common-user/host/$host_arch"; }; then
@@ -1072,7 +1053,7 @@ if test "$static" = "yes" ; then
   fi
   plugins="no"
 fi
-if test "$plugins" != "no" && test $host_bits -eq 64; then
+if test "$plugins" != "no"; then
     if has_meson_option "-Dtcg_interpreter=true"; then
         plugins="no"
     else
-- 
2.39.5


