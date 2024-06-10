Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEBADC27C65
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2024 11:46:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGdTC-0001UD-0Z; Mon, 10 Jun 2024 07:45:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sGdTA-0001TW-QC
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 07:45:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sGdT9-0006Cv-5B
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 07:45:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718019945;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8H7+GFYWZt+fqm9LdJrMD4rXPF9PRp7Tx2xQ1dLcOwE=;
 b=VhIJMDrFSzUTSJ2L+hL3ui9Ugk1rUZSfBkjEiF9aftoajOzo6ful49pCuTL6/lfQ2McUSW
 x5+6onBck+PjFdhJqJbRHYaTjnBZfJN+z65UCpOwPWTNMDTwY4N5gNopIKulX143TROPSX
 DAgR3uU74LyV1e53U2gLdFSAoDWtsZs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-517-kv8X1yWmOZW3CR4Uf6hZyg-1; Mon,
 10 Jun 2024 07:45:41 -0400
X-MC-Unique: kv8X1yWmOZW3CR4Uf6hZyg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 36A3B19560B4; Mon, 10 Jun 2024 11:45:39 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.93])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C24EC1956087; Mon, 10 Jun 2024 11:45:37 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 72B7B21E681D; Mon, 10 Jun 2024 13:45:35 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Gonglei <arei.gonglei@huawei.com>
Cc: <qemu-devel@nongnu.org>,  <peterx@redhat.com>,  <yu.zhang@ionos.com>,
 <mgalaxy@akamai.com>,  <elmar.gerdes@ionos.com>,
 <zhengchuan@huawei.com>,  <berrange@redhat.com>,  <armbru@redhat.com>,
 <lizhijian@fujitsu.com>,  <pbonzini@redhat.com>,  <mst@redhat.com>,
 <xiexiangyou@huawei.com>,  <linux-rdma@vger.kernel.org>,
 <lixiao91@huawei.com>,  <jinpu.wang@ionos.com>,  Jialin Wang
 <wangjialin23@huawei.com>
Subject: Re: [PATCH 1/6] migration: remove RDMA live migration temporarily
In-Reply-To: <1717503252-51884-2-git-send-email-arei.gonglei@huawei.com>
 (Gonglei's message of "Tue, 4 Jun 2024 20:14:07 +0800")
References: <1717503252-51884-1-git-send-email-arei.gonglei@huawei.com>
 <1717503252-51884-2-git-send-email-arei.gonglei@huawei.com>
Date: Mon, 10 Jun 2024 13:45:35 +0200
Message-ID: <878qzdqaw0.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Gonglei <arei.gonglei@huawei.com> writes:

> From: Jialin Wang <wangjialin23@huawei.com>
>
> The new RDMA live migration will be introduced in the upcoming
> few commits.
>
> Signed-off-by: Jialin Wang <wangjialin23@huawei.com>
> Signed-off-by: Gonglei <arei.gonglei@huawei.com>

[...]

> diff --git a/qapi/migration.json b/qapi/migration.json
> index a351fd3714..4d7d49bfec 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -210,9 +210,9 @@
>  #
>  # @setup-time: amount of setup time in milliseconds *before* the
>  #     iterations begin but *after* the QMP command is issued.  This is
> -#     designed to provide an accounting of any activities (such as
> -#     RDMA pinning) which may be expensive, but do not actually occur
> -#     during the iterative migration rounds themselves.  (since 1.6)
> +#     designed to provide an accounting of any activities which may be
> +#     expensive, but do not actually occur during the iterative migration
> +#     rounds themselves.  (since 1.6)

I guess the new RDMA migration code will not do RDMA pinning.  Correct?

>  #
>  # @cpu-throttle-percentage: percentage of time guest cpus are being
>  #     throttled during auto-converge.  This is only present when
> @@ -378,10 +378,6 @@
>  #     for certain work loads, by sending compressed difference of the
>  #     pages
>  #
> -# @rdma-pin-all: Controls whether or not the entire VM memory
> -#     footprint is mlock()'d on demand or all at once.  Refer to
> -#     docs/rdma.txt for usage.  Disabled by default.  (since 2.0)
> -#
>  # @zero-blocks: During storage migration encode blocks of zeroes
>  #     efficiently.  This essentially saves 1MB of zeroes per block on
>  #     the wire.  Enabling requires source and target VM to support
> @@ -476,7 +472,7 @@
>  # Since: 1.2
>  ##
>  { 'enum': 'MigrationCapability',
> -  'data': ['xbzrle', 'rdma-pin-all', 'auto-converge', 'zero-blocks',
> +  'data': ['xbzrle', 'auto-converge', 'zero-blocks',
>             'events', 'postcopy-ram',
>             { 'name': 'x-colo', 'features': [ 'unstable' ] },
>             'release-ram',

I guess you remove @rdma-pin-all, because it makes no sense with the new
migration code.  However, this is an incompatible change.

Here's the orderly way to remove it:

1. Document it doesn't do anything anymore, and deprecate it.

2. Remove after the deprecation grace period (two releases, see
docs/about/deprecated.rst.

> @@ -533,7 +529,6 @@
>  #     -> { "execute": "query-migrate-capabilities" }
>  #     <- { "return": [
>  #           {"state": false, "capability": "xbzrle"},
> -#           {"state": false, "capability": "rdma-pin-all"},
>  #           {"state": false, "capability": "auto-converge"},
>  #           {"state": false, "capability": "zero-blocks"},
>  #           {"state": true, "capability": "events"},

[...]


