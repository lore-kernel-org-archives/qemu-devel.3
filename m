Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A85CFD10F58
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Nov 2025 16:29:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOINq-0004q1-GO; Wed, 26 Nov 2025 11:28:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1vOINo-0004pV-Pl
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 11:28:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1vOINm-0004f2-15
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 11:28:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764174519;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TJdvnOPZS0tH0Udf3ZQJ0GFmrJWE/5g7v4KwoNwxmNM=;
 b=YDOq3iwqme40isz0wKxsrJcGkItKBDHj67Jnrv0blb2uRLVhB6O4iSz82x+60mI4dPj20A
 eUm2+GUB8Z4yyze11vo0iKMy31jvBC6ex/ItiMjtD29Wly+yBeYiY7v73lJieEjx6HxiGh
 lUZ68iTBEbKE1X4SS/uxiB3sqaDruuQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-155-UiZUKIoSNgWrk5l0yhDERQ-1; Wed, 26 Nov 2025 11:28:38 -0500
X-MC-Unique: UiZUKIoSNgWrk5l0yhDERQ-1
X-Mimecast-MFC-AGG-ID: UiZUKIoSNgWrk5l0yhDERQ_1764174517
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-42b3c965ce5so1988f8f.2
 for <qemu-devel@nongnu.org>; Wed, 26 Nov 2025 08:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764174517; x=1764779317; darn=nongnu.org;
 h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=TJdvnOPZS0tH0Udf3ZQJ0GFmrJWE/5g7v4KwoNwxmNM=;
 b=hYD9QBvn+2XvUJe64a9ZotdrHyvcL7SF/qZQ+x4Xf5fC0IZgVRrMpHl6zvC5uGHsfR
 M2cHn3FMIbRhJeWZfPPHAHi4ykeKXuh/Uj2UfvLB81XWclbikhRmXxNLAAFO1Xi75sQJ
 qRUnUjIgJ8zKlwYsQm0OnAYCE23Sfz0NKThjtJ3Ecc3np9mD3G4Koi2n2qOPUFD4Kflc
 tYxUoEa+mgawdfwXDmjpkb4/Iqq6h+b6jbMS1RLxj1+CEWlPqm395hbmKP1TFdOw2i2x
 jI6ZJ9kYwLdEoSJ1Qi8eZOpTQAcjmuK6P3dxbgJz6EC5Dv5tW07hzmSuM/HDhlKfOe0n
 wuew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764174517; x=1764779317;
 h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TJdvnOPZS0tH0Udf3ZQJ0GFmrJWE/5g7v4KwoNwxmNM=;
 b=f6k1yky6CE3zfeSMlVylHfNxQjZsBH2FiZf145it/uKQybILZXMCfcENyg8pseImVc
 XV+12ZOSd92Ac54w0bijLIOO3mxDDf+fiIxU6jwj2jxji0/3k8r/Uj3NB3GTYSfiWqaU
 OadwuSuoYu8K6VGieoCqXCU8oF0ZgmYjSiirE5c4lZqIeLGEi3QVOyIO2u+OVlsB0pAf
 eJ7/SSrApKw6HyyT3jGbRqvalp9v20OmBS95QcC2yrDjjWjW7GpWsulIcj8FKVXiBtXR
 tLecsRLYyroToBAX5Wvk7qyOzPaI75y5psCRdpoW9aCKmH+ORp4c2tZ0/IeqCTMTrcqx
 1W8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXlLqdysIvIH/SC8uObn16xSxoBTen2knQdvRN6FKts7JCatcbqNTIKHnCozv62TJo+qzvqjOOI8OdE@nongnu.org
X-Gm-Message-State: AOJu0YxCkQt8cfuM2rVnWnt92J5tkaNhsL8rsWSWSnoTiZ5sya6A2KBH
 PyRYLtMbVoLOwzxEiBOoJTmyTrDQjLI9NM+TM3SGsqf4CDrTeeNfFM4HbN6qwZOrBe5kEHG48Cj
 O6rnOLcktAuFnTorxLseyKn5LchRVjJDC3J7p8uYTA7tybQgcTMaQOl8C
X-Gm-Gg: ASbGncud+4VaFMhz3xjcx8FtOmTLMBTZwGTzIBI8xNbc/PCN86qwqgjf75DeGoC4jIn
 m9UhhK5GXayc3zB07mS6HVD70/8xzg7P4/nQt8n6w0dEMKFEaIx97wsDsBgYqRRIBoMHbO3Q2Jl
 8Cs9i+5LM/z9hWr80/bZ0kJ4Sv9HXQuv1AR7oWFXTqpUmgju8rn6C2fDy7ZOMpKfsp70Y+0yrg/
 Y1ivbU2N2Kia2YMZiy4neKSLJ0sxbwDh/rlKdCklPHphqynJ2Hf24bjCxHnpNDOUVyjWNLhgz0z
 K5PcDGALK6oaDfbg44P5GUK5ibP1yQOCWvQnyldvKJw8fiudwZqTujKNvCSN7i7rXy/4bOXlOSK
 GhEGARWdIJHT78GhMWzxaIS0s3yu/LdtLk8oOmwSlYfSDc83tSenl/PSTmQ==
X-Received: by 2002:a05:6000:2c0c:b0:42b:2c61:86f1 with SMTP id
 ffacd0b85a97d-42e0f34a082mr8042809f8f.35.1764174517044; 
 Wed, 26 Nov 2025 08:28:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHIHiBtTEC+GB2idM5msCaHnYuhv/BudNRpMJKHSA2WN1SdtfsBDoXFhWlKh03j+ARnRkne6g==
X-Received: by 2002:a05:6000:2c0c:b0:42b:2c61:86f1 with SMTP id
 ffacd0b85a97d-42e0f34a082mr8042777f8f.35.1764174516620; 
 Wed, 26 Nov 2025 08:28:36 -0800 (PST)
Received: from rh (p200300f6af35a800883b071bf1f3e4b6.dip0.t-ipconnect.de.
 [2003:f6:af35:a800:883b:71b:f1f3:e4b6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7fd9b45sm42175143f8f.43.2025.11.26.08.28.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Nov 2025 08:28:36 -0800 (PST)
Date: Wed, 26 Nov 2025 17:28:34 +0100 (CET)
From: Sebastian Ott <sebott@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 peter.maydell@linaro.org, cohuck@redhat.com, maz@kernel.org, 
 oliver.upton@linux.dev, gshan@redhat.com, ddutile@redhat.com, 
 peterx@redhat.com, philmd@linaro.org, pbonzini@redhat.com
Subject: Re: [PATCH v3 03/11] target/arm/cpu: Allow registers to be hidden
In-Reply-To: <20251125100859.506228-4-eric.auger@redhat.com>
Message-ID: <d053b75f-1a09-d929-1cd8-9485672cb4ed@redhat.com>
References: <20251125100859.506228-1-eric.auger@redhat.com>
 <20251125100859.506228-4-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="-1463806286-70621147-1764174516=:22658"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sebott@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.224,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463806286-70621147-1764174516=:22658
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Tue, 25 Nov 2025, Eric Auger wrote:
> More recent kernels sometimes expose new registers in an
> unconditionnal manner. This situation breaks backward migration
> as qemu notices there are more registers in the input stream
> than supported on the destination host. This leads to a
> "failed to load cpu:cpreg_vmstate_array_len" error.
>
> A good example is the introduction of KVM_REG_ARM_VENDOR_HYP_BMAP_2
> pseudo FW register in v6.16 by commit C0000e58c74e (“KVM: arm64:
> Introduce KVM_REG_ARM_VENDOR_HYP_BMAP_2”). Trying to do backward
> migration from a host kernel that features the commit to a destination
> host that doesn't, fail with above error.
>
> Currently QEMU is not using that feature so ignoring this latter
> is not a problem. An easy way to fix the migration issue is to teach
> qemu we don't care about that register and we can simply ignore it
> when syncing its state during migration.
>
> This patch introduces an array of such hidden registers. Soon it will
> be settable through an array property.
>
> If hidden, the register is moved out of the array of cpreg which is
> built in kvm_arm_init_cpreg_list(). That way their state won't be
> synced.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>

Reviewed-by: Sebastian Ott <sebott@redhat.com>
---1463806286-70621147-1764174516=:22658--


