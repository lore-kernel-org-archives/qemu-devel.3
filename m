Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 042E8C07C79
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2024 13:53:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ryu6E-0002Hv-4y; Mon, 22 Apr 2024 09:52:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ryu6C-0002G6-4S
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 09:52:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ryu69-0001Vt-UQ
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 09:52:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713793964;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QmRbRu/3cSgah9VfTSsATRVA9ATWppHT1+RcbuEZpdE=;
 b=eF0sTUWmHl8mxgVIv0yhrJYbBN67nhENqapVuLgPCCVBQtyechrRIhGS4JXiXDVeK/yVcK
 UPQiNTT7/g/ol/muisASG2QEe+4jJDKlJq+BTYWxtW8fWdCjsw6V+Kj8M+1JKV+Z5/7zij
 5cJID2O1GF6X3CuZ8GibejH6ysCq53o=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-33-aEDcwoNEPI-ZoEf8kCoiNQ-1; Mon, 22 Apr 2024 09:52:38 -0400
X-MC-Unique: aEDcwoNEPI-ZoEf8kCoiNQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4AA7981B5AF;
 Mon, 22 Apr 2024 13:52:33 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.247])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EE567492BC6;
 Mon, 22 Apr 2024 13:52:32 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id DEBF021E6811; Mon, 22 Apr 2024 15:52:31 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Michael Roth <michael.roth@amd.com>
Cc: <qemu-devel@nongnu.org>,  <kvm@vger.kernel.org>,  Tom Lendacky
 <thomas.lendacky@amd.com>,  "Paolo Bonzini" <pbonzini@redhat.com>,  Daniel
 P . =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Pankaj Gupta
 <pankaj.gupta@amd.com>, Xiaoyao Li <xiaoyao.li@intel.com>,  Isaku Yamahata
 <isaku.yamahata@linux.intel.com>,  Brijesh Singh <brijesh.singh@amd.com>
Subject: Re: [PATCH v3 22/49] i386/sev: Introduce 'sev-snp-guest' object
In-Reply-To: <20240320083945.991426-23-michael.roth@amd.com> (Michael Roth's
 message of "Wed, 20 Mar 2024 03:39:18 -0500")
References: <20240320083945.991426-1-michael.roth@amd.com>
 <20240320083945.991426-23-michael.roth@amd.com>
Date: Mon, 22 Apr 2024 15:52:31 +0200
Message-ID: <871q6xec80.fsf@pond.sub.org>
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

> From: Brijesh Singh <brijesh.singh@amd.com>
>
> SEV-SNP support relies on a different set of properties/state than the
> existing 'sev-guest' object. This patch introduces the 'sev-snp-guest'
> object, which can be used to configure an SEV-SNP guest. For example,
> a default-configured SEV-SNP guest with no additional information
> passed in for use with attestation:
>
>   -object sev-snp-guest,id=sev0
>
> or a fully-specified SEV-SNP guest where all spec-defined binary
> blobs are passed in as base64-encoded strings:
>
>   -object sev-snp-guest,id=sev0, \
>     policy=0x30000, \
>     init-flags=0, \
>     id-block=YWFhYWFhYWFhYWFhYWFhCg==, \
>     id-auth=CxHK/OKLkXGn/KpAC7Wl1FSiisWDbGTEKz..., \
>     auth-key-enabled=on, \
>     host-data=LNkCWBRC5CcdGXirbNUV1OrsR28s..., \
>     guest-visible-workarounds=AA==, \
>
> See the QAPI schema updates included in this patch for more usage
> details.
>
> In some cases these blobs may be up to 4096 characters, but this is
> generally well below the default limit for linux hosts where
> command-line sizes are defined by the sysconf-configurable ARG_MAX
> value, which defaults to 2097152 characters for Ubuntu hosts, for
> example.
>
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> Co-developed-by: Michael Roth <michael.roth@amd.com>
> Acked-by: Markus Armbruster <armbru@redhat.com> (for QAPI schema)
> Signed-off-by: Michael Roth <michael.roth@amd.com>

[...]

> diff --git a/qapi/qom.json b/qapi/qom.json
> index 66b5781ca6..b25a3043da 100644
> --- a/qapi/qom.json
> +++ b/qapi/qom.json
> @@ -920,6 +920,55 @@
>              '*handle': 'uint32',
>              '*kernel-hashes': 'bool' } }
>  
> +##
> +# @SevSnpGuestProperties:
> +#
> +# Properties for sev-snp-guest objects. Most of these are direct arguments
> +# for the KVM_SNP_* interfaces documented in the linux kernel source

"Linux", please.

> +# under Documentation/virt/kvm/amd-memory-encryption.rst, which are in

Does not seem to exist.  Do you mean
Documentation/arch/x86/amd-memory-encryption.rst?

> +# turn closely coupled with the SNP_INIT/SNP_LAUNCH_* firmware commands
> +# documented in the SEV-SNP Firmware ABI Specification (Rev 0.9).

docs/devel/qapi-code-gen.rst:

    For legibility, wrap text paragraphs so every line is at most 70
    characters long.

    Separate sentences with two spaces.

> +#
> +# More usage information is also available in the QEMU source tree under
> +# docs/amd-memory-encryption.
> +#
> +# @policy: the 'POLICY' parameter to the SNP_LAUNCH_START command, as
> +#          defined in the SEV-SNP firmware ABI (default: 0x30000)

docs/devel/qapi-code-gen.rst:

    Descriptions start with '\@name:'.  The description text must be
    indented like this::

     # @name: Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed
     #     do eiusmod tempor incididunt ut labore et dolore magna aliqua.

> +#
> +# @guest-visible-workarounds: 16-byte, base64-encoded blob to report
> +#                             hypervisor-defined workarounds, corresponding
> +#                             to the 'GOSVW' parameter of the
> +#                             SNP_LAUNCH_START command defined in the
> +#                             SEV-SNP firmware ABI (default: all-zero)
> +#
> +# @id-block: 96-byte, base64-encoded blob to provide the 'ID Block'
> +#            structure for the SNP_LAUNCH_FINISH command defined in the
> +#            SEV-SNP firmware ABI (default: all-zero)
> +#
> +# @id-auth: 4096-byte, base64-encoded blob to provide the 'ID Authentication
> +#           Information Structure' for the SNP_LAUNCH_FINISH command defined
> +#           in the SEV-SNP firmware ABI (default: all-zero)
> +#
> +# @auth-key-enabled: true if 'id-auth' blob contains the 'AUTHOR_KEY' field
> +#                    defined SEV-SNP firmware ABI (default: false)
> +#
> +# @host-data: 32-byte, base64-encoded, user-defined blob to provide to the
> +#             guest, as documented for the 'HOST_DATA' parameter of the
> +#             SNP_LAUNCH_FINISH command in the SEV-SNP firmware ABI
> +#             (default: all-zero)
> +#
> +# Since: 7.2

9.1

> +##

Together:

    ##
    # @SevSnpGuestProperties:
    #
    # Properties for sev-snp-guest objects.  Most of these are direct
    # arguments for the KVM_SNP_* interfaces documented in the Linux
    # kernel source under
    # Documentation/arch/x86/amd-memory-encryption.rst, which are in turn
    # closely coupled with the SNP_INIT/SNP_LAUNCH_* firmware commands
    # documented in the SEV-SNP Firmware ABI Specification (Rev 0.9).
    #
    # More usage information is also available in the QEMU source tree
    # under docs/amd-memory-encryption.
    #
    # @policy: the 'POLICY' parameter to the SNP_LAUNCH_START command, as
    #     defined in the SEV-SNP firmware ABI (default: 0x30000)
    #
    # @guest-visible-workarounds: 16-byte, base64-encoded blob to report
    #     hypervisor-defined workarounds, corresponding to the 'GOSVW'
    #     parameter of the SNP_LAUNCH_START command defined in the SEV-SNP
    #     firmware ABI (default: all-zero)
    #
    # @id-block: 96-byte, base64-encoded blob to provide the 'ID Block'
    #     structure for the SNP_LAUNCH_FINISH command defined in the
    #     SEV-SNP firmware ABI (default: all-zero)
    #
    # @id-auth: 4096-byte, base64-encoded blob to provide the 'ID
    #     Authentication Information Structure' for the SNP_LAUNCH_FINISH
    #     command defined in the SEV-SNP firmware ABI (default: all-zero)
    #
    # @auth-key-enabled: true if 'id-auth' blob contains the 'AUTHOR_KEY'
    #     field defined SEV-SNP firmware ABI (default: false)
    #
    # @host-data: 32-byte, base64-encoded, user-defined blob to provide to
    #     the guest, as documented for the 'HOST_DATA' parameter of the
    #     SNP_LAUNCH_FINISH command in the SEV-SNP firmware ABI (default:
    #     all-zero)
    #
    # @certs-path: path to certificate data that can be passed to guests
    #     via SNP Extended Guest Requests.  File should be in the format
    #     described in the GHCB specification.  (default: none)
    #
    # Since: 9.1
    ##

We generally prefer symbolic to numeric / binary encoding in QMP.  Can
you explain briefly why you choose numeric and binary here?

> +{ 'struct': 'SevSnpGuestProperties',
> +  'base': 'SevCommonProperties',
> +  'data': {
> +            '*policy': 'uint64',
> +            '*guest-visible-workarounds': 'str',
> +            '*id-block': 'str',
> +            '*id-auth': 'str',
> +            '*auth-key-enabled': 'bool',
> +            '*host-data': 'str' } }
> +
>  ##
>  # @ThreadContextProperties:
>  #
> @@ -998,6 +1047,7 @@
>      { 'name': 'secret_keyring',
>        'if': 'CONFIG_SECRET_KEYRING' },
>      'sev-guest',
> +    'sev-snp-guest',
>      'thread-context',
>      's390-pv-guest',
>      'throttle-group',
> @@ -1068,6 +1118,7 @@
>        'secret_keyring':             { 'type': 'SecretKeyringProperties',
>                                        'if': 'CONFIG_SECRET_KEYRING' },
>        'sev-guest':                  'SevGuestProperties',
> +      'sev-snp-guest':              'SevSnpGuestProperties',
>        'thread-context':             'ThreadContextProperties',
>        'throttle-group':             'ThrottleGroupProperties',
>        'tls-creds-anon':             'TlsCredsAnonProperties',

[...]


