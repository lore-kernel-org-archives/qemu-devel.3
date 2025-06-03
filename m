Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78FB1C5AD49
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 16:55:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMUth-00048S-Hg; Tue, 03 Jun 2025 12:54:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uMUtY-00047I-GI
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 12:53:49 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uMUtR-000113-CM
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 12:53:46 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-addda47ebeaso398269866b.1
 for <qemu-devel@nongnu.org>; Tue, 03 Jun 2025 09:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748969617; x=1749574417; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XGlHGaqH4TXVuzLOeNBCW7NUHAnY0zyqjJ0BSGR6EQY=;
 b=RG4yJ0LZGIPJdxONiCTmivp5iQeB/OGidwjasryEUgSueAzRCKcDJHh8SwTMReYe0U
 8FEpd8M8rpwefXy+mC4uE+KeBXNjaSYQWHtv2vmubdF4ZsEi1DffjuyRdDwIBZ/iHWyc
 fhkBUXUgPoaF9Rkze66XJKVYAhfRJBVmv1zGCC2XIAmDwlPM9KuCmYV+f2CZ1278O/r6
 FQ2jOccFLlday1doi1ymUCIyb6tp2jrnimZYwVzxde1usHEIkjHhUvf52g2pfwUku6BN
 Tl66KTSNFCsn2Na5ScrKTfvTUFgdqR9w7dDHC5+1o4KUudZDi7JU03q3FaSN1iMD7WlQ
 xkjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748969617; x=1749574417;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XGlHGaqH4TXVuzLOeNBCW7NUHAnY0zyqjJ0BSGR6EQY=;
 b=IThuG1jhMaO1w+Mi+PrIAFE4q1QSF6MQy3/nssFmMMIJR3cr5+Poq8BeeqelrHHuDC
 oRi9lYxyZpDzLTOFgt0XhAI4EedtyTEm9YUcUNVgy4weEG0+HjKkjMiCVKBlnLOoPrur
 wLwpIipjMfJA+UBJ2VuW2BZ7wmT0pFKwKy/oiXlp2bXqe5a7H+zdosLFUSze78uf2S7i
 /zlKNAWkdik0N1XJ6YMl1SVJ9Bf4lFpWKIvEV/hVvhNw8cKfDN6+2PtjvD0nbtCFfmTk
 JM9HXxXFGzlN2Tcvrk3ySQ8/RLRXSzNXdLNjRf36lQ+WS8iuzJAKqVOw5x4m80QV8d/i
 Bhhg==
X-Gm-Message-State: AOJu0YwewP72Y/+/M8wjAFMKZLq7J336adUAB/mVmJumLrU01ozjmfsg
 5TTd17o8S35pZ7JddMlaywZTVjJn1N0UwDHzL/tXamk5hYsLvsUoEc8PE9hM2RHcytY=
X-Gm-Gg: ASbGncs1P951RItFnWl2xs24cR4DOymUVKypjat7FUzBeSFbuRMECS5X+t2ceNboTAS
 t8iBLh3O2e/diVMz/1e1o30VquBZ3YRfCW1CJHtNpWAzYxFpBcLmkfnf2ZZQ0gZdf3tfGWN31WF
 D73XmvLcI5iAAWtBnC2OJT2NSpnTwlgJfr9gJKuS7mTqmWd/D/XBMVo4jTjCIly2Hdw/895X2Qm
 r1KyjpYcTSQeacPlXQ8xJcv7DPKgtH/GZPIsfz1JHyYzmk17ZfF8ajRMeCk8vpZeiJ2P3b9Gaub
 79wiaalXCnyC5gwz1AGJh+wzFkdQO3m2hsquVEeU8l3AUUOCpPTvpK1t3OUwf+g=
X-Google-Smtp-Source: AGHT+IGWeZc1ngXxy3pMiliZh3T+51fEjdYmJ1EcilgDfjJnB7KuOXH5edwCmXLXetJmbiMpcmIloQ==
X-Received: by 2002:a17:907:3c8a:b0:adb:3345:7594 with SMTP id
 a640c23a62f3a-adb36afcea8mr1356546166b.9.1748969617277; 
 Tue, 03 Jun 2025 09:53:37 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ada5e2befdbsm985330566b.97.2025.06.03.09.53.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Jun 2025 09:53:36 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id DE3155F901;
 Tue, 03 Jun 2025 17:53:35 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,  "Michael S . Tsirkin" <mst@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,  Mark Cave-Ayland
 <mark.cave-ayland@ilande.co.uk>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Kevin Wolf <kwolf@redhat.com>,  Stefan Hajnoczi
 <stefanha@redhat.com>,  Alexander Graf <agraf@csgraf.de>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v3 1/3] docs: introduce dedicated page about code
 provenance / sign-off
In-Reply-To: <20250603142524.4043193-2-armbru@redhat.com> (Markus Armbruster's
 message of "Tue, 3 Jun 2025 16:25:22 +0200")
References: <20250603142524.4043193-1-armbru@redhat.com>
 <20250603142524.4043193-2-armbru@redhat.com>
User-Agent: mu4e 1.12.11; emacs 30.1
Date: Tue, 03 Jun 2025 17:53:35 +0100
Message-ID: <87a56o3gxc.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x636.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_FILL_THIS_FORM_SHORT=0.01 autolearn=no autolearn_force=no
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

Markus Armbruster <armbru@redhat.com> writes:

> From: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>
> Currently we have a short paragraph saying that patches must include
> a Signed-off-by line, and merely link to the kernel documentation.
> The linked kernel docs have a lot of content beyond the part about
> sign-off an thus are misleading/distracting to QEMU contributors.
>
> This introduces a dedicated 'code-provenance' page in QEMU talking
> about why we require sign-off, explaining the other tags we commonly
> use, and what to do in some edge cases.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  docs/devel/code-provenance.rst    | 218 ++++++++++++++++++++++++++++++
>  docs/devel/index-process.rst      |   1 +
>  docs/devel/submitting-a-patch.rst |  18 +--
>  3 files changed, 221 insertions(+), 16 deletions(-)
>  create mode 100644 docs/devel/code-provenance.rst
>
> diff --git a/docs/devel/code-provenance.rst b/docs/devel/code-provenance.=
rst
> new file mode 100644
> index 0000000000..4fc12061b5
> --- /dev/null
> +++ b/docs/devel/code-provenance.rst
> @@ -0,0 +1,218 @@
> +.. _code-provenance:
> +
> +Code provenance
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Certifying patch submissions
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +The QEMU community **mandates** all contributors to certify provenance of
> +patch submissions they make to the project. To put it another way,
> +contributors must indicate that they are legally permitted to contribute=
 to
> +the project.
> +
> +Certification is achieved with a low overhead by adding a single line to=
 the
> +bottom of every git commit::

s/git commit/commit/ throughout?

> +
> +   Signed-off-by: YOUR NAME <YOUR@EMAIL>
> +
> +using a known identity (sorry, no anonymous contributions.)
> +

maybe "(contributions cannot be anonymous)" is more direct?

> +The addition of this line asserts that the author of the patch is contri=
buting
> +in accordance with the clauses specified in the
> +`Developer's Certificate of Origin <https://developercertificate.org>`__:
> +
> +.. _dco:
> +
> +  Developer's Certificate of Origin 1.1
> +
> +  By making a contribution to this project, I certify that:
> +
> +  (a) The contribution was created in whole or in part by me and I
> +      have the right to submit it under the open source license
> +      indicated in the file; or
> +
> +  (b) The contribution is based upon previous work that, to the best
> +      of my knowledge, is covered under an appropriate open source
> +      license and I have the right under that license to submit that
> +      work with modifications, whether created in whole or in part
> +      by me, under the same open source license (unless I am
> +      permitted to submit under a different license), as indicated
> +      in the file; or
> +
> +  (c) The contribution was provided directly to me by some other
> +      person who certified (a), (b) or (c) and I have not modified
> +      it.
> +
> +  (d) I understand and agree that this project and the contribution
> +      are public and that a record of the contribution (including all
> +      personal information I submit with it, including my sign-off) is
> +      maintained indefinitely and may be redistributed consistent with
> +      this project or the open source license(s) involved.
> +
> +It is generally expected that the name and email addresses used in one o=
f the
> +``Signed-off-by`` lines, matches that of the git commit ``Author`` field.
> +It's okay if you subscribe or contribute to the list via more than one
> +address, but using multiple addresses in one commit just confuses
> +things.
> +
> +If the person sending the mail is not one of the patch authors, they are
> +nonetheless expected to add their own ``Signed-off-by`` to comply with t=
he
> +DCO clause (c).

We should probably mention that sometimes the committer may update the
patch after they have pulled it into the tree. In those cases we preface
the S-o-B tag with a comment:

  Signed-off-by: Original Hacker <hacker@domain>
  [MH: tweaked the commit message for clarity]
  Signed-off-by: Maintainer Hacker <hacker@another.com>

> +
> +Multiple authorship
> +~~~~~~~~~~~~~~~~~~~
> +
> +It is not uncommon for a patch to have contributions from multiple autho=
rs. In
> +this scenario, git commits will usually be expected to have a ``Signed-o=
ff-by``
> +line for each contributor involved in creation of the patch. Some edge c=
ases:
> +
> +  * The non-primary author's contributions were so trivial that they can=
 be
> +    considered not subject to copyright. In this case the secondary auth=
ors
> +    need not include a ``Signed-off-by``.
> +
> +    This case most commonly applies where QEMU reviewers give short snip=
pets
> +    of code as suggested fixes to a patch. The reviewers don't need to h=
ave
> +    their own ``Signed-off-by`` added unless their code suggestion was
> +    unusually large, but it is common to add ``Suggested-by`` as a credit
> +    for non-trivial code.
> +
> +  * Both contributors work for the same employer and the employer requir=
es
> +    copyright assignment.
> +
> +    It can be said that in this case a ``Signed-off-by`` is indicating t=
hat
> +    the person has permission to contribute from their employer who is t=
he
> +    copyright holder. It is nonetheless still preferable to include a
> +    ``Signed-off-by`` for each contributor, as in some countries employe=
es are
> +    not able to assign copyright to their employer, and it also covers a=
ny
> +    time invested outside working hours.
> +
> +When multiple ``Signed-off-by`` tags are present, they should be strictl=
y kept
> +in order of authorship, from oldest to newest.
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

We don't mention the Link: or Message-Id: tags.

> +
> + * **``Suggested-by``**: when a reviewer or other 3rd party makes non-tr=
ivial
> +   suggestions for how to change a patch, it is good practice to credit =
them
> +   by including a ``Suggested-by`` tag.
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
> +append a suitable line matching the configured git author details.
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

Much as I love Emacs I wonder if this next section is worth it given the
multiple ways you can solve this (I use yas-snippet expansions for
example).

If we do want to mention the editors we should probably also mention b4.

> +emacs
> +^^^^^
> +
> +In the file ``$HOME/.emacs.d/abbrev_defs`` add:
> +
> +.. code:: elisp
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
> index cb7c6640fd..5807752d70 100644
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
> index 65c64078cb..8624f21673 100644
> --- a/docs/devel/submitting-a-patch.rst
> +++ b/docs/devel/submitting-a-patch.rst
> @@ -344,28 +344,14 @@ Patch emails must include a ``Signed-off-by:`` line
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
> +this and happy for it to go into QEMU". For full guidance, read the
> +:ref:`code-provenance` documentation.
>=20=20
>  The name used with "Signed-off-by" does not need to be your legal name,
>  nor birth name, nor appear on any government ID. It is the identity you
>  choose to be known by in the community, but should not be anonymous,
>  nor misrepresent whom you are.
>=20=20
> -There are various tooling options for automatically adding these tags
> -include using ``git commit -s`` or ``git format-patch -s``. For more
> -information see `SubmittingPatches 1.12
> -<http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Doc=
umentation/SubmittingPatches?id=3Df6f94e2ab1b33f0082ac22d71f66385a60d8157f#=
n297>`__.
>=20=20
>  .. _include_a_meaningful_cover_letter:

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

