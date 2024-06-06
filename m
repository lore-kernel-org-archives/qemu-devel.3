Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B04CC25B75
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 10:47:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFAdo-000126-J1; Thu, 06 Jun 2024 06:46:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sFAdn-00010y-6w
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 06:46:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sFAdj-00049z-B8
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 06:46:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717670797;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=Z02w6vpeSlYet3Lg2fTxmHRdAKpGVKBtnEn3Bwk9ZiE=;
 b=Qu4wJ3ix6ZlsPLBXg+5w8yDM1VTUNtBWe6jx/Tc7yGx46PkQDtqYrWLWQQd+J0F9NkCtN0
 mKTfpBrOZnksUzEtlOmaelNtPTzaZv6FxLAxUigFxgM2xbQUuBDb+drOBK7HJ/ouEa/8Yv
 NkDTYne0rPMk/Ux9Z6EW4WDB9qsmdBc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-213-DBQ6n8jrPbuQUkc46zKpmw-1; Thu,
 06 Jun 2024 06:46:32 -0400
X-MC-Unique: DBQ6n8jrPbuQUkc46zKpmw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8364029AA387;
 Thu,  6 Jun 2024 10:46:31 +0000 (UTC)
Received: from redhat.com (unknown [10.39.193.201])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E6E80201F3E5;
 Thu,  6 Jun 2024 10:46:25 +0000 (UTC)
Date: Thu, 6 Jun 2024 11:45:48 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, Peter Xu <peterx@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org,
 qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>,
 Claudio Fontana <cfontana@suse.de>, Gerd Hoffmann <kraxel@redhat.com>,
 Isaku Yamahata <isaku.yamahata@gmail.com>,
 Chenyi Qiang <chenyi.qiang@intel.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: Re: [PATCH v5 25/65] i386/tdx: Add property sept-ve-disable for
 tdx-guest object
Message-ID: <ZmGTXP36B76IRalJ@redhat.com>
References: <20240229063726.610065-1-xiaoyao.li@intel.com>
 <20240229063726.610065-26-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240229063726.610065-26-xiaoyao.li@intel.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Copying  Zhenzhong Duan as my point relates to the proposed libvirt
TDX patches.

On Thu, Feb 29, 2024 at 01:36:46AM -0500, Xiaoyao Li wrote:
> Bit 28 of TD attribute, named SEPT_VE_DISABLE. When set to 1, it disables
> EPT violation conversion to #VE on guest TD access of PENDING pages.
> 
> Some guest OS (e.g., Linux TD guest) may require this bit as 1.
> Otherwise refuse to boot.
> 
> Add sept-ve-disable property for tdx-guest object, for user to configure
> this bit.
> 
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Acked-by: Gerd Hoffmann <kraxel@redhat.com>
> Acked-by: Markus Armbruster <armbru@redhat.com>
> ---
> Changes in v4:
> - collect Acked-by from Markus
> 
> Changes in v3:
> - update the comment of property @sept-ve-disable to make it more
>   descriptive and use new format. (Daniel and Markus)
> ---
>  qapi/qom.json         |  7 ++++++-
>  target/i386/kvm/tdx.c | 24 ++++++++++++++++++++++++
>  2 files changed, 30 insertions(+), 1 deletion(-)
> 
> diff --git a/qapi/qom.json b/qapi/qom.json
> index 220cc6c98d4b..89ed89b9b46e 100644
> --- a/qapi/qom.json
> +++ b/qapi/qom.json
> @@ -900,10 +900,15 @@
>  #
>  # Properties for tdx-guest objects.
>  #
> +# @sept-ve-disable: toggle bit 28 of TD attributes to control disabling
> +#     of EPT violation conversion to #VE on guest TD access of PENDING
> +#     pages.  Some guest OS (e.g., Linux TD guest) may require this to
> +#     be set, otherwise they refuse to boot.
> +#
>  # Since: 9.0
>  ##
>  { 'struct': 'TdxGuestProperties',
> -  'data': { }}
> +  'data': { '*sept-ve-disable': 'bool' } }

So this exposes a single boolean property that gets mapped into one
specific bit in the TD attributes:

> +
> +static void tdx_guest_set_sept_ve_disable(Object *obj, bool value, Error **errp)
> +{
> +    TdxGuest *tdx = TDX_GUEST(obj);
> +
> +    if (value) {
> +        tdx->attributes |= TDX_TD_ATTRIBUTES_SEPT_VE_DISABLE;
> +    } else {
> +        tdx->attributes &= ~TDX_TD_ATTRIBUTES_SEPT_VE_DISABLE;
> +    }
> +}

If I look at the documentation for TD attributes

  https://download.01.org/intel-sgx/latest/dcap-latest/linux/docs/Intel_TDX_DCAP_Quoting_Library_API.pdf

Section "A.3.4. TD Attributes"

I see "TD attributes" is a 64-bit int, with 5 bits currently
defined "DEBUG", "SEPT_VE_DISABLE", "PKS", "PL", "PERFMON",
and the rest currently reserved for future use. This makes me
wonder about our modelling approach into the future ?

For the AMD SEV equivalent we've just directly exposed the whole
field as an int:

     'policy' : 'uint32',

For the proposed SEV-SNP patches, the same has been done again

https://lists.nongnu.org/archive/html/qemu-devel/2024-06/msg00536.html

     '*policy': 'uint64',


The advantage of exposing individual booleans is that it is
self-documenting at the QAPI level, but the disadvantage is
that every time we want to expose ability to control a new
bit in the policy we have to modify QEMU, libvirt, the mgmt
app above libvirt, and whatever tools the end user has to
talk to the mgmt app.

If we expose a policy int, then newly defined bits only require
a change in QEMU, and everything above QEMU will already be
capable of setting it.

In fact if I look at the proposed libvirt patches, they have
proposed just exposing a policy "int" field in the XML, which
then has to be unpacked to set the individual QAPI booleans

  https://lists.libvirt.org/archives/list/devel@lists.libvirt.org/message/WXWXEESYUA77DP7YIBP55T2OPSVKV5QW/

On balance, I think it would be better if QEMU just exposed
the raw TD attributes policy as an uint64 at QAPI, instead
of trying to unpack it to discrete bool fields. This gives
consistency with SEV and SEV-SNP, and with what's proposed
at the libvirt level, and minimizes future changes when
more policy bits are defined.

> +
>  /* tdx guest */
>  OBJECT_DEFINE_TYPE_WITH_INTERFACES(TdxGuest,
>                                     tdx_guest,
> @@ -529,6 +549,10 @@ static void tdx_guest_init(Object *obj)
>      qemu_mutex_init(&tdx->lock);
>  
>      tdx->attributes = 0;
> +
> +    object_property_add_bool(obj, "sept-ve-disable",
> +                             tdx_guest_get_sept_ve_disable,
> +                             tdx_guest_set_sept_ve_disable);
>  }
>  
>  static void tdx_guest_finalize(Object *obj)
> -- 
> 2.34.1
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


