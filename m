Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F82CC73C66
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2024 11:04:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjcwd-00020P-KW; Thu, 29 Aug 2024 07:04:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sjcwb-0001sE-Vz
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 07:04:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sjcwY-0007ZC-NV
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 07:04:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724929438;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Vmyo8rb1VpUAEtVbigZ0KJZmrQV76sPVOZAW0UJZWi0=;
 b=clGtc7MDyq/uStxPIxYfRgeJHGdkI2VOA1WvDGMeDnkY4ZJ4ok5DgaJCLRUSqqAUCVWyPi
 fNNK5SGd5+uTgllLcTCxdEi0sblmaIjBN/DtFZuUF218NYTXdzUz+k7XSnTxywDY+OWszU
 ZnH8h9d7W5XE6thn0edOUGOo2Iliqbc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-272-y9WfbsuYNj6ikD8LYjHZQg-1; Thu,
 29 Aug 2024 07:03:55 -0400
X-MC-Unique: y9WfbsuYNj6ikD8LYjHZQg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A710F1955BF6; Thu, 29 Aug 2024 11:03:53 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.64])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 391AA19560A3; Thu, 29 Aug 2024 11:03:49 +0000 (UTC)
Date: Thu, 29 Aug 2024 12:03:45 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Blake <eblake@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Hyman Huang <yong.huang@smartx.com>,
 Qemu-block <qemu-block@nongnu.org>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PULL 10/11] crypto: push error reporting into TLS session I/O
 APIs
Message-ID: <ZtBVkSR6KtEB3v4G@redhat.com>
References: <20240724094706.30396-1-berrange@redhat.com>
 <20240724094706.30396-11-berrange@redhat.com>
 <25ea7357-99e1-4fdf-9ef8-885cb7e75f47@redhat.com>
 <ZrotVcPk1XQa53gs@redhat.com> <87plpumonz.fsf@pond.sub.org>
 <623915fb-4d6d-4de8-921a-cf6ad315c060@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <623915fb-4d6d-4de8-921a-cf6ad315c060@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Wed, Aug 28, 2024 at 10:32:15AM +0200, Thomas Huth wrote:
> On 27/08/2024 09.05, Markus Armbruster wrote:
> > Daniel P. Berrangé <berrange@redhat.com> writes:
> > 
> > > On Mon, Aug 12, 2024 at 05:38:41PM +0200, Thomas Huth wrote:
> > > > On 24/07/2024 11.47, Daniel P. Berrangé wrote:
> > > > > The current TLS session I/O APIs just return a synthetic errno
> > > > > value on error, which has been translated from a gnutls error
> > > > > value. This looses a large amount of valuable information that
> > > > > distinguishes different scenarios.
> > > > > 
> > > > > Pushing population of the "Error *errp" object into the TLS
> > > > > session I/O APIs gives more detailed error information.
> > > > > 
> > > > > Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> > > > > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > > > > ---
> > > > 
> > > >   Hi Daniel!
> > > > 
> > > > iotest 233 is failing for me with -raw now, and bisection
> > > > points to this commit. Output is:
> > > > 
> > > > --- .../qemu/tests/qemu-iotests/233.out
> > > > +++ /tmp/qemu/tests/qemu-iotests/scratch/raw-file-233/233.out.bad
> > > > @@ -69,8 +69,8 @@
> > > >   1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> > > > 
> > > >   == check TLS with authorization ==
> > > > -qemu-img: Could not open 'driver=nbd,host=127.0.0.1,port=PORT,tls-creds=tls0': Failed to read option reply: Cannot read from TLS channel: Software caused connection abort
> > > > -qemu-img: Could not open 'driver=nbd,host=127.0.0.1,port=PORT,tls-creds=tls0': Failed to read option reply: Cannot read from TLS channel: Software caused connection abort
> > > > +qemu-img: Could not open 'driver=nbd,host=127.0.0.1,port=PORT,tls-creds=tls0': Failed to read option reply: Cannot read from TLS channel: The TLS connection was non-properly terminated.
> > > > +qemu-img: Could not open 'driver=nbd,host=127.0.0.1,port=PORT,tls-creds=tls0': Failed to read option reply: Cannot read from TLS channel: The TLS connection was non-properly terminated.
> > > 
> > > This is an expected change. Previously squashed the real GNUTLS error
> > > into ECONNABORTED:
> > > 
> > > -        case GNUTLS_E_PREMATURE_TERMINATION:
> > > -            errno = ECONNABORTED;
> > > -            break;
> > > 
> > > 
> > > now we report the original gnutls root cause.
> > > 
> > > IOW, we need to update the expected output files.
> > 
> > Has this been done?
> 
> No, I think the problem still persists.

I've just cc'd you both on a patch that fixes this.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


