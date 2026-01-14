Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC62DD37E31
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 13:19:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vg0m5-0004Rz-KE; Wed, 14 Jan 2026 08:19:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@jiesong.me>) id 1vg0lv-0004HN-EI
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 08:18:53 -0500
Received: from out28-59.mail.aliyun.com ([115.124.28.59])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@jiesong.me>) id 1vg0ls-0004oQ-2b
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 08:18:49 -0500
Received: from Sun.localdomain(mailfrom:mail@jiesong.me
 fp:SMTPD_---.g6QTLef_1768396703 cluster:ay29) by smtp.aliyun-inc.com;
 Wed, 14 Jan 2026 21:18:27 +0800
From: Jie Song <mail@jiesong.me>
To: mjt@tls.msk.ru
Cc: armbru@redhat.com, berrange@redhat.com, eblake@redhat.com, mail@jiesong.me,
 marcandre.lureau@gmail.com, marcandre.lureau@redhat.com,
 qemu-devel@nongnu.org, qemu-stable@nongnu.org,
 songjie_yewu@cmss.chinamobile.com
Subject: Re: [PATCH v4] monitor/qmp: cleanup SocketChardev listener sources
 early to avoid fd handling race
Date: Wed, 14 Jan 2026 21:18:22 +0800
Message-ID: <20260114131823.8239-1-mail@jiesong.me>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <3719bb72-4b15-4af5-8c55-46cf9a064918@tls.msk.ru>
References: <3719bb72-4b15-4af5-8c55-46cf9a064918@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.28.59; envelope-from=mail@jiesong.me;
 helo=out28-59.mail.aliyun.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

Hi Michael, sorry for the late reply — this message was unfortunately
caught by my mail filter and I just noticed it.

Regarding applying this change to qemu-stable: this patch only 
uses the existing qio_net_listener_set_client_func_full() helper.
Considering this limited dependency and the fact that the change
is confined to cleaning up the listener sources earlier to avoid
the fd handling race, it should be safe to apply this patch to 
the qemu-stable series.

Thanks for taking a look and for considering it for the stable branches.

> On 11/25/25 17:07, Jie Song wrote:
> > From: Jie Song <songjie_yewu@cmss.chinamobile.com>
> > 
> > When starting a dummy QEMU process with virsh version, monitor_init_qmp()
> > enables IOThread monitoring of the QMP fd by default. However, a race
> > condition exists during the initialization phase: the IOThread only removes
> > the main thread's fd watch when it reaches qio_net_listener_set_client_func_full(),
> > which may be delayed under high system load.
> > 
> > This creates a window between monitor_qmp_setup_handlers_bh() and
> > qio_net_listener_set_client_func_full() where both the main thread and
> > IOThread are simultaneously monitoring the same fd and processing events.
> > This race can cause either the main thread or the IOThread to hang and
> > become unresponsive.
> > 
> > Fix this by proactively cleaning up the listener's IO sources in
> > monitor_init_qmp() before the IOThread initializes QMP monitoring,
> > ensuring exclusive fd ownership and eliminating the race condition.
> 
> I'm picking this up for qemu-stable series (10.0.x, 10.1.x, 10.2.x),
> for now.  Please let me know if I shouldn't.
> 
> Yes I've seen this change has a breakage potential, too -- let's see
> how it works out.
> 
> Thanks,
> 
> /mjt

Best regards,
Jie Song

