Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDA2DE9A03B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 12:28:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt38I-0007Bw-5j; Thu, 19 Feb 2026 07:27:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vt388-0006Zh-Kn
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 07:27:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vt385-0002Ar-8y
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 07:27:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771504054;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BCp9VC8NCOwy7Gb72FEIAQX+YRpsYez6BIjZtUCT1K8=;
 b=cmNZfhsJKqC+XWpaIEBrMn92XsKrrW/3OCRd7C0R4BarAsoBH1Ggg95IhWwQexvQRYmnKV
 yCl86c1aTL/j1/4DFt4YTrgdPMC9iEtzD8qkm5UhPJv1qoKYrTt+k+xzvXVQe5DSeV2IFN
 sp5NZNlNhbQVlWByzJ4/zbf8qyTlxdU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-X0KByVmdOe2AZsqMg0qLGw-1; Thu, 19 Feb 2026 07:27:32 -0500
X-MC-Unique: X0KByVmdOe2AZsqMg0qLGw-1
X-Mimecast-MFC-AGG-ID: X0KByVmdOe2AZsqMg0qLGw_1771504051
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4836b7c302fso7272735e9.1
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 04:27:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771504051; x=1772108851; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BCp9VC8NCOwy7Gb72FEIAQX+YRpsYez6BIjZtUCT1K8=;
 b=iOTwtanzKD1ChT5T0V0KqUZ37eaW/W4y6KxnEAtVsuLT0zGs2aGnvgXI75whkfDkoQ
 TzRH1DFpLLEkjUYCWDxb8/ru024fySiGlxc0XR8TQpZAdTDhc+VghkgRdv2vMobYXuYO
 Cf0DuCDPzEiHDjhThhv3FyIyb9d5rxTU4zlSwb7zETd0Y18/7J9JjjLFpdlgbZF6DWJV
 /6LK2huv16wlRo5brYkwm32+drpFyf+/T9emfCe2YMEsCCZzONLRoXwzhxsJmzzmA3zF
 o3gxMDcD58/llZAyFOZdx3xB24fCMBnGrIkcYzCxF5q23hB0Bf1X9+6AWdCvq1Wz6XEF
 bpHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771504051; x=1772108851;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BCp9VC8NCOwy7Gb72FEIAQX+YRpsYez6BIjZtUCT1K8=;
 b=t64UsDEj08i9ZcvROqekYLmy2rPIvm7DV7DWp9MlfmalQ41TS4TH6m+i1F2mvXtZJR
 YkYuAWj7TSv1GM+Q69rcl4ii9RWusdTc2KU3evJqWA6ks6fgDbqrazLGzXPaN2i4E4Xl
 abxs0uQ6+nS+Lno9Hgfp7idbF80+LYeNCdU/o1msqfUjghocsIfQLiErFvW38znYHBA8
 Thmc0ffBcvrk1a8pcVk3V8SsxdPipIsSlDN6iO+Bs82yIp4wK6/BWsBXUWgNn3mzCCLf
 aFvPMV57StRe/P0yKtzEtBiyI9igPfZZi4CatuAD9CPPMfQbyLhKMA/j44RzHdz7Fdlp
 ZWNA==
X-Gm-Message-State: AOJu0YxlwIkmF++cEvOfc5ojZGnPz+8Sf3nZNiKU9sTFHhLz3SJxFWP9
 kIir4bZkBAgekg1oA98mWiuVpO4pw8HRyd4jJ+XUfa/mVMe7XoHZiMqNkOLYU10DxZV88NcJ26f
 I4r+fko7y2KQj5OGANwZxmpD//m844chvNFDgOG2fNbz/sRfFezL3XWog
X-Gm-Gg: AZuq6aIKOfJe5eiIbH4GEdYg26xTFXKDeEl3uwwB9gXxsOEHtzpxakwlqEl+pWvfIZm
 /eJB9xpjn5l6jtZTYSFS+IXsEk3WsYKnCbU8geTkr6SUEfoH/uAsGMoePCBUFKAhp6HxdrUdLrh
 QiqV/iKoebsE0lPK+O6B+3j3ANFPRka6CjZY9ALA2OMYp4NFDhKgGJUeSi+lvEV/bRLSXmAEYcn
 Qbccje7PrY/KW4SzLt7yuOax9iddKtUgDmmMhw94XT9mrkJFdR5YMA/98rESMwv8CTMfPvmNjj9
 2HOo/TQjX2tpzarsDVpPyncL6b+Fd3mq/bzvf+DmlRaRfOffVBg0HjXRawv7MjFVGPV78Cqxs62
 MxR2aYw==
X-Received: by 2002:a05:600c:314b:b0:482:eec4:772 with SMTP id
 5b1f17b1804b1-483710962c5mr285733935e9.32.1771504051384; 
 Thu, 19 Feb 2026 04:27:31 -0800 (PST)
X-Received: by 2002:a05:600c:314b:b0:482:eec4:772 with SMTP id
 5b1f17b1804b1-483710962c5mr285733525e9.32.1771504050979; 
 Thu, 19 Feb 2026 04:27:30 -0800 (PST)
Received: from imammedo ([213.175.46.86]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4839f978339sm16599765e9.15.2026.02.19.04.27.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 04:27:30 -0800 (PST)
Date: Thu, 19 Feb 2026 13:27:29 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, mst@redhat.com, anisinha@redhat.com,
 pbonzini@redhat.com, shannon.zhaosl@gmail.com, philmd@linaro.org,
 zhao1.liu@intel.com, rad@semihalf.com, leif.lindholm@oss.qualcomm.com
Subject: Re: [PATCH 00/11] Introduce ACPI watchdog for Q35 and arm/virt boards
Message-ID: <20260219132729.1eb521cb@imammedo>
In-Reply-To: <CAFEAcA-jtOBvOs2dJkrd2vwHFj54m2jPKK9fLSBLptAVNorhSA@mail.gmail.com>
References: <20260206131438.1857182-1-imammedo@redhat.com>
 <CAFEAcA-jtOBvOs2dJkrd2vwHFj54m2jPKK9fLSBLptAVNorhSA@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.045,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Wed, 18 Feb 2026 19:10:02 +0000
Peter Maydell <peter.maydell@linaro.org> wrote:

> On Fri, 6 Feb 2026 at 13:14, Igor Mammedov <imammedo@redhat.com> wrote:
> >
> > Windows doesn't ship built-in TCO watchdog driver, and users are
> > forced to install vendor specific driver(s) if such exists.
> > However OS provides a generic watchdog driver that uses
> > ACPI WDAT table [1] to abstract actual hardware behind it.
> > The same applies to ARM version of Windows.
> >
> > This series adds
> >  *  WDAT table tailored for TCO watchdog that Q35 already
> >     has as part of ICH9 chipset and a knob to enable it.
> >  *  SBSA GWDT to arm/vit machine with WDAT table tailored
> >     for it and necessary tweaks to GWDT to make usable
> >     with WDAT driver.  
> 
> > Also CCing SBSA folks to see if they are interested in adding it to their
> > reference machine  
> 
> The sbsa-ref machine already implements an sbsa-gwdt watchdog...

yep, but not exposed as WDAT one. Hence the question.
It also would need clock-frequency tweak if we are expose it via ACPI.

PS:
I don't even see DT mapping for it,
looks like sbsa-gwdt is just wired for the sake of compliance with the spec.
Well sbsa-ref specific firmware could just opencode it's mapping instead
of getting it from QEMU.


> 
> -- PMM
> 


