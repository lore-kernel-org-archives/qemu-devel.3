Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82EA4D35162
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 11:59:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7uDf-0001YC-FX; Wed, 01 Apr 2026 07:58:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1w7uDd-0001Un-LI
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 07:58:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1w7uDb-0001ni-Kb
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 07:58:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775044722;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FMbgkMiGMeafnQuu2iitX0/zDKm/GCOqNzo1XRKbK+I=;
 b=RXEwt7qq5Tttn29bjW3w4n6HORBeLkS1Y6anPIAUi7qGtmrOa+VSMEge5R6tDVWg7U5LJ2
 9Cr2PUAV6nJP/NPnd3bngYoDHkh+dPfkiMyaN2yNqB8FfwZhBNryPnikRdbcZ3aE5N7D7c
 sBWAaPBgvUjiqwNOspicIHK/Z+I+1Po=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-180-adHHs4soNzeVqcRF0m0qPA-1; Wed,
 01 Apr 2026 07:58:41 -0400
X-MC-Unique: adHHs4soNzeVqcRF0m0qPA-1
X-Mimecast-MFC-AGG-ID: adHHs4soNzeVqcRF0m0qPA_1775044720
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E4523180034E; Wed,  1 Apr 2026 11:58:39 +0000 (UTC)
Received: from redhat.com (headnet01.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.101])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E070430001A2; Wed,  1 Apr 2026 11:58:38 +0000 (UTC)
Date: Wed, 1 Apr 2026 12:58:36 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?B?Sm/Do28gVmlsYcOnYQ==?= <machadovilaca@gmail.com>
Cc: Kostiantyn Kostiuk <kkostiuk@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH] qga: implement 'guest-get-nvidia-smi' command
Message-ID: <ac0IbJM3RFRt44Kx@redhat.com>
References: <20260331110135.92883-1-machadovilaca@gmail.com>
 <CAPMcbCpJsiTs95g_8v+AkNCL7LhVAK+CZM=X-y+-kbRDd41bSA@mail.gmail.com>
 <CAPM7mp10RGfhV7hpnhDcvm_fj7Ks=ozK=2=MTew-4fKKmxq8pA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPM7mp10RGfhV7hpnhDcvm_fj7Ks=ozK=2=MTew-4fKKmxq8pA@mail.gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Mar 31, 2026 at 02:07:27PM +0100, João Vilaça wrote:
> Monitoring, on the hypervisor side, of GPU workloads running in guests with
> NVIDIA GPU passthrough (VFIO) or vGPU (NVIDIA GRID).
> Operators who want GPU metrics from a fleet of VMs must either SSH into
> each guest or deploy a separate monitoring agent inside the guest itself
> (e.g. DCGM exporter).


IMHO, directly people to deploy an existing monmitoring agent solution
in the guest is likely the right thing todo.

We don't really want the QEMU guest agent expanding arbitrarily such
that it effectively re-invents what's already offered by general
purpose monitoring agents.

If the problem is that those existing monitoring agents need network
support, then IMHO the answer is likely to enhance the agent to use
vsock, rather than add more monitoring commands to QEMU.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


