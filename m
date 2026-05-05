Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69429CD3427
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 20:29:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKMMP-0004dL-5d; Tue, 05 May 2026 16:27:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wKMML-0004ZD-Hq
 for qemu-devel@nongnu.org; Tue, 05 May 2026 16:27:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wKMMJ-0002fS-3d
 for qemu-devel@nongnu.org; Tue, 05 May 2026 16:27:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778012830;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UrdJvZlwcHz7aiZ2PAnafLIUZGKxAgtWgdAZUAhTr6E=;
 b=RqzPbWI4+yvYqBeV1CCNFh7sAGO3h/Dy5EUljN9JD2GrZ5u6O5kCiRtc5U48xotNWg26Wa
 BNhrmL5JeKUtm3JXTBV5gSHxo8RZ5V5BAtysQavSGowwC/cWfevkRDgY6EZ8rYo1H348XR
 7M5c7mXf6s/05XPRiXzvZxtbWjePf1E=
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-280-ax-VDKlwMP-XHDhM3CqKTg-1; Tue, 05 May 2026 16:27:08 -0400
X-MC-Unique: ax-VDKlwMP-XHDhM3CqKTg-1
X-Mimecast-MFC-AGG-ID: ax-VDKlwMP-XHDhM3CqKTg_1778012828
Received: by mail-vs1-f71.google.com with SMTP id
 ada2fe7eead31-62f30279e90so2381900137.0
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 13:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1778012828; x=1778617628; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UrdJvZlwcHz7aiZ2PAnafLIUZGKxAgtWgdAZUAhTr6E=;
 b=MURegrAvqCmj9MQn8VXohb2TiCgXTacphvWGB0r9ADB7UJE7q5PlwYeectXZLrX0cg
 kh5KoXwz+YWfZU3gcw6QYAKT/JLyiXl18JpzPrJ4Ijua8Epy8ZRZFrXE/gNAejWXT/7a
 9IvDP92sgOKwzrVkf17owlkxQC6CfX0Et1EANWw+wUTbsKcNA0aQ8zb0Xx8OitsXYkZL
 wz8TDerFdN9Y5UCZLGqhgeLrjOaYA7u/gvQ0lv6jGYYFUFB9y1cHNQhjIWterkKnOJUw
 o7/Fj2HEqYqyy7qxgF6TBpbCOZ6SA7WK2RKGR25gOlXDd0witzYJTVxf7gyOR5VuCjci
 Xe6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778012828; x=1778617628;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UrdJvZlwcHz7aiZ2PAnafLIUZGKxAgtWgdAZUAhTr6E=;
 b=UNaxbrRKLkINoPUcAaEWU0rQBlwSWgQrIpzi+107LvpY083n9nKHc1JdjhQfZz9L5A
 tDCd+ZkT/pLlrGmciRToOSaIVsk+1BVS7hpJtei/j5pn4tfflFFcJh5AAYZVb9IU2tzc
 BHda/+8w6O/NK5K2ZAORYwk0P3Q04l6aWJNPYcHIwL4EuH0D2LkJZ2til14axeRxSLCz
 fhcT4L18ajWDwfam3fBBH6hU3vuE0/DDM5YgQy0k0VqeEAZT5eLm27di9EkpxhU8D45U
 C4JLe4pyQT2IkH+uqhlG8CbKovAP8XZmX6Y5yONDzzeRNkRW2I+0fBmtd9yrvwkSATKd
 jdaw==
X-Gm-Message-State: AOJu0YxhbBcLa9HrluHNxrKHZg2G0Q8nVQzIqFc54k2haHa0bH188nTO
 zjYT3LNaYdHmXI2gNvf8whJ19UnSGzHvYAV7e/1TbMSJ5apXIju23VI/VDEWPlIVXF20DNb9zS1
 N4XKlSygY1n4by68iFpxOw2CGvo2k9ofMKVOhOA0q76/1Cj4JxuDOVxBjicAuG4uOT7L6B5a4BC
 8DqT1GyiwEl9DSV4fyUobywAR45tNs7pHTFyXbFA==
X-Gm-Gg: AeBDietFUuHHi1EP9VEAA2eoBWRcXRAsvxAX2+MNZpMS9gPmvgYf/RnSHP2sbvEioiZ
 FIymJicA+1npq/JCFhW0rg/331V6ojYOz2sNv3zP2MOPKuUhUFDSECsoJFujFKVeC+RprbWqxSi
 FT41iMZUDOBbcmDX11GvSMSUpA92aaoruTsP05OUL8I3ieaUL+k00H2emvFw5vhF3rGrjgJPNUw
 9KodJ8O5WR9fdvkeHHYVjM30BmkYs7mEgvdbbTyYbB3dqS7X4D3Ta9auEdF/IwRzGOTz16yzsUT
 U9KPTNbxQEYp4IJdpgB/Bs2krMGcwseIpmgNvGTMOPQRvunb5eD4g3IBzMnahdYrWpqvXmuI93i
 TLRjl84itVPm2oBgieyXLmHWduLVQDD66cNWGUwPW2Buf/3sqyIPrpPo=
X-Received: by 2002:a05:6102:374d:b0:611:e0c2:1604 with SMTP id
 ada2fe7eead31-630f8fcf085mr136593137.19.1778012827446; 
 Tue, 05 May 2026 13:27:07 -0700 (PDT)
X-Received: by 2002:a05:6102:374d:b0:611:e0c2:1604 with SMTP id
 ada2fe7eead31-630f8fcf085mr136396137.19.1778012825823; 
 Tue, 05 May 2026 13:27:05 -0700 (PDT)
Received: from x1.com ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b53c6b8123sm155283806d6.35.2026.05.05.13.27.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 13:27:05 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>, CJ Chen <cjchen@igel.co.jp>,
 Tomoyuki Hirose <hrstmyk811m@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 19/23] hw/riscv: iommu-trap: remove .impl.unaligned = true
Date: Tue,  5 May 2026 16:26:36 -0400
Message-ID: <20260505202640.1011006-20-peterx@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260505202640.1011006-1-peterx@redhat.com>
References: <20260505202640.1011006-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: CJ Chen <cjchen@igel.co.jp>

The riscv_iommu_trap_ops MemoryRegionOps specifies that
unaligned accesses are not valid for this device but that
it does implement them. This doesn't make much sense, and
we want to add an assertion that registered MRs don't specify
this invalid combination of settings.

Drop .impl.unaligned = true, with no behaviour change.

Signed-off-by: CJ Chen <cjchen@igel.co.jp>
Acked-by: Tomoyuki Hirose <hrstmyk811m@gmail.com>
Reported-by: Tomoyuki Hirose <hrstmyk811m@gmail.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
[PMM: reworded commit message]
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Link: https://lore.kernel.org/r/20260428093339.2087081-2-peter.maydell@linaro.org
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/riscv/riscv-iommu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index 7ba3240552..2b40ab2ce0 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -2434,7 +2434,6 @@ static const MemoryRegionOps riscv_iommu_trap_ops = {
     .impl = {
         .min_access_size = 4,
         .max_access_size = 8,
-        .unaligned = true,
     },
     .valid = {
         .min_access_size = 4,
-- 
2.53.0


