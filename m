Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CD3CCA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 09:06:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xENVN-0008MW-Ku; Wed, 07 Oct 2026 05:00:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1xEKsa-0003Ep-21
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 02:12:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1xEKsI-0002AL-Bh
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 02:11:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791353482;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0KjBGitEkOT6/H3O0Jz3UU2krKy3QWVZjrAiPk8YehM=;
 b=SHA/jAVMdprBbnbRRfFwCXwkY5Nw+LLGR4C1KIewA6QLuAJEE8AWq+xYA3nSGqYrm7h8q3
 su3M1Cy5bL0NCCQaolIiJF/59koO4PcxWgfKuht+af+pmeTWYH7vLD1QZV/ojBw+pu3qxG
 deeGSqn59FDQncBkwIU7z1JBKUT396Y=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-292-Mkt63JpHODyMrMn17jr2ow-1; Wed, 07 Oct 2026 02:11:20 -0400
X-MC-Unique: Mkt63JpHODyMrMn17jr2ow-1
X-Mimecast-MFC-AGG-ID: Mkt63JpHODyMrMn17jr2ow_1791353479
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2df8d1e91c9so67012785ad.0
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2026 23:11:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791353479; cv=none;
 d=google.com; s=arc-20260327;
 b=frVjibAU6xly9ey4x3fxXJNBcTeEwRej2NC3BjvPByh84NVhJQqZD5zsDEKwWsh7SE
 1yLkKa1osdPxfljolTlFoLDqrHjcntuz5bToaHOwjWYzEhKQMs3Fc77XDQ5DbQfO7J4B
 cGyj59/cST7GHsNwVM7UJgS0m99/axVytrDjn6WCFbYayO9euAeMjj8djZdoNWjGHD1j
 lkXzHUk0q6HNz7+W3HpM/HXpxgQZlQiagcGE6RpfgqeXdcjMATt/3oPczITtLTUB3U8r
 fVzuHwV9I91Y3DMf+hgdLuWLTvvdNFalsmcYAYiHaBXPUM56UDD7dYFzJYRGBqrMQ0We
 GDYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=0KjBGitEkOT6/H3O0Jz3UU2krKy3QWVZjrAiPk8YehM=;
 fh=A8uD+msS3MKQfhfDeZBeS3RPqVja6wU9NXA3uZOXLCc=;
 b=bL/WNYrwHmFMIaMpEL+kg40RBo9b7/2zdwuk1VHTyWFWA1klWOYCRhzJ9JhPFVz83e
 Z4klk0lJxl20oQupWSLah00CGYdihZSyi6119qQXLH420yQtnjRfV9Pipy8hG+vMEozt
 urHQz9zyID4b06kVSYI8s4sr1opSqrf0V/IO0Vxzm5nvSNK/QgrRA8E9yguOZ54c0/pp
 wFobtkzT3X+ORlfOF0/ZFjCquxei93ECep55HFAN+eSc9e4KIpMnlWW6l3V3Ft8xYl63
 PvU8MvYtZ7i7zW2dE5+r/I6F9N92el7HkvTtsDTBmdS3UWRTgByopfDEDKmLy41gjt8g
 Xmzg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1791353479; x=1791958279; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=0KjBGitEkOT6/H3O0Jz3UU2krKy3QWVZjrAiPk8YehM=;
 b=DKtfaYYqqUvdTQT9/+X83WHc20EX4VSO/31Jp1PZycqjG4UBJPCUxzDpOwJtDHLxRO
 HcTEftn8JGK2TOpBiaRuM/ZxfAcVgHfhOvz0lOhTg3mZfAKuPzUh2ClWFvH+6HDwvHGL
 QDRse/1CD7jd6i1lw8glueEeuxEaxJzGvgABUm1OVspVqPeG42DCBykey77dzP5J6AQw
 PVjBZZoim5PYYfyPpguO35RS4kxfM0EUTSeKjMY+GVkJ2sn3NjGDX8PwgknqVkWNGmrU
 Q7IDU1L+agOFE4U6X9fIkhMDlOPmEMlVJApKO2b9ipjqFHhXLZI1QXyLm4GLuCUzLiRH
 trKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791353479; x=1791958279;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0KjBGitEkOT6/H3O0Jz3UU2krKy3QWVZjrAiPk8YehM=;
 b=Zveh5WFxZGm5lHVCXNnmyH1izp0yfEPFUw1UCK9JhM/4nxT875382i66QL5Jm//1VL
 1vI8egn7JTudVfUyoLkvLbsI6vT4MajPyw46Y5AC8fYMcmHaMMmN6XWv5zWEUqLPXdxj
 A+DGObhd0i86pmnvqGgky+q/BIzbCiUidBovbCX4hwW4EFbgFGDgTO27KcWfFs0ykmya
 Rpi4hZRqH4Ms2rIylIfzMW4r+ACwehqQ74HWYbkMK4lR5u5u+ZpjOeqWd5cLiCb+ZdCN
 DU2lEbTmiaXOp/6Int9OUelfZor8s9fdocc1FOtXHuG5N8vaOSOBsL82ISfG1MFLcXU6
 sbxg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzUo0nzpN5C/3VanW1YktGlgjXi3e7VWFinkkQAMRA9cbM+NdKwwacuL1G0rGfa0v1VnFGAfviqm0jh@nongnu.org
X-Gm-Message-State: AFq9FYIQdb5KseQZQfQsgQaCSQjPol1Xzq22mYlLVYbisSy04/Mrdb7r
 PJcEyYAeZp25THrXnWVsePAayAWgK4Rc5/hUxk40jPNINaLgbiRSvGIk4F7kZnBJwRjk/MTyUG8
 3PIlDl/cpGqo9yk9c4Rx4DFK21gJT8H0hAA1FxrqYDG2O6AAF+IoN8dTfB/Bn3sP7SZhfIi64L2
 7Tyv/QOAM5XTB5EK9jRdY75ITr9mPosuY=
X-Gm-Gg: AYBFou2/3WHYg6RyB8izSDlLW1hSyHzKmAh1KBsSCITXDK6hUh43NE0opVBwpyoT1AW
 bcyftyx0/ld6Gw5ojd/pT43k3ip/tFKMScAuVhOPRXaOAAE+SOSsuRcGrqoKQlvG9b7X8OTG6Gj
 scFHtCczGlWztBiLMJpAiFlDrgXD9DAq9LVhZi6QvVJwiAr2gfBCty+HVB9Vee2pinDlqG+rxfR
 cFpCesnpIlBNOFDCz7ls8VsK6p+6aKm/AfBtEEmBYlyejwPhIvmhhnyL7dXoN1DNLuOFNaLyawz
 fA==
X-Received: by 2002:a17:903:2c10:b0:2e4:b112:14d with SMTP id
 d9443c01a7336-2e60054442bmr11393795ad.54.1791353478704; 
 Tue, 06 Oct 2026 23:11:18 -0700 (PDT)
X-Received: by 2002:a17:903:2c10:b0:2e4:b112:14d with SMTP id
 d9443c01a7336-2e60054442bmr11393675ad.54.1791353478256; Tue, 06 Oct 2026
 23:11:18 -0700 (PDT)
MIME-Version: 1.0
References: <20261005032022.3980903-1-jamin_lin@aspeedtech.com>
 <20261005032022.3980903-3-jamin_lin@aspeedtech.com>
 <179119075845.699310.5944945395562648270.b4-review@b4>
 <SEZPR06MB736267CA04EA7BB0EE82D87DFC942@SEZPR06MB7362.apcprd06.prod.outlook.com>
In-Reply-To: <SEZPR06MB736267CA04EA7BB0EE82D87DFC942@SEZPR06MB7362.apcprd06.prod.outlook.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 7 Oct 2026 10:11:06 +0400
X-Gm-Features: AclHuK9YhCBll7k6ee6cr2xOKlOWG5fTekkMuOlJEvKfQxFPaHMc_LiizB4zZ9U
Message-ID: <CAMxuvazTUQ7Z2c2+6mUpKr1EJgaVTdxYqyeyZgb7LMRbAXfrEg@mail.gmail.com>
Subject: Re: [PATCH v2 2/8] hw/usb/redirect-server: Add a usbredir server
 device
To: Jamin Lin <jamin_lin@aspeedtech.com>
Cc: "clg@kaod.org" <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>, 
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, 
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Joel Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 Troy Lee <troy_lee@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
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

Hi

On Wed, Oct 7, 2026 at 6:16=E2=80=AFAM Jamin Lin <jamin_lin@aspeedtech.com>=
 wrote:
>
> Hi Marc-Andr=C3=A9 Lureau
>
> > > diff --git a/include/hw/usb/redirect-server.h
> > > b/include/hw/usb/redirect-server.h
> >
> > What do you need a header for? If there is nothing to share with other =
units,
> > better keep it all in .c.
> >
> > --
> > Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> Thanks for your suggestion and review.
>
> Nothing else includes it. The main reason for having a separate header fi=
le is readability.
> redirect-server.c is already about 1600 lines, so I thought keeping the s=
tate structure
> and constants in a separate file would make the code easier to follow.
>
> Would hw/usb/redirect-server.h be OK instead?

Yes - I don't think we have strict rules about headers

> If you still prefer to keep everything in the .c file, I will move it the=
re for v3.

That would be "my" preference. I don't mind large files as long as
they don't mix various concerns/domains/levels.


