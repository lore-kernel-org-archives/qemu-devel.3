Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFA18CCFA1A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Nov 2025 12:59:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJARA-0000h7-KA; Wed, 12 Nov 2025 07:59:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vJA1W-0001MS-IA
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 07:32:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vJA1T-0006I6-8X
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 07:32:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762950743;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vxT9WdJ1BjFAeF0qA6fL+iV1TCBCgsDvlXsPuyn8QRU=;
 b=fvcHNm2oAGq11G+h1vGHp/vCiM2Tp0UEWs0D1BfnT750P3ctLGlX0duiyRIcNcLcfplfdz
 gryWtNcStlBLg9pgyHAZR8yEViZzF7gHj5BuPqdrN8CoPq6J/beIS2Q5qFMAzwGdtw8iao
 CCpkM8HgoDxkVvTCVYY3UI05rOlhC+Q=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-_3goFazyMq66tWLK_vSE6Q-1; Wed, 12 Nov 2025 07:32:21 -0500
X-MC-Unique: _3goFazyMq66tWLK_vSE6Q-1
X-Mimecast-MFC-AGG-ID: _3goFazyMq66tWLK_vSE6Q_1762950740
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4775f51ce36so8770935e9.1
 for <qemu-devel@nongnu.org>; Wed, 12 Nov 2025 04:32:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762950740; x=1763555540; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vxT9WdJ1BjFAeF0qA6fL+iV1TCBCgsDvlXsPuyn8QRU=;
 b=cosyi8jsXYKeTN8X/jXX98K0tzUFDw9tj6ywPaeTZxr8E2dojV8af4XCzGcmaRiWu0
 OYTqyloG9zhc2l8TmBOt4YkccU4b8B+dJYQvbRncwhBrinxMZlJ3lMXW5hgDbzB8WG1B
 wt79dmOvUtE3CQPBH4FXmuMeuW/R6SxaqG523CPxFxA+vLSasLadENYYCoEiYV2iH9oP
 wyVSvnadElOHtZpAfxkK7V2XfSfdmd772XhDBNRVOJ+U8zM7NplsSlanLsW8j8qfhjVw
 x77dbHhQRxcM4KE4YBxUr9ou2re/xh9wiXGsFw0O/p37iFSJbk2X+KzTIWfNAxqGmRoF
 a37Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762950740; x=1763555540;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vxT9WdJ1BjFAeF0qA6fL+iV1TCBCgsDvlXsPuyn8QRU=;
 b=miS6yHNjnVr3yW0tdlp3avwcxnb+jCT/ehBYD5Fu4F2e4Mjm4wxqHRQuYLXo7jOa7G
 3IVW72N2oQiSsdPAKMz6Gs1E+DtWyxDQnGGRRlQ878Xd4Xo6TBNM8CPfrGLMw++KosbZ
 Mdj8MEojnpCWqxQj7Nv4mTdJCVDSs9MtYnqMVxGXJy8x2GD1xMOP1D0EkVpNUEZkLQ5y
 TMMSra98luI0RIJotxlIKHySI/JZBB1wHuJgmv4sBQMR6QbPWqCpvKP2dsWFOtkFPJTE
 xM1/1cesAcNPgLGamEGSMRIZeC/krUmX4uhBKtOL6jhx38L4fhu06D0jyvK5nUlID+tw
 vp5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUm+rx+p+JXNm9txK13w7xfMWcvGxNSvrrL/cfDfYS/XiadrAWvXkeCq98yKAX28Tgs4f69GrbSrA2U@nongnu.org
X-Gm-Message-State: AOJu0YxJIszeanPLaPzhracddP/hFj0r2qR3JeQG4RY5dahdj+OKBo07
 jF7p6PgSW3owOuLgktSE9QyO2qfMcwzx1Ede5qJruR2F3E8RVfTJ8ctHCFxUMOIYZekgmLFNkQs
 eHRB+cC21EFw+Cvmfllm3CUKhFFXvOkU9L/YFP7noSLyEDsvgsgpkiLPH
X-Gm-Gg: ASbGnctfQ733LHJIiLdyVAzELuplpk3b9dV2W8avixzKgZrxqs0NoVVrKSuGE0+NMxi
 g//RqAdBtNNCLkdrdfDOma4zFSLvQFy1I8CUkKy4afLywJjEs2QjHe4pQ3qEPjK1ttR/iSgmbTq
 0w9XN63Z9rvamdJvHri5YMmcaUI16a2jEdGalwGXqQqVfbi0NPtf+WJ1dBgQ/RDVRuYTJ2uZK8F
 lhCOMQCpo9Lf1KdHPC9/Vc6GM4uZRbaop/HquQu+o1qHi6hgFdl5jo5pkcMNqOsyvCgkd1CavY6
 c3PGQ7B0gpTHQA9hoTzNXGcrlAqVYVjzdo2SxBLP6BTEt6Ofg0wkye9vQXebBdbYEA==
X-Received: by 2002:a05:600c:1f92:b0:477:7c45:87b2 with SMTP id
 5b1f17b1804b1-4778704da1amr20021085e9.16.1762950739978; 
 Wed, 12 Nov 2025 04:32:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGSjpd2GNdosu1RgxYNDbIJeXmmc28+oUokHi94BvSmN0CH5DZGGDbioto1+EJzxF66m4cXRg==
X-Received: by 2002:a05:600c:1f92:b0:477:7c45:87b2 with SMTP id
 5b1f17b1804b1-4778704da1amr20020865e9.16.1762950739519; 
 Wed, 12 Nov 2025 04:32:19 -0800 (PST)
Received: from fedora ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47787e36ca3sm36857995e9.5.2025.11.12.04.32.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Nov 2025 04:32:19 -0800 (PST)
Date: Wed, 12 Nov 2025 13:32:17 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Gavin Shan <gshan@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, jonathan.cameron@huawei.com,
 mchehab+huawei@kernel.org, gengdongjiu1@gmail.com, mst@redhat.com,
 anisinha@redhat.com, peter.maydell@linaro.org, pbonzini@redhat.com,
 shan.gavin@gmail.com
Subject: Re: [PATCH v3 2/8] acpi/ghes: Increase GHES raw data maximal length
 to 4KiB
Message-ID: <20251112133217.41cc6df8@fedora>
In-Reply-To: <de9e6c46-6682-488e-bb50-9ce43ffaaa8e@redhat.com>
References: <20251105114453.2164073-1-gshan@redhat.com>
 <20251105114453.2164073-3-gshan@redhat.com>
 <20251110151107.5e825ea0@fedora>
 <de9e6c46-6682-488e-bb50-9ce43ffaaa8e@redhat.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, 11 Nov 2025 14:05:23 +1000
Gavin Shan <gshan@redhat.com> wrote:

> Hi Igor,
> 
> On 11/11/25 12:11 AM, Igor Mammedov wrote:
> > On Wed,  5 Nov 2025 21:44:47 +1000
> > Gavin Shan <gshan@redhat.com> wrote:
> >   
> >> The current GHES raw data maximal length isn't enough for 16 consecutive
> >> CPER errors, which will be sent to a guest with 4KiB page size on a
> >> erroneous 64KiB host page. Note those 16 CPER errors will be contained
> >> in one single error block, meaning all CPER errors should be identical
> >> in terms of type and severity and all of them should be delivered in
> >> one shot.
> >>
> >> Increase GHES raw data maximal length from 1KiB to 4KiB so that the
> >> error block has enough storage space for 16 consecutive CPER errors.
> >>
> >> Signed-off-by: Gavin Shan <gshan@redhat.com>
> >> ---
> >>   docs/specs/acpi_hest_ghes.rst | 2 +-
> >>   hw/acpi/ghes.c                | 2 +-
> >>   2 files changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/docs/specs/acpi_hest_ghes.rst b/docs/specs/acpi_hest_ghes.rst
> >> index aaf7b1ad11..acf31d6eeb 100644
> >> --- a/docs/specs/acpi_hest_ghes.rst
> >> +++ b/docs/specs/acpi_hest_ghes.rst
> >> @@ -68,7 +68,7 @@ Design Details
> >>       and N Read Ack Register entries. The size for each entry is 8-byte.
> >>       The Error Status Data Block table contains N Error Status Data Block
> >>       entries. The size for each entry is defined at the source code as
> >> -    ACPI_GHES_MAX_RAW_DATA_LENGTH (currently 1024 bytes). The total size
> >> +    ACPI_GHES_MAX_RAW_DATA_LENGTH (currently 4096 bytes). The total size  
> > 
> > is it safe to bump without compat glue?
> > 
> > consider VM migrated from old QEMU to new one,
> > it will have  etc/hardware_errors allocated with 1K GESB,
> > and more importantly error_block_addressN will have 1K offsets as well
> > 
> > however with ACPI_GHES_MAX_RAW_DATA_LENGTH all length checks will
> > let >1K blocks to be written into into 1K 'formated' etc/hardware_errors.
> > 
> > Thanks to previous refactoring we get all addresses right (1K version),
> > but if you write large GESB there it will either overlap with the next GESB
> > or a smaller GESB might overwrite tail of preceding large one.
> > And in works case it's OOB when writing large GESB in the last block.
> > 
> > Given we have to write GESB successfully or abort, there is no point
> > in adding compat knobs. But we still need to check if GEBS will fit into
> > whatever block size etc/hardware_errors inside guest RAM is laid out originally.
> >   
> 
> Good point. You're right that we're not safe for migration from old QEMU to
> and new QEMU. So I think I need to bump vmstate_hest_state::minimum_version_id
> in generic_event_device.c ?

that won't help,
what would help is creating compat property (in the owner of GHES MMIO registers),
and lower limits (to former value) for older machine types.
That way sizes would match even if you do ping pong migration
between old qemu and new one, since one would still be using old machine type
for that.

> 
> 
> >>       for the "etc/hardware_errors" fw_cfg blob is
> >>       (N * 8 * 2 + N * ACPI_GHES_MAX_RAW_DATA_LENGTH) bytes.
> >>       N is the number of the kinds of hardware error sources.
> >> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> >> index 06555905ce..a9c08e73c0 100644
> >> --- a/hw/acpi/ghes.c
> >> +++ b/hw/acpi/ghes.c
> >> @@ -33,7 +33,7 @@
> >>   #define ACPI_HEST_ADDR_FW_CFG_FILE          "etc/acpi_table_hest_addr"
> >>   
> >>   /* The max size in bytes for one error block */
> >> -#define ACPI_GHES_MAX_RAW_DATA_LENGTH   (1 * KiB)
> >> +#define ACPI_GHES_MAX_RAW_DATA_LENGTH   (4 * KiB)
> >>   
> >>   /* Generic Hardware Error Source version 2 */
> >>   #define ACPI_GHES_SOURCE_GENERIC_ERROR_V2   10  
> 
> Thanks,
> Gavin
> 


