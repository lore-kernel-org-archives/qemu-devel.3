Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD87DC4828D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 19:47:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXnrq-0002wD-2g; Wed, 07 Feb 2024 14:45:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1rXnrk-0002vR-Cd
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 14:45:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1rXnrh-0008Rl-5Z
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 14:45:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707335146;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7xY362Hv+CgTCHCGpYBWynKVAJZjQvyW0YFLaLMgKdQ=;
 b=QJFA0AVsZ3gYIgBBNrXu3SuJ6eZ8E5SbAQx4AOJBE0p9qghU160XJArczbkqmbUze+0gOY
 aWKEl7S1XQtP4JW6HbZ3wAzTAAAIw03a5yDQwy4UoGWgn/5sH1IFkxlu7DBJwyMyKcGr6l
 e/MYoZkFBhT2USuDPgg/KSOUFU9R434=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-lu3ZsW0LO3qZZr0pXgOSrw-1; Wed, 07 Feb 2024 14:45:42 -0500
X-MC-Unique: lu3ZsW0LO3qZZr0pXgOSrw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 63D3785CBA5;
 Wed,  7 Feb 2024 19:45:42 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3962B2166B31;
 Wed,  7 Feb 2024 19:45:41 +0000 (UTC)
Date: Wed, 7 Feb 2024 13:45:39 -0600
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, 
 pbonzini@redhat.com, devel@lists.libvirt.org
Subject: Re: [PATCH 2/4] tests/unit/test-char: Fix qemu_socket(),
 make_udp_socket() check
Message-ID: <xtjhv5rzpzzdebjwnefbin44ubygp35yqlyuoo3v6tw77qyhgq@dbw2rzuxulga>
References: <20240203080228.2766159-1-armbru@redhat.com>
 <20240203080228.2766159-3-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240203080228.2766159-3-armbru@redhat.com>
User-Agent: NeoMutt/20231221
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.106,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Sat, Feb 03, 2024 at 09:02:26AM +0100, Markus Armbruster wrote:
> qemu_socket() and make_udp_socket() return a file descriptor on
> success, -1 on failure.  The check misinterprets 0 as failure.  Fix
> that.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  tests/unit/test-char.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

Might be worth amending the commit message of 1/4 where you called out
this bug to mention it will be fixed in the next patch.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


