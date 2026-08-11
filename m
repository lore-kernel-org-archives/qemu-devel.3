Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EDDCC5B572
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 14:37:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtna0-00005m-6V; Tue, 11 Aug 2026 10:35:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1wtnZy-0008WQ-Mf
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 10:35:46 -0400
Received: from mail-qv1-xf35.google.com ([2607:f8b0:4864:20::f35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1wtnZw-0001oX-C3
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 10:35:46 -0400
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-8f29ec73064so17583576d6.1
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 07:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786458943; x=1787063743; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nUDoFYam/Cs4djr+4VD+W1090TdsQ0zW6Cv5SU9lt7c=;
 b=D8H7Kj4AW4tN2gP+xyIWGEcTJ9VDeRPfOeXhCVR0NKvfNiTc7ozzhfaTkcexgMN1Io
 CP/RwBQMc87Td1A5itGJLrbgH8IbNI3O96wvqWuxrhlHRBrQuf6JyjCGEyYEPDyhugRP
 /yaylbivvgJ+t95mR2/5eThY/N77iDfOp2m7DsZ1HrM99ZDZvbmteCEiSJm5FlN6SCMu
 ro/bcCcxzw/q9dXhiqMFnH7yQNzGOJ7a/GbfCjzgReCXvMOn9gtg59vUSCwrU6chGcJi
 P4tWWtUv6IRKFx5bdj4LmwXEZNaSN7EgWd2PVvQow41J21LGvpUjv4pdr1TxMpQbl9LD
 IPoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786458943; x=1787063743;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nUDoFYam/Cs4djr+4VD+W1090TdsQ0zW6Cv5SU9lt7c=;
 b=n+vFpBNwxclSPGXWI11yNNvMyOHEkEAxDC6uhbdPpdzd9f0o3QOn7vFMi8T4UYUa+a
 Vij2hKgE6GntsDboGYkfEt6Y17U5lD1vXp/OtZKUkWRboWniQ8b5KN5hF6z9YUEMsfPw
 KE22IwwoAukJNlh7QnScVb7nVCp+Fno3jnhT2isKWNXYLY2jIf86tKzKe4z7lMNy1HyU
 oM6FPltI51fqIRX9jJEinGNX4voCYRWtJxAGArOA6+Ed5WMmtgzkm8FfZBilMq2J5bDS
 ez1qYXBdeSRg9f2wB8lndNjEDlJ4b8WpUL/NF0qswxOuZQjMvWfZOYa272qsHBj/CdzG
 c0jA==
X-Gm-Message-State: AOJu0Yyb8Kbs8pUqXqFeMXxkNcNgHP0bMNpeqLrYyP55Gxq+D6vM2yd8
 Ci5W2qP4mITApgnOlaJ4114frN8rWQUlw79NM/F22WCu6g4jIscv8vL6ySEsBQ==
X-Gm-Gg: AR+sD10bxAoITlNf1xVToOa33X8tHI05BR8uvLqNLLstEKNddHfOht6ZpSPyMq73kEv
 Wf5yCxcgT05DXbMYBittzzYYQwJzvnm01L5lfHNXaRCcd47WpHP0crtUobfWRLQQEBzqOyv/P4p
 1Z/8brW9BGBHzyGOeeF9wb1NJF3QSEujwsl5163SfHzE93Zw/ILrzwRZsq+3L7CEc+gMVRsic3o
 aGfUlSzFKh87EgbDEU63iYJGrqOhyzo1TrccJyoLiRFhFK6KeyUFW12pfsg74CKora/VssmhSmK
 GpAek2qLs+gx2AQtfcGbAtgyZYKOxUguYXp1wwaun+qKwNT5mK5mWNO+SWgx7KPODc0RCbVHPeM
 8avoO4QThEc3jEWpg4avscr8iNRuO3IMeq19LxBxLZ6zcztKCRz68B6WJQ5kAkjuiEjs0DrTk4d
 +7c/cNraqZv0qkjMNLLHq1ZU4CzZT+J9oQY2pRZNnsXU9KMjlvY9phN9gz31l6Tc8hztnatpD9k
 OYe6Q/tNpuHG5fM4kM=
X-Received: by 2002:a05:6214:540e:b0:8f0:5b55:1f64 with SMTP id
 6a1803df08f44-90a66901679mr36615686d6.20.1786458943057; 
 Tue, 11 Aug 2026 07:35:43 -0700 (PDT)
Received: from localhost.localdomain ([198.16.145.87])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90a6c3ec565sm376396d6.43.2026.08.11.07.35.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 11 Aug 2026 07:35:42 -0700 (PDT)
From: Marcelo Manzo <marcelomanzo@gmail.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Marcelo Manzo <marcelomanzo@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>
Subject: [PATCH v3 1/2] hw/arm/raspi4b: fix guest never seeing more than ~1
 GiB of RAM
Date: Tue, 11 Aug 2026 10:35:38 -0400
Message-ID: <20260811143539.7835-2-marcelomanzo@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260811143539.7835-1-marcelomanzo@gmail.com>
References: <20260811143539.7835-1-marcelomanzo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f35;
 envelope-from=marcelomanzo@gmail.com; helo=mail-qv1-xf35.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

raspi4_modify_dtb() decides whether to add a second memory node above
the 1 GiB peripheral hole by checking info->ram_size -- but that field
is the boot loader's RAM budget for loading the kernel/initrd/dtb
image, itself always capped to at most UPPER_RAM_BASE - vcram_size by
raspi_base_machine_init(). Since that capped value can never exceed
UPPER_RAM_BASE by construction, the condition was never true for any
raspi4b configuration, and the second node was never added: the guest
never saw more than ~1 GiB of its nominal RAM, regardless of the
machine's actual size.

board_ram_size(info->board_id), computed one line above in the same
function, is the value that was actually needed -- the board's real
total RAM, not the boot loader's own budget for where it's allowed to
place the kernel image.

Confirmed via direct measurement inside the guest ("free -h" /
/proc/meminfo) on raspi4b's default 2 GiB configuration, before and
after:

    before: MemTotal:  943524 kB (~921 MiB)
    after:  MemTotal: 1905824 kB (~1861 MiB)

Also verified against two real, unmodified Raspberry Pi OS releases
(Debian 11/Bullseye and Debian 13/Trixie): both now report ~1.8 GiB of
usable RAM instead of ~900 MiB, with clean boots, working SSH, and no
kernel errors on either.

Signed-off-by: Marcelo Manzo <marcelomanzo@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/arm/raspi4b.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/raspi4b.c b/hw/arm/raspi4b.c
index b92840e1b6..821ddb42ed 100644
--- a/hw/arm/raspi4b.c
+++ b/hw/arm/raspi4b.c
@@ -64,7 +64,7 @@ static void raspi4_modify_dtb(const struct arm_boot_info *info, void *fdt)
 
     ram_size = board_ram_size(info->board_id);
 
-    if (info->ram_size > UPPER_RAM_BASE) {
+    if (ram_size > UPPER_RAM_BASE) {
         raspi_add_memory_node(fdt, UPPER_RAM_BASE, ram_size - UPPER_RAM_BASE);
     }
 }
-- 
2.47.1


