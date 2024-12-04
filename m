Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59110E7716D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 09:25:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIlcR-0003qg-3P; Wed, 04 Dec 2024 04:24:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tIlcM-0003qQ-Vf
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 04:24:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tIlcK-0001jW-1t
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 04:24:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733304258;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0rA3Q8pSqM1dSDp1IjUijqveaLItTi22vCFk780D7MI=;
 b=EuoFP7BmFw7dg1jT8/mUAbJ2CC6Mjmmxv/NNqS+m7qxjnmZgWhM6JIwkQchKfGyeRNsj6i
 3oz3x/Lfa6psOw0z+gh+xpfbyQ44G1kQ9VSEE85/e8BOXfEV4wmS+/k8PeJcRxh5zAxRyH
 Vo9K72dOgaDx9LG9931hBwGPsfPW074=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-101-jVfhPaorNOCrJ1A62OJrxg-1; Wed, 04 Dec 2024 04:24:17 -0500
X-MC-Unique: jVfhPaorNOCrJ1A62OJrxg-1
X-Mimecast-MFC-AGG-ID: jVfhPaorNOCrJ1A62OJrxg
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-53e1ef4d176so201570e87.2
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2024 01:24:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733304255; x=1733909055;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0rA3Q8pSqM1dSDp1IjUijqveaLItTi22vCFk780D7MI=;
 b=cW+Yz5diwJFfvG0ekQjtbabjaCH8hNX+hzzO18OQxOqjKJsW2W172Su4RCbcKpQeva
 UGZKqufBm7JTnE/qSi4W/Gtr3Nf/sSOja4NjjbfyERz19YAyXUKISGnVhemIGdJmvgHV
 mN4uKa5Cl6ncswzpD2swtn3unIenK41AhM9QCWwZqqThuNcdFxp+KAq5daRgSJCFcnVv
 tZo9Bw4MsIeb18cCjoGDBpnFeNdx4wb35NjfqeDW0yHnsNY7dOEDD8GZE2rB+eh/wP6T
 +RZzux6tWCtsiF1uJNajKIQQ1qoTeDZNlgmvY03Jn1LVpPyJayJEpL1mBmMAMTRCg/of
 8vBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6niyfw9mg0yO5PFlrjpdb7KuKIAGF9bpb6dd4MBOKMZ6/DQd+ZOSxaN6NledRxUuagytkKYdEj3Pa@nongnu.org
X-Gm-Message-State: AOJu0Yyu9YoLT4nhrMIgTzuf7Hs50HFVoBPW9pXJQu8J/K3CtsnNlUTT
 Ctu67Rx2ojWHCY2qZmkJm7tdO4lyvv4J0l3MJRonw5n/oyu3tvDlNXhyTJTVUL8/0aYsFY9GXLu
 9eqvFQVRi2zdrBemeQqYq/PDWkTdtef+YuRRe3F3sIAKTwE4XzXPk
X-Gm-Gg: ASbGnct98EtmxQDFQVJbPTvvIm3wx+cUVBXFxwxHvG9slR+6wUntSsbIm98VmMohTxQ
 nmij3qYLcdIHxE2v4RpdsJG8MIJq9o3YKyCMmGFHk3XM8v2Q99d1s7CI/QXtDa6zrT1rDjktPW5
 9NLpQDfZoEWpS5pxSOsooSo0KEAvpFlT9H0uvNz7L/zQwFhVyBO9tO16r1SoAjh5Nun+1AfYTj7
 7Xt6+Ibd4OgQYaYNYrQQHXDoKZobHXFdpUD4jUUFDic5YGDrevnt5SGbBQlc5Ln8Ol1heDIymQ7
 umYywqjCcDJZpYxtsJGDkg==
X-Received: by 2002:a05:6512:10c5:b0:53e:1c3d:d1ae with SMTP id
 2adb3069b0e04-53e1c3dd2c2mr1189001e87.29.1733304255440; 
 Wed, 04 Dec 2024 01:24:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEsbNZvNHIYi3juR1bGlOd7p4wtzrVDLahVmik9+1Qp9w7qDv8Yeu/UFp2p0lFOTQ8AFCDHtw==
X-Received: by 2002:a05:6512:10c5:b0:53e:1c3d:d1ae with SMTP id
 2adb3069b0e04-53e1c3dd2c2mr1188975e87.29.1733304255025; 
 Wed, 04 Dec 2024 01:24:15 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-u.redhat.com.
 [213.175.37.12]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434d526b312sm18181805e9.6.2024.12.04.01.24.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Dec 2024 01:24:14 -0800 (PST)
Date: Wed, 4 Dec 2024 10:24:13 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 linux-kernel@vger.kernel.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v4 13/15] acpi/ghes: move offset calculus to a separate
 function
Message-ID: <20241204102413.31c8d76d@imammedo.users.ipa.redhat.com>
In-Reply-To: <20241204095635.512a44d5@foz.lan>
References: <cover.1732266152.git.mchehab+huawei@kernel.org>
 <e5661a6383449675b28e15c8479ebca42c939368.1732266152.git.mchehab+huawei@kernel.org>
 <20241203125143.7171892a@imammedo.users.ipa.redhat.com>
 <20241203144730.47b8ca86@foz.lan>
 <20241204085440.4640a476@imammedo.users.ipa.redhat.com>
 <20241204095635.512a44d5@foz.lan>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On Wed, 4 Dec 2024 09:56:35 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Em Wed, 4 Dec 2024 08:54:40 +0100
> Igor Mammedov <imammedo@redhat.com> escreveu:
> 
> > On Tue, 3 Dec 2024 14:47:30 +0100
> > Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> >   
> > > Em Tue, 3 Dec 2024 12:51:43 +0100
> > > Igor Mammedov <imammedo@redhat.com> escreveu:
> > >     
> > > > On Fri, 22 Nov 2024 10:11:30 +0100
> > > > Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> > > >       
> > > > > Currently, CPER address location is calculated as an offset of
> > > > > the hardware_errors table. It is also badly named, as the
> > > > > offset actually used is the address where the CPER data starts,
> > > > > and not the beginning of the error source.
> > > > > 
> > > > > Move the logic which calculates such offset to a separate
> > > > > function, in preparation for a patch that will be changing the
> > > > > logic to calculate it from the HEST table.
> > > > > 
> > > > > While here, properly name the variable which stores the cper
> > > > > address.
> > > > > 
> > > > > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > > > > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > > > ---
> > > > >  hw/acpi/ghes.c | 41 ++++++++++++++++++++++++++++++++---------
> > > > >  1 file changed, 32 insertions(+), 9 deletions(-)
> > > > > 
> > > > > diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> > > > > index 87fd3feedd2a..d99697b20164 100644
> > > > > --- a/hw/acpi/ghes.c
> > > > > +++ b/hw/acpi/ghes.c
> > > > > @@ -364,10 +364,37 @@ void acpi_ghes_add_fw_cfg(AcpiGhesState *ags, FWCfgState *s,
> > > > >      ags->present = true;
> > > > >  }
> > > > >  
> > > > > +static void get_hw_error_offsets(uint64_t ghes_addr,
> > > > > +                                 uint64_t *cper_addr,
> > > > > +                                 uint64_t *read_ack_register_addr)
> > > > > +{        
> > > > 
> > > >       
> > > > > +    if (!ghes_addr) {
> > > > > +        return;
> > > > > +    }        
> > > > 
> > > > why do we need this check?      
> > > 
> > > It is a safeguard measure to avoid crashes and OOM access. If fw_cfg 
> > > callback doesn't fill it properly, this will be zero.    
> > 
> > shouldn't happen, but yeah it firmware job to write back addr
> > which might happen for whatever reason (a bug for example).
> >  
> 
> The main reason I added it is that, after the second series, it could 
> also happen if there's something wrong with the backward compat logic.
> 
> So, both here and after switching to HEST-based offsets, I opted
> to explicitly test.
> 
> > Perhaps push this up to the stack, so we don't have to deal
> > with scattered checks in ghes code.
> > 
> > kvm_arch_on_sigbus_vcpu() looks like a goo candidate for check
> > and warn_once if that ever happens.
> > It already calls acpi_ghes_present() which resolves GED device
> > and then later we duplicate this job in ghes_record_cper_errors()
> > 
> > so maybe rename acpi_ghes_present to something like AcpiGhesState* acpi_ghes_get_state()
> > and call it instead. And then move ghes_addr check/warn_once there.
> > This way the rest of ghes code won't have to deal handling practically
> > impossible error conditions that cause reader to wonder why it might happen.  
> 
> I'll look on it. Yet, if ok for you, I would prefer dealing with this
> once we have a bigger picture, e.g. once we merge those tree series:
> 
> 	- cleanup series (this one);
> 	- HEST offset (I'll be sending a new version today);
ok, lets revisit this point after this series.
Since at this point we should have a clean picture of how new code
works.

> 	- error_inject.
> 
> Thanks,
> Mauro
> 


