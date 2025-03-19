Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90C38C35FFF
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 08:30:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuonp-0003Iw-CO; Wed, 19 Mar 2025 04:29:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1tuonl-0003I0-ON
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 04:29:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1tuond-0008OD-I8
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 04:29:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742372954;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/bJ6MbFwN+di6JVTLn1fhmV28rnHIqOgYBZ2FBtGYb8=;
 b=Fe07paV5v1bDZTsDoXo5MB5a40Kytvo3Qp/WdNB3Gcgi6tY9XR3IRbEuYmGF5mKll7Yi5x
 pkDukFKj/ZimP8nwgh0+/W3RGanTXbxzXYvvqfeyOyi9jhwwHXT40JLfXG6FUsg8eJ5IVR
 k/+CZ4mgvsyrADTa9DBmGo8wxfqR2R8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-588-RwIdvYrCN0yCUePFZyJBgQ-1; Wed,
 19 Mar 2025 04:29:11 -0400
X-MC-Unique: RwIdvYrCN0yCUePFZyJBgQ-1
X-Mimecast-MFC-AGG-ID: RwIdvYrCN0yCUePFZyJBgQ_1742372950
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F30A71956064; Wed, 19 Mar 2025 08:29:09 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.45.224.38])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0E00F1955BE1; Wed, 19 Mar 2025 08:29:07 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 91F8818000AF; Wed, 19 Mar 2025 09:29:04 +0100 (CET)
Date: Wed, 19 Mar 2025 09:29:04 +0100
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
Message-ID: <wcpg5idrxwq6fntknc4vubnzaeqqqgqbpo5rdiqhumk745hsu5@tofolnd6v4dt>
References: <20250304124815.591749-1-kraxel@redhat.com>
 <20250304124815.591749-15-kraxel@redhat.com>
 <CAFEAcA9_rb321OBOfv9v84ZLO7aw_8t8pTDMUYxj2SNnSBfRmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA9_rb321OBOfv9v84ZLO7aw_8t8pTDMUYxj2SNnSBfRmg@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
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

  Hi,

> Hi; Coverity points out some problems in this code
> (CID 1593154, 1593157):

I'll send fixes later today.

> Do we absolutely need to be operating on a continuously open
> filedescriptor here rather than a filename? If we could make
> these functions use uv->jsonfile each time then we could use
> the glib functions g_file_get_contents() and
> g_file_set_contents(), which get all the pesky details of the
> error handling right for you.

qemu_create() works only once in case libvirt hands us a
file handle instead of a filename.

take care,
  Gerd


