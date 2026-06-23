Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78EC3CDB46F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 11:55:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbzir-00038l-Ea; Tue, 23 Jun 2026 07:55:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wbzip-00038Z-Dc
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 07:55:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wbzih-0004my-Oy
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 07:55:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782215710;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EVtSagZITA/vCjnhFI8rs12EVEcRAWsW3VLlEzlIEWo=;
 b=OiaC2tB99iKXkGN/+IF/4XDmNRDe8z6kOXcOD9Z+u5MAWEotKMG7ZPcNMfPg0Nj9Qcj9ye
 qMOA0xlp8pQzhfSFzdVh2lrIqKYZ6U6qyCoQFJktC+wbumB2fl9BLod99zuQ9S2OzgwJWT
 WxVY6QsZe/g0dyd9bEC/pQgnoUuaoa0=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-279-EybJgsZRPQ2FqGdg1HVnbw-1; Tue, 23 Jun 2026 07:55:07 -0400
X-MC-Unique: EybJgsZRPQ2FqGdg1HVnbw-1
X-Mimecast-MFC-AGG-ID: EybJgsZRPQ2FqGdg1HVnbw_1782215706
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2c2d0a8b5beso60159155ad.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 04:55:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782215706; cv=none;
 d=google.com; s=arc-20240605;
 b=JFuf/HdmVzHBrrs4Gqm92kUGuwV0nFSRrpZAH2ZGwvMGgS676Ipr+z0IwX+8pVeal+
 3YX2keW+NkqK3NJN5hQpT19ErpC0lx5C8jEom4YcmSM1d+wb/ECPK8g7T8lfYZAwZGCx
 ahJV3KOCLxHVmX1heF1PXRCooyxw9qZyRtQsfL347Y9B885ejNNKet4p+x5nD0ksucCY
 btj4pAkTf2qSH4sVeMZK5PtyuhcEWFhA0Cm843X0tLpElc/vvQ3+E8B48BbulZ8iW3rV
 bLsnq+LlcZ9XssMK0/kupDhyJGcUrOUoYFeIUJMWlRn0zHO8PX1LurozOUR4jETrCFad
 MEbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=EVtSagZITA/vCjnhFI8rs12EVEcRAWsW3VLlEzlIEWo=;
 fh=dGH/5+nH3FM7IfLV/XwXKqSxGgsCS5JoK4GdF74RF+A=;
 b=Dp8040q50UVX+J8JRlndzAwHrqaxHZca0UlLHsZCDU+RJVv1jzvgV3gG4J447DoKQc
 PFu0CXgb5k+H/RiHL5MUfQTksHf/QMg/lqBRKPC8Vn0uMsvUOR8aD0BVsBLdDr2NRiiK
 G5dOyOKPqQThe+M06zEd9upeDlkHzM2CE2OFZDktnZRKJqOb1T0TlsLuKTxP1diC5Agm
 PF5yjgxc5aS1smmmiU7KyDrkKZKjwkPRjh/Ijq63kX5V/X6/HoeSItZWvtshjPq4AcQ5
 rHiANsVIN1qbeITEq7tBinA+KL/dMw3Gv/Ioel+M/cO6tZ8evNeh1ygdhNIhWpoe+rd/
 WVzw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782215706; x=1782820506; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EVtSagZITA/vCjnhFI8rs12EVEcRAWsW3VLlEzlIEWo=;
 b=VQJtPcjxvtsnbMpztgtmOMBQ7hWNsP+xAPVxfP2NplCiq8NM52KUbvP6BLP/Er4W7y
 HoC5KNs+U0I/8auh+AUDhtnGu5ny/tYU22XaWtAy7hStSC53A4TIkk1v4fnOj0pNR6UB
 zQcgieNCjZU02qlVB1H45YtBqNEYT0eOso5MRLk+MQQhxosaaiJmuoUOPOplHCHYSmLp
 R4iiZb55oCmDQxdum1JrMJP+xUmarP0Ym+/IPBPuoey+MIXCWve76qHJUv/at5D0ue3i
 SOZPhqbKlX4x0ke9eKT3N/EKg3DWgU5DgeSl9eQp2ZYVeAnHsg7PzOBQT9I2IO4SsT9o
 nNEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782215706; x=1782820506;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EVtSagZITA/vCjnhFI8rs12EVEcRAWsW3VLlEzlIEWo=;
 b=VeAVXDTMjVSGi9nAOkKRQY3WBe/pEbSglyRIywfB42ARwqjGd4Y10khAOqvqBOrIS6
 nf10vrD87KzNgK6k4i7ATwBgiOYd/Yt3F6GIWtOcwbbMJ6OjQq96B+LK9SK8JB/0Y4Lt
 poiv68mIwD6bHm8P4GJD3c7dm7gPWWnzHJ0iR1iM3Fkb/D6VSZed+1VCYLU/YtcHAkuI
 zFBsdmrk27tVimAWbeYbO4OgSZB4B5vzG8a7X7NVUML4x7mH/1ACoTWOSZn12FWtPud7
 icgBOFxQj1QmjG1m9ZelpJ6xds3TxXqsfMBUHuc+fc6xqkgCQ5VV7PRA6YaagirHkTZL
 2cDQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro4vekSfpFgxzhu1oRdUUTfnRhj200NSbT0v1va/WBckcXcuHF9Q3siVr0FFEcyoEawOcLPXNrFJKvC@nongnu.org
X-Gm-Message-State: AOJu0Yx53pRiJSCCub98cc+8/LQazuUVx2ClWq8ONDsufWS0BlFodegQ
 LrAoJhlEYdDAPIy6QVLDdCZppCJpCVvnWdrOJoXz5MmXMdRjdtAqhr093FYg0yzt9hA5vbw7lp4
 DGYUiA5UrkT9yST+mDpUWDYLNKTAMPNSTEYkkKsxmOeCxLt445Kw3iEoKyYVGkdqHG0MyW8UJsm
 l+yJxtDJUFMhUWAdlutGT2aMX3n/ivyOs=
X-Gm-Gg: AfdE7clZpg9bDu379yCgWhWfV80CBom3BfXINI0+0C7AiBHR2lOnux1VSGYFGGRYTsl
 QPn937lR8s7S6q91ZN+3xG43zwFJXhM+b3zhCtfiJhEI8ZnzLbgdAro9O/wWwgaV3L7YOByKaUd
 fuioiwtARgGdB+IXgPv+fWHpTSJI3ARt4cDVooPVgxAgOWg1O67kqlm8jztBKjwrvu7EnQRk+ZM
 xrcl4VjcXeAvIx+yjnx9IKMyki0b3D2o8KXiNR/CKe4B9SNsjW843NE9OysE4qRoO7e7vI9Nz3k
 pD4WkJlDRGlO
X-Received: by 2002:a17:902:d504:b0:2c2:8659:da2c with SMTP id
 d9443c01a7336-2c7425d58aamr150441875ad.14.1782215706205; 
 Tue, 23 Jun 2026 04:55:06 -0700 (PDT)
X-Received: by 2002:a17:902:d504:b0:2c2:8659:da2c with SMTP id
 d9443c01a7336-2c7425d58aamr150441605ad.14.1782215705782; Tue, 23 Jun 2026
 04:55:05 -0700 (PDT)
MIME-Version: 1.0
References: <20260623095551.2106712-1-berrange@redhat.com>
 <ajpoEoUcQ5IxMJy1@angien.pipo.sk>
 <ajpwIvZ9qfSgE-la@redhat.com> <ajpzlaz7kCKw0aPQ@redhat.com>
In-Reply-To: <ajpzlaz7kCKw0aPQ@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 23 Jun 2026 15:54:54 +0400
X-Gm-Features: AVVi8CcRmb01pDDA_tPQ2vFyoAmU7iL5aSdvYEj0zUorLp08gCEY6YFYcDEM6HE
Message-ID: <CAMxuvaxcc65N-6MWOzkXr9rXTeZ5DnvR8o4_2qjnW_EEVWEUhQ@mail.gmail.com>
Subject: Re: [PATCH v4 00/35] monitor: turn QMP and HMP into QOM objects
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Peter Krempa <pkrempa@redhat.com>, qemu-devel@nongnu.org, 
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Christian Brauner <brauner@kernel.org>, devel@lists.libvirt.org, 
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

On Tue, Jun 23, 2026 at 3:53=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
>
> On Tue, Jun 23, 2026 at 12:38:10PM +0100, Daniel P. Berrang=C3=A9 wrote:
> > On Tue, Jun 23, 2026 at 01:03:46PM +0200, Peter Krempa wrote:
> > > On Tue, Jun 23, 2026 at 10:55:16 +0100, Daniel P. Berrang=C3=A9 via D=
evel wrote:
> > > > Conceptually -object and object_add/object_del should be sufficient
> > > > for essentially all QEMU configuration....if only we ported all our
> > > > internal custom backends/devices/etc to QOM. That is of course a bi=
g
> > > > job which is why it hasn't happened.
> > > >
> > > > This series started with the premise that the monitor is one of the
> > > > easier areas to convert since we have no more than three classes,
> > > > a common base, and QMP and HMP subclasses[1]. So why not give it a
> > > > go and thus unlock the ability to dynamically create/delete monitor=
s
> > > > in QMP/HMP.
> > > >
> > > > This series does the conversion in a great many small steps to bett=
er
> > > > understand the implications at each stage.
> > > >
> > > > The high level outcome of this series is
> > > >
> > > >  * HMP and QMP monitors are QOM objects, 'monitor-hmp' and
> > > >    'monitor-qmp' respectively
> > > >
> > > >  * Both can be cold plugged and hot plugged. QMP only, can
> > > >    also be hot unplugged.
> > > >
> > > >  * '-mon' is obsolete, deprecated and replaced by '-object',
> > > >    but -monitor, -qmp and kept  as high level syntax sugar
> > >
> > > I was giving this a spin by implementing libvirt support for it. The
> > > basic usage seems to work well but I've encoutered a regression in
> > > behaviour which happens both when the QMP monitor is instantiated usi=
ng
> > > the new syntax but also the old one
> > > ( -mon chardev=3Dcharmonitor,id=3Dmonitor,mode=3Dcontrol)
> > >
> > > When libvirt wants to re-connect to a qemu running with these patches=
 it
> > > re-issues a 'qmp_capabilities' command after connecting.
> > >
> > > With these patches qemu does not respond to that command even when th=
e
> > > old syntax is used. This makes libvirt stuck when re-connecting to VM=
s.
> >
> > Oh that's odd, thanks for the warning. I'll investigate this.
>
> /face-palm - a misplaced a line in the auto-delete code, and did not
> have test coverage of re-opening a monitor. Try testing libvirt with
> this additional change on top
>
> diff --git a/monitor/qmp.c b/monitor/qmp.c
> index f6b7fe65bb..10d651ca5c 100644
> --- a/monitor/qmp.c
> +++ b/monitor/qmp.c
> @@ -613,7 +613,6 @@ static void monitor_qmp_event(void *opaque, QEMUChrEv=
ent event)
>          qobject_unref(data);
>          break;
>      case CHR_EVENT_CLOSED:
> -        mon->delete_pending =3D true;
>          /*
>           * Note: this is only useful when the output of the chardev
>           * backend is still open.  For example, when the backend is
> @@ -629,6 +628,7 @@ static void monitor_qmp_event(void *opaque, QEMUChrEv=
ent event)
>          case MONITOR_QMP_CLOSE_ACTION_NONE:
>              break; /* nada */
>          case MONITOR_QMP_CLOSE_ACTION_DELETE:
> +            mon->delete_pending =3D true;
>              /*
>               * Do NOT run in the AIO context associated with the
>               * monitor. We need to run in the default AIO context
>
>

Good, I just asked the same in my review :)

btw, you didn't collect my r-b from v3.

> With regards,
> Daniel
> --
> |: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
> |: https://libvirt.org          ~~          https://entangle-photo.org :|
> |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|
>


