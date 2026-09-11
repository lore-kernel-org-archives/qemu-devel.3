Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08E45C88E4D
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 08:29:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4wcy-0003LW-85; Fri, 11 Sep 2026 04:28:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x4wcw-0003Kt-Ly
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 04:28:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x4wcv-0002rl-0t
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 04:28:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789115331;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UA8BrIwzKoxooN7zfRMNnxY5pGttyiiUqNIb6r2sL9Y=;
 b=gmGrra2O+QM3JaKdrurLM9R1oXc2XTRpBiDmT3A7Y7d+rJLVFN2GaLqcZ23zPU0KOW3xcq
 l8YXtL8dPxc+Hah9zCxOucPrjhBRewdFwFV1wODEx02XExz3GKg6BNK+gMC5h/cBc3UwJa
 D07gbYHQSHHg+Oq1xWiczp4PUM5gqmM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-691-K6OMBfWJMpyyjuZ1Sm0Kkw-1; Fri,
 11 Sep 2026 04:28:48 -0400
X-MC-Unique: K6OMBfWJMpyyjuZ1Sm0Kkw-1
X-Mimecast-MFC-AGG-ID: K6OMBfWJMpyyjuZ1Sm0Kkw_1789115327
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6A04C180075A; Fri, 11 Sep 2026 08:28:46 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9F22B30001A2; Fri, 11 Sep 2026 08:28:45 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 549DE21E6A04; Fri, 11 Sep 2026 10:28:43 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Miles Glenn <milesg@linux.ibm.com>
Cc: Simon Ruderich <simon@ruderich.org>,  qemu-devel@nongnu.org,  David Alan
 Gilbert <dgilbert@redhat.com>,  Peter Crosthwaite
 <crosthwaitepeter@gmail.com>,  Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>,  Eric Blake <eblake@redhat.com>,
 Caleb Schlossin <calebs@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v8 0/7] qmp: add pmemload command
In-Reply-To: <7f4620558ac861573fc83d6569189432de77493b.camel@linux.ibm.com>
 (Miles Glenn's message of "Thu, 10 Sep 2026 11:59:28 -0500")
References: <cover.1542290622.git.simon@ruderich.org>
 <7f4620558ac861573fc83d6569189432de77493b.camel@linux.ibm.com>
Date: Fri, 11 Sep 2026 10:28:43 +0200
Message-ID: <87se3g9op0.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Miles Glenn <milesg@linux.ibm.com> writes:

> Hello,
>
> It seems that this patch set stalled several years ago for no apparent
> reason.  Does anybody know why?

Review pointed out issues, but the submitter never responded.  Possibly
because review exhausted submitter's patience.
>
> I find myself needing the functionality of a command like `pmemload`. 
> Our user needs to be able to load a binary file into a physical address
> of their VM and it would need to be done every time they start the VM
> (not just for debug or experimentation). It also needs to be done at
> some point after the VM has already started.  I understand that the gdb
> stub could possibly be used, but we don't want to prevent the user from
> being able to use GDB themselves.  The pmemload command uses QMP, so it
> seems that it would be the perfect solution for us.

You could post a v9 addressing the review, or you could start over.


