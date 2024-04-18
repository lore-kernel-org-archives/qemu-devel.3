Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 506C7C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2024 13:57:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxSGh-00052v-Kj; Thu, 18 Apr 2024 09:57:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rxSGg-00052d-1O
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 09:57:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rxSGd-0005ex-ES
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 09:57:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713448654;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X63vAHuOYtBv6KJgkpOpLHzW1WmO5uoDLUFKoFZ4WIA=;
 b=gUjpzARO2YoqkxzKxoegZNMZM5qBbRQHhNzVcAZUMoGrrFW1HfMkasLSxKMY5EhvLsZsOk
 5OSMz0jXjFKNUpJ0tdyGaDemUVwrvnupbVGvgJHPMq/9vB/P+3Guo2lGquaAM1UUWpGrX+
 cYZv288UYXCOAwwC4KRiE2O5hgYNnnk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-491-6uj3DSdqPKWH-sPsy8E-dg-1; Thu,
 18 Apr 2024 09:57:32 -0400
X-MC-Unique: 6uj3DSdqPKWH-sPsy8E-dg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6FBC31C0AF4B;
 Thu, 18 Apr 2024 13:57:32 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.72])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8C93B112132A;
 Thu, 18 Apr 2024 13:57:31 +0000 (UTC)
Date: Thu, 18 Apr 2024 14:57:29 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?B?0KLQuNC80YPRgA==?= <masscry@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 0/2] Fix pointer arithmetic in indirect read for
 libvhost-user and libvduse
Message-ID: <ZiEmyYlUAIhypob7@redhat.com>
References: <20240113012741.54664-1-masscry@gmail.com>
 <CABH+J_76pW0-XQVUsJ+7faK-gCVaoa7DScDcdHmcZxdc25GC5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABH+J_76pW0-XQVUsJ+7faK-gCVaoa7DScDcdHmcZxdc25GC5g@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
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

Adding Michael back to the CC, since he's the designated
maintainer for libvhost-user/

Michael, could you give these patches a review since
they've been pending for many months now.

On Sun, Feb 04, 2024 at 12:41:31PM +0300, Тимур wrote:
> Hello, I am very sorry for bothering community on a such minor problem
> again, but I got no response for a few weeks, so maybe I have started
> thread on a wrong mailing list, so I made an issue in gitlab issue tracker:
> https://gitlab.com/qemu-project/qemu/-/issues/2149 referencing this thread.
> 
> Maybe, it would help attract proper eyes to such a simple problem, so no
> one bothers in trying to fix it, albeit it lives in the codebase for some
> time already and is being copied around.
> 
> Sincerely,
> Temir.
> 
> сб, 13 янв. 2024 г. в 04:28, Temir Zharaspayev <masscry@gmail.com>:
> 
> > Hello! I have found a problem with virtqueue_read_indirect_desc function,
> > which
> > was advancing pointer to struct as it was a byte pointer, so every element
> > comming after first chunk would be copied somewhere out of buffer.
> >
> > As I understand this is cold path, but nevertheless worth fixing.
> >
> > Also, exacly same problem in vduse_queue_read_indirect_desc function,
> > because
> > as I understand it is a copy of virtqueue_read_indirect_desc with vduse
> > backend.
> >
> > I was not sure if element of scattered buffer may end in the middle of
> > vring_desc struct data, so instead of writing
> > desc += read_len/sizeof(struct vring_desc)
> > have implemented fix with proper byte pointer arithmetic.
> >
> > Sincerely,
> > Temir.
> >
> > Temir Zharaspayev (2):
> >   libvhost-user: Fix pointer arithmetic in indirect read
> >   libvduse: Fix pointer arithmetic in indirect read
> >
> >  subprojects/libvduse/libvduse.c           | 11 ++++++-----
> >  subprojects/libvhost-user/libvhost-user.c | 11 ++++++-----
> >  2 files changed, 12 insertions(+), 10 deletions(-)
> >
> > --
> > 2.34.1
> >
> >

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


