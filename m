Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78934C5DF71
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2026 08:24:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUKPg-0007vb-VG; Tue, 02 Jun 2026 04:23:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wUKPf-0007v6-Du
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 04:23:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wUKPd-0006TW-Vs
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 04:23:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780388628;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JzEx/djjiKdSQ43hJspteLYFDK5pHtfMy3ITMuebRHU=;
 b=W3VrQEa4OZda9cEX3Zh8AxXc0SDNgu/dAEycDoYT7rpEL5weaCOEaBuLHpw2Po1O65Mq9I
 sHE6bWMY7919/Cpj6bu27ZUicZvFjiT7mTVNqu0yPgTMDP80z01dwo1RO8E6bcgIF1m/ME
 pUDkZXlg3jKaR+D5QB+e3Xv7SAxw/gI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-677-sU4JCvHpM2G4-w1R1dkwvw-1; Tue,
 02 Jun 2026 04:23:45 -0400
X-MC-Unique: sU4JCvHpM2G4-w1R1dkwvw-1
X-Mimecast-MFC-AGG-ID: sU4JCvHpM2G4-w1R1dkwvw_1780388623
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4AA39195606C; Tue,  2 Jun 2026 08:23:43 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E40461800352; Tue,  2 Jun 2026 08:23:42 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 87D1721E6A01; Tue, 02 Jun 2026 10:23:40 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Michael Roth <michael.roth@amd.com>
Cc: <qemu-devel@nongnu.org>,  <kvm@vger.kernel.org>,  <pbonzini@redhat.com>,
 <berrange@redhat.com>,  <pankaj.gupta@amd.com>,
 <isaku.yamahata@intel.com>,  <xiaoyao.li@intel.com>,
 <chao.p.peng@linux.intel.com>,  <david@kernel.org>,
 <ashish.kalra@amd.com>,  <ackerleytng@google.com>
Subject: Re: [PATCH RFC 04/12] accel/kvm: Add CGS option to control in-place
 conversion support
In-Reply-To: <20260528000416.8161-5-michael.roth@amd.com> (Michael Roth's
 message of "Wed, 27 May 2026 19:03:29 -0500")
References: <20260528000416.8161-1-michael.roth@amd.com>
 <20260528000416.8161-5-michael.roth@amd.com>
Date: Tue, 02 Jun 2026 10:23:40 +0200
Message-ID: <87wlwh5p0z.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Michael Roth <michael.roth@amd.com> writes:

> For confidential guests, guest_memfd is currently used only for private
> guest memory, and normal guest memory comes from the configured memory
> backend just as it does for a non-confidential guest. It is now possible
> to use the same physical memory to back a particular GPA regardless of
> whether it is in a shared or private state. This avoids the need to
> rely on discarding memory between shared/private conversions (to avoid
> doubled memory usage), and is intended to be the primary mode of using
> guest_memfd for confidential guests moving forward, and future features
> like hugepage support will likely require it.
>
> Add an option to enable this support. Since ConfidentialGuestSupport is
> already used to track some guest_memfd-related functionality (e.g.
> whether it is required for the configured machine), similarly introduce
> this option as a property of ConfidentialGuestSupport.
>
> Also add the KVM-specific checks to enable this support, but leave the
> option disabled until other required changes are implemented for
> CGS variants that intend to make use of KVM's in-place conversion
> support.
>
> Signed-off-by: Michael Roth <michael.roth@amd.com>

[...]

> diff --git a/qapi/qom.json b/qapi/qom.json
> index 502fafeb15..037c078799 100644
> --- a/qapi/qom.json
> +++ b/qapi/qom.json
> @@ -1014,6 +1014,21 @@
>    'if': 'CONFIG_IGVM',
>    'data': { 'file': 'str' } }
>  
> +##
> +# @ConfidentialGuestSupportProperties:
> +#
> +# Properties for ConfidentialGuestSupport base class.
> +#
> +# @convert-in-place: If true, the same physical pages are reused
> +#     when memory is converted between shared and private states.
> +#     If false (default), separate allocations are used depending
> +#     on whether the page is private or shared.
> +#
> +# Since: 11.1
> +##
> +{ 'struct': 'ConfidentialGuestSupportProperties',
> +  'data': { '*convert-in-place': 'bool' } }
> +
>  ##
>  # @SevCommonProperties:
>  #
> @@ -1038,6 +1053,7 @@
>  # Since: 9.1
>  ##
>  { 'struct': 'SevCommonProperties',
> +  'base': 'ConfidentialGuestSupportProperties',
>    'data': { '*sev-device': 'str',
>              '*cbitpos': 'uint32',
>              'reduced-phys-bits': 'uint32',

Why use a base type instead of simply adding @convert-in-place to
SevCommonProperties?


