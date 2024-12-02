Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 974B8D10DA0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 06:05:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tHzXZ-0005ib-Af; Mon, 02 Dec 2024 01:04:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1tHzXV-0005iJ-OB
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 01:04:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1tHzXT-0000iE-4Q
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 01:04:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733119445;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GfEdwozRqEYLGu2F23TI6JQCa5+Mg7t5YZLLnoPBVAs=;
 b=UgrJaR1D+XbLp3aUl+CQVKLQulEba4/1E4X9QyN5AWdCn2T6cnIaYXwGaLX9O4a2hVakxd
 x7aac0dCOYGEBS66SPsOIsl68y+96w6r7aSFln2NckM7QxMdcajPMqfnOY7E2lyxmkRr4S
 MPUihm1o1NA3zcs1O0jC7uqsYzR8Cn0=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-312-2f59L0gzOh-G66ISx106RQ-1; Mon, 02 Dec 2024 01:04:03 -0500
X-MC-Unique: 2f59L0gzOh-G66ISx106RQ-1
X-Mimecast-MFC-AGG-ID: 2f59L0gzOh-G66ISx106RQ
Received: by mail-io1-f69.google.com with SMTP id
 ca18e2360f4ac-8419d05aa7cso37236139f.0
 for <qemu-devel@nongnu.org>; Sun, 01 Dec 2024 22:04:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733119443; x=1733724243;
 h=content-transfer-encoding:mime-version:organization:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GfEdwozRqEYLGu2F23TI6JQCa5+Mg7t5YZLLnoPBVAs=;
 b=cT3GqQ2UHF3n9GApkw02yh4EYxcICSs9taQ9134NWLprIaduJUUdn94sf6NkoPm+9i
 TvfbBnoP+RqSZZDqaBdToAeWdJmkjcQFcXGcX0R5l/7H1aNoW9WH7UDAtQgmOsXmrrjp
 2GfIw3Bv58puZy0uEJ9KThBZsXU9t3GjvRsXOrVEQvksQSHF5diXxRRlXnfF4G5t6Zas
 79rsP52vSDtwXkWtZv1M+NxBTW5o7DcCuZKY9JxybARS1zQI2V74a1XFGczoovc9/I89
 AMuCQosGVpm4R3KpSuLXehbAYHy/iHd+pMgt3DKkOhS3/HlaXPYbZcgV9GbY6AZi196k
 y3aA==
X-Gm-Message-State: AOJu0Yync08V/V3wTg9IYtNc/c0jqwQO2cq5H3TTFWDYq7ZakyOSEWwn
 9nZVMDmuc4HKWtnvccZ4sBey5xU0OLTGryhC9lmEtZiXDNJFyU4C21xeBC3K3Xe9umO2NDt2NIR
 1EJeq8ie/i8m964sw18l2EySHZiMruBB41THC4e6NGsD8EW64qkQV
X-Gm-Gg: ASbGncu/IJf19vJ118cW+jnrQVqcoz0tPPHJzN6gK4wptG6aZjj8lUALUcu53cAkZ63
 NMPquzdkl4eFURL8j5kpSXH9vstozkQljlYOTVBsmppe/s2aFgYX/edlf5GUz7+RWCXidc8f9ps
 XZ5Pcyhzlv4yq5p2zJS3o4BIyDPM/ONzsz9euvkwrJdp4xbpiurGcmlLceliLyj/QSd5y9P4kbw
 F/HaXvp3yb2o2II7oifgdg+uvQ1jEhc+V9udenafKEutNfrwa2Vwg==
X-Received: by 2002:a05:6e02:1a69:b0:3a7:c5ff:e5fc with SMTP id
 e9e14a558f8ab-3a7c5ffe7d2mr63718155ab.0.1733119442961; 
 Sun, 01 Dec 2024 22:04:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE28vfLNJoBQAJ8HRPZZsnFGB5YlgKFfCMdNQ/ULCAmHgG/Gema3HGuozIXUcrdjs7rnl0QuQ==
X-Received: by 2002:a05:6e02:1a69:b0:3a7:c5ff:e5fc with SMTP id
 e9e14a558f8ab-3a7c5ffe7d2mr63718065ab.0.1733119442600; 
 Sun, 01 Dec 2024 22:04:02 -0800 (PST)
Received: from redhat.com ([38.15.36.11]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e230da8f6dsm1883093173.5.2024.12.01.22.04.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Dec 2024 22:04:02 -0800 (PST)
Date: Sun, 1 Dec 2024 23:04:01 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Tomita Moeko <tomitamoeko@gmail.com>
Cc: qemu-devel@nongnu.org, Corvin =?UTF-8?B?S8O2aG5l?=
 <c.koehne@beckhoff.com>, =?UTF-8?B?Q8OpZHJpYw==?= Le Goater
 <clg@redhat.com>
Subject: Re: [PATCH 4/8] vfio/igd: align generation with i915 kernel driver
Message-ID: <20241201230401.3b2e8e61.alex.williamson@redhat.com>
In-Reply-To: <20241201160938.44355-5-tomitamoeko@gmail.com>
References: <20241201160938.44355-1-tomitamoeko@gmail.com>
 <20241201160938.44355-5-tomitamoeko@gmail.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Mon,  2 Dec 2024 00:09:34 +0800
Tomita Moeko <tomitamoeko@gmail.com> wrote:

> Define the igd device generations according to i915 kernel driver to
> avoid confusion, and adjust comment placement to clearly reflect the
> relationship between ids and devices.
> 
> Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
> ---
>  hw/vfio/igd.c | 36 ++++++++++++++++--------------------
>  1 file changed, 16 insertions(+), 20 deletions(-)
> 
> diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
> index 8f300498e4..71342863d6 100644
> --- a/hw/vfio/igd.c
> +++ b/hw/vfio/igd.c
> @@ -59,33 +59,29 @@
>   */
>  static int igd_gen(VFIOPCIDevice *vdev)
>  {
> -    if ((vdev->device_id & 0xfff) == 0xa84) {
> -        return 8; /* Broxton */
> +    if ((vdev->device_id & 0xffe) == 0xa84) {
> +        return 9;   /* Broxton/Apollo Lake, Gemini Lake */
>      }

J4105 is a Gemini Lake, the IGD device ID is 0x3185 according to
ark[1]??

I do find Apollo Lake examples (N3450) with ID 0x5a85, which I assume
justifies masking out the zero bit of the ID.

Since Broxton was apparently canceled, I think this unique device ID
test was concocted from i915.  Maybe Apollo Lake should just be added
under gen9 below with 0x5a00?  Then Gemini Lake should be added as
0x3100.  Both should be noted as new IDs.  Have either been tested?

>  
>      switch (vdev->device_id & 0xff00) {
> -    /* SandyBridge, IvyBridge, ValleyView, Haswell */
> -    case 0x0100:
> -    case 0x0400:
> -    case 0x0a00:
> -    case 0x0c00:
> -    case 0x0d00:
> -    case 0x0f00:
> +    case 0x0100:    /* SandyBridge, IvyBridge */
>          return 6;
> -    /* BroadWell, CherryView, SkyLake, KabyLake */
> -    case 0x1600:
> -    case 0x1900:
> -    case 0x2200:
> -    case 0x5900:
> +    case 0x0400:    /* Haswell */
> +    case 0x0a00:    /* Haswell */
> +    case 0x0c00:    /* Haswell */
> +    case 0x0d00:    /* Haswell */

Crystal Well?

> +    case 0x0f00:    /* Valleyview/Bay Trail */
> +        return 7;
> +    case 0x1600:    /* Broadwell */
> +    case 0x2200:    /* Cherryview */

These two jump from gen6/7 to gen8, that's certainly not just a cosmetic
change.

>          return 8;
> -    /* CoffeeLake */
> -    case 0x3e00:
> +    case 0x1900:    /* Skylake */
> +    case 0x5900:    /* Kaby Lake */

These two jump from gen6/7 to gen9, so again, functional differences
for these.  Have these changes been tested?

> +    case 0x3e00:    /* Coffee Lake */
>          return 9;
> -    /* ElkhartLake */
> -    case 0x4500:
> +    case 0x4500:    /* Elkhart Lake */
>          return 11;
> -    /* TigerLake */
> -    case 0x9A00:
> +    case 0x9A00:    /* Tiger Lake */
>          return 12;
>      }
>  

Actually, patch 1 doesn't even need to be addressed here because patch
2 already made the change to check (gen < 8) rather than (gen > 6), so
we can just entirely drop patch 1 (ideally with an updated commit log
in 2 to note the logic change for this upcoming split of gen6/7).
Thanks,

Alex

[1]https://www.intel.com/content/www/us/en/products/sku/128989/intel-celeron-j4105-processor-4m-cache-up-to-2-50-ghz/specifications.html


