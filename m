Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C34AFD6B6A9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2024 16:27:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6BXc-00054B-Rw; Wed, 30 Oct 2024 12:27:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t6BXa-00053c-TR
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 12:27:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t6BXY-0003or-0Z
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 12:27:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730305642;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XvXVF5ChtnVmltzGExYLCTKSbX1wrbGeka/LhaWLXrk=;
 b=iSwLEadDEfIN8UgkICtNn52MHwPEKdecghRfpMWlvz48NFofPRjMAAYy/Q6dcMBRF4Waae
 aHH9xV3aDruXptA7RQ/HiGxNh5EVgb3/5IIlV/wcTDfFmOBIkPmuGra5X1MGaTXop668cT
 /p4ROtliVK1Lmq2S6aOo7FogtrsSr6Q=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-554-RyGJEPBdPLyHId5huFoBcQ-1; Wed,
 30 Oct 2024 12:27:18 -0400
X-MC-Unique: RyGJEPBdPLyHId5huFoBcQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1668B19560B5; Wed, 30 Oct 2024 16:27:16 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.92])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 77B871956086; Wed, 30 Oct 2024 16:27:09 +0000 (UTC)
Date: Wed, 30 Oct 2024 16:27:06 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Oliver Upton <oliver.upton@linux.dev>,
 Peter Maydell <peter.maydell@linaro.org>,
 Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvmarm@lists.linux.dev,
 richard.henderson@linaro.org, alex.bennee@linaro.org,
 maz@kernel.org, sebott@redhat.com,
 shameerali.kolothum.thodi@huawei.com, armbru@redhat.com,
 abologna@redhat.com, jdenemar@redhat.com, shahuang@redhat.com,
 mark.rutland@arm.com, philmd@linaro.org, pbonzini@redhat.com
Subject: Re: [RFC 18/21] arm/cpu: Introduce a customizable kvm host cpu model
Message-ID: <ZyJeWkxJX-5dcq4Z@redhat.com>
References: <20241025101959.601048-1-eric.auger@redhat.com>
 <20241025101959.601048-19-eric.auger@redhat.com>
 <ZxuX4i9NjVRizB72@redhat.com>
 <cb6c8f62-c5dc-416d-865f-fbdf96164dac@redhat.com>
 <Zxub7ol4p8P_sWF8@redhat.com>
 <CAFEAcA_wQu17y0PyQwxw0wuf2H5y2VE5aX16nLP2-u7QUP2ggA@mail.gmail.com>
 <Zx-9WxXkmkMuGIlQ@redhat.com>
 <CAFEAcA9w0mb5bcU8p+fScQony-=oqLmNurGWpnL_sBneQCzxUg@mail.gmail.com>
 <Zx_CU9eeQByANMRW@linux.dev> <87bjz1o9di.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87bjz1o9di.fsf@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.366,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Wed, Oct 30, 2024 at 05:15:05PM +0100, Cornelia Huck wrote:
> On Mon, Oct 28 2024, Oliver Upton <oliver.upton@linux.dev> wrote:
> 
> > On Mon, Oct 28, 2024 at 04:48:18PM +0000, Peter Maydell wrote:
> >> On Mon, 28 Oct 2024 at 16:35, Daniel P. Berrangé <berrange@redhat.com> wrote:
> >> >
> >> > On Mon, Oct 28, 2024 at 04:16:31PM +0000, Peter Maydell wrote:
> >> > > On Fri, 25 Oct 2024 at 14:24, Daniel P. Berrangé <berrange@redhat.com> wrote:
> >> > > > On Fri, Oct 25, 2024 at 03:18:25PM +0200, Eric Auger wrote:
> >> > > > > On 10/25/24 15:06, Daniel P. Berrangé wrote:
> >> > > > > > Also, is this naming convention really the same one that users
> >> > > > > > will see when they look at /proc/cpuinfo to view features ? It
> >> > > > > No it is not. I do agree that the custom cpu model is very low level. It
> >> > > > > is very well suited to test all series turning ID regs as writable but
> >> > > > > this would require an extra layer that adapts /proc/cpuinfo feature
> >> > > > > level to this regid/field abstraction.
> >> > > > >
> >> > > > > In /cpu/proc you will see somethink like:
> >> > > > >  Features    : fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics fphp
> >> > > > > asimdhp cpuid asimdrdm lrcpc dcpop asimddp
> >> > > >
> >> > > > Right, IMHO, this is the terminology that QEMU must use in user
> >> > > > facing APIs.
> >> > >
> >> > > /proc/cpuinfo's naming is rather weird for historical
> >> > > reasons (for instance there is only one FEAT_FP16 feature
> >> > > but cpuinfo lists "fphp" and "asimdhp" separately).
> >> >
> >> > There's plenty of wierd history in x86 too. In this
> >> > case I might suggest just picking one of the two
> >> > common names, and ignoring the other.
> >> >
> >> > If we really wanted to, we could alias the 2nd name
> >> > to the first, but its likely not worth the bother.
> >> 
> >> Or we could use the standard set of architectural
> >> feature names, and not have the problem at all, and not
> >> have to document what we mean by our nonstandard names.
> >
> > +1
> >
> > There's existing documentation [*] for the standard feature names, which
> > provides:
> >
> >  - A short description of what the feature does
> >  - Any dependencies a particular feature has (e.g.FEAT_VHE implies
> >    FEAT_LSE, FEAT_Debugv8p1, and FEAT_AA64EL2)
> >  - The register fields/values that are used to discover the feature.
> >
> > This seems like the most user-friendly option...
> >
> > [*]: https://developer.arm.com/documentation/109697/2024_09
> 
> FEAT_XXX sounds good, would be a different approach than this series
> obviously, since the user resp. upper software layers would operate on a
> per-feature basis, and QEMU would translate to and from registers.
> 
> I'm wondering about the amount of translation that would be needed, and
> what information would be best exposed via QEMU, given that a feature
> may or may not be toggable not only because of what the Arm revision
> specifies, but what registers the host kernel allows to be written.
> 
> I.e. if we have two cpus that differ in whether FEAT_FOO is provided,
> would it make sense to have an extra QMP command so that you can find
> out whether FEAT_FOO can be switched off, with QEMU translating from the
> set of writable id registers to the set of features that can be changed?

If there are restrictions on what features can be turned off, then yes,
we should add that in QMP, as x86 doesn't have such a restriction
currently.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


