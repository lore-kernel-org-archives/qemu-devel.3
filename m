Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34774CA1013
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 18:24:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzJIc-0004zr-Tr; Thu, 18 Sep 2025 14:24:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uzJIW-0004z1-Px
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 14:24:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uzJIS-0005HQ-9j
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 14:23:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758219833;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lNsw5JLeKY9uVflrGldSh1MSaksI/KlXGOcdfAP4dVg=;
 b=hnbT1VcGsztXK6y7ZCPrCjbQJSP2uNBzV9BF8H5zT4RACv0Vhk9tRwXbqRf4hoS004fSFX
 wT+jF7zt4B49Q6a0LO/jg/cUlf9a6m4L7EH4xkJmvgB64wP5BYZCMdWIWn/xey9SXVQMfx
 V1PJ22OB+r6nayaBzDaQ88/X9ljiee8=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-417-ypKHmh_ON8qnWcB-oC1XWQ-1; Thu, 18 Sep 2025 14:23:52 -0400
X-MC-Unique: ypKHmh_ON8qnWcB-oC1XWQ-1
X-Mimecast-MFC-AGG-ID: ypKHmh_ON8qnWcB-oC1XWQ_1758219832
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-81ea2cb6f13so242321385a.0
 for <qemu-devel@nongnu.org>; Thu, 18 Sep 2025 11:23:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758219832; x=1758824632;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lNsw5JLeKY9uVflrGldSh1MSaksI/KlXGOcdfAP4dVg=;
 b=vYtBGAMPAnc3lUCL42Y7W5s0/khDdsD+9Md41Kh4MCN8KPeWYnIGDj7I7ZF9K5PQuy
 waqPQdNhvRGIQdvqwfzZM0NoRodONDlWPSadk6CB1Kpel3qo4Te3cOkY/BI68SHd++qB
 O0AtzusCqJDhJFd2Zem6ARyZ8s6jOJz/UPqxMYxH48z+8NG4yVRwOGILh7JsaQ4DlZNQ
 erKvHposRAukbMIJxqvPEpd5RPIrADt3g23A1G80TJkN5EcaCJUg5tIuLnU1ri4DJRO1
 1SdnC9EqUg7cAOs4BU4irJLJSlly+tK53u0BvNFlHBNtVS2klALCmVoGNHiULZa8izM6
 zhZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUKwWAPa+WHtnythZxI0PAPNonCdoRn+P8zOriN1m/XSmb5Y6jIbOuflOn4vJ5WuzpRbVoU/ufBl2q9@nongnu.org
X-Gm-Message-State: AOJu0Yz5EWpr+2afYkonhtttnCQczUodHmGdRbAR8bl/pbviIz+J4liW
 mHSm/ffZJ2rqs4rDTaxst3L4lkFY2+qvF/C4uT9prNwdcakFStbW0pRisWwOr6ZmbhIRTlyqJon
 5p5YZ5LPlGPmZtJZpbo581HU/hJl8/JOBCP/IYDHLc25VmtNXvks3CGBr
X-Gm-Gg: ASbGncvm1pe6hgHHlh8qDxxcQDxiDVbppJwTKZgVIriEi1sJAsTpGWe3uskgyfw4qlU
 zUnuGtHrih9h5ApVoJhJOcgOikT4lSvYkU5gmHTew7orzJ9ymItvanzwHtzEYx2wfjkDVozGQ9J
 A1acwHVObw8m912WvukP8cdKooeH3D4+wQFLuOvGm/+EenMLwEZrJ2ft/KPLrSiJmq/QCP8aPMY
 DBIMCNAvjyl1Oh08EXJXhmlRMLGVfWDe+dpYS6iEccYAveBZFpx0YLpz8hXlolaNtHi3xyiuIy+
 adcjoh7kTVMgsyCm6YLS/lDa9IV7YrMvWziC8Au8v1QF7iAJjgfs1qZW1DpmV2dhjYnmD/aO77P
 PYf6pW9ltncVQk95FVJQypg==
X-Received: by 2002:a05:620a:1a8c:b0:80d:a8d5:9857 with SMTP id
 af79cd13be357-83bab74d395mr64509085a.43.1758219831744; 
 Thu, 18 Sep 2025 11:23:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUpTtF0CBpm8iaj0vzODs7Wm2HXXsF9gB4ig///X5jqMVyDsGMScgSe8thOnLAxmi8d11Yfg==
X-Received: by 2002:a05:620a:1a8c:b0:80d:a8d5:9857 with SMTP id
 af79cd13be357-83bab74d395mr64504285a.43.1758219831243; 
 Thu, 18 Sep 2025 11:23:51 -0700 (PDT)
Received: from x1.local
 (bras-base-aurron9134w-grc-11-174-89-135-121.dsl.bell.ca. [174.89.135.121])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8363344e970sm204144985a.61.2025.09.18.11.23.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Sep 2025 11:23:50 -0700 (PDT)
Date: Thu, 18 Sep 2025 14:23:47 -0400
From: Peter Xu <peterx@redhat.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org,
 Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 David Hildenbrand <david@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-block@nongnu.org, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Yanan Wang <wangyanan55@huawei.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <arikalo@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
 =?utf-8?B?SGVydsOp?= Poussineau <hpoussin@reactos.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Bin Meng <bmeng.cn@gmail.com>, Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 xen-devel@lists.xenproject.org
Subject: Re: [PATCH v3 0/7] Do not unparent in instance_finalize()
Message-ID: <aMxOM-XCamf2y8ke@x1.local>
References: <20250917-use-v3-0-72c2a6887c6c@rsg.ci.i.u-tokyo.ac.jp>
 <aMwRSpezxmIwIHrU@x1.local>
 <f536fc18-73ab-676c-bdec-59e94a3e5408@eik.bme.hu>
 <aMwxYY9E3QghD10K@x1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aMwxYY9E3QghD10K@x1.local>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.005,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, Sep 18, 2025 at 12:20:49PM -0400, Peter Xu wrote:
> On Thu, Sep 18, 2025 at 05:29:34PM +0200, BALATON Zoltan wrote:
> > On Thu, 18 Sep 2025, Peter Xu wrote:
> > > On Wed, Sep 17, 2025 at 07:13:25PM +0900, Akihiko Odaki wrote:
> > > > Based-on: <cover.1751493467.git.balaton@eik.bme.hu>
> > > > ("[PATCH v2 00/14] hw/pci-host/raven clean ups")
> > > 
> > > Could I ask why this is a dependency?
> > 
> > It removes an address_space usage from raven so this series does not have to
> > change that and I don't have to rebase that series. Otherwise these are not
> > related. I'll check the problem reported about my series and send an updated
> > one.
> 
> This series should be a split of a previous mixed up series that may
> contain address space changes while this one doesn't.  It also doesn't
> touch raven.c and ppc/.
> 
> Can I then understand it as the dependency is simply not needed?

I meant, it seems we don't need to wait for the other series to merge this
one, hence the there is no real dependency.

I didn't mean to drop that series for sure.. if it was confusing before..

Thanks,

-- 
Peter Xu


