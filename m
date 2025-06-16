Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26567C71136
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Jun 2025 10:30:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uR75W-0007II-Dv; Mon, 16 Jun 2025 06:29:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <idryomov@gmail.com>)
 id 1uR75L-0007GF-Sz; Mon, 16 Jun 2025 06:29:06 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <idryomov@gmail.com>)
 id 1uR75I-0006sz-6e; Mon, 16 Jun 2025 06:29:02 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2363e973db1so41957305ad.0; 
 Mon, 16 Jun 2025 03:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750069737; x=1750674537; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+EWd6AuSh0sCTK8mlejekZBA9CosXuo/DQP9YgSYPjI=;
 b=dJbqRMuCCrTZ8c49tRtAEmIvugQNq0TT7HHsmQx1amA/AAuTMsrQ8TqpeOtqYMOKAR
 NZmYygAYOZXQwsJ7fTJRoVr90r2AYMss7FRU7PdSdMMET7oVjK2aOGRI7CaXbgZk7emR
 +YdaePNr8k5bWO4+jTjS+SB2V/Q16scfhJIBzQy7YVM+f0gvmJLXwyBuMMQ4pEll5QiH
 Vskl4gpwqty8PgA5WMSF/4zJ43i9NLOOaP+YUCvY73+Z712+9YoWkQ9yGbkZGAoAMbMh
 IhKTVLAaeX++KKKJjovRZDBEPRrPQbmA2FoWy7yWQneYhVNFVglYtQdCBv3paikZruvE
 /SAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750069737; x=1750674537;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+EWd6AuSh0sCTK8mlejekZBA9CosXuo/DQP9YgSYPjI=;
 b=LxOhvLJd0+RhN8Ux5JgW0QxFWM7beSY8dJFwOqf/FcOU+WPyZ7WW4BAA+bHW2mHa6I
 HiAYtdTcFfXGLTonjuoq22V5A6K9v/+kUqIEa9yLbXxr8GHEQ+7exwrLgtasch5P8bae
 KYgbeMPTbOSDzVosuZ1mXRuq09vmwRqE/6tpFzFfh+00eN0CBsboMINq4LTLqSo+FUW5
 4G5Eyj7NfgcP8i7kZfKmxQVLv6yt/mx9JdgI24zdWqVBr4jke4757ll6edmC7p9vkcwh
 Mq3gOaAvZBgigkR70cU4f+Fms5hmQUqfukqytP6xXaXm3Z2Lp77a6oFoLODYXDdG+Sxs
 Jn5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+sAekzpNchAWiWcpNI29L+qzHSuagA1aMBjJkSIqJDdXI8rZiQ1Mj4lSa6RNUUlNyA2eST80M4bL7@nongnu.org,
 AJvYcCW2JmZBcBO4XJiL7mOzkA5Gsomvoo0hJcSCCkvLl/BEosiC8fwI9T5hfTduyq4lHqPz1ocKz568FjY5hg==@nongnu.org
X-Gm-Message-State: AOJu0Yx7s/8wvyUdG9pWGfJe5hGyxIn1jvfzMuM7ih5Hyc6hKG/IoFG7
 12WsE5jBE45+uj3rIygyuvHRz35uV9zdrUzrBs1K0n5+2zwq88GCbDpqXCNfMQDaWcCq1cBPLhA
 jOLCwLptnL8KQka7hNN0YAsMgC/h2KOzTJd3/
X-Gm-Gg: ASbGncvAFEUmPQ6rFplsamtql1LWfD8pC2CIYtEkNyX4i7JdvHa1qgpJvmAv6JuXdFt
 6B499mvHnSjlbz4eY+Q6RtZT0eiNlrReRyQfETA/CisWjBu1GtK1lSBxi/DNtUS/jvvbVxUXWrx
 LA5uraZj7Tsd4IlnhIZIRCrfkosZ8pE/vr3Vpx1ipRSjNjRJRP7bS5sw==
X-Google-Smtp-Source: AGHT+IEprtCSXw3BEBV7KHv4oCikH30DnhUXQwqgZ6qtpNWlXi7+UVx4ofIfrh2E6AKZkAODi7OqROJd+8ywVRH9Pz0=
X-Received: by 2002:a17:903:2288:b0:234:9dce:74e3 with SMTP id
 d9443c01a7336-2366781613emr137475255ad.2.1750069737148; Mon, 16 Jun 2025
 03:28:57 -0700 (PDT)
MIME-Version: 1.0
References: <20250515112908.383693-1-f.ebner@proxmox.com>
 <20250515112908.383693-2-f.ebner@proxmox.com>
 <CAOi1vP94WJ7r1vPXvcpGZTs2xf6TZ=p=EmVGQvwipftufaYAMw@mail.gmail.com>
 <aE_pbAS_gS12Fp8f@redhat.com>
In-Reply-To: <aE_pbAS_gS12Fp8f@redhat.com>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Mon, 16 Jun 2025 12:28:44 +0200
X-Gm-Features: AX0GCFusGr96N_ea00DCRluAE8UEWBf8S0krizrQW8ZKNolNW8gkNyjHvcVC2zk
Message-ID: <CAOi1vP-oc0XHR28E7JrvZOohL7KZEq7LunYKHfb540W=a8t=wQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] block/rbd: support selected key-value-pairs via QAPI
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Fiona Ebner <f.ebner@proxmox.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, 
 armbru@redhat.com, eblake@redhat.com, hreitz@redhat.com, kwolf@redhat.com, 
 pl@dlhnet.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=idryomov@gmail.com; helo=mail-pl1-x62f.google.com
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

On Mon, Jun 16, 2025 at 11:52=E2=80=AFAM Daniel P. Berrang=C3=A9 <berrange@=
redhat.com> wrote:
>
> On Mon, Jun 16, 2025 at 11:25:54AM +0200, Ilya Dryomov wrote:
> > On Thu, May 15, 2025 at 1:29=E2=80=AFPM Fiona Ebner <f.ebner@proxmox.co=
m> wrote:
> > >
> > > Currently, most Ceph configuration options are not exposed via QAPI.
> > > While it is possible to specify a dedicated Ceph configuration file,
> > > specialized options are often only required for a selection of images
> > > on the RBD storage, not all of them. To avoid the need to generate a
> > > dedicated Ceph configuration file for each image (or for each require=
d
> > > combination of options), support a selection of key-value pairs via
> > > QAPI.
> > >
> > > Initially, this is just 'rbd_cache_policy'. For example, this is
> > > useful with small images used as a pflash for EFI variables. Setting
> > > the 'rbd_cache_policy' to 'writeback' yields a substantial improvemen=
t
> > > there [0].
> > >
> > > The function qemu_rbd_extract_key_value_pairs() was copied/adapted
> > > from the existing qemu_rbd_extract_encryption_create_options().
> > >
> > > [0]: https://bugzilla.proxmox.com/show_bug.cgi?id=3D3329#c9
> > >
> > > Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
>
> snip
>
> > >  ##
> > >  # @BlockdevOptionsRbd:
> > >  #
> > > @@ -4327,6 +4360,9 @@
> > >  #     authentication.  This maps to Ceph configuration option "key".
> > >  #     (Since 3.0)
> > >  #
> > > +# @key-value-pairs: Key-value pairs for additional Ceph configuraton=
.
> > > +#     (Since 10.1)
> > > +#
> > >  # @server: Monitor host address and port.  This maps to the "mon_hos=
t"
> > >  #     Ceph option.
> > >  #
> > > @@ -4342,6 +4378,7 @@
> > >              '*user': 'str',
> > >              '*auth-client-required': ['RbdAuthMode'],
> > >              '*key-secret': 'str',
> > > +            '*key-value-pairs' : 'RbdKeyValuePairs',
> >
> > To side-step all of the above, have you considered implementing
> > a straightforward passthrough to Ceph instead?  Something like
> >
> >   '*key-value-pairs': ['RbdKeyValuePair']
> >
> > where RbdKeyValuePair is just a pair arbitrary strings (and
> > key-value-pairs is thus an optional list of those).  rados_conf_set()
> > would be called just the same but the user would be able to override
> > any Ceph option they wish, not just a few that we thought of here.
>
> Passing through arbitrary key/value pairs as strings is essentially
> abdicating our design responsibility in QAPI. enums would no longer
> be introspectable. Integers / booleans would require abnormal formatting
> by clients. API stability / deprecation promises can no longer be made.
> and more besides.
>
> Given that limitation, if we did go the string pairs route, I would
> expect it to be marked as "unstable" in the QAPI schema, so apps have
> a suitable warning NOT to rely on this.

This sounds sensible to me.  We can continue exposing the most common
Ceph options through a proper QAPI schema but add key-value-pairs as an
alternative low-level route for those who want to avoid dealing with
physical configuration files.

Thanks,

                Ilya

