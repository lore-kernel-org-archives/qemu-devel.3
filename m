Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F12B0CD5BAC
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 12:46:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ2mI-0005Ww-V3; Thu, 21 May 2026 08:45:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mcascell@redhat.com>)
 id 1wQ2mH-0005Wm-1c
 for qemu-devel@nongnu.org; Thu, 21 May 2026 08:45:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mcascell@redhat.com>)
 id 1wQ2mD-0008E0-UG
 for qemu-devel@nongnu.org; Thu, 21 May 2026 08:45:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779367523;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/xqY60V/ttCEZ/A3IkZklnQGYeVKAgGbyN031fA/4iA=;
 b=gIBoHRWqPxequxr0lVhzG30Y7QQXXQZilCJoWtelO94R+X/bvEhcgHSE853mawVUMqx6lS
 4w76WT7KvRHCi/Xa7w511A8zzbuOs/wDv9mXEwgGs1oaVnd8bsIw/nKkqpy7JMe/LrWlcp
 sBeM4iz8Bs1qse5zDXNEazHeQIVmnWc=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-mFw7atn_Ox-EyWv9PPt-LA-1; Thu, 21 May 2026 08:45:21 -0400
X-MC-Unique: mFw7atn_Ox-EyWv9PPt-LA-1
X-Mimecast-MFC-AGG-ID: mFw7atn_Ox-EyWv9PPt-LA_1779367521
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2ba224c3ffdso148003165ad.0
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 05:45:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779367521; cv=none;
 d=google.com; s=arc-20240605;
 b=XfT+kBMafFkDwwRxjQcRJqG9KSUtg/u+ramdpf4JnfFu0Y0Kjh6u+AHymKwi/4Xs+R
 lFonIFjnb+cJ3J1yhFg+Wx+kYc6v5D9pzG8misn8K+mpbkZkwnhQkJ5yC5/CaGn7z/3u
 v78F/5S5Vzt4bACAeTRq5Jo0M5XfigH8N5Du8BDMxMcfpT/2vjBv7Q3IWxd4IfQmry2J
 bFnw22xMo2slWQ31KlSKdMiWM62SMw31cAYDo7MY5zYc1hokGVoFKDIWxiZMVacqT40v
 zT59FjKgKLL7DLfhthIN2v5qgcltyCHyUMypM9Xk21aeS3MK4sBQX/CNtepDaFlMXYGc
 UzBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=/xqY60V/ttCEZ/A3IkZklnQGYeVKAgGbyN031fA/4iA=;
 fh=/MESDVhDTmAebCfHHOvQBWjIXCkNHw667C84lto2VBo=;
 b=QBt+cwU2esKB2kigadb7+PtuUtxupzcPqvZmnvH11ZVLNvSZWvmwtcs5wNWexJDRp7
 Lgxo1mJvKFOOTpDgdLZOUHbBDCbBJGuUNguWGqmQF69cicur3WyFx1ydmCn/cvfKNYJj
 wi03mTjziTu8CdJxgUWBni2Tnlu/w0Hz6jZkX36IGI/57nXdMx77+zv4vZr7kiJA0K0c
 +HrtXn20KVp1iEAIT4Swst3rPRAg2w6EjR+32P8xQCJBZh4z5c3PNh/H9kpTAIWnzMei
 MJr3OHTrZpcrxjZi/1eCLZXv2skmn2Zzb8jFDvzoGFT1I8s/2ParN+WIb7wwjcz2zCQt
 QlsA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779367521; x=1779972321; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/xqY60V/ttCEZ/A3IkZklnQGYeVKAgGbyN031fA/4iA=;
 b=BlnoUKKrMkVe6T+z19wpLV3nblc8xIE8hyUzaNjS0VS/h3OwmvnCNRsBQ00KtDnq7m
 LCTLdrdpZGzV0feCuGTf70r1bRtAXzmWOoY4NxoyvBojvJXxlZTy3/sI+YXwoBdUSkeG
 ANwkjeXUTMMvUEdHX78NyVWdVnGIToI8UE7CNe8U4FrGiqjT2V6B6sdb1JAQIDO45umD
 qNSmUvXYe0aVyw6xZEymglVFkAs3qgt80ZS90DfaNsbVxkJHuWU2YWT9RSPZkzS8UmVG
 c+L6CyFbKtAHQy14A7CZI23UvT3vlKszA/ilkWXeXGuVYayljBwB19m7+7537pMMe5Ln
 5rkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779367521; x=1779972321;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/xqY60V/ttCEZ/A3IkZklnQGYeVKAgGbyN031fA/4iA=;
 b=RDtQX8TXmtPQde9HmRphYybBy93smvcdIMFH8j1cz2oRFdQI18hyPgGvMXT//l0q4A
 RtxmORrjy0qKUNBEN1vD0iovVdwNZAN8uUgpbD/u5OPRCW4glCWYdNBCkhG61xgoSWJK
 AyrdOdit/uGDZ/5ajKf+394V9lPKW4B3y4ziqgcTYtF9L9QyRe7CDMX3lniSDJr8vyf1
 2pn6cVMvZ1Z0rSBVMqQoK7GjzgFILGnw6fj5BY+5ZQrw65hMD5SUdesiFLsXyBZBBJkr
 5Bbx/8tmXpCtWpPy/c4/37jbfG26nDT0kHhIjfmiC8uNhAIOLm5EbIrmhCKyE+v3SMBL
 0wMA==
X-Forwarded-Encrypted: i=1;
 AFNElJ90hZO0izWyAAiRfaaQrWv8QpdMlc7r5D92bNsgONE8YAlbiFg8MO3tNJX/dCLENv2roj4kiiPyppll@nongnu.org
X-Gm-Message-State: AOJu0YyTok5mO/cHmSqMEw8C80M21352nsU5Tuew3nL0EeD3RnNDzVoc
 Je54Ji1PG1hM0kz2PTDimgsuVH+4BuuK1nh27xL7HEwZVBJ2nmI9XjoO3YqbtqfYl6mCC67hOag
 PXiwZZ5tPHbht6emtBlu5tdhwjYK/2Pbj6YALJzVeLQpK++BGLy/zgIHlVzxZ7OEG0Fhb070djc
 mqcb7B3qPg/E+guiYYVjkZFYJEvRKk9ws=
X-Gm-Gg: Acq92OHfpVoZcE9/NJbzHMRGiQ1UuiFBlpOC+FyLn3wIWb8lsIU0rMquTtVAH0RtMcv
 fyYSOwuu/vKOX9tOEX65KsV+Sxy4mQ85AQVcVFluOiWQ+dHmHG4flVThDeXwSwL7ASlDTEL+2qJ
 W9C8nh5JACfrUy7i+z+S8zCK1zreoy+VEQJEkDEQpfRBilrFPnisdLtGa9AJ6dakdhaS8aX1GNB
 eYR
X-Received: by 2002:a17:902:ce10:b0:2bd:2de3:5198 with SMTP id
 d9443c01a7336-2bea32d02d3mr32888635ad.3.1779367520800; 
 Thu, 21 May 2026 05:45:20 -0700 (PDT)
X-Received: by 2002:a17:902:ce10:b0:2bd:2de3:5198 with SMTP id
 d9443c01a7336-2bea32d02d3mr32888085ad.3.1779367520338; Thu, 21 May 2026
 05:45:20 -0700 (PDT)
MIME-Version: 1.0
References: <agxzKzzDOJm1EU_v@redhat.com>
 <c9cd8228-0a18-49f7-b403-445affeaf972@oss.qualcomm.com>
 <ag3OopKwGVUjSrrV@redhat.com>
 <e7f1fd11-774d-4610-8cca-a434f508e472@oss.qualcomm.com>
 <ag3xwssG6KZecv0o@redhat.com> <20260520191235-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260520191235-mutt-send-email-mst@kernel.org>
From: Mauro Matteo Cascella <mcascell@redhat.com>
Date: Thu, 21 May 2026 14:45:08 +0200
X-Gm-Features: AVHnY4IHVlOJqHr8i8FancmwWmoJSZPZ2mxZdqyOOXAml702FyZXbMZvx2kURkw
Message-ID: <CAA8xKjWoMYBPedC5RP96=TOe2MzDwtsmBHFW=0Bq170YNsR9DQ@mail.gmail.com>
Subject: Re: RFC: GitLab issues for security disclosures
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mcascell@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, May 21, 2026 at 1:14=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Wed, May 20, 2026 at 06:39:14PM +0100, Daniel P. Berrang=C3=A9 wrote:
> > On Wed, May 20, 2026 at 12:33:16PM -0500, Pierrick Bouvier wrote:
> > > On 5/20/2026 10:09 AM, Daniel P. Berrang=C3=A9 wrote:
> > > > On Wed, May 20, 2026 at 10:01:14AM -0500, Pierrick Bouvier wrote:
> > > >> Hi Daniel,
> > > >>
> > > >> On 5/19/2026 9:26 AM, Daniel P. Berrang=C3=A9 wrote:
> > > >>> The qemu-security mailing list was created several years back now=
 and
> > > >>> traditionally saw 1-2 disclosures a month at worst. This was mana=
geable.
> > > >>>
> > > >>> Since approx March 1st, the new normal is to see as many as 20 di=
sclosures
> > > >>> in one single day, more than 200 in total now. This is unsustaina=
ble.
> > > >>> I was thinking we needed more people on qemu-security to triage, =
but IMHO
> > > >>> this won't really fix the problem.
> > > >>>
> > > >>
> > > >> Considering the increase in number of issues, would that be possib=
le to
> > > >> make stricter rules about what is expected?
> > > >>
> > > >> For instance, asking for a working exploit and optionally a VM ima=
ge +
> > > >> instructions to reproduce it. I am not expert on the topic, but wh=
at I
> > > >> see is that if we have this, all duplicates would be eliminated at=
 once.
> > > >
> > > > With the new crop of AI assisted disclosures there is absolutely no
> > > > lack of data provided.
> > > >
> > > > Most come with reproducible exploits, detailed descriptions and ana=
lysis,
> > > > and more - everything you could conceivably need to triage the disc=
losure.
> > > > Reading and interpreting this takes significant mental effort and t=
here's
> > > > too much data to quickly/easily eliminate dupes.
> > > >
> > >
> > > Maybe we need to "standardize" this part then.
> > > Or do something like asking a (GitLab) CI pipeline to be written to
> > > expose the issue. If we can just run this with a specific qemu
> > > remote/branch, it becomes trivial to rerun it when fixes are pushed.
> > >
> > > It definitely does not solve the original scaling issue, but maybe ca=
n
> > > help to absorb it, and spend time where it's useful: writing and
> > > upstreaming a fix, and check it "broke" the exploit.
> > >
> > > >>> This needs an issue tracker to cope with & email is not an issue =
tracker.
> > > >>> We faked an issue tracker with a shared spreadsheet to prevent us=
 drowning
> > > >>> these past few months, but this is still not sustainable & probab=
ly won't
> > > >>> ever be.
> > > >>>
> > > >>
> > > >> Overall, you're right.
> > > >> However, changing the tool won't solve the number of issues sent, =
and
> > > >> for that, something additional is needed.
> > > >
> > > > I don't expect there to be any change in submission rate. The propo=
sal
> > > > is based on the expectation that the submission rate will continue =
at
> > > > a high level for a long time. Primarily the goal is to reduce the
> > > > tracking and triage work overhead and to eliminate/reduce single pe=
rson
> > > > bottlenecks in the process
> > > >
> > > >> I wonder also what is the percentage of duplicates there is from w=
hat
> > > >> you observed in the last 2 months. Any rough idea of the number?
> > > >
> > > > Definitely at least 10%, probably closer to 15%.
> > > >
> > >
> > > Ok, interesting number, thanks. I was expecting much more, but I'm
> > > biased having heard Linus this morning talk about this for Linux kern=
el.
> >
> > I expect the dupes to increase over time as more people run the
> > same analysis across QEMU, especially given that most of the bugs
> > are not yet fixed.
> >
> > With regards,
> > Daniel
> > --
> > |: https://berrange.com       ~~        https://hachyderm.io/@berrange =
:|
> > |: https://libvirt.org          ~~          https://entangle-photo.org =
:|
> > |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com =
:|
>
>
> something I was unaware of previously, is that gitlab is a CNA:
> https://about.gitlab.com/security/cve/
>
> so using gitlab issues means assigning CVE #s should be super easy.

Red Hat is a CNA too, QEMU CVEs are currently being reserved by Red Hat.

In fact, Red Hat is a root CNA:
https://www.cve.org/Media/News/item/blog/2023/01/10/Why-Red-Hat-Became-Root

Projects like glibc, postgresql and curl now operate as independent
CNAs under Red Hat, retaining complete end-to-end ownership over CVE
assignment. Is it time for QEMU to follow suit?

> --
> MST
>

--
Mauro Matteo Cascella
Red Hat Product Security
PGP-Key ID: BB3410B0


