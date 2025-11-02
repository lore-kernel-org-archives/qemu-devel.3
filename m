Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BB30CCF9E3
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Nov 2025 17:41:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFc4A-00050m-LS; Sun, 02 Nov 2025 12:40:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>) id 1vFc47-00050Z-Mk
 for qemu-devel@nongnu.org; Sun, 02 Nov 2025 12:40:32 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>) id 1vFc45-0003vB-Ed
 for qemu-devel@nongnu.org; Sun, 02 Nov 2025 12:40:31 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2947d345949so31908945ad.3
 for <qemu-devel@nongnu.org>; Sun, 02 Nov 2025 09:40:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762105228; x=1762710028; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
 :reply-to; bh=ZYbTk2ueJYXypWzVqHgnDbwZ7HCQN08enFgIRr+DB0s=;
 b=APzdm6mieVLa2QxTDym02YSqjvNhFIsNOtopjxIMYknBxeVHmvbvoFMKuZD90lkata
 Oj2rbljXFhzM7Lg8NTCb/nR8Z7NIB09K71tTppguUEfMw/rCVtwzOorGwCxYePHH6poK
 JnncAKPUGzWUlSjJCUcn9KV0Tj9OfbEc1hU9iqL+VWgDdRgAJFhFVnQui6eq7VQsfDzL
 oavlhQ5bTExo8pOMnK1rYIybdyy7iW5TwG3hpnH8Plh1Amq1KWeALe836WvTqSNWCjPn
 myir60oXwVbD5eWW3iH4NP2TkmaMBGyYz1Yd5wAFTsjgZ1GoTcp+nk1+H1MYOba0Z67W
 YofQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762105228; x=1762710028;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZYbTk2ueJYXypWzVqHgnDbwZ7HCQN08enFgIRr+DB0s=;
 b=qE6xzAMNfpLTP1jzAHNuLMsxKsHD10qekt/DMerVUE7stU5T8qQ+c4O/bJ4VYJwSJ8
 w/k8MnmaEfHMBmj+Xc0K+UOnvSwihOzHJloX1zRra8u0tz0J0ZHnj/25awkiYkq6Qf+e
 RVpyznLeGFfFyNnN/KHJ/LXigJwfhFHO8kwNHYoEU4NNyq8pOrJY6WaZ2z21NYkxrDW+
 mUJW83LmjH0ub1/S/sq/RngMvfEQ0AY8CvALaI3NS3mAtnaOsL6/6UH44O0x2Gq3FwPN
 /1dUBXsjB/1py2pmgJWzwsBOqWzbuJevt7D5ljO8m8iWxHzYZEdjcjtDCONmTnUuHpI7
 ui9w==
X-Gm-Message-State: AOJu0Yw6hhwk4cA/W4DTZvUHMkQWP0p0Eo1+rMdCGgQbvcWZI91fRbnH
 pz6pqryRv4Cdb2Guneg6YHCcAcA7LDTlNcaQ6+pIB4j5+9Xxc1A8EF0E
X-Gm-Gg: ASbGncvqfqKTsukxQUHCzbbOln/hWps2JWks215XlV3DgQISO284j8A4gHK0vVPgd5+
 pCfLXj4tM8i8KYdDY5S3MLB9WnobLAcFdo3CGbEkx/Tine1AQBp84qQFL6q2LaehEBmVEbyGwK7
 tFvewVeFJRB/999mjsES955elTX+bC7YesGZRVKycuYkRSeEqjw5XwFvz1LSJDZKXKUcJ0Cao6L
 +5/baQZMWuDY7OvgMoTfulEFTc3gxGWWcXO4soh7sNCXvNlMC5BCxO1AC52txNlE7HQx6reHoPv
 7ChVkZUQ4oHDg3isiRAcsmu8HRDoNU/N+xknA3v2uwS319zb8zutB4GZUGB9ENZcCQ0TpbBNtne
 s2FL4g6vJwRBC7HIgQXukhbQ4fpdn+TaBg5OpAhjd8MwgowQ6A68FbUQe0IsHStmQ7K57sOTiKP
 3we1Y05FuywhF2vETe0suc9/M=
X-Google-Smtp-Source: AGHT+IFKQ3YfgqYWETq46I5VED/FmMC/FjNFQSySd55JcyIQGcO1IhqyKV4xNWjzf+QS3k1ZhNjC1g==
X-Received: by 2002:a17:902:f706:b0:295:7453:b58b with SMTP id
 d9443c01a7336-2957453b74bmr38595275ad.4.1762105227617; 
 Sun, 02 Nov 2025 09:40:27 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29546185f17sm68535305ad.31.2025.11.02.09.40.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Nov 2025 09:40:27 -0800 (PST)
Date: Sun, 2 Nov 2025 09:40:26 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
Cc: qemu-devel@nongnu.org, mark.cave-ayland@ilande.co.uk, deller@gmx.de,
 Jason Wang <jasowang@redhat.com>, sarkarsoumyajyoti23@gmail.com,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v2 1/3] hw/hppa: Enable LASI i82596 network on 715 machine
Message-ID: <ed6aaa98-af19-40ca-ad76-e4215579b74c@roeck-us.net>
References: <20251101125726.45912-1-soumyajyotisarkar23@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251101125726.45912-1-soumyajyotisarkar23@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=groeck7@gmail.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Sat, Nov 01, 2025 at 06:27:25PM +0530, Soumyajyotii Ssarkar wrote:
> From: RemZapCypher <soumyajyotisarkar23@gmail.com>
> 
> Enable the i82596 network chip which is included in the LASI
> multi I/O chip. Since LASI has different start addresses on
> the various machines, always initialize the LASI components
> by their offsets.
> 
> As suggested by Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Changes since v1:
> Added proper Qemu device initialization for LASI
> 
...
> diff --git a/hw/hppa/hppa_hardware.h b/hw/hppa/hppa_hardware.h
> index d422af0429..a8a496c0e1 100644
> --- a/hw/hppa/hppa_hardware.h
> +++ b/hw/hppa/hppa_hardware.h
> @@ -21,14 +21,6 @@
>  #define DINO_SCSI_HPA   0xfff8c000
>  #define LASI_HPA_715    0xf0100000
>  #define LASI_HPA        0xffd00000
> -#define LASI_UART_HPA   0xffd05000
> -#define LASI_SCSI_HPA   0xffd06000
> -#define LASI_LAN_HPA    0xffd07000
> -#define LASI_RTC_HPA    0xffd09000
> -#define LASI_LPT_HPA    0xffd02000
> -#define LASI_AUDIO_HPA  0xffd04000
> -#define LASI_PS2KBD_HPA 0xffd08000
> -#define LASI_PS2MOU_HPA 0xffd08100
>  #define LASI_GFX_HPA    0xf8000000
>  #define ARTIST_FB_ADDR  0xf9000000
>  #define CPU_HPA         0xfffb0000
> @@ -44,6 +36,18 @@
>  
>  #define SCSI_HPA        0xf1040000      /* emulated SCSI, needs to be in f region */
>  
> +#define HPA_DISABLED_DEVICE     1       /* add to HPA to disable */
> +
> +/* LASI offsets */
> +#define LASI_LPT        0x02000
> +#define LASI_AUDIO      0x04000
> +#define LASI_UART       0x05000
> +#define LASI_SCSI       0x06000
> +#define LASI_LAN        0x07000
> +#define LASI_PS2        0x08000
> +#define LASI_RTC        0x09000
> +#define LASI_FDC        0x0A000

One thing I noticed: Those defines are now duplicated.
Example:

hw/hppa/hppa_hardware.h:#define LASI_LAN        0x07000
include/hw/misc/lasi.h:#define LASI_LAN        0x07000

Guenter

