Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 971E9D116F1
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Dec 2025 13:05:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQ3aM-0004af-Hc; Mon, 01 Dec 2025 08:04:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@jiesong.me>) id 1vQ3Zu-0004QB-DH
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 08:04:31 -0500
Received: from out28-88.mail.aliyun.com ([115.124.28.88])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@jiesong.me>) id 1vQ3Zs-0005T7-4q
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 08:04:30 -0500
Received: from Sun.localdomain(mailfrom:mail@jiesong.me
 fp:SMTPD_---.faV.YF7_1764594245 cluster:ay29) by smtp.aliyun-inc.com;
 Mon, 01 Dec 2025 21:04:09 +0800
From: Jie Song <mail@jiesong.me>
To: armbru@redhat.com
Cc: berrange@redhat.com, eblake@redhat.com, mail@jiesong.me,
 marcandre.lureau@gmail.com, marcandre.lureau@redhat.com,
 qemu-devel@nongnu.org, songjie_yewu@cmss.chinamobile.com
Subject: Re: [PATCH v4] monitor/qmp: cleanup SocketChardev listener sources
 early to avoid fd handling race
Date: Mon,  1 Dec 2025 21:04:03 +0800
Message-ID: <20251201130404.12083-1-mail@jiesong.me>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <87ms424u8p.fsf@pond.sub.org>
References: <87ms424u8p.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.28.88; envelope-from=mail@jiesong.me;
 helo=out28-88.mail.aliyun.com
X-Spam_score_int: 6
X-Spam_score: 0.6
X-Spam_bar: /
X-Spam_report: (0.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SORTED_RECIPS=2.499, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=no autolearn_force=no
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

Hi Markus,

> Jie Song, Marc-André, is this bug serious enough and the fix safe enough
> to still go into 10.2?

First, regarding the seriousness of this bug, although the probability of encountering 
it in a production environment is relatively low, it has existed for quite some time.

Secondly, with regard to the safety of this fix, it has been verified successfully
in the test environment. However, it would be better if more people could help to
review it to further ensure its robustness.

> 
> Jie Song <mail@jiesong.me> writes:
> 
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
> >
> > Signed-off-by: Jie Song <songjie_yewu@cmss.chinamobile.com>
> > Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Regards,
Jie Song

