Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E539CE77184
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 22:39:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNgDG-0005Pk-4d; Tue, 17 Dec 2024 17:38:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNgDE-0005OX-9N
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 17:38:44 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNgDC-0008T3-Qx
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 17:38:44 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-216426b0865so51614165ad.0
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 14:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734475120; x=1735079920; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3xW+LPUYaCaHyMzbWV59CTTMsUuCbv/1PDmcaQ3NGQk=;
 b=CCkjTQjLWhM9bTrMnw0zuaonvWrLDP3CTK9/ldWFAWCsMw1GNnotodJk27GEXj44By
 RNw+7LDssKn6TzSh3nN6Mh1Gs8D0lKpe5QvxztDJXAFLAkQc+K5gTsA8I5Lpga8V+Eo2
 tv/guzw1njU8WQmHm/7dhRvz7iuodDmBe2GMgXhMrlUEd1bUZ1wq6C+X0fl+kDRFD6Ew
 qgW+7GtWBgL3ZwROkKx0pwZQhvUQIP3eLAxHkSpy0zHCSmEHaDjkT2if2qvUegGM2WRP
 Ryzj3xQvA39AKlC4xKWvH2+xgtBmrwUgD9DqIIaE9cPHJmiSiLOvDLuhPkN9wLctP1Xj
 DuOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734475120; x=1735079920;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3xW+LPUYaCaHyMzbWV59CTTMsUuCbv/1PDmcaQ3NGQk=;
 b=sZ0NiYjM3tr2uhefi976Bj5VjooQVYjRkvGitt99RvjBlXOSupzUzTul7nHnXZhzSH
 /+MlAOeIHDKqrfTgSy20wv4Qc2oElyFD204ZmgQ/QQOpbipLPMXjILvxD1Z9XIQVRr1D
 CFtsHeFhE+9aNmzHw4MtYuQv7KEyUpEDOfHhNtrMYBhDjVEYQGw+rigyTtVf3GnUWWR0
 3wWurx2LXp/hLS7K8KRMBvB55k/RtY2T/XGweqFmdiVzHBFtZHo9zTWV+3yEpmoYuq/Z
 VM34XquigS3IFJb07S2Swr40f6UXCd2iHzQK1BFmvIzNHuJ8ExJyKhPqQL6UOYBIzwZn
 rEGA==
X-Gm-Message-State: AOJu0YxR31AwYQr8umhPshMVoODVBdU+TAWoQaNa1aBqGLLlCq9VahCQ
 P4EQfhikhPy2PoKIR5l0WktLZacDCCiLNOO0CRYbVhgJq0xw535JmaFgY734EYsTUZpghaUi0Fk
 kus0=
X-Gm-Gg: ASbGnctzEoE4ZfZ/prvWFZU3asBQ5LgmlNzSTE4wYKaXaXPSC9+eaerbpvAGlhkZF2W
 dpSOeiR2kZZxO5OErNQHJlabJnidCyQlFcEmebHowlVx0SYCL+QxOC4mUxt3NEaSoUHEeEAwTyz
 +TY+xt/oYxcUiEMPG9/BRSZbrX1gfJvaa9wfvEFvBLf4rhUbVTFTPjzr2IieMIVBnREEZ1LVwTE
 ZWBoTxRxYFPDG8LCq+IH0Fs61onvfUPwUVnPa7jUDgMc4bmol79vjdi
X-Google-Smtp-Source: AGHT+IFYufPbVKnw72PKlB3wpqSHAPLfW03YlGYnhN3hy0n34j/n8yoaagSxEvTJpMw83RJflR66Sg==
X-Received: by 2002:a17:902:e807:b0:216:30f9:93d4 with SMTP id
 d9443c01a7336-218d6fbe4e3mr8318695ad.8.1734475120440; 
 Tue, 17 Dec 2024 14:38:40 -0800 (PST)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-218a1dccb03sm64869465ad.98.2024.12.17.14.38.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Dec 2024 14:38:40 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, philmd@linaro.org,
 Mahmoud Mandour <ma.mandourr@gmail.com>, richard.henderson@linaro.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>
Subject: [PATCH v2 11/11] configure: reenable plugins by default for 32-bit
 hosts
Date: Tue, 17 Dec 2024 14:38:25 -0800
Message-Id: <20241217223825.2895749-12-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241217223825.2895749-1-pierrick.bouvier@linaro.org>
References: <20241217223825.2895749-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62b.google.com
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


