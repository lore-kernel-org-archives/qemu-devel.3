Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73E40C48BC3
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 12:35:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rc2rF-0000sJ-M4; Mon, 19 Feb 2024 07:34:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rc2r7-0000rM-Kk
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 07:34:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rc2r6-0004lz-0C
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 07:34:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708346083;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=i1xFjzrx1FsNyRKzs2KQj6cKvo6mP0Et2w5wO8f+wKY=;
 b=iafozKAzr3GFZ9Q7hKZVSOfly1jfYsYSBF31UaIlmwMrhM3ywNvdxQrzquvchOZbOY3s1t
 6Tf4qJdZOgW8J25TJy6lF0g+wsMsEd/BDZ9SNN8/oSmZDzCgJaxOT18kFmOe9Hpez9RLsV
 1ng03dfUcyABxwnNpgKzWuWrTmQJVv0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-466-FbnK2GDEOG64yZwe4j2Z-g-1; Mon, 19 Feb 2024 07:34:39 -0500
X-MC-Unique: FbnK2GDEOG64yZwe4j2Z-g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8F5F6863065;
 Mon, 19 Feb 2024 12:34:38 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 66DBC112131D;
 Mon, 19 Feb 2024 12:34:38 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 697D821E6740; Mon, 19 Feb 2024 13:34:37 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,  David Hildenbrand
 <david@redhat.com>,  Igor Mammedov <imammedo@redhat.com>,  "Michael S .
 Tsirkin" <mst@redhat.com>,  Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,  Peter Xu
 <peterx@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Eric Blake <eblake@redhat.com>,  Marcelo Tosatti
 <mtosatti@redhat.com>,  qemu-devel@nongnu.org,  kvm@vger.kernel.org,
 Michael Roth <michael.roth@amd.com>,  Sean Christopherson
 <seanjc@google.com>,  Claudio Fontana <cfontana@suse.de>,  Gerd Hoffmann
 <kraxel@redhat.com>,  Isaku Yamahata <isaku.yamahata@gmail.com>,  Chenyi
 Qiang <chenyi.qiang@intel.com>
Subject: Re: [PATCH v4 11/66] i386: Introduce tdx-guest object
In-Reply-To: <20240125032328.2522472-12-xiaoyao.li@intel.com> (Xiaoyao Li's
 message of "Wed, 24 Jan 2024 22:22:33 -0500")
References: <20240125032328.2522472-1-xiaoyao.li@intel.com>
 <20240125032328.2522472-12-xiaoyao.li@intel.com>
Date: Mon, 19 Feb 2024 13:34:37 +0100
Message-ID: <87a5nwfx9e.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.072,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Xiaoyao Li <xiaoyao.li@intel.com> writes:

> Introduce tdx-guest object which implements the interface of
> CONFIDENTIAL_GUEST_SUPPORT, and will be used to create TDX VMs (TDs) by
>
>   qemu -machine ...,confidential-guest-support=tdx0	\
>        -object tdx-guest,id=tdx0
>
> It has only one member 'attributes' with fixed value 0 and not
> configurable so far.

Really?  Can't see it.

Suggest to add something like "Configuration properties will be added
later in this series."

> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Acked-by: Gerd Hoffmann <kraxel@redhat.com>
> Acked-by: Markus Armbruster <armbru@redhat.com>

[...]

> diff --git a/qapi/qom.json b/qapi/qom.json
> index 95516ba325e5..5b3c3146947f 100644
> --- a/qapi/qom.json
> +++ b/qapi/qom.json
> @@ -895,6 +895,16 @@
>              'reduced-phys-bits': 'uint32',
>              '*kernel-hashes': 'bool' } }
>  
> +##
> +# @TdxGuestProperties:
> +#
> +# Properties for tdx-guest objects.
> +#
> +# Since: 9.0
> +##
> +{ 'struct': 'TdxGuestProperties',
> +  'data': { }}
> +
>  ##
>  # @ThreadContextProperties:
>  #
> @@ -974,6 +984,7 @@
>      'sev-guest',
>      'thread-context',
>      's390-pv-guest',
> +    'tdx-guest',
>      'throttle-group',
>      'tls-creds-anon',
>      'tls-creds-psk',
> @@ -1041,6 +1052,7 @@
>        'secret_keyring':             { 'type': 'SecretKeyringProperties',
>                                        'if': 'CONFIG_SECRET_KEYRING' },
>        'sev-guest':                  'SevGuestProperties',
> +      'tdx-guest':                  'TdxGuestProperties',
>        'thread-context':             'ThreadContextProperties',
>        'throttle-group':             'ThrottleGroupProperties',
>        'tls-creds-anon':             'TlsCredsAnonProperties',

[...]


