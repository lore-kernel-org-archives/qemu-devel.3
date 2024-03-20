Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60C87C54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 12:11:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmumJ-0001ep-Bg; Wed, 20 Mar 2024 08:10:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rmumA-0001aD-FL
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 08:10:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rmulu-0007HW-TK
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 08:10:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710936616;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=8PeOoDi8onYWwvP/YHpzt0z4gl9LDIT4Cjf/SoY/Aro=;
 b=JjMnmFLl4he9sDDWbhhokcam0YBuB2VQ5lZLp1h7riaFyeGHGmx/aAFWK3PKc8VXvxiEb6
 a0MSgzzXrVI/+uXuMavhnG4P1pzpuBwDc/M9Sw1eIrOVLL4zhEIpqFFbkrPGms5k+0ruO2
 Ed7j8hXd1nFnEH6xlL7+zFvWReytLwY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-446--7SzT4i6MheJDfrddV_-vA-1; Wed,
 20 Mar 2024 08:10:12 -0400
X-MC-Unique: -7SzT4i6MheJDfrddV_-vA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 89BFA380673F;
 Wed, 20 Mar 2024 12:10:11 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.205])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 35C1D2166B35;
 Wed, 20 Mar 2024 12:10:10 +0000 (UTC)
Date: Wed, 20 Mar 2024 12:10:04 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Michael Roth <michael.roth@amd.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Tom Lendacky <thomas.lendacky@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Pankaj Gupta <pankaj.gupta@amd.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Isaku Yamahata <isaku.yamahata@linux.intel.com>
Subject: Re: [PATCH v3 31/49] i386/sev: Update query-sev QAPI format to
 handle SEV-SNP
Message-ID: <ZfrSHOWHb3qt3Ap8@redhat.com>
References: <20240320083945.991426-1-michael.roth@amd.com>
 <20240320083945.991426-32-michael.roth@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240320083945.991426-32-michael.roth@amd.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.417,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, Mar 20, 2024 at 03:39:27AM -0500, Michael Roth wrote:
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
> +# @sev-snp: The guest is an SEV-SNP guest.
> +#
> +# Since: 6.2

Now 9.1 at the earliest.

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
> +#
> +# Since: 6.2
> +##
> +{ 'struct': 'SevSnpGuestInfo',
> +  'data': { 'snp-policy': 'uint64' },
> +  'if': 'TARGET_I386' }

IMHO it can just be called 'policy' still, since
it is implicitly within a 'Snp' specific type.


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
> diff --git a/target/i386/sev.c b/target/i386/sev.c
> index 43e6c0172f..b03d70a3d1 100644
> --- a/target/i386/sev.c
> +++ b/target/i386/sev.c
> @@ -353,25 +353,27 @@ static SevInfo *sev_get_info(void)
>  {
>      SevInfo *info;
>      SevCommonState *sev_common = SEV_COMMON(MACHINE(qdev_get_machine())->cgs);
> -    SevGuestState *sev_guest =
> -        (SevGuestState *)object_dynamic_cast(OBJECT(sev_common),
> -                                             TYPE_SEV_GUEST);
>  
>      info = g_new0(SevInfo, 1);
>      info->enabled = sev_enabled();
>  
>      if (info->enabled) {
> -        if (sev_guest) {
> -            info->handle = sev_guest->handle;
> -        }
>          info->api_major = sev_common->api_major;
>          info->api_minor = sev_common->api_minor;
>          info->build_id = sev_common->build_id;
>          info->state = sev_common->state;
> -        /* we only report the lower 32-bits of policy for SNP, ok for now... */
> -        info->policy =
> -            (uint32_t)object_property_get_uint(OBJECT(sev_common),
> -                                               "policy", NULL);
> +
> +        if (sev_snp_enabled()) {
> +            info->sev_type = SEV_GUEST_TYPE_SEV_SNP;
> +            info->u.sev_snp.snp_policy =
> +                object_property_get_uint(OBJECT(sev_common), "policy", NULL);
> +        } else {
> +            info->sev_type = SEV_GUEST_TYPE_SEV;
> +            info->u.sev.handle = SEV_GUEST(sev_common)->handle;
> +            info->u.sev.policy =
> +                (uint32_t)object_property_get_uint(OBJECT(sev_common),
> +                                                   "policy", NULL);
> +        }
>      }

Ok, this is fixing the issues I reported earlier.

For 'policy' I do wonder if we really need to push it into the
type specific part of the union, as oppposed to having a common
'policy' field that is uint64 in size.

As mentioned earlier, on the wire there's no distinction between
int32/int64s, so there's no compat issues with changing it from
int32 to int64.

>  
>      return info;
> @@ -394,20 +396,36 @@ void hmp_info_sev(Monitor *mon, const QDict *qdict)
>  {
>      SevInfo *info = sev_get_info();
>  
> -    if (info && info->enabled) {
> -        monitor_printf(mon, "handle: %d\n", info->handle);
> +    if (!info || !info->enabled) {
> +        monitor_printf(mon, "SEV is not enabled\n");
> +        goto out;
> +    }
> +
> +    if (sev_snp_enabled()) {
>          monitor_printf(mon, "state: %s\n", SevState_str(info->state));
>          monitor_printf(mon, "build: %d\n", info->build_id);
>          monitor_printf(mon, "api version: %d.%d\n",
>                         info->api_major, info->api_minor);
>          monitor_printf(mon, "debug: %s\n",
> -                       info->policy & SEV_POLICY_NODBG ? "off" : "on");
> -        monitor_printf(mon, "key-sharing: %s\n",
> -                       info->policy & SEV_POLICY_NOKS ? "off" : "on");
> +                       info->u.sev_snp.snp_policy & SEV_SNP_POLICY_DBG ? "on"
> +                                                                       : "off");
> +        monitor_printf(mon, "SMT allowed: %s\n",
> +                       info->u.sev_snp.snp_policy & SEV_SNP_POLICY_SMT ? "on"
> +                                                                       : "off");
>      } else {
> -        monitor_printf(mon, "SEV is not enabled\n");
> +        monitor_printf(mon, "handle: %d\n", info->u.sev.handle);
> +        monitor_printf(mon, "state: %s\n", SevState_str(info->state));
> +        monitor_printf(mon, "build: %d\n", info->build_id);
> +        monitor_printf(mon, "api version: %d.%d\n",
> +                       info->api_major, info->api_minor);

This set of three fields is identical in both branches, so the duplication
in printing it should be eliminated.

> +        monitor_printf(mon, "debug: %s\n",
> +                       info->u.sev.policy & SEV_POLICY_NODBG ? "off" : "on");
> +        monitor_printf(mon, "key-sharing: %s\n",
> +                       info->u.sev.policy & SEV_POLICY_NOKS ? "off" : "on");
>      }
> +    monitor_printf(mon, "SEV type: %s\n", SevGuestType_str(info->sev_type));

I'd say 'SEV type' should be printed  before everything else, since
that value is the discriminator for interpreting the other data that
is printed.

>  
> +out:
>      qapi_free_SevInfo(info);
>  }

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


