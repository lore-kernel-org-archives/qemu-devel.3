Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBBD9D729E8
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2024 15:18:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tH2kI-00067r-91; Fri, 29 Nov 2024 10:17:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tH2kG-00067S-1V
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 10:17:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tH2kE-00072H-2F
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 10:17:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732893440;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hCQR5EsafkVoaNMH+bwyjcgM639HWAPYST/OTLF5y5U=;
 b=CiQnCg+XKhLGysog6WqKyeZmtFAB4HlCUAsCXqpIfWE/GApsrWjPBjfShAXnYHXP77oB10
 isIG8dAJ8o0LaETSWsWcQJ5FrGnx6fGCMMTLp8YyAtIJeysXRDXd6S3o96UvJmV3HkCazT
 CwiokM254W5xUfOpDPolbCXnyam4mKo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-3-VVMyWZDtPU-F5d8FbnejRA-1; Fri,
 29 Nov 2024 10:17:18 -0500
X-MC-Unique: VVMyWZDtPU-F5d8FbnejRA-1
X-Mimecast-MFC-AGG-ID: VVMyWZDtPU-F5d8FbnejRA
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8664D1955DB5
 for <qemu-devel@nongnu.org>; Fri, 29 Nov 2024 15:17:17 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.37])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9F32A195605A; Fri, 29 Nov 2024 15:17:14 +0000 (UTC)
Date: Fri, 29 Nov 2024 15:17:10 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?B?Sm/Do28gVmlsYcOnYQ==?= <jvilaca@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: How to query the number of processes queueing for the CPU inside
 the VM
Message-ID: <Z0na9lvoTM2V4iFY@redhat.com>
References: <CAOw09wu31aROKJaYA7igHR_toegozssDXsTBNuUhusoRX+Yvng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOw09wu31aROKJaYA7igHR_toegozssDXsTBNuUhusoRX+Yvng@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.93,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Fri, Nov 29, 2024 at 02:38:52PM +0000, João Vilaça wrote:
> In KubeVirt, through libvirt, we need to know the number of processes
> queued for the CPU inside the VM.
> 
> Can we get this information through the qemu-guest-agent?

The only CPU stats related command in QGA is 'guest-get-cpustat's
returning:

# @user: Time spent in user mode
#
# @nice: Time spent in user mode with low priority (nice)
#
# @system: Time spent in system mode
#
# @idle: Time spent in the idle task
#
# @iowait: Time waiting for I/O to complete (since Linux 2.5.41)
#
# @irq: Time servicing interrupts (since Linux 2.6.0-test4)
#
# @softirq: Time servicing softirqs (since Linux 2.6.0-test4)
#
# @steal: Stolen time by host (since Linux 2.6.11)
#
# @guest: ime spent running a virtual CPU for guest operating systems
#     under the  control of the Linux kernel (since Linux 2.6.24)
#
# @guestnice: Time spent running a niced guest (since Linux 2.6.33)

none of which match your rquest

Essentially what you're asking for seems to be the "load average" which
is a measure of waiting runnable tasks, over some period (1, 5, 15 minutes
typically).

I imagine guest-get-cpustat could be enhanced to include load info without
too much work.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


