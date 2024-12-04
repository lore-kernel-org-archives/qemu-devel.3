Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4FB0E77170
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 16:39:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIsOF-00026b-Ew; Wed, 04 Dec 2024 11:38:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tIsOA-00025j-Ke
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 11:38:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tIsO6-0001qG-Mh
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 11:38:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733330285;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I56T0jef1B9MebW55HaogqObbHI0foL5BjBnDVvFKBY=;
 b=TehPCWTlgalxcB4ar/jXRaT2yzdBHRr9082RU0DVjZ7U8BXb9hdGXB8TSRlwOLKUf6dHy+
 Ta902By3WFpu5dhDKBgI18/opLYoNWZ1wdjVXEtD36q/GkxsEmgUD03e2TqCWEHFGHXtP6
 Om912VPDO1rQxCJXVxT6YB6gJ6MlxK8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-318-C9DDie2vNHG17dvCxCHcYA-1; Wed, 04 Dec 2024 11:38:03 -0500
X-MC-Unique: C9DDie2vNHG17dvCxCHcYA-1
X-Mimecast-MFC-AGG-ID: C9DDie2vNHG17dvCxCHcYA
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-434a9861222so57159465e9.2
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2024 08:38:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733330282; x=1733935082;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I56T0jef1B9MebW55HaogqObbHI0foL5BjBnDVvFKBY=;
 b=jaAA9sBoN/oQOnCGu/QRcmL7asGAtSLPG5fTiZb5X20ujVn7QVtRHejyoATqNUQvTQ
 AbQbvAAvb/NdKW98BHvSS2KkjDyc0Ps80rvaC08Mln/VVn2IBEHxENKnqo2TNW3U1ofv
 f2pQOJ8QBkzK0dbW+qCCRI2jSjsREEq9UY7masZu9uiguDA+gdde9rDg+jmHS3HcrCYz
 zgwaHiCMxsfQIkkHBilHsRfejNK3h4mVA+7pwF6TKmV5SKKGeLE/YUMY3wfGGkbiOL+d
 BdfE3CUYXoP7sdO/oqFMHEDlS6i2RJa17RKpu+jy1Irk1Q+BzSv9szw+uMDlxQonG/Im
 2+aA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbiixpOGCiPNtoNc1sibs0SmjRaQXn02oB9/TSM+RyTMawQWMUfLVhqZjWY+j/ss4FNfvCzCQ5212G@nongnu.org
X-Gm-Message-State: AOJu0YxlPcgtHSfqYqsBy4V8Y2JNpA6REuPs4x/gGiCPYSy33cJkMRpN
 itRMn5OdByynv3QbxDn4Ae/hYKLLRo80QEB2yBoOo5ElVnS66keT0P3miw5SPS9iDv7pPira+5I
 ixDvocyPMqsDdubonwOSiGTL6yeS5HDJFyN+D7Kdz5Pn3KXNhgTwA
X-Gm-Gg: ASbGncuXd7aJ3MHI10/4w6qFkOi7bD2EZTcofd8kvItv1IjfzhKU9NWAK9MQV80SZUR
 IAzlK3PFfdHsaTRbOdOkD1VRB8BqKmBA1UD9NaKzG/43FL/1Go0wbWRVCPTq2RTk/zrBJADE4pf
 d3wLX87H040U9Ut8BNDTwGDb9TcPBfiDo59jnMYPaRyGwTCRE4YsKN/TYiwjHghj6NPQnHiocZ5
 KpFY837x3AgojHsfPErFilwOQ0t+bPuvf9lAnDbXB+JS6xzKeJx0g6UeAdFQljMZhqKGXujf32V
 ELpVXFuKdKDDjTgiajRMtg==
X-Received: by 2002:a05:600c:19d1:b0:434:a765:7f9c with SMTP id
 5b1f17b1804b1-434d09acf91mr64226135e9.6.1733330282485; 
 Wed, 04 Dec 2024 08:38:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGqhxb34XhNhR3Z5uEkWHHBS3X+fStnfGrP/o4WHuOKX8TwbFpardigflmA7xm7EucHBEKmgg==
X-Received: by 2002:a05:600c:19d1:b0:434:a765:7f9c with SMTP id
 5b1f17b1804b1-434d09acf91mr64225985e9.6.1733330282132; 
 Wed, 04 Dec 2024 08:38:02 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434d5280120sm29353435e9.20.2024.12.04.08.38.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Dec 2024 08:38:01 -0800 (PST)
Date: Wed, 4 Dec 2024 17:37:59 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 linux-kernel@vger.kernel.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v5 13/16] acpi/ghes: better name the offset of the
 hardware error firmware
Message-ID: <20241204173759.6f02561a@imammedo.users.ipa.redhat.com>
In-Reply-To: <20b003136d8c008fd54e8d40c806f13867336e13.1733297707.git.mchehab+huawei@kernel.org>
References: <cover.1733297707.git.mchehab+huawei@kernel.org>
 <20b003136d8c008fd54e8d40c806f13867336e13.1733297707.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Wed,  4 Dec 2024 08:41:21 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> The hardware error firmware is where HEST error structures are
      ^^^^^^^^^^^^^^^^^^^^^^^ I can't parse this, suspect you've meant something else here

> stored. Those can be GHESv2, but they can also be other types.
> 
> Better name the location of the hardware error.
> 
> No functional changes.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  hw/acpi/generic_event_device.c | 4 ++--
>  hw/acpi/ghes.c                 | 4 ++--
>  include/hw/acpi/ghes.h         | 2 +-
>  3 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
> index 663d9cb09380..17baf36132a8 100644
> --- a/hw/acpi/generic_event_device.c
> +++ b/hw/acpi/generic_event_device.c
> @@ -364,7 +364,7 @@ static const VMStateDescription vmstate_ghes = {
>      .version_id = 1,
>      .minimum_version_id = 1,
>      .fields = (const VMStateField[]) {
> -        VMSTATE_UINT64(ghes_addr_le, AcpiGhesState),
> +        VMSTATE_UINT64(hw_error_le, AcpiGhesState),
>          VMSTATE_END_OF_LIST()
>      },
>  };
> @@ -372,7 +372,7 @@ static const VMStateDescription vmstate_ghes = {
>  static bool ghes_needed(void *opaque)
>  {
>      AcpiGedState *s = opaque;
> -    return s->ghes_state.ghes_addr_le;
> +    return s->ghes_state.hw_error_le;
>  }
>  
>  static const VMStateDescription vmstate_ghes_state = {
> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> index 52c2b69d3664..90d76b9c2d8c 100644
> --- a/hw/acpi/ghes.c
> +++ b/hw/acpi/ghes.c
> @@ -359,7 +359,7 @@ void acpi_ghes_add_fw_cfg(AcpiGhesState *ags, FWCfgState *s,
>  
>      /* Create a read-write fw_cfg file for Address */
>      fw_cfg_add_file_callback(s, ACPI_HW_ERROR_ADDR_FW_CFG_FILE, NULL, NULL,
> -        NULL, &(ags->ghes_addr_le), sizeof(ags->ghes_addr_le), false);
> +        NULL, &(ags->hw_error_le), sizeof(ags->hw_error_le), false);
>  
>      ags->present = true;
>  }
> @@ -385,7 +385,7 @@ void ghes_record_cper_errors(const void *cper, size_t len,
>      }
>      ags = &acpi_ged_state->ghes_state;
>  
> -    start_addr = le64_to_cpu(ags->ghes_addr_le);
> +    start_addr = le64_to_cpu(ags->hw_error_le);
>  
>      start_addr += source_id * sizeof(uint64_t);
>  
> diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
> index 21666a4bcc8b..39619a2457cb 100644
> --- a/include/hw/acpi/ghes.h
> +++ b/include/hw/acpi/ghes.h
> @@ -65,7 +65,7 @@ enum {
>  };
>  
>  typedef struct AcpiGhesState {
> -    uint64_t ghes_addr_le;
> +    uint64_t hw_error_le;
>      bool present; /* True if GHES is present at all on this board */
>  } AcpiGhesState;
>  


