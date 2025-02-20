Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4265BC021B1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 11:30:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tl4kB-0002f8-Gt; Thu, 20 Feb 2025 06:29:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1tl4k5-0002eQ-AR
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 06:29:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1tl4k1-0008Fo-Ff
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 06:29:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740050955;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=S1q11+8OULlJzjXxJu+62x1kawbZPib2TIjL8eJAys0=;
 b=VgXi5+O1zPx+//ZZFqLfW4M2S8Ug5QkR0JmoeI7EX4HXqZEp8hARELqNlBtzzXeDxcIr3l
 oIHcZuTfGb/hcAmbGJfQyvr9J8b0fObfa9ePYlrhEfhBL9xUm7dFsSkHgq6FDdh9V8kZ2l
 ke/uxhX9Bz1gYqDcaLze97XDkRAsBpw=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-280-26pWaIwFPbumOMXGQxSdag-1; Thu,
 20 Feb 2025 06:29:11 -0500
X-MC-Unique: 26pWaIwFPbumOMXGQxSdag-1
X-Mimecast-MFC-AGG-ID: 26pWaIwFPbumOMXGQxSdag_1740050950
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DCE77193578F; Thu, 20 Feb 2025 11:29:08 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.32.78])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0DEBC1956094; Thu, 20 Feb 2025 11:29:03 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 95577180078D; Thu, 20 Feb 2025 12:28:58 +0100 (CET)
Date: Thu, 20 Feb 2025 12:28:58 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 Markus Armbruster <armbru@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 Artyom Tarasenko <atar4qemu@gmail.com>, 
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: Any plan for command line '-g' option (graphical resolution and
 depth)?
Message-ID: <r5meqdelakahx74pn7iqrb6lkcunh7uifecm2jitfqvnogzsjy@czooelkacrl2>
References: <97e66ba5-488f-4246-b4d9-466d29a86dff@linaro.org>
 <e514d6db-781d-4afe-b057-9046c70044dc@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e514d6db-781d-4afe-b057-9046c70044dc@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.191,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

> Yes, we should have an easy way for machine to allow, in addition to -M
> graphics=BOOLEAN, the structured property -M
> graphics.{width,height,depth,enabled}. Then '-g' can desugar to -M
> graphics.width=WW,graphics.height=HH,graphics.depth=BB.
> 
> > It is also used to set TYPE_NUBUS_MACFB properties in hw/m68k/q800.c.
> > Here i suppose we could directly use '-global nubus-macfb.width=value'
> > etc. although I'm not sure it is the recommended way.
> > > Should we start deprecating '-g' as a whole?
> 
> Only if it's unused/useless.  If the option is useful it could also be used
> for EDID, for example (adding Gerd).

Most but not all display devices have xres + yres properties which are
communicated to the guest some way.  In case of the stdvga it's edid
indeed.  So, yes, having '-g WxH' set these properties makes sense.  The
depth can not be configured though.

take care,
  Gerd


