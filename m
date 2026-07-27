Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4905BC5321C
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 13:54:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woLm6-0001kz-QS; Mon, 27 Jul 2026 09:53:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1woLm0-0001f1-VF
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 09:53:43 -0400
Received: from mail-ua1-x929.google.com ([2607:f8b0:4864:20::929])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1woLlu-0005pA-Qr
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 09:53:37 -0400
Received: by mail-ua1-x929.google.com with SMTP id
 a1e0cc1a2514c-96935063700so1637837241.0
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 06:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785160412; x=1785765212; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nUDoFYam/Cs4djr+4VD+W1090TdsQ0zW6Cv5SU9lt7c=;
 b=PT9IDqqI9HA04Ng73/fZINk8rPMab1Pa7PKGFtbWkHHON1aSagI3tNI9Tdw7NBkyOn
 9GS3vFmU3zSIDNWprw4DAU1eCG2FwsU43/nySu/Slur4CxbDQ0It7MEfbCgwcAYfHvHx
 ng9DQjPWmj2oa4cbH63yJOd9htAfgzOjqPYvP9AwDPI0CXDA1IyiO+HzgA8+4NtHeFJh
 GB3dBGLDZsGzsuaSeMoFD4pPYuc8wnHOJn3U6/Ql/aNJiHkMhS0taMFL+IS6az8Ff/DO
 fdvBBq6cRCpyaStSUVCPcPfttUy8938FBj10uPWhOrYD4i7PRDUYsKHDopHoC/v1QWZf
 EQFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785160412; x=1785765212;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nUDoFYam/Cs4djr+4VD+W1090TdsQ0zW6Cv5SU9lt7c=;
 b=dNnFMpoa90j+oBpVOJiWQA0HEiLpx2nzMcmvZaPJa5CJTGuEtVjvUxRWWopR0YvcLN
 4z0L6lIijOCsbLEmjD4OysmN4HJZCl7U6MEHhpZ+UhH1txvEnUGnmBHXymGNSR2kYEhU
 z3La6j4eAK+wo0Npdlm7mwRYltO2OY7x7U1N/rvMKT5aYrqucWV2G7lCuNHGL7dn7Tkj
 QNcKTBDVf6bB/lJHEX2HqRevfI0mel5Lemrnj+khD6JQhk9znu4ZZu3bd7Xd4/laXR4u
 iQbx4yNFLhHE4+WLwHk0dzCOFrp5IlGaSNitxOiLLB0dF1BxIbLN3Rf9UIBpE0c5QoqU
 ds/A==
X-Gm-Message-State: AOJu0YwDB+m9cQOr1R2H5X3oqMwubPmyC0SSv4kg/0eUe504QmXzlpk8
 3yjyHbDsd2Cb9Beemkp9bYGLChFkS/6soWGJe4Gba3FuOceiFLx7ck4QcW4/gQ==
X-Gm-Gg: AR+sD13h1Alkfp1m/I20FoTJSETNUaNQmfdvVvA2Lv1fJmKKrIVlL/doM9CYmMDZ0b+
 1JpYsa7qnC+XR9qeL8gGwPoxMMBRAA55ARFr62/IwQ5P05tHOe5aIhZ/NeGQkyIoDrow+EFKExo
 PbBZp0GixiZ6XS/dT5DVBSVCyvdf2q4I1YXYRoQFa0235F+gCHksP1IEhjQgUMdfq9QgkdvvCWZ
 1siN2lIiFC8vPY23I3EvCp13k6IuNsimhMbZC4F7KRp0maxPseQzNpdwOOIuUTO9I5nOWIRTyo2
 uKdYsi5vP6v064fzVEMeH0Nma4SqjHVbAJqfiXYmXMMmX/r4LatlGPAtKFMux+h5uaZOKeGtlWT
 F5QZPQKQBYb0D481uCJXEKwHh374TFpSmA7HNAAnVEHtCtpXPjq8r/sMfYDiX/w9uoDgQjNd0vc
 XGn2yFWHdw7aWoa2WOorFqHYWXBBR7y89L
X-Received: by 2002:a05:6102:508c:b0:738:1ef6:51b9 with SMTP id
 ada2fe7eead31-7503dd5664emr4844947137.5.1785160411860; 
 Mon, 27 Jul 2026 06:53:31 -0700 (PDT)
Received: from localhost.localdomain ([146.71.8.128])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-97774ce146csm5199734241.7.2026.07.27.06.53.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 27 Jul 2026 06:53:31 -0700 (PDT)
From: Marcelo Manzo <marcelomanzo@gmail.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Marcelo Manzo <marcelomanzo@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>
Subject: [PATCH v2 1/2] hw/arm/raspi4b: fix guest never seeing more than ~1
 GiB of RAM
Date: Mon, 27 Jul 2026 09:53:28 -0400
Message-ID: <20260727135329.97190-2-marcelomanzo@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260727135329.97190-1-marcelomanzo@gmail.com>
References: <20260727135329.97190-1-marcelomanzo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::929;
 envelope-from=marcelomanzo@gmail.com; helo=mail-ua1-x929.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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


