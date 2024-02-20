Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ACADC48BC4
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 10:57:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcNnp-0003XQ-4A; Tue, 20 Feb 2024 05:56:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rcNnn-0003X2-Ld
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 05:56:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rcNnl-0004mJ-Mu
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 05:56:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708426600;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6TQq0UHeuDvd2+ujvy5eS9NbXMPm2AYMjBVj3preUCg=;
 b=ai+UKVHpUBUXJBZTJ2RSeajQt+rOk9MUhYk/8axXVUcCLiWcA+SeQoQ1PZanC4dvnnKDmZ
 82FCVyb0k3HBNure2UrE7RbCEV3bDNTVqjEySzc0IPfisVL7Agf3tNYOeIIqfwed4yFTBp
 +wqWTKKOTyhztS06TqnHjcJmb5atfrA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-372-TQ8E780PN4i3dDjNOpiAoA-1; Tue, 20 Feb 2024 05:56:39 -0500
X-MC-Unique: TQ8E780PN4i3dDjNOpiAoA-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-33d308b0c76so1202045f8f.0
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 02:56:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708426598; x=1709031398;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6TQq0UHeuDvd2+ujvy5eS9NbXMPm2AYMjBVj3preUCg=;
 b=w5skIVQ4oT5/N3NpeEEFl8gcm5u16tWNfJxau9p8yEEYxIpe6XAM/Sf7kO82Qho7JE
 NrbLfmiFiKohNjqys6r0Md0q5ZCs3AcYFVc3mzsPF2oINM/7pLt1MYmTvmRbf4t5yl11
 merO7Fz/6Lfdae9xPikod04JW7Ohr1dDeyTtT82oTaaQke/8NrJJpJLTfykuzeM+HuJc
 BoYxkgGBgPYeuKYfo5WfFSrOKgm8h8VFb5hbSsus/DqGmDaAcA5jcAWn6b5sztTWJD14
 AUdncheYvaW5Hgp9/mVsrKVMQLH1KKs6v1t2PIN4+oSpwjACwqMyuoeJ7z/1ZHjusi9L
 0tcw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFoGzmo3C84GJcZUdWrROxBvKbBF41QFR3O3FQfFSwwNaQNZgYZrAjYbT3evqjv+t7zpNWy2oEDMwum+ymidjTXzmmcJE=
X-Gm-Message-State: AOJu0YzDbkDbAU9OiaYpa+UkFHErgL7ZTcByuKI2BZHRdjVHtZ/hmvhZ
 1OeoStx1kwRCZA5c1vSfdrj024njuDj90c6gOfTVh8yQZbSCledEDD0WHR9LGeoi40c1hYJ/bjc
 OAH8MW2r9ezMcbYPcXeRqxekragFb+Waz24vb9QG2+EOAg+li63KM
X-Received: by 2002:a05:6000:7:b0:33d:19b5:e811 with SMTP id
 h7-20020a056000000700b0033d19b5e811mr9518869wrx.20.1708426597955; 
 Tue, 20 Feb 2024 02:56:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGSQCvkGftVfXrPMAdr9y+xlU2nrme3XIYBw52EanlHrSpui2UP1G4vfrc7nF+LWYNQ6QAqaA==
X-Received: by 2002:a05:6000:7:b0:33d:19b5:e811 with SMTP id
 h7-20020a056000000700b0033d19b5e811mr9518842wrx.20.1708426597562; 
 Tue, 20 Feb 2024 02:56:37 -0800 (PST)
Received: from redhat.com ([2a02:14f:175:1376:5352:3710:49bb:419e])
 by smtp.gmail.com with ESMTPSA id
 j18-20020a5d6192000000b0033b6e26f0f9sm13093344wru.42.2024.02.20.02.56.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Feb 2024 02:56:37 -0800 (PST)
Date: Tue, 20 Feb 2024 05:56:32 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>,
 Alex =?iso-8859-1?Q?Benn=E9?= e <alex.bennee@linaro.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Hongren Zheng <i@zenithal.me>, "Canokeys.org" <contact@canokeys.org>
Subject: Re: [PATCH v1 01/21] docs: correct typos
Message-ID: <20240220055558-mutt-send-email-mst@kernel.org>
References: <cover.1708419115.git.manos.pitsidianakis@linaro.org>
 <135bbfcb6dd09377cfd39fb73c862cd0fb66bb20.1708419115.git.manos.pitsidianakis@linaro.org>
 <20240220053538-mutt-send-email-mst@kernel.org>
 <95hul.sppswhjb0hah@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <95hul.sppswhjb0hah@linaro.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.072,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, Feb 20, 2024 at 12:42:28PM +0200, Manos Pitsidianakis wrote:
> On Tue, 20 Feb 2024 12:36, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > On Tue, Feb 20, 2024 at 10:52:08AM +0200, Manos Pitsidianakis wrote:
> > > Correct typos automatically found with the `typos` tool
> > > <https://crates.io/crates/typos>
> > > 
> > > Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> > 
> > Acked-by: Michael S. Tsirkin <mst@redhat.com>
> > 
> > > ---
> > >  docs/devel/ci-jobs.rst.inc      | 2 +-
> > >  docs/devel/docs.rst             | 2 +-
> > >  docs/devel/testing.rst          | 2 +-
> > >  docs/interop/prl-xml.txt        | 2 +-
> > >  docs/interop/vhost-user.rst     | 2 +-
> > >  docs/system/devices/canokey.rst | 2 +-
> > >  6 files changed, 6 insertions(+), 6 deletions(-)
> > > 
> > > diff --git a/docs/devel/ci-jobs.rst.inc b/docs/devel/ci-jobs.rst.inc
> > > index 4c39cdb2d9..6678b4f4ef 100644
> > > --- a/docs/devel/ci-jobs.rst.inc
> > > +++ b/docs/devel/ci-jobs.rst.inc
> > > @@ -147,7 +147,7 @@ Set this variable to 1 to create the pipelines, but leave all
> > >  the jobs to be manually started from the UI
> > >  Set this variable to 2 to create the pipelines and run all
> > > -the jobs immediately, as was historicaly behaviour
> > > +the jobs immediately, as was historically behaviour
> > 
> > as long as we do this let's fix grammar too?
> > 
> > as was historically the behaviour
> 
> After the fact, I think it should be "as was historical behaviour".

it needs the definite article though.

> I will re-spin with only this change, and keep the Acks/RoBs if that is okay
> with everyone.
> 
> Thanks,
> 
> > 
> > >  QEMU_CI_AVOCADO_TESTING
> > >  ~~~~~~~~~~~~~~~~~~~~~~~
> > > diff --git a/docs/devel/docs.rst b/docs/devel/docs.rst
> > > index 50ff0d67f8..a7768b5311 100644
> > > --- a/docs/devel/docs.rst
> > > +++ b/docs/devel/docs.rst
> > > @@ -21,7 +21,7 @@ are processed in two ways:
> > >  The syntax of these ``.hx`` files is simple. It is broadly an
> > >  alternation of C code put into the C output and rST format text
> > > -put into the documention. A few special directives are recognised;
> > > +put into the documentation. A few special directives are recognised;
> > >  these are all-caps and must be at the beginning of the line.
> > >  ``HXCOMM`` is the comment marker. The line, including any arbitrary
> > > diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
> > > index bd132306c1..aa96eacec5 100644
> > > --- a/docs/devel/testing.rst
> > > +++ b/docs/devel/testing.rst
> > > @@ -728,7 +728,7 @@ For example to setup the HPPA ports builds of Debian::
> > >      EXECUTABLE=(pwd)/qemu-hppa V=1
> > >  The ``DEB_`` variables are substitutions used by
> > > -``debian-boostrap.pre`` which is called to do the initial debootstrap
> > > +``debian-bootstrap.pre`` which is called to do the initial debootstrap
> > >  of the rootfs before it is copied into the container. The second stage
> > >  is run as part of the build. The final image will be tagged as
> > >  ``qemu/debian-sid-hppa``.
> > > diff --git a/docs/interop/prl-xml.txt b/docs/interop/prl-xml.txt
> > > index 7031f8752c..cf9b3fba26 100644
> > > --- a/docs/interop/prl-xml.txt
> > > +++ b/docs/interop/prl-xml.txt
> > > @@ -122,7 +122,7 @@ Each Image element has following child elements:
> > >      * Type - image type of the element. It can be:
> > >               "Plain" for raw files.
> > >               "Compressed" for expanding disks.
> > > -    * File - path to image file. Path can be relative to DiskDecriptor.xml or
> > > +    * File - path to image file. Path can be relative to DiskDescriptor.xml or
> > >               absolute.
> > >  == Snapshots element ==
> > > diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
> > > index ad6e142f23..d1ed39dfa0 100644
> > > --- a/docs/interop/vhost-user.rst
> > > +++ b/docs/interop/vhost-user.rst
> > > @@ -989,7 +989,7 @@ When reconnecting:
> > >     #. If ``d.flags`` is not equal to the calculated flags value (means
> > >        back-end has submitted the buffer to guest driver before crash, so
> > > -      it has to commit the in-progres update), set ``old_free_head``,
> > > +      it has to commit the in-progress update), set ``old_free_head``,
> > >        ``old_used_idx``, ``old_used_wrap_counter`` to ``free_head``,
> > >        ``used_idx``, ``used_wrap_counter``
> > > diff --git a/docs/system/devices/canokey.rst b/docs/system/devices/canokey.rst
> > > index cfa6186e48..7f3664963f 100644
> > > --- a/docs/system/devices/canokey.rst
> > > +++ b/docs/system/devices/canokey.rst
> > > @@ -14,7 +14,7 @@ CanoKey [1]_ is an open-source secure key with supports of
> > >  All these platform-independent features are in canokey-core [3]_.
> > >  For different platforms, CanoKey has different implementations,
> > > -including both hardware implementions and virtual cards:
> > > +including both hardware implementations and virtual cards:
> > >  * CanoKey STM32 [4]_
> > >  * CanoKey Pigeon [5]_
> > > -- 
> > > γαῖα πυρί μιχθήτω
> > 


