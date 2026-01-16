Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18A21D4A5F7
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 03:37:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgabn-0007OJ-Vj; Thu, 15 Jan 2026 22:34:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vgabX-00075f-3I
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 22:34:32 -0500
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vgabV-0005hg-84
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 22:34:30 -0500
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-c2af7d09533so1084671a12.1
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 19:34:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768534467; x=1769139267; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7DzNQby4LQPUtVLwqs2IyxJ1FWe8jwshY5ovM9t1IBI=;
 b=BJJ4u9BDKhiWH65Swdz/WoGWJlQkpZO4xdohnhAc3B/ymbQZ926QXxvtSP/WtDveh/
 mrCXAJSY6Akl3T5sBrUvrmY9yhTHZvWGh7A8D8XGR2ECJMpVEcgQOS0fCYCyCU3pMQnT
 xs6cXOSGmvHNbEBv5eJC9nF8v80hdrRCpydPK8GqMYwFECO1sZ1ld0eD09kNSmmtRPEA
 27DqmjmTY9RrVWh9Y/ZxOiX6xxkM+GFbi7GcEkotCgbtYbpCH0VqzBeU7I/de7/CLJF7
 gyu7WguQjoQutX00VXETIe3c2qYaOBMd9egFsp3265OLFNnuducwSoqkgTVFscpGjqJf
 cnmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768534467; x=1769139267;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7DzNQby4LQPUtVLwqs2IyxJ1FWe8jwshY5ovM9t1IBI=;
 b=e3HIaGOV5kRgBkANCmAWf8kQcRyIHnvI6HLf9+BPGBbVw3KgR6D21cAPxz+paQ6VYO
 SsJEBVlRu3U8Tj+oZQogS4n3Ivr8mRtUw972gLuGi47H13S50KsQZwIjKVDUCUd7ccL9
 u72VkROjKrJMKp8AEepBF+xo+jGHz2ZEiFHDCGd0pxxxcep8L/ZKfKZ9Ot/8YD54QcYb
 l7meRCJieJbFag0WnVnkGh9Faip36TBnMje52ufiwlACbl/TZqg5AYuaNZx4ae03HSpD
 IG4Zhg2G8YEPJgN01e0U/IETKjq3cYdpIBsWZErH1ns4gCIfcpt4jAcoj3d9wJfQrnJ9
 EJNw==
X-Gm-Message-State: AOJu0YzlDED0hDE7F3xSw+dH2W8TMjvjCVTDxCCOBWDMpxkvQAKuSovU
 jSS1NDQ3iSINvO+FFeSzc1z2xthPrngNXk/Y2a9fF6WGxjPOoBr0XoYjX2xFhIFg8Y6EKhD6+FO
 +qDgyJhJS3w==
X-Gm-Gg: AY/fxX5a2YqHTYmiX0Qlg+/yB+LXEg1TAx7YqKMAEcPoqdSAX4LfYGBWaLlNh0bTXY9
 KnukZB9KtL/vr8nBEitXLbiS2tj/4RK2i156eLXsSU89rnHgJUutdxdsSzx6G9KWrXUicqV3JpR
 mVE/z18iVnmyoRr0Fg8bjuGT29HQ1PEBLF2aYQH4LRNRIJnJfK0AQry7PNJdO966tJ/3XYAxWU2
 xOhji5cmx03CfgkSGUUcn7Xru4kkEzLxW+Ls+QGXe0GR1A6nq+ZwOU24dlMpPHAASqoiZ2ppQNK
 t/Uj8q70CGaz7EBYOpxhPy6fOLQFUF89y+BqXMClqro8qfBbKmi4PrXnhkZZC3p0LqCa2tlk/NB
 YDsozh/tUaal/XZWQ0Dr6Qt0oKonRxF+ZIZgwEHVxKYzqz8tAbQqPnEEL+VDrtfIYdwoefxiXAY
 E9d5cKHDGlcRTrGYWkDg==
X-Received: by 2002:a05:6a20:431c:b0:38b:dec8:9da2 with SMTP id
 adf61e73a8af0-38dfe67bb6fmr1927619637.26.1768534467149; 
 Thu, 15 Jan 2026 19:34:27 -0800 (PST)
Received: from stoup.. ([180.233.125.201]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-81fa12b5c67sm683372b3a.69.2026.01.15.19.34.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 19:34:26 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: ktokunaga.mail@gmail.com, berrange@redhat.com, pierrick.bouvier@linaro.org,
 thuth@redhat.com, pbonzini@redhat.com, philmd@linaro.org
Subject: [PATCH v2 18/58] tcg/x86_64: Rename from i386
Date: Fri, 16 Jan 2026 14:32:24 +1100
Message-ID: <20260116033305.51162-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260116033305.51162-1-richard.henderson@linaro.org>
References: <20260116033305.51162-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x532.google.com
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

Emphasize that we're generating 64-bit code.
Drop the explicit rename from meson's cpu.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/{i386 => x86_64}/tcg-target-con-set.h  | 0
 tcg/{i386 => x86_64}/tcg-target-con-str.h  | 0
 tcg/{i386 => x86_64}/tcg-target-has.h      | 0
 tcg/{i386 => x86_64}/tcg-target-mo.h       | 0
 tcg/{i386 => x86_64}/tcg-target-reg-bits.h | 0
 tcg/{i386 => x86_64}/tcg-target.h          | 0
 MAINTAINERS                                | 4 ++--
 meson.build                                | 2 --
 tcg/{i386 => x86_64}/tcg-target-opc.h.inc  | 0
 tcg/{i386 => x86_64}/tcg-target.c.inc      | 0
 10 files changed, 2 insertions(+), 4 deletions(-)
 rename tcg/{i386 => x86_64}/tcg-target-con-set.h (100%)
 rename tcg/{i386 => x86_64}/tcg-target-con-str.h (100%)
 rename tcg/{i386 => x86_64}/tcg-target-has.h (100%)
 rename tcg/{i386 => x86_64}/tcg-target-mo.h (100%)
 rename tcg/{i386 => x86_64}/tcg-target-reg-bits.h (100%)
 rename tcg/{i386 => x86_64}/tcg-target.h (100%)
 rename tcg/{i386 => x86_64}/tcg-target-opc.h.inc (100%)
 rename tcg/{i386 => x86_64}/tcg-target.c.inc (100%)

diff --git a/tcg/i386/tcg-target-con-set.h b/tcg/x86_64/tcg-target-con-set.h
similarity index 100%
rename from tcg/i386/tcg-target-con-set.h
rename to tcg/x86_64/tcg-target-con-set.h
diff --git a/tcg/i386/tcg-target-con-str.h b/tcg/x86_64/tcg-target-con-str.h
similarity index 100%
rename from tcg/i386/tcg-target-con-str.h
rename to tcg/x86_64/tcg-target-con-str.h
diff --git a/tcg/i386/tcg-target-has.h b/tcg/x86_64/tcg-target-has.h
similarity index 100%
rename from tcg/i386/tcg-target-has.h
rename to tcg/x86_64/tcg-target-has.h
diff --git a/tcg/i386/tcg-target-mo.h b/tcg/x86_64/tcg-target-mo.h
similarity index 100%
rename from tcg/i386/tcg-target-mo.h
rename to tcg/x86_64/tcg-target-mo.h
diff --git a/tcg/i386/tcg-target-reg-bits.h b/tcg/x86_64/tcg-target-reg-bits.h
similarity index 100%
rename from tcg/i386/tcg-target-reg-bits.h
rename to tcg/x86_64/tcg-target-reg-bits.h
diff --git a/tcg/i386/tcg-target.h b/tcg/x86_64/tcg-target.h
similarity index 100%
rename from tcg/i386/tcg-target.h
rename to tcg/x86_64/tcg-target.h
diff --git a/MAINTAINERS b/MAINTAINERS
index 1a6e5bbafe..c39a8f54e8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4057,10 +4057,10 @@ S: Maintained
 L: qemu-arm@nongnu.org
 F: tcg/aarch64/
 
-i386 TCG target
+X86 TCG target
 M: Richard Henderson <richard.henderson@linaro.org>
 S: Maintained
-F: tcg/i386/
+F: tcg/x86_64/
 
 LoongArch64 TCG target
 M: WANG Xuerui <git@xen0n.name>
diff --git a/meson.build b/meson.build
index 7993e4cfb9..594e7d42c0 100644
--- a/meson.build
+++ b/meson.build
@@ -907,8 +907,6 @@ if have_tcg
   endif
   if get_option('tcg_interpreter')
     tcg_arch = 'tci'
-  elif host_arch == 'x86_64'
-    tcg_arch = 'i386'
   elif host_arch == 'ppc64'
     tcg_arch = 'ppc'
   endif
diff --git a/tcg/i386/tcg-target-opc.h.inc b/tcg/x86_64/tcg-target-opc.h.inc
similarity index 100%
rename from tcg/i386/tcg-target-opc.h.inc
rename to tcg/x86_64/tcg-target-opc.h.inc
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/x86_64/tcg-target.c.inc
similarity index 100%
rename from tcg/i386/tcg-target.c.inc
rename to tcg/x86_64/tcg-target.c.inc
-- 
2.43.0


