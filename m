Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E7A4CA0EC0
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Aug 2025 21:12:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukqqM-0002nF-IP; Sat, 09 Aug 2025 17:11:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chichikalyuk@gmail.com>)
 id 1ukqqI-0002fO-UQ; Sat, 09 Aug 2025 17:11:08 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chichikalyuk@gmail.com>)
 id 1ukqqH-0000S5-0s; Sat, 09 Aug 2025 17:11:06 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-af93c3bac8fso458546666b.2; 
 Sat, 09 Aug 2025 14:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754773863; x=1755378663; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zLS1IfdtfCYJXwM0afrlw5a/dpGN+DNTjiPZRtgb6mU=;
 b=CPokN0siSZRs2G1dLycNhCRv2fjEzn9soiIGDUdVLmf6A8AjFXtqqyxux+9phHFM5e
 jrJ0e6xnVdK3bJWeeOnp+knR9qfYK0dfdZB9pbV5HdVMRJccqLs2G6/HEjVyRGdI4Up+
 V5+n2cJAf5E3bxH9xuOYJaqQ9L0YVafXj/gfacq6ax/vi89poa4b/Gs44rkq2uSGWqGr
 H4iXIpdjY7Tf9jPTMHw2zxcaBDrSniNCAJokIbL+J5n7kwe9L0XHC42bLr2h8kVEEtDb
 PcuQYiNZBa2pvWGYEmBTgcydxxs2T4azqOkFaCfmdnUCErapx1AptFt77HkKzCfbRiYi
 ugog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754773863; x=1755378663;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zLS1IfdtfCYJXwM0afrlw5a/dpGN+DNTjiPZRtgb6mU=;
 b=hJWjsc338SgUCY382IZkNM4dGcVTbBw6TdFFt3ZQAlGh+RHD8ldRCFNH0G6noMUivD
 uACp0/n4NEz+OFaJvj1P9O155k4jom4ez0dRnLfh6M+pnYNiY+rG0C0ed5XMzO4ZmcM9
 sIhOp/WvXgWum6WEIpFnDjX5mJyE41R+CwhPRR/wwHwPJbviLBYyLOhg34wMYwKS/Jrz
 dgVjeAyr4NEaUszbiRRJnCB3/P+Si1P7OyUvpxNBETLUEKScrDDnjqdCi7PTfgVfjgcb
 SuuDfYau+OyruNrUMlEv4N2qNF5YqVfjPhPRCoptVEm3B71I+Za0oeOlLiAGa8ybflbx
 2WUw==
X-Gm-Message-State: AOJu0YybmMl6f8uotRbj2qbz1XWgXIZltdfPxJzly0d76iXyoMMEGQ2N
 FJFaP9duVUsAPh+51xXOWHBiLSnHgImsixxa0th7ertbTIyVNKS/KJtdXL7QsFbNVu0=
X-Gm-Gg: ASbGncuMa5P+Y0eXo0+G9kt1xgxLVgdcuTbZunPn4XIyT3nIXph1TRe0vAZaZB4odRR
 ggDFIFRZuqmg3EmyjJ2hH6bvV/HMe81F7KadLwH+h60qC5/7GpFG5M0yW6Q4a5ItPqeLGEdOAXd
 fWbwIicZMZlDmstFCJw/O6En//OnOoSvLI5PahrDO9hnLLcV/uw+oWP0kea8K49S790L24QTGxb
 DnxB7j7i3m6boYwirnxPhe7btQca1v2oMEbdJrFK1oR2ztWuNGUw52CsN5QEf/ib7bIcye81iFf
 p+Z3xraV7RtFyCu0iWNhtBz726VKJy6HwkH+hrCbHMv86RDI2TwOOxQcHm5tBsgA0WKhBPV/AVV
 3JbIJZ/nrDN3KjQ84IDFEFWLvubZMZRPuU8XUUhxQ4mRl3jW8
X-Google-Smtp-Source: AGHT+IGCFF1z8GyfRrmlCjpSnUFgH0FFYvzAJ+qHVKUBVL6qRkb4x8p9ksfb15cd4u8okAx4NH9K8A==
X-Received: by 2002:a17:907:3e1d:b0:af9:3ad2:6923 with SMTP id
 a640c23a62f3a-af9c64f2230mr713317366b.38.1754773862559; 
 Sat, 09 Aug 2025 14:11:02 -0700 (PDT)
Received: from localhost.localdomain ([87.251.30.120])
 by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-af91a078a11sm1759490766b.7.2025.08.09.14.11.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 09 Aug 2025 14:11:02 -0700 (PDT)
From: Vadim Chichikalyuk <chichikalyuk@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Vadim Chichikalyuk <chichikalyuk@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 1/3] tests: acpi: whitelist expected blobs
Date: Sun, 10 Aug 2025 00:10:49 +0300
Message-Id: <20250809211051.68824-2-chichikalyuk@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250809211051.68824-1-chichikalyuk@gmail.com>
References: <20250809211051.68824-1-chichikalyuk@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=chichikalyuk@gmail.com; helo=mail-ej1-x62b.google.com
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

Signed-off-by: Vadim Chichikalyuk <chichikalyuk@gmail.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8b..a60794a3f6 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,2 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/aarch64/virt/SPCR",
-- 
2.39.5 (Apple Git-154)


