Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FE37D5CC81
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2024 09:49:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t65JV-0000in-UV; Wed, 30 Oct 2024 05:48:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t65JS-0000iY-6A
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 05:48:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t65JP-0000Rn-B8
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 05:48:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730281701;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=Tha8CDyFd1x96GP4gGVVmzqGxWb4OQmrL7UvKrCv+a4=;
 b=c80IYu2U29IlCXKAxpPY+ighEwg8W/ECaZXeOvLMaqf4DACZSxMLYl3WOfioXHzkllC2k/
 4PROnYRfhAWkVY/ymgKXjNC9G44li/lgm9jteYoSNfiLjUf0Up2NDjIOugIQCm1SICUFqU
 48m5G4TeRwSgtXzaEM+qlvkYGstxXHk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-107-GoC_R13bOr2KVt-Ll5f1Zw-1; Wed,
 30 Oct 2024 05:48:18 -0400
X-MC-Unique: GoC_R13bOr2KVt-Ll5f1Zw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 82D381955F45; Wed, 30 Oct 2024 09:48:16 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.92])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1DAEB195605F; Wed, 30 Oct 2024 09:48:10 +0000 (UTC)
Date: Wed, 30 Oct 2024 09:48:07 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Igor Mammedov <imammedo@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH RFC v2 0/7] QOM: Singleton interface
Message-ID: <ZyIA1zruTAxHfGcn@redhat.com>
References: <20241029211607.2114845-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241029211607.2114845-1-peterx@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.302,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Tue, Oct 29, 2024 at 05:16:00PM -0400, Peter Xu wrote:
> v1: https://lore.kernel.org/r/20241024165627.1372621-1-peterx@redhat.com

> Meanwhile, migration has a long standing issue on current_migration
> pointer, where it can point to freed data after the migration object is
> finalized.  It is debatable that the pointer can be cleared after the main
> thread (1) join() the migration thread first, then (2) release the last
> refcount for the migration object and clear the pointer.  However there's
> still major challenges [1].  With singleton, we could have a slightly but
> hopefully working workaround to clear the pointer during finalize().

I'm still not entirely convinced that this singleton proposal is
fixing the migration problem correctly.

Based on discussions in v1, IIUC, the situation is that we have
migration_shutdown() being called from qemu_cleanup(). The former
will call object_unref(current_migration), but there may still
be background migration threads running that access 'current_migration',
and thus a potential use-after-free.

Based on what the 7th patch here does, the key difference is that
the finalize() method for MigrationState will set 'current_migration'
to NULL after free'ing it.

I don't believe that is safe.

Back to the current code, if there is a use-after-free today, that
implies that the background threads are *not* holding their own
reference on 'current_migration', allowing the object to be free'd
while they're still using it. If they held their own reference then
the object_unref in migration_shutdown would not have any use after
free risk.

The new code is not changing the ref counting done by any threads.
Therefore if there's a use-after-free in existing code, AFAICT, the
same use-after-free *must* still exist in the current code.

The 7th patch only fixes the use-after-free, *if and only if* the
background thread tries to access 'current_migration', /after/
finalize as completed. The use-after-free in this case, has been
turned into a NULL pointer reference.

A background thread could be accessing the 'current_migration' pointer
*concurrently* with the finalize method executing though. In this case
we still have a use after free problem, only the time window in which
it exists has been narrowed a little.

Shouldn't the problem with migration be solved by every migration thread
holding a reference on current_migration, that the thread releases when
it exits, such that MigrationState is only finalized once every thread
has exited ? That would not require any join() synchronization point.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


