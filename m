Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91669C021BE
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 13:22:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tndpO-0004Cc-Or; Thu, 27 Feb 2025 08:21:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tndpL-0004Bx-HJ
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 08:21:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tndpJ-0001AG-Fx
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 08:21:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740662480;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3g03yAf4l5F8h1WORiHCVOwuwaIh4if8iQdl0nCBRXg=;
 b=dwggsuUbFMPKzZZv4QubhE3kq4F0De2de4e42SjIaCxTecW6g6t05tYGbwhjO5uwaYWDdD
 dSZo/lkjdFUBZS4jrlVTFHbD07kUsrn4rsN0hcvs/vwIhC0eWmdVNNVPDdO4c9gEaSuucw
 PGkzuJikZ95FZHPhud5XdNPeDDZENCQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-10-EWsaSFKMPhySJnQLYIrtoA-1; Thu, 27 Feb 2025 08:21:17 -0500
X-MC-Unique: EWsaSFKMPhySJnQLYIrtoA-1
X-Mimecast-MFC-AGG-ID: EWsaSFKMPhySJnQLYIrtoA_1740662476
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-390ddb832e6so450837f8f.1
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2025 05:21:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740662476; x=1741267276;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3g03yAf4l5F8h1WORiHCVOwuwaIh4if8iQdl0nCBRXg=;
 b=LsrCGKs9LgnJeVsITmrq99zGNw3XVghnpxtlyYSdJtGpax/R5xkbGJkFazs5Xrdml0
 cDD0BLDC5p+hys7utenLKu34nwk0dz7GVPJAy3yEeSn9hJHnwORIYqbRGYnxHW2JdtfO
 DD3827OZO2BfTtENMCu9jWLL+A2gMHdh0AfxkituY+f0ydV5pgzFHxW8MUAuVU0i6UVY
 JCHAMadLl1zML4Zi/ekzkAcrU4XrgucSiqKLJ0JwxOcIRCsqSDPGl71Ak81yuOrEvP1I
 5u3e9+8KJAy0WYSY2jkgJyVtS89fuSmLCCWbAwRCpWlduhgl06MUNLMsmFUjiz7juSsB
 gSPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVEHu8760gFxuVyKgF47ASLrIz3Yt63SsmcLrPi3MABL+xYx9yjCxlidjEq1kLpToBz33oDMHEPrCLu@nongnu.org
X-Gm-Message-State: AOJu0YzzT0gAoQeZdVAMEi43FaLIrfsESo/LDjfkKN0OX9oxB68Tq563
 jitiGXVu24NTrWOdTuZkAjzaCEVchWxU9G8DJY9LKu1hK8TEpmUx5IO2wzgN7h7ivsFdfLNJoDD
 AO0u8ImcvfZUgGiZmqtxIPjQPKqwpO7RjfTFy75emEkisuDE0Ej+i
X-Gm-Gg: ASbGncuuL+cWw3aLIu8/QRc5N0cvB6t1At/Un9MKBuouMujjLsXy9xnzGKzyoEvU1Ah
 +AY5fH/Dvc0XpDlNf/DepIuR83pd9i+0aBF8kwbALp5n3vQNjYrwPprbn0ukbbelPX0E5fVu7Ik
 rB7ThFaDweZgBT4HHifMBQT6Ui5Pypd0KbvikOa1UQSZiUWWilUM5U53+gI2Jk3+D+nnjpR1uXz
 Nj/JHqvZvZm9ZXedDR7gkRrvgyTXPg/LG8TQUpj02g9TXm3vpPoeFqL/CizQ3zcV2l/7Bt/fyH5
 3EKHrEBG3toWHKCDU62SvVsZm6RG5KodgXT4aZqpUbb/9HZmTdaso4yyQAWvlO8=
X-Received: by 2002:a05:6000:1fa9:b0:38f:4fa6:bb24 with SMTP id
 ffacd0b85a97d-390d4f8b44bmr6722052f8f.39.1740662476244; 
 Thu, 27 Feb 2025 05:21:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE9t5CiNJn68RP1oVWTt+sQVksw+R8XH3ts91h1zl+/D1v9evidsONkhXfH4w9mAtjPHRcpsA==
X-Received: by 2002:a05:6000:1fa9:b0:38f:4fa6:bb24 with SMTP id
 ffacd0b85a97d-390d4f8b44bmr6721993f8f.39.1740662475792; 
 Thu, 27 Feb 2025 05:21:15 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e47b7c43sm2009977f8f.49.2025.02.27.05.21.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2025 05:21:15 -0800 (PST)
Date: Thu, 27 Feb 2025 14:21:14 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Shiju Jose <shiju.jose@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, Dongjiu Geng
 <gengdongjiu1@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 19/21] docs: hest: add new "etc/acpi_table_hest_addr"
 and update workflow
Message-ID: <20250227142114.350e4cd7@imammedo.users.ipa.redhat.com>
In-Reply-To: <205abbc22ce816d88aa6c1c7058607fe35aae1ea.1740653898.git.mchehab+huawei@kernel.org>
References: <cover.1740653898.git.mchehab+huawei@kernel.org>
 <205abbc22ce816d88aa6c1c7058607fe35aae1ea.1740653898.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Thu, 27 Feb 2025 12:03:49 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> While the HEST layout didn't change, there are some internal
> changes related to how offsets are calculated and how memory error
> events are triggered.
> 
> Update specs to reflect such changes.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  docs/specs/acpi_hest_ghes.rst | 28 +++++++++++++++++-----------
>  1 file changed, 17 insertions(+), 11 deletions(-)
> 
> diff --git a/docs/specs/acpi_hest_ghes.rst b/docs/specs/acpi_hest_ghes.rst
> index c3e9f8d9a702..f3cb3074b082 100644
> --- a/docs/specs/acpi_hest_ghes.rst
> +++ b/docs/specs/acpi_hest_ghes.rst
> @@ -89,12 +89,21 @@ Design Details
>      addresses in the "error_block_address" fields with a pointer to the
>      respective "Error Status Data Block" in the "etc/hardware_errors" blob.
>  
> -(8) QEMU defines a third and write-only fw_cfg blob which is called
> -    "etc/hardware_errors_addr". Through that blob, the firmware can send back
> -    the guest-side allocation addresses to QEMU. The "etc/hardware_errors_addr"
> -    blob contains a 8-byte entry. QEMU generates a single WRITE_POINTER command
> -    for the firmware. The firmware will write back the start address of
> -    "etc/hardware_errors" blob to the fw_cfg file "etc/hardware_errors_addr".
> +(8) QEMU defines a third and write-only fw_cfg blob to store the location
> +    where the error block offsets, read ack registers and CPER records are
> +    stored.
> +
> +    Up to QEMU 9.2, the location was at "etc/hardware_errors_addr", and
> +    contains an offset for the beginning of "etc/hardware_errors".
                   s/^^^^/GPA/

> +
> +    Newer versions place the location at "etc/acpi_table_hest_addr",
                            s/^^^^^^^^^^^/GPA or address/
> +    pointing to the beginning of the HEST table.
> +
> +    Through that such offsets, the firmware can send back the guest-side
       ^^^ see my previous s comment on that

> +    allocation addresses to QEMU. They contain a 8-byte entry. QEMU generates
> +    a single WRITE_POINTER command for the firmware. The firmware will write
> +    back the start address of either "etc/hardware_errors" or HEST table at
> +    the correspoinding address firmware.
                          ^^^^^^^^^^^^^^^^ what is it?
perhaps it should be "fwcfg file"?

>  
>  (9) When QEMU gets a SIGBUS from the kernel, QEMU writes CPER into corresponding
>      "Error Status Data Block", guest memory, and then injects platform specific
> @@ -105,8 +114,5 @@ Design Details
>       kernel, on receiving notification, guest APEI driver could read the CPER error
>       and take appropriate action.
>  
> -(11) kvm_arch_on_sigbus_vcpu() uses source_id as index in "etc/hardware_errors" to
> -     find out "Error Status Data Block" entry corresponding to error source. So supported
> -     source_id values should be assigned here and not be changed afterwards to make sure
> -     that guest will write error into expected "Error Status Data Block" even if guest was
> -     migrated to a newer QEMU.
> +(11) kvm_arch_on_sigbus_vcpu() report RAS errors via a SEA notifications,
> +     when a SIGBUS event is triggered.


