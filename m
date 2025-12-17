Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A539DD6554E
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Dec 2025 14:08:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVsCu-0002Ln-AK; Wed, 17 Dec 2025 09:08:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1vVsCo-0002GQ-Ty
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 09:08:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1vVsCh-0007jY-VO
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 09:08:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765980514;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/Vr9xukdWOnd+aakAcHJmI8rOgQJ1eSfxjHiLZshjq4=;
 b=G6+8TNPHwCFIZ7vt2zDaSeiKNuWxJcecgxL+/4htlZ28T2MrBkzict4L0IZky8Mncc8AA1
 X7Kq2rdCk6jAYwq8pN8m2TjAQstZuW4D09SinWOgB3XZ2khlax8CguYsNL4lhbJ+ZHm8pt
 G0Z9V4YyWhECFT/C9wFDQFGgrF9hrYI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-360-l-tnkY1MOKqTEV04q0osVw-1; Wed,
 17 Dec 2025 09:08:31 -0500
X-MC-Unique: l-tnkY1MOKqTEV04q0osVw-1
X-Mimecast-MFC-AGG-ID: l-tnkY1MOKqTEV04q0osVw_1765980510
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D9FB11801207; Wed, 17 Dec 2025 14:08:29 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.32.156])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7995130001A2; Wed, 17 Dec 2025 14:08:29 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id E67851800080; Wed, 17 Dec 2025 15:08:26 +0100 (CET)
Date: Wed, 17 Dec 2025 15:08:26 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Ani Sinha <anisinha@redhat.com>, 
 Vitaly Kuznetsov <vkuznets@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 qemu-devel <qemu-devel@nongnu.org>
Subject: Re: [PATCH v1 21/28] hw/hyperv/vmbus: add support for confidential
 guest reset
Message-ID: <6z23v5oawxmjzby5yv7mpbnupnv3dgayjg424hxseiqcrihv6z@yx5dfg7c62wu>
References: <20251212150359.548787-1-anisinha@redhat.com>
 <20251212150359.548787-22-anisinha@redhat.com>
 <a0cfba30-8571-4153-a5a3-572cb2fe514f@maciej.szmigiero.name>
 <FCE31E2E-19BA-43AF-9525-B99C45ADBBF6@redhat.com>
 <9cb2723e-4132-44ac-be32-857c7933d27e@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9cb2723e-4132-44ac-be32-857c7933d27e@maciej.szmigiero.name>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Dec 16, 2025 at 02:38:10PM +0100, Maciej S. Szmigiero wrote:
> On 16.12.2025 05:41, Ani Sinha wrote:
> > 
> > 
> > > On 15 Dec 2025, at 10:34 PM, Maciej S. Szmigiero <mail@maciej.szmigiero.name> wrote:
> > > 
> > > On 12.12.2025 16:03, Ani Sinha wrote:
> > > > On confidential guests when the KVM virtual machine file descriptor changes as
> > > > a part of the reset process, event file descriptors needs to be reassociated
> > > > with the new KVM VM file descriptor. This is achieved with the help of a
> > > > callback handler that gets called when KVM VM file descriptor changes during
> > > > the confidential guest reset process.
> > > > Signed-off-by: Ani Sinha <anisinha@redhat.com>
> > > > ---
> > > 
> > > Have you actually tested confidential guests with VMBus or is this a change
> > > "for completeness sake" that can't be exercised in the current state of things?
> > 
> > No I have not tested the changes with VMBus. It’s more for completeness sake as you have correctly put it. If you suggest, I can drop the change.
> > 
> 
> I have mixed feelings here: on the one hand this support could be useful in
> the future, on the other hand we probably don't want to add dead and
> untestable code to QEMU.
> 
> Let's see what other maintainers think about adding such code in order to
> be consistent across different subsystems.

In any case the testing status of these changes should be noted in the
commit messages.  There are some xen changes in the series where I
suspect they are untested too ...

take care,
  Gerd


