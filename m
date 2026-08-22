Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BD74C5DF97
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2026 20:16:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxs88-0002WQ-GR; Sat, 22 Aug 2026 16:15:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wxs84-0002WI-Bc
 for qemu-devel@nongnu.org; Sat, 22 Aug 2026 16:15:48 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wxs82-0004aJ-Hy
 for qemu-devel@nongnu.org; Sat, 22 Aug 2026 16:15:47 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-c197eaaab00so347699366b.0
 for <qemu-devel@nongnu.org>; Sat, 22 Aug 2026 13:15:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787429743; cv=none;
 d=google.com; s=arc-20260327;
 b=ZnP958GrBBaa8C83ctX8aRKZIgG5vkH0bEgJ2bBgwxPsnfYdVlL3duIMT/1NpWq1yo
 faibGGQeT/VJcjhkmzPAHQdRGxF8K6HHWPpm5KG0vifeTBCram4I6M7SlPkra3c4qLMt
 0NXYrBoy6OVADF4cIB2aaHN9MJndKE56fAgInrim3Z5dvZRdsLkVbqYhUPJK2cMNCerM
 pZJs3efTkApTu1LcBNz69v1hJq3D20F+PF3+vJpYC5GINzfJYKUPdX99wYpiDbkr534W
 cAc/eSDn7q4YfMJDg7cCcxoguDsoPVXenRnyNKHb48SBBcP9wnkXuhm8n4qAZRp4ZC3P
 63mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=tXfslKLhvBWZ2ZSDWUgApc3F6sNN5bHnqfFqebD475w=;
 fh=oR6KT4T9R4DzEe393lAnUFWLAI2XD1MXqDS3E+1BJZc=;
 b=o1nGW0ePA9w0zPlU1nYFsHQq1N+1O6HA2IHUOemM3EV4hf0+JjZZxsZcQy0D4t7neh
 +ZPRoX8TssAx6MdNsavaAw7oEeGBo9KC4Houc1EwLHNcSviF5A60km5N81Aobcfnsdlm
 kFAOv5wkhjMf+PCONJ0QW4qfdUZabEnDXvGGpVx0kNrU+Br6SQiAne30r+jll4boHi9w
 LO+OSiZeHpM2OrJbxjADsRSnQT7vIOMylBe7aCMxUP+1jKDIT5sjrq3kba2/h0QkitKU
 0SQ6pHPlmMYlrE5gMTviD37hdjl5AUXuI1rggo0uS7FZjf9GR/3NdqDVxmuFSUr5NijG
 4O9w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787429743; x=1788034543; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=tXfslKLhvBWZ2ZSDWUgApc3F6sNN5bHnqfFqebD475w=;
 b=WPkXYr6jtVw330+TV5a94dfiyI/Mt62WSfv+J9RYyNpF2EK7yy7VToB2ryeIMsrWz6
 KG1si30aaCOujU0QaWhnjAeQV9xaLLNY2fEaW3pl/4H/t6bNLwCyIlo9xX3IEH8xT1ZK
 Ej6wdleV5BEZDS0N7D8Pfy8Buv1Bnzh5x/R9CgUPCDGdfEasevPf/ZcOMA25OMctu7Uw
 C0UCz60FAcYxihf81LOQdAwohrdnFU6cz8d9Mk9Isz3sDLpXW6NOeLeiJYQRl3u2Zdz0
 tMg6qaUIO4zhoPly8RKGNSYOp+W3uO4cw5vB0w6chdVrVf/1150MWNVIzu+EYf285HPo
 RWmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787429743; x=1788034543;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tXfslKLhvBWZ2ZSDWUgApc3F6sNN5bHnqfFqebD475w=;
 b=FDAmu2NaY1ZsXrMsgJk8NZBzWSv+LzWxJXvDMre2tfwRDu3jbjKA6Fa3XRdZrKjuzJ
 dwOgMMoKV6ji8qUBaOuytTCa8U5RWBseolx92+XZitpmZLX6bgALED4Hs8K+OWj37ZfL
 GmjvoFsoEywvQEAVBcRgWDszNKBIQKfL8svmGxCHyjSfMs1YDlVS8VdIJXwKewa9yUrW
 xGMyHy9GzWETcELC/KIVP2Ub3ZBxnuFYzigoeQgZxsRe9VSyb+3g9jHscKQFvc3QOyWZ
 FXiCR4eOIfweqOdD+teu90eDfsUmvuGXnRo4QRsJESoiaXs2tr5U3TiNfni11OZyvBhj
 2dFA==
X-Gm-Message-State: AFuF++k/W+HF6zPQvbNT7Ko4meGCKrlj6RHAJMs0zlYTL9uDSmc7d1cN
 kFN7utDtFIcO6zpfu8sEMN6q1LsVjDCYeAZMncvdphrCbwaQbEYrdzO06ARsb2e4eAsFD1fjelc
 PuXqNrHqwtGuJ4OGIUFC9yd7w/CJV/Tw=
X-Gm-Gg: AR+sD13hjetkdRseCACIvXRe/QrAdYCq9e7sW1UqZdauDPPLkckWuoRCiwpPjxbRxdZ
 B04865HTRbpraOCqjyoQRmNI3qPpHeCbmW7TCDUf1PLZ14xUcn80DDWuk8Cch3VHVx5a49C/i5B
 tILWdmE1jsrK7k58OBgWnR1B0Rs33UJGOEPVGheX04cbHABol1uiGWncXftPfNS9FNZhcQRrYWp
 KrIOyef20oybcQ2FFbNPqL5rw3qESf5vgLVI/h0kcfpI8GxJHGpWqfSsEBdabitheeTYxvdFyvR
 41vlc2UQwmMDoN3X9y06jyf1BTT6574LSyqHTXm3WxUR
X-Received: by 2002:a17:906:9f8b:b0:c1f:c061:569a with SMTP id
 a640c23a62f3a-c246a4c6d63mr1470929566b.7.1787429743053; Sat, 22 Aug 2026
 13:15:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260814174830.1691540-1-zhangckid@gmail.com>
 <20260814174830.1691540-7-zhangckid@gmail.com>
 <20260819191217.GE222512@fedora>
In-Reply-To: <20260819191217.GE222512@fedora>
From: Zhang Chen <zhangckid@gmail.com>
Date: Sun, 23 Aug 2026 04:14:41 +0800
X-Gm-Features: AcwNN1V7C2KNx885fi8WWovGVjM80FYN74u_7nhkcXFCcyIv8ectkqhNDGEvjsg
Message-ID: <CAK3tnvJYgzO32QYD1p8DhuYDkeeFAn9mpk+RQbikBi=1WAmeNQ@mail.gmail.com>
Subject: Re: [PATCH V12 06/15] monitor: track IOThread users with QOM paths
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Jason Wang <jasowangio@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=zhangckid@gmail.com; helo=mail-ej1-x62a.google.com
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

On Thu, Aug 20, 2026 at 3:12=E2=80=AFAM Stefan Hajnoczi <stefanha@redhat.co=
m> wrote:
>
> On Sat, Aug 15, 2026 at 01:48:20AM +0800, Zhang Chen wrote:
> > @@ -668,6 +668,17 @@ void monitor_cleanup(void)
> >          qemu_mutex_unlock(&monitor_lock);
> >          monitor_flush(mon);
> >          qemu_mutex_lock(&monitor_lock);
> > +
> > +        if (monitor_requires_iothread(mon)) {
> > +            g_autofree char *path =3D object_get_canonical_path(OBJECT=
(mon));
> > +            const IOThreadHolder io_holder =3D {
> > +                .type =3D IO_THREAD_HOLDER_KIND_QOM_OBJECT,
> > +                .u.qom_object.qom_path =3D path,
> > +            };
> > +
> > +            iothread_unref_and_put_aio_context(mon_iothread, &io_holde=
r);
> > +            mon->ctx =3D NULL;
> > +        }
>
> Is it possible to move this to monitor_finalize() so it's guaranteed to
> run when a Monitor object is deleted with object_unparent()? That would
> avoid the code duplication in monitor_qmp_prepare_delete().
>
> One complication is that object_get_canonical_path() may not work inside
> monitor_finalize(), so it may be necessary to store the IOThreadHolder
> or at least the qom_path in Monitor.

Yes. Since the canonical path is no longer available in monitor_finalize(),
I=E2=80=99ll move the cleanup to the Monitor=E2=80=99s ObjectClass::unparen=
t callback instead.
It runs before the object is detached, avoids storing the path, and removes=
 the
duplication in monitor_cleanup() and monitor_qmp_prepare_delete().

Thanks
Chen

