Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C84EFE668B8
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Dec 2025 16:04:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWzR3-0001s7-V3; Sat, 20 Dec 2025 11:04:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guodong@riscstar.com>)
 id 1vWonC-00055X-Je
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 23:42:10 -0500
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <guodong@riscstar.com>)
 id 1vWonA-0003id-GO
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 23:42:10 -0500
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-7b80fed1505so2622283b3a.3
 for <qemu-devel@nongnu.org>; Fri, 19 Dec 2025 20:42:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1766205726; x=1766810526;
 darn=nongnu.org; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=k6b46huaaVKN8mknPD7v5SyJ09/0QNYrXwXxhdCaQH4=;
 b=WkDe/4SqMGrQuOad6vUV7AlHfPri8GQiE6JkTZtpEYOUFYe70p5HXonm4T+66XaipT
 xWwWU4TBSQQ4Elu90ssxteVnpAGaZWwqHYyD/LUQdqu4POrJ3pw/DMAiq4OGqZmcBgeJ
 ldcOhhifzSb+GKiCFaGli76uisF4VfWXwWg1q/p16vChLzaZvy7LZOXFwZZ5/aK3G/aM
 NO3MKmKunthqVlqrrvcH8Hq8DD/lq9J8zQ0XsqH3bmYUerIxWsDNuTVmfEIW7fyGJ6iE
 bpvRWXFheAOubf0vzVmFsifo4sqW0ZTUsCaSSrADQ+flwTgx2JoS0+8hu+D25caSGOZM
 64+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766205726; x=1766810526;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k6b46huaaVKN8mknPD7v5SyJ09/0QNYrXwXxhdCaQH4=;
 b=Y01YY4BGiLDjYSGZ0+LnAcns5a5Qx7UL6QSIhg075tK0maUpOIgyXgZDlZfyDn7gDU
 +IOA8Wi7fnSmMm+UcwBZbLweCdtFK+Y2h25ewBjHjjideVMX/wsi7cMihq27IGJndIgX
 jQoC7TADtkOuZg0PhPF4jbunporgemk9RoZar3mFWONbKl/WVYWv7xGyUuqXEUJVvBsV
 nB82srBaKAgc84monxODU/8BgyelWKi0ImXxOOOh9N+kjA8WHMlTVJJC6y50Hz1J6Saw
 IZsBOsHLFWHwjsxZ/WcR2guuriqAOyevLASz/imn5B0C3XRtmX5fiHAE576e0Du40kTW
 hyXg==
X-Gm-Message-State: AOJu0YxtoBzJoho4/+p5asI62rK5Kv+drIEFGYhKlJ2opZVpHnDuv+lV
 nQPBva99qe8BWmvjo2NGG41p6s5n8CWSQjL348NJBUFnA3h5DK0N1IChcvKkJkc7m3E=
X-Gm-Gg: AY/fxX7j00hMiQSwAHrNOy6+eHHbr6Ionj03sjhkNtnMn6T0fFBxO0zlhv20dFOm+On
 Z06FB0jAPHRSfDt+pLO8gzSvC9gLo2Zrg69zYNV1eac0CvIo7Mpx0J8/+EaBNHzybfpK/xvvxwI
 R/6Kw1fstR6h6IuqYceg1Ck2qYFOHx9YJ4/AyGfBMgftDckyavsufM5F7xPs1KRG21UN7T3QIR5
 I0WzeG0hJX3gUonPit5K/eDX/1Ey6B7UiczzBkwQHlrf7gsn+3SvayMwLXrIdiE+2Y5NXStA/dW
 p+H111tHnC2BIPMNr1uDIxLHPbHFxf0F20o8kgUdzMByNFB5GpyUs11VluG6QuIU6axl+HYcBEz
 fgBZrVDqZGPQPGkFPCuQrgcSATwiXid/C+sxt4eczdiZJGdd8vYVY4zFgFajnNiQCttN07GwD/W
 iCX0UgEphyblABDYh5IhZJ7bOFOxtJceY=
X-Google-Smtp-Source: AGHT+IHWzevY/YyjSknJjnUqud1XFnpQf8O8YQJ2cv88pbTyynWm1r/nuGdXMlMcff7SR6DF/a4vQA==
X-Received: by 2002:a05:6a00:4197:b0:7e8:4398:b357 with SMTP id
 d2e1a72fcca58-7ff66079e35mr4806674b3a.42.1766205726191; 
 Fri, 19 Dec 2025 20:42:06 -0800 (PST)
Received: from [127.0.1.1] ([2a12:a305:4::302f])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7ff7b423b9asm3901686b3a.28.2025.12.19.20.42.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Dec 2025 20:42:05 -0800 (PST)
From: Guodong Xu <guodong@riscstar.com>
Date: Sat, 20 Dec 2025 12:39:32 +0800
Subject: [PATCH] target/riscv: put sha and shcounterenw in alphabetical order
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251220-sha-v1-1-56b1b8b6ef79@riscstar.com>
X-B4-Tracking: v=1; b=H4sIAIMoRmkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDIyMD3eKMRF1LszTD5FTDNGNjY3MloMqCotS0zAqwKdGxtbUAk7EqCVU
 AAAA=
X-Change-ID: 20251220-sha-96f1ce1f3337
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>, 
 qemu-riscv@nongnu.org, Guodong Xu <guodong@riscstar.com>
X-Mailer: b4 0.14.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=guodong@riscstar.com; helo=mail-pf1-x434.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 20 Dec 2025 11:03:59 -0500
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

Ordering rule 3 preceding the isa_edata_arr[] array requires alphabetical
ordering of standard supervisor-level extensions.

The sha extension needs to be placed before shcounterenw. This change also
corrects the riscv,isa string generated for cpus which includes them,
such as rva23s64.

Verified by
  qemu-system-riscv64 \
    -machine virt,acpi=off \
    -cpu rva23s64 \
    ...

/proc/device-tree/cpus/cpu@0 # cat riscv,isa

Signed-off-by: Guodong Xu <guodong@riscstar.com>
---
 target/riscv/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 73d4280d7c84a9d4c7cecd3e067d312adc13b035..e24f32978f645d71d149e0f06c31ce848876f636 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -190,8 +190,8 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zhinx, PRIV_VERSION_1_12_0, ext_zhinx),
     ISA_EXT_DATA_ENTRY(zhinxmin, PRIV_VERSION_1_12_0, ext_zhinxmin),
     ISA_EXT_DATA_ENTRY(sdtrig, PRIV_VERSION_1_12_0, debug),
-    ISA_EXT_DATA_ENTRY(shcounterenw, PRIV_VERSION_1_12_0, has_priv_1_12),
     ISA_EXT_DATA_ENTRY(sha, PRIV_VERSION_1_12_0, ext_sha),
+    ISA_EXT_DATA_ENTRY(shcounterenw, PRIV_VERSION_1_12_0, has_priv_1_12),
     ISA_EXT_DATA_ENTRY(shgatpa, PRIV_VERSION_1_12_0, has_priv_1_12),
     ISA_EXT_DATA_ENTRY(shtvala, PRIV_VERSION_1_12_0, has_priv_1_12),
     ISA_EXT_DATA_ENTRY(shvsatpa, PRIV_VERSION_1_12_0, has_priv_1_12),

---
base-commit: bb7fc1543fa45bebe7eded8115f25441a9fee76e
change-id: 20251220-sha-96f1ce1f3337

Best regards,
-- 
Guodong Xu <guodong@riscstar.com>


