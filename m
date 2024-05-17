Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7518FC25B78
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2024 18:09:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s820K-0000Kq-PR; Fri, 17 May 2024 14:08:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1s820J-0000Ke-Hs
 for qemu-devel@nongnu.org; Fri, 17 May 2024 14:08:27 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1s820G-0006Sy-Gx
 for qemu-devel@nongnu.org; Fri, 17 May 2024 14:08:27 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a599a298990so537675166b.2
 for <qemu-devel@nongnu.org>; Fri, 17 May 2024 11:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715969303; x=1716574103; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=XscfhMemdh6om0QchJOqmb/nyUkqXsqK67esm5Ji9yo=;
 b=o2g4xrGeCFaE3NpdXXa77vy2CqnRVWSt+OVnrCbXT7vlGaM9xH0iToRjf0EOY1gAfb
 4oPlyivXhtvzQYYFd5d8T3QbZnfWZNl8IDXbSdp8r2p6U0209D/StBBTHaa2JvoPIb1W
 xNzO0+OB2/OfOhXJdaDTxGAb8vT6EQdm72uHLXL0k2hYLkelTwBpd+W7Mqyq5AopU2DB
 uL4IyqlyHixHezzRyk/A2UZ1b84HFrWUrsFXBVMv1S227WRqIH18zJ0t4k5RtRxwySV+
 FAQtCFN6iR39VHyg7wVi7l2vVawb2Yzv6WvOYM/70Nug8Hpa6Pr3JE6liJ4+0QcIJoM2
 WDwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715969303; x=1716574103;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XscfhMemdh6om0QchJOqmb/nyUkqXsqK67esm5Ji9yo=;
 b=BYEDhIhuFIvqgRU9IDy7VlGrM/Cvtn1leaKQbZ+hp00TxihbXaJPtnz0ci3jo1nyqX
 pTM+Dksd/Cmxyt4cDbiK/YEfv3TpnvQ3e2ns/D/MaRz/UlhCdQ4vrKbLrVahBdknyf+1
 yGcnxbqDlGirepj+BJZDvMXasgn8+xcyA7Gd1zGCQ1HP/c3VohsHqDsWDqFfQjB9My78
 B2mypegK1INM45hBGE6pQSBwOjk/vl8T7t/9TwHExMbwqDkwU+8LWwPZ/g4vKjtgzSsg
 lwQjKmrv/Xd/eq420G1q61u+K2UsYGjniXSHOeh7LaSB5L4Qrx0YJ+PVItR6rzieRiPh
 EFyw==
X-Gm-Message-State: AOJu0YxCr5Qkb2k4dwUbllDvlNrOBe+BqhcyoNOlAMIXSHNRWaY+lsiC
 wuZse2g+sIfrXYcRmZsOga0EBM2ze/n0a9k1qCrXrtm1GI7g6jkt0p8yCcpTvjc=
X-Google-Smtp-Source: AGHT+IHxVYTO8MwlIbDkI8H9JiEZNzJc3ObD42J2diABuq0RPW6NaS3G0+hiVQYfbae5Uk5Ekc7PGg==
X-Received: by 2002:a17:906:350b:b0:a59:bbd6:bb39 with SMTP id
 a640c23a62f3a-a5a2d64158emr1411068566b.55.1715969302253; 
 Fri, 17 May 2024 11:08:22 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5cdc72d31fsm304895466b.169.2024.05.17.11.08.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 May 2024 11:08:21 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 3E3215F88D;
 Fri, 17 May 2024 19:08:21 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Thomas Huth <thuth@redhat.com>,  "Michael S.
 Tsirkin" <mst@redhat.com>,  Gerd Hoffmann <kraxel@redhat.com>,  Mark
 Cave-Ayland <mark.cave-ayland@ilande.co.uk>,  Philippe =?utf-8?Q?Mathieu-?=
 =?utf-8?Q?Daud=C3=A9?=
 <philmd@linaro.org>,  Kevin Wolf <kwolf@redhat.com>,  Stefan Hajnoczi
 <stefanha@redhat.com>,  Alexander Graf <agraf@csgraf.de>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,  Markus Armbruster
 <armbru@redhat.com>
Subject: Re: [PATCH v2 1/3] docs: introduce dedicated page about code
 provenance / sign-off
In-Reply-To: <20240516162230.937047-2-berrange@redhat.com> ("Daniel P.
 =?utf-8?Q?Berrang=C3=A9=22's?= message of "Thu, 16 May 2024 17:22:28
 +0100")
References: <20240516162230.937047-1-berrange@redhat.com>
 <20240516162230.937047-2-berrange@redhat.com>
Date: Fri, 17 May 2024 19:08:21 +0100
Message-ID: <87zfsopazu.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> Currently we have a short paragraph saying that patches must include
> a Signed-off-by line, and merely link to the kernel documentation.
> The linked kernel docs have a lot of content beyond the part about
> sign-off an thus are misleading/distracting to QEMU contributors.
>
> This introduces a dedicated 'code-provenance' page in QEMU talking
> about why we require sign-off, explaining the other tags we commonly
> use, and what to do in some edge cases.
>
<snip>
> +
> +Other commit tags
> +~~~~~~~~~~~~~~~~~
> +
> +While the ``Signed-off-by`` tag is mandatory, there are a number of othe=
r tags
> +that are commonly used during QEMU development:
> +
> + * **``Reviewed-by``**: when a QEMU community member reviews a patch on =
the
> +   mailing list, if they consider the patch acceptable, they should send=
 an
> +   email reply containing a ``Reviewed-by`` tag. Subsystem maintainers w=
ho
> +   review a patch should add this even if they are also adding their
> +   ``Signed-off-by`` to the same commit.
> +
> + * **``Acked-by``**: when a QEMU subsystem maintainer approves a patch t=
hat
> +   touches their subsystem, but intends to allow a different maintainer =
to
> +   queue it and send a pull request, they would send a mail containing a
> +   ``Acked-by`` tag. Where a patch touches multiple subsystems, ``Acked-=
by``
> +   only implies review of the maintainers' own areas of responsibility. =
If a
> +   maintainer wants to indicate they have done a full review they should=
 use
> +   a ``Reviewed-by`` tag.
> +
> + * **``Tested-by``**: when a QEMU community member has functionally test=
ed the
> +   behaviour of the patch in some manner, they should send an email reply
> +   containing a ``Tested-by`` tag.
> +
> + * **``Reported-by``**: when a QEMU community member reports a problem v=
ia the
> +   mailing list, or some other informal channel that is not the issue tr=
acker,
> +   it is good practice to credit them by including a ``Reported-by`` tag=
 on
> +   any patch fixing the issue. When the problem is reported via the GitL=
ab
> +   issue tracker, however, it is sufficient to just include a link to the
> +   issue.
> +
> + * **``Suggested-by``**: when a reviewer or other 3rd party makes non-tr=
ivial
> +   suggestions for how to change a patch, it is good practice to credit =
them
> +   by including a ``Suggested-by`` tag.

Should we mention our use of Message-Id in so far the informal good
practice is that we keep the Message-Id's of the last time a patch was
posted and potentially the message-ids of previous posters?

But this is definitely an improvement of what we had before so:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>


> +
> +Subsystem maintainer requirements
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +When a subsystem maintainer accepts a patch from a contributor, in addit=
ion to
> +the normal code review points, they are expected to validate the presenc=
e of
> +suitable ``Signed-off-by`` tags.
> +
> +At the time they queue the patch in their subsystem tree, the maintainer
> +**must** also then add their own ``Signed-off-by`` to indicate that they=
 have
> +done the aforementioned validation. This is in addition to any of their =
own
> +``Reviewed-by`` tags the subsystem maintainer may wish to include.
> +
> +Tools for adding ``Signed-off-by``
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +There are a variety of ways tools can support adding ``Signed-off-by`` t=
ags
> +for patches, avoiding the need for contributors to manually type in this
> +repetitive text each time.
> +
> +git commands
> +^^^^^^^^^^^^
> +
> +When creating, or amending, a commit the ``-s`` flag to ``git commit`` w=
ill
> +append a suitable line matching the configuring git author details.
> +
> +If preparing patches using the ``git format-patch`` tool, the ``-s`` fla=
g can
> +be used to append a suitable line in the emails it creates, without modi=
fying
> +the local commits. Alternatively to modify all the local commits on a br=
anch::
> +
> +  git rebase master -x 'git commit --amend --no-edit -s'
> +
> +emacs
> +^^^^^
> +
> +In the file ``$HOME/.emacs.d/abbrev_defs`` add::
> +
> +  (define-abbrev-table 'global-abbrev-table
> +    '(
> +      ("8rev" "Reviewed-by: YOUR NAME <your@email.addr>" nil 1)
> +      ("8ack" "Acked-by: YOUR NAME <your@email.addr>" nil 1)
> +      ("8test" "Tested-by: YOUR NAME <your@email.addr>" nil 1)
> +      ("8sob" "Signed-off-by: YOUR NAME <your@email.addr>" nil 1)
> +     ))
> +
> +with this change, if you type (for example) ``8rev`` followed by ``<spac=
e>``
> +or ``<enter>`` it will expand to the whole phrase.
> +
> +vim
> +^^^
> +
> +In the file ``$HOME/.vimrc`` add::
> +
> +  iabbrev 8rev Reviewed-by: YOUR NAME <your@email.addr>
> +  iabbrev 8ack Acked-by: YOUR NAME <your@email.addr>
> +  iabbrev 8test Tested-by: YOUR NAME <your@email.addr>
> +  iabbrev 8sob Signed-off-by: YOUR NAME <your@email.addr>
> +
> +with this change, if you type (for example) ``8rev`` followed by ``<spac=
e>``
> +or ``<enter>`` it will expand to the whole phrase.
> +
> +Re-starting abandoned work
> +~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +For a variety of reasons there are some patches that get submitted to QE=
MU but
> +never merged. An unrelated contributor may decide (months or years later=
) to
> +continue working from the abandoned patch and re-submit it with extra ch=
anges.
> +
> +The general principles when picking up abandoned work are:
> +
> + * Continue to credit the original author for their work, by maintaining=
 their
> +   original ``Signed-off-by``
> + * Indicate where the original patch was obtained from (mailing list, bug
> +   tracker, author's git repo, etc) when sending it for review
> + * Acknowledge the extra work of the new contributor by including their
> +   ``Signed-off-by`` in the patch in addition to the orignal author's
> + * Indicate who is responsible for what parts of the patch. This is typi=
cally
> +   done via a note in the commit message, just prior to the new contribu=
tor's
> +   ``Signed-off-by``::
> +
> +    Signed-off-by: Some Person <some.person@example.com>
> +    [Rebased and added support for 'foo']
> +    Signed-off-by: New Person <new.person@mycorp.test>
> +
> +In complicated cases, or if otherwise unsure, ask for advice on the proj=
ect
> +mailing list.
> +
> +It is also recommended to attempt to contact the original author to let =
them
> +know you are interested in taking over their work, in case they still in=
tended
> +to return to the work, or had any suggestions about the best way to cont=
inue.
> diff --git a/docs/devel/index-process.rst b/docs/devel/index-process.rst
> index 362f97ee30..b54e58105e 100644
> --- a/docs/devel/index-process.rst
> +++ b/docs/devel/index-process.rst
> @@ -13,6 +13,7 @@ Notes about how to interact with the community and how =
and where to submit patch
>     maintainers
>     style
>     submitting-a-patch
> +   code-provenance
>     trivial-patches
>     stable-process
>     submitting-a-pull-request
> diff --git a/docs/devel/submitting-a-patch.rst b/docs/devel/submitting-a-=
patch.rst
> index 83e9092b8c..2cc4d53ff6 100644
> --- a/docs/devel/submitting-a-patch.rst
> +++ b/docs/devel/submitting-a-patch.rst
> @@ -322,23 +322,8 @@ Patch emails must include a ``Signed-off-by:`` line
>=20=20
>  Your patches **must** include a Signed-off-by: line. This is a hard
>  requirement because it's how you say "I'm legally okay to contribute
> -this and happy for it to go into QEMU". The process is modelled after
> -the `Linux kernel
> -<http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Doc=
umentation/SubmittingPatches?id=3Df6f94e2ab1b33f0082ac22d71f66385a60d8157f#=
n297>`__
> -policy.
> -
> -If you wrote the patch, make sure your "From:" and "Signed-off-by:"
> -lines use the same spelling. It's okay if you subscribe or contribute to
> -the list via more than one address, but using multiple addresses in one
> -commit just confuses things. If someone else wrote the patch, git will
> -include a "From:" line in the body of the email (different from your
> -envelope From:) that will give credit to the correct author; but again,
> -that author's Signed-off-by: line is mandatory, with the same spelling.
> -
> -There are various tooling options for automatically adding these tags
> -include using ``git commit -s`` or ``git format-patch -s``. For more
> -information see `SubmittingPatches 1.12
> -<http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Doc=
umentation/SubmittingPatches?id=3Df6f94e2ab1b33f0082ac22d71f66385a60d8157f#=
n297>`__.
> +this and happy for it to go into QEMU". For full guidance, read the
> +:ref:`code-provenance` documentation.
>=20=20
>  .. _include_a_meaningful_cover_letter:

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

