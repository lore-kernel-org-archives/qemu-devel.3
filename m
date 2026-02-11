Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5896EE9E315
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 14:36:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqBJv-0007L3-Nq; Wed, 11 Feb 2026 09:35:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vqBJt-0007Kr-E8
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 09:35:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vqBJr-0003TE-CW
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 09:35:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770820554;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zoxr2hs8OTfjAGGmQS29imVD6YshtNuLYoyQZrJ/4bU=;
 b=cm2KatRKXIhFAc3NV3vbiqQ4I1Wz9P3p5WiZQzNnVNdeED95meKaW+HPA4qM3VLNqdpnuQ
 Eb9SapwcVo5PYKApi+HsOHmoSiegAMVZ6HRyVZ4YPwjXjgkykZ7K9qUJZc0i27YAzdkQu6
 VNBNW/kwMNO/ZqPR6iKt6mAkmsaf248=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-673-jZARNsnUMQafQesIveI_og-1; Wed, 11 Feb 2026 09:35:53 -0500
X-MC-Unique: jZARNsnUMQafQesIveI_og-1
X-Mimecast-MFC-AGG-ID: jZARNsnUMQafQesIveI_og_1770820549
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-896f2e45fb0so31241536d6.0
 for <qemu-devel@nongnu.org>; Wed, 11 Feb 2026 06:35:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770820549; x=1771425349; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=zoxr2hs8OTfjAGGmQS29imVD6YshtNuLYoyQZrJ/4bU=;
 b=JxkmO3kvbUreU2Wb2DfAE1wkCNhNVnWmZsXnmMM+6hgLsSJuCLU99Br8QPqKIs1zFI
 8SQlnfEeGB6yOIWkc5UZtefuGSwszQq5zvkSAB+VmOnMyUvY1bdVyP2eynfdIJ/F2BQR
 itMQPlMq42LiCmTQSE+kL5D1XhE7jPQMjKwffcyZ7OsPDGBAXZ1nCtIHiPp0E6KyO7Wv
 6rCEq/XbLSp19c/WKrf5r2Xuhi0ZU6mXUuEWieA4//3ygxS2MHWBht6G43be2Cbk7jEl
 oQccz4V8JGMy7/2odkVD7fxP61RCE0w8gYSNVII93LnoxOSDkAfoFDmjLIGsgbTClZOk
 NxKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770820549; x=1771425349;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zoxr2hs8OTfjAGGmQS29imVD6YshtNuLYoyQZrJ/4bU=;
 b=jAx+L5v1tmE0x6QIRq1T0or/WJriLSL2Rfbxrvnp3JyC/zJAUDqOhT+DBfMyRjxMqh
 GY0xDSGIa0vmbpBaQe2VUeVvwUDRzNh97HKAa/USOvutyYmVpCNX8XsDzVdz5G4M7b6A
 U9moSleUXIusJ2ChJdD+PsCjKTbSYSTXtv6gU4IXo7hBOcXvGuQJjGjpHatc1v4Zjfpx
 7E+p4sYwvfr7+L22tjhlCwuxgIz5MYOUDxnQt6BTj2ah/lhh5NNpX5TvbmEAzbMC9dMF
 +Ec2bzCrVvilcS7H5sc8LAytS1ElcNb5DlXNRINPXxcssZKVHcW5LuwQPo04iE5AyXmz
 WcjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUFU9IcigDKP/5Dxm+4JDhFlUpQjIwdAgtW3IQ0LOG+EHHFuSPKu0HlWNl8s/jn7fL2t0Q2/SdTCZW5@nongnu.org
X-Gm-Message-State: AOJu0Yy2kw6tFxv/gmsl1N+TLBvJ1qVHxV14wO9ch7ldWa9cILTIdWPm
 9sCpkTvVpNmBYJ7T6lV7GSrLp7d1F26vPzaLmLnWvYz/rGE+uR9CcSvZ1yxO7GJKDL3qrh4B0vf
 JgCgiFRmrWXC843upYfUFynae5s/VenZaqhp4hDGhNEJNIqdtu/nzj+c4
X-Gm-Gg: AZuq6aKJ8PL+lujjRA4t5VK3gi4TmDBVx/C6BCY86zeeQEEK/GSBGrqW6l73Yz5CDaf
 36qDqyLDKeZh0BVuh7laGRCIEZmOPUg7yuoiC/lo/pKgmy822OpyXSJ/oI0RO0I6BjUmdU6pTDD
 GEmt97xuJS97a5WCDTeQm/OOr0tMaEznvkQv3EFnTAeDTr23FnCovA+FgxZsfoUTvsvHA/43If0
 UEnjrtwHQOnWBy0FnnAGrsb1j4xuUzz6TNQh1qKhc8oWR5BC7W3GWEArW4u+9/O319iFWPZnu9h
 R1JFdBvBfXH+M3/XtX/EVC+nYQUvDLhskStE+hGdtHdEFJzp1B50/tenI/MEfvUbgl94Z1rxn8A
 5TLxH5Ye4LQiXEg==
X-Received: by 2002:a05:6214:c29:b0:896:f848:2c2 with SMTP id
 6a1803df08f44-8970d7f2ab0mr91790436d6.4.1770820548797; 
 Wed, 11 Feb 2026 06:35:48 -0800 (PST)
X-Received: by 2002:a05:6214:c29:b0:896:f848:2c2 with SMTP id
 6a1803df08f44-8970d7f2ab0mr91786066d6.4.1770820547054; 
 Wed, 11 Feb 2026 06:35:47 -0800 (PST)
Received: from x1.local ([174.91.117.149]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8971cdd1541sm15567936d6.49.2026.02.11.06.35.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Feb 2026 06:35:46 -0800 (PST)
Date: Wed, 11 Feb 2026 09:35:35 -0500
From: Peter Xu <peterx@redhat.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Gerd Hoffmann <kraxel@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v3 0/6] Implement memory_region_new_* functions
Message-ID: <aYyTtz1B2Qz3aQWA@x1.local>
References: <cover.1770753117.git.balaton@eik.bme.hu>
 <CABgObfYpW0YMofv4O8gf4p-aWVxfvQ+BCMPsm2w+5MtD8-9s0Q@mail.gmail.com>
 <42233b06-f058-152d-645e-e16528a1640d@eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <42233b06-f058-152d-645e-e16528a1640d@eik.bme.hu>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Wed, Feb 11, 2026 at 12:47:53PM +0100, BALATON Zoltan wrote:
> On Wed, 11 Feb 2026, Paolo Bonzini wrote:
> > Il mar 10 feb 2026, 21:02 BALATON Zoltan <balaton@eik.bme.hu> ha scritto:
> > 
> > > Our documentation says that memory regions are automatically freed
> > > when the owner dies and the reference counting to do this is also
> > > implemented. However this relies on the QOM free funtion that can only
> > > be set by creating objects with object_new but memory API only
> > > provides constructors that call object_initialize which clears the
> > > free function that prevents QOM to manage the memory region lifetime.
> > > Implement corresponding memory_region_new_* functions that do the same
> > > as the memory_region_init_* functions but create the memory region
> > > with object_new so the lifetime can be automatically managed by QOM as
> > > documented. The memory_region_init functions are kept because they are
> > > useful for memory regions embedded in other object or managed
> > > externally and not by QOM for some reason.
> > > 
> > 
> > I think there was pretty much agreement *not* to do this?
> 
> Who agreed on that? So far I got concerns that this was too big (that's why
> I split it from the clean ups to show it's not that big change, less than
> 200 lines plus the docs but the clean ups removed as many lines as the doc
> comments add) and others saying this should replace memory_region_init
> altogether (that's way too much churn and not needed IMO) but no clear
> explanation of why this was *not* needed. You as maintainer can say no but
> then please give a justification for why and some solution to the problems
> this tries to fix.

I didn't participate much on this discussion, because I don't think I know
well on this topic.. especially on the Rust implications, comparing to most
of others who should be more familiar with.

However, IMHO, what we really need here is a justification on "why this is
needed", instead of requesting maintainer to say "why it's not needed"..

The rational should be simple to me: by default, we change nothing.  We fix
bugs, but that justifies itself.  If we change something else, we need to
justify the change worthwhile (by the author of the proposal).  If we
change a lot of things, we need serious and strong justifications.

At least I didn't see any Rust mentioned in this cover letter explaining
why we need this change.  I also don't know if the "documentation" issue is
a major flaw to introduce these whole set of new APIs.  For example, could
we fix the doc instead if it is flawed?

Thanks,

-- 
Peter Xu


