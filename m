Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91E29C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 20:04:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts5lL-0003BU-Kh; Tue, 11 Mar 2025 15:59:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ts5kH-00012C-MG
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 15:58:39 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ts5kE-00009J-En
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 15:58:33 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-224171d6826so18622755ad.3
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 12:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741723105; x=1742327905; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q89mBu4b5JYOE58WB93/V2zR/jXmfpOvKMtRO3aXK0o=;
 b=lf3qCzTH2MlGFP7nyvD2Mqga8jLUjWq8MXtIF0mxdFdhlDqxKCTKzwyLwSzoNQRYzO
 Yw6YPSIiFXul+9X4WV0AOTeY8m5U0qN+YyDWriNm1QVwmgC99Iuph8YkPRdaWupF5IZb
 spucxO6ZFaB40Ss+ft7ny2XRnHj5l886VgWOYS5GGm8gl8BJ6qwDRMtMg88gpPNn83O4
 2NZK/503bRiZxybEFqtmQMtDqN3x40V35bg7Rid37VjNv5YmCvBXsgmc7NeeFJzgM3Pa
 sSpIFjh8sFJCrgav0S9H8VOuw4tisyqZOyq8OHXNZCNi14iDxj72L/QYBimT0GzZs6UX
 NM7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741723105; x=1742327905;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q89mBu4b5JYOE58WB93/V2zR/jXmfpOvKMtRO3aXK0o=;
 b=mMq8nCo1Iu/f+Dvk8xA9eKXaWLgUFxUYxX2Lvu8THoM917zFGM66bUzzREg4JQlsp3
 yXdNiCOv/C8Y7xRnHJEQf8Um5VLG9LL5/PovCvN0qWMufNcSVs8EbtWw/XaGR8ZiSgI4
 s+qeRa1IllEECzuvH+KH2bgdUAlq84TZ/01Nspx6Jp93k0Mls1/gKT2/XP7zlJT1EWQh
 DzzTwSq3r2oYhQEe8ZWYcjKHRW6+PaAqpF7u4v/PAKi9XoabT0cidaH4l2Tj+MoZCIVo
 5cmcvjDYNgRCgRYNSZ844VXZMIrl0anaqbF+SM9xrKOI7928V4jMMhMQ7gfUlsRVYqNy
 5oZQ==
X-Gm-Message-State: AOJu0YxvVc29IePvqCxlDYZkaGO8uJ83WE6YT+JvERf/n1gvi2H5Jssf
 n7Lak3gqeXyRS6z3UmkZ4NmxrFxLEWUwbfEUOIpzxvzzjRxy5RElKlt00XEKrWyOObVvABbm4AZ
 CpcM=
X-Gm-Gg: ASbGncuRHrs/lTkjRpgo/Xb3wI7OxpIrRvwdmlhKfUUFYXQmWPLLG/iBb1G/42ipvHc
 J+nejQfiIA14NEXFzacyAyTT0zBcrVTKUehkkGwc+Yh6MsYJJ3HVOcW7i1ho3D3h5RwUGB/5aLK
 AHMgRkzHWRSt7NzHIhMUQxH7+NvAsHddyyKuN+pvrLifiYNI5RRLvR7fD6BsJog5k0v6nVHtGTY
 GPwcJLIWX9BHY60fY8zHpzbjXNEBrDtLp01Ux+Ku9Lmm8Fm4wQrNynQ0CBxh5MMzM6QulZlxPAP
 kkvLoovudEXmE14cEe4n8BKopORvh3i23vGE0ST6COfS
X-Google-Smtp-Source: AGHT+IGPxcxao/HSElseyaTLTAghrvJ2csxsBfbQ4Udwa0eEZtZIt5xFFqgWZBrC6WgJmJp7FceqHA==
X-Received: by 2002:a05:6a00:4b4a:b0:736:5c8e:baaa with SMTP id
 d2e1a72fcca58-736aa9bc0e9mr26082176b3a.2.1741723105679; 
 Tue, 11 Mar 2025 12:58:25 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-736a6e5c13asm9646981b3a.157.2025.03.11.12.58.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 12:58:25 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Anthony PERARD <anthony@xenproject.org>, xen-devel@lists.xenproject.org,
 Nicholas Piggin <npiggin@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>, kvm@vger.kernel.org,
 Palmer Dabbelt <palmer@dabbelt.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paul Durrant <paul@xen.org>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 manos.pitsidianakis@linaro.org, Peter Xu <peterx@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Alistair Francis <alistair.francis@wdc.com>, alex.bennee@linaro.org,
 Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-riscv@nongnu.org,
 qemu-ppc@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 13/17] system/physmem: compilation unit is now common to
 all targets
Date: Tue, 11 Mar 2025 12:57:59 -0700
Message-Id: <20250311195803.4115788-14-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250311195803.4115788-1-pierrick.bouvier@linaro.org>
References: <20250311195803.4115788-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x631.google.com
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


