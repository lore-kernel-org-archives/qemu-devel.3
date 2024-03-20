Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E8C3C6FD1F
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 19:40:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rn1mn-0000vO-Hn; Wed, 20 Mar 2024 15:39:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rn1mm-0000uJ-89
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 15:39:40 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rn1mj-0000G8-P8
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 15:39:39 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-512f54fc2dbso277627e87.1
 for <qemu-devel@nongnu.org>; Wed, 20 Mar 2024 12:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710963575; x=1711568375; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bpHuHkZmF+RI7YNsG7r67vZd0DMRSB4rHwmVb/ht/QY=;
 b=XscpOpF4kGBA1poeoBdUTN7J7KbGczqs94Pkul8XiIteYqMnhVTuE4T8cEbNPFXLys
 z0ZBq5XcXz1CBNYGl6PRuk+RSYXJYo72QxijURVLO149TuzLjLzq3mJyaX0ryPQyFcQV
 ruDphJgdu56mtxWPE76n96JEt0WFgdIfHIwWsyBraP9I2/Hz/lvZ8jsOC+65CzLwFlHH
 pGQgZBp7r0UZouJBv7fbRLErx9cQFQjzv7Z+AbfC5KnJk48t7eAtQjiHXtFG5uNmJ6yy
 O+BhlxSiXUkjES9u6ehMNChVUTPwqSKeNflq2K2+u1IUf4hmaDvun3tUd8Orn9F7V2gy
 0utA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710963575; x=1711568375;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bpHuHkZmF+RI7YNsG7r67vZd0DMRSB4rHwmVb/ht/QY=;
 b=OyWYusGPJD9R9lNdfs6cUanD6TSqF6mhu1MsHMZO/WqUyCi3jQYJC0fdtgtICSuz+h
 D0ID/Lz0TkT/g/gY59IwVWCrO1+HgtU8ZexoboluZpl1lAUxxPLeJZsNjNr+solOTsE5
 PPyaOr4XLcy+Xd/LbjiQAP0KFk6YsN2KfW9lRVH4Mhn/ZEVxgr83DmT26G0r2PU3PjyG
 eKivQ7VSvTCGW0PhYJcGHoC2mjncEapybi98Yc+uLqruZddJd2eFw0QlMjnPDl4rlpC+
 MbuUkyvGYPfzQEa9fzrGkZyHQ0vmqsAo3BeHfgE6v5inz3wCdFeabnSGEIrgc0aiNlA2
 B/8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCV9fao2x2cDVQDs13vMBj5vHH/gaiABINBKwmHxoPBSpHnvZViEjwztoYf5/TY/73qLRkg/lg88qZKuAeIwQG87hZYwU3s=
X-Gm-Message-State: AOJu0Yw9MDX8mSZEqRnUvB1daLEx1GENSX1iV5WsIODVgN98kStl5jNi
 fK+bxUlztPqUO6sbfe7NskjpvIkgR7IToz6upOTOX0ujX+Ikz4Z/YfgQ6/pOp09+TuM1Lsz2zig
 6ySWRrJWIP9IxC29+tsJ6OqYZdIFOHmYBeSfGEw==
X-Google-Smtp-Source: AGHT+IEVp/aUug5d7USvmyxVihmESpyokzjuguPaTToq+tG0Jy7abp2JwL7xU7+RAQEbVoiCrsm3siMpa90ocdXxN6E=
X-Received: by 2002:a19:5e53:0:b0:513:a88b:3296 with SMTP id
 z19-20020a195e53000000b00513a88b3296mr12736853lfi.9.1710963574664; Wed, 20
 Mar 2024 12:39:34 -0700 (PDT)
MIME-Version: 1.0
References: <20240220150833.13674-1-philmd@linaro.org>
 <20240220150833.13674-4-philmd@linaro.org>
 <CAFEAcA9kVkM16paZQfH1voNNjWRT3DmchepiMs045w+YA61Fzw@mail.gmail.com>
 <52f35af0-4b18-48c8-8e18-aa7b01f53848@linaro.org>
 <87y1aclo65.fsf@pond.sub.org>
In-Reply-To: <87y1aclo65.fsf@pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 20 Mar 2024 19:39:23 +0000
Message-ID: <CAFEAcA8J61GEEHPRJQ=8G8n17mmeFZa6j-H6oiKmXem-JzdP6A@mail.gmail.com>
Subject: Re: [PATCH 3/4] hw/nmi: Remove @cpu_index argument from
 NMIClass::nmi_handler()
To: Markus Armbruster <armbru@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org, 
 qemu-ppc@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Richard Henderson <richard.henderson@linaro.org>, Helge Deller <deller@gmx.de>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, 
 Laurent Vivier <laurent@vivier.eu>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, 
 Eric Farman <farman@linux.ibm.com>, David Hildenbrand <david@redhat.com>, 
 Ilya Leoshkevich <iii@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Wed, 20 Mar 2024 at 19:05, Markus Armbruster <armbru@redhat.com> wrote:
>
> Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:
>
> > On 20/3/24 14:23, Peter Maydell wrote:
> >> On Tue, 20 Feb 2024 at 15:09, Philippe Mathieu-Daud=C3=A9 <philmd@lina=
ro.org> wrote:
> >>>
> >>> Only s390x was using the 'cpu_index' argument, but since the
> >>> previous commit it isn't anymore (it use the first cpu).
> >>> Since this argument is now completely unused, remove it. Have
> >>> the callback return a boolean indicating failure.
> >>>
> >>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> >>> ---
> >>>   include/hw/nmi.h           | 11 ++++++++++-
> >>>   hw/core/nmi.c              |  3 +--
> >>>   hw/hppa/machine.c          |  8 +++++---
> >>>   hw/i386/x86.c              |  7 ++++---
> >>>   hw/intc/m68k_irqc.c        |  6 ++++--
> >>>   hw/m68k/q800-glue.c        |  6 ++++--
> >>>   hw/misc/macio/gpio.c       |  6 ++++--
> >>>   hw/ppc/pnv.c               |  6 ++++--
> >>>   hw/ppc/spapr.c             |  6 ++++--
> >>>   hw/s390x/s390-virtio-ccw.c |  6 ++++--
> >>>   10 files changed, 44 insertions(+), 21 deletions(-)
> >>>
> >>> diff --git a/include/hw/nmi.h b/include/hw/nmi.h
> >>> index fff41bebc6..c70db941c9 100644
> >>> --- a/include/hw/nmi.h
> >>> +++ b/include/hw/nmi.h
> >>> @@ -37,7 +37,16 @@ typedef struct NMIState NMIState;
> >>>   struct NMIClass {
> >>>       InterfaceClass parent_class;
> >>>
> >>> -    void (*nmi_monitor_handler)(NMIState *n, int cpu_index, Error **=
errp);
> >>> +    /**
> >>> +     * nmi_handler: Callback to handle NMI notifications.
> >>> +     *
> >>> +     * @n: Class #NMIState state
> >>> +     * @errp: pointer to error object
> >>> +     *
> >>> +     * On success, return %true.
> >>> +     * On failure, store an error through @errp and return %false.
> >>> +     */
> >>> +    bool (*nmi_handler)(NMIState *n, Error **errp);
> >> Any particular reason to change the method name here?
> >> Do we really need to indicate failure both through the bool return
> >> and the Error** ?
> >
> > No, but this is the style *recommended* by the Error API since
> > commit e3fe3988d7 ("error: Document Error API usage rules"):
> >
> >     error: Document Error API usage rules
> >
> >     This merely codifies existing practice, with one exception: the rul=
e
> >     advising against returning void, where existing practice is mixed.
> >
> >     When the Error API was created, we adopted the (unwritten) rule to
> >     return void when the function returns no useful value on success,
> >     unlike GError, which recommends to return true on success and false
> >     on error then.
> >
> >     [...]
> >
> >     Make the rule advising against returning void official by putting i=
t
> >     in writing.  This will hopefully reduce confusion.
> >
> >   * - Whenever practical, also return a value that indicates success /
> >   *   failure.  This can make the error checking more concise, and can
> >   *   avoid useless error object creation and destruction.  Note that
>
> It's the difference between
>
>     if (!frobnicate(arg, errp)) {
>         return;
>     }
>
> and
>
>     frobnicate(arg, &err);
>     if (err) {
>         error_propagate(errp, err);
>         return;
>     }
>
> Readabilty dies by a thousand cuts.
>
> GError got this right.  We deviated from it for Error, until we
> understood why it's right.
>
> Another win: &error_abort gives you a backtrace into frobnicate() with
> the former, and into error_propagate() with the latter.

Fair enough. (When I made the comment I was vaguely wondering
if we wanted to keep the return value available to distinguish
"this hook has handled the NMI, don't keep iterating" from
"no error, but you should keep iterating through other handlers".
But I think in the end my feeling is we should always stop
after the first NMI handler we find regardless.

-- PMM

