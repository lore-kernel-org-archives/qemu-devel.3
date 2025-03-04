Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDBEDC282C6
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 02:35:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpI73-0005f1-RS; Mon, 03 Mar 2025 21:34:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1tpI6x-0005ea-5E
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 21:34:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1tpI6u-0001Cn-GK
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 21:34:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741055658;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+bwmP4mZjorBC9LRAE7Yiam7V2JRMTbsusBM9K0mUeI=;
 b=HyzysWsaUED+To51GwGGhYWOKdUTYL2rOMJa9MOn+8v8BUT9UaVBhduTl+mTgmCR5dr2aI
 LKosnkV/OBNzlBvJZrhLxs10XREG3vpolQWKLB0GFiXHFVLnipLURE2BzjQ9TTxEX9jAae
 u2ZfXizbJjriVW/8O4SuY0dkoqvHKVI=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-DyEBBrm2MKC8c9OC3z-rZA-1; Mon, 03 Mar 2025 21:34:06 -0500
X-MC-Unique: DyEBBrm2MKC8c9OC3z-rZA-1
X-Mimecast-MFC-AGG-ID: DyEBBrm2MKC8c9OC3z-rZA_1741055646
Received: by mail-io1-f70.google.com with SMTP id
 ca18e2360f4ac-849cc81984eso20402639f.1
 for <qemu-devel@nongnu.org>; Mon, 03 Mar 2025 18:34:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741055646; x=1741660446;
 h=content-transfer-encoding:mime-version:organization:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+bwmP4mZjorBC9LRAE7Yiam7V2JRMTbsusBM9K0mUeI=;
 b=X/e7I+ds2C6V2WRW5UNu0LgNJ4qvH+bcnapNy9+WWC7ZVcugrfNfji0jQsisPyzYUD
 4EoGxMNBsNHTUDl02YpupgdHGyXD5TvJdqp3AtPAvT56QYVUR+tz29j/VQUPc9nb/v4a
 xU8dT8iTw4LFZDoKoqIbbSZTTtgIgOPECaaFoBS55DzQakSj9XL+dP+m8u6MrA93cxRI
 2/mG4yHrVjF/CUOgUqP8XbkoM/zW11UmnFwva53Iy3xN7y38T1caIbq7a5vEjsmqITvU
 X0bGMgNxL0Rr/apEKgGlzpS8v4YccG10kX1ifhm7D6K+fScfiboN4HEC6rNz9gXrXJPj
 qPMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVsN8Jboz2UmPMlzp2iBbrky+/Vr/ZyIMm8p5XffngetjZX+n5Z6z27PK+gS6i/RzZHK0MMwFsLDGQj@nongnu.org
X-Gm-Message-State: AOJu0Yx+VCfvHDV/l5EedRYz04bdQkBiZ+bdMvAWpjCeByct1b9xtjJG
 mUD7ydVJet9k3mU2+SuAWbqWSKjdrym3wkNqfnBidnDOyLGfmR0B+wwLjD0GRmNgS3M96r0yqWV
 GbROfmeotbwq6fLuWRelrLRo1GIN/ngPqwB1RdXn6GRutS6yJ45P9
X-Gm-Gg: ASbGncu+LliuATl5JpK2qVe0yp5QRISDtq9f4Z2hDLq5UqsTtQVRYfqvY4QiT3xflOO
 lpuiOOHM9oWNKFk9KC4jnSpgqdU7iugU0NNNvWZxLOfc+Xt4QIJ0pDLC6Qa7pVLewFzMEyVy0Iu
 a2c61ZwnDAeq3vTOIwhne5qoACRdUttxguzl+T5rmcWxt10KL8HG4CD+X7d9oTI29oi372fxCDE
 ZffqFMARnzzNp03Zh38ZH6QYpPDdwte6Oxb/vT7diaQg9SQE5YonWLdt9RBSbYJcLGRAl4CUJJa
 /3khGjyg6SQeAicvMo4=
X-Received: by 2002:a05:6e02:214f:b0:3d2:b506:96b with SMTP id
 e9e14a558f8ab-3d41e7f2346mr3709605ab.0.1741055645799; 
 Mon, 03 Mar 2025 18:34:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF0PLiEZ8GP+kKg9PfiTsArCxnZDpmjxZlvAheLDJgvTkWscYE8EyOKqAKQWD0Bk3V1nmFm/Q==
X-Received: by 2002:a05:6e02:214f:b0:3d2:b506:96b with SMTP id
 e9e14a558f8ab-3d41e7f2346mr3709575ab.0.1741055645482; 
 Mon, 03 Mar 2025 18:34:05 -0800 (PST)
Received: from redhat.com ([38.15.36.11]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f09cac9f8asm795461173.39.2025.03.03.18.34.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Mar 2025 18:34:03 -0800 (PST)
Date: Mon, 3 Mar 2025 19:33:58 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Tomita Moeko <tomitamoeko@gmail.com>
Cc: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@redhat.com>,
 qemu-devel@nongnu.org, Corvin =?UTF-8?B?S8O2aG5l?=
 <corvin.koehne@gmail.com>
Subject: Re: [PATCH v2 7/9] vfio/igd: Decouple common quirks from legacy mode
Message-ID: <20250303193358.22e93640.alex.williamson@redhat.com>
In-Reply-To: <20250303175220.74917-8-tomitamoeko@gmail.com>
References: <20250303175220.74917-1-tomitamoeko@gmail.com>
 <20250303175220.74917-8-tomitamoeko@gmail.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

On Tue,  4 Mar 2025 01:52:17 +0800
Tomita Moeko <tomitamoeko@gmail.com> wrote:

> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index a58d555934..b0620a0ae8 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -3363,6 +3363,8 @@ static const Property vfio_pci_dev_properties[] = {
>                      VFIO_FEATURE_ENABLE_REQ_BIT, true),
>      DEFINE_PROP_BIT("x-igd-opregion", VFIOPCIDevice, features,
>                      VFIO_FEATURE_ENABLE_IGD_OPREGION_BIT, false),
> +    DEFINE_PROP_BIT("x-igd-legacy-mode", VFIOPCIDevice, features,
> +                    VFIO_FEATURE_ENABLE_IGD_LEGACY_MODE_BIT, true),

Shouldn't this be an on/off/auto property with default set to auto?
That way we can have a soft fail when set to "auto" and requirements
don't align, and a hard fail when set to "on".  Thanks,

Alex


