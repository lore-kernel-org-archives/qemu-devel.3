Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20F82D3B7EA
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 06:02:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSqmy-0007Ec-5N; Tue, 09 Dec 2025 01:01:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vSqmw-0007EK-Nn
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 01:01:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vSqmu-0003lQ-JA
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 01:01:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765260087;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3Y4ssyz4xJjGs4zILO4jNmV1gyYhA9KuYufib5ok8Eg=;
 b=QKj/Adk4X4bvIkHKo1vg9ptD7/l/6Chl0xs0MsiBPRh+RBKl7tqC1098gfk/uYPkrvsYNn
 jOSnntf3c0/k4n0Ixx+OQtTWmBZ+nkhjcIoO7guI+Svi39hyWEcNtyZIQZyMHmrWX+y9As
 9DnLlPud8TF3n6hVG2a8XRBYBMUPxRI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-82-2XSxsWpUPXa63Kuo0Woecw-1; Tue,
 09 Dec 2025 01:01:23 -0500
X-MC-Unique: 2XSxsWpUPXa63Kuo0Woecw-1
X-Mimecast-MFC-AGG-ID: 2XSxsWpUPXa63Kuo0Woecw_1765260082
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 48BEE1956058; Tue,  9 Dec 2025 06:01:22 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.7])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CC257180044F; Tue,  9 Dec 2025 06:01:21 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3388421E6A27; Tue, 09 Dec 2025 07:01:19 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, qemu-rust@nongnu.org
Subject: Re: [PATCH 00/19] rust: QObject and QAPI bindings
In-Reply-To: <87tsy52ftl.fsf@pond.sub.org> (Markus Armbruster's message of
 "Fri, 05 Dec 2025 14:55:50 +0100")
References: <20251010151006.791038-1-pbonzini@redhat.com>
 <87tsy52ftl.fsf@pond.sub.org>
Date: Tue, 09 Dec 2025 07:01:19 +0100
Message-ID: <87zf7s5h3k.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Markus Armbruster <armbru@redhat.com> writes:

> I applied, ran make, and it didn't create qapi-types.rs and
> test-qapi-types.rs for me.  What am I missing?

Looks like I have to run with -B qapi.backend.QAPIRsBackend.

-B is meant for out-of-tree backends.  Commit dde279925c9 explains:

    qapi: pluggable backend code generators
    
    The 'qapi.backend.QAPIBackend' class defines an API contract for code
    generators. The current generator is put into a new class
    'qapi.backend.QAPICBackend' and made to be the default impl.
    
    A custom generator can be requested using the '-k' arg which takes a
    fully qualified python class name
    
       qapi-gen.py -B the.python.module.QAPIMyBackend
    
    This allows out of tree code to use the QAPI generator infrastructure
    to create new language bindings for QAPI schemas. This has the caveat
    that the QAPI generator APIs are not guaranteed stable, so consumers
    of this feature may have to update their code to be compatible with
    future QEMU releases.

Using it for the in-tree Rust backend is fine for a prototype.
Mentioning it in a commit message or the cover letter would've saved me
some digging.


