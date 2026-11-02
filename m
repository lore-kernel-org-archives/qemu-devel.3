Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED316606A326
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 11:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QGIijm3N;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=bzwX5pFQ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNq4W-000728-Rj; Mon, 02 Nov 2026 06:19:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1xNq4T-00071d-M6
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 06:19:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1xNq4R-00030i-7Z
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 06:19:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793618361;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ah+WpKYvkXPp8UCvFsZ+hV5CREW7lSVfg/8FMQmg24M=;
 b=QGIijm3NnfK+smJNu1RiwS4yQwU0OJanjdBP96/DxmZgBNlwT1P72yfz4TtaH7sg5YvA2Q
 UZ20JhtaxK89lhWhv4hjFpzZvFuh1DVtq6fmMziWLfDfqKjG9fYAKZIB3Iqd8m3E4d5nMk
 WRgGLm5PSR0o6XbIsHgCXe8/LSGUX1w=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-215-gtRAMa5wMpat-zupYr__FA-1; Mon, 02 Nov 2026 06:19:19 -0500
X-MC-Unique: gtRAMa5wMpat-zupYr__FA-1
X-Mimecast-MFC-AGG-ID: gtRAMa5wMpat-zupYr__FA_1793618359
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3ae7faf4ff7so4033244a91.3
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2026 03:19:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793618359; cv=none;
 d=google.com; s=arc-20260327;
 b=Piswco/tU3Jg0MuBHZE67m21AZVga7azUaEFB+kU06jWSnOTpNP/grvIp/LkG2sdXi
 UhbJVoavmEdQw3TH9fm7v5wu/th/eSRc7CHVIEX8yKMl04R+nyQy+0FWn6i4C5ZgkKfL
 7PHTb0saDOfzAzAHi6j9/ZQ589jR+HkT5RsJus0Lyrj8fsfuN0KN6p3jxylTxpYdLLrC
 0Om6bJHk3lDEXz9KfyK4O3eHBunyvUodddMe5WffWkhcgWGcZd2Yy8q42gIaufdkgspy
 OZWnzx9cJa/sryys/qL/SE8uE6W6ggpbIipi2CazFrupdMOZpWkRl4MQ1FyM27Z9Rkkg
 pYFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Ah+WpKYvkXPp8UCvFsZ+hV5CREW7lSVfg/8FMQmg24M=;
 fh=zOT1kvACi2WkeAzl60r00J4rhcyGvXhcNQxmgCxdCLs=;
 b=p0wadmv3Bmd1nj08YUxP3abYtLh9X0N/YI88lFcr0l2/M0K4w618iA57GnyYM7wN0E
 Q0TajKDFEhU1DiU7Be2IKJ8Axj26BaB5vtflTvbKU2RcB631wyUcv11J+vXjV5JaSWdQ
 hxZkt1DU2VnanXsisuxIhTsCJq77CqaFxLtFi7QCYbGr3a0aosz7QuJXjdg0a1ynjeDm
 2WUcZHJ6VwffWFOiPkVG5QItvvAh/omNWIEH/Wj5fP6V68daU9osF+4GmuygW6PpbkLh
 g9TT7/Ong4DJ+0CFIuzfk/vHteUK+XvRELVbDsvNm0BzPnVQnm4Ob+XnrXjCygwy56OF
 CqaQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793618359; x=1794223159; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Ah+WpKYvkXPp8UCvFsZ+hV5CREW7lSVfg/8FMQmg24M=;
 b=bzwX5pFQ8UcD6cDFYP+KU44GjCZjLwai4yBXVzCljqra6HH4GgBH8gWxZc3f/ASo2d
 xv0+pqDXluQayWJPZDUFpAIxPDisizYropZbx8yhqZYxSyoKkLgafsxA949Q4YLLFKtz
 c934gox8YJJtiJkNIDaUKsBQCYvu+o0qpp3afRdnfzZF1jsr0Z9Bqv7AJbPaEnMLssn4
 iUZXBH7WbwhGQaGdfGM4TOabDoeFRxMa7j2RbNHgExeKjBeSgcskbjhaa8MOQX1/YGwa
 2YIJax8DtHEKkf5Undv6TIctmZPxxxH+zO5zJow+whc9rEJCnd4bgjKTFwmjfD4b/NtV
 NnQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793618359; x=1794223159;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Ah+WpKYvkXPp8UCvFsZ+hV5CREW7lSVfg/8FMQmg24M=;
 b=HqgMnG3Wx2VcHxe0dTRbKFAmfJA3b5Utmb/DzFPbMVornVtzrroA8Qa+g10r8sH5Y2
 tUTxNm8Sy/hW/4NCrdPdTFDOjKQzZ6iPuVsrmdxJrl4XDcucAah3vbbw5iR93/8q6hHL
 ff877XIKDs3d9IB/7YVFSwLN3EVphTKaIOaxLRBp1/tjBv55jldTTCQmsAvPkNdXLwcI
 qwxMoamaAJR+ssNtDXGe6jtAFN1IE5NmVMBuDMuSabPWD+zGDoIxnVc6K2gXFAz4hJh4
 8mfjqKfBbBekWkNd+8P1sD272TB9DSYic4Ad9Kt4lYGK+4/ZXf22rKd4jm3KzNAG2dnK
 JizQ==
X-Gm-Message-State: APuU4Z+OqCNe7bMwZpKEDMHD4wEwzOLA/Gh0J3AKyuoBDtEelKk33fft
 +lyi0nGBY8bT3AO8uQlW1W5s0Gam/FETRdfBeOEF82BjjLuRhIMBPH70swA1RYcurHhPkC0I60C
 X+VFi/ThsWIovZzfkg973xfERve01QuPqePox40ZW+yv9KbIQ6usD5fmFLYuLyV0ELUBC036/av
 KXPBSNC/zgYEcngFr4qVfiafqyVYuKsJk=
X-Gm-Gg: AYBFou2juZS8Fk40D9OgHyd3aQuiAIxwuwk2rf0fjQk4OHFruR8qvU1KjGY906dMwRZ
 A0H5I6J3dgOUEEhlxB3H1H3BGDA1uH+VlHlDIeD0BIwzAM0E5RnHz+VVNGAXgVYIlxSEWJd0K1i
 73t/lbfH7WKLRqlpwj0K7RdaIJ9sKohd+XZNGcn7m61sS3eIMkim+33rcPk/Vrmtlg+rPagihA/
 fTJqKf3Ww4BHnJyhX/u/2EuGoH1oWZPOfBPeK0/KF0+R+WPyuAHIVf76gjrP91rduOuSDwJzh/1
 Ow==
X-Received: by 2002:a17:90b:2549:b0:3ac:4e18:238e with SMTP id
 98e67ed59e1d1-3ae89847e94mr7383838a91.46.1793618358604; 
 Mon, 02 Nov 2026 03:19:18 -0800 (PST)
X-Received: by 2002:a17:90b:2549:b0:3ac:4e18:238e with SMTP id
 98e67ed59e1d1-3ae89847e94mr7383820a91.46.1793618358115; Mon, 02 Nov 2026
 03:19:18 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261030141442.264308-1-lucas.kornicki@nutanix.com>
 <20261030141442.264308-3-lucas.kornicki@nutanix.com>
 <179343138750.2067999.4231298981143140799.b4-review@b4>
 <2f95e624-974b-46e1-9d00-490a3e690534@nutanix.com>
In-Reply-To: <2f95e624-974b-46e1-9d00-490a3e690534@nutanix.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 2 Nov 2026 15:19:06 +0400
X-Gm-Features: AclHuK9ttY_tarVtOMY5GRSoIVtfoZNjFTSyRd-mTt3spgkvHmJeh7aqF3UuTLg
Message-ID: <CAMxuvaw-0hxv7+e6XFQACKS1D5TUbDSyawN=SW9gdbqZUZJtkQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] ui/clipboard: keep track of clipboard peer side
To: Lucas Kornicki <lucas.kornicki@nutanix.com>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 2, 2026 at 2:11=E2=80=AFPM Lucas Kornicki
<lucas.kornicki@nutanix.com> wrote:
>
>
> On 10/31/26 08:23, marcandre.lureau@redhat.com wrote:
> >> Add a "guest" flag to QemuClipboardPeer and set it on vdagent peer.
> >>
> >> Use the flag to keep track of number of registered guest peers and
> >> allow to query for their presence with
> >> qemu_clipboard_guest_peer_present().
> >>
> >> This change makes it possible for a clipboard peer to determine if
> >> any guest side peers are present so they can tell whether a guest is
> >> actually able to participate in clipboard exchange.
> >>
> >> Signed-off-by: Lukasz Kornicki <lucas.kornicki@nutanix.com>
> >> Message-ID: <20261030141442.264308-3-lucas.kornicki@nutanix.com>
> >> ---
> >>   include/ui/clipboard.h |  9 +++++++++
> >>   ui/clipboard.c         | 17 +++++++++++++++++
> >>   ui/vdagent.c           |  1 +
> >>   3 files changed, 27 insertions(+)
> >>
> >> diff --git a/include/ui/clipboard.h b/include/ui/clipboard.h
> >> index 6166af513906..250f1d8ea53e 100644
> >> --- a/include/ui/clipboard.h
> >> +++ b/include/ui/clipboard.h
> >> @@ -62,6 +62,7 @@ enum QemuClipboardSelection {
> >>    * struct QemuClipboardPeer
> >>    *
> >>    * @name: peer name.
> >> + * @guest: is peer guest side.
> >>    * @notifier: notifier for clipboard updates.
> >>    * @request: callback for clipboard data requests.
> >>    *
> >> @@ -69,6 +70,7 @@ enum QemuClipboardSelection {
> >>    */
> >>   struct QemuClipboardPeer {
> >>       const char *name;
> >> +    bool guest;
> >>       Notifier notifier;
> >>       void (*request)(QemuClipboardInfo *info,
> >>                       QemuClipboardType type);
> >> @@ -179,6 +181,13 @@ void qemu_clipboard_peer_register(QemuClipboardPe=
er *peer);
> >>    */
> >>   void qemu_clipboard_peer_unregister(QemuClipboardPeer *peer);
> >>
> >> +/**
> >> + * qemu_clipboard_guest_peer_present
> >> + *
> >> + * Return TRUE if a guest side clipboard peer is currently registered=
.
> >> + */
> >> +bool qemu_clipboard_guest_peer_present(void);
> >> +
> >>   /**
> >>    * qemu_clipboard_peer_owns
> >>    *
> >> diff --git a/ui/clipboard.c b/ui/clipboard.c
> >> index 3d8f58a85508..f750b494eb6b 100644
> >> --- a/ui/clipboard.c
> >> +++ b/ui/clipboard.c
> >> @@ -12,6 +12,8 @@ static VMChangeStateEntry *cb_change_state_entry =3D=
 NULL;
> >>
> >>   static bool cb_reset_serial_on_resume =3D false;
> >>
> >> +static int guest_peer_count;
> > Rather than adding an extra global (that must be sync), why not simply
> > iterate the clipboard_notifiers?
> >
> > Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> Good question. I wasn't positive if it was thread safe to walk the list
> at the time,
> hence going with a global counter felt like a safer bet since there are
> others like it.
>
> It looks like this is not an issue and cost of recomputing seems reasonab=
le.
> Since the series was pulled, should I send in a separate patch fixing thi=
s?

yes, should be acceptable as minor fix during rc, otherwise I will
just queue it for later
thanks


