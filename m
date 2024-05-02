Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DED2AC4345F
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 08:27:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2Rll-0002If-Na; Thu, 02 May 2024 04:26:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s2Rlj-0002Ho-1E
 for qemu-devel@nongnu.org; Thu, 02 May 2024 04:26:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s2RlY-0001MI-Fq
 for qemu-devel@nongnu.org; Thu, 02 May 2024 04:26:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714638367;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r0+pYBPuZcQozFtojH1FAgd/ol5l+hPsQAuxthRmbbE=;
 b=fS2mtVGc4IKnlz6+lcVNcmHNYFOU9QvP44KCJxPCTGysAeEjuCD1ajC0nZM12DcpiAIFol
 Qqv/3hm+YS31ta6ENZLdNQsLi40yOQSE/FKiatTdQso94IoAJ5aHacxwLCVImy10yB2kx6
 LAykjdDHy1c5wWzQ2i223KbBjQVeQ9c=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-635-RAY-jc8uOL6Db37VrA8asg-1; Thu,
 02 May 2024 04:26:03 -0400
X-MC-Unique: RAY-jc8uOL6Db37VrA8asg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9A9FA3820EA9;
 Thu,  2 May 2024 08:26:03 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.138])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 11E1720239F3;
 Thu,  2 May 2024 08:26:01 +0000 (UTC)
Date: Thu, 2 May 2024 09:26:00 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH] crypto: Allow building with GnuTLS but without Libtasn1
Message-ID: <ZjNOGBnv4UeaFSLI@redhat.com>
References: <20240502081144.86599-1-philmd@linaro.org>
 <d67338f5-a13a-4663-b77d-f9dac2b2936c@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d67338f5-a13a-4663-b77d-f9dac2b2936c@linaro.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.897,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, May 02, 2024 at 10:22:02AM +0200, Philippe Mathieu-Daudé wrote:
> On 2/5/24 10:11, Philippe Mathieu-Daudé wrote:
> > We only use Libtasn1 in unit tests. As noted in commit d47b83b118
> > ("tests: add migration tests of TLS with x509 credentials"), having
> > GnuTLS without Libtasn1 is a valid configuration, so do not require
> > Libtasn1, to avoid:
> > 
> >    Dependency gnutls found: YES 3.7.1 (cached)
> >    Run-time dependency libtasn1 found: NO (tried pkgconfig)
> > 
> >    ../meson.build:1914:10: ERROR: Dependency "libtasn1" not found, tried pkgconfig
> > 
> > Restrict the unit test pkix_asn1_tab[] variable to CONFIG_TASN1.
> 
> Otherwise we get:
> 
>   In file included from tests/unit/crypto-tls-psk-helpers.c:23:
>   tests/unit/crypto-tls-x509-helpers.h:26:10: fatal error:
>   libtasn1.h: No such file or directory
>      26 | #include <libtasn1.h>
>         |          ^~~~~~~~~~~~
>   compilation terminated.

I'd say that crypto-tls-psk-helpers.c shouldn't be including
crypto-tls-x509-helpers.h at all, as PSK auth does not depend
on X509 code		  

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


