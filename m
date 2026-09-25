Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8E3BC9830E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 10:14:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xA2wY-0008Bl-9W; Fri, 25 Sep 2026 06:14:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xA2wW-0008B9-Fu
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 06:14:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xA2wU-0000kt-VH
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 06:14:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790331250;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YlPcNFjcdw8Ob9yituhBiitIPbGzQwkss2uejcIy8Nc=;
 b=Horr+HjN8qsAzIuhlF8uFkqHxyHmbYYAwnHRk3LvtKrmp6Fb+6cBmaBQd9x/fyiwrkNwv2
 4y3JtR6UvhoPsZOieK9YJJY7nGL0MC1yZcSk1aoIfvOdOW3llLqvzg7fNoGuXgGzOmvUEQ
 yIM1RQOuzAgKL4fi1H6txv1XJDk5zd0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-581-xiXuvVe1Ns2JXNO9x4ii7A-1; Fri,
 25 Sep 2026 06:14:08 -0400
X-MC-Unique: xiXuvVe1Ns2JXNO9x4ii7A-1
X-Mimecast-MFC-AGG-ID: xiXuvVe1Ns2JXNO9x4ii7A_1790331248
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B3CF518E755C; Fri, 25 Sep 2026 10:14:07 +0000 (UTC)
Received: from redhat.com (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7CE501956086; Fri, 25 Sep 2026 10:14:06 +0000 (UTC)
Date: Fri, 25 Sep 2026 11:14:03 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
Subject: Re: [RFC PATCH 04/14] qemu-options: Add qemu_opts_parse_list
Message-ID: <arZJa4iixssdLbGC@redhat.com>
References: <20260918223002.1892021-1-farosas@suse.de>
 <20260918223002.1892021-5-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260918223002.1892021-5-farosas@suse.de>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Sep 18, 2026 at 07:29:51PM -0300, Fabiano Rosas wrote:
> Currently the qemu_opts_parse and qemu_opts_parse_noisily functions
> are called in one two ways:
> 
> 1) qemu_opts_parse|_noisily(&some_group_list, ...)
> 2) qemu_opts_parse|_noisily(qemu_find_opts("some_opt"), ...)
> 
> The second form is problematic. Having the result of qemu_find_opts()
> going directly into the first argument makes it difficult to handle a
> possible NULL pointer retuned by it.
> 
> Next patches will change qemu_opts_parse() and
> qemu_opts_parse_noisily() to receive the option name and call
> qemu_find_opts() in their body so the return of the function can be
> handled properly.
> 
> Add a new qemu_opts_parse_list() and change all callsites that pass
> the list directly to use it. In the next patches this new _list
> version will become the inner function, but at this point, simply make
> it defer to qemu_opts_parse() to make the refactoring easier.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  include/qemu/option.h       |   2 +
>  tests/unit/test-qemu-opts.c | 169 +++++++++++++++++++-----------------
>  util/qemu-option.c          |  13 +++
>  util/qemu-sockets.c         |   2 +-
>  4 files changed, 104 insertions(+), 82 deletions(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


