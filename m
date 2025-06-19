Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E66EC7115B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Jun 2025 21:20:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSMgi-0005rD-Lv; Thu, 19 Jun 2025 17:20:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <idryomov@gmail.com>)
 id 1uSMgg-0005qg-Vy; Thu, 19 Jun 2025 17:20:47 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <idryomov@gmail.com>)
 id 1uSMgf-0001U4-3l; Thu, 19 Jun 2025 17:20:46 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-b3182c6d03bso1383963a12.0; 
 Thu, 19 Jun 2025 14:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750368043; x=1750972843; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BYElizDDq6mi/dEHbeb6zdDvUIIDdWv5q62FG1T9Uy0=;
 b=FnVsUTtUI+Xyp79qEw8VHIVS3CciWOCXc7jkbS2VDl7PtpuAOuydCfDdqx7lgFgHuz
 cNp2KYhm9FQflYycx3IyxBOaqPPDQ/CijBPKQpbfFqS2g3NGTR5PXvajVyptothvLVjv
 QwTnp3CAz2h9vTY7mJJXEHVKmi5MTFnm5Pe9y5YFNKZM8Eue9ET04it5fq8mA3fZIpa4
 0nPl2SDaSAEgbMNtWPXNNQOBYaWnUXc/w81vLXyzfQpuDP79FfM4TTvRHfIZHKa1vV8M
 ROZntbCHrAY/r7l5jAtByC0XVpn8yTfKmMyTbA+LVHNLFUZAOMZIbWSlXegAc0mT5OYn
 snbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750368043; x=1750972843;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BYElizDDq6mi/dEHbeb6zdDvUIIDdWv5q62FG1T9Uy0=;
 b=BQyzxKPM2THwhPwwjufjdq4RTN6W2JUhKMtU6Hcy2LGT3BYLAMpIb2ddfpuVV+H0Zw
 3kI84Ha4pjcBN+f6OdqEJucOTw8eHEDF1eEyIeIMPRe7CfGIbR10R4S72fC2QIxO41Yo
 hsi+/hZHdmrl3SmUMH4qq9gzth6Qkr+SxJsJSEvGD/e74H3+RfID1ZKAhoW49gqm7f9h
 uWDpN/L02YFOuWjJwclbYRiAJCiQJ9Fz8Qs+eOrdpddo9BwwH+11suohYpxxvJhQPEUs
 +3i2VTv+guKLVj0apqa0HGEx+KU7k2dzggmHHLJwpaLuI+4MxTVaLqFogVO8Ngo4/FCf
 mvJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJGfbGRkc+NBoF1ITitX0oGNjC6fY/4W63gHxM2dhz5w04gpkYk9mwKSRoF0siFxqJF7u9v8N/8ls8@nongnu.org,
 AJvYcCXLqEQB7xX3K64556zzuvj1NOq6RgOmFhKyN9c/OjY6onOidzFMopFBgPCYClXNuF0+xOQPIbzJDxwdlQ==@nongnu.org
X-Gm-Message-State: AOJu0Yzffd9W1E2zP5hNGc0PsPhOKmzujEyiD8L1HI/nxIzzSznvU6zy
 UP/fVynwoIy+RPb4kEkdG0Qu8iFIPeDBSnbLGMTSxK7ZAdd9OeWF0baYLZ3yK79QhgJh4sOhq25
 4+N1yQdWM+Sz8AeWlbprXVVJekVv/PhbAItr7
X-Gm-Gg: ASbGnct9RfvUDkOssLTvM4lt2zrN2YwVZGSpLLP8Oszyr5nIJIjA7OJs3lpsdKNZD46
 JCZ5j6b4hjFqNKL8YrAiy5emo+SaYUyMYRnysdFkFUPDh1cOJiylCACbDYQsL4rDEpr3KWdanUy
 BTv7I4X3cWztKeO7J7BrfJZL9FQgiPPQDywEtchRRE9Sbjc12jBPcvsg==
X-Google-Smtp-Source: AGHT+IFqA1eJr8VmfaajVzhu+041g8AW9eeLIJ7rnYdaZ1xCB1IJZ9fJDvGw9kou4nb0h9XXX5AuT6qnaOCrHj3VEWE=
X-Received: by 2002:a17:90b:3952:b0:313:db0b:75db with SMTP id
 98e67ed59e1d1-3159d8e1597mr1058249a91.33.1750368043149; Thu, 19 Jun 2025
 14:20:43 -0700 (PDT)
MIME-Version: 1.0
References: <20250515112908.383693-1-f.ebner@proxmox.com>
 <20250515112908.383693-2-f.ebner@proxmox.com>
 <CAOi1vP94WJ7r1vPXvcpGZTs2xf6TZ=p=EmVGQvwipftufaYAMw@mail.gmail.com>
 <aE_pbAS_gS12Fp8f@redhat.com>
 <CAOi1vP-oc0XHR28E7JrvZOohL7KZEq7LunYKHfb540W=a8t=wQ@mail.gmail.com>
 <4a7ca415-0d16-4b21-ad93-31c35f1a4511@proxmox.com>
 <CAOi1vP8sazy4h=HcZyxE+EaC_C-5QnYezvwnJLzTCnz+=HM4hQ@mail.gmail.com>
In-Reply-To: <CAOi1vP8sazy4h=HcZyxE+EaC_C-5QnYezvwnJLzTCnz+=HM4hQ@mail.gmail.com>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Thu, 19 Jun 2025 23:20:31 +0200
X-Gm-Features: AX0GCFt79T_vr_RYda4kF9UBQ3NcqGWBrJwWHbYHDZDmEBDiZqDVGz35IyXdKrY
Message-ID: <CAOi1vP81g40nOnskY8fR8Eh7j9JMJdfD=P0+HBVUp80suNQWJQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] block/rbd: support selected key-value-pairs via QAPI
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-block@nongnu.org, qemu-devel@nongnu.org, armbru@redhat.com, 
 eblake@redhat.com, hreitz@redhat.com, kwolf@redhat.com, pl@dlhnet.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=idryomov@gmail.com; helo=mail-pg1-x52d.google.com
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

On Thu, Jun 19, 2025 at 8:38=E2=80=AFPM Ilya Dryomov <idryomov@gmail.com> w=
rote:
>
> On Mon, Jun 16, 2025 at 2:38=E2=80=AFPM Fiona Ebner <f.ebner@proxmox.com>=
 wrote:
> >
> > Am 16.06.25 um 12:28 schrieb Ilya Dryomov:
> > > On Mon, Jun 16, 2025 at 11:52=E2=80=AFAM Daniel P. Berrang=C3=A9 <ber=
range@redhat.com> wrote:
> > >> On Mon, Jun 16, 2025 at 11:25:54AM +0200, Ilya Dryomov wrote:
> > >>> On Thu, May 15, 2025 at 1:29=E2=80=AFPM Fiona Ebner <f.ebner@proxmo=
x.com> wrote:
> > >>>>  ##
> > >>>>  # @BlockdevOptionsRbd:
> > >>>>  #
> > >>>> @@ -4327,6 +4360,9 @@
> > >>>>  #     authentication.  This maps to Ceph configuration option "ke=
y".
> > >>>>  #     (Since 3.0)
> > >>>>  #
> > >>>> +# @key-value-pairs: Key-value pairs for additional Ceph configura=
ton.
> > >>>> +#     (Since 10.1)
> > >>>> +#
> > >>>>  # @server: Monitor host address and port.  This maps to the "mon_=
host"
> > >>>>  #     Ceph option.
> > >>>>  #
> > >>>> @@ -4342,6 +4378,7 @@
> > >>>>              '*user': 'str',
> > >>>>              '*auth-client-required': ['RbdAuthMode'],
> > >>>>              '*key-secret': 'str',
> > >>>> +            '*key-value-pairs' : 'RbdKeyValuePairs',
> > >>>
> > >>> To side-step all of the above, have you considered implementing
> > >>> a straightforward passthrough to Ceph instead?  Something like
> > >>>
> > >>>   '*key-value-pairs': ['RbdKeyValuePair']
> > >>>
> > >>> where RbdKeyValuePair is just a pair arbitrary strings (and
> > >>> key-value-pairs is thus an optional list of those).  rados_conf_set=
()
> > >>> would be called just the same but the user would be able to overrid=
e
> > >>> any Ceph option they wish, not just a few that we thought of here.
> > >>
> > >> Passing through arbitrary key/value pairs as strings is essentially
> > >> abdicating our design responsibility in QAPI. enums would no longer
> > >> be introspectable. Integers / booleans would require abnormal format=
ting
> > >> by clients. API stability / deprecation promises can no longer be ma=
de.
> > >> and more besides.
> >
> > Yes, and I also was under the impression that there is no desire to
> > re-introduce arbitrary key-value pairs with QMP/blockdev options.
>
> Hi Fiona,
>
> What do you mean by re-introduce?
>
> >
> > >> Given that limitation, if we did go the string pairs route, I would
> > >> expect it to be marked as "unstable" in the QAPI schema, so apps hav=
e
> > >> a suitable warning NOT to rely on this.
> > >
> > > This sounds sensible to me.  We can continue exposing the most common
> > > Ceph options through a proper QAPI schema but add key-value-pairs as =
an
> > > alternative low-level route for those who want to avoid dealing with
> > > physical configuration files.
> >
> > As written in the commit message, the cache option should not apply to
> > all volumes, so using configuration files is rather impractical there.
> >
> > I'd prefer defining the cache option(s) explicitly, and have people add
> > additional key-value pairs they require explicitly going forward. But i=
f
> > you really don't want me to, I can still go with the unstable, arbitrar=
y
> > strings approach instead.
>
> The RBD cache policy option would definitely count as one of the most
> common, so I don't have an objection to it being added in an explicit
> form.  I'm also fine with the "disabled" enum value that you expressed
> a preference for in another email.

The QEMU block layer-wide "cache" option is kind of in the way though:
if it's set to "off"/"none" or the more specific "cache.direct" option
is set to "on", we disable the RBD cache.  So there is an existing way
to control that, but it's at another level and QEMU cache modes aren't
distinguished (i.e. there is no mapping to RBD which means that one can
have "cache=3Dwriteback" set in QEMU but still get e.g. "writethrough"
RBD cache policy come from the ceph.conf file).  An extra enum value
for disabling the RBD cache might muddy the waters further.

Another thing that comes to mind is that if you need to control the
cache policy (or any other RBD option) on a per-image basis as opposed
to per-user basis, you can employ image-level configuration overrides
on the RBD side -- see "rbd config image get/set/ls/rm" commands.

Thanks,

                Ilya

