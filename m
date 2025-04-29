Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27871C369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 14:31:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9lzK-0006RM-UT; Tue, 29 Apr 2025 10:31:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1u9lzH-0006P5-UZ
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 10:31:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1u9lzF-0002dR-Qm
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 10:31:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745937062;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=6wAdqzap6CbGwhUPha2QUddcyuEa2xsOuA8P0fdddb8=;
 b=Uh2XS4CuKGInfy2a8f4GxlBjsHLUu8469wTpD36MHOq0/p0n0WwIYMGR5K+VopaRDTFDLx
 irr0VW+3rziOCKhFI5CM1Qt9qK04+WMDP8NULox7aWCQpebl3jpCqQvIWUQ7SP/2LMvrQw
 QEh9NnKSPYOhj4L82Egj3pxFCIjY55U=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-304-DEs-spi8NRydBuw90bT1IQ-1; Tue, 29 Apr 2025 10:31:00 -0400
X-MC-Unique: DEs-spi8NRydBuw90bT1IQ-1
X-Mimecast-MFC-AGG-ID: DEs-spi8NRydBuw90bT1IQ_1745937059
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43ea256f039so45517455e9.0
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 07:31:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745937059; x=1746541859;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6wAdqzap6CbGwhUPha2QUddcyuEa2xsOuA8P0fdddb8=;
 b=xDwPyhd7Csb/1jLLhbg0Pofmy7O0H4rXEdh6NYZ53RP2fnmIyYD/iQ+3wI/MxnUy4m
 iW4l7u0SjbIiUjdJ+qVXbmqVUzYRVE/LJpA+ydc4EyvS8te0xCnwhn2Ai5bqIYwt6xvV
 Du0I+NvtK4QqtQee6xk6feY5J62y7w6m1UShJETj/tOb8HIY6U7rkjHdehnC/oGDPssY
 15Xg+D7+5Vxu9c8O6jWqbqTid0PNOGEm+tSY1Dq0AauYB40OBg5mJTzijrkwRDnComIR
 9XWAzxOMZqphdAcXTBvv7x8UfsgP7FAVd9ngDcYb7kD8NxZO5J9ieM/IzD5UKTs3hHdF
 d4Sw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZtQLYU7UC/6W8jLG89cNHnKAy04Ol+RUCJdMEoO4Cxhj00bPRQOGPzeVs1Dwl/an030e0edDY6bsw@nongnu.org
X-Gm-Message-State: AOJu0YxGIv7Wp/h08xI6nqfxWNmSLjbyGuWqsBbb2A5x/He0nnITm49T
 fwWY6OAU7MFYRv/TfRMrkm9kw3Y5+QTgbxkjujkQn/hD31iVKr1nTWBZodFphT0D6unuh7GCV9/
 FLqDkWyd6bkYU9LBrpZCvVTZYUY/t9OC/VFdN0qh/RvifFOCYR02w
X-Gm-Gg: ASbGncv4xW/JtyMwMZUSAWzVsjYpdhQW537xMuKcYzPPY9ShQo38gXa3ze+gkT4TKHX
 2HAdsPmPHebwii1CyYJYeqDhrAQb78MOVGi9cGGJEneIf8cGbzQ+1Jn8+RaUyPlzV1PGruSwqgM
 bc+4zzakrAcZFpSWZlC+iEHNxxF9UO/6hflEHHPLxnL9kZnux2Ox/eK4s3aUF68jP9CbSgMziDE
 ECUL6bygHLztwx1qS41v7zX0RDV3D/r2mgMHn7dWx5NpL00ePS2ThKimEUYyUu2jwP1N/o3aYV8
 jBBoDkpcDQveVTc98JXDJH3No3D6mFQCrcDBurK+
X-Received: by 2002:a05:600c:19c6:b0:43d:83a:417d with SMTP id
 5b1f17b1804b1-441ac856d64mr33550315e9.12.1745937059144; 
 Tue, 29 Apr 2025 07:30:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEY5khO73VDG2k+M3tfQlgDSPXzxH8T6wplKZJbpMLNQD5s+fe1AIBUzcsXv5qJPi9kxo4fuA==
X-Received: by 2002:a05:600c:19c6:b0:43d:83a:417d with SMTP id
 5b1f17b1804b1-441ac856d64mr33549925e9.12.1745937058756; 
 Tue, 29 Apr 2025 07:30:58 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-49-87.web.vodafone.de. [109.42.49.87])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4409d2e01bdsm194111865e9.38.2025.04.29.07.30.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Apr 2025 07:30:58 -0700 (PDT)
Message-ID: <ba15c1a9-d568-46ee-ada4-b8250fbb24bb@redhat.com>
Date: Tue, 29 Apr 2025 16:30:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] Revert "include/hw: temporarily disable deletion
 of versioned machine types"
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 devel@lists.libvirt.org, Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Zhao Liu <zhao1.liu@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20250429131526.1842130-1-berrange@redhat.com>
 <20250429131526.1842130-2-berrange@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250429131526.1842130-2-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.489,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 29/04/2025 15.15, Daniel P. Berrangé wrote:
> This reverts commit c9fd2d9a48ee3c195cf83cc611b87b09f02f0013.
> 
> When we introduced the specialized machine type deprecation policy, we
> allow automatic deprecation to take effect immediately, but blocked the
> automatic deletion of machine types for 2 releases. This ensured we
> complied with the historical deprecation policy during the transition
> window. Startnig with the 10.1.0 dev cycle, the old machine types would

typo: Startnig

> be candidates for removal under both the old and new deprecation
> policies.
> 
> Thus we can now enable automatic deletion of old machine types, which
> takes effect by skipping the QOM type registration. This prevents the
> machine types being listed with '-machine help', and blocks their
> creation. The actual code can be purged at a convenient time of the
> maintainer's choosing.
> 
> In the case of the x86_64 target, this change results in the blocking
> of the following machine types:
> 
>    pc-i440fx-4.0        Standard PC (i440FX + PIIX, 1996) (deprecated)
>    pc-i440fx-3.1        Standard PC (i440FX + PIIX, 1996) (deprecated)
>    pc-i440fx-3.0        Standard PC (i440FX + PIIX, 1996) (deprecated)
>    pc-i440fx-2.9        Standard PC (i440FX + PIIX, 1996) (deprecated)
>    pc-i440fx-2.8        Standard PC (i440FX + PIIX, 1996) (deprecated)
>    pc-i440fx-2.7        Standard PC (i440FX + PIIX, 1996) (deprecated)
>    pc-i440fx-2.6        Standard PC (i440FX + PIIX, 1996) (deprecated)
>    pc-i440fx-2.5        Standard PC (i440FX + PIIX, 1996) (deprecated)
>    pc-i440fx-2.4        Standard PC (i440FX + PIIX, 1996) (deprecated)
>    pc-i440fx-2.12       Standard PC (i440FX + PIIX, 1996) (deprecated)
>    pc-i440fx-2.11       Standard PC (i440FX + PIIX, 1996) (deprecated)
>    pc-i440fx-2.10       Standard PC (i440FX + PIIX, 1996) (deprecated)
>    pc-q35-4.0.1         Standard PC (Q35 + ICH9, 2009) (deprecated)
>    pc-q35-4.0           Standard PC (Q35 + ICH9, 2009) (deprecated)
>    pc-q35-3.1           Standard PC (Q35 + ICH9, 2009) (deprecated)
>    pc-q35-3.0           Standard PC (Q35 + ICH9, 2009) (deprecated)
>    pc-q35-2.9           Standard PC (Q35 + ICH9, 2009) (deprecated)
>    pc-q35-2.8           Standard PC (Q35 + ICH9, 2009) (deprecated)
>    pc-q35-2.7           Standard PC (Q35 + ICH9, 2009) (deprecated)
>    pc-q35-2.6           Standard PC (Q35 + ICH9, 2009) (deprecated)
>    pc-q35-2.5           Standard PC (Q35 + ICH9, 2009) (deprecated)
>    pc-q35-2.4           Standard PC (Q35 + ICH9, 2009) (deprecated)
>    pc-q35-2.12          Standard PC (Q35 + ICH9, 2009) (deprecated)
>    pc-q35-2.11          Standard PC (Q35 + ICH9, 2009) (deprecated)
>    pc-q35-2.10          Standard PC (Q35 + ICH9, 2009) (deprecated)
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   include/hw/boards.h | 19 +------------------
>   1 file changed, 1 insertion(+), 18 deletions(-)
> 
> diff --git a/include/hw/boards.h b/include/hw/boards.h
> index 765dc8dd35..74a8e96b2e 100644
> --- a/include/hw/boards.h
> +++ b/include/hw/boards.h
> @@ -719,28 +719,11 @@ struct MachineState {
>    * suitable period of time has passed, it will cause
>    * execution of the method to return, avoiding registration
>    * of the machine
> - *
> - * The new deprecation and deletion policy for versioned
> - * machine types was introduced in QEMU 9.1.0.
> - *
> - * Under the new policy a number of old machine types (any
> - * prior to 2.12) would be liable for immediate deletion
> - * which would be a violation of our historical deprecation
> - * and removal policy
> - *
> - * Thus deletions are temporarily gated on existance of
> - * the env variable "QEMU_DELETE_MACHINES" / QEMU version
> - * number >= 10.1.0. This gate can be deleted in the 10.1.0
> - * dev cycle
>    */
>   #define MACHINE_VER_DELETION(...) \
>       do { \
>           if (MACHINE_VER_SHOULD_DELETE(__VA_ARGS__)) { \
> -            if (getenv("QEMU_DELETE_MACHINES") || \
> -                QEMU_VERSION_MAJOR > 10 || (QEMU_VERSION_MAJOR == 10 && \
> -                                            QEMU_VERSION_MINOR >= 1)) { \
> -                return; \
> -            } \
> +            return; \

I wonder whether we might want to have it the other way round now instead, 
so that we could re-activate the dead machines in case a certain environment 
variable (QEMU_ZOMBI_MACHINES) is set? Anyway, just an idea, not sure 
whether it's a good one. So for this patch:

Reviewed-by: Thomas Huth <thuth@redhat.com>


>           } \
>       } while (0)
>   


