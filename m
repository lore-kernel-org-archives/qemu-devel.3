Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54D3FD5808D
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 12:15:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFXzI-0004Ca-VP; Mon, 25 Nov 2024 07:14:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tFXzE-0004Bh-49
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 07:14:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tFXzB-0001my-B7
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 07:14:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732536875;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=enIDTkMYgaWCU5Mf2Igd45rt8TD4RGTB/hy5ZJnHSkU=;
 b=LWNiCn2stpKDuOrkP+22DNUFSA2azqQOXsNrjbMTuBaKwVF+wsqyeOa1SjJFauF8u7+VCN
 /VVoLYxBZ6DHS5Cy3xhOc9FaIp+4Ey43MvTv9kXicvnbATvOI1f1Vw9W6aODqsDvjhRL+H
 3q2fA3oU5BkkYT8kj/J1FzeFL797kTs=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-467-Mr4zAhuDNl29ANWlNmu3DQ-1; Mon,
 25 Nov 2024 07:14:30 -0500
X-MC-Unique: Mr4zAhuDNl29ANWlNmu3DQ-1
X-Mimecast-MFC-AGG-ID: Mr4zAhuDNl29ANWlNmu3DQ
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BE72A1955F57; Mon, 25 Nov 2024 12:14:28 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.111])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D8CAE1955F3C; Mon, 25 Nov 2024 12:14:23 +0000 (UTC)
Date: Mon, 25 Nov 2024 12:14:20 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>
Subject: Re: [RFC PATCH for-10.0] include/hw/boards: Optimize the booleans in
 MachineClass
Message-ID: <Z0RqHDJa-x0B_FPK@redhat.com>
References: <20241122084923.1542743-1-thuth@redhat.com>
 <Z0RZmfjJmaHsfmWy@redhat.com>
 <963aad3c-69aa-498b-9fba-2038ab4a3455@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <963aad3c-69aa-498b-9fba-2038ab4a3455@linaro.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, Nov 25, 2024 at 12:47:33PM +0100, Philippe Mathieu-Daudé wrote:
> On 25/11/24 12:03, Daniel P. Berrangé wrote:
> > On Fri, Nov 22, 2024 at 09:49:23AM +0100, Thomas Huth wrote:
> > > While looking at the QEMU binary with "pahole", I noticed that we
> > > could optimize the size of MachineClass a little bit: So far we
> > > are using a mixture of a bitfield and single "bool" members here
> > > for the boolean flags. Declaring all flags as part of the bitfield
> > > helps to shrink the size of the struct a little bit.
> > > 
> > > Signed-off-by: Thomas Huth <thuth@redhat.com>
> > > ---
> > >   It's just a micro-optimization (the size of the struct decreases by
> > >   eight bytes), so I'm not sure whether it's worth the effort...?
> > 
> > Given that this is a QOM class, rather than an instance, we'll
> > only ever save memory once. That's an unmeasurably small real
> > world improvement. We also have no ABI reasons to use bitfields
> > for this.
> > 
> > So if anything I'd suggest we take the opposite approach, and
> > eliminate that bitfields in favour of just using 'bool' for
> > everything, on the basis that a bitfield has no reason to
> > exist.
> 
> While I agree with you on this, and the patch would take less
> than 1 minute, all of these fields are legacy options. Maybe
> a good opportunity to tackle this technical debt.
> 
> I.e. as of 2024 having to set no_parallel/no_floppy/no_cdrom
> to true to every new machines seems counter intuitive.

We don't set them for all machines though, they are all set
selectively, and this is machine ABI controlled. So we could
only remove this flags, once all versioned machines that have
them active, are deleted.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


