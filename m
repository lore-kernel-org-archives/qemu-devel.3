Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 441C5CAC5A5
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 09:05:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1LQL-0007na-0Y; Wed, 24 Sep 2025 05:04:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v1LQI-0007nP-Cf
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 05:04:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v1LQ9-0001JJ-Sb
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 05:04:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758704649;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dKC6/dwnXYAYIrOBVS6aVJM61MYv66umq/nc4ezfraA=;
 b=c6VAXTLMq7gZ5WpFBKit/PTlOXUgKUBW9rZ5JTwjA2CKQys/s9YhGl3X6Bv6VTVMddPC/u
 sNidA5fucP17A5U1aTFYN6UlqyHvZ3V+jCBWhPTD4l52U53V88r39VJMo1jbAqoVRc4Ob9
 /G+feIPB05kezW4gBF4EvqhqetVAzRw=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-33-vu_vo378PFOt568IZSIOfw-1; Wed, 24 Sep 2025 05:04:08 -0400
X-MC-Unique: vu_vo378PFOt568IZSIOfw-1
X-Mimecast-MFC-AGG-ID: vu_vo378PFOt568IZSIOfw_1758704647
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-b2f989de76eso71101166b.1
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 02:04:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758704647; x=1759309447;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dKC6/dwnXYAYIrOBVS6aVJM61MYv66umq/nc4ezfraA=;
 b=mbZGepAbQAMfex+7qSbvgrhKf7ogvLU4yzoVp3rkbuqZbR0tBZU4v/YXN5t41dYyWr
 GYk5rdrzumR4bU+nE2YcKT1b2L2gsD+GSGrtegaLWFeRKQBCRik40QhiUidsIohJjYbv
 s/Xfh2Bp+pshiqywreSCH/umUvsboCIqayyWMtMmSTAnYxIFYJWFGSQTYH7N5koJBhdV
 K+DooSqO5kYzLgobSZnKoxqY8X1FrjD5foNmI8PIqBiPpRlWHKrWnYDO8XP1pwyh3+bi
 NRXgKG2GHTKHYZKPUFsuhNekGMO35HYK5dh8gl4oZxWND7+OL3xcI8WwSCos3EFCnf6C
 91Pg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYMKUV9Hl8dmWpXl8qi3UOmWYtG7UwautF0ZLJLVUksT3BRRawW0uPKzBzCuPvkRT7AHebZcgGsZ7e@nongnu.org
X-Gm-Message-State: AOJu0YxYAmLR20nJAjP1oeL9zqyVEQHSOcZxd1Hv1Pu2Sbu1JL5WEAt/
 +kqjmOuZTwIX2kzn+fg+d9cuePNS4TXYssxhVyEwXDZt144vXcM+KnEPGBsR5hQeG+FViC5RaAW
 kShoT1Cea688yWVxYkbXaN2PdchtsjJaUXRFON/heyyzZo8rU3G4ArR64
X-Gm-Gg: ASbGncuaZtb2hpEjDGftIL6VtU5HgalsSWq/qRXihH68mUFn17/x36SZ4LbWMdy0Vn2
 TZiDKWbHLSs/snaW9u1uldH6jc+d1iZljGb8cycxU0n23pv7++lGIhodvz44QPqApLdoLMTiuad
 2/vjfCtO1gBLt2LlCq1Zm0G8rqnG1CDe8QXjzzGtKjUXJU+88WI+o/td6Y1GyLpdED6K7FaDKv2
 mlIiHaN+3HeZnkGI0kZbwh92wh6Nt0k60+diHsj3+wd6Fh9dCLboqS55eKtRHKrjX8LezB4oV1A
 GXupbmi4teO2LGbK2BGW8YHCGX63
X-Received: by 2002:a17:907:3d86:b0:b2e:13a:8d7a with SMTP id
 a640c23a62f3a-b32cbe865fdmr190406266b.31.1758704646936; 
 Wed, 24 Sep 2025 02:04:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFe0uLYtec8MDYgCpSJYCf1eyzPeW6qMI8xdRWsnLd/8hp9xmhrfsNL+Zt74VpudldkTCoJ6w==
X-Received: by 2002:a17:907:3d86:b0:b2e:13a:8d7a with SMTP id
 a640c23a62f3a-b32cbe865fdmr190402666b.31.1758704646330; 
 Wed, 24 Sep 2025 02:04:06 -0700 (PDT)
Received: from redhat.com ([31.187.78.57]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b2890e04727sm976046966b.4.2025.09.24.02.04.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Sep 2025 02:04:05 -0700 (PDT)
Date: Wed, 24 Sep 2025 05:04:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Bibo Mao <maobibo@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>, Song Gao <gaosong@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, WANG Xuerui <git@xen0n.name>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH 3/3] tests/data/acpi/loongarch64: Update expected DSDT.*
Message-ID: <20250924050304-mutt-send-email-mst@kernel.org>
References: <20250923143542.2391576-1-chenhuacai@kernel.org>
 <20250923143542.2391576-4-chenhuacai@kernel.org>
 <08a40419-c56e-4944-2a8e-045f0512fe04@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <08a40419-c56e-4944-2a8e-045f0512fe04@loongson.cn>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Sep 24, 2025 at 03:26:13PM +0800, Bibo Mao wrote:
> Add Michael
> 
> On 2025/9/23 下午10:35, Huacai Chen wrote:
> > DSDT diffs from "iasl -d":
> > 
> > @@ -11,7 +11,7 @@
> >    *     Signature        "DSDT"
> >    *     Length           0x000011FB (4603)
> >    *     Revision         0x01 **** 32-bit table (V1), no 64-bit math support
> > - *     Checksum         0x5D
> > + *     Checksum         0x5B
> >    *     OEM ID           "BOCHS "
> >    *     OEM Table ID     "BXPC    "
> >    *     OEM Revision     0x00000001 (1)
> > @@ -1426,11 +1426,11 @@
> >               Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
> >               {
> >                   Memory32Fixed (ReadWrite,
> > -                    0x100E001F,         // Address Base
> > +                    0x100E0020,         // Address Base
> >                       0x0000000C,         // Address Length
> >                       )
> >               })
> > -            OperationRegion (PRST, SystemMemory, 0x100E001F, 0x0C)
> > +            OperationRegion (PRST, SystemMemory, 0x100E0020, 0x0C)
> >               Field (PRST, ByteAcc, NoLock, WriteAsZeros)
> >               {
> >                   Offset (0x04),
> > 
> > Signed-off-by: Huacai Chen <chenhuacai@kernel.org>


this does what the patch says it does

Acked-by: Michael S. Tsirkin <mst@redhat.com>

up to maintainers to figure out if it's TRT

> > ---
> >   tests/data/acpi/loongarch64/virt/DSDT         | Bin 4603 -> 4603 bytes
> >   tests/data/acpi/loongarch64/virt/DSDT.memhp   | Bin 5824 -> 5824 bytes
> >   tests/data/acpi/loongarch64/virt/DSDT.numamem | Bin 4609 -> 4609 bytes
> >   .../data/acpi/loongarch64/virt/DSDT.topology  | Bin 4905 -> 4905 bytes
> >   tests/qtest/bios-tables-test-allowed-diff.h   |   4 ----
> >   5 files changed, 4 deletions(-)
> > 
> > diff --git a/tests/data/acpi/loongarch64/virt/DSDT b/tests/data/acpi/loongarch64/virt/DSDT
> > index b31841aec6ed296f10ea1695a67ead38f45424d5..55aa34f988d6ef69293e91c5fe45bee0a02bc5f1 100644
> > GIT binary patch
> > delta 44
> > zcmeyZ{9BpJCD<k8w;%%pWAsL@BfP>2415AS3=9mF4ABh%LBSymJPMm1@=CD)02#3h
> > APXGV_
> > 
> > delta 44
> > zcmeyZ{9BpJCD<k8w;%%pW9&w*BfP@$415AS3=9mF4ABh%LBSymJo1|#@=CD)02$8<
> > APXGV_
> > 
> > diff --git a/tests/data/acpi/loongarch64/virt/DSDT.memhp b/tests/data/acpi/loongarch64/virt/DSDT.memhp
> > index e291200fc91caa3d93dcd6ec4736f7340f5e3f65..c0955eb60448cc5f4d38d410abc260ae54ea2e9a 100644
> > GIT binary patch
> > delta 44
> > zcmX@0dq9`VCD<k8fEWV<W5PzRW+7n(20j5E1_p*ohUkWXpx_V&9)-;dgcMi+`vnS0
> > 
> > delta 44
> > zcmX@0dq9`VCD<k8fEWV<W70;hW+7pD20j5E1_p*ohUkWXpx_V&9{J4+gcMi+`y&cU
> > 
> > diff --git a/tests/data/acpi/loongarch64/virt/DSDT.numamem b/tests/data/acpi/loongarch64/virt/DSDT.numamem
> > index 07923ac39584c5a5e73c9556d251814ce10de6cc..61e47e7252155dcf9c76879c4f60f4b3eef63f86 100644
> > GIT binary patch
> > delta 44
> > zcmZovX;k5I33dr#6k=dte72G62(PdL1D^m70|P@PLv%wxP;dwXkHY4Myb3G;-$V)Z
> > 
> > delta 44
> > zcmZovX;k5I33dr#6k=dte6f-12(Pd_1D^m70|P@PLv%wxP;dwXkNoC`yb3G;-(m^%
> > 
> > diff --git a/tests/data/acpi/loongarch64/virt/DSDT.topology b/tests/data/acpi/loongarch64/virt/DSDT.topology
> > index 6dfbb495f88b74b87849b58473e46717bc588a56..b2afebc938ce45d798c8aa5f45a463f1617e257e 100644
> > GIT binary patch
> > delta 44
> > zcmZ3fwo;ADCD<iIQ<#B)@!UqPBfP>2415AS3=9mF4ABh%LBSymJPMm1@_MiW0PuGT
> > Ag8%>k
> > 
> > delta 44
> > zcmZ3fwo;ADCD<iIQ<#B)@xn%~BfP@$415AS3=9mF4ABh%LBSymJo1|#@_MiW0PvLx
> > Ag8%>k
> > 
> > diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
> > index 2ed837faee..dfb8523c8b 100644
> > --- a/tests/qtest/bios-tables-test-allowed-diff.h
> > +++ b/tests/qtest/bios-tables-test-allowed-diff.h
> > @@ -1,5 +1 @@
> >   /* List of comma-separated changed AML files to ignore */
> > -"tests/data/acpi/loongarch64/virt/DSDT",
> > -"tests/data/acpi/loongarch64/virt/DSDT.memhp",
> > -"tests/data/acpi/loongarch64/virt/DSDT.numamem",
> > -"tests/data/acpi/loongarch64/virt/DSDT.topology",
> > 


