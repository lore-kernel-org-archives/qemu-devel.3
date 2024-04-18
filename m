Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C192C04FFE
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2024 15:44:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxTvJ-0005wU-BB; Thu, 18 Apr 2024 11:43:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rxTvH-0005vd-KY
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 11:43:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rxTvE-0001BT-Sk
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 11:43:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713455016;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6wF57Na8KP12SJ8r7qxg+aDEgUr4iFUQCEQLjjJSbSs=;
 b=PC9UeRla0JfxXmHvkP3DtN+9yfDBJ+tKk7XQ6JuphoGUkHh/ty15zHZxgcKQRRw5n/PlNj
 5dqsMq7MmaoTsFpBipy9nwZII2CgysQwJTThFEPZ/YUPR+kLkkBQ62x+uUNXm1v4uzQN39
 E383uvEmoBVu6oGlbhJ0FIDcbHwIQKk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-657-Q10jWELUN-OxzJ5qX0pO7Q-1; Thu,
 18 Apr 2024 11:43:32 -0400
X-MC-Unique: Q10jWELUN-OxzJ5qX0pO7Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1A16F1C07F3B;
 Thu, 18 Apr 2024 15:43:31 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.72])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C262940357A7;
 Thu, 18 Apr 2024 15:43:29 +0000 (UTC)
Date: Thu, 18 Apr 2024 16:43:27 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: peterx@redhat.com, farosas@suse.de, yc-core@yandex-team.ru,
 thuth@redhat.com, lvivier@redhat.com, pbonzini@redhat.com,
 qemu-devel@nongnu.org, pkrempa@redhat.com
Subject: Re: [PATCH] migration: do not exit on incoming failure
Message-ID: <ZiE_n7qwvRCz3vjE@redhat.com>
References: <20240417221329.248803-1-vsementsov@yandex-team.ru>
 <ZiEwF0rWlLaKMzqw@redhat.com>
 <0a1d8984-bc01-41bf-9099-0ef426e848ca@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0a1d8984-bc01-41bf-9099-0ef426e848ca@yandex-team.ru>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
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

On Thu, Apr 18, 2024 at 06:40:38PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> On 18.04.24 17:37, Daniel P. Berrangé wrote:
> > On Thu, Apr 18, 2024 at 01:13:29AM +0300, Vladimir Sementsov-Ogievskiy wrote:
> > > We do set MIGRATION_FAILED state, but don't give a chance to
> > > orchestrator to query migration state and get the error.
> > > 
> > > Let's report an error through QAPI like we do on outgoing migration.
> > > 
> > > migration-test is updated correspondingly.
> > > 
> > > Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> > > ---
> > > 
> > > Doubt: is exiting on failure a contract? Will this commit break
> > > something in Libvirt? Finally, could we just change the logic, or I need
> > > and additional migration-parameter for new behavior?
> > 
> > There's a decent risk that this could break apps, whether
> > libvirt or something else, especially if the app is just
> > launching QEMU with '-incoming URI', rather than using
> > '-incoming defer' and then explicitly using QMP to start the
> > incoming migration.
> > 
> > I'd say that with '-incoming defer' we should *not* exit on
> > migration error, because that arg implies the app explicitly
> > wants to be using QMP to control migration.
> > 
> > With the legacy '-incoming URI' it is probably best to keep
> > exit on error, as that's comparatively more likely to be used
> > in adhoc scenarios where the app/user is ignoring QMP on the
> > dst side.
> > 
> > None the less, I think we need to check how libvirt behaves
> > with this patch to be sure of no surprises.
> > 
> 
> Sounds reasonable, thanks! I'll rework it to behave the new
> way only with "-incoming defer", and check how libvirt behave with it.

If there are problems and/or we want to be super safe wrt
backcompat, we could add a new  '-incoming managed' as
being equivalent to '-incoming defer' but without the
implicit exit.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


