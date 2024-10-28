Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6B30D3399B
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2024 16:16:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5SPI-0007vw-1v; Mon, 28 Oct 2024 12:15:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t5SP2-0007um-Aq
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 12:15:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t5SP0-0006lB-Jw
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 12:15:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730132133;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QKIrHJfj63rZmwzKwL6iYi78U/EbdLp1fslXaennyrc=;
 b=Ka3BYkwuVpMSYnpyiBvmbSIWdIJPg6b3+XnaqFAzxjrjki7/thCFdnxW051Vwgi03YnfvA
 4A7m0IQHt/RjfNnI7RlOxSEE4O/oBJ/bMWL9w/MS6t3zbH4EUn5FStjF7cMAzMmM0DCoqq
 PyUs3C74jxSpEaJ0me1vw+mnAOyMjEY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-232-BrWJYIK0PX-Z2wN_TKKHTA-1; Mon,
 28 Oct 2024 12:15:30 -0400
X-MC-Unique: BrWJYIK0PX-Z2wN_TKKHTA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C31EB1956080; Mon, 28 Oct 2024 16:15:27 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.86])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 82EC51956086; Mon, 28 Oct 2024 16:15:20 +0000 (UTC)
Date: Mon, 28 Oct 2024 16:15:16 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvmarm@lists.linux.dev,
 peter.maydell@linaro.org, richard.henderson@linaro.org,
 alex.bennee@linaro.org, maz@kernel.org, oliver.upton@linux.dev,
 sebott@redhat.com, shameerali.kolothum.thodi@huawei.com,
 armbru@redhat.com, abologna@redhat.com, jdenemar@redhat.com,
 shahuang@redhat.com, mark.rutland@arm.com, philmd@linaro.org,
 pbonzini@redhat.com
Subject: Re: [RFC 18/21] arm/cpu: Introduce a customizable kvm host cpu model
Message-ID: <Zx-4lE5IS9BxD7nK@redhat.com>
References: <20241025101959.601048-1-eric.auger@redhat.com>
 <20241025101959.601048-19-eric.auger@redhat.com>
 <ZxuX4i9NjVRizB72@redhat.com>
 <cb6c8f62-c5dc-416d-865f-fbdf96164dac@redhat.com>
 <Zxub7ol4p8P_sWF8@redhat.com> <871q00p68h.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <871q00p68h.fsf@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.373,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Oct 28, 2024 at 05:00:46PM +0100, Cornelia Huck wrote:
> On Fri, Oct 25 2024, Daniel P. Berrangé <berrange@redhat.com> wrote:
> 
> > On Fri, Oct 25, 2024 at 03:18:25PM +0200, Eric Auger wrote:
> >> Hi Daniel,
> >> 
> >> On 10/25/24 15:06, Daniel P. Berrangé wrote:
> >> > On Fri, Oct 25, 2024 at 12:17:37PM +0200, Eric Auger wrote:
> >> >> At the moment, the custom model does not support legacy options
> >> >> of the host cpu model. We need to understand what we do with those
> >> >> latter (SVE, ...). This means that related KVM ioctl are
> >> >> not called yet.
> >> > It will be pretty painful to have to use different feature
> >> > terminology for different CPU models. Everything in libvirt
> >> > assuming feature terminology varies per-arch, not per-CPU
> >> > model.
> >> Actually as far as I understand those regids/fields would fit all kind
> >> of aarch64 Cortex-A CPUs. So they wouldn't vary per-CPU (I mean their
> >> terminology. Their availability will).
> >
> > What I mean is can we define  named models for various different
> > vendor's Cortex-A silicon and just use that without needing to
> > toggle features, except in rare cases.
> 
> I'm not sure whether creating named models for various cpus would
> actually scale; what we probably could do is come up with some Armv8.6,
> Armv8.7, ... models and have additional models for some well-known cpus.
> That would also give us some basic sanity checks for feature
> combinations, if we do not want to support completely custom
> frankencpus.

Yep, even on x86 we don't add named models for every conceivable
CPU SKU variant, just one so called "typical" variant for a given
microarchiteture level [1].

The vendor independent Arm CPU spec versions are a good enough
match for typical real world silicon, then it would make sense
to focus mostly on such named CPU models, not try to make an
exhaustive definition of every vendor's impl. I could see there
might be some exceptions where adding a vendor specific named
model would be worthwhile, but hopefully that'd be relatively
uncommon and   -cpu Armv8.6,+feat1,+feat2 would be sufficient.

eg toggling 1/2/3 extra features to precise match a vendor's
named mode is ok, but adding 20-30 extra features get a match
is painful. That's the kind of rule of thumb that could be
used when deciding whether its worth adding a vendor specific
named model, vs relying on the generic spec based models.

With regards,
Daniel

[1] we do have CPU model versions, as a way to "bugfix" our
    CPU definitions. 
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


