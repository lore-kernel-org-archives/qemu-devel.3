Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70F3CC5B542
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 06:28:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJRJ5-0004oR-2r; Mon, 26 May 2025 02:27:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uJRIz-0004o9-Ds
 for qemu-devel@nongnu.org; Mon, 26 May 2025 02:27:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uJRIx-00009O-1F
 for qemu-devel@nongnu.org; Mon, 26 May 2025 02:27:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748240839;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OIo4DgUU8ilOdeGOoDXvQt58SEkyb9AXEDymqht9a7M=;
 b=GO2f3X7wjSPDLlgPFpcLQ647/wSl5t3+fJaKBiPo1rnqy6nY/sXpRpWeWm2jVr/xsNAsxy
 DVsobuZ5nCh6zGUDnRujpKHzHgHcDUONgRnfLN4wW66a33/ZYG8WWpInPs4TP4zePdCaYm
 pCXDCiCbpp7kaIgvlD7/smUyKDiXL4g=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-36-anRTHdJGN6SyrckBtuPLWQ-1; Mon,
 26 May 2025 02:27:15 -0400
X-MC-Unique: anRTHdJGN6SyrckBtuPLWQ-1
X-Mimecast-MFC-AGG-ID: anRTHdJGN6SyrckBtuPLWQ_1748240834
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F41691800446; Mon, 26 May 2025 06:27:13 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.2])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4436E1800361; Mon, 26 May 2025 06:27:13 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C74BD21E66C3; Mon, 26 May 2025 08:27:10 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org,  stefanha@redhat.com,  BALATON Zoltan
 <balaton@eik.bme.hu>,  Gerd Hoffmann <kraxel@redhat.com>,  Christian
 Schoenebeck <qemu_oss@crudebyte.com>,  Eric Blake <eblake@redhat.com>
Subject: Re: [PULL 8/9] alsaaudio: Set try-poll to false by default
In-Reply-To: <20250525132717.527392-9-marcandre.lureau@redhat.com> (marcandre
 lureau's message of "Sun, 25 May 2025 15:27:15 +0200")
References: <20250525132717.527392-1-marcandre.lureau@redhat.com>
 <20250525132717.527392-9-marcandre.lureau@redhat.com>
Date: Mon, 26 May 2025 08:27:10 +0200
Message-ID: <87cybvkhtt.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -59
X-Spam_score: -6.0
X-Spam_bar: ------
X-Spam_report: (-6.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.904,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

marcandre.lureau@redhat.com writes:

> From: BALATON Zoltan <balaton@eik.bme.hu>
>
> Quoting Volker R=C3=BCmelin: "try-poll=3Don tells the ALSA backend to try=
 to
> use an event loop instead of the audio timer. This works most of the
> time. But the poll event handler in the ALSA backend has a bug. For
> example, if the guest can't provide enough audio frames in time, the
> ALSA buffer is only partly full and the event handler will be called
> again and again on every iteration of the main loop. This increases
> the processor load and the guest has less processor time to provide
> new audio frames in time. I have two examples where a guest can't
> recover from this situation and the guest seems to hang."
>
> One reproducer I've found is booting MorphOS demo iso on
> qemu-system-ppc -machine pegasos2 -audio alsa which should play a
> startup sound but instead it freezes. Even when it does not hang it
> plays choppy sound. Volker suggested using command line to set
> try-poll=3Doff saying: "The try-poll=3Doff arguments are typically
> necessary, because the alsa backend has a design issue with
> try-poll=3Don. If the guest can't provide enough audio frames, it's
> really unhelpful to ask for new audio frames on every main loop
> iteration until the guest can provide enough audio frames. Timer based
> playback doesn't have that problem."
>
> But users cannot easily find this option and having a non-working
> default is really unhelpful so to make life easier just set it to
> false by default which works until the issue with the alsa backend can
> be fixed.
>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> Acked-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> [ Marc-Andr=C3=A9 - Updated QAPI and CLI doc ]
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Message-Id: <20250316002046.D066A4E6004@zero.eik.bme.hu>
> ---
>  qapi/audio.json   | 2 +-
>  audio/alsaaudio.c | 2 +-
>  qemu-options.hx   | 4 ++--
>  3 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/qapi/audio.json b/qapi/audio.json
> index dd5a58d13e..49633cf317 100644
> --- a/qapi/audio.json
> +++ b/qapi/audio.json
> @@ -96,7 +96,7 @@
>  # @period-length: the period length in microseconds
>  #
>  # @try-poll: attempt to use poll mode, falling back to non-polling
> -#     access on failure (default true)
> +#     access on failure (default false)
>  #
>  # Since: 4.0
>  ##

Missed this when it was posted (it wasn't cc'ed to me).  Flipping the
default is technically an incompatible change.  I understand the
justification, and I'm not passing judgement on its validity; that's the
audio maintainers job.  I just want to ask: does this need a release
note?

We normally record incompatible changes in docs/about/deprecated.rst and
then docs/about/removed-features.rst, but these don't fit here.

[...]


