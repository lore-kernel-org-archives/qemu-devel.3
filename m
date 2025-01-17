Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61886C02185
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 13:21:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYmH1-0003r7-VA; Fri, 17 Jan 2025 08:20:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tYmH0-0003qv-1d
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 08:20:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tYmGy-0006Me-FQ
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 08:20:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737120022;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bnsBFEaqcbJMeWOEJt0sktShqsSJAIDe54vk5Al6waE=;
 b=L1bry0xA7xCQEuyKX2+qglIk1pVnrTD3kYhJI9CbZgr+i6JlQ60o6r8CstuipEmq5KwvXv
 ERkYeRiqFmsTcEW8VuHNHgx6k/cFA0rGhKTSDvG7/N0vzYvzWyRt0IffSDwOj0imzHTeK6
 hXHT7uueQc4qQCUzFOw1zM0/riCiO7M=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-556-DWLmY5glNXyWgPOMUbhHvA-1; Fri,
 17 Jan 2025 08:20:18 -0500
X-MC-Unique: DWLmY5glNXyWgPOMUbhHvA-1
X-Mimecast-MFC-AGG-ID: DWLmY5glNXyWgPOMUbhHvA
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 517B919560B8; Fri, 17 Jan 2025 13:20:17 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.176])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CC72C1955F1B; Fri, 17 Jan 2025 13:20:15 +0000 (UTC)
Date: Fri, 17 Jan 2025 14:20:13 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Roman Penyaev <r.peniaev@gmail.com>
Cc: Markus Armbruster <armbru@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v4 6/8] chardev/char-mux: implement backend chardev
 multiplexing
Message-ID: <Z4pZDeGqoqg4Iedk@redhat.com>
References: <20241016102605.459395-1-r.peniaev@gmail.com>
 <20241016102605.459395-7-r.peniaev@gmail.com>
 <CAJ+F1CLkn2WcmJEmNpJwNcc5VPriDTdSFWcv44QWaYtvHycKcQ@mail.gmail.com>
 <87frmuwo6p.fsf@pond.sub.org>
 <CACZ9PQUk7ZjwfYWVNq3z2Wp_pnkKO8ObhLc6uy5ABHq2yCL9Ag@mail.gmail.com>
 <Z4jtJMNeXexEEpVZ@redhat.com>
 <CACZ9PQVzRwgqix=6Do67kgLEJNP4xQZ4dHKrfONHh78vJU1CLg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACZ9PQVzRwgqix=6Do67kgLEJNP4xQZ4dHKrfONHh78vJU1CLg@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.132,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.79,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Am 17.01.2025 um 09:03 hat Roman Penyaev geschrieben:
> On Thu, Jan 16, 2025 at 12:27 PM Kevin Wolf <kwolf@redhat.com> wrote:
> > Whatever you choose to do, my one request for you would be that you
> > really make sure that CLI and QMP are structured and behave exactly the
> > same with your new option, to avoid making the problem worse than it
> > already is.
> 
> I understand this as keeping compatibility between CLI and QAPI at the
> command line interface level. In simple words: a new command line option
> "list.0=id0,list.1=id1" should be parsed in CLI exactly as QAPI will parse
> it in the possible bright future (I mean once the whole chardev is switched
> to QAPI). If my understanding is correct, then, with Markus and Mark-Andre
> help, I'm on the right track.

Yes, that's exactly what I mean. Good to hear that you're already
planning to keep this in mind.

Kevin


