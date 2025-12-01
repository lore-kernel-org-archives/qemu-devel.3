Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A08DED111A8
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Dec 2025 10:18:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQ0t3-0006ed-Fw; Mon, 01 Dec 2025 05:12:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vQ0s1-0005bH-DF
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 05:11:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vQ0rv-0003uE-AP
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 05:10:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764583853;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fGWVhcC4zjG8nxxiobd1UE6Tl65JHRQxp9PlIbFY48Q=;
 b=AWt/g+ppA8jd4nGB861Jcq1IYSC00azSAWYZrxfUBVxdX8kUwMwnkLwI2DUMEx9pwdk9T5
 DlUH++wMjXH+z/ibCwPGnP98hTyocUdQmXvYIWelajuUs7xoKfMuW30y6jXARZf2Cd8FNB
 xoct515JUIgFZKn0BFMmW9+/a8IMdD8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-468-viJASJNLN2GUp-hQ_HwSCg-1; Mon, 01 Dec 2025 05:10:51 -0500
X-MC-Unique: viJASJNLN2GUp-hQ_HwSCg-1
X-Mimecast-MFC-AGG-ID: viJASJNLN2GUp-hQ_HwSCg_1764583850
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-42b2ffe9335so3569504f8f.1
 for <qemu-devel@nongnu.org>; Mon, 01 Dec 2025 02:10:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764583850; x=1765188650; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fGWVhcC4zjG8nxxiobd1UE6Tl65JHRQxp9PlIbFY48Q=;
 b=CN7Wm3fnJm/nIX2VuNgOVxPLxHLhmWE35XxO0P9hMwXCPcFAE7XRT1ipoJZkJ5szfK
 ULi99bPeOdCRm7ege7TtrG0R2xWXxVauS5JCpFriHvzYZ2MZ58BU+OiLbg7tyqdl+OXA
 0JzCva/iojmb04vasCz6St1oVD7a2rgJgyjkTs8xs0K+z53SodvydPmlGy4iKKMoqCFx
 XuMt3/cf+9jLGXy2pD07XuLvxZQ9YjoqLpxi542kNP//UlmLW+F3jDGAnyvDjKo7APzC
 OWHocpJMPyY3ZX02znuhexZilAoKtv492nfkQzAUo0M8Ac15znI+tQP+iFC543b4aMsW
 /cWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764583850; x=1765188650;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fGWVhcC4zjG8nxxiobd1UE6Tl65JHRQxp9PlIbFY48Q=;
 b=bWCm6pMTO8FEIiLoYK51ix1lqNtEoX3yi6KdA1rEuI/eCvLEAM6Coj2tKBHMHX9CiS
 IGmKZEICEACtFnF/Q9OzIWvIunr4LU1cK/rI1ARKnTfG+cUz7NesxZ4qbhj7wMBD1eyg
 UkWMFTaq8wS+9hendN/xTtXYhGsiGwA1Lgy4k8l45zlSwmqzSsJjpVi5QgJqDQDOs8+7
 t1eeHbbiAxy5BFzOWx6GdJs7jqhCqv/gm+NLnVjFidKP2WMWCbuS6cizpbECQo6QMg9b
 rHBv9XU9kLtJkvUyLrL7lKRQ8OskOK0VThraBU033m8KsEAZQHHwSpog/YoPd69ukymc
 zQ2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUR249ORJg79edLAYJpZVXCjTorEGHVPykZ62x4WJ6lbH/7t5CN1bLsyJ3YNA10kr4/7jpUt5Hrmr6X@nongnu.org
X-Gm-Message-State: AOJu0YzAmy1IJ4rRpuFGXFPOPm6MzpE8IdqzU/Kgq4JUryFufNdt4QAE
 mIsD9eZbrhI0iMDVDXewr+hhGh4SJh8f5eOaR6JnPpKBYGo9V8b78g/jvDYCi+4+NNo+bM9bMmv
 s5kSfXhAwrehm4yDfb98CqQsrqdqMc+Vx1gva/BeMTDMM7FcVerYt8XDH
X-Gm-Gg: ASbGncsk+wr3oeqvMo/nQLaO/2JXQNcsm6b80UTUkgJ4J/pcfYfh8KvOHNTHzG9lN/E
 gXzwURTJ6If6r9yICBGO7lfqttGblJ1C2fPpOHMkA+kkOD+4mdEazInM1BSrEcI027Ex2wAayQI
 ElI6QJHS8qAi26pO92XdcDlXwKui5160i+pId0ReKTEDhD2BNao0sM6dzMTmdp9i7dTHUuXcFHM
 Y1PbZXnNMhmKBAFz/mWHxHDc9T+YzH2QEUHDEKSczrfGit0EUUloK+2KEoWrLctIrsk99kuL75f
 6rqk/1gd67i3uwAAUO2T+4Ex5akopc8UjxKSQF7ex58e5JowtPpjlKKWUYrQEMWLSUlWsA==
X-Received: by 2002:a05:6000:601:b0:427:454:43b4 with SMTP id
 ffacd0b85a97d-42cc1d19da6mr40484319f8f.48.1764583850402; 
 Mon, 01 Dec 2025 02:10:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGBV5IMyR0cwhfxH2M6pg+dma3BLC4zKbkSPle74dgZscLkwrBXQLYFZqmn0d5IzwKKSuY5Vw==
X-Received: by 2002:a05:6000:601:b0:427:454:43b4 with SMTP id
 ffacd0b85a97d-42cc1d19da6mr40484289f8f.48.1764583850014; 
 Mon, 01 Dec 2025 02:10:50 -0800 (PST)
Received: from imammedo ([213.175.46.86]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42e1c5d618csm25086474f8f.14.2025.12.01.02.10.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Dec 2025 02:10:49 -0800 (PST)
Date: Mon, 1 Dec 2025 11:10:48 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Gavin Shan <gshan@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, mchehab+huawei@kernel.org,
 jonathan.cameron@huawei.com, armbru@redhat.com, mst@redhat.com,
 anisinha@redhat.com, gengdongjiu1@gmail.com, peter.maydell@linaro.org,
 pbonzini@redhat.com, shan.gavin@gmail.com
Subject: Re: [PATCH 4/5] acpi/ghes: Bail early on error from
 get_ghes_source_offsets()
Message-ID: <20251201111048.17551273@imammedo>
In-Reply-To: <20251127004435.2098335-5-gshan@redhat.com>
References: <20251127004435.2098335-1-gshan@redhat.com>
 <20251127004435.2098335-5-gshan@redhat.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Thu, 27 Nov 2025 10:44:34 +1000
Gavin Shan <gshan@redhat.com> wrote:

> For one particular error (Error), we can't call error_setg() for twice.
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^
I can't really parse that
maybe rephrase it to make some sense?

> Otherwise, the assert(*errp == NULL) will be triggered unexpectedly in
> error_setv(). In ghes_record_cper_errors(), get_ghes_source_offsets()
> can return a error initialized by error_setg(). Without bailing on
> this error, it can call into the second error_setg() due to the
> unexpected value from the read acknowledgement register.
> 
> Bail early in ghes_record_cper_errors() when error is received from
> get_ghes_source_offsets() to avoid the exception.
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

patch itself LGTM
and with commit message fixed
  Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/acpi/ghes.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> index 6366c74248..c35883dfa9 100644
> --- a/hw/acpi/ghes.c
> +++ b/hw/acpi/ghes.c
> @@ -443,7 +443,7 @@ static void get_hw_error_offsets(uint64_t ghes_addr,
>      *read_ack_register_addr = ghes_addr + sizeof(uint64_t);
>  }
>  
> -static void get_ghes_source_offsets(uint16_t source_id,
> +static bool get_ghes_source_offsets(uint16_t source_id,
>                                      uint64_t hest_addr,
>                                      uint64_t *cper_addr,
>                                      uint64_t *read_ack_start_addr,
> @@ -474,7 +474,7 @@ static void get_ghes_source_offsets(uint16_t source_id,
>          /* For now, we only know the size of GHESv2 table */
>          if (type != ACPI_GHES_SOURCE_GENERIC_ERROR_V2) {
>              error_setg(errp, "HEST: type %d not supported.", type);
> -            return;
> +            return false;
>          }
>  
>          /* Compare CPER source ID at the GHESv2 structure */
> @@ -488,7 +488,7 @@ static void get_ghes_source_offsets(uint16_t source_id,
>      }
>      if (i == num_sources) {
>          error_setg(errp, "HEST: Source %d not found.", source_id);
> -        return;
> +        return false;
>      }
>  
>      /* Navigate through table address pointers */
> @@ -508,6 +508,8 @@ static void get_ghes_source_offsets(uint16_t source_id,
>      cpu_physical_memory_read(hest_read_ack_addr, read_ack_start_addr,
>                               sizeof(*read_ack_start_addr));
>      *read_ack_start_addr = le64_to_cpu(*read_ack_start_addr);
> +
> +    return true;
>  }
>  
>  NotifierList acpi_generic_error_notifiers =
> @@ -526,9 +528,10 @@ void ghes_record_cper_errors(AcpiGhesState *ags, const void *cper, size_t len,
>      if (!ags->use_hest_addr) {
>          get_hw_error_offsets(le64_to_cpu(ags->hw_error_le),
>                               &cper_addr, &read_ack_register_addr);
> -    } else {
> -        get_ghes_source_offsets(source_id, le64_to_cpu(ags->hest_addr_le),
> -                                &cper_addr, &read_ack_register_addr, errp);
> +    } else if (!get_ghes_source_offsets(source_id,
> +                    le64_to_cpu(ags->hest_addr_le),
> +                    &cper_addr, &read_ack_register_addr, errp)) {
> +            return;
>      }
>  
>      cpu_physical_memory_read(read_ack_register_addr,


