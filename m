Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADDF9D116F9
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Dec 2025 09:38:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQ0MG-0000am-56; Mon, 01 Dec 2025 04:38:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vQ0M6-0000aI-T4
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 04:38:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vQ0M4-0007em-U7
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 04:38:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764581878;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DaEty387PH/ejKI8m8D9xKfy25pAxHPUdctNf1oV5uQ=;
 b=WU1UHbDQtXKJv3aeTmTYWiGf7mf+0duUqmXwFh72G0Gb2pIX2wjdCBBYXj9A5uuwEbOYjE
 RW1O0tAvMeC7ps5i4WZtZvr7h473RkmQS2Z2howuGR2NOiZ/tRib51zNzuALPCHXV6raY0
 WDmBGULOLE7/ELYpmGFXImRQYTYuFLk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-la9pu3kCPEm_r_RVAE0RqA-1; Mon, 01 Dec 2025 04:37:57 -0500
X-MC-Unique: la9pu3kCPEm_r_RVAE0RqA-1
X-Mimecast-MFC-AGG-ID: la9pu3kCPEm_r_RVAE0RqA_1764581876
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4779393221aso21885145e9.2
 for <qemu-devel@nongnu.org>; Mon, 01 Dec 2025 01:37:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764581876; x=1765186676; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DaEty387PH/ejKI8m8D9xKfy25pAxHPUdctNf1oV5uQ=;
 b=aSQ4YDyazX0+5g8flHicjDdV3Z59TOYUK5xpKusGu64IG0zeTlpufmPXLS23VvPA01
 G1LsemCYOAYYBs18I3Hwpx4U3ZHI1FXlTDZ4p86c87wO8/hIa+NQtX/op8d0QRcwHP1G
 OpFRQCz9+0RMueTl5lQe4k6I0cAJXsAiygrwQCYt3BfrN7iKWnbsw6WQkyrqRQAFGY39
 4gAWaIdjA3WS3whu3GlITykPsLCnrr6Jzat+h3W3LP8AuU6oPCTFFss+jQM4OP5ZLn+A
 XCIFDzQD02qwP3Ny2zDWgovaop6wuj6JrKqxus39H2VigzvPDaYHJ9sidUemZr73RYPI
 8dDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764581876; x=1765186676;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DaEty387PH/ejKI8m8D9xKfy25pAxHPUdctNf1oV5uQ=;
 b=ELG6DAz6TdK++zEqVdHIj5G1Bpyos1C4V3//FUCHolA6HyNZceNDy51BHNy+NborJL
 +mmHwrwODj76iM3Dm0vsougqJ/YH1+tIwJ+x5ruPje/y9xLThuACo+O9nDzB/AhA7ns1
 /Fuf7sNeg1F8/T4WcfpBP0V9eVeYMF4hcgahLvyotdy9iH8mzJTOKAOFZroywnNenzhm
 ibqmQ954mHl1YS2isploc6GqI3LYRh8C1vx7b6/XZStU7S9Cgb18BJZFn8DcAZMLIUec
 avTMenQF5pB58jXOUNOnAOEbAwmqIH9WZPWCDafyXKkqAm/6GmONLf3/OmE+8fJUYxRM
 ohxQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8pcUajq35zL6OpZ6LdrMZT8B4s7FUAAd305jTFbR7oVJAsYVl3KetxnslXYq1L82YhGj3c9fhiG/M@nongnu.org
X-Gm-Message-State: AOJu0YyaIEllIz/OjXV2VgYZqWPxQGqf3HHj2DZtVp5m1AEyhrr95jjl
 AgElb+UDSt/nz4n2V43EYesSuBuSj4y1k6VL5pwQ+IxilKHzyMkYKcYnqPuZngs3YCtMV0PFqxB
 WPr0EXY4IUUJt4z3Qt6+GnRxx8N5VhLflPAiNdpJmdyFqXXzdaJvOyBvs
X-Gm-Gg: ASbGncvLrQ/Q6lIQRNnyxCNrQka7UYnncq5N2G8wgDGTxxgDaJwQiVL+j3ea8mdUETk
 aaA29Iy86rkg9AT1goQcsC9b3v2/A6sz1J3a5cKj/QvtWe1p9aFtwh1FIfGWr83uOGLoN4Rgaye
 Ri9v+EVcuKmGXXex3wowOt+UjNmxAoZg7oEOm2QWrWcKXwBmnpC9Az2uk/RXtYQmY3E8xdbjJ34
 ba523mRQTWeMln0wfKoXL/McUKYCbdJX/iYAUKG2irMd8OMlVS2wGCMtuWskKJWUAR2Lfc+8AXL
 BbjM2eMUEINF2SX9uwaz+NAbnlndf8kS6eSrxEWw6mqnv4SKE2/y/4NPU4/cwoR84fYfxw==
X-Received: by 2002:a05:600c:1c13:b0:471:786:94d3 with SMTP id
 5b1f17b1804b1-477c01b201fmr359198275e9.22.1764581876243; 
 Mon, 01 Dec 2025 01:37:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH2dsjbP7qIEs0Mvap0gO4378zyZOjamu2Mt9MeM8OtAAirolTU8yo+0XKPhbmeONNYnOjZpA==
X-Received: by 2002:a05:600c:1c13:b0:471:786:94d3 with SMTP id
 5b1f17b1804b1-477c01b201fmr359197905e9.22.1764581875871; 
 Mon, 01 Dec 2025 01:37:55 -0800 (PST)
Received: from imammedo ([213.175.46.86]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4791163e3cbsm234661745e9.10.2025.12.01.01.37.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Dec 2025 01:37:55 -0800 (PST)
Date: Mon, 1 Dec 2025 10:37:54 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Gavin Shan <gshan@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, mchehab+huawei@kernel.org,
 jonathan.cameron@huawei.com, armbru@redhat.com, mst@redhat.com,
 anisinha@redhat.com, gengdongjiu1@gmail.com, peter.maydell@linaro.org,
 pbonzini@redhat.com, shan.gavin@gmail.com
Subject: Re: [PATCH 2/5] acpi/ghes: Abort in acpi_ghes_memory_errors() if
 necessary
Message-ID: <20251201103754.770941aa@imammedo>
In-Reply-To: <20251127004435.2098335-3-gshan@redhat.com>
References: <20251127004435.2098335-1-gshan@redhat.com>
 <20251127004435.2098335-3-gshan@redhat.com>
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
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, 27 Nov 2025 10:44:32 +1000
Gavin Shan <gshan@redhat.com> wrote:

> The function hw/acpi/ghes-stub.c::acpi_ghes_memory_errors() shouldn't
> be called by any one. Take g_assert_not_reached() as a clearer indication.
> 
> Suggested-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Gavin Shan <gshan@redhat.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/acpi/ghes-stub.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/acpi/ghes-stub.c b/hw/acpi/ghes-stub.c
> index 40f660c246..b54f1b093c 100644
> --- a/hw/acpi/ghes-stub.c
> +++ b/hw/acpi/ghes-stub.c
> @@ -14,7 +14,7 @@
>  int acpi_ghes_memory_errors(AcpiGhesState *ags, uint16_t source_id,
>                              uint64_t physical_address)
>  {
> -    return -1;
> +    g_assert_not_reached();
>  }
>  
>  AcpiGhesState *acpi_ghes_get_state(void)


