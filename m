Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6FC2CCF2D3
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 08:07:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIiPF-0001wG-DT; Mon, 19 Oct 2026 04:07:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xIiPA-0001vS-LB
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 04:07:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xIiP7-0004GC-Hg
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 04:07:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792397251;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 resent-to:resent-from:resent-message-id:in-reply-to:in-reply-to:
 references:references; bh=5LalhCAaMhzYOPv6hlCkEqOXsF4fDnqWNr18CUqN77w=;
 b=DQfL4M+nlKjIATPSABWVm0GzuGLSSi636qA1h/9/i6mNb7o9dv4/nyF5L5XOt3F5fUPFvG
 tzqjvo/S6XjiDXT7Z7CcxbDncxdjnpoUkTftRmgGXlho2Mz2LaaoTcHCcmx/abJVPn33u2
 I4Zu+dqPl1lZ/lQ2+QkTW/geZRE05fs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-149-uurdzPacNrekP4y-eqiaNQ-1; Mon,
 19 Oct 2026 08:07:30 +0000
X-MC-Unique: uurdzPacNrekP4y-eqiaNQ-1
X-Mimecast-MFC-AGG-ID: uurdzPacNrekP4y-eqiaNQ_1792397249
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5CE3E1955F72; Mon, 19 Oct 2026 08:07:29 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 011A61800642; Mon, 19 Oct 2026 08:07:29 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9E3F221E6A04; Mon, 19 Oct 2026 10:07:26 +0200 (CEST)
Resent-To: michael.roth@amd.com, qemu-devel@nongnu.org
Resent-From: Markus Armbruster <armbru@redhat.com>
Resent-Date: Mon, 19 Oct 2026 10:07:26 +0200
Resent-Message-ID: <874iei2jwh.fsf@pond.sub.org>
From: Markus Armbruster <armbru@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org,  michael.roth@amd.com,  jsnow@redhat.com
Subject: Re: [RFC PATCH 0/6] qapi: Preliminary work for better QOM
 introspection
In-Reply-To: <CAMxuvay1K9gS8xRc_bH1f28txFZXAt9hjH7O4uQZtzffs8fJHA@mail.gmail.com>
 (=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Wed, 14 Oct 2026
 18:09:17 +0400")
References: <20261009140431.3175479-1-armbru@redhat.com>
 <CAJ+F1CKqDbV0xVkL6Q_++qHk4iNstWC_y2raPXy8BovUyPQzdQ@mail.gmail.com>
 <871p9tya83.fsf@pond.sub.org>
 <CAMxuvaxyrOtn5uXuWSuRL4KUTyAVZFAinniG-YZQfo4_ngizrA@mail.gmail.com>
 <87o6cwu816.fsf@pond.sub.org>
 <CAMxuvay1K9gS8xRc_bH1f28txFZXAt9hjH7O4uQZtzffs8fJHA@mail.gmail.com>
Date: Mon, 19 Oct 2026 09:06:53 +0200
Message-ID: <87pkx62mpe.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Thanks!  I intend to post a v6 of your "qom/qdev: associate properties
with QAPI schema types" today, then continue review there.


