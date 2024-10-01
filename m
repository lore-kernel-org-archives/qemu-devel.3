Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99986CEACCB
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2024 14:15:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svdeC-0003PU-Eb; Tue, 01 Oct 2024 10:14:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1svdde-0001vI-Al
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 10:14:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1svddc-0003eO-T9
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 10:14:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727792043;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Eg/44RY4Un3g7HsiR04QOslj35pWulf+XNx+KulBrV0=;
 b=XUw1WcQvJwchFfa6R6iRezVqhHUCDElVjINGx88zBKN4QBNWhXWA1nISgVpgVq7jkrk+tS
 UjfeHGUamj7jfJt/NDbx/h6sRqAK1YGoDUHvq84t61wJMJsBwO5JjQ4UdiC2Nn9kaMJ916
 53zTgJPNuMZQFwFvwWNAURU5dN6b8e0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-286-zBNjPCwQPEG6CXQVw6o9MA-1; Tue,
 01 Oct 2024 01:46:15 -0400
X-MC-Unique: zBNjPCwQPEG6CXQVw6o9MA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (unknown
 [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9A006196FAFD; Tue,  1 Oct 2024 05:46:14 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.47])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 126273003DEC; Tue,  1 Oct 2024 05:46:13 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A86A621E6A28; Tue,  1 Oct 2024 07:46:09 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org,  Prasad Pandit <ppandit@redhat.com>,  Julia
 Suvorova <jusual@redhat.com>,  Fabiano Rosas <farosas@suse.de>,  Juraj
 Marcin <jmarcin@redhat.com>,  "Dr . David Alan Gilbert" <dave@treblig.org>
Subject: Re: [PATCH 0/7] migration: query-migrationthreads enhancements and
 cleanups
In-Reply-To: <20240930195837.825728-1-peterx@redhat.com> (Peter Xu's message
 of "Mon, 30 Sep 2024 15:58:30 -0400")
References: <20240930195837.825728-1-peterx@redhat.com>
Date: Tue, 01 Oct 2024 07:46:09 +0200
Message-ID: <87o744e5pa.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Command query-migrationthreads went in without a QAPI ACK.  Issues
review should have caught:

* Flawed documentation.  Fixed in commit e6c60bf02d1.

* It should have been spelled query-migration-threads.  Not worth fixing
  now, I guess.

* What are the use cases?  The commit message doesn't tell!  If it's
  just for debugging, the command should be marked unstable.


