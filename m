Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D15E4E69175
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2024 16:22:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEWQ5-0005dI-Pw; Fri, 22 Nov 2024 11:22:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tEWQ4-0005cs-A5
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 11:22:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tEWQ1-0003m7-WA
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 11:22:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732292525;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NyV4m9dJITsICN0qNNwyYDHcaqurrOEnQKifJ5kQsB0=;
 b=T2DD5iPu2WXCibw8KDvBmIADHNaeT0RqZZpGDb/t+TThZWm/YMaAK+5cagsAwmlS/xK7NS
 Cq0od5R+yK0XGWSAXNjs6LPao+77g570YRkeGpS9thsw6X+RWSUKVBHaMOaCkP0/Gngddm
 OoYVZMDRFC8ATAVsHaD0g/OHjf9hj2c=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-395-g7pXYZ1aP7abEZQuUjUo9Q-1; Fri, 22 Nov 2024 11:22:01 -0500
X-MC-Unique: g7pXYZ1aP7abEZQuUjUo9Q-1
X-Mimecast-MFC-AGG-ID: g7pXYZ1aP7abEZQuUjUo9Q
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4316655b2f1so16181345e9.0
 for <qemu-devel@nongnu.org>; Fri, 22 Nov 2024 08:22:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732292520; x=1732897320;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NyV4m9dJITsICN0qNNwyYDHcaqurrOEnQKifJ5kQsB0=;
 b=Y/57iRpIZrZUTuYgK2oXXIZHDChuIxjciGkZmstLneIBN15joiKlTelAiFnSbiUOeE
 hkjr05rG3T8Hk8isE6wwY2VdAiKMrormj4XDvPgrQMW+j/kdWZDMVPPhBBu/cLD2OGIX
 c9eCj813yGZgjuFAFWLvzVGMzmGpIsipxck8cAdyzhTVxAvKa2CvPin+cQxNXmJqivoz
 d+O6eEShAqM9Ew5vmQXyNFhHrL9Mz1QfMVP7ivoUQPXtvf4xPbGJZ99ef7X/qVTtnmX0
 cv6DEUnC4GBeoIEd3prYXSlyfiXIkfoJGX5xeFVXnLo5gLgr31BhLgY9Iwz21BSQHBlB
 GuXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXbaWVh2xBA8LrFmWqiegFa7M+JhpV/X4tdhrgZvg2kelkk44pysBrNnv/XLQ7Jq3qoVofGXHb29dl8@nongnu.org
X-Gm-Message-State: AOJu0Ywplzo1lDDKMqsF9oiJ6b9TmSsz2Dy3MZoF54wNdiMQpzhIX5n+
 R0wnaDkeGwvu4QGoDaqosnxvgK89O1PreYIcifT2CfbR3NV8toDgZ/vvHo7Z8AF9vSXrqFrsz1e
 n9qXfotA+08e2feOVOxA9oUqU7bVKAw4xPjazcqUqGfm7u8MUbs/q
X-Gm-Gg: ASbGnct83LB6W3b0U+u1zcJVY7GoCd7P/VvDptd++C6WpLGNz0l25l6H8vufIjR2eRF
 3yozciEtj8TS+MAFXer+i/Oq5Tw6o13MMzEDAlb0n+yOAbHcxkWebmOLyclgXrpOhQj4R5rg5Yt
 6J7DkMcq9K/56eU926HxWeEMOf6rNAJkcIdmSZ9e5nax891M1T4RV7OB5QjbrRMsri75OJxj5wT
 TtFVbtMSBER5yXFY+Dae4oIObp3oBBtY/taw/i7iNMcnWsuqGxevYgv42A9g+dBlA8d4X17SRk+
 6B+qCrX5IKxQUHbUb+YtvQ==
X-Received: by 2002:a05:600c:3b19:b0:42c:bae0:f05b with SMTP id
 5b1f17b1804b1-433ce413c8emr26604705e9.1.1732292520043; 
 Fri, 22 Nov 2024 08:22:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFEkstkJfSxr8aGDMBPVQGktPpGXJ+GanjyrPf4YG9VrYHHxatCFCWHJCelP1CWqHq06xVoyw==
X-Received: by 2002:a05:600c:3b19:b0:42c:bae0:f05b with SMTP id
 5b1f17b1804b1-433ce413c8emr26604585e9.1.1732292519763; 
 Fri, 22 Nov 2024 08:21:59 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-433b45d40basm100217045e9.21.2024.11.22.08.21.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Nov 2024 08:21:58 -0800 (PST)
Date: Fri, 22 Nov 2024 17:21:57 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 linux-kernel@vger.kernel.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v4 10/15] acpi/ghes: don't crash QEMU if ghes GED is not
 found
Message-ID: <20241122172157.10012778@imammedo.users.ipa.redhat.com>
In-Reply-To: <d72d9cf99ad0169a39cd3f8028ee7c2e112edf06.1732266152.git.mchehab+huawei@kernel.org>
References: <cover.1732266152.git.mchehab+huawei@kernel.org>
 <d72d9cf99ad0169a39cd3f8028ee7c2e112edf06.1732266152.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Fri, 22 Nov 2024 10:11:27 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Make error handling within ghes_record_cper_errors() consistent,
> i.e. instead abort just print a error in case ghes GED is not found.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/acpi/ghes.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> index ad7d895def2a..25587f5fc9ab 100644
> --- a/hw/acpi/ghes.c
> +++ b/hw/acpi/ghes.c
> @@ -371,7 +371,10 @@ void ghes_record_cper_errors(const void *cper, size_t len,
>  
>      acpi_ged_state = ACPI_GED(object_resolve_path_type("", TYPE_ACPI_GED,
>                                                         NULL));
> -    g_assert(acpi_ged_state);
> +    if (!acpi_ged_state) {
> +        error_setg(errp, "Can't find ACPI_GED object");
> +        return;
> +    }
>      ags = &acpi_ged_state->ghes_state;
>  
>      start_addr = le64_to_cpu(ags->ghes_addr_le);


