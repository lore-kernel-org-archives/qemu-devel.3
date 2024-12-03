Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2FA9E64A80
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 11:53:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIRSe-00053s-Eo; Tue, 03 Dec 2024 06:53:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tIRSd-00053d-OK
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 06:52:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tIRSc-0002ik-Be
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 06:52:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733226777;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=if0eS42ic4FtOI54nNA13X1+b8OGQFDK6o4TLYIRToo=;
 b=STZ2qN2tahBEJ/OXnAYJH/3YMGqE70EGmpy0e1XUmjdB35SHa6iNx9LMCUP30Kc7hAuwQo
 hWGwkQxL0U7BSWwf//3VRm6R9Q+GSJv/N0ZUfGc3LfpOdwEi/L6SCDzxWZeb5VD4O3ZgC0
 l/mJhc1T8PPTJd1URtHBs/q/o2FRkyw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-42-HfC1Aa5XPGGX9GNEA_4gbw-1; Tue, 03 Dec 2024 06:52:56 -0500
X-MC-Unique: HfC1Aa5XPGGX9GNEA_4gbw-1
X-Mimecast-MFC-AGG-ID: HfC1Aa5XPGGX9GNEA_4gbw
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-434ad71268dso30069575e9.1
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 03:52:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733226775; x=1733831575;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=if0eS42ic4FtOI54nNA13X1+b8OGQFDK6o4TLYIRToo=;
 b=m02VjYW/jFc9ccuZ76B+kfG2LvMEdNrnmzQUW1fL2h6Gy8wXd9W4PBQlR16EaOQiyn
 d3Ts1j2FFGnon9fyFYslQ1vIybWauLBpxrzDuTIw+oKiiE2s5gOVyW9jToASHh8FROXV
 7aeC8FCYUcb9ekUZU1tcNF81XJC7BcsqIzg9wrL+mFBsVfvHXFsjRTxmqRVSBPIVOlcT
 SMhFzWAlbQX1czkMJVRIRoLj54N5eXqwcl7sekX7rUXGUH5A9sXv6NhpMjYXmjnx4QWi
 U9KhUqPjp5uGyruTh9Vw7SDy3wqIJZkhz7zgNVpUVNy0EaoGVZRjHjksAmTH0boTzJI0
 geog==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHOcKUe3XDkXzQQDV3ygYY8I6o3SBDsDOsAmExeSWH6CbXbC3KMvHPnINbU6ybdNy0GQZ8uRsuquhv@nongnu.org
X-Gm-Message-State: AOJu0YwE4ExcQf5JCrsqJWted/HghfsqXvSpKVDciYRuoghGZzlfAkYg
 mnGA7Ek/x9RiuMm7kkneY7GNn8HGkw86haC8KPF0v2TFzr9xZ26TteyBjpZvmJEsKVoel/lmV10
 Oik7Vt+SdLWNkipddeD5sXQkzrSb4YCKeH7GsdXFqZNRTb8S0EPBk
X-Gm-Gg: ASbGnctlM4WQ2Y/bPUigCU6QXq21WTUHYnMcL+EZI2ksf+1UBg1Sza6wjEAOsOp7cRe
 kmT+I9kkeJaI3KXvJNstFUdSz/m4Sx0oHTIRZJ5BEuW+2DQCzAfofpMZ21s3ulyduku4HB61LfD
 WQWZKmgoMfw41UD8I6Z9XLyM7i+MaSRfcn/xmmZLGss3rZHWb4PsHpP23aHfjGflt35g9rFOQ0t
 /VLWS32p4nVKfcT5XSLqWxl9KqTnDs5nRCxlGVac4hcvmd0grKj2VMw9sRDVVGqxcLE5VQFFSqk
 H4WUj0g8oKPy5pA3UuBI8w==
X-Received: by 2002:a05:600c:198e:b0:434:9cf6:a2a5 with SMTP id
 5b1f17b1804b1-434afb9ecc7mr192833215e9.8.1733226774919; 
 Tue, 03 Dec 2024 03:52:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHxOz/gJmc3Ivz+XXCVg78C+KOFX7mhlXMTseV2ZbEE8L+T7U/tPYdNEWcyrVrhI3wXoR2XvA==
X-Received: by 2002:a05:600c:198e:b0:434:9cf6:a2a5 with SMTP id
 5b1f17b1804b1-434afb9ecc7mr192833055e9.8.1733226774600; 
 Tue, 03 Dec 2024 03:52:54 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434aa7804fbsm223249265e9.21.2024.12.03.03.52.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2024 03:52:54 -0800 (PST)
Date: Tue, 3 Dec 2024 12:52:53 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 linux-kernel@vger.kernel.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v4 14/15] acpi/ghes: Change ghes fill logic to work with
 only one source
Message-ID: <20241203125253.5a11194b@imammedo.users.ipa.redhat.com>
In-Reply-To: <cf16e0900e10c5a39e11b590f5267a4b9c228060.1732266152.git.mchehab+huawei@kernel.org>
References: <cover.1732266152.git.mchehab+huawei@kernel.org>
 <cf16e0900e10c5a39e11b590f5267a4b9c228060.1732266152.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
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

On Fri, 22 Nov 2024 10:11:31 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Extending to multiple sources require a BIOS pointer to the
> beginning of the HEST table, which in turn requires a backward-compatible
> code.
> 
> So, the current code supports only one source. Ensure that and simplify
> the code.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/acpi/ghes.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> index d99697b20164..b0b1865dc8d3 100644
> --- a/hw/acpi/ghes.c
> +++ b/hw/acpi/ghes.c
> @@ -387,15 +387,13 @@ static void get_hw_error_offsets(uint64_t ghes_addr,
>       * As the current version supports only one source, the ack offset is
>       * just sizeof(uint64_t).
>       */
> -    *read_ack_register_addr = ghes_addr +
> -			      ACPI_GHES_ERROR_SOURCE_COUNT * sizeof(uint64_t);
> +    *read_ack_register_addr = ghes_addr + sizeof(uint64_t);
>  }
>  
>  void ghes_record_cper_errors(const void *cper, size_t len,
>                               uint16_t source_id, Error **errp)
>  {
>      uint64_t cper_addr = 0, read_ack_register_addr = 0, read_ack_register;
> -    uint64_t start_addr;
>      AcpiGedState *acpi_ged_state;
>      AcpiGhesState *ags;
>  
> @@ -412,11 +410,9 @@ void ghes_record_cper_errors(const void *cper, size_t len,
>      }
>      ags = &acpi_ged_state->ghes_state;
>  
> -    start_addr = le64_to_cpu(ags->hw_error_le);
> -
> -    start_addr += source_id * sizeof(uint64_t);
> -
> -    get_hw_error_offsets(start_addr, &cper_addr, &read_ack_register_addr);
> +    assert(ACPI_GHES_ERROR_SOURCE_COUNT == 1);
> +    get_hw_error_offsets(le64_to_cpu(ags->hw_error_le),
> +                         &cper_addr, &read_ack_register_addr);
>  
>      cper_addr = le64_to_cpu(cper_addr);
>      if (!cper_addr) {


