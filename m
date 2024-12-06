Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8BB6E77173
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 11:44:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJWk4-0002gl-D4; Fri, 06 Dec 2024 06:43:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tJWk3-0002aO-1k
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 06:43:27 -0500
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tJWk0-0007Tl-BL
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 06:43:26 -0500
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-53e2baf3160so1004122e87.0
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2024 03:43:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733485402; x=1734090202; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+dcZL/XycRcgJzs9PvbXJ58kkfyFPYjfcUspncSKoTQ=;
 b=Z4aOsZBGqgNy51xRzKRAvgG2dNph039O6DJDMCnQFx13XIKcppyjd8017BMrbh0RuY
 /uWQka/kHbAA3YvZSwYKuXhX0vbB5fY4OxZVLMhVWn79AuBq61mBC4DacTtbhygcZmFm
 UFBUsgeztIuoqIuvH6hjivTO8OBzH37gtu99EgDuGC7TyeZgxRz0PrR24nVpCmBNDBpI
 PqeZTs4WyQJ1c9cCbQEXpXQ4JCtPZ6R8wRHXjfBSRQKAtUD6QreD4M8XJgXwYjAx5HN2
 qvRNYo3TPHlVJofpB87q/KjfGlzeQGKPxODfuCF9ZmNkrU9Lut83YaQ6Zxf86EzvCJMI
 5JLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733485402; x=1734090202;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+dcZL/XycRcgJzs9PvbXJ58kkfyFPYjfcUspncSKoTQ=;
 b=id2g+OQm8MTboXrEw5I7iJulPseyAeIZPjpEOEqg0if+YML+e5TcnJuapINkMK2Dc/
 vXQ2H+kK/0JrM6E3ANTXNuCEBuDSoxOwP7bTkG4Rktc5aSvThoZhzO/s6YFW4fwKs9sg
 7BCh9EgawzZARQD0yjnqH1p3ptArfZ7TZTVHlhzu0i/BraAHQ9Uz46Ohu97UbyBCPoiW
 FgbTBR6MEZIRXS0BWl0mBO4hObgvDZMJ8auujjvgI4eTnnnwDJbRbA+bns8DqkyXlZcf
 7gQjpPVnc837V+yRST+en/+d6r2N3B2hi2H8Wr4U5L5fcmFiOMMrhPHAQfAlpiaFPoAg
 v4TA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYZ2Y6m1tqvrV+qnnskoN/mw/WWY6W7UP1tgoBLIiiwmPXoKDbxtT726DfDuGFWhpqq24LKy1lqA2X@nongnu.org
X-Gm-Message-State: AOJu0YwwSNpRomXTM6CkuRrbTcIDQpUZCD40lpgppg3/XIvB/w5MHXTm
 a2xw9mv1ud+dYCRPjNTSNEUO2wYvz0JN6Kf90SKgnOGuYCqgxSrjdR8M8bzz80ELAhTqAYM3bDG
 bIK0OONupQDKi6PjCHnTYcHbUuLgEWk+CX6CdFw==
X-Gm-Gg: ASbGncsW/dZfwGuDkAvf76lKXEc61KG7Y1R0XGyItIPf3Fn1bQZGvuIdVt8b9JAQaXS
 UhtMeEBL8RaA4eqMzGeYFt8ufgwfUnQks
X-Google-Smtp-Source: AGHT+IHIMsEF1NNTn6NDxeq3XiOAvczc/SNBhNQysZE2mVj+n7tq6aX+P+1HxSrXc7i4YwTcqkQ+qPxFWkKwgsRwiuY=
X-Received: by 2002:a05:6512:ba8:b0:53d:eed0:8d9e with SMTP id
 2adb3069b0e04-53e2c2efb6amr1250862e87.53.1733485402383; Fri, 06 Dec 2024
 03:43:22 -0800 (PST)
MIME-Version: 1.0
References: <20241205222241.3789437-1-pierrick.bouvier@linaro.org>
 <20241205222241.3789437-3-pierrick.bouvier@linaro.org>
 <Z1LgpKB_J4Df4wcE@redhat.com>
In-Reply-To: <Z1LgpKB_J4Df4wcE@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Dec 2024 11:43:11 +0000
Message-ID: <CAFEAcA-WadSi-U+Q9MFY_+vhNimJ1HpCcSZE7aVz3PRKuwc+ew@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] docs/devel: add git-publish for patch submitting
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org, 
 Fabiano Rosas <farosas@suse.de>, Kevin Wolf <kwolf@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 gustavo.romero@linaro.org, 
 Andrew Melnychenko <andrew@daynix.com>, qemu-arm@nongnu.org,
 alex.bennee@linaro.org, 
 Konstantin Kostiuk <kkostiuk@redhat.com>, Eric Blake <eblake@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Jason Wang <jasowang@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, manos.pitsidianakis@linaro.org,
 qemu-block@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12b.google.com
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

On Fri, 6 Dec 2024 at 11:32, Daniel P. Berrang=C3=A9 <berrange@redhat.com> =
wrote:
>
> On Thu, Dec 05, 2024 at 02:22:37PM -0800, Pierrick Bouvier wrote:
> > Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> > ---
> >  docs/devel/submitting-a-patch.rst | 19 +++++++++++++++++++
> >  1 file changed, 19 insertions(+)
> >
> > diff --git a/docs/devel/submitting-a-patch.rst b/docs/devel/submitting-=
a-patch.rst
> > index 03b2ac298aa..f8b7fc59544 100644
> > --- a/docs/devel/submitting-a-patch.rst
> > +++ b/docs/devel/submitting-a-patch.rst
> > @@ -235,6 +235,25 @@ to another list.) ``git send-email`` (`step-by-ste=
p setup guide
> >  works best for delivering the patch without mangling it, but
> >  attachments can be used as a last resort on a first-time submission.
> >
> > +.. _use_git_publish:
> > +
> > +Use git-publish
> > +~~~~~~~~~~~~~~~
> > +
> > +If you already configured git send-email, you can simply use `git-publ=
ish
> > +<https://github.com/stefanha/git-publish>`__ to send series.
> > +
> > +::
> > +
> > +    $ git checkout master -b my-feature
> > +    $ # work on new commits, add your 'Signed-off-by' lines to each
> > +    $ git publish
> > +    $ ... more work, rebase on master, ...
> > +    $ git publish # will send a v2
> > +
> > +Each time you post a series, git-publish will create a local tag with =
the format
> > +``<branchname>-v<version>`` to record the patch series.
>
> Lets also mention
>
>   "When sending patch emails, 'git publish' will consult the output
>    of 'scripts/get_maintainers.pl' and automatically CC anyone listed
>    as maintainers of the affected code. Generally you should accept the
>    suggested CC list, but there may sometimes be scenarios where it is
>    appropriate to cut it down (eg on certain large tree-wide cleanups),
>    or augment it with other interested people"
>
> Second, lets say something about pull requests
>
>   "When a subsystem maintainer is ready to send a pull request, the
>    'git publish --pull' command will triggering GPG tag signing,
>    publish the branch to the git remote name specified by the
>    'remote.pushDefault' config option, and send the email series'

We don't do pull requests for the normal "end developer submits
a patch" process, and given the prevalence of the github/gitlab
"all contributions go in as pull requests" model, I think that
talking about pull requests here (except to say "we don't do them")
would be confusing. If we want to document how you can use git publish
for pull request submission we can do that in
docs/devel/submitting-a-pull-request.rst.

thanks
-- PMM

