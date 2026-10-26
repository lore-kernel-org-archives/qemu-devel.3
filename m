Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973BC606A31B
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 06:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=R/73QE4s
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLED3-0006T7-0J; Mon, 26 Oct 2026 02:29:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xLECR-0006QT-Cp
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 02:29:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xLECP-0005P1-Hv
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 02:28:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792996128;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oyx+CADSwdj2xvA5MRQPOEWYy3UsifleJ6zhocLbwL4=;
 b=R/73QE4s7FPSDDkjLLS5uJXzyf1GeIhasxlMACHmsSkSY0Wat6yJMnxiCJLuoAdn/ZMxUa
 BbTkRuCz8lFW8GIIUhqOHtuypgyJxAhfsEu5Tu0to5EpEij+BeKDxs2ED0U/i4AK18MeO7
 hzbzKkRh3rL8timM+Vkr3Bb8oYTInzI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-467-OE7Xtw-ZPXa1Z8WxZDQ6Kg-1; Mon,
 26 Oct 2026 02:28:44 -0400
X-MC-Unique: OE7Xtw-ZPXa1Z8WxZDQ6Kg-1
X-Mimecast-MFC-AGG-ID: OE7Xtw-ZPXa1Z8WxZDQ6Kg_1792996124
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A26AF19560B4; Mon, 26 Oct 2026 06:28:43 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3908518004D2; Mon, 26 Oct 2026 06:28:43 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D674D21E6A04; Mon, 26 Oct 2026 07:28:40 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-block@nongnu.org,  qemu-devel@nongnu.org,  Kevin Wolf
 <kwolf@redhat.com>,  John Snow <jsnow@redhat.com>,  "Denis V . Lunev"
 <den@openvz.org>,  Eric Blake <eblake@redhat.com>,  Stefan Hajnoczi
 <stefanha@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 06/12] qapi/block: Add BLOCK_IO_DELAY event
In-Reply-To: <44691c04-0bd0-48de-afc5-56f2cddd5662@redhat.com> (Hanna
 Czenczek's message of "Fri, 23 Oct 2026 16:33:45 +0200")
References: <20261019182028.45305-1-hreitz@redhat.com>
 <20261019182028.45305-7-hreitz@redhat.com>
 <87a4o8sw79.fsf@pond.sub.org>
 <65193d93-2fcc-4a39-8e54-d16022855bbf@redhat.com>
 <87pkx1gczk.fsf@pond.sub.org>
 <44691c04-0bd0-48de-afc5-56f2cddd5662@redhat.com>
Date: Mon, 26 Oct 2026 07:28:40 +0100
Message-ID: <87jyn56kmf.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 2
X-Spam_score: 0.2
X-Spam_bar: /
X-Spam_report: (0.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.339,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hanna Czenczek <hreitz@redhat.com> writes:

> On 23.10.26 08:14, Markus Armbruster wrote:

[...]

>> In sane usage, @delay-report-ns < @delay-stop-ns.  Correct?
>
> Well, uh, I suppose. The opposite could be imagined, but if someone wants=
 that, that might rather indicate they would really want an array of thresh=
olds rather than a single one, so=E2=80=A6 As long as we just have a single=
 reporting threshold, `@delay-report-ns < @delay-stop-ns` is the sane usage=
, yes.

Three options, I think:

1. Make @delay-stop-ns < @delay-stop-ns an error.

2. Advice users that @delay-stop-ns < @delay-stop-ns probably makes no
   sense.

3. Nothing, because we trust users they can figure this out themselves.

Entirely up to you!

[...]


