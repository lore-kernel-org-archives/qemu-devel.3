Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9FCEC27C4F
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2024 00:57:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJjci-0003Hq-Cf; Tue, 18 Jun 2024 20:56:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sJjcf-0003Gj-9j
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 20:56:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sJjca-00053J-1a
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 20:56:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718758576;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qfSKhom+OeCLrgTpu6WEhLwdpcmJcRar6Ox5TasflVw=;
 b=ipPEBwWfANWOUtY4HaZqeMcvTUDoCRgS5iqa7VVe1frsQ0dFzAcRs7HubliicjSa8QJQj+
 NnGJUdt2Y40E2FLqCNU5RG3fy0wJoKO/EgXVh08tGlJ0CPydHGoAO5sQlKEujL9WcKSl9b
 jg6vtz7RuT+eud2wHeWkmgVpQQ2l1EE=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-92-8G0W4gU1P-eowTzv7fTbFQ-1; Tue, 18 Jun 2024 20:56:12 -0400
X-MC-Unique: 8G0W4gU1P-eowTzv7fTbFQ-1
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-1f733390185so49922005ad.3
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 17:56:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718758571; x=1719363371;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qfSKhom+OeCLrgTpu6WEhLwdpcmJcRar6Ox5TasflVw=;
 b=JZXgaZ9sDc8h4LQtjDQmAVPXF8NQSUwvEy1iQC66PKhB5p7YOYS2eWhH2OTa7NH00g
 jnl5OgWocqDDPZUw/RMU+/brYJZF5wLYaDqpUxlri21VEo/JwSOrzm3t5duqdGPFiZYv
 R1MughAbN9jrl10GuyTbXLU0Z33zNUykMHPlqrG/u5d+HrQxMQ6GWIqO7TgNuCAM7nS1
 w4DJz4PdRTOMF3neWc+5tv9W6oGxUTmno3wQ5pq4c+D6oAq+nbWipAuSLhxXqTR+cQNC
 yahtoac4vhGnV5nzCd9qgXaN1sefVWltj25tF18aU/rzNfHG211pMwqjnRjAl0Iiqp/L
 ovUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQ5snhJU9iipqUeFGJnFTpLqbPIMhvAOAHrBbhpiWhHOZ06tHtiFiY43WzXPm+XZ8qVpWKYRi/h4edZKH9OFkqhcD10i8=
X-Gm-Message-State: AOJu0YwoSywedTXkNJCK+It/gqKnJG41cDssJxRtt2uM4EF17+ccQxHN
 swnJ9qdqgHp6LgtxnKSoq8vkOU5aVdftJ4xJcxh/1zqX4bpV5uzgxEFpGcDfdrtCzPCW5P4z+C8
 qZ6Yy/sRmHqKPdvrflXUCed5jHMAj6hqd5qYFJmX1PL3Y3Z4hvDF02UBBfMgrwCuK596GInl+jj
 6sLEh9CB+C+vYcd929bqUwVdN/rh8=
X-Received: by 2002:a17:902:e543:b0:1f7:187f:cb5b with SMTP id
 d9443c01a7336-1f9aa46612bmr11437735ad.64.1718758570765; 
 Tue, 18 Jun 2024 17:56:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEe9OdyxkJrOKEelYR3vEoycV3YE248mRZK4GlWnotBunyVewhR5/8UzMU3EdzLaF9ERfLNNkhsx8NnKV4ZU4o=
X-Received: by 2002:a17:902:e543:b0:1f7:187f:cb5b with SMTP id
 d9443c01a7336-1f9aa46612bmr11437525ad.64.1718758570098; Tue, 18 Jun 2024
 17:56:10 -0700 (PDT)
MIME-Version: 1.0
References: <CAFn=p-ZmjLKRN1kKo1iM_tiijYbOEqt5=vRg7WoAXuQ6E8Rm+A@mail.gmail.com>
 <Zmsad48PjR66xpA3@redhat.com>
In-Reply-To: <Zmsad48PjR66xpA3@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Tue, 18 Jun 2024 20:55:58 -0400
Message-ID: <CAFn=p-bsrCZKSpK9v3UxNT+SYnjebLyb=78dU8-HbCLMeJR=tA@mail.gmail.com>
Subject: Re: Historical QAPI schema parser, "compiled schema",
 and qapi-schema-diff
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, 
 Victor Toso de Carvalho <victortoso@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000069ff6061b33aa1d"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.148,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--000000000000069ff6061b33aa1d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2024 at 12:12=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@=
redhat.com>
wrote:

> On Thu, Jun 13, 2024 at 02:13:15AM -0400, John Snow wrote:
> > Hi, recently I've been working on overhauling our QMP documentation; se=
e
> > https://jsnow.gitlab.io/qemu/qapi/index.html for a recent
> work-in-progress
> > page showcasing this.
> >
> > As part of this project, Markus and I decided it'd be nice to be able t=
o
> > auto-generate "Since" information. The short reason for 'why' is becaus=
e
> > since info hard-coded into doc comments may not be accurate with regard=
s
> to
> > the wire protocol availability for a given field when a QAPI definition
> is
> > shared or inherited by multiple sources. If we can generate it, it shou=
ld
> > always be accurate.
> >
> > So, I've prototyped three things:
> >
> > (1) An out-of-tree fork of the QAPI generator that is capable of parsin=
g
> > qemu-commands.hx, qmp-commands.hx, and all versions of our
> qapi-schema.json
> > files going all the way back to v0.12.0.
> >
> > It accomplishes this with some fairly brutish hacks that I never expect
> to
> > need to check in to qemu.git.
> >
> > (2) A schema "compiler", a QAPI generator module that takes a parsed
> Schema
> > and produces a single-file JSON Schema document that describes every
> > command and event as it exists on the wire without using type names or
> any
> > information not considered to be "API".
> >
> > This part *would* need to be checked in to qemu.git (if we go in this
> > direction.)
> > The compiled historical schema would also get checked in, for the QAPI
> > parser to reference against to generate the since information.
>
> The upside with checking in every historical schema is that we
> have a set of self-contained schemas where you can see everything
> at a glance for each version.
>

Yep. It's "dumb" but very easy to access and work with.


>
> The downside with checking in every historical schema is that between
> any adjacent pair of schemas 99% of the content is identical. IOW we
> are very wasteful of storage.
>

... Also agree. Because these files avoid shared types as an explicit
design goal, and JSON Schema is *very* verbose, these files get extremely
large while saying little.

I chose them for the proof of concept because they're an existing
standard/format I didn't have to engineer or reason about heavily, and
really no other reason.


>
> Looking at your other mail about schema diffs, I wonder if we the
> diff format you show there can kill two birds with one stone.
>
>   https://lists.nongnu.org/archive/html/qemu-devel/2024-06/msg02398.html
>
> In my reply I had illustrated a variant of your format:
>
>  - x-query-rdma
>  -     returns.human-readable-text: str
>  . blockdev-backup
>  +     arguments.discard-source: Optional<boolean>
>  . migrate
>  -    arguments.blk: Optional<boolean>
>  -    arguments.inc: Optional<boolean>
>  . object-add
>  .    arguments.qom-type: enum
>  +        'sev-snp-guest'
>  +    arguments[sev-guest].legacy-vm-type: Optional<boolean>
>  +    arguments[sev-snp-guest].author-key-enabled: Optional<boolean>
>  +    arguments[sev-snp-guest].cbitpos: Optional<integer>
>
>
> Where '.' is just pre-existing context, and +/- have the obvious
> meaning for the 2 given versions.
>
> What if, we append a version number to *every* line, and exclusively
> use +/-.
>
> Taking just one small command:
>
>  + 6.2.0: x-query-rdma
>  + 6.2.0:    returns.human-readable-text: str
>  - 9.1.0: x-query-rdma
>
> This tell us 'x-query-rdma' was added in 6.2.0, the
> 'human-readable-text' parameter arrived at the same
> time, and the whole command was then deleted in 9.1.0
> That has implicit property deletion, but for completeness
> we could be explicit about each property when deleting
> a command:
>
>  + 6.2.0: x-query-rdma
>  + 6.2.0:    returns.human-readable-text: str
>  - 9.1.0:    returns.human-readable-text: str
>  - 9.1.0: x-query-rdma
>
> Taking the more complex 'object-add' command
>
>  +  2.0.0: object-add
>  +  2.0.0:   arguments.qom-type: enum
>  +  2.0.0:     '....'
>  + 2.11.0:     'sev-guest'
>  +  9.1.0:     'sev-snp-guest'
>  + 2.11.0:   arguments[sev-guest].policy: uint32
>  + 2.11.0:   arguments[sev-guest].session-file: str
>  + 2.11.0:   arguments[sev-guest].dh-cert: str
>  +  9.1.0:   arguments[sev-guest].legacy-vm-type: Optional<boolean>
>  +  9.1.0:   arguments[sev-snp-guest].author-key-enabled: Optional<boolea=
n>
>  +  9.1.0:   arguments[sev-snp-guest].cbitpos: Optional<integer>
>
>
> IOW, object-add was introduced in 2.0.0. The 'sev-guest' enum
> variant was added in 2.11.0 with various fields at the same
> time. The 'sev-guest' enum variant got an exctra field in 9.1.0
> The 'sev-snp-guest' enum variant was added in 9.1.0 with some
> fields.
>
>
> For fields which change from Optional <-> Required, that could
> be modelled simply as parameter deletion + addition in the
> same version eg hypothetically lets say the 'sev-guest' field
> 'policy' had changed, we would see:
>
>  +  2.0.0: object-add
>  +  2.0.0:   arguments.qom-type: enum
>  +  2.0.0:     '....'
>  + 2.11.0:     'sev-guest'
>  +  9.1.0:     'sev-snp-guest'
>  + 2.11.0:   arguments[sev-guest].policy: uint32
>  -  6.2.0:   arguments[sev-guest].policy: uint32
>  +  6.2.0:   arguments[sev-guest].policy: Optional<uint32>
>  + 2.11.0:   arguments[sev-guest].session-file: str
>  + 2.11.0:   arguments[sev-guest].dh-cert: str
>  +  9.1.0:   arguments[sev-guest].legacy-vm-type: Optional<boolean>
>  +  9.1.0:   arguments[sev-snp-guest].author-key-enabled: Optional<boolea=
n>
>  +  9.1.0:   arguments[sev-snp-guest].cbitpos: Optional<integer>
>
>
Very interesting idea, I think this could be a reasonable compromise. I'll
have to spend some time prototyping it (and digesting your other mail,
too), but tentatively, I like the idea. Thanks a lot for really digging
into both of these mails to give your feedback on this subproject.

(IOW: I think I like it, but haven't sat with it enough to really know if
there's anything it doesn't do that I need it to do. Prototyping it will
tell me. One concern I might have is that I'll need some custom code to
compare a QAPISchema object against the stored history file in order to
amend that history file. I'm not sure how complex that will be at present,
but admit my current solution is very egregious with regards to SLOC in the
git repo. And it's not as if the JSON Schema writing/reading code I
prototyped is particularly short, either.)


>
> Incidentally, if going down this route, I think I would NOT
> have 1 file with the whole schema history, but have 1 file
> per command / event. eg qapi/history/object-add.txt,
> qapi/history/x-query-rdma.txt, qapi/history/VFIO_MIGRATION.txt,
> etc. This will make it trivial for a person to focus in on
> changes in the command they care about, likely without even
> needing a schema diff tool much of the time, as the per-command
> files will often be concise enough you can consider the full
> history without filtering.
>

Interesting idea... might be a lot of files, but I suppose those don't
really *cost* anything, now do they? :)

I guess you lose out on a good summary, but a tool can just parse
qapi/history/*.txt or whatnot and concatenate the results to stdout for
you; I suppose it'd be little more than `cat qapi/history/*.txt | grep
"9\.0\.0"` or similar.


>
> > (3) A script that can diff two compiled schema, showing a change report
> > between two versions. (I sent an email earlier today/yesterday showing
> > example output of this script.) This one was more for "fun", but it
> helped
> > prove all the other parts were working correctly, and it might be usefu=
l
> in
> > the future when auditing changes during the RC phase. We may well decid=
e
> to
> > commit this script upstream, or one like it.
>
> With a single file containing all deltas, where each line is
> version annotated, the "diff" tool becomes little more than
> something which can 'grep' for lines in the file which have
> a version number within the desired range. In fact it can also
> optionally offer something better than a diff, as instead of
> showing you only the orignal state and result state, it
> can trivially shows you any intermediate changes and what
> version they happened with.
>
> eg if you asked for a diff between 2.0.0 and 9.1.0, and there
> was a command or property that was added in 4.0.0 and deleted
> in 6.0.0, a traditional diff will not tell you about this. You'll
> never notice it ever existed.
>
> A "history grep" showing the set of changes between 2 versions
> will highlight things that come + go, which can be quite
> useful for understanding API evolution I think.
>

Good point. The existing diff tool I wrote was just a prototype to prove
"this sort of thing was possible", but I didn't put much thought into its
design beyond "It was quick to write as a proof of concept".

Maximizing this information's utility for use with existing utilities
without needing to maintain lots of our own script code is a great design
goal to keep in mind.


>
>
>
> With regards,
> Daniel
> --
> |: https://berrange.com      -o-
> https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-
> https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-
> https://www.instagram.com/dberrange :|
>

Thanks again! I'm going to re-focus on some of the more immediate changes
for the documentation project for now, but I'll no doubt be returning to
the historical parsing / since information subproject before too long --
just didn't want to sit on your email for too long so as to appear
ungrateful ;)

I'll loop you into future discussions on this subproject when I pick it
back up (Hopefully, not too far in the future.) -- and I'll make sure to
keep it on-list. Markus and I haven't gone too in-depth on this part yet,
so I figure I'll pick the prototyping back up when he's chewed through more
of my other patches and all of the Maintainers that need to care about this
are paying active attention. (Sorry for all the patches, Markus... You
asked for it!)

--js

--000000000000069ff6061b33aa1d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, Jun 13, 2024 at 12:12=E2=80=
=AFPM Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.com">be=
rrange@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex">On Thu, Jun 13, 2024 at 02:13:15AM -0400, John Snow wrote:=
<br>
&gt; Hi, recently I&#39;ve been working on overhauling our QMP documentatio=
n; see<br>
&gt; <a href=3D"https://jsnow.gitlab.io/qemu/qapi/index.html" rel=3D"norefe=
rrer" target=3D"_blank">https://jsnow.gitlab.io/qemu/qapi/index.html</a> fo=
r a recent work-in-progress<br>
&gt; page showcasing this.<br>
&gt; <br>
&gt; As part of this project, Markus and I decided it&#39;d be nice to be a=
ble to<br>
&gt; auto-generate &quot;Since&quot; information. The short reason for &#39=
;why&#39; is because<br>
&gt; since info hard-coded into doc comments may not be accurate with regar=
ds to<br>
&gt; the wire protocol availability for a given field when a QAPI definitio=
n is<br>
&gt; shared or inherited by multiple sources. If we can generate it, it sho=
uld<br>
&gt; always be accurate.<br>
&gt; <br>
&gt; So, I&#39;ve prototyped three things:<br>
&gt; <br>
&gt; (1) An out-of-tree fork of the QAPI generator that is capable of parsi=
ng<br>
&gt; qemu-commands.hx, qmp-commands.hx, and all versions of our qapi-schema=
.json<br>
&gt; files going all the way back to v0.12.0.<br>
&gt; <br>
&gt; It accomplishes this with some fairly brutish hacks that I never expec=
t to<br>
&gt; need to check in to qemu.git.<br>
&gt; <br>
&gt; (2) A schema &quot;compiler&quot;, a QAPI generator module that takes =
a parsed Schema<br>
&gt; and produces a single-file JSON Schema document that describes every<b=
r>
&gt; command and event as it exists on the wire without using type names or=
 any<br>
&gt; information not considered to be &quot;API&quot;.<br>
&gt; <br>
&gt; This part *would* need to be checked in to qemu.git (if we go in this<=
br>
&gt; direction.)<br>
&gt; The compiled historical schema would also get checked in, for the QAPI=
<br>
&gt; parser to reference against to generate the since information.<br>
<br>
The upside with checking in every historical schema is that we<br>
have a set of self-contained schemas where you can see everything<br>
at a glance for each version.<br></blockquote><div><br></div><div>Yep. It&#=
39;s &quot;dumb&quot; but very easy to access and work with.<br></div><div>=
=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
The downside with checking in every historical schema is that between<br>
any adjacent pair of schemas 99% of the content is identical. IOW we<br>
are very wasteful of storage.<br></blockquote><div><br></div><div>... Also =
agree. Because these files avoid shared types as an explicit design goal, a=
nd JSON Schema is *very* verbose, these files get extremely large while say=
ing little.</div><div><br></div><div>I chose them for the proof of concept =
because they&#39;re an existing standard/format I didn&#39;t have to engine=
er or reason about heavily, and really no other reason.<br></div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Looking at your other mail about schema diffs, I wonder if we the<br>
diff format you show there can kill two birds with one stone.<br>
<br>
=C2=A0 <a href=3D"https://lists.nongnu.org/archive/html/qemu-devel/2024-06/=
msg02398.html" rel=3D"noreferrer" target=3D"_blank">https://lists.nongnu.or=
g/archive/html/qemu-devel/2024-06/msg02398.html</a><br>
<br>
In my reply I had illustrated a variant of your format:<br>
<br>
=C2=A0- x-query-rdma<br>
=C2=A0-=C2=A0 =C2=A0 =C2=A0returns.human-readable-text: str<br>
=C2=A0. blockdev-backup<br>
=C2=A0+=C2=A0 =C2=A0 =C2=A0arguments.discard-source: Optional&lt;boolean&gt=
;<br>
=C2=A0. migrate<br>
=C2=A0-=C2=A0 =C2=A0 arguments.blk: Optional&lt;boolean&gt;<br>
=C2=A0-=C2=A0 =C2=A0 arguments.inc: Optional&lt;boolean&gt;<br>
=C2=A0. object-add<br>
=C2=A0.=C2=A0 =C2=A0 arguments.qom-type: enum<br>
=C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;sev-snp-guest&#39;<br>
=C2=A0+=C2=A0 =C2=A0 arguments[sev-guest].legacy-vm-type: Optional&lt;boole=
an&gt;<br>
=C2=A0+=C2=A0 =C2=A0 arguments[sev-snp-guest].author-key-enabled: Optional&=
lt;boolean&gt;<br>
=C2=A0+=C2=A0 =C2=A0 arguments[sev-snp-guest].cbitpos: Optional&lt;integer&=
gt;<br>
<br>
<br>
Where &#39;.&#39; is just pre-existing context, and +/- have the obvious<br=
>
meaning for the 2 given versions.<br>
<br>
What if, we append a version number to *every* line, and exclusively<br>
use +/-.<br>
<br>
Taking just one small command:<br>
<br>
=C2=A0+ 6.2.0: x-query-rdma<br>
=C2=A0+ 6.2.0:=C2=A0 =C2=A0 returns.human-readable-text: str<br>
=C2=A0- 9.1.0: x-query-rdma<br>
<br>
This tell us &#39;x-query-rdma&#39; was added in 6.2.0, the<br>
&#39;human-readable-text&#39; parameter arrived at the same<br>
time, and the whole command was then deleted in 9.1.0<br>
That has implicit property deletion, but for completeness<br>
we could be explicit about each property when deleting<br>
a command:<br>
<br>
=C2=A0+ 6.2.0: x-query-rdma<br>
=C2=A0+ 6.2.0:=C2=A0 =C2=A0 returns.human-readable-text: str<br>
=C2=A0- 9.1.0:=C2=A0 =C2=A0 returns.human-readable-text: str<br>
=C2=A0- 9.1.0: x-query-rdma<br>
<br>
Taking the more complex &#39;object-add&#39; command<br>
<br>
=C2=A0+=C2=A0 2.0.0: object-add<br>
=C2=A0+=C2=A0 2.0.0:=C2=A0 =C2=A0arguments.qom-type: enum<br>
=C2=A0+=C2=A0 2.0.0:=C2=A0 =C2=A0 =C2=A0&#39;....&#39;<br>
=C2=A0+ 2.11.0:=C2=A0 =C2=A0 =C2=A0&#39;sev-guest&#39;<br>
=C2=A0+=C2=A0 9.1.0:=C2=A0 =C2=A0 =C2=A0&#39;sev-snp-guest&#39;<br>
=C2=A0+ 2.11.0:=C2=A0 =C2=A0arguments[sev-guest].policy: uint32<br>
=C2=A0+ 2.11.0:=C2=A0 =C2=A0arguments[sev-guest].session-file: str<br>
=C2=A0+ 2.11.0:=C2=A0 =C2=A0arguments[sev-guest].dh-cert: str<br>
=C2=A0+=C2=A0 9.1.0:=C2=A0 =C2=A0arguments[sev-guest].legacy-vm-type: Optio=
nal&lt;boolean&gt;<br>
=C2=A0+=C2=A0 9.1.0:=C2=A0 =C2=A0arguments[sev-snp-guest].author-key-enable=
d: Optional&lt;boolean&gt;<br>
=C2=A0+=C2=A0 9.1.0:=C2=A0 =C2=A0arguments[sev-snp-guest].cbitpos: Optional=
&lt;integer&gt;<br>
<br>
<br>
IOW, object-add was introduced in 2.0.0. The &#39;sev-guest&#39; enum<br>
variant was added in 2.11.0 with various fields at the same<br>
time. The &#39;sev-guest&#39; enum variant got an exctra field in 9.1.0<br>
The &#39;sev-snp-guest&#39; enum variant was added in 9.1.0 with some<br>
fields.<br>
<br>
<br>
For fields which change from Optional &lt;-&gt; Required, that could<br>
be modelled simply as parameter deletion + addition in the<br>
same version eg hypothetically lets say the &#39;sev-guest&#39; field<br>
&#39;policy&#39; had changed, we would see:<br>
<br>
=C2=A0+=C2=A0 2.0.0: object-add<br>
=C2=A0+=C2=A0 2.0.0:=C2=A0 =C2=A0arguments.qom-type: enum<br>
=C2=A0+=C2=A0 2.0.0:=C2=A0 =C2=A0 =C2=A0&#39;....&#39;<br>
=C2=A0+ 2.11.0:=C2=A0 =C2=A0 =C2=A0&#39;sev-guest&#39;<br>
=C2=A0+=C2=A0 9.1.0:=C2=A0 =C2=A0 =C2=A0&#39;sev-snp-guest&#39;<br>
=C2=A0+ 2.11.0:=C2=A0 =C2=A0arguments[sev-guest].policy: uint32<br>
=C2=A0-=C2=A0 6.2.0:=C2=A0 =C2=A0arguments[sev-guest].policy: uint32<br>
=C2=A0+=C2=A0 6.2.0:=C2=A0 =C2=A0arguments[sev-guest].policy: Optional&lt;u=
int32&gt;<br>
=C2=A0+ 2.11.0:=C2=A0 =C2=A0arguments[sev-guest].session-file: str<br>
=C2=A0+ 2.11.0:=C2=A0 =C2=A0arguments[sev-guest].dh-cert: str<br>
=C2=A0+=C2=A0 9.1.0:=C2=A0 =C2=A0arguments[sev-guest].legacy-vm-type: Optio=
nal&lt;boolean&gt;<br>
=C2=A0+=C2=A0 9.1.0:=C2=A0 =C2=A0arguments[sev-snp-guest].author-key-enable=
d: Optional&lt;boolean&gt;<br>
=C2=A0+=C2=A0 9.1.0:=C2=A0 =C2=A0arguments[sev-snp-guest].cbitpos: Optional=
&lt;integer&gt;<br>
<br></blockquote><div><br></div><div>Very interesting idea, I think this co=
uld be a reasonable compromise. I&#39;ll have to spend some time prototypin=
g it (and digesting your other mail, too), but tentatively, I like the idea=
. Thanks a lot for really digging into both of these mails to give your fee=
dback on this subproject.</div><div><br></div><div>(IOW: I think I like it,=
 but haven&#39;t sat with it enough to really know if there&#39;s anything =
it doesn&#39;t do that I need it to do. Prototyping it will tell me. One co=
ncern I might have is that I&#39;ll need some custom code to compare a QAPI=
Schema object against the stored history file in order to amend that histor=
y file. I&#39;m not sure how complex that will be at present, but admit my =
current solution is very egregious with regards to SLOC in the git repo. An=
d it&#39;s not as if the JSON Schema writing/reading code I prototyped is p=
articularly short, either.)<br></div><div>=C2=A0</div><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex">
<br>
Incidentally, if going down this route, I think I would NOT<br>
have 1 file with the whole schema history, but have 1 file<br>
per command / event. eg qapi/history/object-add.txt,<br>
qapi/history/x-query-rdma.txt, qapi/history/VFIO_MIGRATION.txt,<br>
etc. This will make it trivial for a person to focus in on<br>
changes in the command they care about, likely without even<br>
needing a schema diff tool much of the time, as the per-command<br>
files will often be concise enough you can consider the full<br>
history without filtering.<br></blockquote><div><br></div><div>Interesting =
idea... might be a lot of files, but I suppose those don&#39;t really *cost=
* anything, now do they? :)</div><div><br></div><div>I guess you lose out o=
n a good summary, but a tool can just parse qapi/history/*.txt or whatnot a=
nd concatenate the results to stdout for you; I suppose it&#39;d be little =
more than `cat qapi/history/*.txt | grep &quot;9\.0\.0&quot;` or similar.</=
div><div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
<br>
&gt; (3) A script that can diff two compiled schema, showing a change repor=
t<br>
&gt; between two versions. (I sent an email earlier today/yesterday showing=
<br>
&gt; example output of this script.) This one was more for &quot;fun&quot;,=
 but it helped<br>
&gt; prove all the other parts were working correctly, and it might be usef=
ul in<br>
&gt; the future when auditing changes during the RC phase. We may well deci=
de to<br>
&gt; commit this script upstream, or one like it.<br>
<br>
With a single file containing all deltas, where each line is<br>
version annotated, the &quot;diff&quot; tool becomes little more than<br>
something which can &#39;grep&#39; for lines in the file which have<br>
a version number within the desired range. In fact it can also<br>
optionally offer something better than a diff, as instead of<br>
showing you only the orignal state and result state, it<br>
can trivially shows you any intermediate changes and what<br>
version they happened with. <br>
<br>
eg if you asked for a diff between 2.0.0 and 9.1.0, and there<br>
was a command or property that was added in 4.0.0 and deleted<br>
in 6.0.0, a traditional diff will not tell you about this. You&#39;ll<br>
never notice it ever existed. <br>
<br>
A &quot;history grep&quot; showing the set of changes between 2 versions<br=
>
will highlight things that come + go, which can be quite<br>
useful for understanding API evolution I think.<br></blockquote><div><br></=
div><div>Good point. The existing diff tool I wrote was just a prototype to=
 prove &quot;this sort of thing was possible&quot;, but I didn&#39;t put mu=
ch thought into its design beyond &quot;It was quick to write as a proof of=
 concept&quot;.</div><div><br></div><div>Maximizing this information&#39;s =
utility for use with existing utilities without needing to maintain lots of=
 our own script code is a great design goal to keep in mind.<br></div><div>=
=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
<br>
<br>
With regards,<br>
Daniel<br>
-- <br>
|: <a href=3D"https://berrange.com" rel=3D"noreferrer" target=3D"_blank">ht=
tps://berrange.com</a>=C2=A0 =C2=A0 =C2=A0 -o-=C2=A0 =C2=A0 <a href=3D"http=
s://www.flickr.com/photos/dberrange" rel=3D"noreferrer" target=3D"_blank">h=
ttps://www.flickr.com/photos/dberrange</a> :|<br>
|: <a href=3D"https://libvirt.org" rel=3D"noreferrer" target=3D"_blank">htt=
ps://libvirt.org</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-o-=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https://fstop138.berrange.com" rel=3D"n=
oreferrer" target=3D"_blank">https://fstop138.berrange.com</a> :|<br>
|: <a href=3D"https://entangle-photo.org" rel=3D"noreferrer" target=3D"_bla=
nk">https://entangle-photo.org</a>=C2=A0 =C2=A0 -o-=C2=A0 =C2=A0 <a href=3D=
"https://www.instagram.com/dberrange" rel=3D"noreferrer" target=3D"_blank">=
https://www.instagram.com/dberrange</a> :|<br></blockquote><div><br></div><=
div>Thanks again! I&#39;m going to re-focus on some of the more immediate c=
hanges for the documentation project for now, but I&#39;ll no doubt be retu=
rning to the historical parsing / since information subproject before too l=
ong -- just didn&#39;t want to sit on your email for too long so as to appe=
ar ungrateful ;)</div><div><br></div><div>I&#39;ll loop you into future dis=
cussions on this subproject when I pick it back up (Hopefully, not too far =
in the future.) -- and I&#39;ll make sure to keep it on-list. Markus and I =
haven&#39;t gone too in-depth on this part yet, so I figure I&#39;ll pick t=
he prototyping back up when he&#39;s chewed through more of my other patche=
s and all of the Maintainers that need to care about this are paying active=
 attention. (Sorry for all the patches, Markus... You asked for it!)<br></d=
iv><div><br></div><div>--js <br></div></div></div>

--000000000000069ff6061b33aa1d--


