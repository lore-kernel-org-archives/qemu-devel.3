Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5E9BC3DA49
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 15:18:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sXMhQ-0002Rc-Jf; Fri, 26 Jul 2024 11:17:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sXMhL-0002Qb-Ey
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 11:17:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sXMhI-00018c-45
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 11:17:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722007047;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6q5+BxFnzluFw4B6k0u8M+z9XFIUuBtDXItwUrUywR8=;
 b=BzvtbsNsAcokVbed8VuICjLsVfkiYfrBR+F9ShVgPCPa8DZMP4nsuniVxFPz6hajIrKVml
 xg9kCeY1YArGGMyUqiCYfIKnvdW3JWNj5ggJaYsLZDvIU66qIs9HRQGGNKy8DeREBQA6T6
 +UqE4XCgy5OppdELrogH78sYKZER7Eo=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-170-J-TtIDN4Mk26h3j6oESoPQ-1; Fri,
 26 Jul 2024 11:17:24 -0400
X-MC-Unique: J-TtIDN4Mk26h3j6oESoPQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A61F61955F3D; Fri, 26 Jul 2024 15:17:21 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.32])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 063201955D45; Fri, 26 Jul 2024 15:17:15 +0000 (UTC)
Date: Fri, 26 Jul 2024 16:17:12 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, dmitry.fleytman@gmail.com,
 akihiko.odaki@daynix.com, jasowang@redhat.com,
 sriram.yagnaraman@est.tech, sw@weilnetz.de, qemu-devel@nongnu.org,
 yan@daynix.com, Fabiano Rosas <farosas@suse.de>, devel@lists.libvirt.org
Subject: Re: [PATCH v2 4/4] virtio-net: Add support for USO features
Message-ID: <ZqO7cR-UiGpX2rk0@redhat.com>
References: <20230731223148.1002258-1-yuri.benditovich@daynix.com>
 <20230731223148.1002258-5-yuri.benditovich@daynix.com>
 <ZqLPLBnbfD5r6z7D@x1n>
 <20240726020656-mutt-send-email-mst@kernel.org>
 <775ff713-f7d3-4fdc-8ba0-4ebde577040d@redhat.com>
 <ZqNiwmy29dxdyMA0@redhat.com> <ZqO2HvFJ8v7hZFOd@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZqO2HvFJ8v7hZFOd@x1n>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Jul 26, 2024 at 10:43:42AM -0400, Peter Xu wrote:
> On Fri, Jul 26, 2024 at 09:48:02AM +0100, Daniel P. Berrangé wrote:
> > On Fri, Jul 26, 2024 at 09:03:24AM +0200, Thomas Huth wrote:
> > > On 26/07/2024 08.08, Michael S. Tsirkin wrote:
> > > > On Thu, Jul 25, 2024 at 06:18:20PM -0400, Peter Xu wrote:
> > > > > On Tue, Aug 01, 2023 at 01:31:48AM +0300, Yuri Benditovich wrote:
> > > > > > USO features of virtio-net device depend on kernel ability
> > > > > > to support them, for backward compatibility by default the
> > > > > > features are disabled on 8.0 and earlier.
> > > > > > 
> > > > > > Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
> > > > > > Signed-off-by: Andrew Melnychecnko <andrew@daynix.com>
> > > > > 
> > > > > Looks like this patch broke migration when the VM starts on a host that has
> > > > > USO supported, to another host that doesn't..
> > > > 
> > > > This was always the case with all offloads. The answer at the moment is,
> > > > don't do this.
> > > 
> > > May I ask for my understanding:
> > > "don't do this" = don't automatically enable/disable virtio features in QEMU
> > > depending on host kernel features, or "don't do this" = don't try to migrate
> > > between machines that have different host kernel features?
> > > 
> > > > Long term, we need to start exposing management APIs
> > > > to discover this, and management has to disable unsupported features.
> > > 
> > > Ack, this likely needs some treatments from the libvirt side, too.
> > 
> > When QEMU automatically toggles machine type featuers based on host
> > kernel, relying on libvirt to then disable them again is impractical,
> > as we cannot assume that the libvirt people are using knows about
> > newly introduced features. Even if libvirt is updated to know about
> > it, people can easily be using a previous libvirt release.
> > 
> > QEMU itself needs to make the machine types do that they are there
> > todo, which is to define a stable machine ABI. 
> > 
> > What QEMU is missing here is a "platform ABI" concept, to encode
> > sets of features which are tied to specific platform generations.
> > As long as we don't have that we'll keep having these broken
> > migration problems from machine types dynamically changing instead
> > of providing a stable guest ABI.
> 
> Any more elaboration on this idea?  Would it be easily feasible in
> implementation?

In terms of launching QEMU I'd imagine:

  $QEMU -machine pc-q35-9.1 -platform linux-6.9 ...args...

Any virtual machine HW features which are tied to host kernel features
would have their defaults set based on the requested -platform. The
-machine will be fully invariant wrt the host kernel.

You would have -platform hlep to list available platforms, and
corresonding QMP "query-platforms" command to list what platforms
are supported on a given host OS.

Downstream distros can provide their own platforms definitions
(eg "linux-rhel-9.5") if they have kernels whose feature set
diverges from upstream due to backports.

Mgmt apps won't need to be taught about every single little QEMU
setting whose default is derived from the kernel. Individual
defaults are opaque and controlled by the requested platform.

Live migration has clearly defined semantics, and mgmt app can
use query-platforms to validate two hosts are compatible.

Omitting -platform should pick the very latest platform that is
cmpatible with the current host (not neccessarily the latest
platform built-in to QEMU).


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


