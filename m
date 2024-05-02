Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA0CAC25B10
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 08:36:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2RvE-0006NS-8E; Thu, 02 May 2024 04:36:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1s2RvC-0006Mz-Bw
 for qemu-devel@nongnu.org; Thu, 02 May 2024 04:36:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1s2Rv9-0003eQ-Nx
 for qemu-devel@nongnu.org; Thu, 02 May 2024 04:36:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714638962;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mqAhxicxksET7XeX1SBGmkK553H3lWnTjKCamVjFZn8=;
 b=cqEOffTbZ4SYg3lDClHV1IlB2oXawiuedP0gQfC/nfjudtpavcff/eRdR/Y49C6dJJ9uYW
 9exWThc/xt2wFLEzq/7QtnVhHuVVroSV36UHWsNi3uhHSibXnflCJX6paWwlUcwhqlj1Av
 qEeWlGW/4UXLFyli62MygvVhd8ORk9Q=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-128-OSvBLYNsNuqzoJefzDVDEw-1; Thu, 02 May 2024 04:35:57 -0400
X-MC-Unique: OSvBLYNsNuqzoJefzDVDEw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 27CAA810431;
 Thu,  2 May 2024 08:35:57 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.247])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0622C2166B31;
 Thu,  2 May 2024 08:35:56 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1287321E6811; Thu,  2 May 2024 10:35:56 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: qemu-devel@nongnu.org,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>, Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH v10 1/2] tpm: convert tpmdev options processing to new
 visitor format
In-Reply-To: <20240430190855.2811-2-James.Bottomley@HansenPartnership.com>
 (James Bottomley's message of "Tue, 30 Apr 2024 15:08:54 -0400")
References: <20240430190855.2811-1-James.Bottomley@HansenPartnership.com>
 <20240430190855.2811-2-James.Bottomley@HansenPartnership.com>
Date: Thu, 02 May 2024 10:35:56 +0200
Message-ID: <87sez0pq4z.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.897,
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

James Bottomley <James.Bottomley@HansenPartnership.com> writes:

> Instead of processing the tpmdev options using the old qemu options,
> convert to the new visitor format which also allows the passing of
> json on the command line.
>
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> Tested-by: Stefan Berger <stefanb@linux.ibm.com>
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>

[...]

> diff --git a/qapi/tpm.json b/qapi/tpm.json
> index 1577b5c259..5604553b7d 100644
> --- a/qapi/tpm.json
> +++ b/qapi/tpm.json
> @@ -142,6 +142,27 @@
>              'emulator': 'TPMEmulatorOptionsWrapper' },
>    'if': 'CONFIG_TPM' }
>  
> +##
> +# @TpmCreateOptions:
> +#
> +# A union referencing different TPM backend types' configuration options
> +#   without the wrapper to be usable by visitors.

reST trap: this is a definition list.  Delete the second line's
indentation to make it a paragraph:

   # A union referencing different TPM backend types' configuration
   # options without the wrapper to be usable by visitors.


> +#
> +# @type: - 'passthrough' The configuration options for the TPM passthrough type
> +#        - 'emulator' The configuration options for TPM emulator backend type

docs/devel/qapi-code-gen.rst:

    Descriptions start with '\@name:'.  The description text must be
    indented like this::

     # @name: Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed
     #     do eiusmod tempor incididunt ut labore et dolore magna aliqua.

You indent more to make the '-' line up.  Hmm.

Let's indent this like @TpmTypeOptions right above, namely

    # @type:
    #     - 'passthrough' The configuration options for the TPM
    #       passthrough type
    #     - 'emulator' The configuration options for TPM emulator backend
    #       type

> +#
> +# @id: The Id of the TPM

What kind of Id is this?

> +#
> +# Since: 9.0

9.1

> +##
> +{ 'union': 'TpmCreateOptions',
> +  'base': { 'type': 'TpmType',
> +            'id' : 'str' },
> +  'discriminator': 'type',
> +  'data': { 'passthrough' : 'TPMPassthroughOptions',
> +            'emulator': 'TPMEmulatorOptions' },
> +  'if': 'CONFIG_TPM' }
> +

This is a flattened version of TpmTypeOptions with additional member
@id.

Flattened: the union branches use Foo instead of FooWrapper.

@id: Iguess query-tpm has it one level up, in TPMInfo.

Okay.

>  ##
>  # @TPMInfo:
>  #

[...]


