Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BEDBCEACCB
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2024 14:29:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svdqF-0008LT-Eh; Tue, 01 Oct 2024 10:27:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1svdp6-0007ZX-Da
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 10:26:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1svdov-0006cn-Cs
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 10:25:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727792740;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=hFAooNKd01/7jy/TVgwpCQpkboRyQ3CLsMqdDCLTRzM=;
 b=gVcUlrH5+15dR03MiVV4x/oJLt4th6Uo7J9TCLuS8AInlGq7ywFJ56EatpQ8tbz+8rCsIh
 V/k80sBztiGezMtCXK/bEPLa9QAjhjXmHM0siW2Upaxj8Ezw+3GuAVM1bhjgYvAbPTPQ+n
 GID6J8jYvtevcyrXV9lpXzhInf5kEYY=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-473-Vu2TZG6SNUG3Yw-gc51xTw-1; Tue,
 01 Oct 2024 10:25:36 -0400
X-MC-Unique: Vu2TZG6SNUG3Yw-gc51xTw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (unknown
 [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EC3601955D4C; Tue,  1 Oct 2024 14:25:33 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.186])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 381F21944AA4; Tue,  1 Oct 2024 14:25:17 +0000 (UTC)
Date: Tue, 1 Oct 2024 15:25:14 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org,
 Prasad Pandit <ppandit@redhat.com>,
 Julia Suvorova <jusual@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Juraj Marcin <jmarcin@redhat.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>
Subject: Re: [PATCH 0/7] migration: query-migrationthreads enhancements and
 cleanups
Message-ID: <ZvwGSgDnW8KfgFEh@redhat.com>
References: <20240930195837.825728-1-peterx@redhat.com>
 <87o744e5pa.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87o744e5pa.fsf@pond.sub.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Oct 01, 2024 at 07:46:09AM +0200, Markus Armbruster wrote:
> Command query-migrationthreads went in without a QAPI ACK.  Issues
> review should have caught:
> 
> * Flawed documentation.  Fixed in commit e6c60bf02d1.
> 
> * It should have been spelled query-migration-threads.  Not worth fixing
>   now, I guess.
> 
> * What are the use cases?  The commit message doesn't tell!  If it's
>   just for debugging, the command should be marked unstable.

It is hard to use too.

Lets say a mgmt app wants to restrict migration threads to some
certain pCPUs. It can't call query-migrationthreads beforehand
as the threads don't exist until migration is started. If it
calls after migration is started, then there's a window where
threads are running on arbitrary pCPUs that QEMU has access
to. There's no synchronization point where threads have been
created & can be queried, but are not yet sending data (and
thus burning CPU time)


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


