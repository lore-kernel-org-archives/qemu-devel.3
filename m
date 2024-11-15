Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33ED7D68BCF
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2024 19:22:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tC1sv-0001zG-Dj; Fri, 15 Nov 2024 14:21:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1tC1ss-0001yz-Vw
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 14:21:35 -0500
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1tC1sq-0000i8-5t
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 14:21:34 -0500
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-53d9ff92ee9so2608807e87.1
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2024 11:21:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731698485; x=1732303285; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Nbh6o5ubGKdV6+0lnf2i9/yJv83sBr2g1cSrTtoTLk4=;
 b=m4zchphoAbr7I/Z85VxAySKtFiVeN74v2PM9vwrFN0jBnk7EhAM8deMkE+6tpJHLRM
 x48VQROl6EZvESqy8JjjNIoGkroKhErMbXA76BXyAWWQwceFVsitbMijKOUZ3x2xlpT3
 AGma7rgnZD/RJewKZcyh/Z0jjO73Nrk8yP+Ck/cIChKBISrKfAv3m/2M69MPWkARyEJY
 PajLB7cG/bFIu88ivo19FS+CIKH2YELpdiV6M+eiNwSpuXhwaz08bQLaBreoT2OL1q/1
 0m9jLu8r2fYOko+hjjJ5nroip+BB1balb1AQ4UELlE+/FrZbOEriPUfGssII4FJCj0lG
 h6sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731698485; x=1732303285;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Nbh6o5ubGKdV6+0lnf2i9/yJv83sBr2g1cSrTtoTLk4=;
 b=L2B4nvLbOqeir2EUfKAUJbewZo5qKDY/iQQHlAAFbhSUWnyNkTPXUvOXusSK0MgotD
 iv2ZZpm2uj1cu/JEw4OOu5AsNBs3qAcG/lh9gDkZoGaPAyjvl1WuKIdcgnAcaH8QUiG2
 UvlKmZWn8C9NhsybgA2qx1MXf7oZ1WUGBrKZGgPDjOaCXex51D3f129dgETVxPfwUF3v
 LDUEVN6wXR/lscidagFbix5ELoG8hTCG5y4DyLfdBaqXBP4ALO9CiBKY6jMPsjMP8s9f
 TMnr4TPY/PxVUBth85NPlBe1otI2qCYqJLoRyfUfbCGGYL/7cOqfLyXKRhAVjr40rtec
 NASg==
X-Gm-Message-State: AOJu0YxZRbKG+ER7qh1RHV6kFzWsFVYrEMUbT3QzDIZrYHqYLHln8MvL
 IhnV4XmPTR/hpAkTj3Fsy1CGwWkyRJ8S63jtwJADK+PbfJScZRBlGenqZpi6oUUDgQrELINYtXF
 dmQ+I2pAZvr+jGR8O93BWnvWwR1g=
X-Google-Smtp-Source: AGHT+IFtc2342zuHqQUv+uUBo7eUN2IOn5qlABIdUnA4VxkUcZPuaPkwzYyyUPDtaaa6Bb3iE1kSvaXw/GJNnwfylvI=
X-Received: by 2002:a05:6512:3d27:b0:52c:dc97:45d1 with SMTP id
 2adb3069b0e04-53dab290654mr2105765e87.10.1731698484313; Fri, 15 Nov 2024
 11:21:24 -0800 (PST)
MIME-Version: 1.0
References: <ZzXV-KyYLa-7yNdV@redhat.com>
 <CAJSP0QUkfSO3uXPjZCxNfCfVwwWBBy6u5a=PjqqnMZSxE95YpA@mail.gmail.com>
 <ZzcMQeHfBTm2iEsc@redhat.com>
In-Reply-To: <ZzcMQeHfBTm2iEsc@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Fri, 15 Nov 2024 14:21:12 -0500
Message-ID: <CAJSP0QVPiibdfs1YsYMe0Mk-DX-Xy7f+utG=W4eSpBkdzaodGg@mail.gmail.com>
Subject: Re: QEMU wiki theme table of contents changes
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=stefanha@gmail.com; helo=mail-lf1-x12e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, 15 Nov 2024 at 03:54, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> On Thu, Nov 14, 2024 at 02:04:35PM -0500, Stefan Hajnoczi wrote:
> > On Thu, 14 Nov 2024 at 05:51, Daniel P. Berrang=C3=A9 <berrange@redhat.=
com> wrote:
> > >
> > > Looking at
> > >
> > >   https://wiki.qemu.org/ChangeLog/9.2
> > >
> > > I'm thinking that I'm sure there used to be a table of contents prese=
nt
> > > at the top of pages, but none is to be seen..... until I eventually
> > > discover that there's a bare noticable, fully collapsed ToC in the le=
ft
> > > hand nav panel below all the general wiki nav links, partially off th=
e
> > > bottom of the page :-(
> > >
> > > If going to https://wiki.qemu.org/Special:Preferences, "Appearance" a=
nd
> > > selecting "Vector legacy (2010)" as the "Skin" instad of "Vector (202=
2)"
> > > then the full ToC re-appears at the top of page in the main body cont=
ent.
> > >
> > > I'm presuming this style change was triggered by a software upgrade t=
hat
> > > was done on the wiki at some point.
> > >
> > > IMHO this is quite a significant visual/usability regression.
> > >
> > > On wikipedia, they do have the same theme, with ToC in the left hand
> > > panel, but their ToC is expanded by default, and there's no other gen=
eral
> > > navigation in the left hand panel that's displacing the ToC off the b=
ottom
> > > of the page. That is fairly effective as a layout.
> > >
> > > We can do something to the QEMU skin to improve this ? Swapping order
> > > of the ToC & general nav blocks in the left hand panel would be a
> > > improvement, as well making it expand at least 1 further level by
> > > default.
> > >
> > > If we're going to have background colour set for the general nav bloc=
k,
> > > we should also probably do similar for the ToC nav block to make it
> > > visually stand out to the same degree.
> >
> > Yes, that sounds good. The quickest would be for you to:
> > 1. Run https://hub.docker.com/_/mediawiki/ in a container on your machi=
ne.
> > 2. Adjust the theme CSS until you are happy.
> > 3. Send me the tweaks and I will apply them to wiki.qemu.org.
>
> Is the current QEMU mediawiki code (or just theme) published anywhere
> that I can base work off ?

The QEMU wiki runs from the vanilla mediawiki 1.39 container image.
The Vector (2022) theme comes with Mediawiki and there are no
QEMU-specific customizations.

You can get the same look with the vanilla Mediawiki container image
with the following in LocalSettings.php:
$wgDefaultSkin =3D "vector-2022";
wfLoadSkin('Vector');

Sorry I am not able to fix this quickly myself. I don't have much
Mediawiki knowledge but if you tell me what to do we can certainly
customize QEMU's wiki.

Stefan

