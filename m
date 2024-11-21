Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19A1AD78793
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 16:49:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEAMW-0000i3-6B; Thu, 21 Nov 2024 11:49:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tEAML-0000UZ-D8
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 11:48:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tEAMI-0006ca-PU
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 11:48:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732207725;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EmAGqbJ8J21Mv6LX0LV83l9hiBNpbgS8yyPan3PGV6U=;
 b=LSAirr0FHRcYbEloTgJHWMxmOug6pcb/C2NQTl8W/rCs489yDs4puuKccUXkLPGMQBxZkm
 zLSbRL54KOcp92h6/JxzG7NLOr2Zfvx5xBZwVCKjQ+Rp0R1u3Cm0to9YicY0uKG+3mhVX2
 3St8NS3iP+epVAcpw+t8eWsqaFl1MSg=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-UAEP7UK6PjKsV8DONwM5qA-1; Thu, 21 Nov 2024 11:48:42 -0500
X-MC-Unique: UAEP7UK6PjKsV8DONwM5qA-1
X-Mimecast-MFC-AGG-ID: UAEP7UK6PjKsV8DONwM5qA
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-6ee7ccc0286so18208877b3.2
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2024 08:48:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732207721; x=1732812521;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EmAGqbJ8J21Mv6LX0LV83l9hiBNpbgS8yyPan3PGV6U=;
 b=KycJgObCukQPsyUIbhxwZWT8OyQbrqpskbGENI8bIq3qBBYpG33pOr008MwlBtLjF1
 5AxrQ8l118x50dwRWJC8TGltM2jSbJl02r1VA7bBaBJJK9pMnIE74B3lzkx5f548OdXl
 jqvFCuPD7nw9hfVhLulNbYeBG0fVLGBRa3akMUA91pTb7irXCw01OEWExMJ98w7Swzb6
 hkUUwRkE6B08S9qna+SzRlpwL2NdpAnm/tyUBcIJ0QzNCWMLk+Hq/6AYR6TasNQd2ulo
 pGluUMgutddyjO1chOXOe8LjJKtlSqxL+/fP9JAgrrpCxkYCobHDhQ1uVyDn9b+0T0Lt
 VXdQ==
X-Gm-Message-State: AOJu0YxSqot/6ty/wSR/Y0TJIrZWaU7JrLi6n1T8ytOwvUskD/qXsf7U
 Mz2b7c5DTEhPf5vFlGzQdXBb2pKDNBiTr2XeZ4eo3dEI2xvkxFvMQa2Agjx27ZUHlojokJdfDWO
 mGicoYw0Q6WIDoI53N0jZo11IxvyKXq2DIjOAmMAKxO0OQ8jY7qzz
X-Gm-Gg: ASbGncvDOK5LGAbvV1+9HFaMLS0bH13rLUrCTRoxLgmTUe/wyGoxiC9UQrssYibca47
 cx8poH4vpB9E3JjzOwHRPTjHzHzei61JAhCBuJiseE88vhbPiqgP9XY1L2ukZ0oM+uBEqiK+EH8
 sdqS4ESkFtXzksixaPZHmZvUIKh0ORqTXYL29TNbKBE+JEPZaiKYUJRHKog5HynVpH7ebSiDXOB
 TKNmxZrC58QIBgYNZT76xYWZwgmszbquq066svQt6hhCc9v9HtK/ZdxujkPxPXVmok8Duu74Kav
 2nHRX9VHlJw=
X-Received: by 2002:a05:690c:620e:b0:6eb:344:9fa5 with SMTP id
 00721157ae682-6eebd0f78e9mr85633697b3.15.1732207721687; 
 Thu, 21 Nov 2024 08:48:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEuweCByBHJ2sG3RDLpmFoOp5qHdjXKdt5qL/qul5Shb6nB7r75cBJJE3x14zssOtHnlOqiMg==
X-Received: by 2002:a05:690c:620e:b0:6eb:344:9fa5 with SMTP id
 00721157ae682-6eebd0f78e9mr85633517b3.15.1732207721417; 
 Thu, 21 Nov 2024 08:48:41 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4653c415171sm552661cf.53.2024.11.21.08.48.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Nov 2024 08:48:41 -0800 (PST)
Date: Thu, 21 Nov 2024 11:48:38 -0500
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Juraj Marcin <jmarcin@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH 08/12] qdev: Make qdev_get_machine() not use
 container_get()
Message-ID: <Zz9kZnGrNgD64FIz@x1n>
References: <20241120215703.3918445-1-peterx@redhat.com>
 <20241120215703.3918445-9-peterx@redhat.com>
 <Zz8JvAxXHqa3wfHv@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zz8JvAxXHqa3wfHv@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.14,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On Thu, Nov 21, 2024 at 10:21:48AM +0000, Daniel P. Berrangé wrote:
> On Wed, Nov 20, 2024 at 04:56:59PM -0500, Peter Xu wrote:
> > Currently, qdev_get_machine() has a slight misuse on container_get(), as
> > the helper says "get a container" but in reality the goal is to get the
> > machine object.  It is still a "container" but not strictly.
> > 
> > Note that it _may_ get a container (at "/machine") in our current unit test
> > of test-qdev-global-props.c before all these changes, but it's probably
> > unexpected and worked by accident.
> > 
> > Switch to an explicit object_resolve_path_component(), with a side benefit
> > that qdev_get_machine() can happen a lot, and we don't need to split the
> > string ("/machine") every time.  This also paves way for making the helper
> > container_get() never try to return a non-container at all.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  hw/core/qdev.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> > 
> > diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> > index 5f13111b77..c869c47a27 100644
> > --- a/hw/core/qdev.c
> > +++ b/hw/core/qdev.c
> > @@ -817,7 +817,13 @@ Object *qdev_get_machine(void)
> >      static Object *dev;
> >  
> >      if (dev == NULL) {
> > -        dev = container_get(object_get_root(), "/machine");
> > +        /*
> > +         * NOTE: when the machine is not yet created, this helper will
> > +         * also keep the cached object untouched and return NULL.  The next
> > +         * invoke of the helper will try to look for the machine again.
> > +         * It'll only cache the pointer when it's found the first time.
> > +         */
> 
> This smells like a recipe for subtle bugs. I think I'd consider it a code
> flaw if something called qdev_get_machine() in a scenario where the machine
> does not yet exist.

Returning NULL to catch such bug isn't that bad either if it appears, IMHO.
It'll crash on the null reference instead.

I did this not only because I used to allow this return NULL (in my other
patchset to enable singleton for vIOMMUs, then whoever wants to do that for
singleton doesn't need yet another qdev patch..), but also I think qemu is
complex enough, so for such frequently used global helper it won't surprise
me that users will start to detect NULL soon anyway.

For example, I learned only recently that migration_is_active() can be
invoked before migration object is initialized.. and it needs to keep
working like that..

> 
> > +        dev = object_resolve_path_component(object_get_root(), "machine");
> >      }
> 
> IOW, I think we should assert that dev != NULL to ensure we immediately
> diagnose the flawed sequence of calls.

I'd confess indeed the current qemu can assert that.  OK, let me switch.

-- 
Peter Xu


