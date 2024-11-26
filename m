Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33316D3B9A4
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 15:44:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFxjV-0001NA-2t; Tue, 26 Nov 2024 10:44:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tFxjS-0001Mr-OE
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 10:44:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tFxjQ-0002gT-T6
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 10:44:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732635843;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cov+HJJf9XDcnLy2Qwwjh5PMJARo3z35Y9SJbkWQ+oA=;
 b=G4S116Q7gSsSFOoSwRYBGYJ99nWJ80kUCZNYJiYyUnEB5EnJKoOF08yrNVEoEYWZy7rLBk
 nmI+0EmHj3rWdHLPk/zn28dmlSNUnjoNVGV+C8xGY34uIrYygUh1zF6fXFXo9O6/UnmEKf
 DJFvDy4xDMBAmFbvrCQPchURCDtN+WA=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-Jetvk6eMPUmVFhz4rLauzA-1; Tue, 26 Nov 2024 10:43:59 -0500
X-MC-Unique: Jetvk6eMPUmVFhz4rLauzA-1
X-Mimecast-MFC-AGG-ID: Jetvk6eMPUmVFhz4rLauzA
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6d42001c9baso124437876d6.1
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2024 07:43:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732635839; x=1733240639;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cov+HJJf9XDcnLy2Qwwjh5PMJARo3z35Y9SJbkWQ+oA=;
 b=kq58MSBZl/afEVudd2y4c1biYKU7Ehi5+JErw++/O/b/VlPfuUqEkuNtkthuwaDyOx
 AIRQkfzkGO65BDwVykAEsz3ekwA5AJ1FaU1FgIUWZRRmVpseuynDNxsniktTqd4gRHsW
 Bf+HUNWdjdEDrnNXjbY5QJs+CNbfPgja9FbO1B5Bg0YXPdTFBqqKuzrv4cGkmvPPQyNy
 QebvBvyvyq1/wzRv/nSbvV8PIVjMVuWRUPSMBUj4EWM/9ZByYOQQk1LV5G7/TNt1cvBr
 alVcFYqKgmgeNkxzbu9NTtKSk9QMx3d87RvgukZqH9mEKjYtdzOSZlv0kxxQ60vMfqsr
 M2DA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBLPrttx3JV+MXtO87G9xyIAQB4LyV/cgT8pZW75iMNv9uwum08SRHV+dEqUl6H8bvBFtbrTLBQWJv@nongnu.org
X-Gm-Message-State: AOJu0YyC9ltxrUxL5Yv7Yi6gwKmp0pOSLuT9rk/DkX4E96aZnD6JEzz/
 bLXgGCVFpYA0ckMsmgyn7AxpSf4gZYOa7aabmuBTER737Xds4qiwVmK06D6P3srERnUBoIbd4CT
 wKCSQLbrws8Jx8eMrPknEK3elOfikbHpH0Zl3IlkIjQb25U7je5Z5
X-Gm-Gg: ASbGncsCJJ53SfXELyI2vFc/Is6OT7dO1T1qYBD11uYKPoq/7koufwXFcCQSb6Kjydg
 7nEMSqRLQnlXEk72M9KlUMCxSzM3XB5Cg86OJxzVjuet6DGNEKUaLEg/117nYSogY22CnrZymcw
 s2nxIYreG4fHtXr/K5NFmJgrYlL0RkeNVsiBS4J2ncvXvQZJKecqRvDvpqCuS4lyU3nPNaAkfkJ
 BG5jLYynrjK6/SdnV5K6kgkghY8wWIl5z35zfJhmyC+/Hibgrjw4WYlgtP+SuxWVZ+kj/I0sKmA
 RSoAJ8RQfzg=
X-Received: by 2002:ad4:5bca:0:b0:6d4:1fc8:8e70 with SMTP id
 6a1803df08f44-6d856be675fmr60433266d6.10.1732635839166; 
 Tue, 26 Nov 2024 07:43:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHZ52U4ZxBllhdrqF/kcbmXytGVO38GFg4anVqX+spapj/IEyHg7kbkhTM55lq5BeLqwaG1Tg==
X-Received: by 2002:ad4:5bca:0:b0:6d4:1fc8:8e70 with SMTP id
 6a1803df08f44-6d856be675fmr60433016d6.10.1732635838852; 
 Tue, 26 Nov 2024 07:43:58 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d451a839e0sm56693446d6.8.2024.11.26.07.43.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Nov 2024 07:43:58 -0800 (PST)
Date: Tue, 26 Nov 2024 10:43:55 -0500
From: Peter Xu <peterx@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 Chalapathi V <chalapathi.v@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>
Subject: Re: [PATCH 4/4] ppc/pnv: Add xscom- prefix to pervasive-control
 region name
Message-ID: <Z0Xsu_G8JnF6kaOm@x1n>
References: <20241125132042.325734-1-npiggin@gmail.com>
 <20241125132042.325734-5-npiggin@gmail.com>
 <03d94b2b-4653-4401-a33d-8581ec022ced@linaro.org>
 <D5VT2APZ0C4M.2BNQ7AT62V693@gmail.com>
 <5c99da97-ddd1-4cc4-88c8-f11732be64b3@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5c99da97-ddd1-4cc4-88c8-f11732be64b3@linaro.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.931,
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

On Tue, Nov 26, 2024 at 06:19:52AM +0100, Philippe Mathieu-Daudé wrote:
> On 26/11/24 04:54, Nicholas Piggin wrote:
> > On Tue Nov 26, 2024 at 5:28 AM AEST, Philippe Mathieu-Daudé wrote:
> > > Hi,
> > > 
> > > On 25/11/24 14:20, Nicholas Piggin wrote:
> > > > By convention, xscom regions get a xscom- prefix.
> > > > 
> > > > Fixes: 1adf24708bf7 ("hw/ppc: Add pnv nest pervasive common chiplet model")
> > > > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > > > ---
> > > >    hw/ppc/pnv_nest_pervasive.c | 2 +-
> > > >    1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/hw/ppc/pnv_nest_pervasive.c b/hw/ppc/pnv_nest_pervasive.c
> > > > index 77476753a4..780fa69dde 100644
> > > > --- a/hw/ppc/pnv_nest_pervasive.c
> > > > +++ b/hw/ppc/pnv_nest_pervasive.c
> > > > @@ -177,7 +177,7 @@ static void pnv_nest_pervasive_realize(DeviceState *dev, Error **errp)
> > > >        pnv_xscom_region_init(&nest_pervasive->xscom_ctrl_regs_mr,
> > > >                              OBJECT(nest_pervasive),
> > > >                              &pnv_nest_pervasive_control_xscom_ops,
> > > > -                          nest_pervasive, "pervasive-control",
> > > > +                          nest_pervasive, "xscom-pervasive-control",
> > > 
> > > Could this break migration stream? Or only RAM regions need to
> > > have a stable name? I don't remember, but try be be cautions with
> > > such cosmetic change just before the release ;)
> > 
> > Hey Phil,
> > 
> > Thanks for always somehow being across everything :)
> 
> ;)
> 
> Answering myself, I/O regions are migrated within the device state,
> per field, via DeviceClass::vmsd structure.

IIUC by default we don't migrate IO regions at all, unless we register
something into the VMSD explicitly.

> 
> IIRC RAM regions are the ones tied to their name, which is built
> using the object owner, which is why we can't change migrated RAM
> MR owners.

True.

Thanks,

-- 
Peter Xu


