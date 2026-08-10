Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B61CAC5AD7B
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2026 18:19:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtUb5-0007AX-3y; Mon, 10 Aug 2026 14:19:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wtUb2-00079Z-CN
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 14:19:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wtUb0-0003Pp-On
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 14:19:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786385974;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U8ta+deO0PrbFXE6WJ73opDbTnniNhcpfByv9SfLUhY=;
 b=bSP6H+zgLJZiyBLURqwhRmU/jlTFdWIxmdIznSGRbtwAlDuhq9pidwI9Uw7IAFK0nfqDbE
 wt6CgsgZoJtFm3eqLahTiMMrckTgsuIyxWldvrdd3NlBnZ/nSTHA+3iKQCXae6oxTMNJh/
 xVWhFHjWZiFPNveMD+8ThRU3vVjDWEg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-251-gWGj8efrOFWtcotPahugEg-1; Mon,
 10 Aug 2026 14:19:30 -0400
X-MC-Unique: gWGj8efrOFWtcotPahugEg-1
X-Mimecast-MFC-AGG-ID: gWGj8efrOFWtcotPahugEg_1786385970
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9DB1518005B3; Mon, 10 Aug 2026 18:19:29 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2B5FA472; Mon, 10 Aug 2026 18:19:27 +0000 (UTC)
Date: Mon, 10 Aug 2026 19:19:25 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v2 22/39] qemu-io: propagate errors through Error API
 instead of printf
Message-ID: <anoWLcR_xLmgUb8U@redhat.com>
References: <20260626-qemu-no-hmp-v2-0-8af31bc54c61@redhat.com>
 <20260626-qemu-no-hmp-v2-22-8af31bc54c61@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260626-qemu-no-hmp-v2-22-8af31bc54c61@redhat.com>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.746,
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

On Fri, Jun 26, 2026 at 01:19:23AM +0400, Marc-André Lureau wrote:
> Convert the qemu-io command infrastructure to use QEMU's Error API
> (Error **errp) for error propagation instead of printing directly to
> stdout/stderr via printf/fprintf.
> 
> The cfunc_t typedef, all ~35 command functions, the dispatcher chain
> (command/init_check_command/qemuio_command), and helper functions
> (parse_pattern, create_iovec, qemu_io_alloc_from_file) all gain an
> Error **errp parameter. Async completion callbacks (aio_read_done,
> aio_write_done, aio_discard_done) use error_report() since they have
> no Error path back to the caller.
> 
> Update tests:
> - error_report_err() prepends qemu-io: prefix
> - copy-before-write: check the HMP return value, rather than stdio
> - other tests: update to check JSON {"return": "Error: error text"}
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  include/qemu-io.h                              |   4 +-
>  block/monitor/block-hmp-cmds.c                 |   2 +-
>  qemu-io-cmds.c                                 | 414 +++++++++++++------------
>  qemu-io.c                                      |  17 +-
>  tests/qemu-iotests/004.out                     |  20 +-
>  tests/qemu-iotests/021.out                     |  60 ++--
>  tests/qemu-iotests/026.out                     | 228 +++++++-------
>  tests/qemu-iotests/060.out                     |  44 ++-
>  tests/qemu-iotests/071.out                     |  10 +-
>  tests/qemu-iotests/072.out                     |   2 +-
>  tests/qemu-iotests/080.out                     |   4 +-
>  tests/qemu-iotests/081.out                     |   2 +-
>  tests/qemu-iotests/083.out                     |  36 +--
>  tests/qemu-iotests/089.out                     |   4 +-
>  tests/qemu-iotests/114.out                     |   2 +-
>  tests/qemu-iotests/134.out                     |   2 +-
>  tests/qemu-iotests/137.out                     |   2 +-
>  tests/qemu-iotests/153.out                     |  12 +-
>  tests/qemu-iotests/171                         |   2 +-
>  tests/qemu-iotests/171.out                     |  68 ++--
>  tests/qemu-iotests/205                         |   2 +-
>  tests/qemu-iotests/214.out                     |   2 +-
>  tests/qemu-iotests/220.out                     |   2 +-
>  tests/qemu-iotests/225.out                     |   4 +-
>  tests/qemu-iotests/244.out                     |  12 +-
>  tests/qemu-iotests/249.out                     |   6 +-
>  tests/qemu-iotests/271.out                     |  14 +-
>  tests/qemu-iotests/289.out                     |   2 +-
>  tests/qemu-iotests/305.out                     |   2 +-
>  tests/qemu-iotests/307.out                     |   2 +-
>  tests/qemu-iotests/tests/backup-discard-source |   4 +-
>  tests/qemu-iotests/tests/copy-before-write     |  66 ++--
>  tests/qemu-iotests/tests/file-io-error.out     |   2 +-
>  tests/qemu-iotests/tests/image-fleecing.out    |  12 +-
>  tests/qemu-iotests/tests/inactive-node-nbd.out |   8 +-
>  35 files changed, 552 insertions(+), 523 deletions(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


