Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17494CA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 09:35:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xENpt-0001Rb-6H; Wed, 07 Oct 2026 05:21:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xEMp9-0003sz-4I
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 04:16:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xEMp6-0004FT-SO
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 04:16:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791360983;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yKZCGlkeK0jSz6ABLwhVKIXKedX+ZEFxfYug5miMP5U=;
 b=Dyf3N1wECnCWr7OmruulHEj0sWpxat3vYflobjUH3N7j59gqhatGaEeEyPdMpPegBgWmsb
 i4NhUvANWjBhHLRpQ5o6jqTfs0cXZS4WDZSM81kJhqMwWvp0Q7kwCIb8OCc3R7sK7bYwAf
 PMZXCYAkWyLtmCugdUi8IRH3ISuQ1Pg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-344-zwafXP4wPmaMclLU2UFYzQ-1; Wed,
 07 Oct 2026 04:16:22 -0400
X-MC-Unique: zwafXP4wPmaMclLU2UFYzQ-1
X-Mimecast-MFC-AGG-ID: zwafXP4wPmaMclLU2UFYzQ_1791360981
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D31B319792DE; Wed,  7 Oct 2026 08:16:20 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8B3301956095; Wed,  7 Oct 2026 08:16:20 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2688F21E6A04; Wed, 07 Oct 2026 10:16:18 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,  Kevin Wolf
 <kwolf@redhat.com>,  Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH v2 03/11] qemu-option: Remove short form options support
In-Reply-To: <20260930221105.2262063-4-farosas@suse.de> (Fabiano Rosas's
 message of "Wed, 30 Sep 2026 19:10:57 -0300")
References: <20260930221105.2262063-1-farosas@suse.de>
 <20260930221105.2262063-4-farosas@suse.de>
Date: Wed, 07 Oct 2026 10:16:18 +0200
Message-ID: <877bjuapt9.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
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

Fabiano Rosas <farosas@suse.de> writes:

> Option parameters without a value (i.e. key vs. key=val) are
> deprecated. The missing value is currently implied to be either "on"
> or "off" depending on whether the parameter name starts with "no".
>
> Remove the implied behavior and start rejecting option parameters
> without values by emitting the error message:
>
>  "Parameter 'foo' without a value."

[...]

> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index ccbc421949..f54905eba9 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -30,19 +30,6 @@ deprecated.
>  System emulator command line arguments
>  --------------------------------------
>  
> -Short-form boolean options (since 6.0)
> -''''''''''''''''''''''''''''''''''''''
> -
> -Boolean options such as ``share=on``/``share=off`` could be written
> -in short form as ``share`` and ``noshare``.  This is now deprecated
> -and will cause a warning.
> -
> -``delay`` option for socket character devices (since 6.0)
> -'''''''''''''''''''''''''''''''''''''''''''''''''''''''''
> -
> -The replacement for the ``nodelay`` short-form boolean option is ``nodelay=on``
> -rather than ``delay=off``.
> -
>  Plugin argument passing through ``arg=<string>`` (since 6.1)
>  ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
> 

No docs/about/removed-features.rst update?

[...]


