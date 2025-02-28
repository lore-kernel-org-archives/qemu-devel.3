Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00660C19776
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 13:00:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnzy9-0005Lz-CY; Fri, 28 Feb 2025 07:59:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tnzy6-0005J0-G4
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 07:59:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tnzy4-0006Jj-KN
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 07:59:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740747591;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c83XVy6ozclMfOWx6ksvJRIp+J3X+fmuC/ka4FyOnOE=;
 b=J+T58mQrISVMClWI3vv6AVTayFUYLEBJw0lNDups01s0gKdNI+sEu0rs57FAziioPU2KCA
 mcTf7TEYSVj3vcwcE6JuUobmhQ/BOEj4EcwZN7NWzBXNvBMhCyuI/WiLQ6/bA2fVvdW8HC
 jsqF2mjg+2qP/dzNT3tKk5R1u41sCX4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-412-idtNM3jmPrab-SJ-7HLcGg-1; Fri, 28 Feb 2025 07:59:49 -0500
X-MC-Unique: idtNM3jmPrab-SJ-7HLcGg-1
X-Mimecast-MFC-AGG-ID: idtNM3jmPrab-SJ-7HLcGg_1740747589
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-390f000e962so308989f8f.2
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2025 04:59:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740747588; x=1741352388;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c83XVy6ozclMfOWx6ksvJRIp+J3X+fmuC/ka4FyOnOE=;
 b=t1C4jYjs5AFlCW2qFbAqCFgvV0yKv6xB/hd6DLXkje0caqVC2uCkB4ssVZcamEipOf
 L4uLQREVwNZt1tM59378eAX6e7iJOttRdSS9xd7KdJ705LEdaGMx+aRcmfMf3JBw3GMj
 YEkSe8Gb3GRHy9aeyUW3UdsOIx916VDlh1JVmijEOxBWcIlapdO3wLoYGxwl3Hyq3+u8
 kcNF+6/Azhd5bDXfXpQcoueodmER/cy0frq8t+DyshgZnQD4yhyuIEkaH43x/2S1nkP2
 yVEA6bioId0Dfb5Waw1OAvJBOBK862PFmqv7wkJbiirL4qLUPssUGpQG0S/mSWxDKUbM
 zvDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJTpCT/zOz5u9UxWiomq6qN1GG1lt7I7nrHVDWckuA7+e79nGmzq22GLwMhkDTylx1H4f8b8LhK4Go@nongnu.org
X-Gm-Message-State: AOJu0YzHkgKNVtrHl74VrYssmq52ZES1U2/FBPyWG8yZm3reBrSieUYc
 lMXGd2MAUZNVYMo4svabHHdovcR61TJwZYlslNPzT5Epv882s16aIWlsLP0lA4dm/uPUawd/riZ
 1011Ftnw3/4ZLtJzECofi7qWy8U+PbyTFoKXu+aeE8wtLMsnkp3EU
X-Gm-Gg: ASbGncsIRcPuY1qC9MUVdMxV1XcErSjCLcIRneib+cKHKFvKh74OXZtOLhNF519ZdTu
 3Jpxng+igSqL0pXajcVKd/b2NOcl0Z6e7e2N95/HmVBJAWic2mIxBjXM0aTA55J3RUVkaN/i7fR
 yM/ieVaUMbVar5RcBwp0AbfRaIt3wqMcAUWS5cFRD/7rvspc3wrMYZ/KTctsokCCZmyUZeo+zux
 Ujy26/22ItU8HNOATsy8Y80N8D6jSHFcuPCFnF8qpqeZoyb8m2pLD7FVLAsLimiKDBjaFNwo0cF
 PH66IY41R0+em1pRWn9mJFQfgt5krnxc705A7IYdVsOJjIdhAVeI4buZhsGR6RI=
X-Received: by 2002:a05:6000:1f8b:b0:38d:e092:3ced with SMTP id
 ffacd0b85a97d-390ec7c6c4amr2643361f8f.7.1740747588686; 
 Fri, 28 Feb 2025 04:59:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF39024ECeki2qeJ7m1bCe/xYOH62Iyh1CEl4EZF/iAAejb6b6Z9XQvhcS5PKHFcbRdN7SHDw==
X-Received: by 2002:a05:6000:1f8b:b0:38d:e092:3ced with SMTP id
 ffacd0b85a97d-390ec7c6c4amr2643343f8f.7.1740747588359; 
 Fri, 28 Feb 2025 04:59:48 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e47a6739sm5110782f8f.22.2025.02.28.04.59.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2025 04:59:47 -0800 (PST)
Date: Fri, 28 Feb 2025 13:59:47 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Shiju Jose <shiju.jose@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, Ani Sinha
 <anisinha@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 16/19] acpi/generic_event_device.c: enable
 use_hest_addr for QEMU 10.x
Message-ID: <20250228135947.15504734@imammedo.users.ipa.redhat.com>
In-Reply-To: <797c0199ef713241db145baf3860d32e0eb1d03a.1740671863.git.mchehab+huawei@kernel.org>
References: <cover.1740671863.git.mchehab+huawei@kernel.org>
 <797c0199ef713241db145baf3860d32e0eb1d03a.1740671863.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Thu, 27 Feb 2025 17:00:54 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Now that we have everything in place, enable using HEST GPA
> instead of etc/hardware_errors GPA.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/acpi/generic_event_device.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
> index f029753ab709..9fe70b74bd42 100644
> --- a/hw/acpi/generic_event_device.c
> +++ b/hw/acpi/generic_event_device.c
> @@ -332,7 +332,7 @@ static void acpi_ged_send_event(AcpiDeviceIf *adev, AcpiEventStatusBits ev)
>  static const Property acpi_ged_properties[] = {
>      DEFINE_PROP_UINT32("ged-event", AcpiGedState, ged_event_bitmap, 0),
>      DEFINE_PROP_BOOL("x-has-hest-addr", AcpiGedState,
> -                     ghes_state.use_hest_addr, false),
> +                     ghes_state.use_hest_addr, true),
>  };
>  
>  static const VMStateDescription vmstate_memhp_state = {


