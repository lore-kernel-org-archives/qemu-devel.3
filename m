Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B92CD13C30
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 15:20:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkOOZ-0004MW-0I; Mon, 26 Jan 2026 10:20:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vkOOT-0004Ln-0j
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 10:20:48 -0500
Received: from mail-qt1-x829.google.com ([2607:f8b0:4864:20::829])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vkOOR-0005yR-5M
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 10:20:44 -0500
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-5014db8e268so75479201cf.1
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 07:20:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769440841; cv=none;
 d=google.com; s=arc-20240605;
 b=Db5M8e4rCf3IWOUr8XMuclbCNSxSrlFcZjoLtIPpiYmnJX6iDX3Ur1mLOdLC62+EXC
 TRHJwijAW8T8iekapMv84IPVZ92ATSGQE9uaiUYaFQYkM55kka6IrchRTj5V4LoJ3GdE
 pXLCYeVefdfInad0u7xmFwbyfW3XHopJXacIPvM+/MsJCNABCSGSpjwAFEmrII54RaZ3
 jKAoHKscshk0LX31SRqyBPA/hvIpm8h43KMTsNO8V5KgPkdauEV0KQSqs2LRQXdzjtO+
 mhJMlRRhOFlRYI8788KGWqj88yfBOVSDWQJSIzYcAV8aqTmYd4go05XITZrOmANcigs2
 XZYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=n4aXoXhV1+Jkl0JeaP+K3SiKzpvUnjm/UfLBA8oksx4=;
 fh=2VgvMF2ooAgVnXNNeiBrt4AEnWrryPMyfOnPm0+DMKY=;
 b=MUEIkJ0lWwQvffYTUQtolaergSxNCTl2QywkRPhiQnzNO5KJ7U1x0IP9h0P4uge/GA
 GUFoVvJJnULwUNjL4Tt0Lwgr5rZraqgGCFMY9ga+/rgfnc9zZzoBAGlSkdmz84HTigoo
 +C1ONUGdq7yGZDZD+T8DTOdQC8lc5XLDc8Hjf5ctiiYOktJ3WlzYDahqe7QpLu7jFZIg
 kQNnGbGjv+xHQu/u6Rv18xXl0XJCW6PrzkF/Xn7TlPrz0SI3dwHtH8wTZwjntpc1u9Jq
 eaDVWbYFEV3D8WGKU4Z3U1wvPEDcopowOv97asTspeinHdh4ZBJ+PgJQaQ/hzfnqryTd
 494A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769440841; x=1770045641; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n4aXoXhV1+Jkl0JeaP+K3SiKzpvUnjm/UfLBA8oksx4=;
 b=cabYHrAzR0b3dTyhmE20GGRDyCVRzuMBBNG+3LvEktkNtyAOeio0fvPsgDyX5PN4w3
 Y0FRBCYqZp9rkKLuAHQRIYDHtdtQRO8bm+yZ0taBrD04yOS2gUhu69v/kZmVT1Lc8mVU
 M5X3q4SmajUu8zUoTziA6KHe18dGB+JadReIj7d7Kg4upd0/OOF/pZed2tS59IZPDfDJ
 Xrgp6WOeNsgokIMTYkG6cMaGzsUvXaZNVSoRnVB62+WkAXPtr+0ht4FDwNfTKE7zQHFT
 KoAj0OEAzph8iPadWqax2Nn5FuGD7ipXzacq1xZ+TFxSJoxEN8WBUrusu/SHtcWuZ09V
 5Qrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769440841; x=1770045641;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=n4aXoXhV1+Jkl0JeaP+K3SiKzpvUnjm/UfLBA8oksx4=;
 b=MJnf2uku2LkU6lf0RTxc0muhUZ5Fk9K0ATqfIVdLlhs4MHdrmq+Db7Apba7JzBNpPM
 4mJ85rjqf2DnsWh14qc6MfoJpg7rk+yIsNkTaFaLiwnMVIERChqfbRGgoUi5jtn7xSiU
 fCluqwSNWLk1r3ZwsiIGaTr8q4ACJvLhyJfmDpfVzIm+7HsMVZ1O+tZHdxEusVGiPF9V
 vxM8Aaw+iiPARgzs9oktrH731qLHlhymHq8i0XjYqcH4+FKKDJDkDkAJPWVvYK0Ns8pM
 2Hz+canHwbP79sDhp/EnVxBZM1mSrNpvqK04hKwR+MZanIDmUIUSow9aYpNvgA3DGI1n
 lrYA==
X-Gm-Message-State: AOJu0YyPQy1h/VnPJW2Xrv2Cz+yLEmZJHv2VYJmxI0cJg5iw96lA1u8E
 aEcCoK0pPD2zaq/AvmdkpkH63+lq8hvWMDdS1lSW9MvqSZMsD71odQBHc9fa0L0M5ug0nDE9Gml
 k0dsqvhEqww4VN+zIZnRhYEU8zDhZ+cI=
X-Gm-Gg: AZuq6aJDPLY6kSNDqAS3c5MP5iBJCTxZQONh5lJdpevgmJRAIa0+nMxZ7q3RIStc+fB
 5ZucCzsPUG/rzNVf3X9htOIsvss2MEfGjM+vfBhYJfkljGpd2QpCBQ9Fxl2M59xGIeqWzZ2QKo/
 0vTO1SaxEBC9/D6uRMW3c20r8SimQCxC+klj1JhCLxndGInegTOWst5/jG27YiCDldiMaDX2vDZ
 bUOxJhGSDVfbBtOT6sxOBsuHH9LPmpxq5KCaVGY9qaVj27+Vt6LmEYLsb+het28ubjWPyRpfstP
 zDv7+HlZmU2hPDYAOGAqyqkeN5c=
X-Received: by 2002:ac8:7d96:0:b0:4ee:60a6:ee03 with SMTP id
 d75a77b69052e-50314c3b9b6mr56475751cf.41.1769440840871; Mon, 26 Jan 2026
 07:20:40 -0800 (PST)
MIME-Version: 1.0
References: <20260106183620.2144309-1-marcandre.lureau@redhat.com>
 <aV41CQP0JODTdRqy@redhat.com> <87qzrzku9z.fsf@pond.sub.org>
 <aWDMU7WOlGIdNush@redhat.com> <87jyxrksug.fsf@pond.sub.org>
 <aWDTXvXxPRj2fs2b@redhat.com> <87cy3jkrj8.fsf@pond.sub.org>
 <aWDatqLQYBV9fznm@redhat.com> <871pjzkm4y.fsf@pond.sub.org>
In-Reply-To: <871pjzkm4y.fsf@pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 26 Jan 2026 19:20:29 +0400
X-Gm-Features: AZwV_QiWDJZzB7DvgpJJkKN3Qa8Yby82KkUTkKUZVgpA8IHUW9I7VV_iHDCLVV0
Message-ID: <CAJ+F1CLR4wt-bA+V+oV6N4iKTK_=Hn8TSD0pP7Uwj=jWHWvZRA@mail.gmail.com>
Subject: Re: [PATCH] Add query-tdx-capabilities
To: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, 
 "open list:X86 KVM CPUs" <kvm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::829;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x829.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Fri, Jan 9, 2026 at 4:27=E2=80=AFPM Markus Armbruster <armbru@redhat.com=
> wrote:
>
> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>
> > On Fri, Jan 09, 2026 at 11:29:47AM +0100, Markus Armbruster wrote:
> >> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
> >>
> >> > On Fri, Jan 09, 2026 at 11:01:27AM +0100, Markus Armbruster wrote:
> >> >> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
> >> >>
> >> >> > On Fri, Jan 09, 2026 at 10:30:32AM +0100, Markus Armbruster wrote=
:
> >> >> >> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
> >> >> >>
> >> >> >> > On Tue, Jan 06, 2026 at 10:36:20PM +0400, marcandre.lureau@red=
hat.com wrote:
> >> >> >> >> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >> >> >> >>
> >> >> >> >> Return an empty TdxCapability struct, for extensibility and m=
atching
> >> >> >> >> query-sev-capabilities return type.
> >> >> >> >>
> >> >> >> >> Fixes: https://issues.redhat.com/browse/RHEL-129674
> >> >> >> >> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redha=
t.com>
> >> >>
> >> >> [...]
> >> >>
> >> >> >> > This matches the conceptual design used with query-sev-capabil=
ities,
> >> >> >> > where the lack of SEV support has to be inferred from the comm=
and
> >> >> >> > returning "GenericError".
> >> >> >>
> >> >> >> Such guesswork is brittle.  An interface requiring it is flawed,=
 and
> >> >> >> should be improved.
> >> >> >>
> >> >> >> Our SEV interface doesn't actually require it: query-sev tells y=
ou
> >> >> >> whether we have SEV.  Just run that first.
> >> >> >
> >> >> > Actually these commands are intended for different use cases.
> >> >> >
> >> >> > "query-sev" only returns info if you have launched qemu with
> >> >> >
> >> >> >   $QEMU -object sev-guest,id=3Dcgs0  -machine confidential-guest-=
support=3Dcgs0
> >> >> >
> >> >> > The goal of "query-sev-capabilities" is to allow you to determine
> >> >> > if the combination of host+kvm+qemu are capable of running a gues=
t
> >> >> > with "sev-guest".
> >> >> >
> >> >> > IOW, query-sev-capabilities alone is what you want/need in order
> >> >> > to probe host features.
> >> >> >
> >> >> > query-sev is for examining running guest configuration
> >> >>
> >> >> The doc comments fail to explain this.  Needs fixing.
> >> >>
> >> >> Do management applications need to know more than "this combination=
 of
> >> >> host + KVM + QEMU can do SEV, yes / no?
> >> >>
> >> >> If yes, what do they need?  "No" split up into serval "No, because =
X"?
> >> >
> >> > When libvirt runs  query-sev-capabilities it does not care about the
> >> > reason for it being unsupported.   Any "GenericError" is considered
> >> > to mark the lack of host support, and no fine grained checks are
> >> > performed on the err msg.
> >> >
> >> > If query-sev-capabilities succeeds (indicating SEV is supported), th=
en
> >> > all the returned info is exposed to mgmt apps in the libvirt domain
> >> > capabilities XML document.
> >>
> >> So query-sev-capabilities is good enough as is?
> >
> > IIUC, essentially all QEMU errors that could possibly be seen with
> > query-sev-capabilities are "GenericError" these days, except for
> > the small possibility of "CommandNotFound".
> >
> > The two scenarios with lack of SEV support are covered by GenericError
> > but I'm concerned that other things that should be considered fatal
> > will also fall under GenericError.
> >
> > eg take a look at qmp_dispatch() and see countless places where we can
> > return GenericError which ought to be treated as fatal by callers.
> >
> > IMHO  "SEV not supported" is not conceptually an error, it is an
> > expected informational result of query-sev-capabilities, and thus
> > shouldn't be using the QMP error object, it should have been a
> > boolean result field.
>
> I agree that errors should be used only for "abnormal" outcomes, not for
> the "no" answer to a simple question like "is SEV available, and if yes,
> what are its capabilities?"
>
> I further agree that encoding "no" as GenericError runs the risk of
> conflating "no" with other errors.  Since query-sev itself can fail just
> one way, these can only come from the QMP core.  For the core's syntax
> and type errors, the risk is only theoretical: just don't do that.
> Errors triggered by state, like the one in qmp_command_available(), are
> a bit more worrying.  I think they're easy enough to avoid if you're
> aware, but "if you're aware" is admittedly rittle.
>
> Anyway, that's what we have.  Badly designed, but it seems to be
> workable.
>
> Is the bad enough to justify revising the interface?  I can't see how to
> do that compatibly.
>
> Is it bad enough to justify new interfaces for similar things to be
> dissimilar?
>

Maybe query-{sev,tdx,*}-capabilities should only be called when the
host is actually capable, thus throwing an Error is fine.

What about a new "query-confidential-guest-supports" command that
checks the host capability and returns ["sev", "tdx", "pef"...] then ?

Or maybe this should be provided at the MachineInfo level instead
(query-machines).

--=20
Marc-Andr=C3=A9 Lureau

