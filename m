Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8017C35FFA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 11:39:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1turm1-0006Ha-5o; Wed, 19 Mar 2025 07:39:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1turlt-0006Eg-6h
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 07:39:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1turlr-0008JJ-BF
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 07:39:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742384378;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4VEK/kMEJxog7cOQheaMglQ/0TdCFhswXeMf1Ry5mPc=;
 b=Okw8Q6XB0MjzlOTaaGDB1lPgwz5oxdrPnKso21eMMy6i7KGcx45bKthqm3q0euXxRX/KGF
 bNSqg3sNFFByOwrHyQk/13VTbA5lyGAOeRQpWcJBJnr+Ra13AJniNFs25yKhoA5ZHrg3mi
 vX79BeEfXja4JofmGwqjOMrHF6qnyrI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-38-THc1bAz-O_uQFiGt5x4sxw-1; Wed,
 19 Mar 2025 07:39:32 -0400
X-MC-Unique: THc1bAz-O_uQFiGt5x4sxw-1
X-Mimecast-MFC-AGG-ID: THc1bAz-O_uQFiGt5x4sxw_1742384371
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0042819560BF; Wed, 19 Mar 2025 11:39:31 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.45.224.38])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D8E7D18001F6; Wed, 19 Mar 2025 11:39:29 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 875D918000AF; Wed, 19 Mar 2025 12:39:27 +0100 (CET)
Date: Wed, 19 Mar 2025 12:39:27 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Eric Blake <eblake@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Michael Roth <michael.roth@amd.com>, 
 Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>, 
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PULL 14/24] hw/uefi: add var-service-json.c + qapi for NV vars.
Message-ID: <fimc5ulpt3536p4enp7eykwzmsin4qkucmhvrmkr4kiutclztv@4koxypatj5hg>
References: <20250304124815.591749-1-kraxel@redhat.com>
 <20250304124815.591749-15-kraxel@redhat.com>
 <CAFEAcA9_rb321OBOfv9v84ZLO7aw_8t8pTDMUYxj2SNnSBfRmg@mail.gmail.com>
 <wcpg5idrxwq6fntknc4vubnzaeqqqgqbpo5rdiqhumk745hsu5@tofolnd6v4dt>
 <CAFEAcA_MbaZjv9R0YjfHNuAqqMsHBm3-AeqnVp7w8hTHFMpz5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA_MbaZjv9R0YjfHNuAqqMsHBm3-AeqnVp7w8hTHFMpz5w@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.337,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Wed, Mar 19, 2025 at 10:18:08AM +0000, Peter Maydell wrote:
> On Wed, 19 Mar 2025 at 08:29, Gerd Hoffmann <kraxel@redhat.com> wrote:
> > qemu_create() works only once in case libvirt hands us a
> > file handle instead of a filename.
> 
> If we have to work on a filehandle, we have the problem
> that if the host crashes after the ftruncate() and
> before the write() of the new data then we just lost
> the contents of the var store. Working on filenames
> would let us do "write new file and then rename in to
> position".

Yes.  Drawback of the libvirt filehandle passing is that
this rename trick is not going to work.

> If you need to try to operate on a filehandle
> in a "don't lose the data for crashes mid-write" that
> gets tricky. Do we care ?

Do we have a chance to care?

Probably this is still better than what we had before.  Pflash updates
are slow and need lots of vmexits, so I guess there is a higher chance
to end up with a corrupted varstore in case of a host reset in a
unpleasent moment.

take care,
  Gerd


