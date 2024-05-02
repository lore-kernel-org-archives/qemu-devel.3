Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4467EC25B10
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 17:11:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2ZxK-0004BR-0M; Thu, 02 May 2024 13:10:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jinpu.wang@ionos.com>)
 id 1s2ZxI-0004B7-98
 for qemu-devel@nongnu.org; Thu, 02 May 2024 13:10:48 -0400
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jinpu.wang@ionos.com>)
 id 1s2ZxD-0001n4-4z
 for qemu-devel@nongnu.org; Thu, 02 May 2024 13:10:47 -0400
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2e0a2870bceso58558841fa.2
 for <qemu-devel@nongnu.org>; Thu, 02 May 2024 10:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ionos.com; s=google; t=1714669840; x=1715274640; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V937n7SKAOQsmaEFyMkxEdSkPOIJt6K+sZJnhw3hbQ0=;
 b=KsiVgxMewA7gz3aZn1rchrIvnkdcT9GHSOtfIkhWuDCM6kwec4oYL5d+coYAyKixgH
 WTmnaP62d2/VLpPo0a8odAX4rrDVwwP0L3S5fvs8Tgv9nON8dB4mTR/9dGWgu/b9mgWA
 iEu28rAmLIpV7/+WwPOROh/UxqN7V6/Lh/w7OJKSMFeLAJJv3z5uUzMtlhWg2pf5eYBE
 wN5t3DqDzXilBkqUea3Ng2bZTYQrzVSTLTusQEFZ9tYxPJ+hZO6FYcDAE6cbd8Vss1as
 fGcPlb2eblgVpEXZO1gGDUJPT3QiZTPVIggnYFpJhM4yAJkgetEqryhbzLZ+P14Ej3WH
 2Z5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714669840; x=1715274640;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V937n7SKAOQsmaEFyMkxEdSkPOIJt6K+sZJnhw3hbQ0=;
 b=qKY6S6rhk+h3gbLTPSKzR2czoXpe4twZdbUcMVJag5gO4fwYoX9HSaU8ebn4Oz1O/G
 SssFnrBt3Sq8R0NAUj/TW1QkZM0o4GhrXYfkKAUKWlyo7L2Xzxz/cZevT7FcyT/2iVKF
 01SCXJ1klrJn8S57DRATEDyzEO1SEtu5aJ/ZrQ2fqyQgFuA8WKCUsh2yviRxWUNFWvZz
 13vtBcGTBxIn+Oqwx5Pf9hKTSoBY9YkC7+RClCT0NgwRTg6EvOudwJdXjpSjCg6PIAEa
 3eGP3UtJg1IFuRqHNDuQ48t/8qLmUMvkYfG+XzQ+tlnfXUNPPCJ4TS6Fv/HW4EsOpqOG
 CPJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRpt5LYnMxd8H9f/1gHQvFe68+0SkjVMaJM0Q3ygL15x79RPe6iWKYTYMn/Wr38PrC8fRuYVyURC+UUZo5r2hWQz2GBEI=
X-Gm-Message-State: AOJu0Yy42GHkymD7wy/o4RNIitqnH2cUT9mx6O5IWoFLzskpM1YnNJ2Q
 s4wG+jnFcIQQMKIPlycJNb2X2t9NgEtsHgRrPJgviNdS+X8PLcsrXGLr0EhiBQyItRxkIZ+1tPy
 xXKb/upAMmtKJgqMFE2z3TYlVf8JL1DwYBwKRzg==
X-Google-Smtp-Source: AGHT+IF1VsF06dR1NKo7IIwxa3HjPVw3PcVPqPRtWWevfOk44XZDvw7s8rAEs3H1yY8uFtxWbDyebboaVcGlRuXRIxA=
X-Received: by 2002:a05:6512:3119:b0:516:d18b:eae8 with SMTP id
 n25-20020a056512311900b00516d18beae8mr308848lfb.41.1714669839612; Thu, 02 May
 2024 10:10:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAHEcVy7POArt+CmY8dyNTzLJp3XxXgjh3k8=C=9K+_cw1CSJFA@mail.gmail.com>
 <46f5e323-632d-7bda-f2c5-3cfa7b1c6b68@akamai.com> <Zi-1OvxA5MIHjklU@x1n>
 <877cgfe2yw.fsf@pond.sub.org> <ZjClMb-6MddpvHqQ@redhat.com>
 <ZjJgQcPQ29HJsTpY@x1n> <ZjJm6rcqS5EhoKgK@redhat.com> <ZjJqwg1H2nZbcekb@x1n>
 <ac86d9a7-02c6-9a07-4135-8327d17aca6b@akamai.com>
 <CAMGffEm-PXOBi-jR3CTe5dwT12EgOAh1h0KKaBH7=1BETCbvWg@mail.gmail.com>
 <ZjO9FQjrV9Ph23vU@x1n>
In-Reply-To: <ZjO9FQjrV9Ph23vU@x1n>
From: Jinpu Wang <jinpu.wang@ionos.com>
Date: Thu, 2 May 2024 19:10:28 +0200
Message-ID: <CAMGffEkTQ1=2TtboqEEL23_Sib1BL43aAqMdrrbjCRn4LEN=3g@mail.gmail.com>
Subject: Re: [PATCH-for-9.1 v2 2/3] migration: Remove RDMA protocol handling
To: Peter Xu <peterx@redhat.com>
Cc: Michael Galaxy <mgalaxy@akamai.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Yu Zhang <yu.zhang@ionos.com>, 
 "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>,
 Elmar Gerdes <elmar.gerdes@ionos.com>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Yuval Shaia <yuval.shaia.ml@gmail.com>, Kevin Wolf <kwolf@redhat.com>,
 Prasanna Kumar Kalever <prasanna.kalever@redhat.com>, 
 Cornelia Huck <cohuck@redhat.com>, Michael Roth <michael.roth@amd.com>, 
 Prasanna Kumar Kalever <prasanna4324@gmail.com>, 
 "integration@gluster.org" <integration@gluster.org>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "devel@lists.libvirt.org" <devel@lists.libvirt.org>, 
 Hanna Reitz <hreitz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Thomas Huth <thuth@redhat.com>, 
 Eric Blake <eblake@redhat.com>, Song Gao <gaosong@loongson.cn>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, arei.gonglei@huawei.com, 
 pannengyuan@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: permerror client-ip=2a00:1450:4864:20::231;
 envelope-from=jinpu.wang@ionos.com; helo=mail-lj1-x231.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

Hi Peter

On Thu, May 2, 2024 at 6:20=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote:
>
> On Thu, May 02, 2024 at 03:30:58PM +0200, Jinpu Wang wrote:
> > Hi Michael, Hi Peter,
> >
> >
> > On Thu, May 2, 2024 at 3:23=E2=80=AFPM Michael Galaxy <mgalaxy@akamai.c=
om> wrote:
> > >
> > > Yu Zhang / Jinpu,
> > >
> > > Any possibility (at your lesiure, and within the disclosure rules of
> > > your company, IONOS) if you could share any of your performance
> > > information to educate the group?
> > >
> > > NICs have indeed changed, but not everybody has 100ge mellanox cards =
at
> > > their disposal. Some people don't.
> > Our staging env is with 100 Gb/s IB environment.
> > We will have a new setup in the coming months with Ethernet (RoCE), we
> > will run some performance
> > comparison when we have the environment ready.
>
> Thanks both.  Please keep us posted.
>
> Just to double check, we're comparing "tcp:" v.s. "rdma:", RoCE is not
> involved, am I right?
kinds of. Our new hardware is RDMA capable, we can configure it to run
in "rdma" transport or "tcp"
it is more straight comparison,
When run "rdma" transport, RoCE is involved, eg the
rdma-core/ibverbs/rdmacm/vendor verbs driver are used.
>
> The other note is that the comparison needs to be with multifd enabled fo=
r
> the "tcp:" case.  I'd suggest we start with 8 threads if it's 100Gbps.
>
> I think I can still fetch some 100Gbps or even 200Gbps nics around our la=
bs
> without even waiting for months.  If you want I can try to see how we can
> test together.  And btw I don't think we need a cluster, IIUC we simply
> need two hosts, 100G nic on both sides?  IOW, it seems to me we only need
> two cards just for experiments, systems that can drive the cards, and a
> wire supporting 100G?

Yes, the simple setup can be just two hosts directly connected. This remind=
 me,
I may also able to find a test setup with 100 G nic in lab, will keep
you posted.

Regards!
>
> >
> > >
> > > - Michael
> >
> > Thx!
> > Jinpu
> > >
> > > On 5/1/24 11:16, Peter Xu wrote:
> > > > On Wed, May 01, 2024 at 04:59:38PM +0100, Daniel P. Berrang=C3=A9 w=
rote:
> > > >> On Wed, May 01, 2024 at 11:31:13AM -0400, Peter Xu wrote:
> > > >>> What I worry more is whether this is really what we want to keep =
rdma in
> > > >>> qemu, and that's also why I was trying to request for some seriou=
s
> > > >>> performance measurements comparing rdma v.s. nics.  And here when=
 I said
> > > >>> "we" I mean both QEMU community and any company that will support=
 keeping
> > > >>> rdma around.
> > > >>>
> > > >>> The problem is if NICs now are fast enough to perform at least eq=
ually
> > > >>> against rdma, and if it has a lower cost of overall maintenance, =
does it
> > > >>> mean that rdma migration will only be used by whoever wants to ke=
ep them in
> > > >>> the products and existed already?  In that case we should simply =
ask new
> > > >>> users to stick with tcp, and rdma users should only drop but not =
increase.
> > > >>>
> > > >>> It seems also destined that most new migration features will not =
support
> > > >>> rdma: see how much we drop old features in migration now (which r=
dma
> > > >>> _might_ still leverage, but maybe not), and how much we add mostl=
y multifd
> > > >>> relevant which will probably not apply to rdma at all.  So in gen=
eral what
> > > >>> I am worrying is a both-loss condition, if the company might be e=
asier to
> > > >>> either stick with an old qemu (depending on whether other new fea=
tures are
> > > >>> requested to be used besides RDMA alone), or do periodic rebase w=
ith RDMA
> > > >>> downstream only.
> > > >> I don't know much about the originals of RDMA support in QEMU and =
why
> > > >> this particular design was taken. It is indeed a huge maint burden=
 to
> > > >> have a completely different code flow for RDMA with 4000+ lines of
> > > >> custom protocol signalling which is barely understandable.
> > > >>
> > > >> I would note that /usr/include/rdma/rsocket.h provides a higher le=
vel
> > > >> API that is a 1-1 match of the normal kernel 'sockets' API. If we =
had
> > > >> leveraged that, then QIOChannelSocket class and the QAPI SocketAdd=
ress
> > > >> type could almost[1] trivially have supported RDMA. There would ha=
ve
> > > >> been almost no RDMA code required in the migration subsystem, and =
all
> > > >> the modern features like compression, multifd, post-copy, etc woul=
d
> > > >> "just work".
> > > >>
> > > >> I guess the 'rsocket.h' shim may well limit some of the possible
> > > >> performance gains, but it might still have been a better tradeoff
> > > >> to have not quite so good peak performance, but with massively
> > > >> less maint burden.
> > > > My understanding so far is RDMA is sololy for performance but nothi=
ng else,
> > > > then it's a question on whether rdma existing users would like to d=
o so if
> > > > it will run slower.
> > > >
> > > > Jinpu mentioned on the explicit usages of ib verbs but I am just mo=
stly
> > > > quotting that word as I don't really know such details:
> > > >
> > > > https://urldefense.com/v3/__https://lore.kernel.org/qemu-devel/CAMG=
ffEm2TWJxOPcNQTQ1Sjytf5395dBzTCMYiKRqfxDzJwSN6A@mail.gmail.com/__;!!GjvTz_v=
k!W6-HGWM-XkF_52am249DrLIDQeZctVOHg72LvOHGUcwxqQM5mY0GNYYl-yNJslN7A5GfLOew9=
oW_kg$
> > > >
> > > > So not sure whether that applies here too, in that having qiochanne=
l
> > > > wrapper may not allow direct access to those ib verbs.
> > > >
> > > > Thanks,
> > > >
> > > >> With regards,
> > > >> Daniel
> > > >>
> > > >> [1] "almost" trivially, because the poll() integration for rsocket=
s
> > > >>      requires a bit more magic sauce since rsockets FDs are not
> > > >>      really FDs from the kernel's POV. Still, QIOCHannel likely ca=
n
> > > >>      abstract that probme.
> > > >> --
> > > >> |: https://urldefense.com/v3/__https://berrange.com__;!!GjvTz_vk!W=
6-HGWM-XkF_52am249DrLIDQeZctVOHg72LvOHGUcwxqQM5mY0GNYYl-yNJslN7A5GfLOfyTmFF=
UQ$       -o-    https://urldefense.com/v3/__https://www.flickr.com/photos/=
dberrange__;!!GjvTz_vk!W6-HGWM-XkF_52am249DrLIDQeZctVOHg72LvOHGUcwxqQM5mY0G=
NYYl-yNJslN7A5GfLOf8A5OC0Q$  :|
> > > >> |: https://urldefense.com/v3/__https://libvirt.org__;!!GjvTz_vk!W6=
-HGWM-XkF_52am249DrLIDQeZctVOHg72LvOHGUcwxqQM5mY0GNYYl-yNJslN7A5GfLOf3gffAd=
g$          -o-            https://urldefense.com/v3/__https://fstop138.ber=
range.com__;!!GjvTz_vk!W6-HGWM-XkF_52am249DrLIDQeZctVOHg72LvOHGUcwxqQM5mY0G=
NYYl-yNJslN7A5GfLOfPMofYqw$  :|
> > > >> |: https://urldefense.com/v3/__https://entangle-photo.org__;!!GjvT=
z_vk!W6-HGWM-XkF_52am249DrLIDQeZctVOHg72LvOHGUcwxqQM5mY0GNYYl-yNJslN7A5GfLO=
eQ5jjAeQ$     -o-    https://urldefense.com/v3/__https://www.instagram.com/=
dberrange__;!!GjvTz_vk!W6-HGWM-XkF_52am249DrLIDQeZctVOHg72LvOHGUcwxqQM5mY0G=
NYYl-yNJslN7A5GfLOfhaDF9WA$  :|
> > > >>
> >
>
> --
> Peter Xu
>

