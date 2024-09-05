Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B29ACD5BA2
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 09:44:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sm91a-0008Ol-Si; Thu, 05 Sep 2024 05:43:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sm91Y-0008Ni-Ui
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 05:43:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sm91W-0004iN-Ah
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 05:43:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725529408;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=XoruUiZtnqwjix1nRp+rt3Ip66D/yTVzkjSRh9uAUrs=;
 b=cFjAsYJFL6UpVcH24MUI+lBDoocFnABKWUwSCBdt3+RhByTzznrp0VIUWcVe9+UGePzhsC
 aMzMhhjlo5zEbd7Kau2mEJ8Z9FX+WOarma1geC+axdquxer18JKwIo4eCGc6cSpghyLTZ9
 vT/kGaXS8t1NuW1WyAquEEsYqVWjOeE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-322-c5TQrZLRM3KO3YOWdgrJUg-1; Thu,
 05 Sep 2024 05:43:25 -0400
X-MC-Unique: c5TQrZLRM3KO3YOWdgrJUg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E7B7E1956069; Thu,  5 Sep 2024 09:43:23 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.53])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C936B1956052; Thu,  5 Sep 2024 09:43:20 +0000 (UTC)
Date: Thu, 5 Sep 2024 10:43:17 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH V2 00/11] Live update: cpr-exec
Message-ID: <Ztl9NRnELy82n3-R@redhat.com>
References: <Zru4AaTmBIAGnyDr@x1n>
 <46b63356-9602-4fa2-9d31-186f5f85151f@oracle.com>
 <Zr9q4muKZmYCf9mv@x1n> <Zr9tYsmy8j2t8fq0@redhat.com>
 <Zr9xcmUfkYAWnXH-@x1n> <Zr93oOn9J5JLs2Rn@redhat.com>
 <Zr97ms6Ur9HH_EXG@x1n>
 <d45761d3-6bee-42ac-9752-1192b3bae6ef@oracle.com>
 <ZsYzIN5pM9Ad_DYn@x1n>
 <e1284027-6860-460c-8f3c-5b9c34e2c351@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e1284027-6860-460c-8f3c-5b9c34e2c351@oracle.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Wed, Sep 04, 2024 at 04:58:14PM -0400, Steven Sistare wrote:
> On 8/21/2024 2:34 PM, Peter Xu wrote:
> > On Fri, Aug 16, 2024 at 01:09:23PM -0400, Steven Sistare wrote:
> > > 
> > > libvirt starts qemu with the -sandbox spawn=deny option which blocks fork, exec,
> > > and change namespace operations.  I have a patch in my workspace to be submitted
> > > later called "seccomp: fine-grained control of fork, exec, and namespace" that allows
> > > libvirt to block fork and namespace but allow exec.
> > 
> > The question is whether that would be accepted, and it also gives me the
> > feeling that even if it's accepted, it might limit the use cases that cpr
> > can apply to.
> 
> This is more acceptable for libvirt running in a container (such as under kubevirt)
> with a limited set of binaries in /bin that could be exec'd.  In that case allowing
> exec is more reasonable.

Running inside a container does protect the host to a significant
degree. I'd say it is still important, however, to protect the
control plane (libvirt's daemons & kubevirt's agent) from the QEMU
process being managed, and in that case it still looks pretty
compelling to deny exec.

> > What I read so far from Dan is that cpr-transfer seems to be also preferred
> > from Libvirt POV:
> > 
> >    https://lore.kernel.org/r/Zr9-IvoRkGjre4CI@redhat.com
> > 
> > Did I read it right?
> 
> I read that as: cpr-transfer is a viable option for libvirt.  I don't hear him
> excluding the possibility of cpr-exec.
> 
> I agree that "Dan the libvirt expert prefers cpr-transfer" is a good reason to
> provide cpr-transfer.  Which I will do.

Both approaches have significant challenges for integration, but my general
preference is towards a solution that doesn't require undermining our security
protections.

When starting a VM we have no knowledge of whether a user may want to use
CPR at a later date. We're not going to disable the seccomp sandbox by
default, so that means cpr-exec would not be viable in a default VM
deployment.

Admins could choose to modify /etc/libvirt/qemu.conf to turn off seccomp,
but I'm very much not in favour of introducing a feature that requires
them todo this. It would be a first in libvirt, as everything else we
support is possible to use with seccomp enabled. The seccomp opt-out is
essentially just there as an emergency escape hatch, not as something we
want used in production.

> We are at an impasse on this series.  To make forward progress, I am willing to
> reorder the patches, and re-submit cpr-transfer as the first mode, so we can
> review and pull that.  I will submit cpr-exec as a follow on and we can resume
> our arguments then.

Considering the end result, are there CPR usage scenarios that are possible
with cpr-exec, that can't be achieved with cpr-transfer ?

Supporting two ways to doing the same thing is increasing the maint burden
for QEMU maintainers, as well as downstream testing engineers who have to
validate this functionality. So unless there's compelling need to support
both cpr-transfer and cpr-exec, it'd be nice to standardize on just one of
them.

cpr-transfer does look like its probably more viable, even with its own
challenges wrt resources being opened twice.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


