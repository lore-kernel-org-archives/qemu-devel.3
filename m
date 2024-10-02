Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E3D8CF6D2D
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2024 15:16:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sw158-0004Bf-54; Wed, 02 Oct 2024 11:16:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sw14x-0003vo-4V
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 11:15:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sw14v-0004cM-EA
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 11:15:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727882148;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RG7pacTsb3Z1pKhgoiCAeMHrnd1TFk28biALoK/dBSA=;
 b=DpIE4CBcdmhp4n91jt3tuBFC1KM9S5cY/ktZnNFWk1uwqYVtMeGXaUFBsVER4yJkmm6q6F
 nmC0/CSmdYvYqmmd6aR4UEy3bOVJ6S8NDIHRei30xhPLJ4n0oujhG8wuZBD4fcqT6G/5p3
 FzdtB/yQLtLG6ZV1CtUEU5Zi+H2aWFw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-b_1Ld0YvODGI7zOG5OdlTQ-1; Wed, 02 Oct 2024 11:15:47 -0400
X-MC-Unique: b_1Ld0YvODGI7zOG5OdlTQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-42ca8037d9aso44633085e9.3
 for <qemu-devel@nongnu.org>; Wed, 02 Oct 2024 08:15:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727882146; x=1728486946;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RG7pacTsb3Z1pKhgoiCAeMHrnd1TFk28biALoK/dBSA=;
 b=f56u0rek6t/5pFGdx83Chlnxnk4MdVfObgdIHf2z+WQlCW3ROSCUrgquKo2bcBbZ9l
 nXkF5cnlnbBJMmvEuEbyzDXfxGEktoIB6rfv7I6TVrH3L9yfCjQyUiYUQasOhIg7Fx/8
 yzIIBX2fZCivR3Sq0mvM1opfpIoynmNdaVT7y3Lv8BJoaZiWCG/AocrzmhALSX7dlyzP
 ZHEB0alPC1UxGgU2MxsBz/tGH5QXKr7u7Vza9gEhlgGhguulTElCJet4RkOX9GrMZi6y
 RrDWHQ+SKUOr8PRz6ZFsnS1QvjRoQHy0KzjsbxDn6pVXlos+8CB8d/CPJhnwJJURKJoT
 RcRw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXTr+YdM1KN+SbnM6ceuzJSZm2V2JdKVrPTFGmJ9JTis7T7r81pBovvQO1uZ3d31pWEIdVRYUi+WBm0@nongnu.org
X-Gm-Message-State: AOJu0Yy1IGbrT440Fp+v4A1o35ZFfjcvaJ1GSA89ZaqeR+lbT455bBik
 RCOLSeevLV+Oqf5ZmbVuCSdHbd8LvkLIn030sWdhPLjAj8CSJouJKg1j+q0hWcia/ap0VgV4NS4
 o/oJvJAIiRz0ep3CD5lN21j5XcAOMLA8yDTD/VNAdMvPmsimwUlz9
X-Received: by 2002:a05:600c:1d1f:b0:42c:b22e:fbfa with SMTP id
 5b1f17b1804b1-42f777dba40mr23824565e9.21.1727882146012; 
 Wed, 02 Oct 2024 08:15:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsK+5K05akORUjistIGZUjbBnDCo25jpAOQvMzy3UiB8KuFLG4FXkVEoB0X6hHQIGL2t3orw==
X-Received: by 2002:a05:600c:1d1f:b0:42c:b22e:fbfa with SMTP id
 5b1f17b1804b1-42f777dba40mr23824365e9.21.1727882145626; 
 Wed, 02 Oct 2024 08:15:45 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42f79db2b97sm21240245e9.6.2024.10.02.08.15.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Oct 2024 08:15:45 -0700 (PDT)
Date: Wed, 2 Oct 2024 17:15:43 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org,
 peterx@redhat.com
Subject: Re: [PATCH RFC 3/5] acpi/generic_event_device: Update GHES
 migration to cover hest addr
Message-ID: <20241002171543.703ab6e1@imammedo.users.ipa.redhat.com>
In-Reply-To: <d29cdf2bbb67c660142841c2d854db280c18e5e0.1727782588.git.mchehab+huawei@kernel.org>
References: <cover.1727782588.git.mchehab+huawei@kernel.org>
 <d29cdf2bbb67c660142841c2d854db280c18e5e0.1727782588.git.mchehab+huawei@kernel.org>
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

On Tue,  1 Oct 2024 13:42:48 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> The GHES migration logic at GED should now support HEST table
> location too.
> 
> Increase migration version and change needed to check for both
> ghes_addr_le and hest_addr_le.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

other than minor issues below, lgtm

> ---
>  hw/acpi/generic_event_device.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
> index d4dbfb45e181..49ca1fb8e84a 100644
> --- a/hw/acpi/generic_event_device.c
> +++ b/hw/acpi/generic_event_device.c
> @@ -369,6 +369,34 @@ static const VMStateDescription vmstate_ghes_state = {
>      }
>  };
>  
> +static const VMStateDescription vmstate_hest = {
> +    .name = "acpi-ghes",
duplicate name for section, we use that already for hw_error address
I don't know ramification of (CCIng Peter)

Perhaps
s/ghes/hest/



> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_UINT64(hest_addr_le, AcpiGhesState),
> +        VMSTATE_END_OF_LIST()
> +    },
> +};
> +
> +static bool hest_needed(void *opaque)
> +{
> +    AcpiGedState *s = opaque;
> +    return s->ghes_state.hest_addr_le;
> +}
> +
> +static const VMStateDescription vmstate_hest_state = {
> +    .name = "acpi-ged/ghes",

ditto

> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .needed = hest_needed,
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_STRUCT(ghes_state, AcpiGedState, 1,
> +                       vmstate_hest, AcpiGhesState),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
>  static const VMStateDescription vmstate_acpi_ged = {
>      .name = "acpi-ged",
>      .version_id = 1,
> @@ -380,6 +408,7 @@ static const VMStateDescription vmstate_acpi_ged = {
>      .subsections = (const VMStateDescription * const []) {
>          &vmstate_memhp_state,
>          &vmstate_ghes_state,
> +        &vmstate_hest_state,
>          NULL
>      }
>  };


