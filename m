Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30D59D11184
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Nov 2025 22:28:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vONzv-0007pe-VI; Wed, 26 Nov 2025 17:28:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vONzp-0007oP-I0
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 17:28:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vONzm-0004Il-4O
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 17:28:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764196096;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=a37zBTN9+DLC02idUW67f9zAWok0gX7O+ydKWrXTJEU=;
 b=R9WHyTdRVFVTZ+csqST1sYQ383P3hY7nz3a1Ms7tG3QvS2SnwdwtyQRtKQpq37V73toIrI
 Fcitn3EyIp7lBmdlJOKyIMtdqyJWvQkYdgJDWnS1ocEjRi8qrX0rtchDPwUIhPwuv8nXMQ
 7ezAUwxCLUuLN1WqoxLbLcecfLZs3j4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-38-YBXiHAA6Mvu0G8hKS6M3rg-1; Wed, 26 Nov 2025 17:28:14 -0500
X-MC-Unique: YBXiHAA6Mvu0G8hKS6M3rg-1
X-Mimecast-MFC-AGG-ID: YBXiHAA6Mvu0G8hKS6M3rg_1764196092
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-477cf2230c8so1739615e9.0
 for <qemu-devel@nongnu.org>; Wed, 26 Nov 2025 14:28:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764196092; x=1764800892; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=a37zBTN9+DLC02idUW67f9zAWok0gX7O+ydKWrXTJEU=;
 b=VGMhTKMIjYacgeDklLeZSWiXMzc0PP31zuMnBUeuxni5X2pysbJroDprkufne7mSQj
 OJ8vlS4IEBQ5S3hYhWszouPyTUl3sEjyiPxAk0O8XrFgjDHw5+84f/aeQscE8EuiTZnL
 dq5WnwLUZbfAabnXAV88mDeQbubZR22+KWZlYZkNPq6M8w1Tb06eFAOrTWJAiodjySS/
 L1bbkWqUpi1G+ojmSmObbhsiEnOrbTue7JrRKxkFS8FX5jR/D7iLeOnCvGwBDOlaroD3
 POM8DhMCTnG1zKd2xNU152f//KUL8++JhlErUvN+3x2A07EVzxJRz9UlzVXj9n/NeHw3
 9S4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764196092; x=1764800892;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a37zBTN9+DLC02idUW67f9zAWok0gX7O+ydKWrXTJEU=;
 b=cO+Iuiklu7gmN+TPoQc4JZtZfLi37Bm5cgsqwMPdwAKA6PNUwf1QY31ijO6OjuWF4b
 gb/67vzJ5sytI3jrU6OvolPlUJpbCBRf2W6/5sVnWw6LI+7fiwIKMqjqXsoTuU9jk613
 2Ii6HzyYqy/WZ2vdFY88tsDu7lnhY1ox3h6Mxyjv37TlHGIspMSS9YjqwdeYYSrQbhGU
 B4uubkpfUXJTEKXv0v26DVt/MvogMCjBeTZUoX+dL9vKyq8oDnDGozOSfIQ7g4KsQfUz
 Cdieck6nLgGDn/Wl+5QLQy/9jzFUyRdumw5hEkGLUgq7Na91G3ODw+uSlWkfB23D9kiQ
 DAjw==
X-Gm-Message-State: AOJu0Yxmb5zoWbJYU6mbS8LqDwEG2jHa76+uaNe84dBTqfSejGTBAp8T
 l//LYlo4XeV4LL81ajiFYxCeJIXq8XteIUcX8DNP6ietan5bWePKSlJaWXqW/WW3b46bJUJLioS
 kdeKfEqAj8Phb3owIY9tBnGUB2vexuV7ddSfGn81lwxPjUHDYcQDy1bb8
X-Gm-Gg: ASbGncswEtql9KCKCIJ8r70jQaJtRyMHt74u/2rbXzsCX54qRddVh9Qa4fLKz7jcY6d
 RfZ3q4PT5trXHYS1JpJyirW5cISap8nauxqHjFc5hsNwcS2P6taKI1uM/k+FRLNmZsNZUEucvim
 QBXofqlyiR6Q+GtHmkXefhSpi10FRxuYlwD9utePkAHavhIoPcvYBzYIWhhnoY29KSJDG8R84ff
 Ik6dl+9ytEf5xIhVDiODR6nzlesw/X4dX3G2CLpSf2dOpPAji4MSRBDbJ8CcVzKG+x9IhVgRSh7
 4xqv1rKxzw7CptcHfR1E0GjSBFKJYP6AovuXQKbF1q2bPpDo8ugfKsWhEA0chauyzxKkLaecXLv
 Tfuvjl1BXczLp1Xu0jBrUUbrk2PR1dw==
X-Received: by 2002:a05:600c:1d26:b0:477:9cdb:e32e with SMTP id
 5b1f17b1804b1-47904ae0654mr80630915e9.9.1764196092282; 
 Wed, 26 Nov 2025 14:28:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGSLSDCdqFyRAhx+GokUVG7+eLHSuLsju+fHnoMlyrGFOHD6c6Y90U+3VUNnlLyJq563mFm6Q==
X-Received: by 2002:a05:600c:1d26:b0:477:9cdb:e32e with SMTP id
 5b1f17b1804b1-47904ae0654mr80630805e9.9.1764196091843; 
 Wed, 26 Nov 2025 14:28:11 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7fa3592sm41693134f8f.21.2025.11.26.14.28.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Nov 2025 14:28:11 -0800 (PST)
Date: Wed, 26 Nov 2025 17:28:09 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH 7/8] tests/acpi: update expected data files
Message-ID: <20251126172712-mutt-send-email-mst@kernel.org>
References: <20251126142116.4077056-1-kraxel@redhat.com>
 <20251126142116.4077056-8-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251126142116.4077056-8-kraxel@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.224,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Nov 26, 2025 at 03:21:08PM +0100, Gerd Hoffmann wrote:
> New firmware builds change the memory layout a bit,
> so some addresses in the acpi tables need an update.

Please, show the diff of the disassembled tables
in the commit log.
Otherwise the change is impossible to review or rebase.


> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  tests/data/acpi/aarch64/virt/HEST       | Bin 224 -> 224 bytes
>  tests/data/acpi/aarch64/virt/SSDT.memhp | Bin 1817 -> 1817 bytes
>  2 files changed, 0 insertions(+), 0 deletions(-)
> 
> diff --git a/tests/data/acpi/aarch64/virt/HEST b/tests/data/acpi/aarch64/virt/HEST
> index 674272922db7d48f7821aa7c83ec76bb3b556d2a..cc1641fdb4e7144a72278f7ef502352139d7b9e1 100644
> GIT binary patch
> delta 56
> zcmaFB_<)hi!!<bM0RsaA<A;e{793`73=9km95NFFMJ6V&PTbGQBEVqgHnBjD$;@ry
> K0xb|(AOZlXP!7ES
> 
> delta 56
> zcmaFB_<)hi!!<bM0RsaAW6ne_3yxdP3=9km95NFFMJ6V&PTbGQBEWFVd18Sc(=F$T
> K3$#FFfd~M<x)8kp
> 
> diff --git a/tests/data/acpi/aarch64/virt/SSDT.memhp b/tests/data/acpi/aarch64/virt/SSDT.memhp
> index 1deb1d2832201a5da7501821f1ea20d3eecb08b2..a6c8bd9ea06c8704f82a35792d6415f42e0de23d 100644
> GIT binary patch
> delta 22
> dcmbQqH<OPmIM^jblAVEp(RL#jFFTW&8vr>C1VR7+
> 
> delta 22
> dcmbQqH<OPmIM^jblAVEpan43AUUsHi&Hz111wsG-
> 
> -- 
> 2.52.0


