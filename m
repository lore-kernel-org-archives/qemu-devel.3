Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D51E3FA1FC5
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 16:31:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFaT9-00057v-UX; Wed, 22 Apr 2026 12:30:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mtosatti@redhat.com>)
 id 1wFaT5-00057I-Fl
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 12:30:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mtosatti@redhat.com>)
 id 1wFaT3-0003Kx-Sh
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 12:30:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776875422;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BjmfO0yef6kA1xNy1Y3HMovxD+y48D5FJPyYtPucIfg=;
 b=WAESOtahv7B+r3BOxBN/inR3QdT1ZJZ5w2ltmXYbWmMEXSecRCPJsSyv0pxola+nd/fSOH
 Tc9wPNcLH45v2VaYUTWKeAdEp11tq3VSvB3EHdL5eobF5PdzKhnm3cMT5x9/+8ToZ89rmn
 /1cq31CTEU44Yat2VxqWeGVa4TMMESw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-220-qIeuUwPcM7GshO1j2F47Cg-1; Wed,
 22 Apr 2026 12:30:19 -0400
X-MC-Unique: qIeuUwPcM7GshO1j2F47Cg-1
X-Mimecast-MFC-AGG-ID: qIeuUwPcM7GshO1j2F47Cg_1776875418
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EE07319560B3; Wed, 22 Apr 2026 16:30:17 +0000 (UTC)
Received: from tpad.localdomain (unknown [10.96.133.3])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 801A9180045E; Wed, 22 Apr 2026 16:30:17 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
 id 35F92400DFC8C; Mon, 20 Apr 2026 12:01:02 -0300 (-03)
Date: Mon, 20 Apr 2026 12:01:02 -0300
From: Marcelo Tosatti <mtosatti@redhat.com>
To: Florian Schmidt <flosch@nutanix.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 qemu-devel@nongnu.org
Subject: Re: [RFC PATCH 2/2] Add HvExtCallGetBootZeroedMemory
Message-ID: <aeY/rmwBQp5F/wPf@tpad>
References: <20260112113139.3762156-1-flosch@nutanix.com>
 <20260112113139.3762156-3-flosch@nutanix.com>
 <a28bd807-6e98-4393-a354-b7ed1f7a08ae@redhat.com>
 <aeHKfOmm2b7cY70i@tpad>
 <80e6ecc4-eac6-40ee-aaf8-da60daaf96d4@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80e6ecc4-eac6-40ee-aaf8-da60daaf96d4@nutanix.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mtosatti@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

On Mon, Apr 20, 2026 at 10:25:43AM +0100, Florian Schmidt wrote:
> Hi Marcelo,
> 
> On 2026-04-17 06:51, Marcelo Tosatti wrote:
> > Is this to improve boot time of very large guests ?
> 
> It depends a bit on how you define "boot time". It won't make a difference
> if you measure the time it takes to create the VM until you start the vCPUs.
> It may even make a huge difference if you measure the time until a user can
> first log in.
> 
> What it will do is reduce the time the guest spends on writing memory,
> mostly in the background, to zero out all pages it has gotten from the
> hypervisor. The main advantage (other than saving CPU cycles that are
> effectively wasted on an unneeded operation) is that if you don't
> pre-allocate all the VMs memory, then the VM won't touch all pages after
> boot, keeping the RSS down until the memory is actually used. That's for
> example useful if you overcommit/oversubscribe VM memory.
> 
> Cheers,
> Florian

Hi Florian,

That is useful!


