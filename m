Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C53CCF31B7
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2024 12:39:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svycj-000260-JD; Wed, 02 Oct 2024 08:38:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1svyci-00025q-2d
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 08:38:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1svycd-0001aZ-DM
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 08:38:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727872706;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nUycqu6EqSC60iYvDsl+Om1SzAibDAMectWvdn0BXWc=;
 b=SJXWLBGaAss/sh69eocpbTHURXZ/LglWyo1QKG9kcxHf0cRPKhdzpKHnHEYs/vYtFeMx9D
 29Ll7MFpJNQ/kiK3fo0ktcTevtg/i9PGjWLf7YPKiar2MfLM2xdLkfXqrwnLqX6BaNRL4+
 3EzQfyBAyy9OKnlYvP8TVG6MVb6cLJk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-zkRrVqaRM5mKwNTXU3LZJg-1; Wed, 02 Oct 2024 08:38:22 -0400
X-MC-Unique: zkRrVqaRM5mKwNTXU3LZJg-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-42cb940cd67so66288725e9.0
 for <qemu-devel@nongnu.org>; Wed, 02 Oct 2024 05:38:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727872701; x=1728477501;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nUycqu6EqSC60iYvDsl+Om1SzAibDAMectWvdn0BXWc=;
 b=eZ/l6qc8mGLq49IUaPsdTNHyEsywAdixc27Gp1EUgFjLNLe5Lnfltq4YeIdeDQHUJV
 pSA+NfBg5XwpSMg/Q7XdjIQ0vUjhsf9Kvot2WqItFWO9ezf5BGq6XsV85gq6MjBUS7pB
 YRnkWTBXPMfImAhyg+G+xERCSPf/qAdkVux3Wu9u8vwWzI1cThkszQxy+EBG2s2LohsG
 ZC1qhdNv6qbNc1lvuj9wkts5vt4b5f2W89sJiGJy9YO33nMCgYp38KxXix89/0wru8KF
 HFPZG8nkuJGmIh7wjmeDMEQmkEGta7dwDFsXtdlTiwq3DB0Vsvfxd+vumjXb2ZIGl6f2
 Az3Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXfn6QS1QaOv/fHOS5UslA3Z5FeGaFy6G87YFd0Nviir9qBzK54gB7P6mNP5q2GuJv8vzwEfU/ZbUOK@nongnu.org
X-Gm-Message-State: AOJu0YzxyiUIxopoT1lHAfQyw2x1zDXHaKWQ6C5vlPl5yess/c9Eez1+
 QvgYWpCnDclx8j4UJBhJq6W394bedBXi+eOJymy5ryvqouxGQnbNGg+s9eZfB2/pUFAc1m3Rp4/
 E/7JJX+h6ozle4xxikiDso7LWl9sy4/vj3fLxJfmgl91V3kRLz1IV
X-Received: by 2002:a05:6000:c9:b0:37c:d2e3:1298 with SMTP id
 ffacd0b85a97d-37cfba19c9amr2701950f8f.55.1727872701313; 
 Wed, 02 Oct 2024 05:38:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGM3GfOi2lkguW+zchNgFC917E3/BtHmefG60ZH994PbjW8zP0KkoN/vzUw316qUHGQh1fseA==
X-Received: by 2002:a05:6000:c9:b0:37c:d2e3:1298 with SMTP id
 ffacd0b85a97d-37cfba19c9amr2701917f8f.55.1727872700825; 
 Wed, 02 Oct 2024 05:38:20 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cd572fbdfsm13859274f8f.79.2024.10.02.05.38.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Oct 2024 05:38:20 -0700 (PDT)
Date: Wed, 2 Oct 2024 14:38:19 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Dongjiu Geng <gengdongjiu1@gmail.com>, linux-kernel@vger.kernel.org,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 14/15] acpi/ghes: better name the offset of the
 hardware error firmware
Message-ID: <20241002143819.281ea155@imammedo.users.ipa.redhat.com>
In-Reply-To: <b74975e46f321d5e7e4c3f566d1d8827c83f33e7.1727766088.git.mchehab+huawei@kernel.org>
References: <cover.1727766088.git.mchehab+huawei@kernel.org>
 <b74975e46f321d5e7e4c3f566d1d8827c83f33e7.1727766088.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue,  1 Oct 2024 09:03:51 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> The hardware error firmware is where HEST error structures are
> stored. Those can be GHESv2, but they can also be other types.
> 
> Better name the location of the hardware error.
> 
> No functional changes.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com> 

> ---
>  hw/acpi/generic_event_device.c | 4 ++--
>  hw/acpi/ghes.c                 | 4 ++--
>  include/hw/acpi/ghes.h         | 2 +-
>  3 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
> index 15b4c3ebbf24..d4dbfb45e181 100644
> --- a/hw/acpi/generic_event_device.c
> +++ b/hw/acpi/generic_event_device.c
> @@ -346,7 +346,7 @@ static const VMStateDescription vmstate_ghes = {
>      .version_id = 1,
>      .minimum_version_id = 1,
>      .fields = (const VMStateField[]) {
> -        VMSTATE_UINT64(ghes_addr_le, AcpiGhesState),
> +        VMSTATE_UINT64(hw_error_le, AcpiGhesState),
>          VMSTATE_END_OF_LIST()
>      },
>  };
> @@ -354,7 +354,7 @@ static const VMStateDescription vmstate_ghes = {
>  static bool ghes_needed(void *opaque)
>  {
>      AcpiGedState *s = opaque;
> -    return s->ghes_state.ghes_addr_le;
> +    return s->ghes_state.hw_error_le;
>  }
>  
>  static const VMStateDescription vmstate_ghes_state = {
> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> index 3d03506fdaf8..8b3292be07e7 100644
> --- a/hw/acpi/ghes.c
> +++ b/hw/acpi/ghes.c
> @@ -379,7 +379,7 @@ void acpi_ghes_add_fw_cfg(AcpiGhesState *ags, FWCfgState *s,
>  
>      /* Create a read-write fw_cfg file for Address */
>      fw_cfg_add_file_callback(s, ACPI_HW_ERROR_ADDR_FW_CFG_FILE, NULL, NULL,
> -        NULL, &(ags->ghes_addr_le), sizeof(ags->ghes_addr_le), false);
> +        NULL, &(ags->hw_error_le), sizeof(ags->hw_error_le), false);
>  
>      ags->present = true;
>  }
> @@ -430,7 +430,7 @@ void ghes_record_cper_errors(const void *cper, size_t len,
>      }
>      ags = &acpi_ged_state->ghes_state;
>  
> -    get_ghes_offsets(le64_to_cpu(ags->ghes_addr_le),
> +    get_ghes_offsets(le64_to_cpu(ags->hw_error_le),
>                       &cper_addr, &read_ack_register_addr);
>  
>      if (!cper_addr) {
> diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
> index 051a9322141f..e47ffacbb5c9 100644
> --- a/include/hw/acpi/ghes.h
> +++ b/include/hw/acpi/ghes.h
> @@ -58,7 +58,7 @@ enum AcpiGhesNotifyType {
>  };
>  
>  typedef struct AcpiGhesState {
> -    uint64_t ghes_addr_le;
> +    uint64_t hw_error_le;
>      bool present; /* True if GHES is present at all on this board */
>  } AcpiGhesState;
>  


