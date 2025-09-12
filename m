Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45BBFCAC582
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 08:35:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwzEs-0007vz-T5; Fri, 12 Sep 2025 04:34:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uwzEm-0007vf-Ax
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 04:34:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uwzEc-0004hy-NE
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 04:34:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757666060;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=14xZn5G4Urm3Om3xD7aUT/piJTVVQkd8B73ggPx0R6o=;
 b=Dpf0iCQDfFoh/XZcQtszy9CXy/tdLEEpxbU7ma61SwquyVTcc1/5pBhgAsk9tcIatwu0d7
 I7FTrDqZzdUe189YsBovWv6iKVLttKjCRvVR7gDF9MfbZLRFgPMHT4iS1xa4uVVLkAmI4R
 ryJNm1ipjU9elXtOmSq+29MGqzla/5Y=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-354-GPmkBeszPgCwEbhs4wSP8g-1; Fri,
 12 Sep 2025 04:34:16 -0400
X-MC-Unique: GPmkBeszPgCwEbhs4wSP8g-1
X-Mimecast-MFC-AGG-ID: GPmkBeszPgCwEbhs4wSP8g_1757666055
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DB9361800285; Fri, 12 Sep 2025 08:34:14 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.154])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D40871800446; Fri, 12 Sep 2025 08:34:07 +0000 (UTC)
Date: Fri, 12 Sep 2025 09:34:03 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: "Dr. David Alan Gilbert" <dave@treblig.org>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Stefan Weil <sw@weilnetz.de>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v3 17/20] util: add support for formatting a workload
 name in messages
Message-ID: <aMPa-yjEzsdsqjZO@redhat.com>
References: <20250910180357.320297-1-berrange@redhat.com>
 <20250910180357.320297-18-berrange@redhat.com>
 <aMMwuEqguq62FZhU@gallifrey>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aMMwuEqguq62FZhU@gallifrey>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Thu, Sep 11, 2025 at 08:27:36PM +0000, Dr. David Alan Gilbert wrote:
> * Daniel P. Berrangé (berrange@redhat.com) wrote:
> > The error_report function can include the guest name in any
> > messages it prints. The qemu_log function has no equivalent
> > behaviour.
> > 
> > This introduces support for a "workload name" in the new
> > messages API, which in the case of system emulators will
> > be the guest name. The possibility of defining a workload
> > name for other binaries is left as an exercise for the
> > future.
> > 
> > This change has no impact on the output of the error_report
> > function, but will change the qemu_log function. This can
> > be easily seen with the 'log' trace backend, and how it is
> > now more closely matching error_report output.
> > 
> > Before:
> > 
> >   # qemu-system-x86_64 -msg guest-name=on -name blah -object tls-creds-x509,id=t0,dir=fish -d 'trace:qcrypto*'
> >   qcrypto_tls_creds_x509_load TLS creds x509 load creds=0x55b3af3fd870 dir=fish
> >   qcrypto_tls_creds_get_path TLS creds path creds=0x55b3af3fd870 filename=ca-cert.pem path=<none>
> >   blah qemu-system-x86_64: Unable to access credentials fish/ca-cert.pem: No such file or directory
> > 
> > After:
> > 
> >   # qemu-system-x86_64 -msg guest-name=on -name blah -object tls-creds-x509,id=t0,dir=fish -d 'trace:qcrypto*'
> >   blah qcrypto_tls_creds_x509_load TLS creds x509 load creds=0x55b3af3fd870 dir=fish
> >   blah qcrypto_tls_creds_get_path TLS creds path creds=0x55b3af3fd870 filename=ca-cert.pem path=<none>
> >   blah qemu-system-x86_64: Unable to access credentials fish/ca-cert.pem: No such file or directory
> > 
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> 
> Are you going to want to escape that? I see later you're adding []'s around it,
> which makes it feel like you want to end up with it parsable, but if some nasty
> person does:
> 
> -name ']})🐧({['
> 
> then things get confusing; I guess you're hoping that whoever calls qemu will
> be careful not to allow that.

I was considering the log output to be human targetted, rather
than something to be parsed. IOW, if users want to confuse
themselves with wierd names, that's their own (unwise) decision.

If we added ecaping of the name, it'd probably even more difficult
to read for a human, even if we make it a bit easier for humans ?

TL;DR: do we care about parseability here, or just humans reading ?

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


