Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 602E3C02192
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 15:23:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1teyHe-0001Xm-AH; Mon, 03 Feb 2025 10:22:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1teyHc-0001XX-D9
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 10:22:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1teyHa-0006zf-UC
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 10:22:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738596161;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IPyZM1t4JHDpUYVyrdVFxb2Um0jbsvrzJI4R8XaR9uA=;
 b=BT5Y9aKd5DWb2pC8XWGDqUqZcDCFkDqeyyNWbi2szaMBLAarQ7JfOHcl7Ae6KNgpkvewt+
 ixqmLO/73wibcK8JONloz+d3KEA/th3S9gDrrSu1ObaUQlBsgmIHSas4udb3xZRR7I1jRP
 Lme1R+peTPvPdQnYSYwMCQV8JBawZP4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-EAkSJ1kKNbKewWzzT0Tvsw-1; Mon, 03 Feb 2025 10:22:39 -0500
X-MC-Unique: EAkSJ1kKNbKewWzzT0Tvsw-1
X-Mimecast-MFC-AGG-ID: EAkSJ1kKNbKewWzzT0Tvsw
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3862a49fbdaso1763172f8f.1
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2025 07:22:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738596158; x=1739200958;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IPyZM1t4JHDpUYVyrdVFxb2Um0jbsvrzJI4R8XaR9uA=;
 b=gwx8UrJ/Wtc1FowFDSA+PE77DAQTi1R2dQm1GJBT2YKftpc2HUTTdUMkJaPky7Weoe
 ggRCmUW0CihegcxHI9MQAzmEGrIifr/dJnUKrtnMaKCazgvWoYass/92HCFH2k24HC0t
 hWkkd0G4dZ7ZXKTJkfRMFIjflQHCM2Xd1YnTsyUM2yrtdAh7tjYZmnmcFMJTZE8nu2w1
 gnhZdvvQgWEUcmIoeRVtBVUIu1J2WZNSaP/PjNx344NimdPkh2/51ycINllNMYcITmis
 iaHZunCfJJ+jq/Xz0M8HwLhi1UxAdCJ1guVfI8ptp1bY1FZrYCWZOoiXkbEECCXu5Ifm
 XNXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVnz5/vnG88bj15Fc+NbSpNFTu7WuHfuxi8Qafmcxyhj3oOjJoZEnC+f2jcNt7SoxzZ7eHelnr2rH39@nongnu.org
X-Gm-Message-State: AOJu0YxaxN/Ox5mK1/Vh/GPJqEhw8V1xoUVyqL/tbnh9PoqfR6IZ3e+R
 xm9x5u2V+kX+GButT9ymhhHoUnE4MuJTFEC0sH5E/Jaz6PD2U4SO67PxX61gRw8PM9+KMkpmTzy
 s4T4ICayv2FWfwjIfGYT+q+8shUdVVMKxXKB9RmfVkJr/7zahwaiu
X-Gm-Gg: ASbGncsJYR7e+TwHse/Stq9CAf3R/UgoSzcXWaI2+dVXOw30USFokTOaMV0IXdMVByp
 8BSi3GjUnK1gMFrlpv1jirOX9yfUTmApLRN2+PJlF6Pr3k80756cWd/glu2je7iTlohfWfK2VTz
 bLhCZTd2hhPAYIoklw6ZJPDpQbCwkIHILewks4+rjxOT89gGzgYNJW6/DD7nJ5Cwbrkv0+oHhbN
 i17Nu/sJDZQ9Wh4uKDFGhsvAbL0K8XKkA21tu3FWlPwTaZIipDTyu+27KIi+XjkoWF1dOwWuS0R
 vrLysNIWcWOKHPuPb0WfHnLx+wouD1RK1H+CM8ToBpwoFoRW17ex
X-Received: by 2002:a05:6000:4011:b0:385:e8b0:df13 with SMTP id
 ffacd0b85a97d-38c52095e20mr20768475f8f.40.1738596158367; 
 Mon, 03 Feb 2025 07:22:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFU8GdTGi8sB7oRmFhV909MaP4kFCPPAe8WiAnv6V5VuMzr3T7UiP99xHMB2JJSil2uW9p+BA==
X-Received: by 2002:a05:6000:4011:b0:385:e8b0:df13 with SMTP id
 ffacd0b85a97d-38c52095e20mr20768432f8f.40.1738596157876; 
 Mon, 03 Feb 2025 07:22:37 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438e23de772sm157161035e9.13.2025.02.03.07.22.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2025 07:22:37 -0800 (PST)
Date: Mon, 3 Feb 2025 16:22:36 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, "Michael S . Tsirkin"
 <mst@redhat.com>, Shiju Jose <shiju.jose@huawei.com>,
 <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, Philippe =?UTF-8?B?TWF0?=
 =?UTF-8?B?aGlldS1EYXVkw6k=?= <philmd@linaro.org>, Ani Sinha
 <anisinha@redhat.com>, Cleber Rosa <crosa@redhat.com>, Dongjiu Geng
 <gengdongjiu1@gmail.com>, Eduardo Habkost <eduardo@habkost.net>, Eric Blake
 <eblake@redhat.com>, John Snow <jsnow@redhat.com>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, "Markus Armbruster" <armbru@redhat.com>,
 Michael Roth <michael.roth@amd.com>, "Paolo Bonzini" <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Shannon Zhao
 <shannon.zhaosl@gmail.com>, Yanan Wang <wangyanan55@huawei.com>, Zhao Liu
 <zhao1.liu@intel.com>, <kvm@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 00/14] Change ghes to use HEST-based offsets and add
 support for error inject
Message-ID: <20250203162236.7d5872ff@imammedo.users.ipa.redhat.com>
In-Reply-To: <20250203110934.000038d8@huawei.com>
References: <cover.1738345063.git.mchehab+huawei@kernel.org>
 <20250203110934.000038d8@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, 3 Feb 2025 11:09:34 +0000
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> On Fri, 31 Jan 2025 18:42:41 +0100
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> 
> > Now that the ghes preparation patches were merged, let's add support
> > for error injection.
> > 
> > On this series, the first 6 patches chang to the math used to calculate offsets at HEST
> > table and hardware_error firmware file, together with its migration code. Migration tested
> > with both latest QEMU released kernel and upstream, on both directions.
> > 
> > The next patches add a new QAPI to allow injecting GHESv2 errors, and a script using such QAPI
> >    to inject ARM Processor Error records.
> > 
> > If I'm counting well, this is the 19th submission of my error inject patches.  
> 
> Looks good to me. All remaining trivial things are in the category
> of things to consider only if you are doing another spin.  The code
> ends up how I'd like it at the end of the series anyway, just
> a question of the precise path to that state!

if you look at series as a whole it's more or less fine (I guess you
and me got used to it)

however if you take it patch by patch (as if you've never seen it)
ordering is messed up (the same would apply to everyone after a while
when it's forgotten)

So I'd strongly suggest to restructure the series (especially 2-6/14).
re sum up my comments wrt ordering:

0  add testcase for HEST table with current HEST as expected blob
   (currently missing), so that we can be sure that we haven't messed
   existing tables during refactoring.
1. Introduce use_hest_addr (disabled) for now so we could place all
   legacy code to !use_hest_addr branch
2. then patches that do the part of switching to HEST addr lookup,
    * ged lookup (preferably at the place it should end up eventually)
    * legacy bios_linker/fwcfg fencing patches
    * on top of that new hest bios_linker/fwcfg ones
    * and then the rest 
    (everything that belongs to the 2nd error source should _not_ be a part of that)
3. add 2nd error source incl. necessary tests procedures introduce
   and update DSDT/HEST



> 
> Jonathan
> 


