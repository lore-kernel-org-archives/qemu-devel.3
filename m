Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0136C79FAA
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 06:30:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4Bp8-0002Nw-SI; Wed, 09 Sep 2026 02:30:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x4Bp3-0002KV-DA
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 02:30:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x4Bp1-0005Fj-3S
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 02:30:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788935412;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LC8+YbgnfxjDMTWkI2yYU7JFG1cx5/F6SPMn8GP1R3g=;
 b=YYov/ph+uSuNpbU/lIpMf7h+eso+R0ueEr5k7GY1R6aJ/ZjPRII7nr2JSJi32waqxoQTmV
 /eR8nAAUqhwpePHh981MJQvmk5IsH3moYxUyLM1NVHnZaC74Mp39y4Cpw16uqZqMyVs2OV
 59/S7d7/y3/mnA6jth8+uJEOFbgic3c=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-332-wfQRiOkkNlO55PQrgd115Q-1; Wed,
 09 Sep 2026 02:30:10 -0400
X-MC-Unique: wfQRiOkkNlO55PQrgd115Q-1
X-Mimecast-MFC-AGG-ID: wfQRiOkkNlO55PQrgd115Q_1788935409
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9AD521800741; Wed,  9 Sep 2026 06:30:08 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 19560418; Wed,  9 Sep 2026 06:30:08 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C62B121E6A04; Wed, 09 Sep 2026 08:30:05 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Michael Roth <michael.roth@amd.com>
Cc: <qemu-devel@nongnu.org>,  <kvm@vger.kernel.org>,  <pbonzini@redhat.com>,
 <berrange@redhat.com>,  <pankaj.gupta@amd.com>,
 <isaku.yamahata@intel.com>,  <xiaoyao.li@intel.com>,
 <chao.p.peng@linux.intel.com>,  <david@kernel.org>,
 <ashish.kalra@amd.com>,  <ackerleytng@google.com>, <lpieralisi@kernel.org>
Subject: Re: [PATCH v2 19/19] hostmem: Automatically select set
 guest-memfd=on for in-place conversion
In-Reply-To: <20260908205236.838281-20-michael.roth@amd.com> (Michael Roth's
 message of "Tue, 8 Sep 2026 15:48:39 -0500")
References: <20260908205236.838281-1-michael.roth@amd.com>
 <20260908205236.838281-20-michael.roth@amd.com>
Date: Wed, 09 Sep 2026 08:30:05 +0200
Message-ID: <874ifzos2a.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Michael Roth <michael.roth@amd.com> writes:

> When in-place conversion is enabled, both the shared memory and private
> memory must come from the same guest_memfd instance. Thus, the
> memory-backend-memfd options must in turn correspond to a guest_memfd
> instance, e.g. guest-memfd=on must be specified. Since there is no
> use-case for enabling in-place conversion without setting
> guest-memfd=on, just set it automatically if in-place conversion is
> enabled.
>
> Signed-off-by: Michael Roth <michael.roth@amd.com>

[...]

> diff --git a/qapi/qom.json b/qapi/qom.json
> index 20d6fefb04..32df7cb794 100644
> --- a/qapi/qom.json
> +++ b/qapi/qom.json
> @@ -772,7 +772,8 @@
>  #     resizing of the memory (default: true)
>  #
>  # @guest-memfd: if true, use guest-memfd to back the memory region.
> -#     (default: false, since: 11.2)
> +#     (default: true for Confidential VMs with in-place conversion,
> +#     false otherwise, since: 11.2)

What does "Confidential VMs with in-place conversion" mean exactly?
Which configuration settings need to be set how?

>  #
>  # Since: 2.12
>  ##
> @@ -781,7 +782,7 @@
>    'data': { '*hugetlb': 'bool',
>              '*hugetlbsize': 'size',
>              '*seal': 'bool',
> -            '*guest-memfd': 'bool' },
> +            '*guest-memfd': 'OnOffAuto' },

Valid values change from JSON true and false to JSON "on", "off", and
"auto".

If @guest-memfd was already in a release, this would be a compatibility
break, i.e. a hard "don't".  But it isn't, it's in the series this is
one based on.  So it's merely a "either avoid or justify in the commit
message, and avoiding feels easier to me."

The doc comment still uses true and false.

>    'if': 'CONFIG_LINUX' }
>  
>  ##


