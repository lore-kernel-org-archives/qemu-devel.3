Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63035C2BD09
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jul 2024 06:28:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPytu-0002F7-CV; Sat, 06 Jul 2024 02:28:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sPyts-0002Ed-9q
 for qemu-devel@nongnu.org; Sat, 06 Jul 2024 02:28:00 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sPytq-0004pD-Eo
 for qemu-devel@nongnu.org; Sat, 06 Jul 2024 02:28:00 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a77bf336171so336555466b.1
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2024 23:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720247276; x=1720852076; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pvIUEf4OGw4szd3dnSi14gEwyaKCg7Ab/IbdT2ipIzg=;
 b=CZ9JR1AdiLKKHJhS5cEYjP/Y2N8qsfQx2fchYpFP913RKOHXehqsSWedbiOzT7hhZp
 xZs57TEA3QInGDPNrXp/v37AEGhdMbaeQtJurA04PNo97/Tk5rrgkcoMeWqCbLBTD6+q
 6CpyVX6YSs8jpALR8EIbD+WqBz0XIdiEBK/J8rRxMstR8JNFDS8NRHcL2tYz7IQhNaL7
 x1i2eZnZJ4cC1RgewFnlPF/uhAhT2I+vIK45W71CI3XlKVc9Hr22eK5mESTyoAkB3kmB
 sWVDceOGJmSYTCwinB5ngh6rc7E4w+0qX9gIsowim2fiKioDW+Ete5NcYxM4jvg9WTPz
 ciiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720247276; x=1720852076;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pvIUEf4OGw4szd3dnSi14gEwyaKCg7Ab/IbdT2ipIzg=;
 b=c1dzSKxqcEfJD+QMUS29vCM/DEmLDgBPsirerGQQCjPcM2cZno1OiNYY7NByJMZUK6
 M70DzfoIPzc5686Lp9FLXyQPTJPIy5CoYwjU1cXTbqTGZDIy1p08ZXyWvJgQruSGMtrx
 PXet6YzvDjNQtBSjV9u0pyxKmhECn5u64GwJRWE9TMTABEQZm75WjL+ykrpxYOY9T2Kq
 hi3bW6aKaCk9kFW+PodbgeOxRl6QUhtM06C/gGzCCJi3GPUNadMsxu0fSmWxpt8HCXZ1
 KPbbDHBgjz8PgEsVxAXfRYRYyKQiO8Ql2N+C0mBn+5TkG/XttLXB6W4u/C2FwRfRwMcl
 KtXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhlE0jm6ESCzGRe4gs/MRgYykoTfMW38/4zB+Q8kYaqtdStpJ/tf+AeIaR8vX3DJBI3HJvM3kbewSByi583sWjv8MNwzM=
X-Gm-Message-State: AOJu0Yye1SAwE/XJLCwjPaL64jEfGyIxumGRVPcCefOGuSIzUvU3TToo
 MHzgtHtUucrK1OYKvrnYkKzBXtkDm9eJPL3f67ehRfNuta/6LjSjwIyibiTSk0f+oeccF23D+Bs
 Fk8Wfe/Gk+cvUJihqUwaZq7MkbbM=
X-Google-Smtp-Source: AGHT+IHb4euwyMG906Cgc/z+6QFks7kCcEVu5rz8RaCdbkYNp03KGEF87G5qUqigQ1YjyF5U+qdmoA3h1kC1O2PHljE=
X-Received: by 2002:a17:906:c14b:b0:a77:d9b5:ad4b with SMTP id
 a640c23a62f3a-a77d9b5db0cmr282609366b.9.1720247275819; Fri, 05 Jul 2024
 23:27:55 -0700 (PDT)
MIME-Version: 1.0
References: <20240701224421.1432654-1-edgar.iglesias@gmail.com>
 <20240701224421.1432654-3-edgar.iglesias@gmail.com> <ZoawbAnukIBkYWCw@l14>
 <87wmm1m7i3.fsf@draig.linaro.org> <ZobuhcLHqUEy_bQs@toto>
In-Reply-To: <ZobuhcLHqUEy_bQs@toto>
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Sat, 6 Jul 2024 09:27:43 +0300
Message-ID: <CAJy5ezrfbAzwPWg_YABLy5NwCUiNa31FFR1nAZzy-WC3vXrMhg@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] xen: mapcache: Fix unmapping of first entries in
 buckets
To: "Edgar E. Iglesias" <edgar.iglesias@amd.com>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Anthony PERARD <anthony.perard@vates.tech>, qemu-devel@nongnu.org,
 sstabellini@kernel.org, paul@xen.org, xen-devel@lists.xenproject.org
Content-Type: multipart/alternative; boundary="000000000000cd1a70061c8e471c"
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-ej1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--000000000000cd1a70061c8e471c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 4, 2024 at 9:48=E2=80=AFPM Edgar E. Iglesias <edgar.iglesias@am=
d.com>
wrote:

> On Thu, Jul 04, 2024 at 05:44:52PM +0100, Alex Benn=C3=A9e wrote:
> > Anthony PERARD <anthony.perard@vates.tech> writes:
> >
> > > On Tue, Jul 02, 2024 at 12:44:21AM +0200, Edgar E. Iglesias wrote:
> > >> From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>
> > >>
> > >> This fixes the clobbering of the entry->next pointer when
> > >> unmapping the first entry in a bucket of a mapcache.
> > >>
> > >> Fixes: 123acd816d ("xen: mapcache: Unmap first entries in buckets")
> > >> Reported-by: Anthony PERARD <anthony.perard@vates.tech>
> > >> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
> > >> ---
> > >>  hw/xen/xen-mapcache.c | 12 +++++++++++-
> > >>  1 file changed, 11 insertions(+), 1 deletion(-)
> > >>
> > >> diff --git a/hw/xen/xen-mapcache.c b/hw/xen/xen-mapcache.c
> > >> index 5f23b0adbe..18ba7b1d8f 100644
> > >> --- a/hw/xen/xen-mapcache.c
> > >> +++ b/hw/xen/xen-mapcache.c
> > >> @@ -597,7 +597,17 @@ static void
> xen_invalidate_map_cache_entry_unlocked(MapCache *mc,
> > >>          pentry->next =3D entry->next;
> > >>          g_free(entry);
> > >>      } else {
> > >> -        memset(entry, 0, sizeof *entry);
> > >> +        /*
> > >> +         * Invalidate mapping but keep entry->next pointing to the
> rest
> > >> +         * of the list.
> > >> +         *
> > >> +         * Note that lock is already zero here, otherwise we don't
> unmap.
> > >> +         */
> > >> +        entry->paddr_index =3D 0;
> > >> +        entry->vaddr_base =3D NULL;
> > >> +        entry->valid_mapping =3D NULL;
> > >> +        entry->flags =3D 0;
> > >> +        entry->size =3D 0;
> > >
> > > This kind of feels like mc->entry should be an array of pointer rathe=
r
> > > than an array of MapCacheEntry but that seems to work well enough and
> > > not the first time entries are been cleared like that.
> >
> > The use of a hand rolled list is a bit of a concern considering QEMU an=
d
> > Glib both provide various abstractions used around the rest of the code
> > base. The original patch that introduces the mapcache doesn't tell me
> > much about access patterns for the cache, just that it is trying to
> > solve memory exhaustion issues with lots of dynamic small mappings.
> >
> > Maybe a simpler structure is desirable?
> >
> > We also have an interval tree implementation ("qemu/interval-tree.h") i=
f
> > what we really want is a sorted tree of memory that can be iterated
> > locklessly.
> >
>
> Yes, it would be interesting to benchmark other options.
> I agree that we should at minimum reuse existing lists/hash tables.
>
> We've also had some discussions around removing it partially or
> alltogether but
> there are some concerns around that. We're going to need something to
> keep track of grants. For 32-bit hosts, it's a problem to exhaust virtual
> address-space if mapping all of the guest (are folks still using 32-bit
> hosts?).
> There may be other issues aswell.
>
> Some benefits are that we'll remove some of the complexity and latency fo=
r
> mapping
> and unmapping stuff continously.
>
>
One more thing I forgot to add is that IMO, these larger longer term
changes should not block this tiny bugfix...

Cheers,
Edgar

--000000000000cd1a70061c8e471c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Thu, Jul 4, 2024 at 9:48=E2=80=AFPM Ed=
gar E. Iglesias &lt;<a href=3D"mailto:edgar.iglesias@amd.com">edgar.iglesia=
s@amd.com</a>&gt; wrote:<br></div><div class=3D"gmail_quote"><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">On Thu, Jul 04, 2024 at 05:44:52PM +010=
0, Alex Benn=C3=A9e wrote:<br>
&gt; Anthony PERARD &lt;anthony.perard@vates.tech&gt; writes:<br>
&gt; <br>
&gt; &gt; On Tue, Jul 02, 2024 at 12:44:21AM +0200, Edgar E. Iglesias wrote=
:<br>
&gt; &gt;&gt; From: &quot;Edgar E. Iglesias&quot; &lt;<a href=3D"mailto:edg=
ar.iglesias@amd.com" target=3D"_blank">edgar.iglesias@amd.com</a>&gt;<br>
&gt; &gt;&gt; <br>
&gt; &gt;&gt; This fixes the clobbering of the entry-&gt;next pointer when<=
br>
&gt; &gt;&gt; unmapping the first entry in a bucket of a mapcache.<br>
&gt; &gt;&gt; <br>
&gt; &gt;&gt; Fixes: 123acd816d (&quot;xen: mapcache: Unmap first entries i=
n buckets&quot;)<br>
&gt; &gt;&gt; Reported-by: Anthony PERARD &lt;anthony.perard@vates.tech&gt;=
<br>
&gt; &gt;&gt; Signed-off-by: Edgar E. Iglesias &lt;<a href=3D"mailto:edgar.=
iglesias@amd.com" target=3D"_blank">edgar.iglesias@amd.com</a>&gt;<br>
&gt; &gt;&gt; ---<br>
&gt; &gt;&gt;=C2=A0 hw/xen/xen-mapcache.c | 12 +++++++++++-<br>
&gt; &gt;&gt;=C2=A0 1 file changed, 11 insertions(+), 1 deletion(-)<br>
&gt; &gt;&gt; <br>
&gt; &gt;&gt; diff --git a/hw/xen/xen-mapcache.c b/hw/xen/xen-mapcache.c<br=
>
&gt; &gt;&gt; index 5f23b0adbe..18ba7b1d8f 100644<br>
&gt; &gt;&gt; --- a/hw/xen/xen-mapcache.c<br>
&gt; &gt;&gt; +++ b/hw/xen/xen-mapcache.c<br>
&gt; &gt;&gt; @@ -597,7 +597,17 @@ static void xen_invalidate_map_cache_ent=
ry_unlocked(MapCache *mc,<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pentry-&gt;next =3D entry-&=
gt;next;<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_free(entry);<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt; &gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 memset(entry, 0, sizeof *entry);=
<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Invalidate mapping but k=
eep entry-&gt;next pointing to the rest<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* of the list.<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Note that lock is alread=
y zero here, otherwise we don&#39;t unmap.<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 entry-&gt;paddr_index =3D 0;<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 entry-&gt;vaddr_base =3D NULL;<b=
r>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 entry-&gt;valid_mapping =3D NULL=
;<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 entry-&gt;flags =3D 0;<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 entry-&gt;size =3D 0;<br>
&gt; &gt;<br>
&gt; &gt; This kind of feels like mc-&gt;entry should be an array of pointe=
r rather<br>
&gt; &gt; than an array of MapCacheEntry but that seems to work well enough=
 and<br>
&gt; &gt; not the first time entries are been cleared like that.<br>
&gt; <br>
&gt; The use of a hand rolled list is a bit of a concern considering QEMU a=
nd<br>
&gt; Glib both provide various abstractions used around the rest of the cod=
e<br>
&gt; base. The original patch that introduces the mapcache doesn&#39;t tell=
 me<br>
&gt; much about access patterns for the cache, just that it is trying to<br=
>
&gt; solve memory exhaustion issues with lots of dynamic small mappings.<br=
>
&gt; <br>
&gt; Maybe a simpler structure is desirable?<br>
&gt; <br>
&gt; We also have an interval tree implementation (&quot;qemu/interval-tree=
.h&quot;) if<br>
&gt; what we really want is a sorted tree of memory that can be iterated<br=
>
&gt; locklessly.<br>
&gt; <br>
<br>
Yes, it would be interesting to benchmark other options.<br>
I agree that we should at minimum reuse existing lists/hash tables.<br>
<br>
We&#39;ve also had some discussions around removing it partially or alltoge=
ther but<br>
there are some concerns around that. We&#39;re going to need something to<b=
r>
keep track of grants. For 32-bit hosts, it&#39;s a problem to exhaust virtu=
al<br>
address-space if mapping all of the guest (are folks still using 32-bit hos=
ts?).<br>
There may be other issues aswell.<br>
<br>
Some benefits are that we&#39;ll remove some of the complexity and latency =
for mapping<br>
and unmapping stuff continously.<br><br></blockquote><div><br></div><div>On=
e more thing I forgot to add is that IMO, these larger longer term changes =
should not block this tiny bugfix...</div><div><br></div><div>Cheers,</div>=
<div>Edgar=C2=A0<br></div></div></div>

--000000000000cd1a70061c8e471c--

