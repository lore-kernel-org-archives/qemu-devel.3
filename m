Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B202BC44515
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 05:35:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlge5-0001iq-C6; Mon, 20 Jul 2026 01:34:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariyam@oss.nttdata.com>)
 id 1wlgdg-0001cq-As
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 01:34:05 -0400
Received: from oss.nttdata.com ([49.212.34.109])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariyam@oss.nttdata.com>)
 id 1wlgde-0008VO-94
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 01:34:04 -0400
Received: by oss.nttdata.com (Postfix, from userid 1024)
 id 8A1BC2020285; Mon, 20 Jul 2026 14:33:34 +0900 (JST)
From: Mitsuru Kariya <Mitsuru.Kariya@oss.nttdata.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Mitsuru Kariya <Mitsuru.Kariya@oss.nttdata.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Eric Blake <eblake@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Peter Xu <peterx@redhat.com>,
 Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 2/5] qemu-options: document keep-alive-count/idle/interval
 for -netdev stream
Date: Mon, 20 Jul 2026 14:33:33 +0900
Message-ID: <20260720053333.2316643-1-Mitsuru.Kariya@oss.nttdata.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <87y0gx8sld.fsf@pond.sub.org>
References: <20260524073442.435408-3-Mitsuru.Kariya@oss.nttdata.com>
 <87y0gx8sld.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 1.4.3 at oss.nttdata.com
X-Virus-Status: Clean
Received-SPF: pass client-ip=49.212.34.109;
 envelope-from=kariyam@oss.nttdata.com; helo=oss.nttdata.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_PASS=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Thank you for reviewing, and I'm sorry for the late reply.

Markus Armbruster <armbru@redhat.com> writes:
> You document these options only for -netdev stream.  They also work
> for -netdev dgram, possibly more (didn't check).  Shouldn't we
> document them every where they work?

As you pointed out, options such as keep-alive* are accepted by -netdev
dgram as well. However, since these options are TCP-specific, they have
no effect on sockets created by -netdev dgram.
In fact, while these options are applied to sockets in
inet_set_sockopts(), it is only called from inet_connect_saddr() and
inet_listen_saddr(), which are for TCP, and not from inet_dgram_saddr(),
which is for UDP. (I also confirmed this with strace.)

Since the options are effectively no-ops there, I thought documenting
them was unnecessary — but would you prefer that I add some note about
it?

For completeness, I also checked places other than -netdev stream and
-incoming tcp:.
For -blockdev driver=nbd and -drive driver=nbd, the keep-alive* options
do take effect.  However, the documentation for -blockdev refers
readers to the blockdev-add QMP command, and -drive is documented as
accepting the same options as -blockdev, so I concluded that no
additional description is needed there.

As for -netdev socket, -drive file=nbd:, -chardev socket, and -vnc,
they can also be used with TCP connections, but the keep-alive* options
cannot be specified with them.

