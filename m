Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0983ACF6D25
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2024 13:28:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svzP1-0005EG-9O; Wed, 02 Oct 2024 09:28:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1svzOs-0005Dh-6P
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 09:28:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1svzOq-0007ts-I1
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 09:28:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727875694;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z+VvDVDKFYS1/82i/nMHdeQIrsk+nBd6/CLcGztnt+Y=;
 b=f9xxvY1byNM+1N70tCJO3C9Z44ClAoLYN7lED7LXySsCfydrmAiTN2oEJ23CyI7vDEKwMx
 Y2Y6Ro0oRpRnzwtLby8bFp0DpDaYScJxbXD2iAkDcCL3WuLJNDwNM1U+LFuog6+7GDHllO
 eF1hpFEam3nwq8u7YY6+popPMYdgJ+E=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-207-FgW0O33zPqekNdvLSUeamw-1; Wed, 02 Oct 2024 09:28:12 -0400
X-MC-Unique: FgW0O33zPqekNdvLSUeamw-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-37ce14d621aso2271832f8f.3
 for <qemu-devel@nongnu.org>; Wed, 02 Oct 2024 06:28:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727875691; x=1728480491;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z+VvDVDKFYS1/82i/nMHdeQIrsk+nBd6/CLcGztnt+Y=;
 b=CAWYtVDjvhVOUCWPhdRy8yjFRlTHMNCsQnY4ch8zlh28mAGiatq9IjXLgOGzbGAiGO
 BK7CbIhxy9FmHaYz87n+eoUvsvFREGjmBIXsamWh6Q/j9LD2nVzaxouuo8Pyvx/ybXKh
 sU0gsz2TfAyeqO5/x/FVptL69mNzjLdED9ik1Wm/E2Xk2h9yPIWQKnvypUWTdP4rGaYW
 b/opTaN3Njksbz/l4y2hwO5HTjsAviIP8nxD/fy/wZxB9C0KL5GGBwBrSSIHWWJAdKCa
 KEdWVVR1+O6OUib1v4+7APszWVc1bs0f6AIgjT4NnQeFXNpp8W1dbram4ld8xvDvVROH
 Dx5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbdJyfN94dlOjPWMnVkiUbAPGsNIc7HvlKgXoKU4/jjVuopPeaS+OMRUAYJ4mO4ODMFtWT0e5lvYGJ@nongnu.org
X-Gm-Message-State: AOJu0YxamNZwlrZEtHorqasMmXfeo9yKyUIjE0tbTidTpTuIWhbDK08T
 mCABqGDj4MTXc6sswEgsvaOvRQ+JYjcEpTvLTNQPW5097mPWeGHNh+Dvt8ToSL5tYmY8xNhXI9Z
 ESsHmxhmXtZnj8sUHLqme3RB8UX4mFwfXdAdw4Hp7Ud832jpBfDha
X-Received: by 2002:adf:f34f:0:b0:37c:d200:4fea with SMTP id
 ffacd0b85a97d-37cfb9d1efdmr1847903f8f.34.1727875690972; 
 Wed, 02 Oct 2024 06:28:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGImb7tRUCqw88TPMFN34Y/dIqnQmHnS519NkAmKtNWLDD0LoJUTCHo9IlXjyCys473aLHxEw==
X-Received: by 2002:adf:f34f:0:b0:37c:d200:4fea with SMTP id
 ffacd0b85a97d-37cfb9d1efdmr1847885f8f.34.1727875690582; 
 Wed, 02 Oct 2024 06:28:10 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42f79ed3e3fsm18631645e9.23.2024.10.02.06.28.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Oct 2024 06:28:10 -0700 (PDT)
Date: Wed, 2 Oct 2024 15:28:09 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Dongjiu Geng <gengdongjiu1@gmail.com>, linux-kernel@vger.kernel.org,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 04/15] acpi/ghes: better handle source_id and
 notification
Message-ID: <20241002152809.0dcc4013@imammedo.users.ipa.redhat.com>
In-Reply-To: <1b6ddd0bdfc9ac32a35fa7d85692e635bb76da11.1727766088.git.mchehab+huawei@kernel.org>
References: <cover.1727766088.git.mchehab+huawei@kernel.org>
 <1b6ddd0bdfc9ac32a35fa7d85692e635bb76da11.1727766088.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue,  1 Oct 2024 09:03:41 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> GHES has two fields that are stored on HEST error source
> blocks:
> 
> - notification type, which is a number defined at the ACPI spec
>   containing several arch-specific synchronous and assynchronous
>   types;
> - source id, which is a HW/FW defined number, used to distinguish
>   between different implemented hardware report mechanisms.
there could be several sources with the same
hardware report mechanisms /aka notification type/

s/between different implemented hardware report mechanisms/
  different implemented sources.




> Cleanup the logic to fill those, as they should be handled
> independently.

above doesn't really say/describe the patch's intent

> This is a preparation for a future patch that will shift
> those fields to the HEST init function call.

not relevant in this series

> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> ---
> 
> Chenges from v10:
> 
> - Some changes got moved to the previous patch.
> 
> Changes from v8:
> - Non-rename/cleanup changes merged altogether;
> - source ID is now more generic, defined per guest target.
>   That should make easier to add support for 86.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  hw/acpi/ghes.c | 23 +++++++++--------------
>  1 file changed, 9 insertions(+), 14 deletions(-)
> 
> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> index 4a6c45bcb4be..29cd7e4d8171 100644
> --- a/hw/acpi/ghes.c
> +++ b/hw/acpi/ghes.c
> @@ -284,9 +284,13 @@ static void build_ghes_error_table(GArray *hardware_errors, BIOSLinker *linker)
>  }
>  
>  /* Build Generic Hardware Error Source version 2 (GHESv2) */
> -static void build_ghes_v2(GArray *table_data, int source_id, BIOSLinker *linker)
> +static void build_ghes_v2(GArray *table_data,
> +                          BIOSLinker *linker,
> +                          enum AcpiGhesNotifyType notify,
> +                          uint16_t source_id)
>  {
>      uint64_t address_offset;
> +
>      /*
>       * Type:
>       * Generic Hardware Error Source version 2(GHESv2 - Type 10)
> @@ -316,18 +320,8 @@ static void build_ghes_v2(GArray *table_data, int source_id, BIOSLinker *linker)
>          address_offset + GAS_ADDR_OFFSET, sizeof(uint64_t),
>          ACPI_GHES_ERRORS_FW_CFG_FILE, source_id * sizeof(uint64_t));
>  
> -    switch (source_id) {
> -    case ACPI_HEST_SRC_ID_SEA:
> -        /*
> -         * Notification Structure
> -         * Now only enable ARMv8 SEA notification type
> -         */
> -        build_ghes_hw_error_notification(table_data, ACPI_GHES_NOTIFY_SEA);
> -        break;
> -    default:
> -        error_report("Not support this error source");
> -        abort();
> -    }
> +    /* Notification Structure */
> +    build_ghes_hw_error_notification(table_data, notify);
>  
>      /* Error Status Block Length */
>      build_append_int_noprefix(table_data, ACPI_GHES_MAX_RAW_DATA_LENGTH, 4);
> @@ -369,7 +363,8 @@ void acpi_build_hest(GArray *table_data, GArray *hardware_errors,
>  
>      /* Error Source Count */
>      build_append_int_noprefix(table_data, ACPI_GHES_ERROR_SOURCE_COUNT, 4);
> -    build_ghes_v2(table_data, ACPI_HEST_SRC_ID_SEA, linker);
> +    build_ghes_v2(table_data, linker,
> +                  ACPI_GHES_NOTIFY_SEA, ACPI_HEST_SRC_ID_SEA);
>  
>      acpi_table_end(linker, &table);
>  }


