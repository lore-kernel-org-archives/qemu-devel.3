Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D0B2F9B5E2
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 08:32:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFT0T-0002ZT-0d; Wed, 22 Apr 2026 04:32:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1wFT0O-0002ZD-B0
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 04:32:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1wFT0M-0000pY-H1
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 04:32:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776846737;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PxKwaNqrEh393Tj7dL4S1gttLHd8KClU8otwT0STlh4=;
 b=XnvhTqSyUJAZ1opoa0MQ187YWnujXNfBEQ7Y2h4i68cuZqDEQZYBpJCGnWeQvABAqY7YjY
 WgUPKZtlqbn84dOJTfp5R/67zLqk8CqCyfl+gpwlGRaim+MlgkFRh00QVqwckdAr7EwYRj
 0Igl5NucYcMqEKgqq+KD1FxpEOXrMDY=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-257-lwTczGVFMOajMDNRL69ZOQ-1; Wed, 22 Apr 2026 04:32:15 -0400
X-MC-Unique: lwTczGVFMOajMDNRL69ZOQ-1
X-Mimecast-MFC-AGG-ID: lwTczGVFMOajMDNRL69ZOQ_1776846734
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2b2e91add2aso44809765ad.1
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 01:32:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776846734; cv=none;
 d=google.com; s=arc-20240605;
 b=MIdYYluVO2Ro5JgKMKECH98LloOFF84aoc2s0379DGqVW9pgmRiI+SaWxQ54P+wtKY
 IKFT6/9nhDE4cmEpsm2oI5gZiXciKsqvglSlJPEJ1NtfbcAJQbLH5NCW8Eor1/+GD1Jf
 LkdVGr3OB60AwpX5I3jI5C9K0vOA4pD07GuSF+IV8aLUasvfWR4FNgC7OmXaXKS1fkun
 chH8s7MLpiSNhI4bw5RdduWhTFWD0PFOE3eZaZgKwfze1UrLmxpOcx5ZU0EnxLeAUZtu
 DK1EZ7hB42X7NJNOceu4fA4yaaSXnmhhvfU6tzqpNr+NVQxrzBwFTgRXq1ZBVnEuXaKz
 EGzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=PxKwaNqrEh393Tj7dL4S1gttLHd8KClU8otwT0STlh4=;
 fh=Kc3jHB0kH2xiC7VCtY5bLngO+5IU5SjJ5VxIVZXufgg=;
 b=hCWOzhVYw34Hxs/Xo4S8wW0en+gwl5yCc0+DjxofpIBkgh517RnC3WBmud09I7cpqD
 wkkhdCsWXoEpv39kKBtMJ/iWQTwfdc9/OC5smHMfE1rXg+bNZ6IA05Yk0Uy19Loyyx9H
 grRB5Bom+euFTleqVCi4M3SxZuyiMxuKYOABmMkcO1gWRjy9DUEZJ2+atBVzr+T4S8cO
 XB35b/fmTFmcGhLtZXq3KvTfcOtxI2ou8GRQbWGgfm/7UBKVAQ8w5ukXyNXsayzLYLXJ
 rHF7cnlElpAQ6VYxMFmRA6+0l0hu5OQfk2nip2tuYF4HqwpAHRCBJs3Z97eDrKVRjdgn
 3ZFg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776846734; x=1777451534; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PxKwaNqrEh393Tj7dL4S1gttLHd8KClU8otwT0STlh4=;
 b=RwHi1pLhv0PWupNs63Q1wGq8XLWvpm9gfJLpPxrHBhind+P3oxnL4u6py6rCMX4WeW
 2PPm6wmNIn+28BK5OvdxRnUHGkkahQcbwwvirf7kJue6FXE7ENGPb5E1PeD6WhGgbmWx
 REFgSY8R3FD4QGLmc9QfuR0LQElldbfP8GEnVIy1V6aWcV1DEyRbQq5CEe3Bql7oGgir
 oFC0UU3AmZTKFyOK8mb9/v1quDfHoOHMjWc5OnjzdR3806pr8+XlCM4YnSG6gld3GVZA
 oEyL8cMvUPDWTsnlz/b6Q6dcv/kqdW4hmdyxqN1ZwktaNMVeOrrOWv+xbwz3KKlEG3Jr
 St1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776846734; x=1777451534;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PxKwaNqrEh393Tj7dL4S1gttLHd8KClU8otwT0STlh4=;
 b=eY1uXzXIy27eTXirwkedEgSaaydLeipb3aNk4b6QVrQI1cg56flDzaaKL9Jpwfg9Y9
 uA3m9jXx/29d0B6DiGkOHwzkVFHZt24wmwshFID9k3jPPf6/CalEaL316UcG5h8M3h8G
 IUwdgeGT4M1QRTAjqrPiZkvsLXpZsnan4VpkVsXUT4ZOUWTpDyp8LcDOtlW45LqGaKnc
 Hz9hQWgMlHnLc+ZPMApiOo4TVZp2I9kGBCng4dsPgPsIIiL3IVeUGzQXfoJ30fI/N2kY
 Rx7Vlj/VfzX8VDr+bT3Qyh983tme/PhGqtNc/uNM63e8ZYOYhXwcqXOzECyXnbOB/kip
 guAg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/hIzsPYrDMV2nL2A/te21oeudRUDGufzEaQgXLgH2g3T7gwqnYZCaJ8Hgzlap9XQWQc3/APnM5rYFJ@nongnu.org
X-Gm-Message-State: AOJu0YxpY/mg2+4ZFHaZRqyCXA3QzWKgIHx2Ggn0iXLG0n4p/UCEBhjA
 iOfNFuWiEKlE3nMF6reRwRKd6GLH+ExeElHkzIf1cz7FMJI4z1X3fKRYB2HDi7BVAgNaYqCHP2v
 P0K20HillPpzSv8o7xAJvTJlaYF3b4dNWGf/o4pU4rBYB74jdVD7yOeMM4T7XHRDRF7s/mJbpf6
 ok+n+H0oXYcbJN7T++RxpDSxWwBJJxflg=
X-Gm-Gg: AeBDiesCW4cp/U0brAf3ouwbTXptMKkTY83lNoFDXyyFebigOSuD6niaCOTxXaNE6sS
 mU1AMvyTRExntF08+2rvXZ5uHSY+rxBuLHFfejWcNYP1RBxoYPlYaetkCd9aeHfzKdL3kB8lKt2
 VxLVnUvGCqSY7EOaT0eiJT1dhRcyd+m+sVz0dmIuwU+NgxjGye1vIimtR0B/ohoeYadfrAUMtds
 KXIUA+48rDoOJo=
X-Received: by 2002:a17:903:17c3:b0:2b0:708f:4dc7 with SMTP id
 d9443c01a7336-2b5f9f3b367mr240065325ad.29.1776846734265; 
 Wed, 22 Apr 2026 01:32:14 -0700 (PDT)
X-Received: by 2002:a17:903:17c3:b0:2b0:708f:4dc7 with SMTP id
 d9443c01a7336-2b5f9f3b367mr240064935ad.29.1776846733708; Wed, 22 Apr 2026
 01:32:13 -0700 (PDT)
MIME-Version: 1.0
References: <20260411021205.3592118-1-jemoreira@google.com>
 <aeYvCK2qhZd1W9sA@sgarzare-redhat> <20260420181818.GC405461@fedora>
 <CAJi--PPzd_fqcsBU-aA11624apoKTtEW6GTKE3_OyZ4SJ90DzA@mail.gmail.com>
 <20260421211237.GC466778@fedora>
 <CAJi--PP6gsR5E7RtQ_RwV8fG9Xivk0fXTfNxWuZ6cX+uWBPV=A@mail.gmail.com>
In-Reply-To: <CAJi--PP6gsR5E7RtQ_RwV8fG9Xivk0fXTfNxWuZ6cX+uWBPV=A@mail.gmail.com>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Wed, 22 Apr 2026 10:32:02 +0200
X-Gm-Features: AQROBzAlqZstQ47EXu0KpQ8x73fA_LCINtIPKZKYNB13HB9DtYG53fQhA7ncM5g
Message-ID: <CAGxU2F7UJhbikjFKMgMcFenFx35vmic-hj4pFm7vM0-gk-nCyg@mail.gmail.com>
Subject: Re: [PATCH] vhost-user.rst: Explicitly allow front-end to write to
 kick FDs
To: Jorge Moreira <jemoreira@google.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, hreitz@redhat.com,
 gmaglione@redhat.com, 
 "Michael S . Tsirkin" <mst@redhat.com>, Hanna Czenczek <xanclic@gmail.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, 22 Apr 2026 at 03:16, Jorge Moreira <jemoreira@google.com> wrote:
>
> On Tue, Apr 21, 2026 at 2:12=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat.=
com> wrote:
> >
> > On Mon, Apr 20, 2026 at 05:48:13PM -0700, Jorge Moreira wrote:
> > > While starting the vrings on SET_VRING_KICK could solve the state
> > > machine issue, it still won't notify the back-end that buffers are
> > > ready (the driver won't do this). Non-polling back-ends depend on thi=
s
> > > kick, especially for queues where data flows only from the driver to
> > > the back-end. Most implementations likely attempt to read from the
> > > queue only after receiving the kick.
> >
> > This is an interesting question to clarify in the spec.

Yep, which is in part related to what I wrote in the other reply:
"I think the main issue to clarify is what the device should do
when the vrings are configured, but the driver has already been
initialized (which is usually the case after migration)."

> >
> > Stefan
>
> This is the question that interests me most, to be honest. I'd rather
> have the discussion about when to activate the vrings in a different
> thread and keep this one focused on whether the front-end should send
> the kick or if the back-end is expected to check if there are "new"
> buffers in the vring after restore.
>

IMO we don't need anything from the VMM. When the device receives
SET_VRING_KICK, it can check if the vring already contains buffers
(and this is the part we might need to clarify) and wake-up the other
threads (or always wake-ups them, as crosvm does IIUC, and let them
perform this check).
After sending the SET_VRING_KICK message to the device, the VMM has
the exact same knowledge of the vring state as the device, therefore,
it's still unclear to me why we need to inject that kick.

Stefano


