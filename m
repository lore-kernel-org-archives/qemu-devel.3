Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD8A2C79FB9
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 10:07:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4bgE-0004Zv-Cs; Thu, 10 Sep 2026 06:06:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1x4bgC-0004ZO-JR
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 06:06:52 -0400
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1x4bg1-0008JL-Mv
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 06:06:52 -0400
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7f6617c7536so3264400a34.1
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 03:06:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789034795; cv=none;
 d=google.com; s=arc-20260327;
 b=qNDe4dLrxHQQ2pSPfvU0OUZSsbC01plLKnHljB7i1nLYkJj8M2sXUPXl/dJMQse0g1
 wnkTYs9Pzws/X6K3pbyW9Ers1id+b82r32mdoBMlxk37ZqJ1cIwsTxzLyRDze3hGKetY
 iGfoP4GiBM9xkIy9/G6sytrwT4PJU68cBFfhStMsXvBaNk3ttBKXb73b5uz1TEMHbVvg
 0RWxzR5WJzOulKDsgzRPjgg8T2tHDILjRzXuY0qSOuDdZPH9h+r4WaFBlocQGIxSdp1y
 TDd7sKkRCg030B4/mAATKMEpeiKX8Ht6mWh/heEOJajR5EWGwNmshUVwjrO4niZu3aTa
 dezQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=hzjq0Km0aZZwXIAhUOaDgnPfYXW620zD0UfZSSzAqME=;
 fh=MSgXJWkfX6drgHhltmY4z9M9KmIuQLD56TEjfqsrTC8=;
 b=CNe1v6PElMo9uaTkjWWXNLDoWhpgvNJbhFxXJum4Wvf7+rM+//pYKUBvu22ebIoIY7
 lRgs3rVsoj4KKvXyYVML2eenFJoQApFbS8MC47CPdf+uY9DR2uu5Mwp1EIEnGZgt4Q25
 mb0QTjV0dJCJN7gB96VYfCuakC9moYvcwjSGUsdpPDZ+K4I0b1j5ucCefTU2nESrLyOu
 tqH+Wx6bLfWNr3A/aPPeH900z6C0sZjwdE1++ch/n9X4S/x43/I3d0IehDTZxmqn1a1z
 zYfPzrGiIEg8T8HfClbrbwfH896mdCkI2nxLXcD9I7tL5MujdX95943Jorg8WLzfgLXM
 5f/g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789034795; x=1789639595; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=hzjq0Km0aZZwXIAhUOaDgnPfYXW620zD0UfZSSzAqME=;
 b=O2HZlO/BMMlcfH98kBw9+2JL15QpkfRtuQUii4zvK3YbmRCcLOC5nPju6uFjJoqYAZ
 NpAA2hIi9Lh/wIlEv8gbAO8/weQPoHam1wjDKJJYEYa/UxRRyJY42czR3ruE2DXdtW0I
 JylHSdTwh+GK26K5rO+475X2Q+oVIf/FLtQCctNjRpUNNA+8qUeQusKxEVlUQTZ9e2Fx
 tAOZJ3vEQIdBqAK+BBYkMBiPap1zRQ4Vz8zT7NG9xRB3QReRXZTLgKrpOo6j1wbZ8x5U
 p5iSJo/cSAhq+xhZy7h96k3nV+I0GGyAifELb6Mg/4QJnYY4b5hKWILhNYfcd6tFfOpV
 gqjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789034795; x=1789639595;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hzjq0Km0aZZwXIAhUOaDgnPfYXW620zD0UfZSSzAqME=;
 b=SjpOErmcpu0MV+U8fvphaeLaaxgLW3HtdZHS+APUrlx1iqxJeAp3g7f5LVkY6NATmO
 HNK/qsJtAbCXgapDGsopJhUU2eZLvx5j/1XKm0xLpeH217Ue5Ys240OLW0y1hgysJo0x
 HcHQipr+6qbWf7PdYGIaC8YBoPv0ltvaIS3HcevudlpdDl+LT1KZ0NhyE/V7iFm4uamZ
 ZAAoVKa9AaPIfI4rdxJ7q7Gg87qClLkm9OsOD9R05z8IfUyB2neT6mel6WLDTttiP59t
 6/Dx9CbOxzMlOXttaJ3vFIPCcBu8IXvPkCeW/Xlmy8QwaoxH/cavCPm+1SbzYNyXvAua
 E9TA==
X-Gm-Message-State: AFuF++nNkBYcqzRBoCn2TjO2Lr1I5an6rYj85jU8LtWo4TNth+TAR89A
 NnbKsRKW/bvllcXorouB6CMxD6wGcBShlI9bw6fZJ3h/ZsOV+8zItWUYX3zQOR0h7Q+cVZexX2t
 yTvV+Tyz7CrU8qlwLV2MKadox3glZals=
X-Gm-Gg: AYBFou1Col6WuUhF+IQLD6rkmWc4MifURSqYZ6IjtLw2966u/fGtJqHUnDHzqdaIxJz
 cjgnILrX/SM/rn9GoQ1KYGVnEfN76JNEgps33SYO7tB8sE/QZtbBhkfaBXoRRPpMoZDpcG882Hk
 wfJo4s7V4WcbZCWsGyq/r06TOfplgwrFBGDwqkm8ROLBi72kGaYmiUh3usmAoGVNjiM1n8i4Cic
 xzhZLI+y/zrCV0T7dFnXWOZwd6T45xIM+Q39+9apgaBPyu07H6f/XTN/ofLjryQVG2j7ZBNikZd
 EX/IgM4jMRYTke/dF2ZWFdzpUIJAuIGCHWeudlJqreNW+/lTkAlUUYQy/q3Db6lT355HnfreUit
 Bx3ju3n7vgDo=
X-Received: by 2002:a4a:e847:0:b0:6b7:46e9:96f6 with SMTP id
 006d021491bc7-6b746e9a2damr21104159eaf.38.1789034795165; Thu, 10 Sep 2026
 03:06:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260904-qom-qapi-v4-0-a985f168e938@redhat.com>
 <20260904-qom-qapi-v4-4-a985f168e938@redhat.com> <87h5jyjyf3.fsf@pond.sub.org>
In-Reply-To: <87h5jyjyf3.fsf@pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 10 Sep 2026 14:06:20 +0400
X-Gm-Features: AcwNN1W_nHK5eYi39LoFfX8SZmQ6LNnnlRNIqY1QPFJCBlIsSZD7AfuoYQ_1jEI
Message-ID: <CAJ+F1CJ_i=hzd-DbSBUWS5TkJBk6VdTpqjWdo93EA=49Hx5bbg@mail.gmail.com>
Subject: Re: [PATCH v4 04/75] qapi: register all introspectable types, not
 just QMP-reachable ones
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Michael Roth <michael.roth@amd.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::32c;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-ot1-x32c.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi

On Wed, Sep 9, 2026 at 6:25=E2=80=AFPM Markus Armbruster <armbru@redhat.com=
> wrote:
>
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>
> > Rename QAPISchemaUsedTypes to QAPISchemaTypeAnalysis and broaden type
> > collection: instead of discovering types transitively from commands and
> > events, register every non-implicit type upfront in visit_needed() and
> > let visit_end() resolve their dependencies.
>
> So, we now discover types transitively from commands, events, and
> non-implicit types.  Correct?

As well as arrays, yes

>
> > This is needed so that QOM property types that are defined in the QAPI
> > schema but not referenced by any command or event still appear in
> > query-qmp-schema output, making them introspectable by management tools=
.
>
> It's the stupidest solution that could possibly work.  I respect that.
>
> > Commands and events still register their (often implicit) argument and
> > return types, which visit_needed() intentionally skips.
> >
> > This makes the x86-64 schema grow from 244K to 265K.
>
> You mean the output of query-qmp-schema, don't you?

Yes, I'll clarify in commit message

>
> I see it grow like you wrote modulo a KiB or two.  Tolerable, I guess.
>
> The QAPI schema has some 1400 definitions.
>
> Before the patch, query-qmp-schema shows some 1250 of them (89%).
> Afterwards, it's just under 1350 (96%).
>
> I didn't check how many of the additional types are actually used for
> QOM properties at the end of the series.  The ones that aren't are and
> thus dead weight in query-qmp-schema output.  I'm sure we could come up
> with a way to cut them out, but would it be worth our while?  Even if
> most of them are dead weight, most of a small number is still a small
> number.
>
> Still elided are 38 implicit union base types and the builtin integer
> types we don't expose in introspection (9 total), and their lists
> (another 9).
>
> Computing reachability to elide these is kinda ridiculous :)
>
> Thoughts?


I agree that filtering out types unused by QOM probably isn't worth at
this point

There's also a follow-up at the end of the series that exposes integer
signedness and width. It removes the mapping to "int" and preserves
integer array element types, so the nine integer types and their lists
will appear in introspection too.

thanks

