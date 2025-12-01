Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BB02D111A8
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Dec 2025 10:08:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQ0ol-0003R4-Nh; Mon, 01 Dec 2025 05:07:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vQ0nJ-0002Xf-Qn
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 05:06:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vQ0nG-00039b-GO
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 05:06:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764583564;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uW1p99+fEKKcsGF5xx8D4kXfkA4YCt3Lw264D2SyIyc=;
 b=VxgL8Rk6USRh1XCScBfgsQKZ4G2+Py0yvMJAh9Shg5EL6tNBBJfyMArt1feNQc54Bg+zcg
 q0huPgiB6AcplYuAq8v54rH6wGmAY6fNl/FUKuvJLiPLHnlVzy0OL9wlMJtVVRCX5/MOXl
 0wa4X7QLX44s2Nost6AL0QvcaCSppJA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-261-u4aDnU8wOBuw6rQ8-cyVLA-1; Mon, 01 Dec 2025 05:06:03 -0500
X-MC-Unique: u4aDnU8wOBuw6rQ8-cyVLA-1
X-Mimecast-MFC-AGG-ID: u4aDnU8wOBuw6rQ8-cyVLA_1764583562
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-42b3c965ce5so2990717f8f.2
 for <qemu-devel@nongnu.org>; Mon, 01 Dec 2025 02:06:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764583562; x=1765188362; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uW1p99+fEKKcsGF5xx8D4kXfkA4YCt3Lw264D2SyIyc=;
 b=IYATKFKEDroieJzDTf81s+W1dLHnEMo74zq+pKtnwIhAKWpciDBSfuA1ZuO9xeikFN
 A00blj45V4/9561iCUVsrJXVEaHYr93PWO7T/H8jDfaFfj8KrNqxbnwGynt+PFp6Eqhs
 sQEMCvM3uHLepcjueLVpJXECSeWjFXOkwjPNkJP2WJGwYfEwXKWB62RPhGXJ0WZfxY3t
 NW8sGyWDPf3FRaDMBHZAZNiRGmg3jsO4ph9hQkNpSNQrP44oHhrRjhUvQ8NWopwVfGCH
 vIUDUyWhqlpYeJFWz8gWnTS0am0JZU6ZqqNh+KoSgbjaGknh4FTE36ivKEdqPBofBJ/9
 D50g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764583562; x=1765188362;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uW1p99+fEKKcsGF5xx8D4kXfkA4YCt3Lw264D2SyIyc=;
 b=ssnjiHZUfv/L3cpov/xiR5m1fin28WPBrXSN4d2R3NOvDqZ52LM0ZO6+J2Et9VuhHt
 2BEYG3ocRkhGX+MelFKVS4GsyGlCgZDNJU4zIrTr9i8dFN6BXefpVcmV+hy238iURBgb
 wyU1P2vh8VMlNlAR+vtGGKFoJWacGlknTj3GddeV6VJ2f6SueWKowRJhJ+/UXfMHN3Hk
 V8pRw2KYtb3AIv/EInIii5TC8T4/jR+EGYxMzvu/AMbfyhsrEBAd/eUZaBhWrmQpcjuT
 QPmb1ay/stUJYYxur0WD4p24S+YRsAMHqWvgKajffXTl9IFfd1xh752Msg946iCvW5gJ
 F9IQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2RhqNRyxy0T4HLVjl2FfrCCClvRPXDv/FE6O+jAqdYqNxZwoR8GPhuL78t5j/KGAhYVwu/N1DnDVb@nongnu.org
X-Gm-Message-State: AOJu0Yz3d89L1QaRROCLHdmZCKDdMRvN+dMREGW5lkK5+JPSxa4VGDNR
 ZSpt27JmVomRXB+EUTvVZbvTn1wkiNtn/Pc04hb8yNGsTRrz54zfn8MsQVKaiFoooIxp+VAD5/7
 J5dfQnI7sruH0QYGIj+tKETV11TrglDPot7s6D5jD13TLlVmZai92xBW5
X-Gm-Gg: ASbGnctrhPjcy+/kdVxz75IcnMK/Xk3yPBc1ZO1i8yvGvxghdSxuq4YGsGv3p4HteOt
 aq9+AliZvQdRzJjlY3Z4zN9N3u5h+1rUbk8Mi7gL+hW0aNuWaMJcuiEoKRH6GKjIVcK2g1Yw4Bo
 Tm8+0cIDkt+AnUstJfjHQ+5AhY/xFfD1KrowxZU7JXSm+5uk55OfiopsEDcRjSzvAfO+zyvQUXS
 Z02FJrcMfqtcx8A9NyMqze3kzREnh4nuRIC4vlwqu2qqNCK/E9Bg+21C/hVTrxTq8dtQ0eSS+8T
 yL7zFl+rF9E+Yr2li0E8i6HxdLPfDrbI82niAxrJnaRqqCTC6ol6GLoBTEjUCQLukarAJA==
X-Received: by 2002:a5d:5f54:0:b0:425:742e:7823 with SMTP id
 ffacd0b85a97d-42e0f1fbd71mr27026358f8f.12.1764583561892; 
 Mon, 01 Dec 2025 02:06:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFhuYmeLXGraGZvXTc50VFEuB2MxTZxQVtw773W22xA0ONbEaj/VVEQOaSMqTTXLGSZ2IxBpA==
X-Received: by 2002:a5d:5f54:0:b0:425:742e:7823 with SMTP id
 ffacd0b85a97d-42e0f1fbd71mr27026320f8f.12.1764583561483; 
 Mon, 01 Dec 2025 02:06:01 -0800 (PST)
Received: from imammedo ([213.175.46.86]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42e1c5c30c4sm25852149f8f.9.2025.12.01.02.06.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Dec 2025 02:06:00 -0800 (PST)
Date: Mon, 1 Dec 2025 11:06:00 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Gavin Shan <gshan@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, mchehab+huawei@kernel.org,
 jonathan.cameron@huawei.com, armbru@redhat.com, mst@redhat.com,
 anisinha@redhat.com, gengdongjiu1@gmail.com, peter.maydell@linaro.org,
 pbonzini@redhat.com, shan.gavin@gmail.com
Subject: Re: [PATCH 3/5] target/arm/kvm: Exit on error from
 acpi_ghes_memory_errors()
Message-ID: <20251201110600.370bc0b5@imammedo>
In-Reply-To: <20251127004435.2098335-4-gshan@redhat.com>
References: <20251127004435.2098335-1-gshan@redhat.com>
 <20251127004435.2098335-4-gshan@redhat.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
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

On Thu, 27 Nov 2025 10:44:33 +1000
Gavin Shan <gshan@redhat.com> wrote:

> A core dump is no sense as there isn't programming bugs related to
> errors from acpi_ghes_memory_errors().
> 
> Exit instead of abort when the function returns errors, and the
> excessive error message is also dropped.
> 
> Suggested-by: Igor Mammedov <imammedo@redhat.com>
> Suggested-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Gavin Shan <gshan@redhat.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  target/arm/kvm.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index 0d57081e69..acda0b3fb4 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -2460,8 +2460,7 @@ void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
>                                               paddr)) {
>                      kvm_inject_arm_sea(c);
>                  } else {
> -                    error_report("failed to record the error");
> -                    abort();
> +                    exit(1);
>                  }
>              }
>              return;


