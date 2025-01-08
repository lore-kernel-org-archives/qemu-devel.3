Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29266E77199
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 13:47:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVWNz-0002za-N3; Wed, 08 Jan 2025 08:46:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1tVWNp-0002yQ-Tk
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 08:46:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1tVWNn-0002di-3I
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 08:46:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736343960;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+Mlk0rWicdwp6hnJVzit2mDYIkn5cm8d1vJY1QTZg6s=;
 b=aOTwyBbA/pw6gqsaJIjV8/MloAxTr28I8NOQFY1qWzjcw7q37ZOM/D+6FPaUy4MwP/lG7/
 l45vcndlsO49qCM1NQakYTUge4bCz3ZCFxoXA0vlWFqZaRIkEDpCFKDv510ciYQ2T96Hnd
 cTwY3iMcvnR+2dpJ82dQC5qNrUeWhh8=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-524-fndTGMvzMIKxmQZMk3N9lA-1; Wed,
 08 Jan 2025 08:45:53 -0500
X-MC-Unique: fndTGMvzMIKxmQZMk3N9lA-1
X-Mimecast-MFC-AGG-ID: fndTGMvzMIKxmQZMk3N9lA
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D703319153C8; Wed,  8 Jan 2025 13:45:51 +0000 (UTC)
Received: from dobby.home.kraxel.org (unknown [10.39.192.243])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 486581956053; Wed,  8 Jan 2025 13:45:50 +0000 (UTC)
Received: by dobby.home.kraxel.org (Postfix, from userid 1000)
 id A43C62CDE47; Wed, 08 Jan 2025 14:45:47 +0100 (CET)
Date: Wed, 8 Jan 2025 14:45:47 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, 
 qemu-devel@nongnu.org, graf@amazon.com, Paolo Bonzini <pbonzini@redhat.com>, 
 Michael Roth <michael.roth@amd.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 Eric Blake <eblake@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v2 00/21] hw/uefi: add uefi variable service
Message-ID: <f74vd4sabo4ndrlq6jm7xish5wzgkh4lqksqdi6s6pv43acagt@wl74akpl237h>
References: <20250107153353.1144978-1-kraxel@redhat.com>
 <CAMxuvazrd+3v2qqO-5o3qpky-ULRTwvU48jkwdxMPZG5c1RA1A@mail.gmail.com>
 <Z35ulWfiCNq-cd3Y@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z35ulWfiCNq-cd3Y@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.432,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

  Hi,

> > Typically the kind of new code that I wish would be in Rust. But I
> > suppose it is too early yet, and you came to the same conclusion.
> > Probably a good candidate for rewrite though!
> 
> Perhaps too early for the device impl, but I would have thought
> the general var-service code could be done in rust today. It does
> not have all that much interaction with other parts of the QEMU
> codebase & thus wouldn't be building on the moving target of the
> QOM/Device abstractions. It would also be the prime part that
> could be shared with coconut-svsm too.

That remains to be seen.  The svsm code will indeed most likely be
written in rust.  There are a number of noteworthy differences though:

 * It's a totally different environment (no_std).
 * Persistent storage for the vars will be different.
 * Crypto code will be different (probably openssl because the vTPM
   needs that too, possibly native rust crypto).

So not fully sure the code sharing part will actually work out ...

I plan to keep this in mind when designing the svsm code though, and
then revisit things once I have some actual rust code for this and the
rust support in qemu is more mature.

take care,
  Gerd


