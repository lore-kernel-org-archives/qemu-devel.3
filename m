Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7686CD68BD7
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2024 21:00:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tC3PO-0007bs-Fo; Fri, 15 Nov 2024 15:59:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tC3PF-0007Yg-3c
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 15:59:06 -0500
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tC3PD-0004Oc-3I
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 15:59:04 -0500
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2e9b55b83d2so916247a91.3
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2024 12:59:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731704342; x=1732309142; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EYpw+FgnCnpLICJOkhi6wbCufDiGso6GG1nTzyOYRhg=;
 b=b496SyLI1lYwEL07pJpPBshlseVi4TApct7/WBrzC4iAwQY1S4XKdUEtU01JZvLLGL
 No5HOyeYM++s3fxEnh4T+/ku/M3fcW1FeAYPW/7hi3Cxj3fuUaRG74y8cEJ1vPs+nV06
 UA0D2IArgnyUmzjD7khpiHI9fws8TupyU5UOhFaVYpzZaYV8vBa/7WN1dZnkcGA1hjTk
 715E8Csyo+d/IKAMzAe90dX/9Gxu/rhTriT041EiLtlKnmJM45y8b3QJM/2b+L94qnzW
 IOSBhnNac7auwe4ViXZtSaX0xZgjLGKTNirj1UHSzCLuYzFYN5fQHzTdIVi+awx+QE37
 qg2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731704342; x=1732309142;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EYpw+FgnCnpLICJOkhi6wbCufDiGso6GG1nTzyOYRhg=;
 b=w+v/TfSlP+cpL8ACbMHdgFsFqr2fj9AACM0+SSaKeID8QpGusbgDLO+WZGC/f1kDO6
 1rjvXG2kphta2bS9wr4y4Dc8xJuhG3BkfG7+8/nKzIAzQHkS5KVmEY4eSkgVSiLyq/Lp
 4RSM4LR8Idx0XvxWslDysx9amWBsPlf6Fs7SXRW/NTMBe27FHmWSQVX4DzR0wvOhVjad
 dDPDTDpBBQkINsfMr3lfyE0NKy3I7fCH7LE35kE395U2OfpBoadOpSz+skjWnP5ljznx
 tI/5smfFwI8XY8z8b5ReGr4Lr9aPXpezS29G8euK3x9SPKq9R8/LcMJUkjqbIhtrJmUb
 rVmA==
X-Gm-Message-State: AOJu0Yynq129wqHVD19m3xx6Dkq7uJT4oaPgXwdwKjaAByJrOnqs9FWb
 GEDY/FCON51AQIsegrgDksQk//Ncey4ob2tiRsx6PROFOFG9A3qJv47ZHRzHarVmomFqDboOORz
 K
X-Google-Smtp-Source: AGHT+IHR6i9hvxsGnXSOF3FDrmDmYK+yHpOeill5PiIJmLYK9TTS1C7C+md5NctJJJVSVrTNxOLhSw==
X-Received: by 2002:a17:90b:4e:b0:2e0:a77e:82ff with SMTP id
 98e67ed59e1d1-2ea1559bab1mr5308055a91.33.1731704341673; 
 Fri, 15 Nov 2024 12:59:01 -0800 (PST)
Received: from stoup.. ([71.212.136.242]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ea024a49a8sm3362274a91.23.2024.11.15.12.59.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Nov 2024 12:59:01 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 10/14] linux-user/arm: Reduce vdso alignment to 4k
Date: Fri, 15 Nov 2024 12:58:45 -0800
Message-ID: <20241115205849.266094-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241115205849.266094-1-richard.henderson@linaro.org>
References: <20241115205849.266094-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102c.google.com
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

Reduce vdso alignment to minimum page size.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/arm/Makefile.vdso |   2 +-
 linux-user/arm/vdso-be.so    | Bin 2648 -> 2648 bytes
 linux-user/arm/vdso-le.so    | Bin 2648 -> 2648 bytes
 3 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/arm/Makefile.vdso b/linux-user/arm/Makefile.vdso
index 2d098a5748..8a24b0e534 100644
--- a/linux-user/arm/Makefile.vdso
+++ b/linux-user/arm/Makefile.vdso
@@ -6,7 +6,7 @@ VPATH += $(SUBDIR)
 all: $(SUBDIR)/vdso-be.so $(SUBDIR)/vdso-le.so
 
 # Adding -use-blx disables unneeded interworking without actually using blx.
-LDFLAGS = -nostdlib -shared -Wl,-use-blx \
+LDFLAGS = -nostdlib -shared -Wl,-use-blx -Wl,-z,max-page-size=4096 \
 	  -Wl,-h,linux-vdso.so.1 -Wl,--build-id=sha1 \
 	  -Wl,--hash-style=both -Wl,-T,$(SUBDIR)/vdso.ld
 
diff --git a/linux-user/arm/vdso-be.so b/linux-user/arm/vdso-be.so
index 69cafbb956e283e2975bac59a10491c0cbafca57..bed02804a4bd367eb9fd8ca54d0c980103c02245 100755
GIT binary patch
delta 49
zcmV-10M7r|6xbAyaRLAkk#lhrGQ`BrU>NUTo0WUr&~YvSTwestvG{WZ25D?qS41(h
HaR%oD3DgvN

delta 49
zcmV-10M7r|6xbAyaRLDVk#lhrweyTc_Z*p@&&2@VLR1?$m|vtIvG{WZ23l}Oc}8xt
HaR%oD4;B=<

diff --git a/linux-user/arm/vdso-le.so b/linux-user/arm/vdso-le.so
index ad05a1251875ac0c76685e1f9190a7307a8444d1..38d3d51047372391b3125c3f9f6ea5401f04bba1 100755
GIT binary patch
delta 49
zcmV-10M7r|6xbAyaRLwkk#lhr8{q*880U1i=t7z4dQ|b*DDU}VvG{WZ25CxDZDwh+
HaR%oD5d#(3

delta 49
zcmV-10M7r|6xbAyaRLAVk#lhrkUMV7Jk`NO!6O#urC$6IB@6+uvG{WZ26R_8MpaO=
HaR%oD?$r}}

-- 
2.43.0


