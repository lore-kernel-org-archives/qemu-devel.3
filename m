Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAE5DD116E2
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Dec 2025 06:01:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vPwxX-0006BW-Ch; Mon, 01 Dec 2025 01:00:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vPwxV-000694-Ki
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 01:00:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vPwxP-0004fx-Kn
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 01:00:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764568815;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XBPBpbsS2JyvptKS0jTD17AI3l/fBMkx7rikPQaQ/aE=;
 b=gOhR8TPUruXun6Hg92lL6gwP8DBF12DOF9mQ4Rk0szkwmH+olugf7jO81FVJneRuzTwkTB
 TJc3FqdfFO0RCoP7B/KaMFzhnlajyvWKlJ+emfHv5HlnUva3gUaajBp2lvAX6ja3fwHPo9
 KRrAkQzRM5cc9cXnVly5cUusOfqTRi0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-22-9F9v1LzsP4WRje1esxdb1g-1; Mon,
 01 Dec 2025 01:00:11 -0500
X-MC-Unique: 9F9v1LzsP4WRje1esxdb1g-1
X-Mimecast-MFC-AGG-ID: 9F9v1LzsP4WRje1esxdb1g_1764568810
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 602C61955F2A; Mon,  1 Dec 2025 06:00:10 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.7])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B9A55195608E; Mon,  1 Dec 2025 06:00:09 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id DCF1321E6A27; Mon, 01 Dec 2025 07:00:06 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Jie Song <mail@jiesong.me>
Cc: marcandre.lureau@gmail.com,  eblake@redhat.com,  berrange@redhat.com,
 qemu-devel@nongnu.org,  songjie_yewu@cmss.chinamobile.com,  =?utf-8?Q?Ma?=
 =?utf-8?Q?rc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH v4] monitor/qmp: cleanup SocketChardev listener sources
 early to avoid fd handling race
In-Reply-To: <20251125140706.114197-1-mail@jiesong.me> (Jie Song's message of
 "Tue, 25 Nov 2025 22:07:06 +0800")
References: <20251125140706.114197-1-mail@jiesong.me>
Date: Mon, 01 Dec 2025 07:00:06 +0100
Message-ID: <87ms424u8p.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Jie Song, Marc-Andr=C3=A9, is this bug serious enough and the fix safe enou=
gh
to still go into 10.2?

Jie Song <mail@jiesong.me> writes:

> From: Jie Song <songjie_yewu@cmss.chinamobile.com>
>
> When starting a dummy QEMU process with virsh version, monitor_init_qmp()
> enables IOThread monitoring of the QMP fd by default. However, a race
> condition exists during the initialization phase: the IOThread only remov=
es
> the main thread's fd watch when it reaches qio_net_listener_set_client_fu=
nc_full(),
> which may be delayed under high system load.
>
> This creates a window between monitor_qmp_setup_handlers_bh() and
> qio_net_listener_set_client_func_full() where both the main thread and
> IOThread are simultaneously monitoring the same fd and processing events.
> This race can cause either the main thread or the IOThread to hang and
> become unresponsive.
>
> Fix this by proactively cleaning up the listener's IO sources in
> monitor_init_qmp() before the IOThread initializes QMP monitoring,
> ensuring exclusive fd ownership and eliminating the race condition.
>
> Signed-off-by: Jie Song <songjie_yewu@cmss.chinamobile.com>
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


