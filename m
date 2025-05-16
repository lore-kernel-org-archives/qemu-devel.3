Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D26FC3ABC9
	for <qemu-devel@archiver.kernel.org>; Fri, 16 May 2025 14:58:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFwVn-0006dz-Nd; Fri, 16 May 2025 10:58:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uFwVj-0006cw-Dl
 for qemu-devel@nongnu.org; Fri, 16 May 2025 10:58:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uFwVb-0003bj-AD
 for qemu-devel@nongnu.org; Fri, 16 May 2025 10:58:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747407477;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=paUwJkwQHzBMcBv8RskLb1Dl+OLJ1nXy6PmUjXt/7Ys=;
 b=RttHWHZud/WSW28LLZwt7wOVg428fJ9WMXzJe89qneUrBPKQNG/lGE0gNTlLuBwdrGLUYi
 FQ1eMc8iKvAhSF+1nYVPXg1UJ8vmZB5YibBby14YAWBjqqCZ794Fw4Astcu2sjV+Rt7w//
 vu3YcQx3+vxkSn287iyIfCqQnWguvkE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-470-JLqCEF1EMaKnFUoXyb3IKQ-1; Fri,
 16 May 2025 10:57:54 -0400
X-MC-Unique: JLqCEF1EMaKnFUoXyb3IKQ-1
X-Mimecast-MFC-AGG-ID: JLqCEF1EMaKnFUoXyb3IKQ_1747407472
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 186791800261; Fri, 16 May 2025 14:57:52 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.109])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8EC11195608D; Fri, 16 May 2025 14:57:44 +0000 (UTC)
Date: Fri, 16 May 2025 15:57:40 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Cc: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, kvmarm@lists.linux.dev,
 peter.maydell@linaro.org, richard.henderson@linaro.org,
 alex.bennee@linaro.org, maz@kernel.org, oliver.upton@linux.dev,
 sebott@redhat.com, shameerali.kolothum.thodi@huawei.com,
 armbru@redhat.com, abologna@redhat.com, jdenemar@redhat.com,
 agraf@csgraf.de, shahuang@redhat.com, mark.rutland@arm.com,
 philmd@linaro.org, pbonzini@redhat.com
Subject: Re: [PATCH v3 08/10] arm/cpu: more customization for the kvm host
 cpu model
Message-ID: <aCdSZD5n2GCRXjVQ@redhat.com>
References: <20250414163849.321857-1-cohuck@redhat.com>
 <20250414163849.321857-9-cohuck@redhat.com>
 <aCNsSbDoi5oKWYul@redhat.com> <875xi3cig5.fsf@redhat.com>
 <aCTe5kEN1WdgZ74T@redhat.com> <87v7q0bocp.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87v7q0bocp.fsf@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, May 16, 2025 at 04:51:34PM +0200, Cornelia Huck wrote:
> On Wed, May 14 2025, Daniel P. Berrangé <berrange@redhat.com> wrote:
> 
> > On Wed, May 14, 2025 at 05:36:58PM +0200, Cornelia Huck wrote:
> >> On Tue, May 13 2025, Daniel P. Berrangé <berrange@redhat.com> wrote:
> >> 
> >> > On Mon, Apr 14, 2025 at 06:38:47PM +0200, Cornelia Huck wrote:
> >> >> From: Eric Auger <eric.auger@redhat.com>
> >> >> 
> >> >> If the interface for writable ID registers is available, expose uint64
> >> >> SYSREG properties for writable ID reg fields exposed by the host
> >> >> kernel. Properties are named  SYSREG_<REG>_<FIELD> with REG and FIELD
> >> >> being those used  in linux arch/arm64/tools/sysreg. This done by
> >> >> matching the writable fields retrieved from the host kernel against the
> >> >> generated description of sysregs.
> >> >> 
> >> >> An example of invocation is:
> >> >> -cpu host,SYSREG_ID_AA64ISAR0_EL1_DP=0x0
> >> >> which sets DP field of ID_AA64ISAR0_EL1 to 0.
> >> >
> >> > For the value you are illustrating 0x0 - is this implying that
> >> > all the flags take an arbitrary integer hex value ?
> >> >
> >> > This would be different from x86, where CPU feature flags are
> >> > a boolean on/off state.
> >> 
> >> Most of the fields are 4 bits, the allowed values vary (there are also
> >> some fields that are single bits, or wider.) The FEAT_xxx values (which
> >> can be expressed via ID register fields, or a combination thereof) are
> >> mostly boolean, but there are also some of them that can take values.
> >> 
> >> We could cook up pseudo-features that are always on/off, but I don't
> >> like that approach: they would be QEMU only, whereas the ID register
> >> fields and FEAT_xxx features are all defined in the Arm documentation.
> >
> > Fortunately from a libvirt POV we can likely expand our config
> > to cope with hex values for arm features without too much
> > trouble.
> >
> >> 
> >> An additional difference from x86 would be that FEAT_xxx featues are not
> >> neccessarily configurable (only if the host kernel supports changing the
> >> ID register field(s) backing the feature.)
> >
> > Is the kernel able to tell us which ones are configurable and which
> > are not ? If so, it'd be helpful to expose this info in QAPI some
> > place.
> 
> The kernel can tell us which ID register fields are writable (we won't
> generate properties if we don't.) For FEAT_xxx, this depends on how
> we'll end up handling them (maybe we should only expose them if all ID
> register bits backing them are actually writable.)
> 
> What worries me a bit is that QEMU exposing a certain set of FEAT_xxx
> values could be interpreted as "those features are present, any other
> features aren't", while it is only the list of configurable features.
> 
> Another issue: If libvirt is trying to baseline two cpus, it might end
> up creating a model that looks sane on paper, but migrations will fail
> because there are differences in non-writable bits. It would be much
> better if libvirt could detect beforehand that there was no common
> determinator. Not yet sure how to handle this.

For "host" model that's probably not the end of the world. Apps have
already given up strong guarantee of migration compat by using 'host'
CPU and so in that context libvirt's feature comparison can assume
the underlying silicon is a match and just compare features.


In that sense the ability to list features and baseline two cpus
lets you guarantee that whatever CPU you boot the guest on, will
have at least those requested features. That's useful, even if it
does not give you a strong migration compat guarantee.

Doing better would require info on non-writable features, and
possibly even that might not be sufficient to guarantee compat

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


