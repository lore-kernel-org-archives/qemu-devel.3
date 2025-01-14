Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 877E4E77188
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 11:48:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXfOL-0004Qj-7z; Tue, 14 Jan 2025 06:47:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tXfNq-0004Ka-5n
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 06:46:59 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tXfNo-0006eF-0u
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 06:46:57 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4361dc6322fso37686045e9.3
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2025 03:46:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736855214; x=1737460014; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dqmHD2ejeCU6vyBEybsqYUS9Cxg0cRrbaI6dvUsODH8=;
 b=E97gk1nGa9LcKrOCEE1r0BFla/cVioRBFNdjnXlgrbfnrYCjqNOSAm8ADbCjou7kPC
 lXMoRRSvVn1km2+zf7zxzPzS1za6y20sWfUEWJjWJyqrnzAveIAb8JOpbOM/XRGJw+q8
 yH8DfIyR0cx+xDtqit2iKhUg/y7jAXgyXhIxAsNVW0LCaOIHFVQ+ngH1MJsTuinIqPrY
 p9vkfvpbdSQk3aj2o1N1bO2crwkO/uXNadF4VBTGLDEqosCRa+8SpuMHN01TPQKUNcaf
 +U1LOyqV2a4AaY95iPcvDAkNv6oJ8l1NBz6bXaIcddIkYG5/PrXYCyhLZ5ksZKB1KQXn
 IjHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736855214; x=1737460014;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dqmHD2ejeCU6vyBEybsqYUS9Cxg0cRrbaI6dvUsODH8=;
 b=Fq9tGF8kHDwJDG7bSmoVcNYtLCxv8AV5bUWZtwXVk514fJ+Y/Rk0+FYkADYdCMHVCd
 Um9I5S6BLNr9APx3SZxfDJ8UC2UCrsq+kR2SCZ+ONjDq4jBKRKUgeSQJMUooqgcCEw3T
 /1gaHAw6cfmsh/bOSxikFE3V/5G54QKza/Zh4eIQFgUeSQOmVMSXenFb2/piiNCRGyII
 M7Wt/CcRO9pVQoWafOyVHCEV+NgINdkRnSxahxMPcVt2HRoKffs8aSpkNcRzRza7Jr9j
 4knG8yTyzIQv6vTib6lSTdJVlqIviVaSFS/1yFJTWYBv44ThIJB+QiOzmfXduf+y+cxe
 zvEA==
X-Gm-Message-State: AOJu0YwcaiDl/SCAfIKStMX/KvuPnN3gIUayDjPuXB8MOKNuYJ9SukxE
 EdIGBk7RNDexwrJnxe6AuqU3bo1d6FUVejNQazjIWaFC71KaoyYmsqfhOGLd1AQ=
X-Gm-Gg: ASbGncuRFUNAPgYZ09gcIEJLoFaIuR2BZowIakUC0b/pF3vEyRcchJDNPc11KNAut8x
 gjbD1LmgaMN9ayezjVQIQx7SqMAScArYrB5iLgOLSGXNohA4CUu2qDreRDWoXUpNZTtfrXsQbzF
 AazCsYd0lT+9NXC89jIGGeN5e73aJOtqcAy9fPknOrSx8+U9A1nzrsHp2HX2R0cnMU5PsURmrJt
 zqxqEXtIKOJQB95p1lyJ9Q/PMljaxKpQSqIPhDdI/wKF64APj1GpyU=
X-Google-Smtp-Source: AGHT+IEr7sXXwfqvKZKjC0tZZN3CxOD1EeDoN0Oqi+lF2cs6rGW86LhcAv2UejvoeDQoza8Kc2F85A==
X-Received: by 2002:a05:600c:4f06:b0:436:6160:5b81 with SMTP id
 5b1f17b1804b1-436e26b98d1mr247137425e9.14.1736855214468; 
 Tue, 14 Jan 2025 03:46:54 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e37d17dsm14347308f8f.21.2025.01.14.03.46.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2025 03:46:52 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B7C3C5FA34;
 Tue, 14 Jan 2025 11:38:23 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Weil <sw@weilnetz.de>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 21/37] configure: reenable plugins by default for 32-bit
 hosts
Date: Tue, 14 Jan 2025 11:38:05 +0000
Message-Id: <20250114113821.768750-22-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250114113821.768750-1-alex.bennee@linaro.org>
References: <20250114113821.768750-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x334.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20241217224306.2900490-12-pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 configure | 21 +--------------------
 1 file changed, 1 insertion(+), 20 deletions(-)

diff --git a/configure b/configure
index 18336376bf..02f1dd2311 100755
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


