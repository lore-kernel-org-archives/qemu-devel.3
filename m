Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B43B9C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2024 16:58:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxV4p-0001dt-C8; Thu, 18 Apr 2024 12:57:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rxV4m-0001dL-BA
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 12:57:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rxV4j-0006Zp-LH
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 12:57:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713459448;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c1Lujg0s7gu/f+rfaoraX1BIlKRV3KzkNXAPSpKPQIo=;
 b=iNUvkClwkkPyjKd3t3Q2uS0dsKfsqUe/MNBtMpYVPjm49IwlQDlCxUGlI1rVTJMB0M0ofK
 IoX35eLUzsRRjoZnnN878AqCIfEZn+gBOWoRklBPemTlviAabs0sILeXWhkVvDgz3YCFnc
 yFB4F3SaQSgOQeeTEKYY8MliNz/i9pI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-84-Pq9H1czXM4q6uymnk_QGHA-1; Thu,
 18 Apr 2024 12:57:23 -0400
X-MC-Unique: Pq9H1czXM4q6uymnk_QGHA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7A1CB383CD62;
 Thu, 18 Apr 2024 16:57:23 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.72])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 45EDF492BC7;
 Thu, 18 Apr 2024 16:57:21 +0000 (UTC)
Date: Thu, 18 Apr 2024 17:57:20 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 farosas@suse.de, yc-core@yandex-team.ru, thuth@redhat.com,
 lvivier@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org,
 pkrempa@redhat.com
Subject: Re: [PATCH] migration: do not exit on incoming failure
Message-ID: <ZiFQ8Fb-nXbxqBiA@redhat.com>
References: <20240417221329.248803-1-vsementsov@yandex-team.ru>
 <ZiEwF0rWlLaKMzqw@redhat.com>
 <0a1d8984-bc01-41bf-9099-0ef426e848ca@yandex-team.ru>
 <ZiE_n7qwvRCz3vjE@redhat.com>
 <985d47bb-3c14-4576-95fa-28649710686b@yandex-team.ru>
 <ZiFNvgf0sDwC1Zkv@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZiFNvgf0sDwC1Zkv@x1n>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.067,
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

On Thu, Apr 18, 2024 at 12:43:42PM -0400, Peter Xu wrote:
> On Thu, Apr 18, 2024 at 06:47:31PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> > On 18.04.24 18:43, Daniel P. Berrangé wrote:
> > > On Thu, Apr 18, 2024 at 06:40:38PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> > > > On 18.04.24 17:37, Daniel P. Berrangé wrote:
> > > > > On Thu, Apr 18, 2024 at 01:13:29AM +0300, Vladimir Sementsov-Ogievskiy wrote:
> > > > > > We do set MIGRATION_FAILED state, but don't give a chance to
> > > > > > orchestrator to query migration state and get the error.
> > > > > > 
> > > > > > Let's report an error through QAPI like we do on outgoing migration.
> > > > > > 
> > > > > > migration-test is updated correspondingly.
> > > > > > 
> > > > > > Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> > > > > > ---
> > > > > > 
> > > > > > Doubt: is exiting on failure a contract? Will this commit break
> > > > > > something in Libvirt? Finally, could we just change the logic, or I need
> > > > > > and additional migration-parameter for new behavior?
> > > > > 
> > > > > There's a decent risk that this could break apps, whether
> > > > > libvirt or something else, especially if the app is just
> > > > > launching QEMU with '-incoming URI', rather than using
> > > > > '-incoming defer' and then explicitly using QMP to start the
> > > > > incoming migration.
> > > > > 
> > > > > I'd say that with '-incoming defer' we should *not* exit on
> > > > > migration error, because that arg implies the app explicitly
> > > > > wants to be using QMP to control migration.
> > > > > 
> > > > > With the legacy '-incoming URI' it is probably best to keep
> > > > > exit on error, as that's comparatively more likely to be used
> > > > > in adhoc scenarios where the app/user is ignoring QMP on the
> > > > > dst side.
> > > > > 
> > > > > None the less, I think we need to check how libvirt behaves
> > > > > with this patch to be sure of no surprises.
> > > > > 
> > > > 
> > > > Sounds reasonable, thanks! I'll rework it to behave the new
> > > > way only with "-incoming defer", and check how libvirt behave with it.
> > > 
> > > If there are problems and/or we want to be super safe wrt
> > > backcompat, we could add a new  '-incoming managed' as
> > > being equivalent to '-incoming defer' but without the
> > > implicit exit.
> > > 
> > 
> > Probably, that's the best variant. As I can check libvirt in some case, but not at all cases. And libvirt is not the only vm manager finally.
> > And we can in the same time deprecate "-incoming defer" in favor of new behavior.
> 
> Or just make it a new migration parameter?  Then we keep all existing
> interfaces untouched, no risk of breaking anyone, and then it'll also apply
> to anyone who uses things like -incoming tcp but still wants to keep the
> qemu instance alive?

True, or even more simply, an argument to the 'migrate-incoming' command

diff --git a/qapi/migration.json b/qapi/migration.json
index 8c65b90328..6882aef328 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -1889,7 +1889,8 @@
 ##
 { 'command': 'migrate-incoming',
              'data': {'*uri': 'str',
-                      '*channels': [ 'MigrationChannel' ] } }
+                      '*channels': [ 'MigrationChannel' ],
+                      '*exit-on-error': 'bool' } }
 
 ##
 # @xen-save-devices-state:


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


