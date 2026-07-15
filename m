Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A86EC44508
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2026 16:57:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wk2uJ-0003DP-Iv; Wed, 15 Jul 2026 12:56:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wk2uI-0003D6-02
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 12:56:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wk2uF-0005ku-DN
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 12:56:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784134581;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iDkEzqqOzzpZfw9bS534GnVHm6ZtnJ1yrDR7f3wScm4=;
 b=YM7g5vvI6pGXUG2yEmzsXMq76rIwP4/BtCx95n6oxXI3silQXB7L6GH1DZZS7bzebQLKRa
 VFGa8dlbNSUtKaHYnucqdE38XoOdzI/rJdDYFuRTxhKtl+62QPIos146/WrI1mDEiCxk1h
 4tV2abpztX8s/44rtwAGnv+IIzYeDoA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-683-mCFAlpHCNCyWd_1Vt61ZEA-1; Wed,
 15 Jul 2026 12:56:20 -0400
X-MC-Unique: mCFAlpHCNCyWd_1Vt61ZEA-1
X-Mimecast-MFC-AGG-ID: mCFAlpHCNCyWd_1Vt61ZEA_1784134579
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8AD0D1956063; Wed, 15 Jul 2026 16:56:18 +0000 (UTC)
Received: from redhat.com (unknown [10.44.34.221])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4B0AE180036E; Wed, 15 Jul 2026 16:56:15 +0000 (UTC)
Date: Wed, 15 Jul 2026 17:56:12 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH] hw/9pfs: fix O_TRUNC bypass on read-only export
Message-ID: <ale7rOcjP4EXtcbi@redhat.com>
References: <E1wk2Dq-0019kY-JK@kylie.crudebyte.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <E1wk2Dq-0019kY-JK@kylie.crudebyte.com>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=berrange@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
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

On Wed, Jul 15, 2026 at 06:10:00PM +0200, Christian Schoenebeck wrote:
> Guest 9p client opening a file with O_TRUNC on a read-only 9p file
> system using 9p2000.u protocol version, allowed to bypass 9p
> server's read-only check, eventually causing file(s) being
> truncated to empty file(s) on host's read-only export.
> 
> Root cause is that 9p server's read-only check is using Linux open
> flags like O_WRONLY, O_RDWR, O_TRUNC, but checking them against
> the 9p Topen request's "mode" parameter, which has a different
> encoding (Otrunc = 0x10 vs. O_TRUNC = 0x200).
> 
> Fix this by checking against the "flags" variable instead of the
> protocol's "mode" option. Because the "flags" variable is already
> converted to Linux encoding by omode_to_uflags() for 9p2000.u and
> by get_dotl_openflags() for 9p2000.L protocol version.
> 
> Only 9p2000.u was affected by this bypass, 9p2000.L uses the Linux
> format on protocol level already.
> 
> Fixes: 2c74c2cb4b ("hw/9pfs: Read-only support for 9p export")
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4000
> Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> ---
>  hw/9pfs/9p.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>

Once a CVE is assigned to this in the gitlab issue, just include
that CVE ID in the commit message when doing a pull request.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


