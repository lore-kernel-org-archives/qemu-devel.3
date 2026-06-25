Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01D8ACDE000
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 17:37:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wco0j-0002xy-2i; Thu, 25 Jun 2026 13:37:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wco0g-0002xW-Is
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 13:37:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wco0f-0001mB-4U
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 13:37:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782409023;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z074bJO6OHWaI7OyPaH6/IPDvBnvlv9ayjdX6IUQvtI=;
 b=btq2T22JWv1EduvtDZqIBwovAQt9Igx7bBItmNT41rQEhyfwdYJ77GGI6bAGI2etPo6LaU
 abZg5j9TtJ+cP7Ws+gvOtt85G00WziVOZS3h37dMh+4ZMPfqbzjuhGt1UcIkYQXCmdChTH
 nqmZOj1+A0panwsdNI7Dk2b1fEXLNPU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-115-Fpfia1kfMxuFhK4H8qL2uQ-1; Thu, 25 Jun 2026 13:37:01 -0400
X-MC-Unique: Fpfia1kfMxuFhK4H8qL2uQ-1
X-Mimecast-MFC-AGG-ID: Fpfia1kfMxuFhK4H8qL2uQ_1782409020
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-4625b4f54c6so14835f8f.0
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 10:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782409020; x=1783013820; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=z074bJO6OHWaI7OyPaH6/IPDvBnvlv9ayjdX6IUQvtI=;
 b=IV8ytKK34GYxtiIFcVtk8jaMdqF56mG9nQgB8TS6mGlL3wd1UPzuwvcU1CG2HfSgts
 1ihgnl/QSaiPrb/mSBxZxFJ7NlhWJ6bFC8UW7YbfMYPWoJky+Ht2ZLGM865vXgEDsfcV
 +RScb+dwErtuTJ5/wdUkR+3gj84UPQildaf/sMz3+d3ocPHTPcDU5a4jiqHFwb82XOvI
 31P6lnT14NPO5lDD1efaykn2TldbcQmQhV6l0MeWd9VvsHC7R2Cchjt1ZSgYwZSHi9o0
 BF2fm2vrDYoVF+g+PC6KsPK/+y5ULUxzQFtTUfWGotzSox5KzEDAbBP7ZcrPs/tXTgUA
 qA6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782409020; x=1783013820;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=z074bJO6OHWaI7OyPaH6/IPDvBnvlv9ayjdX6IUQvtI=;
 b=S03C5YZTsZB4kWGJBRiEObFJwb2pLYmojJSVZ9F10No7d+Ggb47EWKcnVt/ctS3Tes
 C2BwABxxDRP0eHRuc1GOTptv4a3cKw88x0m9zmHtGJYVq3GC0uCMtM21oERHkZppXTaI
 2FZOb00jqj6JL2qW4uFBu1uhDLgNsHOl4bgIvVGkleUB3QVCQSF9VLw3HU5iCvcWDY4d
 bwOcRgD9jR7gENI00Y5FUaYfKOn7Hh88FGy0CHYMZw5QRHvqfT8+Kmk6KBp6j+dq4ajV
 Uve3IfLFobXEiho1Fp7Sg+JUP6qH3uGyB0JluRN/GD6H2Nw51jw8qfdzH5Qo0ks8Oqp7
 vGUA==
X-Gm-Message-State: AOJu0YxANtAkalR92UFe9IDGAqXz46IiW3DI6ElufGbaig/gKVgobhpX
 6FLHYLOJBE7QxNJzbE5yLYD1lRqyx5arYePo+RlWQWRt0KtBktEg3/0cGCUcABqghS8DbvoPqyD
 hVXG04I2Mby+wj60v3Lgop8Bwhbw7qM47tgw/EACnzDYGKzhzS2nKRWNW
X-Gm-Gg: AfdE7ck3nuDFothnHFDik7cKP8tP0243eYRdIn4rtwSzZ1OycdbMHsDIpA3JBE+JUpE
 4QXPYGuVFblqfOEkAW6AxvPTDURxkF7Gg7sSkMjPN5FKUFhgfk69dNPfWyLQ8ffIWgEGY+j+R6A
 TNnCTiPqcKTFKPoPTy5Hv6Uz/39Bp1DTTWD8SHW1RcKU15Cwkx7jN2ol3D+TSLeIP0ptbRRd+QP
 BCuQwRktB1wBwxZGtZZ6ZSGhW3KZKhE+D9NZUPJHdEqruHtbG1AbuTKr7japp3Ng3cJTIIbDRPr
 TVnFKN/bYpSxCZyiQRI7LQiHcEl7QprCDQAaZWDMA9jlREq0o77aon4fCFJ+kMl58W3NMC7fSh0
 b9AAkyfgXofSju6/cHzb0hfJLgjSL23f5II5WwRSgurdhhZfbmOqcfHq63wan1vw+EyQrUYx1U4
 TXCWFJWfDjyJmZc7Xj
X-Received: by 2002:a05:6000:220f:b0:465:8fc5:7f52 with SMTP id
 ffacd0b85a97d-46dc0e05344mr5737796f8f.26.1782409020386; 
 Thu, 25 Jun 2026 10:37:00 -0700 (PDT)
X-Received: by 2002:a05:6000:220f:b0:465:8fc5:7f52 with SMTP id
 ffacd0b85a97d-46dc0e05344mr5737745f8f.26.1782409019927; 
 Thu, 25 Jun 2026 10:36:59 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.124.208])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46c22c680fasm18026588f8f.34.2026.06.25.10.36.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 10:36:59 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Magnus Kulke <magnuskulke@linux.microsoft.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Magnus Kulke <magnuskulke@microsoft.com>, Wei Liu <liuwe@microsoft.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Wei Liu <wei.liu@kernel.org>, Alex Williamson <alex@shazbot.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [PATCH 00/34] Add migration support to the MSHV accelerator
Date: Thu, 25 Jun 2026 19:35:31 +0200
Message-ID: <20260625173530.1624189-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260417105618.3621-1-magnuskulke@linux.microsoft.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

I merged everything except:

- target/i386/mshv: migrate LAPIC state (*)
- target/i386/mshv: migrate Synic SINT MSRs
- target/i386/mshv: migrate SIMP and SIEFP state
- target/i386/mshv: migrate STIMER state
- accel/mshv: introduce SaveVMHandler (*)
- accel/mshv: write synthetic MSRs after migration
- accel/mshv: migrate REFERENCE_TIME
- target/i386/mshv: migrate MP_STATE

The ones marked (*) were the important ones that I'll reply to, the rest are
collateral damage.

I also removed TSC_DEADLINE from the MSRs patch, since it's more of a local
APIC register and it has a dependency on "migrate LAPIC state".

Paolo


