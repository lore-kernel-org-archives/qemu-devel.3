Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2C2AFED3C5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 12:53:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGG1X-00059w-4X; Fri, 24 Apr 2026 08:52:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wGG1T-00059R-Nv
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 08:52:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wGG1R-0006DC-8d
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 08:52:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777035160;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PvpqaD5pQprg8kQpCjG4/3zKp7IuXHWAAtigm1MC0zo=;
 b=ehDy0h4Vksul3dir3x5uVxSkwiZhoexqclgC7RihQntODytZMiWX1gvqYjubEN9B3em+7W
 L8pBGaAIYLvG7TmBOLZdxQXG4Tmw+Gq0UksxQX5XB8Y7NohOVp42SDZdeGmS4qUVDB2Pil
 Opa8TP7P7oW7DYK+LPu9AMQmPuurNlM=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-329-oyMPRGRlPWa8i05Wv8COTA-1; Fri, 24 Apr 2026 08:52:33 -0400
X-MC-Unique: oyMPRGRlPWa8i05Wv8COTA-1
X-Mimecast-MFC-AGG-ID: oyMPRGRlPWa8i05Wv8COTA_1777035153
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-7a45cf7ff24so125017847b3.0
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 05:52:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777035153; cv=none;
 d=google.com; s=arc-20240605;
 b=gA7d2ZhEulf1kMSUAljdBq14NjqbTVUGXOPO+xmqylJUUsqWePNZOL3ykYZ031yNVB
 MeiO7OjAZvtQcEO/lUXARM5HFRRxL1ec18JZ9a8xAB7QF68JLJdTGDqx6ClnPeZjfbIt
 VWVCe3ZHQndDTAJUmKWtaFLGDVIO0L+xeJGTPY+jypNwPQRwRND+bIjTAH7bXjzuWDq5
 xjSLPVb2yYtFWIQZrHDx1SOz3+mn4RYRw0DWiCVUcpdNYxp9plCC7gSSNDZcby9+WlGM
 cEdlK4dsS6qX8DS+GSMBwiX6Yoto8eMKJATMxGt5HwHl1SldNgiCXO3JutixBXLt4cy0
 kMQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=PvpqaD5pQprg8kQpCjG4/3zKp7IuXHWAAtigm1MC0zo=;
 fh=FokTuDZJP0b72MuyfYB6pDu1SUcEvdw8SifBRO2CIB0=;
 b=FCnwLczuFiF7Vxn+ito0HWsC7FDQFmH0j87+3q3Z+RUZY6bSYXYoF3/l2mFi8M/pSQ
 m5FN48xi7WcgbhWb/0EpT9E23LmTkjCCno7J6hbUaEwtIWHpRJ2g73mX42uOHhD6xjv3
 smob4aiABOp2yH1RNuOsLs8gUscaRZyNdivJd2dtx2dcSXS8FuCLF8ZB4BtFTJIdfQHM
 Im06S4uFx4iBNNhLxJ9+QJXnX3czPy+ZNT+j8emi+NkhXqxcrbXJiJC3X/lRfEfHZXHk
 g4jFif7a+9N6c1P3aiZ2c40TxALqxZ0SvT+kBlPJqiW3Cv241oZsogOIb6F8y6GQJa26
 zt9Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777035153; x=1777639953; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PvpqaD5pQprg8kQpCjG4/3zKp7IuXHWAAtigm1MC0zo=;
 b=sG9vNsXc5ZOS6HhUsJWxG8P0imwl9DTxDHUHtjCve8vwlBOjqJ65HQtbeJCOCm1YlR
 L2NLjWnx4YxyLAzt6sxMRo3x70Npx4+AFJ025XRZKf+rm6ertCM54gvKY59OQgu2g990
 Sdu67X1xgr3FP4CJxJM/TuTxYtCp37EAaoRfMpnXVEOtddZ+cLWyYp30Ev3pcN5EnFQZ
 a0/QXBFbxgdn/gQRa7LRqnrk7GSDlkN0a3JmifLK3zfD0sfdJXjePVcvmjMtG/qdowys
 ixigV3g6cSokOtWClg5OWcrjhS6MeAdzifbiESeI/dpIQ5hHEUaRDuRCJhEpYqx1rOro
 iuXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777035153; x=1777639953;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PvpqaD5pQprg8kQpCjG4/3zKp7IuXHWAAtigm1MC0zo=;
 b=gyVgUgGwOa9kwXpVmQ+2IYkjZ0WZduZTFYHT/nHOBZJOQMfpSs7gjytZQEKsK3ix10
 eEtcASlqhY+PgIvufodr4iHb7OCZQ0GrPT9W+CGDAMasbYJm1+vpLaMEOLGfG0KrTuJ3
 5+ppMs0eImxdlZslYdKKaZF08jVgB1k28EbzIj+4H4wo3LFkptPxjb6ghFGNB4Hu3aAl
 xpb5vOoj9quomSUY2F7ku/wrEew6BCc4z54Rur9+uHuje5saCaNunXQ75/ErhIFmYVdV
 3emcOFkk9JqOZd9IGw5f7nNZx6SyWp9Ll+pkvOHTZBxyVBWEEnHdFRUA2bm9TLGjZ7Zy
 gpRA==
X-Gm-Message-State: AOJu0Yw6/s4AoD6836cMsRRkuGJvLumTDw9dT6JZYpBCFoB0nV3me24r
 IsUs2GlF24oIO7vusFjl7pjWTTA93wDJHv8vamMX1VGfQAeBm7BcIhnVa4+DGQqI/hlkZl+j/PL
 y6x7xBukNMEH9YxCPOMMyXgQCvuZUJtEmxUf9QPprQoVBbt/PpA1Zmv6zHXJf/LOrJR3oCaCW04
 HVIxG1QbGEeOy4NNCZ6K3pK59+ferA+AI=
X-Gm-Gg: AeBDiev4ozOhimvGT/hppCDNRmoaOvA141v4pOUw/EFaruJwoiEej+6qRtYZb82yLR5
 QF4R/0gfXyXwiPxXCaX82yo4Rb7ujrYCH82i6RS7lPB8U1Hg5OQTJkeyv0CCg+cYlw465VkLOLd
 irdWQa+Pt5MaiRqcDLJbOtYQpMNYqeQfGCHIkinJ3XvB+CJtjiUQCqDU8nLW9zHpoSxA+VznWoG
 COssVECCbHKOn+y4SvtX4/GfeaccZQejRw/xpXwVg3437l9
X-Received: by 2002:a05:690c:6612:b0:7ba:f712:95f6 with SMTP id
 00721157ae682-7baf712b9abmr197749377b3.3.1777035153118; 
 Fri, 24 Apr 2026 05:52:33 -0700 (PDT)
X-Received: by 2002:a05:690c:6612:b0:7ba:f712:95f6 with SMTP id
 00721157ae682-7baf712b9abmr197748987b3.3.1777035152543; Fri, 24 Apr 2026
 05:52:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260423220022.2180059-1-jsnow@redhat.com>
 <87mrysr08h.fsf@pond.sub.org>
In-Reply-To: <87mrysr08h.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Fri, 24 Apr 2026 08:52:21 -0400
X-Gm-Features: AQROBzAue56kt90Qnr7z4lUjKCYxd5V-YJRR_92zjlz9j06kiCP3YVjHG6mGrYg
Message-ID: <CAFn=p-ZNOYwSybMQDHnw9FF88_RDaRNhJkFjCT3AHKu496Ggeg@mail.gmail.com>
Subject: Re: [PATCH 00/12] qapi: add formal "intro" section
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Igor Mammedov <imammedo@redhat.com>, 
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, Ani Sinha <anisinha@redhat.com>, 
 Gerd Hoffmann <kraxel@redhat.com>, Eric Blake <eblake@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>
Content-Type: multipart/alternative; boundary="00000000000005e59e0650343d5f"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--00000000000005e59e0650343d5f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 24, 2026, 8:50=E2=80=AFAM Markus Armbruster <armbru@redhat.com>=
 wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > Hiya, this is a series that explores a potential syntax for a
> > designated "Intro" section. Markus knows why I want this, but for
> > everyone else: a designated "Introduction" section is useful for the
> > desired "inliner" feature for the new QAPI doc system. Commits explain
> > a bit more. This is prep work and doesn't really change anything
> > tangibly except source code syntax for the QAPI docs.
>
> Let me elaborate a bit.
>
> 1. Why "intro"?
>
> Generated documentation often refers to types like this:
>
>     Command announce-self (Since: 4.0)
>
>        Trigger generation of broadcast RARP frames to update network
>        switches.  This can be useful when network bonds fail-over the
>        active slave.
>
>        Arguments:
>           * The members of "AnnounceParameters".
>
>        Example::
>
>           -> { "execute": "announce-self",
>                "arguments": {
>                    "initial": 50, "max": 550, "rounds": 10, "step": 50,
>                    "interfaces": ["vn2", "vn3"], "id": "bob" } }
>           <- { "return": {} }
>
> The arguments are hidden behind link "AnnounceParameters".  Following
> leads to:
>
>     Object AnnounceParameters (Since: 4.0)
>
>        Parameters for self-announce timers
>
>        Members:
>           * initial ("int") -- Initial delay (in ms) before sending
>             the first GARP/RARP announcement
>
>           * max ("int") -- Maximum delay (in ms) between GARP/RARP
>             announcement packets
>
>           * rounds ("int") -- Number of self-announcement attempts
>
>           * step ("int") -- Delay increase (in ms) after each self-
>             announcement attempt
>
>           * interfaces ("[string]", *optional*) -- An optional list of
>             interface names, which restricts the announcement to the
>             listed interfaces.  (Since 4.1)
>
>           * id ("string", *optional*) -- A name to be used to identify
>             an instance of announce-timers and to allow it to modified
>             later.  Not for use as part of the migration parameters.
>             (Since 4.1)
>
> This is bad UX.  Especially when you have to chase multiple links.
>
> John's doc inliner inlines AnnounceParameters documentation into
> announce-self documentation.
>
> However, we don't want to inline "Parameters for self-announce timers".
>
> Definitions typically start with a short description of the thing being
> defined.  John calls this "intro".  We don't want to inline these.
>
> Syntactically, a doc comment begins with optional plain paragraphs.
> These end when something else begins: argument or member description,
> tagged section such as "Returns:", ...
>
> Most of the time, these initial paragraphs are exactly the "intro".  But
> not always.
>
> Even without the inliner, we often need to know where "intro" ends.  In
> the example above, "Arguments:" is auto-generated right after the
> "intro", and for that, the generator needs to know where "intro" ends.
>
> In his "qapi: enforce section ordering" series, John proposed syntax to
> explicitly end "intro": a line "Details:".  He had to add it to roughly
> one in 25 definition docs.
>
> I fear adding "Details:" when needed is easily forgotten when it's so
> rarely needed.  And I don't even trust myself to catch it patch review.
> So we looked for clearer syntax.
>
> This series implements one: instead of letting intro end when something
> else starts, use indentation like we do for descriptions and tagged
> sections.
>
> Let's have a look at the current doc source for announce-self:
>
>     ##
>     # @announce-self:
>     #
>     # Trigger generation of broadcast RARP frames to update network
>     # switches.  This can be useful when network bonds fail-over the
>     # active slave.
>     #
>     # TODO: This line is a hack to separate the example from the body
>     #
>     # .. qmp-example::
>     #
>     #     -> { "execute": "announce-self",
>     #          "arguments": {
>     #              "initial": 50, "max": 550, "rounds": 10, "step": 50,
>     #              "interfaces": ["vn2", "vn3"], "id": "bob" } }
>     #     <- { "return": {} }
>     #
>     # Since: 4.0
>     ##
>
> "Intro" ends when something else starts, namely the TODO: section.  We
> need this hack so the doc generator inserts the "Arguments:" part where
> we want it.
>
> John's "qapi: enforce section ordering" series replaces the TODO hack
> with a "Details:" line.
>
> In new syntax, this instead becomes:
>
>     ##
>     # @announce-self: Trigger generation of broadcast RARP frames to
>     #     update network switches.  This can be useful when network bonds
>     #     fail-over the active slave.
>     #
>     # .. qmp-example::
>     #
>     #     -> { "execute": "announce-self",
>     #          "arguments": {
>     #              "initial": 50, "max": 550, "rounds": 10, "step": 50,
>     #              "interfaces": ["vn2", "vn3"], "id": "bob" } }
>     #     <- { "return": {} }
>     #
>     # Since: 4.0
>     ##
>
> Now "intro" is indented, and its end is obvious.  Mistakes seem
> unlikely.
>
> We could instead do:
>
>     ##
>     # @announce-self:
>     #     Trigger generation of broadcast RARP frames to update network
>     #     switches.  This can be useful when network bonds fail-over the
>     #     active slave.
>     #
>     # .. qmp-example::
>     #
>     #     -> { "execute": "announce-self",
>     #          "arguments": {
>     #              "initial": 50, "max": 550, "rounds": 10, "step": 50,
>     #              "interfaces": ["vn2", "vn3"], "id": "bob" } }
>     #     <- { "return": {} }
>     #
>     # Since: 4.0
>     ##
>
> I think I like this a bit better.
>
> > It is designed so that this conversion can happen incrementally with
> > no actual difference to the rendered manuals, so each QAPI module can
> > be converted one at a time for easier review and merging in an
> > arbitrary order.
>
> Why not wholesale conversion?  As long as generated output stays the
> same.  It does in this series, except for harmless line breaks.
>

When we last spoke, we weren't convinced this was the right approach and we
both wanted to see it. So I did enough to get a taste.


> > This series demonstrates conversion of just four modules; if I'm given
> > a thumbs up, I will convert the rest of QAPI, one module (or
> > maintainer stanza) per patch like how I handled adding
> > cross-references.
>
>

--00000000000005e59e0650343d5f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Apr 24, 2026, 8:50=E2=80=
=AFAM Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com">armbru@red=
hat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">John Snow &l=
t;<a href=3D"mailto:jsnow@redhat.com" target=3D"_blank" rel=3D"noreferrer">=
jsnow@redhat.com</a>&gt; writes:<br>
<br>
&gt; Hiya, this is a series that explores a potential syntax for a<br>
&gt; designated &quot;Intro&quot; section. Markus knows why I want this, bu=
t for<br>
&gt; everyone else: a designated &quot;Introduction&quot; section is useful=
 for the<br>
&gt; desired &quot;inliner&quot; feature for the new QAPI doc system. Commi=
ts explain<br>
&gt; a bit more. This is prep work and doesn&#39;t really change anything<b=
r>
&gt; tangibly except source code syntax for the QAPI docs.<br>
<br>
Let me elaborate a bit.<br>
<br>
1. Why &quot;intro&quot;?<br>
<br>
Generated documentation often refers to types like this:<br>
<br>
=C2=A0 =C2=A0 Command announce-self (Since: 4.0)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0Trigger generation of broadcast RARP frames to u=
pdate network<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0switches.=C2=A0 This can be useful when network =
bonds fail-over the<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0active slave.<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0Arguments:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * The members of &quot;AnnounceParameter=
s&quot;.<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0Example::<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -&gt; { &quot;execute&quot;: &quot;annou=
nce-self&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;arguments&quot=
;: {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;=
initial&quot;: 50, &quot;max&quot;: 550, &quot;rounds&quot;: 10, &quot;step=
&quot;: 50,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;=
interfaces&quot;: [&quot;vn2&quot;, &quot;vn3&quot;], &quot;id&quot;: &quot=
;bob&quot; } }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;- { &quot;return&quot;: {} }<br>
<br>
The arguments are hidden behind link &quot;AnnounceParameters&quot;.=C2=A0 =
Following<br>
leads to:<br>
<br>
=C2=A0 =C2=A0 Object AnnounceParameters (Since: 4.0)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0Parameters for self-announce timers<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0Members:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * initial (&quot;int&quot;) -- Initial d=
elay (in ms) before sending<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 the first GARP/RARP announcement<=
br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * max (&quot;int&quot;) -- Maximum delay=
 (in ms) between GARP/RARP<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 announcement packets<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * rounds (&quot;int&quot;) -- Number of =
self-announcement attempts<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * step (&quot;int&quot;) -- Delay increa=
se (in ms) after each self-<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 announcement attempt<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * interfaces (&quot;[string]&quot;, *opt=
ional*) -- An optional list of<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 interface names, which restricts =
the announcement to the<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 listed interfaces.=C2=A0 (Since 4=
.1)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * id (&quot;string&quot;, *optional*) --=
 A name to be used to identify<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 an instance of announce-timers an=
d to allow it to modified<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 later.=C2=A0 Not for use as part =
of the migration parameters.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (Since 4.1)<br>
<br>
This is bad UX.=C2=A0 Especially when you have to chase multiple links.<br>
<br>
John&#39;s doc inliner inlines AnnounceParameters documentation into<br>
announce-self documentation.<br>
<br>
However, we don&#39;t want to inline &quot;Parameters for self-announce tim=
ers&quot;.<br>
<br>
Definitions typically start with a short description of the thing being<br>
defined.=C2=A0 John calls this &quot;intro&quot;.=C2=A0 We don&#39;t want t=
o inline these.<br>
<br>
Syntactically, a doc comment begins with optional plain paragraphs.<br>
These end when something else begins: argument or member description,<br>
tagged section such as &quot;Returns:&quot;, ...<br>
<br>
Most of the time, these initial paragraphs are exactly the &quot;intro&quot=
;.=C2=A0 But<br>
not always.<br>
<br>
Even without the inliner, we often need to know where &quot;intro&quot; end=
s.=C2=A0 In<br>
the example above, &quot;Arguments:&quot; is auto-generated right after the=
<br>
&quot;intro&quot;, and for that, the generator needs to know where &quot;in=
tro&quot; ends.<br>
<br>
In his &quot;qapi: enforce section ordering&quot; series, John proposed syn=
tax to<br>
explicitly end &quot;intro&quot;: a line &quot;Details:&quot;.=C2=A0 He had=
 to add it to roughly<br>
one in 25 definition docs.<br>
<br>
I fear adding &quot;Details:&quot; when needed is easily forgotten when it&=
#39;s so<br>
rarely needed.=C2=A0 And I don&#39;t even trust myself to catch it patch re=
view.<br>
So we looked for clearer syntax.<br>
<br>
This series implements one: instead of letting intro end when something<br>
else starts, use indentation like we do for descriptions and tagged<br>
sections.<br>
<br>
Let&#39;s have a look at the current doc source for announce-self:<br>
<br>
=C2=A0 =C2=A0 ##<br>
=C2=A0 =C2=A0 # @announce-self:<br>
=C2=A0 =C2=A0 #<br>
=C2=A0 =C2=A0 # Trigger generation of broadcast RARP frames to update netwo=
rk<br>
=C2=A0 =C2=A0 # switches.=C2=A0 This can be useful when network bonds fail-=
over the<br>
=C2=A0 =C2=A0 # active slave.<br>
=C2=A0 =C2=A0 #<br>
=C2=A0 =C2=A0 # TODO: This line is a hack to separate the example from the =
body<br>
=C2=A0 =C2=A0 #<br>
=C2=A0 =C2=A0 # .. qmp-example::<br>
=C2=A0 =C2=A0 #<br>
=C2=A0 =C2=A0 #=C2=A0 =C2=A0 =C2=A0-&gt; { &quot;execute&quot;: &quot;annou=
nce-self&quot;,<br>
=C2=A0 =C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;arguments&quot;: {<=
br>
=C2=A0 =C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;initi=
al&quot;: 50, &quot;max&quot;: 550, &quot;rounds&quot;: 10, &quot;step&quot=
;: 50,<br>
=C2=A0 =C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;inter=
faces&quot;: [&quot;vn2&quot;, &quot;vn3&quot;], &quot;id&quot;: &quot;bob&=
quot; } }<br>
=C2=A0 =C2=A0 #=C2=A0 =C2=A0 =C2=A0&lt;- { &quot;return&quot;: {} }<br>
=C2=A0 =C2=A0 #<br>
=C2=A0 =C2=A0 # Since: 4.0<br>
=C2=A0 =C2=A0 ##<br>
<br>
&quot;Intro&quot; ends when something else starts, namely the TODO: section=
.=C2=A0 We<br>
need this hack so the doc generator inserts the &quot;Arguments:&quot; part=
 where<br>
we want it.<br>
<br>
John&#39;s &quot;qapi: enforce section ordering&quot; series replaces the T=
ODO hack<br>
with a &quot;Details:&quot; line.<br>
<br>
In new syntax, this instead becomes:<br>
<br>
=C2=A0 =C2=A0 ##<br>
=C2=A0 =C2=A0 # @announce-self: Trigger generation of broadcast RARP frames=
 to<br>
=C2=A0 =C2=A0 #=C2=A0 =C2=A0 =C2=A0update network switches.=C2=A0 This can =
be useful when network bonds<br>
=C2=A0 =C2=A0 #=C2=A0 =C2=A0 =C2=A0fail-over the active slave.<br>
=C2=A0 =C2=A0 #<br>
=C2=A0 =C2=A0 # .. qmp-example::<br>
=C2=A0 =C2=A0 #<br>
=C2=A0 =C2=A0 #=C2=A0 =C2=A0 =C2=A0-&gt; { &quot;execute&quot;: &quot;annou=
nce-self&quot;,<br>
=C2=A0 =C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;arguments&quot;: {<=
br>
=C2=A0 =C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;initi=
al&quot;: 50, &quot;max&quot;: 550, &quot;rounds&quot;: 10, &quot;step&quot=
;: 50,<br>
=C2=A0 =C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;inter=
faces&quot;: [&quot;vn2&quot;, &quot;vn3&quot;], &quot;id&quot;: &quot;bob&=
quot; } }<br>
=C2=A0 =C2=A0 #=C2=A0 =C2=A0 =C2=A0&lt;- { &quot;return&quot;: {} }<br>
=C2=A0 =C2=A0 #<br>
=C2=A0 =C2=A0 # Since: 4.0<br>
=C2=A0 =C2=A0 ##<br>
<br>
Now &quot;intro&quot; is indented, and its end is obvious.=C2=A0 Mistakes s=
eem<br>
unlikely.<br>
<br>
We could instead do:<br>
<br>
=C2=A0 =C2=A0 ##<br>
=C2=A0 =C2=A0 # @announce-self:<br>
=C2=A0 =C2=A0 #=C2=A0 =C2=A0 =C2=A0Trigger generation of broadcast RARP fra=
mes to update network<br>
=C2=A0 =C2=A0 #=C2=A0 =C2=A0 =C2=A0switches.=C2=A0 This can be useful when =
network bonds fail-over the<br>
=C2=A0 =C2=A0 #=C2=A0 =C2=A0 =C2=A0active slave.<br>
=C2=A0 =C2=A0 #<br>
=C2=A0 =C2=A0 # .. qmp-example::<br>
=C2=A0 =C2=A0 #<br>
=C2=A0 =C2=A0 #=C2=A0 =C2=A0 =C2=A0-&gt; { &quot;execute&quot;: &quot;annou=
nce-self&quot;,<br>
=C2=A0 =C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;arguments&quot;: {<=
br>
=C2=A0 =C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;initi=
al&quot;: 50, &quot;max&quot;: 550, &quot;rounds&quot;: 10, &quot;step&quot=
;: 50,<br>
=C2=A0 =C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;inter=
faces&quot;: [&quot;vn2&quot;, &quot;vn3&quot;], &quot;id&quot;: &quot;bob&=
quot; } }<br>
=C2=A0 =C2=A0 #=C2=A0 =C2=A0 =C2=A0&lt;- { &quot;return&quot;: {} }<br>
=C2=A0 =C2=A0 #<br>
=C2=A0 =C2=A0 # Since: 4.0<br>
=C2=A0 =C2=A0 ##<br>
<br>
I think I like this a bit better.<br>
<br>
&gt; It is designed so that this conversion can happen incrementally with<b=
r>
&gt; no actual difference to the rendered manuals, so each QAPI module can<=
br>
&gt; be converted one at a time for easier review and merging in an<br>
&gt; arbitrary order.<br>
<br>
Why not wholesale conversion?=C2=A0 As long as generated output stays the<b=
r>
same.=C2=A0 It does in this series, except for harmless line breaks.<br></b=
lockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">When we=
 last spoke, we weren&#39;t convinced this was the right approach and we bo=
th wanted to see it. So I did enough to get a taste.</div><div dir=3D"auto"=
><br></div><div dir=3D"auto"><div class=3D"gmail_quote gmail_quote_containe=
r"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left=
:1px #ccc solid;padding-left:1ex">
<br>
&gt; This series demonstrates conversion of just four modules; if I&#39;m g=
iven<br>
&gt; a thumbs up, I will convert the rest of QAPI, one module (or<br>
&gt; maintainer stanza) per patch like how I handled adding<br>
&gt; cross-references.<br>
<br>
</blockquote></div></div></div>

--00000000000005e59e0650343d5f--


