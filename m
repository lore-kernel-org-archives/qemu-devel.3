Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9183BCD6E75
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 19:08:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVDQH-0007we-Hn; Thu, 04 Jun 2026 15:08:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wVDQD-0007wF-9B
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 15:08:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wVDQB-0004ku-BP
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 15:08:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780600080;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/7jsGZP7BFRry3kXkhb3T7q12Ju72i2xWTrMMRzZQQY=;
 b=VTkPv3t3A82kXQpIoVxkpm6roTpYenY4GDSuTgEg3W4PP7LVmJrKE0Olz0e0S/75lggtlY
 5Bb5/64gYHHy780rfRdhtyA5phmoegJZB0dX4Y8IYU4YopB1xs9ON5/m6e/8ZV4D/vLr+T
 LX+62oC7PazREhkvO3nYmHvqDIXSbm8=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-251-uMR3I7FsN9m2hyZbNRr95g-1; Thu, 04 Jun 2026 15:07:58 -0400
X-MC-Unique: uMR3I7FsN9m2hyZbNRr95g-1
X-Mimecast-MFC-AGG-ID: uMR3I7FsN9m2hyZbNRr95g_1780600078
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-7e9bb6a1d6fso18388577b3.0
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2026 12:07:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780600078; cv=none;
 d=google.com; s=arc-20240605;
 b=Mjt1GOzDRVEGLDmfuULEWhzzfFUKnws64UmgI0kbFViRNMsBWtXLbdKBQghDmBS1XZ
 VZRuSLBRNcM3fHGWYqr7nCNsEp8eE8DsLZVLH5lZcEFvMY+wiBvMZH433D3zmNoH+VAe
 VXwiNn77hwbDvZLiOaCQNAb/2pfPk6FKwHpm/5tYaFbMHvr487pvf3vpxcJ7Fz9E3jZQ
 KwKb+RfvfmDxtVD4aouP9rSR5EwUzRIqsLEvplG16Jb4Q6sxdrRlqfjsMhs7QqldX4Nk
 KgMBYkSdiHtDm+y0ySsUIlc8WyLw4WU1Dhh2gOreOHb8yYj69yNBnuZM0VvaoKHEn9Pd
 Ufag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=/7jsGZP7BFRry3kXkhb3T7q12Ju72i2xWTrMMRzZQQY=;
 fh=Ohhlf+kwivs7jyQv9LUTHNY6pEAdnCK0uS2X5z9ZBdU=;
 b=NjdiIb1xlXG5gdBmrxyllTJZ/safZ2uoGk56y96q10gkCc3q1k30yH4h3ooAEnaQr6
 opWi0kB3Z+jZm7YQ3N3oU2gDhs4k8svQnIe2jB2wFTrQN3xpKlH7foAdGsdqaKVLXMPB
 2Uryo+nZnQvGIrONuxoUoo9x/PmhyNZDD0HBUJzHkv2LHteGrHwwPCtYUPz2Vjv+1VzF
 2bzwhjLquNe6YRZlLRUfxbw5Uxgzpe1c195j8hwYUQLnxdRXDf5YFnN/yc+ZBUwTxkQl
 kHAL3i2JDf3NbKDiaid6f0qtnau/an9WAGf4y+VbdLte5dnXDyMyhI+EBT91/6KIp2hy
 XM4g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780600078; x=1781204878; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/7jsGZP7BFRry3kXkhb3T7q12Ju72i2xWTrMMRzZQQY=;
 b=t1Bu/yUWlTn8SWw6BwzTee7F/+BYdGwoECfkJq7o6guIPhWDf0V2I/zQ1Rndsc5wED
 3SwzA4qAq+az6hiJKnbvqXvxwhKmoPfvIHzCKTKvzGnr/HrCjJb925InVPupa6ZpOGhH
 z15UcnEWPRxopbFmbWYvNvx/WE5ppbigemtOfRLEjnk/x8o6TLgt/jIbNF9wuR6KSqcK
 iIYnN+vGo5b+KXwKwafvsHCS5cMF02tBp/wPubgdiquTy2gpXDaRP+5qKXkUG38SAsBa
 oXJe99JT6n27ZTUSCGTIWKfcp3Wo6LYF7v30ANiE+mDHnYbo1cYYqlMeoRKZ5FhSUN5K
 a0bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780600078; x=1781204878;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/7jsGZP7BFRry3kXkhb3T7q12Ju72i2xWTrMMRzZQQY=;
 b=Mp+mCuBHMOpbv0P9H0q+jfQ/Xvc51oLp5hZqQy+6pl+x2OJdsurlwuVV7Gu0S6MtyP
 kt7h7GvW3GnPoKRrg4EO2bGpsnx2AlUZ0OzurqV2IvyQovx2wB+lOS2Of1fu8zT5ngRi
 leIWBYgMo7UTSJsyXJEGq0CFdTNSiNARV/6PhzQeNhyAG+4W60wszN9E5BT1WUDddxWH
 fib/JekhrH3RurikONzljtN3oKOjp9kAehMhAgk0hLfiUcixe6Vmd2mGIbbvyXMWDXD0
 fLY3J9KHg7NJG3WlNQR5pWUv6GD1Do9U62NTzyHC8PKdkuDy2bt3XsD7d4AK+vq+wTHb
 TaiQ==
X-Gm-Message-State: AOJu0Yx9EL0z6nZ2i4M1ddzeI2tfe1z4ELgKwR2kuBKB5eLwxs2j6BCE
 iWf22QH8dWwI4CO7ZMtBKwBCFpN9dboZOjU/wPbhhdzDrFfbJmLFdS1Kzy8ufRzWmGzW8cq/HRR
 4HQWv7Qqx7fKjzzHuVfvynARhaq3ZMT0vAPtx/ZV97oUptxqxIGnzU+4Xys95HV2fw/T7hzZUcJ
 8V4kEQhqYYLBRpgoBwCyPmmiX3nwgfNE0=
X-Gm-Gg: Acq92OGt2AuYsgfM+peIouXDDRFF7QA5B6ndnXQgLPcVNZUtYwGd81w/LKZvisNlrtR
 SWdezHzPf3mL/VIUYmFS7ZDefFZPMTBX0sBAxSriieJ0p6iEs+b22UlNeTxkpxYZIZG1v5mlrbD
 m1vu8vYiUCY6JOgv8ZRSyVDcXMfBgoeQ+7xJRtCpx95lAAVUBU8v/k3srjmuWkxxO1DXoZaP/j0
 kvYpRnsx+bMSxey3GEIUfFGZZa9Dce/MD/dkUmgHTpq+Pp2
X-Received: by 2002:a05:690c:4b87:b0:7bf:ff7:ea71 with SMTP id
 00721157ae682-7eb8c2fe788mr37900747b3.17.1780600078083; 
 Thu, 04 Jun 2026 12:07:58 -0700 (PDT)
X-Received: by 2002:a05:690c:4b87:b0:7bf:ff7:ea71 with SMTP id
 00721157ae682-7eb8c2fe788mr37900437b3.17.1780600077563; Thu, 04 Jun 2026
 12:07:57 -0700 (PDT)
MIME-Version: 1.0
References: <20260603032201.993015-1-jsnow@redhat.com>
 <20260603032201.993015-10-jsnow@redhat.com>
 <87ecinkgnv.fsf@pond.sub.org>
In-Reply-To: <87ecinkgnv.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Thu, 4 Jun 2026 15:07:46 -0400
X-Gm-Features: AVHnY4Kl9_8gAYf2PjEJ9ZQzE5vSDMi6CzNvJj2qPaI925F79Rz9tN7Dwp-xpWY
Message-ID: <CAFn=p-aXcHomC4r=Gh9yQhoQzFDqxqTc2YTpaE-NOgiYDQRx_g@mail.gmail.com>
Subject: Re: [PATCH v3 09/16] qapi/docs: adjust stub member insertion algorithm
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Ani Sinha <anisinha@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, Igor Mammedov <imammedo@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 linux-edac@vger.kernel.org, Cleber Rosa <crosa@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Jun 3, 2026 at 7:27=E2=80=AFAM Markus Armbruster <armbru@redhat.com=
> wrote:
>
> Quick first pass...
>
> John Snow <jsnow@redhat.com> writes:
>
> > A forthcoming patch removes the implicit PLAIN section that always
> > starts a QAPIDoc section list. Further future changes begin converting
> > "PLAIN" sections to "INTRO" sections. To accommodate this, the
> > insertion algorithm that places stub and dummy members must be
> > adjusted to cope with not only the finished state, but temporary
> > intermediate states while the series is merged.
>
> Perhaps:
>
>   A forthcoming patch removes the implicit PLAIN section that always
>   starts a QAPIDoc section list. Further future changes begin converting
>   "PLAIN" sections to "INTRO" sections.
>
>   This will affect the code that inserts "Not documented" descriptions
>   for undocumented members ("stub sections") and the dummy section that
>   marks the spot for "The members of ..." references.
>
>   Adjust the algorithm to cope with not only the finished state, but
>   temporary intermediate states while the series is merged.

Sure.

>
> > This algorithm can handle zero-or-more PLAIN *or* INTRO sections at
> > the beginning of a QAPIDoc object, in contrast to the previous
> > algorithm which assumed and relied upon there being always one PLAIN
> > section at the beginning of every QAPIDoc section list.
> >
> > In other words: (PLAIN | INTRO)* <EverythingElse>
> >
> > This does not impact what the parser itself will actually produce. As
> > of this patch, the parser will still always generate QAPIDoc section
> > lists that start with precisely one PLAIN section (whether or not it
> > is empty), followed by the remaining sections. Those remaining
> > sections may or may not include additional PLAIN sections, but never
> > two such sections contiguously as the parser will always treat that
> > layout as one PLAIN section consisting of multiple paragraph(s).
> >
> > In other other words: This insertion algorithm is more lenient than
> > the parser, but this is on purpose for flexibility mid-stream as we
> > convert QAPI to using explicit introductory sections. The allowed
> > order of sections will eventually become strictly enforced in the
> > parser, which will in turn allow dramatic simplifications to the
> > insertion algorithm. This only exists as transitory code until we are
> > able to enforce that order.
> >
> > Fear not: the intermediate rest output before and after this patch
>
> "ReST output"?

Sure

>
> > are byte identical, so failing all else, we at least know it doesn't
> > make anything worse.
> >
> > Lastly, because we have three places in the code that need to insert
> > stub/dummy sections, we take the opportunity to consolidate this code
> > to handle all three cases with one function. This winds up
> > necessitating the qapidoc.py generator actually modify the section
> > list to insert a "dummy" member that acts as a placeholder for "The
> > members of ..." text. While it looks like a code smell to modify the
> > caller's argument, it is ultimately safe because the QAPI Schema
> > object is re-parsed and re-constructed in memory for each individual
> > process that needs to operate on it. In other words, the Sphinx
> > document generator already does have "its own copy" of the section
> > lists, so it is "safe" to modify here without regards to other
> > consumers of the QAPIDoc objects. It only *looks* like it smells
> > bad. Ultimately, this code will also be removed once the inliner is
> > merged, so it is only a temporary aesthetic issue regardless.
>
> Such trickery, even when safe, risks making attentive readers go
> "WAT?!?"  I find it tolerable only because we plan to replace it fairly
> soon.
>
> The code finding the spot to insert stub/dummy sections is more
> complicated than it has any right to be, both before and after your
> patch.  It reconstructs information the doc parser has, but doesn't pass
> on in usable form.  Passing that info on would likely be simpler and
> cleaner.  However, you tell me your inliner patches also simplify
> things, and they already exist.  So let's go with those.

Right, the basic idea is this:

- Differentiate INTRO with new syntax
- Convert "PLAIN" into "DETAILS"
- Enforce strict section ordering: INTRO only at the beginning,
DETAILS only at or quite near to the end

Once that is cemented, the insertion algorithm can become much simpler
and dumber; e.g. using a map of regions where we can append to the end
of a region without having to iterate through to find our sweet spot.

Since that's the plan for the inliner anyway, some temporary ugliness
here in order to ensure that we do not regress even one byte seems
acceptable.

Additionally, once the inliner is merged, we won't need the "dummy"
sections at all, so those go away entirely, and all of the ugliness of
that particular part of the hack with it - i.e. no more modifying the
caller's argument to insert a bookmark.

So, it's a little gross, but it's just a band-aid to get to where we
want to be; and it isn't as gross as it looks.

With your suggested commentary changes, do I have your blessing to
push forward? In the interim, please review the rest of the series so
I can send you a new version.

--js

>
> > That's my story and I'm sticking to it.
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
>


