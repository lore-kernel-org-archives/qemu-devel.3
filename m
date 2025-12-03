Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39BE9D116F3
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 06:11:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQg4d-0005cW-K5; Wed, 03 Dec 2025 01:10:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vQg4W-0005Sh-UZ
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 01:10:43 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vQg4T-00012v-7q
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 01:10:39 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4779a637712so39508275e9.1
 for <qemu-devel@nongnu.org>; Tue, 02 Dec 2025 22:10:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764742234; x=1765347034; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NmzdRNy+XVrnKgfA7Np3tADI6SbGw+r+ug99GdFxAXA=;
 b=h8mfNrtSzAGk+R50v6+ZsAAGFSEf53GVAX5lTIxjFQsZIgiSiZYdx3uVYpIabSXAgQ
 q2H96XyNsLshx+hhq/IFdvYHpFXjT4BeFr0f26PH6umYlLFRgYccQU1cTfZeCdbdUcVB
 Lmz4debdB08X2ehsokoeRhtNPo75XQDnnT/9Do3OkD9zhRbl95IilbBvUbjORzMW3iue
 SQXqVbDcuj1xEEYKrz/JUeYN4fSsTjaBlef8QxxGvEdSs7wCBnFAnIgrDPDp5+mXUg7a
 8YcrIRgB++WQ93Xq1pVlVcVJMe0T87NCbzhJa7FCxDL8JinixpvuOirQ/yj7Ga5PSicL
 zKZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764742234; x=1765347034;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NmzdRNy+XVrnKgfA7Np3tADI6SbGw+r+ug99GdFxAXA=;
 b=vWNtGzkAT6xGFo74nat1pcM0KX7knnpY0KW2+cKopg5hGigXuWSSJMk/fm1s+JRw8g
 E3atUX7P9jU0tcULXML1+noA+taSbxKRGJE2P2OL5L9M1eob6QOo68o1FP+nTYtMzZ2m
 FfrkC9pE8aBYQ6xUh/IlXe65Wgs8I2l6SUk9zYT4eXi4K0UrHOyZ5NxbHgcYmP4tgF/D
 Q4AtSoYOvWwveLiYFhCpVFSSNMLe7z4vi+UTyU/ZWQyYkLRXp0J9Rbj2SVGsu86z0CfH
 4eqhNsno+DZsGT5TWCvtlNEgp/peog2oGu4hq7/pv1csCHBtwWniC1RIqi70+ccKb9DR
 1lvA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU52q1CBkw2FokLbCO7ErEBka+6LE5SC9Tm6gYIShSDuKG0GQvlEm5BXNx3vfUzhvY1WNoQAeebpVnY@nongnu.org
X-Gm-Message-State: AOJu0YzUSsdTXV6LZLg1YM41vvMjGJJUpy0h2UkOIx23ao29T/unzr6I
 yE3DNrvD1TUmBXWlDDdDzpOeT4PcKX7Q48CeYjhl2RxnVwoFTVCTQhx1pPEES50WmEbKQ+zhgYE
 SfRB5VQc=
X-Gm-Gg: ASbGncu41M+6PuKdYJVQ1kT61dXz+m3NCbqT8Zmte9HHDuum94QIYC4r0nTlCX4NaHJ
 9NGZeVFBrxWGvcO4tgL/tstj2VjOfhdo3aUpzfmdWwJCup4EEaaE21yVp7RMeolReuKidnZOi48
 o5lNgaE2Wcs8FUtCCDf7L7JWx2aBUH69Bsnl7tgcqtcMlcMtPaplkTYdXJaPnPB/D8a5jcY8yHs
 sZ2rjwUqq+L0hy63a2p4D8qgGhOLht1Cmc3RCWPmufv5LsyULhn8EPIbNdcabCMzxWeV1k2yb4D
 bbCs9i8UINVMc2BSm8TmmiP+bXNSTuBhfgjE0ZJ06ah8f077PeHYfop+snPqGAayjFmNUT42OG2
 YwDmO15zpHhkPXw2HJHoroJd0J7Twi4D11L+lMATW24IvS08h/uY0+1D/hZqC+gW33cCwDv7uPC
 5nzDRluw41Wo0wqJD9Jq3AptrZAyuEMVFbM8ywdfFhRoLdgfrRqeh0hrGiBIXW
X-Google-Smtp-Source: AGHT+IEPApft5PGZWsFPz//8A8cqjaVIx5m13oFIf9W/WuBW9rwX9Y+20LttgbfbDUMnp9zRiB+bCw==
X-Received: by 2002:a05:600c:1f0d:b0:477:952d:fc00 with SMTP id
 5b1f17b1804b1-4792aef32d7mr9426015e9.12.1764742234286; 
 Tue, 02 Dec 2025 22:10:34 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42e1c5d6277sm37152129f8f.17.2025.12.02.22.10.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Dec 2025 22:10:33 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Zhao Liu <zhao1.liu@intel.com>,
	qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Igor Mammedov <imammedo@redhat.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-riscv@nongnu.org,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH-for-11.0 v6 07/13] hw/nvram/fw_cfg: Add fw_cfg_init_io_nodma()
 helper
Date: Wed,  3 Dec 2025 07:09:35 +0100
Message-ID: <20251203060942.57851-8-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251203060942.57851-1-philmd@linaro.org>
References: <20251203060942.57851-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

Calling fw_cfg_init_io_nodma(...) is more explicit
than fw_cfg_init_io_dma(..., 0, NULL).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/nvram/fw_cfg.h | 1 +
 hw/nvram/fw_cfg.c         | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/include/hw/nvram/fw_cfg.h b/include/hw/nvram/fw_cfg.h
index 7348cbfbc34..a2b8f7fa864 100644
--- a/include/hw/nvram/fw_cfg.h
+++ b/include/hw/nvram/fw_cfg.h
@@ -305,6 +305,7 @@ bool fw_cfg_add_file_from_generator(FWCfgState *s,
                                     Object *parent, const char *part,
                                     const char *filename, Error **errp);
 
+FWCfgState *fw_cfg_init_io_nodma(MemoryRegion *io, uint32_t iobase);
 FWCfgState *fw_cfg_init_io_dma(MemoryRegion *io, uint32_t iobase,
                                uint32_t dma_iobase, AddressSpace *dma_as);
 FWCfgState *fw_cfg_init_mem_nodma(hwaddr ctl_addr, hwaddr data_addr,
diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index 2699e593860..079c28f9212 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -1054,6 +1054,11 @@ static FWCfgState *fw_cfg_init_io_internal(MemoryRegion *iomem,
     return s;
 }
 
+FWCfgState *fw_cfg_init_io_nodma(MemoryRegion *iomem, uint32_t iobase)
+{
+    return fw_cfg_init_io_internal(iomem, iobase, 0, NULL);
+}
+
 FWCfgState *fw_cfg_init_io_dma(MemoryRegion *iomem, uint32_t iobase,
                                uint32_t dma_iobase, AddressSpace *dma_as)
 {
-- 
2.51.0


