Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B6D2C53209
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 17:22:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woP1D-0006ON-8K; Mon, 27 Jul 2026 13:21:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1woP0F-0006Hb-81
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 13:20:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1woP04-0001MH-4n
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 13:20:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785172823;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u6afx08wKd6RvWFzCzuO54Zssef71NPh6fis+puWjoE=;
 b=FgaTBWG7La4lT30taEHJM2wg08h+fCHNaln4XfUim37AlG5n0kIplfXW/YhjuJkZUTVgdI
 QjtW+c4Eq/7c0N2istFuDAY9h7CIn2+EKSwOdYlinUD8qiCof+Ubr3W0MJdpQpAJcE85E+
 0OhKPuNMJOFOykY/jst0pb0regn8z80=
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-277-HRH3vx25MFWt9LNrluDuOg-1; Mon, 27 Jul 2026 13:20:22 -0400
X-MC-Unique: HRH3vx25MFWt9LNrluDuOg-1
X-Mimecast-MFC-AGG-ID: HRH3vx25MFWt9LNrluDuOg_1785172821
Received: by mail-yx1-f71.google.com with SMTP id
 956f58d0204a3-668841f9af1so4879110d50.2
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 10:20:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785172821; cv=none;
 d=google.com; s=arc-20260327;
 b=LUVTdaZ0ikVydJ2NCbSV+vE3b3kxQEjs3Ii660LZMlOYY7+pUR0TBaulUBUDeANjcg
 DKYsDTrplquLFaOC0G9ZaZqVca7RtUHLtNBRWY8+My1zGYhHxbiJKJrfj+hnK6ICfN+2
 nSDOvWCwqz0N2/QqiPlIppVPa5NBDYJ8+CNsPobwOIpgn/kli5fPChZZiuOexa0EuI9d
 u2rGu0Di1u87AsGUcB7vFKf1N3zMX9QNZp7YBrm8dYcjWWj37oX4LBt3eL2ihLOm1VDO
 2xD3vDvdD+XwJ2M9VWWSbCFLN1H+IBQvqXSsZHRwy/VLDaniGhuhK0hkz+U/ntmZjbwf
 XYkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=u6afx08wKd6RvWFzCzuO54Zssef71NPh6fis+puWjoE=;
 fh=0c5lhis1tI0Xv2/4xfQOO5bCANYWd25ch3LVSXcjlLc=;
 b=GdrU4L84FqUv4gK79fcoM/SQ6d8Ai0TA17i2fAn3n/RuOIaIE65G/H761P9P1d/7jB
 0BKTRw23JXQ1qa0zzgIdgl+Fl/YiEllsqS0XGuGFDD87zZqTxvQntXlVoTSJGU/Xwh84
 vtLzsPRJxskaglHJhPZkOKDSl/lVkaCruh23eJmbWMTqJuupngLVrcpHJ+Z6Lrf6dcjx
 OiG0a/XofY6hI+84YT7c4Jk64xMURLiNuyC2hG1q7pTAgSWDk2Lzxp3bsl4fhDkXQpPO
 XwLCOl4cTxuHr7oa52zziTp7RRUtkTbOF25WdLljt02SwWWR7tiTcMh0/SnLXJXb3i7h
 q8hw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785172821; x=1785777621; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=u6afx08wKd6RvWFzCzuO54Zssef71NPh6fis+puWjoE=;
 b=IGL5Ythnfpj9t7bpF6zzh/t17xlfpljMpQIUEzltgdB6TqME8YvwPxUepQIRtOwZnR
 P0Pdt986dUBalmP+wZjtgTXqppPqzFASl1JLAOep/xSAQcAUXNSnsk4Svgtb1Psk1iqh
 hlXgJrbuIju5pDUJXWs+436X4/kri2Tj/Hp/n+3i8u1ohMj3M6vDGWwLYUa5OnoxJt5t
 869B23aTd0H+OTDE46+6TwrfBBlHXS/Nyb7bdnsKUeg3joCMYNn9onPdNpOCG+obmPIA
 PrRUCkQx/bcihtefIB31nh2Gq4GH/9T6xZPwHzfFc1Ym6oZh7d/3+P/GV76iOzgnbO2C
 jHWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785172821; x=1785777621;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=u6afx08wKd6RvWFzCzuO54Zssef71NPh6fis+puWjoE=;
 b=nMP+WPenyO9RLmGlUUT3uwjNcYBh4oPLET/AGEBG98Mjpjpj8MK+Y5nsG3zlf1A/s7
 mFG2WOmxLot0nIcFSKk9Z45jLJMFiuDE4r4lyKJcOj1PY0zvw7P3NGFXcxPa7N9UDYcD
 1ZDWYJf5CmqCD5lGBtC3Q1uW74XbV1A5904src6Z9/1jXZdrscyxJ11M6aST6UmktUvF
 Qltr4WzqcZ3uLkwPxV/N64k8bxIUSndxWSShARhXc2zCQqbUT8s3qwAj+E5x0H/29ww8
 MO6O9EfzCElxfW9usF61vzu+AhtHGGbupXeR5YZKWAQ+JBjczthZDGpPIvstYfUJaVrR
 GEJw==
X-Gm-Message-State: AOJu0YwYckYXBMTV4QvU+CseQvyVFlynUCQgPAATW2YJk91Imp1a+7iG
 dAVVCMHVeC/UIS7gEIz6t17+RMN8m2Wes99he79JFVZcAn/JcWntgqyiz+zY97h2DfN9mwJwWni
 hx4NDVN9ypiIoQXqCKKGhVZNW1ZTF15nNacl9KX2syZYELfLP4us+JxwWN/qOiMjP0i0UnqfAhX
 biD9+m1+bE2J1ScjaHdcGOj8KTWft4XHs=
X-Gm-Gg: AR+sD10VLNMu5x3S3GTAq70DzyZFlsMuylGyKzHUqVwTIssdZtAfo21COgcMgQWb9Fh
 +t5buE0hK1GGAfeGlbyLurFJsmsfDzjCfk1z0eya17vDRc+GKifOU4lYr4yUvcqc2g+Qsj/A683
 bbXSRAW4msjLRmQ+8KymkVpvFOF+3ceDROH+2I7VpE+BSVsTH38yUxtsmWzQqGwwIjncpkv2a0b
 u+UJ4RN4Ta8qktA
X-Received: by 2002:a53:cac1:0:b0:667:d5e0:1c69 with SMTP id
 956f58d0204a3-668c7a13057mr1982217d50.31.1785172821146; 
 Mon, 27 Jul 2026 10:20:21 -0700 (PDT)
X-Received: by 2002:a53:cac1:0:b0:667:d5e0:1c69 with SMTP id
 956f58d0204a3-668c7a13057mr1982197d50.31.1785172820614; Mon, 27 Jul 2026
 10:20:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260723044805.527643-1-jsnow@redhat.com>
 <20260723044805.527643-45-jsnow@redhat.com>
 <87y0f0aikr.fsf@pond.sub.org>
In-Reply-To: <87y0f0aikr.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Mon, 27 Jul 2026 13:20:09 -0400
X-Gm-Features: AUfX_mz_Ii50MiumBfvXVZr6OIQ9ljsx38tHDtxPXG0jyiKi4V8B_BK1TGjrT7g
Message-ID: <CAFn=p-axhB-ezhfD2F8EoFhWT0h92d6oWP6Li1-JdhiXUGbsdA@mail.gmail.com>
Subject: Re: [PATCH v2 44/44] qapi: convert trivial intro sections for
 block-core.json
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Lukas Straub <lukasstraub2@web.de>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Zhao Liu <zhao1.liu@intel.com>, 
 Laurent Vivier <laurent@vivier.eu>, "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 Alex Williamson <alex@shazbot.org>, zhenwei pi <zhenwei.pi@linux.dev>,
 Hanna Reitz <hreitz@redhat.com>, 
 Ani Sinha <anisinha@redhat.com>, qemu-block@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, 
 linux-cxl@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Stefan Berger <stefanb@linux.vnet.ibm.com>, Fabiano Rosas <farosas@suse.de>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>, 
 Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, 
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, linux-edac@vger.kernel.org, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Eric Blake <eblake@redhat.com>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Jason Wang <jasowangio@gmail.com>, qemu-trivial@nongnu.org, 
 Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Jul 24, 2026 at 4:38=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> John Snow <jsnow@redhat.com> writes:
>
> > (Trivial)
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >  qapi/block-core.json | 646 +++++++++++++++++--------------------------
> >  1 file changed, 255 insertions(+), 391 deletions(-)
> >
> > diff --git a/qapi/block-core.json b/qapi/block-core.json
> > index 1f87b078505..bd98af2f298 100644
> > --- a/qapi/block-core.json
> > +++ b/qapi/block-core.json
>
> [...]
>
> > @@ -422,10 +417,9 @@
> >
> >  ##
> >  # @BlockGraphInfo:
> > -#
> > -# Information about all nodes in a block (sub)graph in the form of
> > -# `BlockNodeInfo` data.  The base `BlockNodeInfo` struct contains the
> > -# information for the (sub)graph's root node.
> > +#     Information about all nodes in a block (sub)graph in the form of
> > +#     `BlockNodeInfo` data.  The base `BlockNodeInfo` struct contains
> > +#     the information for the (sub)graph's root node.
> >  #
> >  # @children: Array of links to this node's child nodes' information
> >  #
>
> The first sentence is clearly overview, but the second caught my eye.
> What would we want the inliner to do with it?
>
> Looks like the inliner isn't going to do anything with it right now,
> because BlockGraphInfo is only used as member type.
>
> [...]
>
> > @@ -1378,10 +1355,9 @@
> >
> >  ##
> >  # @BlockdevOnError:
> > -#
> > -# An enumeration of possible behaviors for errors on I/O operations.
> > -# The exact meaning depends on whether the I/O was initiated by a
> > -# guest or by a block job
> > +#     An enumeration of possible behaviors for errors on I/O
> > +#     operations.  The exact meaning depends on whether the I/O was
> > +#     initiated by a guest or by a block job
> >  #
> >  # @report: for guest operations, report the error to the guest; for
> >  #     jobs, cancel the job
>
> The first sentence is clearly overview, but the second caught my eye.
>
> Because this is an enum type, and we're not going to inline these, we
> can leave it as is.
>
> [...]
>
> > @@ -1636,9 +1605,8 @@
> >
> >  ##
> >  # @BackupPerf:
> > -#
> > -# Optional parameters for backup.  These parameters don't affect
> > -# functionality, but may significantly affect performance.
> > +#     Optional parameters for backup.  These parameters don't affect
> > +#     functionality, but may significantly affect performance.
>
> The first sentence is clearly overview.  What would we want the inliner
> to do with the second?
>
> Looks like the inliner isn't going to do anything with it right now,
> because BackupPerf is only used as member type.
>
> Aside: this only user BackupCommon member x-perf has been @unstable for
> more than five years.  That's a long time to sit on a fence.
>
> >  #
> >  # @use-copy-range: Use copy offloading.  Default false.
> >  #
>
> [...]
>
> > @@ -1845,12 +1812,12 @@
> >
> >  ##
> >  # @change-backing-file:
> > -#
> > -# Change the backing file in the image file metadata.  This does not
> > -# cause QEMU to reopen the image file to reparse the backing filename
> > -# (it may, however, perform a reopen to change permissions from r/o ->
> > -# r/w -> r/o, if needed).  The new backing file string is written into
> > -# the image file metadata, and the QEMU internal strings are updated.
> > +#     Change the backing file in the image file metadata.  This does
> > +#     not cause QEMU to reopen the image file to reparse the backing
> > +#     filename (it may, however, perform a reopen to change
> > +#     permissions from r/o -> r/w -> r/o, if needed).  The new backing
> > +#     file string is written into the image file metadata, and the
> > +#     QEMU internal strings are updated.
>
> This is an example of a first paragraph I might flag for review if it
> was a struct or union type.
>
> >  #
> >  # @image-node-name: The name of the block driver state node of the
> >  #     image to modify.  The "device" argument is used to verify
>
> [...]
>
> > @@ -2746,11 +2700,10 @@
> >
> >  ##
> >  # @ThrottleLimits:
> > -#
> > -# Limit parameters for throttling.  Since some limit combinations are
> > -# illegal, limits should always be set in one transaction.  All fields
> > -# are optional.  When setting limits, if a field is missing the
> > -# current value is not changed.
> > +#     Limit parameters for throttling.  Since some limit combinations
> > +#     are illegal, limits should always be set in one transaction.
> > +#     All fields are optional.  When setting limits, if a field is
> > +#     missing the current value is not changed.
>
> The first sentence is clearly overview, but what would we want the
> inliner to do with the remainder?
>
> Looks like the inliner isn't going to do anything with it right now,
> because ThrottleLimits is only used as member type.
>
> >  #
> >  # @iops-total: limit total I/O operations per second
> >  #
>
> [...]
>
> > @@ -3548,12 +3486,11 @@
> >
> >  ##
> >  # @Qcow2OverlapCheckFlags:
> > -#
> > -# Structure of flags for each metadata structure.  Setting a field to
> > -# 'true' makes QEMU guard that Qcow2 format structure against
> > -# unintended overwriting.  See Qcow2 format specification for detailed
> > -# information on these structures.  The default value is chosen
> > -# according to the template given.
> > +#     Structure of flags for each metadata structure.  Setting a field
> > +#     to 'true' makes QEMU guard that Qcow2 format structure against
> > +#     unintended overwriting.  See Qcow2 format specification for
> > +#     detailed information on these structures.  The default value is
> > +#     chosen according to the template given.
> >  #
> >  # @template: Specifies a template mode which can be adjusted using the
> >  #     other flags, defaults to 'cached'
>
> The first sentence is clearly overview, but what would we want the
> inliner to do with the remainder?
>
> Looks like the inliner isn't going to do anything with it right now,
> because Qcow2OverlapCheckFlags is only used as member type.
>
>
> [...]
>
> > @@ -4550,9 +4460,8 @@
> >
> >  ##
> >  # @BlockdevOptionsCurlHttp:
> > -#
> > -# Driver specific block device options for HTTP connections over the
> > -# curl backend.  URLs must start with "http://".
> > +#     Driver specific block device options for HTTP connections over
> > +#     the curl backend.  URLs must start with "http://".
> >  #
> >  # @cookie: List of cookies to set; format is "name1=3Dcontent1;
> >  #     name2=3Dcontent2;" as explained by CURLOPT_COOKIE(3).  Defaults =
to
>
> The first sentence is clearly overview, but what about the second?
> "URLs" are actually member @url of base type BlockdevOptionsCurlBase.
> What would we want the inliner to do with it?
>
> BlockdevOptionsCurlBase is the base type of BlockdevOptionsCurlHttps and
> a branch type of BlockdevOptions, where this will get inlined.
>
> > @@ -4576,9 +4485,8 @@
> >
> >  ##
> >  # @BlockdevOptionsCurlHttps:
> > -#
> > -# Driver specific block device options for HTTPS connections over the
> > -# curl backend.  URLs must start with "https://".
> > +#     Driver specific block device options for HTTPS connections over
> > +#     the curl backend.  URLs must start with "https://".
> >  #
> >  # @sslverify: Whether to verify the SSL certificate's validity
> >  #     (defaults to true)
>
> Likewise.
>
> > @@ -4591,9 +4499,8 @@
> >
> >  ##
> >  # @BlockdevOptionsCurlFtp:
> > -#
> > -# Driver specific block device options for FTP connections over the
> > -# curl backend.  URLs must start with "ftp://".
> > +#     Driver specific block device options for FTP connections over
> > +#     the curl backend.  URLs must start with "ftp://".
> >  #
> >  # Since: 2.9
> >  ##
>
> Likewise.
>
> > @@ -4603,9 +4510,8 @@
> >
> >  ##
> >  # @BlockdevOptionsCurlFtps:
> > -#
> > -# Driver specific block device options for FTPS connections over the
> > -# curl backend.  URLs must start with "ftps://".
> > +#     Driver specific block device options for FTPS connections over
> > +#     the curl backend.  URLs must start with "ftps://".
> >  #
> >  # @sslverify: Whether to verify the SSL certificate's validity
> >  #     (defaults to true)
>
> Likewise.
>
>
> [...]
>
> > @@ -4735,14 +4637,13 @@
> >
> >  ##
> >  # @BlockdevOptionsCbw:
> > -#
> > -# Driver specific block device options for the copy-before-write
> > -# driver, which does so called copy-before-write operations: when data
> > -# is written to the filter, the filter first reads corresponding
> > -# blocks from its file child and copies them to @target child.  After
> > -# successfully copying, the write request is propagated to file child.
> > -# If copying fails, the original write request is failed too and no
> > -# data is written to file child.
> > +#     Driver specific block device options for the copy-before-write
> > +#     driver, which does so called copy-before-write operations: when
> > +#     data is written to the filter, the filter first reads
> > +#     corresponding blocks from its file child and copies them to
> > +#     @target child.  After successfully copying, the write request is
> > +#     propagated to file child.  If copying fails, the original write
> > +#     request is failed too and no data is written to file child.
> >  #
> >  # @target: The target for copy-before-write operations.
> >  #
>
> What would we want the inliner to do with this one?
>
> BlockdevOptionsCbw is a branch type of BlockdevOptions, where this will
> get inlined.
>
> > @@ -4778,9 +4679,8 @@
> >
> >  ##
> >  # @BlockdevOptions:
> > -#
> > -# Options for creating a block device.  Many options are available for
> > -# all block devices, independent of the block driver:
> > +#     Options for creating a block device.  Many options are available
> > +#     for all block devices, independent of the block driver:
> >  #
> >  # @driver: block driver name
> >  #
>
> What would we want the inliner to do with this one?
>
> BlockdevOptions is used as argument of blockdev-add, where it will be
> inlined.
>
>
> [...]
>
> > @@ -5587,9 +5465,8 @@
> >
> >  ##
> >  # @BlockdevAmendOptionsQcow2:
> > -#
> > -# Driver specific image amend options for qcow2.  For now, only
> > -# encryption options can be amended
> > +#     Driver specific image amend options for qcow2.  For now, only
> > +#     encryption options can be amended
> >  #
> >  # @encrypt: Encryption options to be amended
> >  #
>
> What would we want the inliner to do with this one?
>
> BlockdevAmendOptionsQcow2 is used as branch of BlockdevAmendOptions,
> where it will be inlined.
>
> [...]
>
> I believe all the problematic first paragraphs consist of more than one
> sentence.  What about splitting "trivial" into "very trivial" (just one
> paragraph, no sentence-ending punctuation in the middle) and "hopefully
> trivial" (just one paragraph, remainder)?

That's tricky to automate, and doing it by hand doesn't sound much fun
either... can we just power through one-by-one?

Unless you have a script or a trick you believe will help, and then I
am happy to oblige.


