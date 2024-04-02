Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E645ACD1284
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Apr 2024 12:39:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrdPj-0006Ig-TZ; Tue, 02 Apr 2024 08:38:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rrdPf-0006Gu-AB
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 08:38:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rrdPc-0000Yh-Td
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 08:38:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712061527;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i2zbuGXOJxgcfwub3bOWKia3a7MOtvZqb2EdNwxf658=;
 b=aRuRYDsApe7tbnrJdp1lzHkVzRf/KMr/JVZYUwkn8syIiWTYE26c97qIpJ2fm9CrmRXirv
 3pBi2I0DzpDLtsk0MrokmtOWaor0ZUQKUZDUJlpmY2lt3GSlcEPZkoofsZpFPAJlj02d0a
 YJQqySZ8LcXOiGZruQckiBlBAywT7XE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-417-cWWtOGK8Pmywgm-1j0DHKg-1; Tue, 02 Apr 2024 08:38:42 -0400
X-MC-Unique: cWWtOGK8Pmywgm-1j0DHKg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AB28F8630C2;
 Tue,  2 Apr 2024 12:38:41 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.153])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 84290200BBF7;
 Tue,  2 Apr 2024 12:38:40 +0000 (UTC)
Date: Tue, 2 Apr 2024 14:38:35 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-block@nongnu.org, f.ebner@proxmox.com, qemu-devel@nongnu.org
Subject: Re: [PATCH] block: Remove unnecessary NULL check in bdrv_pad_request()
Message-ID: <Zgv8S_auU1qFMO2C@redhat.com>
References: <20240327192750.204197-1-kwolf@redhat.com>
 <25f0de51-6010-4c5b-922e-6d7fe9427cf3@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <25f0de51-6010-4c5b-922e-6d7fe9427cf3@linaro.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Am 02.04.2024 um 12:53 hat Philippe Mathieu-Daudé geschrieben:
> On 27/3/24 20:27, Kevin Wolf wrote:
> > Coverity complains that the check introduced in commit 3f934817 suggests
> > that qiov could be NULL and we dereference it before reaching the check.
> > In fact, all of the callers pass a non-NULL pointer, so just remove the
> > misleading check.
> > 
> > Resolves: Coverity CID 1542668
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >   block/io.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Since I'm not seeing other block related patch for 9.0 and
> I'm preparing a pull request, I'm queuing this one.

Thanks, Phil. I didn't send a pull request because I didn't have
anything else and silencing a Coverity false positive didn't seem urgent
for 9.0, but it certainly doesn't hurt either.

Kevin


