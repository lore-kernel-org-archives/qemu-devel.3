Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 232A2C8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 12:27:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXfVP-0007Yt-9D; Fri, 04 Jul 2025 08:27:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uXfVN-0007Xv-1b
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 08:27:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uXfVL-0007sT-0v
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 08:27:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751632017;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=S0Vlo7gJZTH+p2JuSt9jkMefzHeiSCY6B3Cld83Pio4=;
 b=X4rDQlWoRNe4juMBzylODdF387oryWtv9QXKxRg9sgag8HJ/8OYvatdhqZec/WupEhU3Bk
 hux1vw1ISNEEsn8s2kBKCIdQI9d2ZEfCFerG9V0BNLssZzgLiUpMXOeUdabEZLEQMZJGLI
 nZX8ZJuHij653plZ9DvQ6dbymk8/sH0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-632-9XaJbdeHNFC6_ZgZfFGZzg-1; Fri,
 04 Jul 2025 08:26:54 -0400
X-MC-Unique: 9XaJbdeHNFC6_ZgZfFGZzg-1
X-Mimecast-MFC-AGG-ID: 9XaJbdeHNFC6_ZgZfFGZzg_1751632013
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0D41C19560A1; Fri,  4 Jul 2025 12:26:53 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.10])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A591E3000218; Fri,  4 Jul 2025 12:26:52 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1CFCE21E6A27; Fri, 04 Jul 2025 14:26:50 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org,  John Snow <jsnow@redhat.com>,  Cleber Rosa
 <crosa@redhat.com>,  Eric Blake <eblake@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,  Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>,
 Peter Krempa <pkrempa@redhat.com>, devel@lists.libvirt.org
Subject: Re: [PATCH V2 0/5] fast qom tree get
In-Reply-To: <1747057635-124298-1-git-send-email-steven.sistare@oracle.com>
 (Steve Sistare's message of "Mon, 12 May 2025 06:47:10 -0700")
References: <1747057635-124298-1-git-send-email-steven.sistare@oracle.com>
Date: Fri, 04 Jul 2025 14:26:50 +0200
Message-ID: <87v7o8m99x.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 15
X-Spam_score: 1.5
X-Spam_bar: +
X-Spam_report: (1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.218,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

> Using qom-list and qom-get to get all the nodes and property values in a
> QOM tree can take multiple seconds because it requires 1000's of individual
> QOM requests.  Some managers fetch the entire tree or a large subset
> of it when starting a new VM, and this cost is a substantial fraction of
> start up time.
>
> To reduce this cost, consider QAPI calls that fetch more information in
> each call:
>   * qom-list-get: given a path, return a list of properties and values.
>   * qom-list-getv: given a list of paths, return a list of properties and
>     values for each path.
>   * qom-tree-get: given a path, return all descendant nodes rooted at that
>     path, with properties and values for each.
>
> In all cases, a returned property is represented by ObjectPropertyValue,
> with fields name, type, and value.  If an error occurs when reading a value
> the value field is omitted.  Thus an error for one property will not cause a
> bulk fetch operation to fail.
>
> To evaluate each method, I modified scripts/qmp/qom-tree to use the method,
> verified all methods produce the same output, and timed each using:
>
>   qemu-system-x86_64 -display none \
>     -chardev socket,id=monitor0,path=/tmp/vm1.sock,server=on,wait=off \
>     -mon monitor0,mode=control &
>
>   time qom-tree -s /tmp/vm1.sock > /dev/null
>
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
> qom-list-get is shown for comparison only, and is not included in this series.

How badly do you need the additional performance qom-tree-get can give
you in certain cases?

I'm asking because I find qom-list-getv *much* simpler.


