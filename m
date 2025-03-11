Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D604DC35FF2
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 04:13:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trqyB-0006O5-St; Tue, 11 Mar 2025 00:11:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1trqvf-0003Qs-8j
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 00:09:19 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1trqva-0006Wy-9T
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 00:09:19 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2239c066347so87018755ad.2
 for <qemu-devel@nongnu.org>; Mon, 10 Mar 2025 21:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741666152; x=1742270952; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q89mBu4b5JYOE58WB93/V2zR/jXmfpOvKMtRO3aXK0o=;
 b=SBSchH1wFYSblBRzjqFbKV+ImaydQIrBXIru2vNcU9gIm6GMmeIFB/DfsBeh3opStr
 icHRRkgtrnEY4ZFHZwfIUgubNY1xSI9Bzx9SM4JzV+ca2T0eyTiaftovlQbJIDLePHb6
 F17TTwAf8dlctqnLy3kumxpGOo8hjgz5swgx/L9PvHFcT9qYwdVGarh6nVeECOIe1FRG
 44StW7pkSpDys3w1iyzTOtes6s2gvZlfT9DJ07ra69o7aCeQjfjM2jD2X9bS/EGw7CLT
 As0uJ/IiLEHyFZYM0u1w3oHM58XoqCVWfa1gYXdnFSro+0NHypObW9ZL8prXyuG6kY07
 6KFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741666152; x=1742270952;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q89mBu4b5JYOE58WB93/V2zR/jXmfpOvKMtRO3aXK0o=;
 b=Ix+LEfHahOYTraGclUq3bvDR3J/RwdYTDPWyxftzJXJnEb8hBAe4N4o42EPd4Tf7Pv
 iLQM5vFnWp3ZVy7M9kR+YyB4ffKvQJ4R2v8C0ic3l1H/Ir/3kAzfADvAkDpcd9rmTY+B
 9xsa3tLwqzdMiHPO1oe8R5NmkxB/FZjIVJo2B0Ea6rJZPKDvCrBUNFpOL7ExNdvNLUyf
 43/BoJPw/GwyWq4XI4JBl9Ark1f1fdU3qjOFNQgwqcNGfMEfgZMFzC8r8VL/RNLLY4zO
 5UtCfZsPNIvRwaaXn5QeZ2LOIl9YY/xnsWbMyfjDWyQJgx+hw3HSG5eaJTs4uOpHpwTp
 hRew==
X-Gm-Message-State: AOJu0Yx0MeGFfeOPkVY1FsRTk2r0DrUY68ajhldxwo9nCBHr33Gd6brv
 QswFYePOXDp5GLLnNV7JFlFL00XXzOmLfsn4ZNLOgb37CUaCv5vXOx24iF+WweDKUCRqET0wrlb
 zyTw=
X-Gm-Gg: ASbGncuaYery3UF2d49FE7KEAh/ZIqUp/kyEeeRvY9IciGEuLWXMWZcBlBr9WTy1H8r
 5wnfl2Gk/i3pYDChcKk09SBtJIsbKnxUZ/Z0f+D3HgxTZCyYNXXCTaIqTHYQevEP4jZYhRdvmNj
 wDSvP6eapz7V/C64sLqI39XnoM70yp2DtaiQ6BJQQESSMoQmNvqxpll9i5m/HEOLafn5gBkMeDD
 d3ARO3Sr9R7P65GCbqbyFOR0Z1EZfz9LQjRzQajLItDheCqJ8MIsdcethyDmi7I9bfkjPCATufc
 i2AYZ118gkAeW5rUmauQIJxU2OPLhVn7Ds1xeYDvTl6Z
X-Google-Smtp-Source: AGHT+IE7G7QimFDknOZtg96uV2bamM0fTFqFZY88Y5t1E8IfrTFu2U6cjPQap3/Vq7WYgH3pY/scbA==
X-Received: by 2002:a05:6a21:3944:b0:1f3:321b:4f8b with SMTP id
 adf61e73a8af0-1f544b190edmr25270834637.19.1741666151748; 
 Mon, 10 Mar 2025 21:09:11 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af28c0339cesm7324454a12.46.2025.03.10.21.09.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Mar 2025 21:09:11 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paul Durrant <paul@xen.org>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 David Hildenbrand <david@redhat.com>, Weiwei Li <liwei1518@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 xen-devel@lists.xenproject.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Xu <peterx@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 kvm@vger.kernel.org, qemu-ppc@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, alex.bennee@linaro.org,
 qemu-riscv@nongnu.org, manos.pitsidianakis@linaro.org,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Anthony PERARD <anthony@xenproject.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 13/16] system/physmem: compilation unit is now common to
 all targets
Date: Mon, 10 Mar 2025 21:08:35 -0700
Message-Id: <20250311040838.3937136-14-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250311040838.3937136-1-pierrick.bouvier@linaro.org>
References: <20250311040838.3937136-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62f.google.com
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
 system/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/system/meson.build b/system/meson.build
index c83d80fa248..9d0b0122e54 100644
--- a/system/meson.build
+++ b/system/meson.build
@@ -2,7 +2,6 @@ specific_ss.add(when: 'CONFIG_SYSTEM_ONLY', if_true: [files(
   'arch_init.c',
   'ioport.c',
   'memory.c',
-  'physmem.c',
 )])
 
 system_ss.add(files(
@@ -15,6 +14,7 @@ system_ss.add(files(
   'dma-helpers.c',
   'globals.c',
   'memory_mapping.c',
+  'physmem.c',
   'qdev-monitor.c',
   'qtest.c',
   'rtc.c',
-- 
2.39.5


