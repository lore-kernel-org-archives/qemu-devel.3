Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0F84CD6E56
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 11:28:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUjlI-0002uz-58; Wed, 03 Jun 2026 07:27:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wUjlA-0002ul-Lh
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 07:27:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wUjl8-0006gY-75
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 07:27:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780486060;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AiPI7Kj1yBTSfhaqq9Rf7rhYKY3mEeGqJEwvsoccqRQ=;
 b=il0bf0wkcBnb3UAsJp7Ml4UENp+/pAoSTEcvJ5sAkwMZJrozx1emsFwiKPYj/JHXxGgmZx
 6k5qFEKG8bW9yPs+T8HeJG/foUJxfeOijeKqM6TI8Q0gI8fXifpWBA4E9xb9cOjRY9/S5X
 6Lsc6pOxfXeuqlzieWofiSIdT8IBmuM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-658-CfUD5C19M-GaWsWJKNvT-w-1; Wed,
 03 Jun 2026 07:27:37 -0400
X-MC-Unique: CfUD5C19M-GaWsWJKNvT-w-1
X-Mimecast-MFC-AGG-ID: CfUD5C19M-GaWsWJKNvT-w_1780486055
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 886221956094; Wed,  3 Jun 2026 11:27:35 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 60A20180049F; Wed,  3 Jun 2026 11:27:34 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0C11821E6A01; Wed, 03 Jun 2026 13:27:32 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Ani Sinha <anisinha@redhat.com>,  Michael Roth
 <michael.roth@amd.com>,  Igor Mammedov <imammedo@redhat.com>,  Peter
 Maydell <peter.maydell@linaro.org>,  Eric Blake <eblake@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,  Mauro
 Carvalho Chehab
 <mchehab+huawei@kernel.org>,  "Michael S. Tsirkin" <mst@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>,  Richard Henderson
 <richard.henderson@linaro.org>,  Gerd Hoffmann <kraxel@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 linux-edac@vger.kernel.org, Cleber Rosa <crosa@redhat.com>
Subject: Re: [PATCH v3 09/16] qapi/docs: adjust stub member insertion algorithm
In-Reply-To: <20260603032201.993015-10-jsnow@redhat.com> (John Snow's message
 of "Tue, 2 Jun 2026 23:21:54 -0400")
References: <20260603032201.993015-1-jsnow@redhat.com>
 <20260603032201.993015-10-jsnow@redhat.com>
Date: Wed, 03 Jun 2026 13:27:32 +0200
Message-ID: <87ecinkgnv.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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

Quick first pass...

John Snow <jsnow@redhat.com> writes:

> A forthcoming patch removes the implicit PLAIN section that always
> starts a QAPIDoc section list. Further future changes begin converting
> "PLAIN" sections to "INTRO" sections. To accommodate this, the
> insertion algorithm that places stub and dummy members must be
> adjusted to cope with not only the finished state, but temporary
> intermediate states while the series is merged.

Perhaps:

  A forthcoming patch removes the implicit PLAIN section that always
  starts a QAPIDoc section list. Further future changes begin converting
  "PLAIN" sections to "INTRO" sections.

  This will affect the code that inserts "Not documented" descriptions
  for undocumented members ("stub sections") and the dummy section that
  marks the spot for "The members of ..." references.

  Adjust the algorithm to cope with not only the finished state, but
  temporary intermediate states while the series is merged.

> This algorithm can handle zero-or-more PLAIN *or* INTRO sections at
> the beginning of a QAPIDoc object, in contrast to the previous
> algorithm which assumed and relied upon there being always one PLAIN
> section at the beginning of every QAPIDoc section list.
>
> In other words: (PLAIN | INTRO)* <EverythingElse>
>
> This does not impact what the parser itself will actually produce. As
> of this patch, the parser will still always generate QAPIDoc section
> lists that start with precisely one PLAIN section (whether or not it
> is empty), followed by the remaining sections. Those remaining
> sections may or may not include additional PLAIN sections, but never
> two such sections contiguously as the parser will always treat that
> layout as one PLAIN section consisting of multiple paragraph(s).
>
> In other other words: This insertion algorithm is more lenient than
> the parser, but this is on purpose for flexibility mid-stream as we
> convert QAPI to using explicit introductory sections. The allowed
> order of sections will eventually become strictly enforced in the
> parser, which will in turn allow dramatic simplifications to the
> insertion algorithm. This only exists as transitory code until we are
> able to enforce that order.
>
> Fear not: the intermediate rest output before and after this patch

"ReST output"?

> are byte identical, so failing all else, we at least know it doesn't
> make anything worse.
>
> Lastly, because we have three places in the code that need to insert
> stub/dummy sections, we take the opportunity to consolidate this code
> to handle all three cases with one function. This winds up
> necessitating the qapidoc.py generator actually modify the section
> list to insert a "dummy" member that acts as a placeholder for "The
> members of ..." text. While it looks like a code smell to modify the
> caller's argument, it is ultimately safe because the QAPI Schema
> object is re-parsed and re-constructed in memory for each individual
> process that needs to operate on it. In other words, the Sphinx
> document generator already does have "its own copy" of the section
> lists, so it is "safe" to modify here without regards to other
> consumers of the QAPIDoc objects. It only *looks* like it smells
> bad. Ultimately, this code will also be removed once the inliner is
> merged, so it is only a temporary aesthetic issue regardless.

Such trickery, even when safe, risks making attentive readers go
"WAT?!?"  I find it tolerable only because we plan to replace it fairly
soon.

The code finding the spot to insert stub/dummy sections is more
complicated than it has any right to be, both before and after your
patch.  It reconstructs information the doc parser has, but doesn't pass
on in usable form.  Passing that info on would likely be simpler and
cleaner.  However, you tell me your inliner patches also simplify
things, and they already exist.  So let's go with those.

> That's my story and I'm sticking to it.
>
> Signed-off-by: John Snow <jsnow@redhat.com>


