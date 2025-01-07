Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 568BFE77198
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 14:13:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVAJt-0004jK-D8; Tue, 07 Jan 2025 09:12:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tVAJr-0004j9-Qo
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 09:12:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tVAJq-0001uk-55
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 09:12:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736259147;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YT6oXZ7QyPsHVz8vhsMDbMijQzr8eCs6M8NB/JB/gP8=;
 b=AJR6/3LWyo8BvXRrJDPwsjr5X45P4b3gbzqb3UcYM+l4/FiKfWDayhyop/qbl6xOWV3ktR
 Rygxv0RtQUwJyvqC8Xg7in7Q54M/FTGhaTf1AwwDO89pX9O8FO9ve4nAafNcTm5vlBxwGd
 jkY0kROP87EWIoJNeqAA8O0CjTHd0tM=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-394-KjCCjSvJN4mhB9P_nSsAXw-1; Tue,
 07 Jan 2025 09:12:24 -0500
X-MC-Unique: KjCCjSvJN4mhB9P_nSsAXw-1
X-Mimecast-MFC-AGG-ID: KjCCjSvJN4mhB9P_nSsAXw
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9F01719776A2; Tue,  7 Jan 2025 14:12:12 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.194.101])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4363A3000706; Tue,  7 Jan 2025 14:12:12 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id EA25321E6924; Tue, 07 Jan 2025 15:12:09 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: qemu-devel@nongnu.org,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>, Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH v11 1/2] tpm: convert tpmdev options processing to new
 visitor format
In-Reply-To: <20241212170528.30364-2-James.Bottomley@HansenPartnership.com>
 (James Bottomley's message of "Thu, 12 Dec 2024 12:05:27 -0500")
References: <20241212170528.30364-1-James.Bottomley@HansenPartnership.com>
 <20241212170528.30364-2-James.Bottomley@HansenPartnership.com>
Date: Tue, 07 Jan 2025 15:12:09 +0100
Message-ID: <87y0zm90hy.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.437,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
> index a16a72edb9..e6345d424b 100644
> --- a/qapi/tpm.json
> +++ b/qapi/tpm.json

Looks like you missed my review of v10.  I'll copy it below for your
convenience.

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

10.0

> +##
> +{ 'union': 'TpmCreateOptions',
> +  'base': { 'type': 'TpmType',
> +            'id' : 'str' },
> +  'discriminator': 'type',
> +  'data': { 'passthrough' : 'TPMPassthroughOptions',
> +            'emulator': 'TPMEmulatorOptions' },
> +  'if': 'CONFIG_TPM' }

This is a flattened version of TpmTypeOptions with additional member
@id.

Flattened: the union branches use Foo instead of FooWrapper.

@id: I guess query-tpm has it one level up, in TPMInfo.

Okay.

> +
>  ##
>  # @TPMInfo:
>  #

[...]


