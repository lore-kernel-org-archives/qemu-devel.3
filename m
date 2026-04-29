Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC0AACCFA13
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 19:50:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIAub-0007c2-O6; Wed, 29 Apr 2026 15:49:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1wIAuW-0007am-N5
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 15:49:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1wIAuU-0006Lf-LV
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 15:49:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777492165;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YVKhM7NUmDiNQgg6MBYrOoH9RiPvCZIOlPO/u82mKTg=;
 b=ByK6e3v+f99jRVGB+t9xn/n7Ys8F2+Y/oBcSMSrOfzs92QNesqVogCqxDN6kvAwoZA2yDe
 hismIoMeP7XuktnFbKKEtFIgv1L0QvxkdLh/1qnfdKfEeIBxyaiWGVsvq/1VQesPHiZzFX
 XnC015Q3sHbAiSl1mn7QtxM6gzy6mEU=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-448-Q1ZgKbVDNiOEFO4n5DZ7QA-1; Wed, 29 Apr 2026 15:49:23 -0400
X-MC-Unique: Q1ZgKbVDNiOEFO4n5DZ7QA-1
X-Mimecast-MFC-AGG-ID: Q1ZgKbVDNiOEFO4n5DZ7QA_1777492163
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-b630b4d8d52so72826a12.3
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 12:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777492163; x=1778096963; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=YVKhM7NUmDiNQgg6MBYrOoH9RiPvCZIOlPO/u82mKTg=;
 b=VEVpg+AvR5/3ik82O5D7StKC3YBUA3TQ0TWXarDvUkqikzPFJeqFhrfkqJzlT92bDD
 qtC20ufUY9CEc98A/OOstAIy2Xez8ztXWqO33x6tcKoYp31yIQk5IDHxIbm6GbgqEHQ3
 qCMrg2hyovYRoLGfVvcGhHfZhFjkseQ9y0GqJuQ5a+7xF+OhQg9HvyQQVaedM9Vfn9p9
 DZPIzK6laPwstmKCt5MD+lGb+08GCHkuq1JpS7DVt0CI3/S/dyi12SyawCpxOex2RXLn
 7i1GmNTm1UxhjD4Q/cs9yZgsB4iwoPfHlGhPVBQ228P5pxuP2uy4pkrR8sjfBH0jSUfz
 YzuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777492163; x=1778096963;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YVKhM7NUmDiNQgg6MBYrOoH9RiPvCZIOlPO/u82mKTg=;
 b=h/KUTGM7rhZa6O8/Wlyyo0wSVIVxs1v+c9bv5Ml751CLnjEMhU4qeikpQDi7g9oP/w
 q0nhYx0AeyRmlBeqEc/wxG9P8g8tl0/43jo+1Xlrt0FE7KeZJwvU1ioMzQUmdR8DYqLy
 5TrM2NPufdlNGM2QdRM2JoJzZ+RN4Rcf/6GEXDA7Xzy5bms+HMQL0BmCs3TGRdxOAxp8
 bEWj/oZaFv2wBv0q26WM/xhTt9gB8pqlkI7sJjuY9lKWCPaHrspUGRhKbWOYh5sY7q1n
 r0IJ05Nq1rn+Fq5VlgzsHj4LaiPsp0kEPogaHX6CcHRjcDmyE/AorR3uU+sytZ/LbF7p
 5rnA==
X-Gm-Message-State: AOJu0YxwYOqv6OzOaIFhB9Ve9qc8G4ORzIGTlZzaiRh72GMqgTWkS3GE
 1O5fsyjWwwST1L1y41l9atQLWHYPd04BQqq6sxmEs/p7pzZoVd8I1g1/Z6d0sjRmotqTzVzM0+e
 E4mZhwNqpJZpbIZO2YZum1nJ5PcNr0NIyp4bFEceHq8gEHRoHpqlGbho9
X-Gm-Gg: AeBDieuYW/qn/8Ug4e4Gw/RNRBssxJCfsBiZ6M9zHlZFrMhPi3Jgbm3Sp01/gj5UE6M
 joW3ef2AQeoGzmCeFXaO57lH7zs8VJIduNxmlTImUZXYZMs1fDI3ZB0E4rvt01WQpS0Yp2Y8mWc
 /RW5a3Bci/epE0P5cSrwIHgkoBwJ6ikkySPtjTB4eDeF0XDcpHh4/w7k0E5RSrj1runzxQ3Xz3v
 oinHa3n1BL1nEHvKqiu8n0hmtjfNqqsSXgYZpT/jL2mtAELGcEuyOBHUhw1sykxH8iLAo7z/OKO
 x9DeBh5czA920psD3eidCTLt9ry2fei6naijHdayMKvJ5ZZycxusGpNF1QJE7VpyqcfQtEc5nVY
 qaz2RxCP05I6JHuPI1ZoN5dw=
X-Received: by 2002:a05:6a00:a90c:b0:82c:212a:906a with SMTP id
 d2e1a72fcca58-834fdc2ace0mr35978b3a.36.1777492162616; 
 Wed, 29 Apr 2026 12:49:22 -0700 (PDT)
X-Received: by 2002:a05:6a00:a90c:b0:82c:212a:906a with SMTP id
 d2e1a72fcca58-834fdc2ace0mr35946b3a.36.1777492162174; 
 Wed, 29 Apr 2026 12:49:22 -0700 (PDT)
Received: from fedora ([49.36.109.214]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-834ed80faf3sm2787062b3a.59.2026.04.29.12.49.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 12:49:21 -0700 (PDT)
Date: Thu, 30 Apr 2026 01:19:11 +0530
From: Arun Menon <armenon@redhat.com>
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: qemu-devel@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Igor Mammedov <imammedo@redhat.com>, marcandre.lureau@redhat.com,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: Re: [PATCH v5 06/10] hw/tpm: Add support for VM migration with TPM
 CRB chunking
Message-ID: <afJgt-8vQBCKzCbN@fedora>
References: <20260422103018.123608-1-armenon@redhat.com>
 <20260422103018.123608-7-armenon@redhat.com>
 <4474547c-0d94-4585-8970-83950d3c75c3@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4474547c-0d94-4585-8970-83950d3c75c3@linux.ibm.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi,

On Wed, Apr 29, 2026 at 11:36:39AM -0400, Stefan Berger wrote:
> 
> 
> On 4/22/26 6:30 AM, Arun Menon wrote:
> > From: Arun Menon <armenon@redhat.com>
> > 
> > - Add subsection in VMState for TPM CRB with the newly introduced
> >    command and response buffer GByteArrays, along with a needed callback,
> >    so that newer QEMU only sends the buffers if it is necessary.
> > - Implement a migration blocker to prevent migration of the VM if the
> >    user manually enables chunking capability, cap-chunk, but the machine
> >    type does not support it, using a new hw_compat property called
> >    allow_chunk_migration.
> > - Add a post_load_errp hook so that during a migration, the buffers are
> >    validated before destination VM is started.
> > 
> > Signed-off-by: Arun Menon <armenon@redhat.com>
> > ---
> >   hw/core/machine.c |  1 +
> >   hw/tpm/tpm_crb.c  | 71 +++++++++++++++++++++++++++++++++++++++++++++++
> >   2 files changed, 72 insertions(+)
> > 
> > @@ -422,6 +478,7 @@ static void tpm_crb_reset(void *dev)
> >   static void tpm_crb_realize(DeviceState *dev, Error **errp)
> >   {
> >       CRBState *s = CRB(dev);
> > +    int ret;
> >       if (!tpm_find()) {
> >           error_setg(errp, "at most one TPM device is permitted");
> > @@ -431,6 +488,15 @@ static void tpm_crb_realize(DeviceState *dev, Error **errp)
> >           error_setg(errp, "'tpmdev' property is required");
> >           return;
> >       }
> > +    if (s->cap_chunk && !s->allow_chunk_migration) {
> > +        error_setg(&s->migration_blocker,
> > +                   "The tpm-crb device does not support chunk migration with "
> > +                   "machine version less than 11.1");
> > +        ret = migrate_add_blocker_normal(&s->migration_blocker, errp);
> > +        if (ret < 0) {
> > +            return;
> 
> Should this do an error_report() and exit(1)?

The tpm_crb_realize() function has always propagated errors in errp
back to the caller and returned in case of an error.
To be honest I followed the suit. A quick glance at the codebase shows
that the realize function in other devices also avoid calling exit().



Regards,
Arun Menon
> 
> 


