Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FCD6CCD185
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 19:16:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v96xs-0005Zv-Su; Wed, 15 Oct 2025 15:15:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1v96xn-0005UU-TQ
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 15:15:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1v96xW-0007ZN-7M
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 15:15:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760555679;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lbuuEEPcdoRIc930ynkF/7m1eHk03LzfruHz6w8UsQ8=;
 b=K39QftageEh5XmpgAXEFF3lLnEMojXMGJmdtNzdckWhwCaRqwgouyQt5YjSPsnHz2bFutK
 0zLwCCK+BVyw99ImEJimNsfXLdhAoZiuqSJ0mNmyIB1GS/MTGmtYk51oVW1L9CTgUK+kH8
 w25fkQjCP+I+Gt3LTtU+Ylbxj6GyYDU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-206-ZmBEtrg5OJKSQXidb9VIaA-1; Wed,
 15 Oct 2025 15:14:35 -0400
X-MC-Unique: ZmBEtrg5OJKSQXidb9VIaA-1
X-Mimecast-MFC-AGG-ID: ZmBEtrg5OJKSQXidb9VIaA_1760555674
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 748291956089; Wed, 15 Oct 2025 19:14:34 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.144])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 62C0930001A5; Wed, 15 Oct 2025 19:14:32 +0000 (UTC)
Date: Wed, 15 Oct 2025 14:14:29 -0500
From: Eric Blake <eblake@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Praveen K Paladugu <prapal@microsoft.com>, 
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Markus Armbruster <armbru@redhat.com>, 
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>
Subject: Re: [PATCH 2/2] monitor: generalize query-mshv/"info mshv" to
 query-accelerators/"info accelerators"
Message-ID: <ljdotqp75e4elztgub7pdvwx757jg5tis3hil4hh3jluevbgkg@3qzbycse3cng>
References: <20251013112650.935921-1-pbonzini@redhat.com>
 <20251013112650.935921-3-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251013112650.935921-3-pbonzini@redhat.com>
User-Agent: NeoMutt/20250905
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Mon, Oct 13, 2025 at 01:26:50PM +0200, Paolo Bonzini wrote:
> The recently-introduced query-mshv command is a duplicate of query-kvm,
> and neither provides a full view of which accelerators are supported
> by a particular binary of QEMU and which is in use.
> 
> KVM was the first accelerator added to QEMU, predating QOM and TYPE_ACCEL,
> so it got a pass.  But now, instead of adding a badly designed copy, solve
> the problem completely for all accelerators with a command that provides
> the whole picture:
> 
>     >> {"execute": "query-accelerators"}
>     << {"return": {"enabled": "tcg", "present": ["kvm", "mshv", "qtest", "tcg", "xen"]}}
> 
> Cc: Praveen K Paladugu <prapal@microsoft.com>
> Cc: Magnus Kulke <magnuskulke@linux.microsoft.com>
> Suggested-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> 
>  fixup a0df118f73f # fff

Is this note stale?

> ---
>  qapi/accelerator.json      | 47 +++++++++++++++++++++++++++++---------
>  include/monitor/hmp.h      |  2 +-
>  hw/core/machine-hmp-cmds.c | 21 +++++++++--------
>  hw/core/machine-qmp-cmds.c | 20 ++++++++++++----
>  hmp-commands-info.hx       | 15 ++++++++----
>  5 files changed, 74 insertions(+), 31 deletions(-)
>

Otherwise,
Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


