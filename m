Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63923C35FFF
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2024 12:02:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqWuk-0001Vw-Oz; Tue, 17 Sep 2024 08:02:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sqWu4-0000xX-SE
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 08:01:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sqWu1-0004Z9-ND
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 08:01:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726574511;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9HzhMxnLNe3jV8pAQOQDyx0mfb5RIW+kELp9fCFj67Q=;
 b=MdHRmvSpe7vez+2SOy0cHYGZXJGDqmH8KgtZX9M4Sl3zSkbo3yGX0WlB28LeWuOmd035V4
 kqC2v4RFLSLLgPH+aysaLmW2JsZihRASyFeJaKkUybGjg0EeU/tcsYfcAQ4GVGGrHS7o+8
 6Ohb0ZOldmvk1nBSZYf+h89N7qgIBsI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-MOQWVhQpMwyNBhBDvu3f2Q-1; Tue, 17 Sep 2024 08:01:50 -0400
X-MC-Unique: MOQWVhQpMwyNBhBDvu3f2Q-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-374cd315c68so1959845f8f.0
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2024 05:01:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726574508; x=1727179308;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9HzhMxnLNe3jV8pAQOQDyx0mfb5RIW+kELp9fCFj67Q=;
 b=VuMzpv7cdHjt2QRQlYhQTsp+E02uWLGmZnUbPSrxM/viIVfjtGoTdlXUSIs4FOOS3u
 RinqrpxRZkj6RuFUla1FMoo6XLdGDEtlonQZSghDjqX7X1ADpmw7B/yif3zPno99gsX9
 u2UhyKxB0tfbu+tNdWeZMRPdp8CD0T3h9BJziPEWA5fipnqkcs05yEi79deBrB9Ex6Mp
 HzLyoVFwI68QwXbETz13eLzxGJpuHA3pTh4J+SGFPOusJRgUhynKChjNfUQmPWKbYUME
 iqu77/ClUcbQNGtBSnyupqTwxXNnzck2+UoTywoz7YkCQLVmzI3ACD0FGirpwYUL70Pl
 joJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXBYSFXdfgW9ctDGjuGFFt5/+afeQmlQqOBljzvafFKn2sb82teWN4v7SnYR7rRQfwnseHOUufVrB58@nongnu.org
X-Gm-Message-State: AOJu0Yw9/vbeMk+ovn+jWTDhY6BXltGLDgL5aAnSG5sIKCsOTAqEfYvG
 AIdRLzs/1tGzADlhFUlaP3qaa3Zt+hDHvE5eK/qceLTQ85qQ/Dj4ILVKKieqHfmUF3amhHuUkSt
 kokZii9jgtddaJWyiC5U+Yh25qU2pJFeaeloCCruI4EAdjysl5tq4ND1cHTMr
X-Received: by 2002:adf:facb:0:b0:374:babf:ac4d with SMTP id
 ffacd0b85a97d-378d625360bmr7023031f8f.58.1726574507874; 
 Tue, 17 Sep 2024 05:01:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGi0v4jdOWNkzYoSWoRO+8xe9tG/92/3wCyKj+zNE83KRvnVAbqziGM7mF21MWO04u1FDwVYA==
X-Received: by 2002:adf:facb:0:b0:374:babf:ac4d with SMTP id
 ffacd0b85a97d-378d625360bmr7023012f8f.58.1726574507371; 
 Tue, 17 Sep 2024 05:01:47 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-378e7800237sm9377230f8f.83.2024.09.17.05.01.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Sep 2024 05:01:46 -0700 (PDT)
Date: Tue, 17 Sep 2024 14:01:46 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v10 02/21] acpi/generic_event_device: Update GHES
 migration to cover hest addr
Message-ID: <20240917140146.56c9d581@imammedo.users.ipa.redhat.com>
In-Reply-To: <bed4b2da51e0c894cc255f712b67e2e57295d826.1726293808.git.mchehab+huawei@kernel.org>
References: <cover.1726293808.git.mchehab+huawei@kernel.org>
 <bed4b2da51e0c894cc255f712b67e2e57295d826.1726293808.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Sat, 14 Sep 2024 08:13:23 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> The GHES migration logic at GED should now support HEST table
> location too.
> 
> Increase migration version and change needed to check for both
> ghes_addr_le and hest_addr_le.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  hw/acpi/generic_event_device.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
> index 15b4c3ebbf24..4e5e387ee2df 100644
> --- a/hw/acpi/generic_event_device.c
> +++ b/hw/acpi/generic_event_device.c
> @@ -343,10 +343,11 @@ static const VMStateDescription vmstate_ged_state = {
>  
>  static const VMStateDescription vmstate_ghes = {
>      .name = "acpi-ghes",
> -    .version_id = 1,
> -    .minimum_version_id = 1,
> +    .version_id = 2,
> +    .minimum_version_id = 2,
>      .fields = (const VMStateField[]) {
>          VMSTATE_UINT64(ghes_addr_le, AcpiGhesState),
> +        VMSTATE_UINT64(hest_addr_le, AcpiGhesState),
>          VMSTATE_END_OF_LIST()
>      },
>  };
> @@ -354,13 +355,13 @@ static const VMStateDescription vmstate_ghes = {
>  static bool ghes_needed(void *opaque)
>  {
>      AcpiGedState *s = opaque;
> -    return s->ghes_state.ghes_addr_le;
                            ^^^^^^^^^^^^
another thing, perhaps we should rename it to 'hardware_errors_addr'
to make it less confusing 

> +    return s->ghes_state.ghes_addr_le && s->ghes_state.hest_addr_le;
>  }
>  
>  static const VMStateDescription vmstate_ghes_state = {
>      .name = "acpi-ged/ghes",
> -    .version_id = 1,
> -    .minimum_version_id = 1,
> +    .version_id = 2,
> +    .minimum_version_id = 2,
>      .needed = ghes_needed,
>      .fields = (const VMStateField[]) {
>          VMSTATE_STRUCT(ghes_state, AcpiGedState, 1,


