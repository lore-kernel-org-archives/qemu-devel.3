Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B56C3C25B5C
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 12:25:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2VTs-0003A5-ON; Thu, 02 May 2024 08:24:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1s2VTl-00038s-Cz
 for qemu-devel@nongnu.org; Thu, 02 May 2024 08:24:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1s2VTg-0002iM-Gk
 for qemu-devel@nongnu.org; Thu, 02 May 2024 08:24:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714652635;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=30A6CtrWUvckYRSxS1S8p28SL81PqqfbP2H+zFEpKmU=;
 b=gKuA6xNc0HdVb4aywGviEGWbLR2ML8r7xXr6A6PLCr1sY+Ptvn6NFJZS9sHBcHKoLa5LVS
 UN8gkVlozucBcI4BwInrP4aj63cOy3YMu5rU/GYNRiBdb43hWhPoHJkxyaAgfTiukSYgjr
 MK9fupU295CaRg7hMf7n7DuutBDBFok=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-306-xyWNNgC4PMKQLr-BfONWGg-1; Thu, 02 May 2024 08:23:51 -0400
X-MC-Unique: xyWNNgC4PMKQLr-BfONWGg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C9115800935;
 Thu,  2 May 2024 12:23:50 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.247])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A33FC1000628;
 Thu,  2 May 2024 12:23:50 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C256B21E66E5; Thu,  2 May 2024 14:23:49 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>,  Fabiano Rosas
 <farosas@suse.de>,  David Hildenbrand <david@redhat.com>,  Igor Mammedov
 <imammedo@redhat.com>,  Eduardo Habkost <eduardo@habkost.net>,  Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>,  Philippe Mathieu-Daude
 <philmd@linaro.org>,  Paolo Bonzini <pbonzini@redhat.com>,  "Daniel P.
 Berrange" <berrange@redhat.com>
Subject: Re: [PATCH V1 18/26] migration: cpr-exec-args parameter
In-Reply-To: <1714406135-451286-19-git-send-email-steven.sistare@oracle.com>
 (Steve Sistare's message of "Mon, 29 Apr 2024 08:55:27 -0700")
References: <1714406135-451286-1-git-send-email-steven.sistare@oracle.com>
 <1714406135-451286-19-git-send-email-steven.sistare@oracle.com>
Date: Thu, 02 May 2024 14:23:49 +0200
Message-ID: <87cyq4767e.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.476,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Steve Sistare <steven.sistare@oracle.com> writes:

> Create the cpr-exec-args migration parameter, defined as a list of
> strings.  It will be used for cpr-exec migration mode in a subsequent
> patch.
>
> No functional change, except that cpr-exec-args is shown by the
> 'info migrate' command.
>
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>

[...]

> diff --git a/qapi/migration.json b/qapi/migration.json
> index 8c65b90..49710e7 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -914,6 +914,9 @@
>  #     See description in @ZeroPageDetection.  Default is 'multifd'.
>  #     (since 9.0)
>  #
> +# @cpr-exec-args: Arguments passed to new QEMU for @cpr-exec mode.
> +#    See @cpr-exec for details.  (Since 9.1)
> +#

You mean migration mode @cpr-exec, don't you?

If yes, dangling reference until PATCH 20 adds it.  Okay, but worth a
mention in the commit message.

Suggest "See MigMode @cpr-exec for details."

>  # Features:
>  #
>  # @deprecated: Member @block-incremental is deprecated.  Use
> @@ -948,7 +951,8 @@
>             { 'name': 'x-vcpu-dirty-limit-period', 'features': ['unstable'] },
>             'vcpu-dirty-limit',
>             'mode',
> -           'zero-page-detection'] }
> +           'zero-page-detection',
> +           'cpr-exec-args'] }
>  
>  ##
>  # @MigrateSetParameters:
> @@ -1122,6 +1126,9 @@
>  #     See description in @ZeroPageDetection.  Default is 'multifd'.
>  #     (since 9.0)
>  #
> +# @cpr-exec-args: Arguments passed to new QEMU for @cpr-exec mode.
> +#    See @cpr-exec for details.  (Since 9.1)
> +#
>  # Features:
>  #
>  # @deprecated: Member @block-incremental is deprecated.  Use
> @@ -1176,7 +1183,8 @@
>                                              'features': [ 'unstable' ] },
>              '*vcpu-dirty-limit': 'uint64',
>              '*mode': 'MigMode',
> -            '*zero-page-detection': 'ZeroPageDetection'} }
> +            '*zero-page-detection': 'ZeroPageDetection',
> +            '*cpr-exec-args': [ 'str' ]} }
>  
>  ##
>  # @migrate-set-parameters:
> @@ -1354,6 +1362,9 @@
>  #     See description in @ZeroPageDetection.  Default is 'multifd'.
>  #     (since 9.0)
>  #
> +# @cpr-exec-args: Arguments passed to new QEMU for @cpr-exec mode.
> +#    See @cpr-exec for details.  (Since 9.1)
> +#
>  # Features:
>  #
>  # @deprecated: Member @block-incremental is deprecated.  Use
> @@ -1405,7 +1416,8 @@
>                                              'features': [ 'unstable' ] },
>              '*vcpu-dirty-limit': 'uint64',
>              '*mode': 'MigMode',
> -            '*zero-page-detection': 'ZeroPageDetection'} }
> +            '*zero-page-detection': 'ZeroPageDetection',
> +            '*cpr-exec-args': [ 'str' ]} }
>  
>  ##
>  # @query-migrate-parameters:


