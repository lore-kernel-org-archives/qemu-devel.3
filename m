Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96503C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2024 15:02:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ryvAz-0007km-N9; Mon, 22 Apr 2024 11:01:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ryvAv-0007kV-2U
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 11:01:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ryvAs-0006OX-Pk
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 11:01:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713798101;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xxVhsEGm5iz8MRA6eQz0OUYX8Ub1fWixOcLGuqPi9rg=;
 b=DaKuEr5mPiGXoiwzRrkg00/xVEbOU7yunyAd5G+ssGlT/0g5DP+HCpIkf7k4SnU764mUUp
 K9TdTD/uPTrbeGTQC4maBWB1jV6c/vS3lUyHKzxy/UkV/esaY1+GmzrQOsZ1iOxZ/s2EYe
 BBtFdLxRnKgnN+qXYyPye4uPVrl/BHQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-287-XhS98-4PNAeRM3cQdYehEw-1; Mon, 22 Apr 2024 11:01:37 -0400
X-MC-Unique: XhS98-4PNAeRM3cQdYehEw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BD0D69AADB7;
 Mon, 22 Apr 2024 15:01:36 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.247])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9C1A7492BC6;
 Mon, 22 Apr 2024 15:01:36 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8F7C221E66C8; Mon, 22 Apr 2024 17:01:35 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Michael Roth <michael.roth@amd.com>
Cc: <qemu-devel@nongnu.org>,  <kvm@vger.kernel.org>,  Tom Lendacky
 <thomas.lendacky@amd.com>,  "Paolo Bonzini" <pbonzini@redhat.com>,  Daniel
 P . =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Pankaj Gupta
 <pankaj.gupta@amd.com>, Xiaoyao Li <xiaoyao.li@intel.com>,  Isaku Yamahata
 <isaku.yamahata@linux.intel.com>
Subject: Re: [PATCH v3 31/49] i386/sev: Update query-sev QAPI format to
 handle SEV-SNP
In-Reply-To: <20240320083945.991426-32-michael.roth@amd.com> (Michael Roth's
 message of "Wed, 20 Mar 2024 03:39:27 -0500")
References: <20240320083945.991426-1-michael.roth@amd.com>
 <20240320083945.991426-32-michael.roth@amd.com>
Date: Mon, 22 Apr 2024 17:01:35 +0200
Message-ID: <87jzkpcugg.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.669,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Michael Roth <michael.roth@amd.com> writes:

> Most of the current 'query-sev' command is relevant to both legacy
> SEV/SEV-ES guests and SEV-SNP guests, with 2 exceptions:
>
>   - 'policy' is a 64-bit field for SEV-SNP, not 32-bit, and
>     the meaning of the bit positions has changed
>   - 'handle' is not relevant to SEV-SNP
>
> To address this, this patch adds a new 'sev-type' field that can be
> used as a discriminator to select between SEV and SEV-SNP-specific
> fields/formats without breaking compatibility for existing management
> tools (so long as management tools that add support for launching
> SEV-SNP guest update their handling of query-sev appropriately).
>
> The corresponding HMP command has also been fixed up similarly.
>
> Signed-off-by: Michael Roth <michael.roth@amd.com>
> ---
>  qapi/misc-target.json | 71 ++++++++++++++++++++++++++++++++++---------
>  target/i386/sev.c     | 50 ++++++++++++++++++++----------
>  target/i386/sev.h     |  3 ++
>  3 files changed, 94 insertions(+), 30 deletions(-)
>
> diff --git a/qapi/misc-target.json b/qapi/misc-target.json
> index 4e0a6492a9..daceb85d95 100644
> --- a/qapi/misc-target.json
> +++ b/qapi/misc-target.json
> @@ -47,6 +47,49 @@
>             'send-update', 'receive-update' ],
>    'if': 'TARGET_I386' }
>  
> +##
> +# @SevGuestType:
> +#
> +# An enumeration indicating the type of SEV guest being run.
> +#
> +# @sev:     The guest is a legacy SEV or SEV-ES guest.

Single space after ':', please.

Recommend a blank line between argument descriptions.

> +# @sev-snp: The guest is an SEV-SNP guest.
> +#
> +# Since: 6.2

The type is since 9.1, but its members become results of query-sev,
where they are since 2.12.  See also my reply to Daniel's question on
PATCH 21.

> +##
> +{ 'enum': 'SevGuestType',
> +  'data': [ 'sev', 'sev-snp' ],
> +  'if': 'TARGET_I386' }
> +
> +##
> +# @SevGuestInfo:
> +#
> +# Information specific to legacy SEV/SEV-ES guests.
> +#
> +# @policy: SEV policy value

I know you're just moving existing documentation.  Still: this is rather
sparse.  Where would I find what numbers to pass for @policy?

> +#
> +# @handle: SEV firmware handle
> +#
> +# Since: 2.12
> +##
> +{ 'struct': 'SevGuestInfo',
> +  'data': { 'policy': 'uint32',
> +            'handle': 'uint32' },
> +  'if': 'TARGET_I386' }
> +
> +##
> +# @SevSnpGuestInfo:
> +#
> +# Information specific to SEV-SNP guests.
> +#
> +# @snp-policy: SEV-SNP policy value

Same question.

> +#
> +# Since: 6.2

9.1

> +##
> +{ 'struct': 'SevSnpGuestInfo',
> +  'data': { 'snp-policy': 'uint64' },
> +  'if': 'TARGET_I386' }
> +
>  ##
>  # @SevInfo:
>  #
> @@ -60,25 +103,25 @@
>  #
>  # @build-id: SEV FW build id
>  #
> -# @policy: SEV policy value
> -#
>  # @state: SEV guest state
>  #
> -# @handle: SEV firmware handle
> +# @sev-type: Type of SEV guest being run
>  #
>  # Since: 2.12
>  ##
> -{ 'struct': 'SevInfo',
> -    'data': { 'enabled': 'bool',
> -              'api-major': 'uint8',
> -              'api-minor' : 'uint8',
> -              'build-id' : 'uint8',
> -              'policy' : 'uint32',
> -              'state' : 'SevState',
> -              'handle' : 'uint32'
> -            },
> -  'if': 'TARGET_I386'
> -}
> +{ 'union': 'SevInfo',
> +  'base': { 'enabled': 'bool',
> +            'api-major': 'uint8',
> +            'api-minor' : 'uint8',
> +            'build-id' : 'uint8',
> +            'state' : 'SevState',
> +            'sev-type' : 'SevGuestType' },
> +  'discriminator': 'sev-type',
> +  'data': {
> +      'sev': 'SevGuestInfo',
> +      'sev-snp': 'SevSnpGuestInfo' },
> +  'if': 'TARGET_I386' }
> +
>  
>  ##
>  # @query-sev:

[...]


