Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47C78C369A2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Apr 2025 07:39:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2Q20-00052N-F8; Wed, 09 Apr 2025 03:39:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1u2Q1m-0004vk-D8
 for qemu-devel@nongnu.org; Wed, 09 Apr 2025 03:39:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1u2Q1k-0004ET-CE
 for qemu-devel@nongnu.org; Wed, 09 Apr 2025 03:39:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744184350;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hz8UtxSqPotvzl4WW0l53bzNjjxuD72syf+NIGyvDEE=;
 b=Agcxcmu2g56xn3pOicJsPQi/QKDbRN7iNvTJyy0gLTsfyArdN/2oTvsuPJweoCttK6YE8d
 1vGIZ34epCPOYeGDX4MmMh50lFatbmo8ngPApvue1duwS4ANw/1SahetE2EnLmw0WNhORS
 IhVQYBdesiLbNUZR0pen0B8j+l9E93U=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-649-h34UmWV2OKisW_MF6zPJzg-1; Wed,
 09 Apr 2025 03:39:06 -0400
X-MC-Unique: h34UmWV2OKisW_MF6zPJzg-1
X-Mimecast-MFC-AGG-ID: h34UmWV2OKisW_MF6zPJzg_1744184345
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8D9761955BC6; Wed,  9 Apr 2025 07:39:05 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.7])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 03A163001D0E; Wed,  9 Apr 2025 07:39:04 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 95DF021E66C5; Wed, 09 Apr 2025 09:39:02 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org,  John Snow <jsnow@redhat.com>,  Cleber Rosa
 <crosa@redhat.com>,  Eric Blake <eblake@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,  Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, devel@lists.libvirt.org
Subject: Re: [PATCH V1 0/6] fast qom tree get
In-Reply-To: <1741036202-265696-1-git-send-email-steven.sistare@oracle.com>
 (Steve Sistare's message of "Mon, 3 Mar 2025 13:09:56 -0800")
References: <1741036202-265696-1-git-send-email-steven.sistare@oracle.com>
Date: Wed, 09 Apr 2025 09:39:02 +0200
Message-ID: <87friheqcp.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.845,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Steve, I apologize for the slow response.

Steve Sistare <steven.sistare@oracle.com> writes:

> Using qom-list and qom-get to get all the nodes and property values in a
> QOM tree can take multiple seconds because it requires 1000's of individual
> QOM requests.  Some managers fetch the entire tree or a large subset
> of it when starting a new VM, and this cost is a substantial fraction of
> start up time.

"Some managers"... could you name one?

> To reduce this cost, consider QAPI calls that fetch more information in
> each call:
>   * qom-list-get: given a path, return a list of properties and values.
>   * qom-list-getv: given a list of paths, return a list of properties and
>     values for each path.
>   * qom-tree-get: given a path, return all descendant nodes rooted at that
>     path, with properties and values for each.

Libvirt developers, would you be interested in any of these?

> In all cases, a returned property is represented by ObjectPropertyValue,
> with fields name, type, value, and error.  If an error occurs when reading
> a value, the value field is omitted, and the error message is returned in the
> the error field.  Thus an error for one property will not cause a bulk fetch
> operation to fail.

Returning errors this way is highly unusual.  Observation; I'm not
rejecting this out of hand.  Can you elaborate a bit on why it's useful?

> To evaluate each method, I modified scripts/qmp/qom-tree to use the method,
> verified all methods produce the same output, and timed each using:
>
>   qemu-system-x86_64 -display none \
>     -chardev socket,id=monitor0,path=/tmp/vm1.sock,server=on,wait=off \
>     -mon monitor0,mode=control &
>
>   time qom-tree -s /tmp/vm1.sock > /dev/null

Cool!

> I only measured once per method, but the variation is low after a warm up run.
> The 'real - user - sys' column is a proxy for QEMU CPU time.
>
> method               real(s)   user(s)   sys(s)  (real - user - sys)(s)
> qom-list / qom-get   2.048     0.932     0.057   1.059
> qom-list-get         0.402     0.230     0.029   0.143
> qom-list-getv        0.200     0.132     0.015   0.053
> qom-tree-get         0.143     0.123     0.012   0.008
>
> qom-tree-get is the clear winner, reducing elapsed time by a factor of 14X,
> and reducing QEMU CPU time by 132X.
>
> qom-list-getv is slower when fetching the entire tree, but can beat
> qom-tree-get when only a subset of the tree needs to be fetched (not shown).
>
> qom-list-get is shown for comparison only, and is not included in this series.

If we have qom-list-getv, then qom-list-get is not worth having.


