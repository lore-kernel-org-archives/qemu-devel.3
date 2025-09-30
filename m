Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18D2ACCA470
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 09:59:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3X71-00038u-V6; Tue, 30 Sep 2025 05:57:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsntk18@gmail.com>) id 1v3Wmx-0004VO-Lk
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 05:36:52 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <vsntk18@gmail.com>) id 1v3Wmp-0001h2-6D
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 05:36:51 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-afcb7a16441so931548666b.2
 for <qemu-devel@nongnu.org>; Tue, 30 Sep 2025 02:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759224998; x=1759829798; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IYB4a6nRiUdsdyEnHHCpEQNpTkh6ei0Uct+Ltx+xwnc=;
 b=PfjgVU4N4pKvjUxqzWvu0BTfh4blW4LnKgnu7NqMKmoqhtKyMa7N6odRu/jelihuUj
 Io6ISWU5UACerICwwqcUD+ktyvj8lM6w3WTbilCL7AgDL3mGezDNPuGOhUuDkRCruzB9
 ZeEZxaWt8RXAr+UM0zEPCitPwRW6OZjJ5eaGFo4N9ykKeVynK5R9ajjwdJOafsOqsJpo
 MkTsrSspuPq8wzLo7cyTn7X8KFlCCiwbPlu0d4wZ6Hhb5O/fiSBrcfK/NjsPw01exh7b
 ObdmGODDPT0+jWhy6MHFEP2QNSl78OfHrC9QVjFANb2Lr2j5L3Tqfbqxj6If+Cbu+ctD
 5JQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759224998; x=1759829798;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IYB4a6nRiUdsdyEnHHCpEQNpTkh6ei0Uct+Ltx+xwnc=;
 b=NCFa+vrJRB72rrbuJQ3NdeAQOyKMGJAy7TXIXhXZUudUU5bFoAgV9MnQ7TBrhEMIc8
 xLsHmkh55ZG4UdMs9kfmb8z2SNIvdrz9eLhWm9TcMe5S+EzBwDl/gQLA+0z6VjH3YGVl
 gU9iVS2mam/CDTKUb5VlsrFDnn3TwMqNYl1dT8CVtJejjNQsDgRcTPzHWsd0qACrXE05
 E+f1ez85zTI7SQ6c1drsxD1dkin5eOexClZfjVb9GMq43XyckGN5VLJJjwolUruKLEhO
 jQJ4ISyyEk0+MWB1tK1KBTdkUhWhRJgm0eZa7BPqNQl1sc4XHtllrmPEys+4b+hXNPwo
 6UrQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgAHRVAIW0OelEl6GwsECnkRx2DoeWs0OAQ1mkC+3aS/cOooUCFF/bN1B7UNHhAGElUVQkde/vHTzu@nongnu.org
X-Gm-Message-State: AOJu0YyPbnHYIvX7B2yJ6GtXzIUSpFwwDvJjVJ+4BNBk+0H006Dv14ke
 +krerh3q8FvtAqG6veygC4vjna9Mk+v19XadKWj4ReCWuQI7zHaD+BaB
X-Gm-Gg: ASbGncscmSXEpCklyp2TnIrgJJm0Xgzi9l0UpmrF4Tc+DBbYkjhErv+fZ4+v72o3pIk
 9pr6X2n/ZUNPsqOHyD859e+AMMziP0moIU76S++yvp0jA/EcYc54wcGT7dXh4qSmMO4Y4SE6HKt
 FlX5RhXU6yac3uwACavbt21/UDieO/bU8mIAXcII/3fSRK/G9c3KenT/dWlU0bOr2lH0Txh98Ks
 nHYXt1kjOIE1t/Rkaw5rNn1LLgWQ0VHCM6SwzaFDNF25M3rJh+qUpTjCYThXYilDdHgZB5awRAu
 e6KqQAsjHOLH1QQG+UllG29I5y6t3yKFq/IGr7bw26FqYzDD3ZEl1dcHC3GWRrLsbJxpe/asfNM
 GbS6MYXzJSSpO5yQ5/HD1E5LS4e3yZ2ZZ7Bstd7vnuy5VDC+HgjQ=
X-Google-Smtp-Source: AGHT+IG9L1Lwzem4vZVswo7Wt2wPXR8eh6T4QT19VLRvUzxkOmvOJpB2RVM0jSjCXqXcBVWECOs8QQ==
X-Received: by 2002:a17:907:6e8c:b0:b3f:c562:faf7 with SMTP id
 a640c23a62f3a-b3fc562fe27mr644277466b.55.1759224998338; 
 Tue, 30 Sep 2025 02:36:38 -0700 (PDT)
Received: from vasant-suse.suse.org ([81.95.8.245])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b3f57c9c2a9sm349178766b.71.2025.09.30.02.36.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Sep 2025 02:36:37 -0700 (PDT)
From: vsntk18@gmail.com
To: sarunkod@amd.com
Cc: Suravee.Suthikulpanit@amd.com, alejandro.j.jimenez@oracle.com,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, mst@redhat.com,
 pbonzini@redhat.com, philmd@linaro.org, qemu-devel@nongnu.org,
 richard.henderson@linaro.org, vasant.hegde@amd.com
Subject: Re: [PATCH v3 1/6] hw/i386/amd_iommu: Fix MMIO register write tracing
Date: Tue, 30 Sep 2025 11:36:36 +0200
Message-Id: <20250930093636.11796-1-vsntk18@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250801060507.3382-2-sarunkod@amd.com>
References: <20250801060507.3382-2-sarunkod@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=vsntk18@gmail.com; helo=mail-ej1-x62a.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 30 Sep 2025 05:57:28 -0400
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

>-static void amdvi_mmio_trace(hwaddr addr, unsigned size)
>+static inline uint8_t amdvi_mmio_get_index(hwaddr addr)
> {
>     uint8_t index = (addr & ~0x2000) / 8;
>
>    if ((addr & 0x2000)) {
>         /* high table */
>         index = index >= AMDVI_MMIO_REGS_HIGH ? AMDVI_MMIO_REGS_HIGH : index;
>-        trace_amdvi_mmio_read(amdvi_mmio_high[index], addr, size, addr & ~0x07);
>     } else {
>         index = index >= AMDVI_MMIO_REGS_LOW ? AMDVI_MMIO_REGS_LOW : index;
>-        trace_amdvi_mmio_read(amdvi_mmio_low[index], addr, size, addr & ~0x07);
>     }
>+
>+    return index;
>+}
>+
>+static void amdvi_mmio_trace_read(hwaddr addr, unsigned size)
>+{
>+    uint8_t index = amdvi_mmio_get_index(addr);
>+    trace_amdvi_mmio_read(amdvi_mmio_low[index], addr, size, addr & ~0x07);
>+}
>+
>+static void amdvi_mmio_trace_write(hwaddr addr, unsigned size, uint64_t val)
>+{
>+    uint8_t index = amdvi_mmio_get_index(addr);
>+    trace_amdvi_mmio_write(amdvi_mmio_low[index], addr, size, val,

Shouldn't you be picking between amdvi_mmio_low and amdvi_mmio_high in the
above 2 fuctions depending on the addr value?

