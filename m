Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3902CA5FA5
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 08:09:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCBqU-0007lX-7d; Thu, 01 Oct 2026 04:08:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xCBqQ-0007kN-2z
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 04:08:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xCBqM-0000td-5S
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 04:08:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790842119;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pkY1W+RFN7VXlUGGdM/EoH5SXx0pI1gbikcJl3xWgtQ=;
 b=cu/2j57U/l2wc+XQzp89AZm767BTzwOMv6n5xqN9hby/bIC96LnYGmjogeK3fCryHJB9dY
 2AsmrBzyfOxVHjsE2juxtCBYMeDrTSNNGixf/mIjpClbrRmBN8FPMH1xgecD8rqBm22IzA
 qRNHPbvO05T9yNp+nMo+L9n+94CN/Sw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-507-kLcON1kCPYeD4BQVjiFRzg-1; Thu,
 01 Oct 2026 04:08:38 -0400
X-MC-Unique: kLcON1kCPYeD4BQVjiFRzg-1
X-Mimecast-MFC-AGG-ID: kLcON1kCPYeD4BQVjiFRzg_1790842117
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 374C9180AE16
 for <qemu-devel@nongnu.org>; Thu,  1 Oct 2026 08:08:37 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EC0C518005AE
 for <qemu-devel@nongnu.org>; Thu,  1 Oct 2026 08:08:36 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 64B3921E6A04; Thu, 01 Oct 2026 10:08:34 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Luigi Leonardi <leonardi@redhat.com>
Cc: qemu-devel@nongnu.org,  Gerd Hoffmann <kraxel@redhat.com>,  Stefano
 Garzarella <sgarzare@redhat.com>,  Ani Sinha <anisinha@redhat.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>, Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH] igvm: add command line parameter support
In-Reply-To: <20260930-igvm_command_line-v1-1-62857007d89d@redhat.com> (Luigi
 Leonardi's message of "Wed, 30 Sep 2026 16:35:07 +0200")
References: <20260930-igvm_command_line-v1-1-62857007d89d@redhat.com>
Date: Thu, 01 Oct 2026 10:08:34 +0200
Message-ID: <87qzi9alml.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Luigi Leonardi <leonardi@redhat.com> writes:

> Add a "cmdline" property to the igvm-cfg object and a handler for the
> IGVM_VHT_COMMAND_LINE directive, which copies the string into the
> parameter area the directive points at.
>
> This command line is intended for the component running at VMPL0, such
> as SVSM, rather than for the guest OS, whose own command line still
> comes from -append. SVSM can use it to select the serial port it logs
> to, for example.
>
> Signed-off-by: Luigi Leonardi <leonardi@redhat.com>

[...]

> diff --git a/qapi/qom.json b/qapi/qom.json
> index 5895c97750..d56bdef561 100644
> --- a/qapi/qom.json
> +++ b/qapi/qom.json
> @@ -1004,11 +1004,15 @@
>  #
>  # @file: IGVM file to use to configure guest
>  #
> +# @cmdline: command line for the software loaded from the IGVM file,
> +#     rather than for the guest OS.  Ignored if the IGVM file does
> +#     not ask for one.  (since 11.2)
> +#
>  # Since: 10.1
>  ##
>  { 'struct': 'IgvmCfgProperties',
>    'if': 'CONFIG_IGVM',
> -  'data': { 'file': 'str' } }
> +  'data': { 'file': 'str', '*cmdline': 'str' } }
>  
>  ##
>  # @SevCommonProperties:

How is @cmdline going to be parsed?  By a shell?

For what it's worth, MigrationExecCommand uses ['str'].  Such values can
be passed to exec()-like functions without parsing.


