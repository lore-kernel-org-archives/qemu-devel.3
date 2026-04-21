Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D408DF8925F
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 11:19:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wF97m-0000ry-Ox; Tue, 21 Apr 2026 07:18:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wF97k-0000rc-Rc
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 07:18:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wF97j-0005P4-Bi
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 07:18:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776770311;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=U0dEDeN+jE+VmLDvab62h8pagMGyNmeXAXT83EAG9CE=;
 b=h8VPDyvarzoPNebZudKDvBzfvYg3j0WtE76V/ey2Jp/YF+t6eqGhmtyfx36cGO3PcLOxjS
 Z4MBLhlT3B6nB2T2ckxBXap944xhAc8LykzgG5Roo4sQz0LNt1Ixx/tIkoJOpqeUF5mONm
 ZDoNRW9g4keznJ/gHfp23iYmktMqnRs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-171-cBfWl3dXMveZi14cyWDj6Q-1; Tue,
 21 Apr 2026 07:18:29 -0400
X-MC-Unique: cBfWl3dXMveZi14cyWDj6Q-1
X-Mimecast-MFC-AGG-ID: cBfWl3dXMveZi14cyWDj6Q_1776770309
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D623F195606F
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2026 11:18:28 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.22])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 942F5195608E
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2026 11:18:28 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1CE5C21E6A28; Tue, 21 Apr 2026 13:18:26 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>
Subject: Re: [PATCH] tests: add test for json-streamer.c error recovery
In-Reply-To: <CABgObfZQBj5tpi49E83fLs9+azwDE-aPiD_Jue7bzOXAPSXntg@mail.gmail.com>
 (Paolo Bonzini's message of "Mon, 20 Apr 2026 13:00:40 +0100")
References: <20260331095950.512326-1-pbonzini@redhat.com>
 <877bq1df03.fsf@pond.sub.org>
 <CABgObfZQBj5tpi49E83fLs9+azwDE-aPiD_Jue7bzOXAPSXntg@mail.gmail.com>
Date: Tue, 21 Apr 2026 13:18:26 +0200
Message-ID: <87340o7e9p.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Paolo Bonzini <pbonzini@redhat.com> writes:

> Il lun 20 apr 2026, 12:53 Markus Armbruster <armbru@redhat.com> ha scritto:
>
>> > Before rewriting the error recovery code to work in a push parsing
>> > setup, make sure that we have tests for it.
>> >
>> > Cover various cases of invalid JSON, to check that structural
>> > recovery based on balanced brackets and braces works; and
>> > lexer-based recovery which documents "\f" as a sure fire
>> > way to reset the lexer.
>>
>> How is this related to tests/unit/check-qjson.c?
>>
>
> It tests at a lower level, talking directly to the json-streamer.c API.
> check-qjson.c only uses qobject_from_json() so it never tests more than one
> (attempted) JSON object in the input.

I see.

There's overlap between the two.  More on that in the review I'm about
to send.

Thanks!


