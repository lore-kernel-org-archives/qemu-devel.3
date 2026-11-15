Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CCB8606A31A
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Nov 2026 14:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=V4oXjSfg
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSbDq-0001AS-Ah; Sun, 15 Nov 2026 09:28:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@linux.dev>)
 id 1xSbDd-00015N-Np
 for qemu-devel@nongnu.org; Sun, 15 Nov 2026 09:28:35 -0500
Received: from out-13.mta0.migadu.com ([2001:41d0:1004:224b::d]
 helo=mta0.migadu.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <junjie.cao@linux.dev>)
 id 1xSbDa-0002v1-3m
 for qemu-devel@nongnu.org; Sun, 15 Nov 2026 09:28:32 -0500
X-Envelope-To: qemu-devel@nongnu.org
DKIM-Signature: a=rsa-sha256; bh=WYq/gBGjNsfGjHnrMChky3FyCarsbXa6jjT5w2j4HOo=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794752906; v=1; x=1795357706;
 b=V4oXjSfgyUxWbvJFeIY/4ql2PgFWIewNtTtfd5HRaZc8oU0ZkWoPtPT9N0YGxvx4r5lO5iG/
 zOv2/NYSyPNSNA7GuHV42Y2HrpyIO00F/pwpx8DJYPuqsFl249L8voK3E1uP81/8dVMm8PddrAO
 JLz8dD63NkbC9jxeO9+kK4Hc=
X-Envelope-To: qemu-devel@nongnu.org
Received: by smtp.migadu.com with ESMTPS id 868c1201a04459f0;
 Sun, 15 Nov 2026 14:28:26 +0000
X-Mizu-Trace-ID: 868c1201a04459f0
X-Migadu-Flow: FLOW_OUT
From: Junjie Cao <junjie.cao@linux.dev>
To: Tommaso Califano <tcalifano@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-stable@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Junjie Cao <junjie.cao@linux.dev>
Subject: Re: [PATCH 9/9] hw/usb/dev-mtp: Stop processing SendObjectInfo after
 an error
Date: Sun, 15 Nov 2026 08:28:19 -0600
Message-ID: <20261115142819.1299849-1-junjie.cao@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261112174907.158825-10-tcalifano@redhat.com>
References: <20261112174907.158825-1-tcalifano@redhat.com>
 <20261112174907.158825-10-tcalifano@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:41d0:1004:224b::d;
 envelope-from=junjie.cao@linux.dev; helo=mta0.migadu.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 12, 2026 at 06:49:06PM +0100, Tommaso Califano wrote:
> When SendObjectInfo fails its checks, usb_mtp_command() queues an error
> response and then falls through. It still allocates s->data_out. The
> data phase is then dropped because a result is pending, so s->data_out
> is never released.

The guest cannot read that error on master: while s->data_out is
set, usb_mtp_handle_data() stalls every BULK IN, and the next command
with it. With this patch the response carries the error code and the
next command works.

Reviewed-by: Junjie Cao <junjie.cao@linux.dev>
Tested-by: Junjie Cao <junjie.cao@linux.dev>

