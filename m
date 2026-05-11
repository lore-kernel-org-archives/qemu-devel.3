Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5EACCD37AC
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 10:19:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMNiW-0005In-44; Mon, 11 May 2026 06:18:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wMNiU-0005Id-HH
 for qemu-devel@nongnu.org; Mon, 11 May 2026 06:18:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wMNiR-0005es-9a
 for qemu-devel@nongnu.org; Mon, 11 May 2026 06:18:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778494701;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iT3dkcd7GeoJtYyL1uOyBtkKYO1pg0b5qX36ozRdkHU=;
 b=edyWerTOeIWr0WpOdz0Oa4cDPFoUMd0u/s9FhziExxg5GFcjEcDjp/mLYBfFnvuzrscFwX
 i2M8UBHuRTrd9NMmNffijI9iC9YtpKsiyL5t6H6Wij/Sp4FRvMR8OAddbHKIURo3XVfOmu
 JvNKmY1wSMFtnkz/nfKglN3DBHOwB1Y=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-04GTwqGNPe6ALMpe8wf7BA-1; Mon, 11 May 2026 03:10:51 -0400
X-MC-Unique: 04GTwqGNPe6ALMpe8wf7BA-1
X-Mimecast-MFC-AGG-ID: 04GTwqGNPe6ALMpe8wf7BA_1778483451
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-50fb3403e99so68527721cf.2
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 00:10:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778483451; cv=none;
 d=google.com; s=arc-20240605;
 b=F9zd2oypGRwX+FZKY1+3TdRB8yCPzNddXOlmnLRYqbo0aN62gkRIrhz5NR7R/5oZtW
 BWG3TvruWaumdOr+88UgIxSvvCw7I8Q6Rn2+m2/SNbY26sqJIQFNNNn9/npH/82NZ519
 jq9XGmG8LMM1nCLbREp4BkBZcG9xN7Hmo7cnEkUALz8E8i65P1enJRwDUSWrvyJ70H7K
 l2PHPApv8pVhdLyszTPjeeTa55RYWxfj48q6WRockXCAs24ltmtzW3TUzTNxMJ1spsv1
 3S9A4n426BR9so+uCQ7FsdGwEt4utF93FfeowpvJV9MXUJb+4yGhsRQYFTB3XxC7A3U6
 x5DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=iT3dkcd7GeoJtYyL1uOyBtkKYO1pg0b5qX36ozRdkHU=;
 fh=JFAiEBBl2r8CSzdMzyKIeeFbKAXbQlZHrrTafmuotlE=;
 b=hnEjzWZ9BoyIXP93S/XU0GIjZyWPFfuw1cfuUN7N7aVdRp1wv10mtJm8foNdfcJZ2L
 b+HbLv+gCUTdyKq7+7JbU/KdWnySQgRV4B83HeeiyLSN8sSXRzrklatyJm041lfmNh1W
 ktv8tyEWtbQIFnK8JCC3SXqiaNOsWd8c4+J2QqURCDZdIJ4oDeW8nRzCcPBBNB9TAo6H
 iBJA0+2q+W9Bwud4s3EYp17C2dS9qvatxiw9TQfp4/R8CbC4qYC3eFXHdGgcGLH8C0+o
 w7YPTruj1hf+g48wAx6a62Xo/FArqZW83ckOWKD7Gfi5OSw3wZ8J2Y0f02/gQdeDznoe
 bacw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1778483451; x=1779088251; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iT3dkcd7GeoJtYyL1uOyBtkKYO1pg0b5qX36ozRdkHU=;
 b=iqRdPeXorrfT8BHw3hbE0Sv+VcPYQCdhJhaRDqbZubSFkmWPQdN8njvkhsCkQMGFpm
 8dhIUOVzrJqj2lQ2k5YbJkGlquNyFRP+mgZ4zn4zxPsI0fcQ8d35N92ERAO35Mwf/2jV
 AtJiIiLVX5Tvg9fDkK/BVTZxHjhDIyi5hXy1J11UW33ymsjzovioO5FyhwV/Dc6MTYnd
 K3AZrkTlyJhFGX+VAAwWuZEatNgSl/FTDl/3lNX4wwc836xjcVuFCuakyebBKSwAjDCb
 RQ+QqoCqoXmsULexxUYUYUUpWCbJPFMKn6VSd7ONVbLXvAWtGmtDMmsiZn1bMFXNVckW
 S9rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778483451; x=1779088251;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iT3dkcd7GeoJtYyL1uOyBtkKYO1pg0b5qX36ozRdkHU=;
 b=c4in4zfkJO2c04ZR6PVwdpQjwsXV7LDzKUOy3koUJSeE29wG6TnpaKhPRqMztHUpnO
 m2j8q/vNrkJxkC0I8H78YQsSOAXOwUo6/wO5LANM/3VnWJAJTyotFw3vwVU1/lAOeraF
 GSjsM9His2Jl5+l3IOLsXGp50xhOYmNdHFQ/3qeSWCxlfmbUwt8hq8F2qi4GLidUPNCv
 WQcwJinKaSFcw8OJU8IjTLWQ446TiVJzRx5rWkAxu+7nJD1QdBrjBmQBoLFkb8ozsOPB
 Z1l905PHCrjKOtRd/0ajdJePB003tXENyUY3BxfoIHboVMHyHdEEYNCo37gLX0AFRP0Y
 Cw3Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ9YqtyixeoFwNaagvYnnYbhEctoj9lzz4qF1Emoo3/HyX4FpktHw+VV6Tcgv4HMxioXskqv+9IERqhW@nongnu.org
X-Gm-Message-State: AOJu0YybOrNU6XCiZx6fgDyoBIQLjEe6J0yqTViNX1ZVwiqiVFuAJerr
 cW3Jv00+Gdn0MLMDAeM5hoDES7HkPxEuvMOWr0UL8Rc9F5N3zCUUp8COyZ2W5a544YO7s1rvXCj
 yZsPEHZG3EJNuxQ2cP1VzgPKMDWvRCDu7cy0LLkg2qIqmmaA6O0etDDYn4WB8fNrbEQKdtFyga7
 g3DGeq6ZF5BMY8a0ZEgwB2RP0gCafvQOU=
X-Gm-Gg: Acq92OEgfFaRDUJxo8vR+SUv+MiRvcDHeWncnvlPjpSJca6uziikn/y+Jsi/OBJQb2H
 /R/YCKCEJcwWRomAYOLiFHGkwl22faWfa54UQqSXoCkwnYLYlJb3jqbkGbqH2J35rOJ2cGnvoxc
 icl/JOiL7UJsuYSKVwNTnq8kD0DwElObRl1pq9DY1rzacN50cqGURZ87Vi3VlZVkCNghdcYShrx
 OsmdS7N3XgIZMkXLL41kplkvWFEspZFBUv/XDI=
X-Received: by 2002:a05:622a:1145:b0:50d:2a98:2571 with SMTP id
 d75a77b69052e-51461e72ca8mr317578321cf.26.1778483451001; 
 Mon, 11 May 2026 00:10:51 -0700 (PDT)
X-Received: by 2002:a05:622a:1145:b0:50d:2a98:2571 with SMTP id
 d75a77b69052e-51461e72ca8mr317577901cf.26.1778483450458; Mon, 11 May 2026
 00:10:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260508101901.930781-1-mark.caveayland@nutanix.com>
 <20260508101901.930781-3-mark.caveayland@nutanix.com>
In-Reply-To: <20260508101901.930781-3-mark.caveayland@nutanix.com>
From: Ani Sinha <anisinha@redhat.com>
Date: Mon, 11 May 2026 12:40:38 +0530
X-Gm-Features: AVHnY4IjfsPUOUTND_oMUeuyzps9iDaGY-FIVZFt-q5mIew1zq1PyNLop-hDL3A
Message-ID: <CAK3XEhNN7t4eX0ejmJvgD0X9Y=ZGn+nSg2PXPkCqgvxXAJQshA@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] tests/acpi: allow DSDT acpi table changes
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: mst@redhat.com, imammedo@redhat.com, pbonzini@redhat.com, 
 marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, May 8, 2026 at 3:49=E2=80=AFPM Mark Cave-Ayland
<mark.caveayland@nutanix.com> wrote:
>
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>

Acked-by: Ani Sinha <anisinha@redhat.com>

> ---
>  tests/qtest/bios-tables-test-allowed-diff.h | 47 +++++++++++++++++++++
>  1 file changed, 47 insertions(+)
>
> diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bi=
os-tables-test-allowed-diff.h
> index dfb8523c8b..cef44135bc 100644
> --- a/tests/qtest/bios-tables-test-allowed-diff.h
> +++ b/tests/qtest/bios-tables-test-allowed-diff.h
> @@ -1 +1,48 @@
>  /* List of comma-separated changed AML files to ignore */
> +"tests/data/acpi/x86/pc/DSDT",
> +"tests/data/acpi/x86/pc/DSDT.bridge",
> +"tests/data/acpi/x86/pc/DSDT.ipmikcs",
> +"tests/data/acpi/x86/pc/DSDT.cphp",
> +"tests/data/acpi/x86/pc/DSDT.numamem",
> +"tests/data/acpi/x86/pc/DSDT.nohpet",
> +"tests/data/acpi/x86/pc/DSDT.memhp",
> +"tests/data/acpi/x86/pc/DSDT.dimmpxm",
> +"tests/data/acpi/x86/pc/DSDT.acpihmat",
> +"tests/data/acpi/x86/pc/DSDT.acpierst",
> +"tests/data/acpi/x86/pc/DSDT.roothp",
> +"tests/data/acpi/x86/pc/DSDT.hpbridge",
> +"tests/data/acpi/x86/pc/DSDT.hpbrroot",
> +"tests/data/acpi/x86/q35/DSDT",
> +"tests/data/acpi/x86/q35/DSDT.tis.tpm2",
> +"tests/data/acpi/x86/q35/DSDT.tis.tpm12",
> +"tests/data/acpi/x86/q35/DSDT.bridge",
> +"tests/data/acpi/x86/q35/DSDT.noacpihp",
> +"tests/data/acpi/x86/q35/DSDT.multi-bridge",
> +"tests/data/acpi/x86/q35/DSDT.ipmibt",
> +"tests/data/acpi/x86/q35/DSDT.cphp",
> +"tests/data/acpi/x86/q35/DSDT.numamem",
> +"tests/data/acpi/x86/q35/DSDT.nohpet",
> +"tests/data/acpi/x86/q35/DSDT.acpihmat-noinitiator",
> +"tests/data/acpi/x86/q35/DSDT.acpihmat-generic-x",
> +"tests/data/acpi/x86/q35/DSDT.memhp",
> +"tests/data/acpi/x86/q35/DSDT.dimmpxm",
> +"tests/data/acpi/x86/q35/DSDT.acpihmat",
> +"tests/data/acpi/x86/q35/DSDT.mmio64",
> +"tests/data/acpi/x86/q35/DSDT.acpierst",
> +"tests/data/acpi/x86/q35/DSDT.applesmc",
> +"tests/data/acpi/x86/q35/DSDT.pvpanic-isa",
> +"tests/data/acpi/x86/q35/DSDT.ivrs",
> +"tests/data/acpi/x86/q35/DSDT.type4-count",
> +"tests/data/acpi/x86/q35/DSDT.core-count",
> +"tests/data/acpi/x86/q35/DSDT.core-count2",
> +"tests/data/acpi/x86/q35/DSDT.thread-count",
> +"tests/data/acpi/x86/q35/DSDT.thread-count2",
> +"tests/data/acpi/x86/q35/DSDT.viot",
> +"tests/data/acpi/x86/q35/DSDT.cxl",
> +"tests/data/acpi/x86/q35/DSDT.ipmismbus",
> +"tests/data/acpi/x86/q35/DSDT.xapic",
> +"tests/data/acpi/x86/microvm/DSDT",
> +"tests/data/acpi/x86/microvm/DSDT.usb",
> +"tests/data/acpi/x86/microvm/DSDT.rtc",
> +"tests/data/acpi/x86/microvm/DSDT.ioapic2",
> +"tests/data/acpi/x86/microvm/DSDT.pcie",
> --
> 2.43.0
>


