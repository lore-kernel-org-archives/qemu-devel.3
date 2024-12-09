Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB9DEE7717D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2024 13:22:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKdhr-0003aq-0J; Mon, 09 Dec 2024 08:21:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tKdhg-0003Zu-EO
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 08:21:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tKdhe-0005Ne-0P
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 08:21:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733750490;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jrC64vfuasWzI50Ac1WvO0UeovJ22x37jEt9PiFRSDo=;
 b=iAEHN88DuCkvPfrld3fJ7dOQGz6lHfc3ejbPyXEfvch/1TnL0e7ChXeaG1HGPXRJtKNwYd
 4FGrAxXAznBkg4vQvD2KvWDDmD4G05oFqu0v+c5GrKFJo3BMQvl7WFcd7Q+pKwC8Q1dCiv
 GbGpShjCA6Nssy1U/rWsi8RPwa+UWrc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-_uBwd1iiNqeuNjwRwOWG4g-1; Mon, 09 Dec 2024 08:21:29 -0500
X-MC-Unique: _uBwd1iiNqeuNjwRwOWG4g-1
X-Mimecast-MFC-AGG-ID: _uBwd1iiNqeuNjwRwOWG4g
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3862c67763dso1841627f8f.3
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2024 05:21:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733750488; x=1734355288;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jrC64vfuasWzI50Ac1WvO0UeovJ22x37jEt9PiFRSDo=;
 b=Yk/1J2GkE/DiOZ2skZNAQBTKMjt7qAZTZT/wjWuF3x0qWXxR6o+I1jwyh2uSHBYOUQ
 yEtfLwtk5x0D1cuk8tMqKocnJbX1Qt0etjPOXIAVF4+Q1ArktLxQmLA7jjUI8EtWgXOs
 KvabfiysZI8ZtSJkdqM9vUBkND265IZ3Axc4BNay4GdQPk/mMg/ew20K7rdM/GSBVfff
 es8dpDsVrkUSjPV73v7AWYjQZWje2TjN45UfUJAs4tymIowYVk/C/0uoYwBXz7MfilU2
 C8MP/aIf0rf4g2opo16vOPjDjTre3/PcbT/ZZ7NZw4j2hzlzQl+4GK1WC6ATAKGdKobh
 hyXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/FQlJnTamF/WmyUjcgg7TqbDsce8cPCU6zBgOYuQwh+5y28nz5OJaRBGOQIwHY/9CWztNS5n9Fe15@nongnu.org
X-Gm-Message-State: AOJu0YzU2BWkvyIE7O9WHo/LMVa8qQbdydw17Px6KPpr2r9sXsQskRif
 IjZEo5zVj+d1QhSRu+cENkTY1CAnvPI+ptRPeh7n3a7tn15FzWn0sQ2GMQ8ubDhUQvcJKTMaqly
 wPPOU4H+Uk0cAJKNdGRazHocjYuzIfXfn9n5d0LsI76qvjMH1Q3o0
X-Gm-Gg: ASbGnctEeusz8EW7tRMfn2F978G9dTTBsLWaYKo6zpUmjYrOfYU0+VWruZkGfMNQFLQ
 vRBbkUzJza/wU4y5QbZycU1O1ZXS7a46jCtcxNS/jTSxxheDiBHvZvkrNFinlCGbRqZTRD4BkGo
 wuABZXnJqwbi9w9plAR509gfZ6aMab6fQr8Z6ikQ9FyRX9vVELUXXEiYeqnffVtRfhUM/eoxRhK
 7kKuRvY81tv3v0NmHwkh1asgOHYMGK/Pkehc04+I8dHIBs8Sn4PWTt0xbli6zROBHdGB0IjqPbp
 2xBRu+qPtUJzeKSv5hX8cw==
X-Received: by 2002:a05:6000:78d:b0:386:1cd3:89fa with SMTP id
 ffacd0b85a97d-3862b37da8emr10855307f8f.33.1733750488205; 
 Mon, 09 Dec 2024 05:21:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFpPQnRIZu16wT5CDEHDmRuSGupx1hhP8ovzt9nmMxrBf32a0xvYsQS0Wr8vg8lU37w1zZ4rQ==
X-Received: by 2002:a05:6000:78d:b0:386:1cd3:89fa with SMTP id
 ffacd0b85a97d-3862b37da8emr10855275f8f.33.1733750487886; 
 Mon, 09 Dec 2024 05:21:27 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38621909644sm13377648f8f.76.2024.12.09.05.21.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Dec 2024 05:21:27 -0800 (PST)
Date: Mon, 9 Dec 2024 14:21:25 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, "Michael S . Tsirkin"
 <mst@redhat.com>, Shiju Jose <shiju.jose@huawei.com>, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 <linux-kernel@vger.kernel.org>, <qemu-arm@nongnu.org>,
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH v6 08/16] acpi/ghes: don't check if physical_address is
 not zero
Message-ID: <20241209142125.74aa8be4@imammedo.users.ipa.redhat.com>
In-Reply-To: <20241209113640.000055ab@huawei.com>
References: <cover.1733561462.git.mchehab+huawei@kernel.org>
 <95c0fa3fc2969daf3b6bc1f007733f11b715a465.1733561462.git.mchehab+huawei@kernel.org>
 <20241209113640.000055ab@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.489,
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

On Mon, 9 Dec 2024 11:36:40 +0000
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> On Sat,  7 Dec 2024 09:54:14 +0100
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> 
> > The 'physical_address' value is a faulty page. As such, 0 is
> > as valid as any other value.  
> Still not sure on what faulty pages are :)

s/page/address/ probably would make it a bit more clear

> 
> Given I tagged previous (after you'd sent this)
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> > 
> > Suggested-by: Igor Mammedov <imammedo@redhat.com>
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > ---
> >  hw/acpi/ghes.c | 4 ----
> >  1 file changed, 4 deletions(-)
> > 
> > diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> > index edc74c38bf8a..a3dffd78b012 100644
> > --- a/hw/acpi/ghes.c
> > +++ b/hw/acpi/ghes.c
> > @@ -400,10 +400,6 @@ int acpi_ghes_record_errors(uint16_t source_id, uint64_t physical_address)
> >  
> >      start_addr = le64_to_cpu(ags->ghes_addr_le);
> >  
> > -    if (!physical_address) {
> > -        return -1;
> > -    }
> > -
> >      start_addr += source_id * sizeof(uint64_t);
> >  
> >      cpu_physical_memory_read(start_addr, &error_block_addr,  
> 


