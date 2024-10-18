Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2FEDD30004
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 13:10:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1mkB-00064l-Vd; Fri, 18 Oct 2024 09:10:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1t1mkB-00063b-AG
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 09:10:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1t1mk6-0004PP-Gb
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 09:10:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729257008;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lMjrOGFmVI50rdu0SKya0KWK9sRXrS7uZtsgOjBNZug=;
 b=YuYepCfGp+IGXo8M5tAqSzVlJkW/d+uoxtDW9u6+5VBzCAKRLWRhTE9Cdsd4fffvooRtgE
 bq/8D6p/6tETcDrzYYjSzp5aD7763F4uvg/lNhFxKMZnqcymL3oktIBNiliNrghVmOr8SV
 yvh/EPIiusZDyPMNwqokGvy2zoB9t5k=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-652-_S4VzmqUN_mKz36bluwoWA-1; Fri,
 18 Oct 2024 09:10:02 -0400
X-MC-Unique: _S4VzmqUN_mKz36bluwoWA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A7463195608D
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2024 13:10:01 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.196])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A348B19560A2; Fri, 18 Oct 2024 13:10:00 +0000 (UTC)
Date: Fri, 18 Oct 2024 15:09:58 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [RFC PATCH 00/16] rust: allow older versions of rustc and bindgen
Message-ID: <ZxJeJtiMt1xVqk54@redhat.com>
References: <20241015131735.518771-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015131735.518771-1-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.016,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Am 15.10.2024 um 15:17 hat Paolo Bonzini geschrieben:
> This includes a few fixes to the Rust build system machinery, and
> removes constructs that were added or stabilized after version 1.63.0:

Most of this series looks harmless in the sense that we need to write
some workaround code in a single place and can forget about it. So
that's good.

> - "let else" (by patching bilge-impl, patch 4; stable in 1.65.0)

This one affects all of the code we'll write and the replacement is a
bit unwieldy. It might be the most annoying one from the list.

> - std::sync::OnceLock (patch 6; stable in 1.70.0)
> 
> - core::ffi (patch 7; stable in 1.64.0)
> 
> - c"" literals (patch 9; stable in 1.77.0)

This one will be fairly widespread, too, but only a minor inconvenience.

> - offset_of! (patch 10; stable in 1.77.0)

Requiring structs to be wrapped in with_offsets! has potential to become
quite annoying, too, but it seems we already have a solution for this
with the proc macro.

> - MaybeUninit::zeroed() (patch 11; stable in 1.75.0 in const context)
> 
> It also replicates the configuration checks normally done by
> proc-macro2's build.rs into our Meson-based build rules, so that
> the crate can be made to work with an older version of rustc.
> 
> As a small bonus, patch 11 removes some uses of unsafe, so that patch
> probably won't just be simply reverted even once we can assume version
> 1.75.0 of the language.  And as another small bonus this series introduces
> the first use of Rust unit tests.
> 
> On top of this, the required version of bindgen is still too new
> for Debian 12 and Ubuntu 22.04.  This is fixed by the last four patches.
> 
> This is an RFC for two reasons.  First, because it would be a valid
> decision to delay enabling of Rust until at least some of these
> features are available in all supported distros.  Another possibility
> could be to accept Rust 1.64.0 but require installing a newer bindgen
> (0.66.x for example) on those two distros with an older release.  Second,
> because the series is missing the CI updates to actually ensure that
> these minimum versions keep working.
> 
> The main purpose is to show the kind of hacks that would be needed
> to support older toolchains.  The fixes (for example patches
> 1/2/3/6/8/11/13/14) can be easily extracted independent of the outcome
> of the discussion, and/or while the CI updates are made.

It would probably make sense to just go ahead and apply the fixes. They
seem a lot more obvious than the question which toolchains we want to
support.

Kevin


