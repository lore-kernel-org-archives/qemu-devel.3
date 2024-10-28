Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 013C2D3399B
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2024 16:36:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5Sip-0000yj-A9; Mon, 28 Oct 2024 12:36:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t5Sim-0000yI-M1
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 12:36:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t5Sij-0000pq-NB
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 12:36:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730133356;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y9b5CzbUSU2n0RZT4h84OA5Z8uF+KezT8fQqdhGRljA=;
 b=NjM7CepK2ZcDMQTqCMcqH1uuuRdjBMkanvREqkaC2/oSxcNsTKfN8pCNVjnEA6FzwFQfEE
 bX70yaD7vmLAJ+43s/HRQRKMKw3gDAWmgFIkQjnm15EHja2c/GJOWuYBPc1c0o3rrNxbEH
 7/0p4w0cbWr3ufIXE5AuxeBqp8Afh+A=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-120-n8NY9vqZPxSv0Fatb-9iKg-1; Mon,
 28 Oct 2024 12:35:53 -0400
X-MC-Unique: n8NY9vqZPxSv0Fatb-9iKg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EFB2C1955F3C; Mon, 28 Oct 2024 16:35:49 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.86])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D9EE719560A2; Mon, 28 Oct 2024 16:35:42 +0000 (UTC)
Date: Mon, 28 Oct 2024 16:35:39 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 cohuck@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 kvmarm@lists.linux.dev, richard.henderson@linaro.org,
 alex.bennee@linaro.org, maz@kernel.org, oliver.upton@linux.dev,
 sebott@redhat.com, shameerali.kolothum.thodi@huawei.com,
 armbru@redhat.com, abologna@redhat.com, jdenemar@redhat.com,
 shahuang@redhat.com, mark.rutland@arm.com, philmd@linaro.org,
 pbonzini@redhat.com
Subject: Re: [RFC 18/21] arm/cpu: Introduce a customizable kvm host cpu model
Message-ID: <Zx-9WxXkmkMuGIlQ@redhat.com>
References: <20241025101959.601048-1-eric.auger@redhat.com>
 <20241025101959.601048-19-eric.auger@redhat.com>
 <ZxuX4i9NjVRizB72@redhat.com>
 <cb6c8f62-c5dc-416d-865f-fbdf96164dac@redhat.com>
 <Zxub7ol4p8P_sWF8@redhat.com>
 <CAFEAcA_wQu17y0PyQwxw0wuf2H5y2VE5aX16nLP2-u7QUP2ggA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA_wQu17y0PyQwxw0wuf2H5y2VE5aX16nLP2-u7QUP2ggA@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.373,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Oct 28, 2024 at 04:16:31PM +0000, Peter Maydell wrote:
> On Fri, 25 Oct 2024 at 14:24, Daniel P. Berrangé <berrange@redhat.com> wrote:
> > On Fri, Oct 25, 2024 at 03:18:25PM +0200, Eric Auger wrote:
> > > On 10/25/24 15:06, Daniel P. Berrangé wrote:
> > > > Also, is this naming convention really the same one that users
> > > > will see when they look at /proc/cpuinfo to view features ? It
> > > No it is not. I do agree that the custom cpu model is very low level. It
> > > is very well suited to test all series turning ID regs as writable but
> > > this would require an extra layer that adapts /proc/cpuinfo feature
> > > level to this regid/field abstraction.
> > >
> > > In /cpu/proc you will see somethink like:
> > >  Features    : fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics fphp
> > > asimdhp cpuid asimdrdm lrcpc dcpop asimddp
> >
> > Right, IMHO, this is the terminology that QEMU must use in user
> > facing APIs.
> 
> /proc/cpuinfo's naming is rather weird for historical
> reasons (for instance there is only one FEAT_FP16 feature
> but cpuinfo lists "fphp" and "asimdhp" separately).

There's plenty of wierd history in x86 too. In this
case I might suggest just picking one of the two
common names, and ignoring the other.

If we really wanted to, we could alias the 2nd name
to the first, but its likely not worth the bother.

> Currently QEMU only has to care about cpuinfo name tags
> in linux-user/elfload.c where there's a bunch of data
> structures for "what hwcaps do we need to advertise
> given what the CPU has?". I would definitely prefer it if
> we could use architectural feature names...
> 
> On other architectures do we do anything to forbid
> invalid combinations? For Arm there are architectural
> rules about feature X requiring features Y and Z.
> Are we going to just let the user create a CPU that
> the guest OS will barf on if they want to? (The
> user-experience for that is potentially not very nice,
> because something like "-cpu cortex-a57,+sve" seems like
> something you might want to do but isn't actually valid;
> even listing the direct required dependency of FEAT_SVE
> like "-cpu cortex-a57,+sve,+fp16" isn't sufficient
> because SVE is optional-from-v8.2 and so a guest could
> in theory assume the presence of anything mandatory in
> v8.1 and v8.2. But even merely diagnosing invalid
> combinations is a huge pain, and automagically pulling
> in every mandatory implicit or explicit dependency
> seems like it might be surprising to users, as well as
> being annoying to implement. Currently we sidestep
> all of these problems by (a) only allowing the command
> line to disable a feature, not to enable it where it
> didn't previously exist and (b) mostly not providing
> command line flags for individual features...)

AFAICT, in x86 world, there's no generally documented dependancies
between features. I imagine there might be deps mentioned in an
adhoc basis in docs/specs.  There are certainly implicit deps though
where apps check for X, and blindly assume it means Y+Z also exist.

In the QEMU  & libvirt world though, there's no deps. This is generally
why we discourage apps/users from trying to enable arbitrarily many
features. People should stick to the named CPU models, and just use
feature enablement as an exception.

Enabling individual features *is* certainly a critically important
benefit though, even with the risks from implicit undocumented
dependencies.

Most notably, it has been used to turn on fixes for hardware CVEs,
where microcode introduces a new named feature. Your named CPU
model may not be updated, but as long as QEMU knows the feature
name, you can turn it on.

Overall, while it would be desirable to have a way to express
feature dependencies, I wouldn't call that a blocker for enabling
the ability to turn features on & off.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


