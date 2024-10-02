Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20137CF31B4
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2024 12:47:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svykh-00052h-J4; Wed, 02 Oct 2024 08:46:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1svykX-0004ti-3w
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 08:46:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1svykV-0002m3-Ct
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 08:46:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727873194;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DRd2IPTTLSDR0JY8la8Jnse8DqiuCfGZKtSPqIBVrXM=;
 b=MzLwmOU7bPTc5rA7/fLESHz/LA3zv/KskZ3HRLcaxUhTBNtmV4Ea6E+BR5AJCYKtt7hsZI
 3K/asLMO6DiVoTEzc4P8o7pEvzKZRavyoJftiNmwYembFU8P3IhTt3G9iSGHTN/gDHLpz7
 BNDJEvqK5WXQOr81lNxVqPpBefpI0uI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-435-MQZ_1pBOMKi1CjVtfWLkNQ-1; Wed, 02 Oct 2024 08:46:32 -0400
X-MC-Unique: MQZ_1pBOMKi1CjVtfWLkNQ-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-37cd19d0e83so2854139f8f.2
 for <qemu-devel@nongnu.org>; Wed, 02 Oct 2024 05:46:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727873192; x=1728477992;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DRd2IPTTLSDR0JY8la8Jnse8DqiuCfGZKtSPqIBVrXM=;
 b=MI6ScC6hTTgfRTD24YMIbDKIU2HDVAXNVwl78vz084MzLuAaAOJGMd8ZGzlN2JVLlb
 8jmiBBSBeCh1F/3U1SXn8FwzH6BoTLSeJxpQ9aZtNauxMrOgpmgIpTN85RD095bA5+CI
 ODNefaF4QLhzpJCK4PwDA/aGLR4EfzTNW3TyLOo2O4mVkzw3e9oPDt0oUa4dxzzmk7+a
 FMc0hUOuy5zxr7frzE73FpMzIHei1irjq+14stPB2/VBS4EbKJz3/qZiaObOrrUdDtkd
 GrX5VlEoOQ+3GaXqS/KPMGOiz78q2VgWgKt1uzknfPkKL964qDwRgaskrSD6Z1uP3UKe
 1SmA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQPjCNAdVZi3idImYgH07oPCF0GfyyItiAaWXyFbZOMXoXwBCPgzd+kl2bRmHJtmr8BJWDIOzTk/bk@nongnu.org
X-Gm-Message-State: AOJu0YwyK2gwT97IbygQ4nyHSXLsF4Sj/af6K6KwIW3ME66PfTqlJq3j
 jMgOQpKcOg6NuLXXVZDABWrP38Umb+1oyM/3F5Ss/IsEexPso7wQIOlg76zJyixBKkUoxRKnF+f
 cEk6AFNu3BUQMZU5xHnQd9T+imW0qEM7zE6fzUXIYttsn3SHrGEeb
X-Received: by 2002:a5d:6283:0:b0:374:c942:a6b4 with SMTP id
 ffacd0b85a97d-37cfb8b567bmr2019748f8f.20.1727873191658; 
 Wed, 02 Oct 2024 05:46:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF2PexkVT7Txl6Bb82fMhSXSDAiku9xoeWYMrqFmP3lO1ymceSSFLAoDOWFkn8RM4zZGf3o9g==
X-Received: by 2002:a5d:6283:0:b0:374:c942:a6b4 with SMTP id
 ffacd0b85a97d-37cfb8b567bmr2019732f8f.20.1727873191343; 
 Wed, 02 Oct 2024 05:46:31 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42f79ff6e28sm17615235e9.37.2024.10.02.05.46.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Oct 2024 05:46:30 -0700 (PDT)
Date: Wed, 2 Oct 2024 14:46:30 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Dongjiu Geng <gengdongjiu1@gmail.com>, linux-kernel@vger.kernel.org,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 12/15] acpi/ghes: don't crash QEMU if ghes GED is not
 found
Message-ID: <20241002144630.1f8b68c1@imammedo.users.ipa.redhat.com>
In-Reply-To: <18c69e8c7a6b6ac365397fe1f442f3ba0cb83be8.1727766088.git.mchehab+huawei@kernel.org>
References: <cover.1727766088.git.mchehab+huawei@kernel.org>
 <18c69e8c7a6b6ac365397fe1f442f3ba0cb83be8.1727766088.git.mchehab+huawei@kernel.org>
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

On Tue,  1 Oct 2024 09:03:49 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Instead, produce an error and continue working

s/^^^^/make error handling within ... consistent, i.e. instead abort just print a error in case ... /


> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  hw/acpi/ghes.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> index 3af1cd16d4d7..209095f67e9a 100644
> --- a/hw/acpi/ghes.c
> +++ b/hw/acpi/ghes.c
> @@ -418,7 +418,10 @@ void ghes_record_cper_errors(const void *cper, size_t len,
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
>      get_ghes_offsets(le64_to_cpu(ags->ghes_addr_le),


