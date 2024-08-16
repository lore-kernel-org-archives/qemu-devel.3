Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3898C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 05:45:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seplY-0005qA-8W; Fri, 16 Aug 2024 01:44:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1seplW-0005iY-Ew; Fri, 16 Aug 2024 01:44:46 -0400
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1seplU-0007dm-Lk; Fri, 16 Aug 2024 01:44:46 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 01F9ACE0FFC;
 Fri, 16 Aug 2024 05:44:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C248BC32782;
 Fri, 16 Aug 2024 05:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1723787073;
 bh=o6LQ3/gXegMy3cUs5qQqcnaVukWZ6nZIPla8WlD0N+s=;
 h=Date:From:Cc:Subject:In-Reply-To:References:From;
 b=IhiRtDoLKm8lZjTy9j5xvhz+Mhi9jLbiqV55O5b4PAMebp2zW9lInqoI76EkGsFai
 8p/hWCuV4rjtZnpN/TZTpnLpaQhEi6I2OqFsagmSQLCKSj7wpIPNevwiPZJWWWVpP7
 ZyGEaCAK4p7RdwIeNsdEWBsjPOXwhxilMrOXB7y/DMJAkkMNWZ3bJKKw2QK+oUKdf6
 N7PVBaVrv0ni0PLufC0oALoj49Pi2uAYl8Oy7N9Ba0ZXe2D+/QnJKHr8XXf1+YHf0h
 qtGSjAQgcKS2cfKUKCovMCJ3SAgCUpQpEZcAAZRBc3GW8jZdjmd5Oc5bnMXyqKTt77
 VrVELMRT8Mz1g==
Date: Fri, 16 Aug 2024 07:44:27 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>, Igor Mammedov
 <imammedo@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Shannon
 Zhao <shannon.zhaosl@gmail.com>, linux-kernel@vger.kernel.org,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v7 05/10] acpi/ghes: rework the logic to handle HEST
 source ID
Message-ID: <20240816074427.2c7ae7d9@foz.lan>
In-Reply-To: <9f5843c6f774035e80a7a19e0091c347edff9d02.1723591201.git.mchehab+huawei@kernel.org>
References: <cover.1723591201.git.mchehab+huawei@kernel.org>
 <9f5843c6f774035e80a7a19e0091c347edff9d02.1723591201.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2604:1380:40e1:4800::1;
 envelope-from=mchehab+huawei@kernel.org; helo=sin.source.kernel.org
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.131,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MISSING_HEADERS=1.021, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Em Wed, 14 Aug 2024 01:23:27 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> escreveu:

This hunk is wrong:

> @@ -350,9 +380,10 @@ static void build_ghes_v2(GArray *table_data, int source_id, BIOSLinker *linker)
>      build_append_gas(table_data, AML_AS_SYSTEM_MEMORY, 0x40, 0,
>                       4 /* QWord access */, 0);
>      bios_linker_loader_add_pointer(linker, ACPI_BUILD_TABLE_FILE,
> -        address_offset + GAS_ADDR_OFFSET,
> -        sizeof(uint64_t), ACPI_GHES_ERRORS_FW_CFG_FILE,
> -        (ACPI_GHES_ERROR_SOURCE_COUNT + source_id) * sizeof(uint64_t));
> +                                   address_offset + GAS_ADDR_OFFSET,
> +                                   sizeof(uint64_t),
> +                                   ACPI_BUILD_TABLE_FILE,
> +                                   address_offset + GAS_ADDR_OFFSET);
>  
>      /*
>       * Read Ack Preserve field

It should be, instead:

    /*
     * Read Ack Register
     * ACPI 6.1: 18.3.2.8 Generic Hardware Error Source
     * version 2 (GHESv2 - Type 10)
     */
    address_offset = table_data->len;
    build_append_gas(table_data, AML_AS_SYSTEM_MEMORY, 0x40, 0,
                     4 /* QWord access */, 0);
    bios_linker_loader_add_pointer(linker, ACPI_BUILD_TABLE_FILE,
                                   address_offset + GAS_ADDR_OFFSET,
                                   sizeof(uint64_t),
                                   ACPI_HW_ERROR_FW_CFG_FILE,
                                   (ACPI_HEST_SRC_ID_COUNT + source_id) *
                                   sizeof(uint64_t));

Funny enough, even with this problem, error injection was working.

I'll be preparing a v8 with such fix applied.

I'll also add an optional patch at the end to double-check if the
links are properly generated, using an abort() in case something
ever goes wrong.

Regards,
Mauro

