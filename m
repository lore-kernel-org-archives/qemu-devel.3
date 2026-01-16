Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4313D3CCAB
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 09:48:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vggN6-000086-G8; Fri, 16 Jan 2026 04:44:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vggN3-00007I-Ko
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 04:43:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vggMz-0007FJ-Sx
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 04:43:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768556632;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I8YVAeplXYnvRzdj+eZyk7d+O5KSiXJJHtJ7ZiJfdRA=;
 b=ZyG7Zcz1an4SGUzs0BMGhX5EEKpLqOu/PRsX6QQjQQWRqikFRJrcNZb9fX7W2MmApv0Ow5
 Y26meOoIwkypfnMvzK0kI7MISFWRphMP/ChpTMEWXwwDlqX0o8G5DwJl9wziZig8MV4CVM
 a/Edw/T9Z/GiThRLHQIKHBNfcvJYAYs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-595-umXe3TpeNa-ejR7ojjsMpA-1; Fri,
 16 Jan 2026 04:43:48 -0500
X-MC-Unique: umXe3TpeNa-ejR7ojjsMpA-1
X-Mimecast-MFC-AGG-ID: umXe3TpeNa-ejR7ojjsMpA_1768556628
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A6E44180044D; Fri, 16 Jan 2026 09:43:47 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.135])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D42EA18007D2; Fri, 16 Jan 2026 09:43:45 +0000 (UTC)
Date: Fri, 16 Jan 2026 09:43:42 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 Alexandr Moshkov <dtalexundeer@yandex-team.ru>
Subject: Re: [PATCH] tests/functional/x86_64: Limit the memlock test to Linux
 hosts
Message-ID: <aWoITn43oMG_WSM9@redhat.com>
References: <20260114095904.35442-1-thuth@redhat.com>
 <aWdpi4ibUm9qNrwa@redhat.com>
 <fdc2093e-8acb-44fb-b280-edf40f5f8883@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fdc2093e-8acb-44fb-b280-edf40f5f8883@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Jan 16, 2026 at 09:09:17AM +0100, Thomas Huth wrote:
> On 14/01/2026 11.01, Daniel P. Berrangé wrote:
> > On Wed, Jan 14, 2026 at 10:59:04AM +0100, Thomas Huth wrote:
> > > From: Thomas Huth <thuth@redhat.com>
> > > 
> > > The memlock test analyzes /proc/*/status files and expects the layout
> > > from Linux in there. However, these files also exist on NetBSD hosts
> > > with a completely different layout, causing this test to fail. Thus
> > > limit the test to Linux hosts now.
> > > 
> > > Signed-off-by: Thomas Huth <thuth@redhat.com>
> > > ---
> > >   tests/functional/x86_64/meson.build | 5 +++--
> > >   1 file changed, 3 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/tests/functional/x86_64/meson.build b/tests/functional/x86_64/meson.build
> > > index f78eec5e6cf..97286d78b8f 100644
> > > --- a/tests/functional/x86_64/meson.build
> > > +++ b/tests/functional/x86_64/meson.build
> > > @@ -9,12 +9,13 @@ test_x86_64_timeouts = {
> > >     'virtio_balloon': 120,
> > >   }
> > > -tests_x86_64_system_quick = [
> > > +tests_x86_64_system_quick = \
> > > +  (host_os == 'linux' ? ['memlock'] : []) + \
> > 
> > IMHO this should be done with a decorator in the test program, so
> > we keep all conditions in the source, not meson.
> 
> If we already know here that the test will only SKIP during runtime, I think
> there is no need to add it to the test plan. Otherwise this will just always
> waste some cycles when running the tests.

One could say the same about many of the things we check in the @skip
decorators. The time saved by doing it in meson is negligible, and
also ensures it is skipped if anyone runs the test program directly
outside meson.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


