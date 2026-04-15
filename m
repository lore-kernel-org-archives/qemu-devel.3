Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D633F41980
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2026 09:45:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCwmz-0007Gf-VO; Wed, 15 Apr 2026 05:44:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wCwmu-0007Fs-Pj
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 05:44:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wCwms-0002Ov-3c
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 05:44:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776246236;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=H/ezlHI5ydLxNWsVnlvNrUEP7ope9Z1FbS0TQWCw6U4=;
 b=BeznosNDvg38TWszLkJPDWoZwRgdMvdtx/FQ/biS9u7W4dnpBaUDiF1G4qRM9WbdPRPqAZ
 AD88OYyQAZpgesHnn2fqPidFPx4qOncr0snnqytWwUTqrdtzeDAOGKxehYPtsX7Lr0R9CZ
 2ccul1b6MMOa6wq4RIxZXCPp4+tP7ag=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-345-g5salM2KPtO5AsDrkUKfUg-1; Wed,
 15 Apr 2026 05:43:52 -0400
X-MC-Unique: g5salM2KPtO5AsDrkUKfUg-1
X-Mimecast-MFC-AGG-ID: g5salM2KPtO5AsDrkUKfUg_1776246230
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 36B7718005AC; Wed, 15 Apr 2026 09:43:49 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 737B0300022B; Wed, 15 Apr 2026 09:43:47 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1A9F121E6A28; Wed, 15 Apr 2026 11:43:45 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Kashyap Chamarthy <kchamart@redhat.com>,  Stefan
 Berger <stefanb@linux.vnet.ibm.com>,  Mauro Carvalho Chehab
 <mchehab+huawei@kernel.org>,  Michael Roth <michael.roth@amd.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-block@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,  Yanan Wang
 <wangyanan55@huawei.com>,  Hanna Reitz <hreitz@redhat.com>,  Peter Xu
 <peterx@redhat.com>,  Igor Mammedov <imammedo@redhat.com>,  "Michael S.
 Tsirkin" <mst@redhat.com>,  Kevin Wolf <kwolf@redhat.com>,  =?utf-8?Q?Mar?=
 =?utf-8?Q?c-Andr=C3=A9?=
 Lureau <marcandre.lureau@redhat.com>,  Stefano Garzarella
 <sgarzare@redhat.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Lukas
 Straub <lukasstraub2@web.de>,  Jason Wang <jasowang@redhat.com>,  Alex
 Williamson <alex@shazbot.org>,  Paolo Bonzini <pbonzini@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,  Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,  =?utf-8?Q?C=C3=A9dric?=
 Le Goater
 <clg@redhat.com>,  Stefan Hajnoczi <stefanha@redhat.com>,  Peter Maydell
 <peter.maydell@linaro.org>,  Eric Blake <eblake@redhat.com>,  Alex
 =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>,  Kostiantyn Kostiuk <kkostiuk@redhat.com>,  Jiri
 Pirko <jiri@resnulli.us>,  Ani Sinha <anisinha@redhat.com>,  Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH v2 00/10] qapi: enforce section ordering
In-Reply-To: <20260408045531.3006678-1-jsnow@redhat.com> (John Snow's message
 of "Wed, 8 Apr 2026 00:55:21 -0400")
References: <20260408045531.3006678-1-jsnow@redhat.com>
Date: Wed, 15 Apr 2026 11:43:45 +0200
Message-ID: <87zf341ru6.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

John Snow <jsnow@redhat.com> writes:

> Hiya, this series is meant to accomplish mostly one thing: Enforce a
> stricter ordering of sections in QAPI documentation blocks.
>
> The reason to do this is mostly for the sake of the inliner: if QAPI
> documentation blocks have some known, canonical order, it is easier to
> merge two documentation blocks together for the purposes of showing all
> arguments for commands/etc in a simple, flat list without needing to
> follow hyperlink breadcrumbs.
>
> Another reason to do this is to simplify where we insert autogenerated
> documentation. If the order is enforced, then inserting "Not Documented"
> stubs for members and generated "Returns:" statements can have a much
> simpler algorithm that will always match how manually written
> documentation is presented, in the same order.
>
> This is still pretty RFC quality, the tests have not been implemented
> and the implementation of changes in the parser are still pretty
> fuzzy. The main point of this series at this point in time is to review
> the QAPI source changes and decide if the strategy employed in fixing
> the section ordering is the direction we ultimately want to go in.
>
> V2:
>  - Add quite a few FIXME stubs for tests
>  - Much more carefully delineate QAPI source changes into ones required
>    to prevent visible changes, and ones that explictly create visible
>    changes
>  - Various commit message / comment changes
>  - Fix heuristic for griping about Intro/Details "ambiguity" to also
>    ignore generated "Returns" sections, which was missing before and
>    missed quite a few cases that did impact rendered output
>
> To verify rendering changes (or lack thereof), I used this strategy:
>
> (1) For a reference output before a change, I ran a build:
>     > V=1 DEBUG=1 make -j13;
>
> (2) Then I created some reference output for the intermediate rST
>     debugging output files (fish syntax):
>     > for i in *.ir; sed -E 's|\.json:[0-9]{4}|.json:nnnn|g' $i > $i.ref; end
>
> (3) Then after applying a patch, to check for any differences, I re-ran
>     the build as in (1) and then:
>     > for i in *.ir; sed -E 's|\.json:[0-9]{4}|.json:nnnn|g' $i > $i.new; end
>     > for i in *.ir; meld $i.ref $i.new; end
>
> An observation: Most of the time, the Intro section is only one
> paragraph anyway. We might be able to save on some explicit "Details:"
> syntax if we just formalize the idea that the intro can only ever be at
> most one paragraph. I don't know if we want to do that (Do we want to
> keep the ability to run long in the "intro"?) - but it would cut down on
> quite a lot of markup that this series adds.

The series adds 59 "Details:" markers to ~1150 doc comments, i.e. about
one in twenty doc comments needs one.

I can see several ways to skin this cat:

1. Intro ends when something else begins

   Intro can be any number of paragraphs.

   When intro is followed by details, we need a way to mark the
   boundary.  That's your "Details:" marker.  Relatively rare.

   Drawback: since you need "Details:" only rarely, it is easy to
   forget.  Details are then mistaken for intro or the other way round.
   The inliner will lose details / fail to lose intro.

   This is what your series gives us.

2. Intro ends after the first paragraph if we have one.

   Intro can be empty or one paragraph.

   When empty intro is followed by details, we need a way to mark the
   boundary, such as "Details:".  This is quite rare.

   Drawback: "at most one paragraph" is not obvious and easy to forget.
   Extra intro paragraphs end up in details then, where the inliner will
   copy them.

   Drawback: since you need "Details:" almost never, it is easy to
   forget.  The first paragraph of Details is mistaken for intro then.
   The inliner will lose it.

3. Make the end of intro syntactically obvious always

3a. Require the "Details:" line

   Intro can be any number of paragraphs.

   Drawback: the syntax is rather clumsy.  ~270 doc comments have
   details, and every one of them needs a "Details:" line.

   Drawback: you can still forget the "Details:" line.  If you do, the
   entire details will be mistaken for intro, and the inliner will lose
   them.

3b. Require a "Details:" tag

   Like 3a, but with slightly less clumsy syntax.  Instead of

      # @Frob:
      #
      # Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do
      # eiusmod tempor incididunt ut labore et dolore magna aliqua.
      #
      # Details:
      #
      # Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris
      # nisi ut aliquip ex ea commodo consequat.
      #
      # Duis aute irure dolor in reprehenderit in voluptate velit esse
      # cillum dolore eu fugiat nulla pariatur.

   we get

      # @Frob:
      #
      # Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do
      # eiusmod tempor incididunt ut labore et dolore magna aliqua.
      #
      # Details: Ut enim ad minim veniam, quis nostrud exercitation ullamco
      #     laboris nisi ut aliquip ex ea commodo consequat.
      #
      #     Duis aute irure dolor in reprehenderit in voluptate velit esse
      #     cillum dolore eu fugiat nulla pariatur.

   Drawback: the syntax is still clumsy.  ~270 doc comments have
   details, and every one of them needs a "Details:" tag and be
   reindented.

   Drawback: if you forget to tag details, they get mistaken for intro,
   and the inliner will lose them.  Less likely than with 3a?

3c. Indent intro like descriptions and tagged sections.

   Like so:

      # @Frob:
      #     Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do
      #     eiusmod tempor incididunt ut labore et dolore magna aliqua.
      #
      # Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris
      # nisi ut aliquip ex ea commodo consequat.
      #
      # Duis aute irure dolor in reprehenderit in voluptate velit esse
      # cillum dolore eu fugiat nulla pariatur.

   Drawback: all the intros get reindented.

   Drawback: if you format intro the old way, it gets mistaken for
   details, and the inliner will fail to lose it.  Likely to happen
   initially, but hopefully becomes unlikely once people got used to it.

   Anything else?

3d. Both 3b and 3c

   Intros and details written the old way get rejected.

   Drawback: all intros and all details need to be reindented.

   Anything else?

Thoughts?


