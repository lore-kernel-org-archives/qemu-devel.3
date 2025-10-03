Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 541C5CCA471
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 14:14:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4gW0-0002PZ-Jh; Fri, 03 Oct 2025 10:12:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rjones@redhat.com>) id 1v4gVx-0002PE-8Q
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 10:12:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rjones@redhat.com>) id 1v4gVn-00070X-Nz
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 10:12:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759500707;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=K62cKgdNyh2apcWAxppHeuCfsU5yOQJtivRLEbjZ0Cs=;
 b=RLDFBeIjxOyWWZCszP6xzxhA8PSwm3siH/pI3OgqhJNzEnOICJCEn3W0biQldX9LAY2GYj
 V08tIS6/wHsJGzrprtK6A5gsM1/R0HM+sUCZpMlFqbmBlAbfnVLYSMrzH9j9a8+caLqXsM
 Gv9BmOjUvamgE3kNPu4AZh78Qp2xGH4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-624-BQGKTj_kOOSRDem6KOgA5Q-1; Fri,
 03 Oct 2025 10:11:46 -0400
X-MC-Unique: BQGKTj_kOOSRDem6KOgA5Q-1
X-Mimecast-MFC-AGG-ID: BQGKTj_kOOSRDem6KOgA5Q_1759500705
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 569AE180028C
 for <qemu-devel@nongnu.org>; Fri,  3 Oct 2025 14:11:45 +0000 (UTC)
Received: from localhost (unknown [10.45.224.22])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C023319560B1; Fri,  3 Oct 2025 14:11:44 +0000 (UTC)
Date: Fri, 3 Oct 2025 15:11:43 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, berrange@redhat.com
Subject: Re: [PATCH v1 0/2] Implement -run-with exit-with-parent=on
Message-ID: <20251003141143.GA5720@redhat.com>
References: <20251003133158.3978333-1-rjones@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251003133158.3978333-1-rjones@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=rjones@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.467,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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


On Fri, Oct 03, 2025 at 02:24:36PM +0100, Richard W.M. Jones wrote:
> An earlier WIP version was posted here:
> https://lists.gnu.org/archive/html/qemu-devel/2025-10/msg00309.html
> 
> In this version I have incorporated all of Daniel Berrange's feedback,
> and I also tested the change on macOS.
> 
> The new second patch modifies the test suite to use the new flag
> unconditionally, instead of open coding setting PR_SET_PDEATHSIG etc.
> The test suite fails for me both before and after this patch in the
> same way, so I assume this is nothing to do with the patch itself?
> 
>   4/405 qemu:func-quick+func-x86_64 / func-x86_64-bad_vmstate               ERROR            0.15s   exit status 1
> 
> Some points of note:
> 
>  - There's no way to find out if the qemu binary supports
>    exit-with-parent=on except to try it.  Maybe this should be exposed
>    somehow?

.. or exit-with-parent=best, but then it would no longer be a straight
boolean option.

>  - On macOS I wasn't able to find a satisfactory way to force
>    shutdown, except calling 'qemu_system_killed' and pretending we'd
>    been killed by SIGTERM (which does at least emulate what Linux &
>    FreeBSD do).  I suppose it'd be nice if there was a "killed by
>    parent" reason which also forced shutdown.
> 
> Rich.
> 

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
libguestfs lets you edit virtual machines.  Supports shell scripting,
bindings from many languages.  http://libguestfs.org


