Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE8ACC04FF9
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 13:39:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwisV-0001l9-Bm; Tue, 16 Apr 2024 09:29:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rwisT-0001kq-Ey
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 09:29:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rwisR-0005ES-D3
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 09:29:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713274173;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=DOzvuPk3l4UW+jQjqNwTbpPqeZwkuzPq9sWo/e7Ws+w=;
 b=iZEltRNjeH4OwLFP+rD28DXu8aqUC51bqvOyWI5e4vcj9r/+nsummoPIHWchrfR96NftQs
 nAcRMD66FFfcMTsh7jfu3Tucp9z03kTsZ1hSzUGKNvnv3Bd4QPKxH7NxJIENxoEOVrZmWm
 iF3utay6ehVeqJtubMwY4J7B+vcz1TQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-215-Y9ATW11BMAeKNhyvu8rObw-1; Tue, 16 Apr 2024 09:29:29 -0400
X-MC-Unique: Y9ATW11BMAeKNhyvu8rObw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 32E2A8011AF;
 Tue, 16 Apr 2024 13:29:29 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.173])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C3EFA492BD4;
 Tue, 16 Apr 2024 13:29:25 +0000 (UTC)
Date: Tue, 16 Apr 2024 14:29:19 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Roy Hopkins <roy.hopkins@suse.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sergio Lopez <slp@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Tom Lendacky <thomas.lendacky@amd.com>,
 Michael Roth <michael.roth@amd.com>, Ani Sinha <anisinha@redhat.com>,
 =?utf-8?B?SsO2cmc=?= Roedel <jroedel@suse.com>
Subject: Re: [PATCH v2 02/10] backends/confidential-guest-support: Add IGVM
 file parameter
Message-ID: <Zh59L_9w6gCQ_ZO_@redhat.com>
References: <cover.1712141833.git.roy.hopkins@suse.com>
 <af70dfcfeddf36d860ff28765ee30bdde2b2c110.1712141833.git.roy.hopkins@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <af70dfcfeddf36d860ff28765ee30bdde2b2c110.1712141833.git.roy.hopkins@suse.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.844,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Apr 03, 2024 at 12:11:33PM +0100, Roy Hopkins wrote:
> In order to add support for parsing IGVM files for secure virtual
> machines, a the path to an IGVM file needs to be specified as
> part of the guest configuration. It makes sense to add this to
> the ConfidentialGuestSupport object as this is common to all secure
> virtual machines that potentially could support IGVM based
> configuration.
> 
> This patch allows the filename to be configured via the QEMU
> object model in preparation for subsequent patches that will read and
> parse the IGVM file.
> 
> Signed-off-by: Roy Hopkins <roy.hopkins@suse.com>
> ---
>  backends/confidential-guest-support.c     | 21 +++++++++++++++++++++
>  include/exec/confidential-guest-support.h |  9 +++++++++
>  qapi/qom.json                             | 13 +++++++++++++
>  qemu-options.hx                           |  8 +++++++-
>  4 files changed, 50 insertions(+), 1 deletion(-)
> 
> diff --git a/backends/confidential-guest-support.c b/backends/confidential-guest-support.c
> index 052fde8db0..da436fb736 100644
> --- a/backends/confidential-guest-support.c
> +++ b/backends/confidential-guest-support.c
> @@ -20,8 +20,29 @@ OBJECT_DEFINE_ABSTRACT_TYPE(ConfidentialGuestSupport,
>                              CONFIDENTIAL_GUEST_SUPPORT,
>                              OBJECT)
>  
> +#if defined(CONFIG_IGVM)
> +static char *get_igvm(Object *obj, Error **errp)
> +{
> +    ConfidentialGuestSupport *cgs = CONFIDENTIAL_GUEST_SUPPORT(obj);
> +    return g_strdup(cgs->igvm_filename);
> +}
> +
> +static void set_igvm(Object *obj, const char *value, Error **errp)
> +{
> +    ConfidentialGuestSupport *cgs = CONFIDENTIAL_GUEST_SUPPORT(obj);
> +    g_free(cgs->igvm_filename);
> +    cgs->igvm_filename = g_strdup(value);
> +}
> +#endif
> +
>  static void confidential_guest_support_class_init(ObjectClass *oc, void *data)
>  {
> +#if defined(CONFIG_IGVM)
> +    object_class_property_add_str(oc, "igvm-file",
> +        get_igvm, set_igvm);
> +    object_class_property_set_description(oc, "igvm-file",
> +        "Set the IGVM filename to use");
> +#endif
>  }
>  
>  static void confidential_guest_support_init(Object *obj)
> diff --git a/include/exec/confidential-guest-support.h b/include/exec/confidential-guest-support.h
> index ba2dd4b5df..ec74da8877 100644
> --- a/include/exec/confidential-guest-support.h
> +++ b/include/exec/confidential-guest-support.h
> @@ -51,6 +51,15 @@ struct ConfidentialGuestSupport {
>       * so 'ready' is not set, we'll abort.
>       */
>      bool ready;
> +
> +#if defined(CONFIG_IGVM)
> +    /*
> +     * igvm_filename: Optional filename that specifies a file that contains
> +     *                the configuration of the guest in Independent Guest
> +     *                Virtual Machine (IGVM) format.
> +     */
> +    char *igvm_filename;
> +#endif
>  };
>  
>  typedef struct ConfidentialGuestSupportClass {
> diff --git a/qapi/qom.json b/qapi/qom.json
> index 85e6b4f84a..5935e1b7a6 100644
> --- a/qapi/qom.json
> +++ b/qapi/qom.json
> @@ -874,6 +874,18 @@
>    'base': 'RngProperties',
>    'data': { '*filename': 'str' } }
>  
> +##
> +# @ConfidentialGuestProperties:
> +#
> +# Properties common to objects that are derivatives of confidential-guest-support.
> +#
> +# @igvm-file: IGVM file to use to configure guest (default: none)
> +#
> +# Since: 9.1
> +##
> +{ 'struct': 'ConfidentialGuestProperties',
> +  'data': { '*igvm-file': 'str' } }

Since the rest of this patch is conditional on CONFIG_IGVM,
this property should be too, so apps can probe for whether
QEMU is built with IGVM support or not.

> +
>  ##
>  # @SevGuestProperties:
>  #
> @@ -901,6 +913,7 @@
>  # Since: 2.12
>  ##
>  { 'struct': 'SevGuestProperties',
> +  'base': 'ConfidentialGuestProperties',
>    'data': { '*sev-device': 'str',
>              '*dh-cert-file': 'str',
>              '*session-file': 'str',

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


