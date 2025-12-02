Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E7A6D116F6
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Dec 2025 12:07:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQPA4-0002Lr-P1; Tue, 02 Dec 2025 07:07:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vQPA3-0002L4-5k
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 07:07:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vQPA0-0002Rx-E4
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 07:07:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764677230;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=81fr4uOyTK7etTOoB4X2TcIGrzFdpIdvqNziQfiLphY=;
 b=LSV1gdOgsLCTi/5m0SlLDyK8esSNGWLnHFQ1wZCCCm/MYtlVXRmANV5l3eDHAq57n22INd
 KosZyrWBYGw/QzBZ4zRlBBLQXHQL26P/knqq267ZMvng9nMMkD5A+4Pj6YaDiimbg06hHT
 estZc/cu21exKfHcbXPaz+9kEDx6F/8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-326-Ns-oYYavO4a-H4w9SzGsaA-1; Tue,
 02 Dec 2025 07:07:09 -0500
X-MC-Unique: Ns-oYYavO4a-H4w9SzGsaA-1
X-Mimecast-MFC-AGG-ID: Ns-oYYavO4a-H4w9SzGsaA_1764677228
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DF1AF195609F; Tue,  2 Dec 2025 12:07:07 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.7])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 434A31956095; Tue,  2 Dec 2025 12:07:07 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8D02521E6A27; Tue, 02 Dec 2025 13:07:04 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Jie Song <mail@jiesong.me>
Cc: berrange@redhat.com,  eblake@redhat.com,  marcandre.lureau@gmail.com,
 marcandre.lureau@redhat.com,  qemu-devel@nongnu.org,
 songjie_yewu@cmss.chinamobile.com
Subject: Re: [PATCH v4] monitor/qmp: cleanup SocketChardev listener sources
 early to avoid fd handling race
In-Reply-To: <20251201130404.12083-1-mail@jiesong.me> (Jie Song's message of
 "Mon, 1 Dec 2025 21:04:03 +0800")
References: <87ms424u8p.fsf@pond.sub.org>
 <20251201130404.12083-1-mail@jiesong.me>
Date: Tue, 02 Dec 2025 13:07:04 +0100
Message-ID: <87sedtt7dj.fsf@pond.sub.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Jie Song <mail@jiesong.me> writes:

> Hi Markus,
>
>> Jie Song, Marc-Andr=C3=A9, is this bug serious enough and the fix safe e=
nough
>> to still go into 10.2?
>
> First, regarding the seriousness of this bug, although the probability of=
 encountering=20
> it in a production environment is relatively low, it has existed for quit=
e some time.
>
> Secondly, with regard to the safety of this fix, it has been verified suc=
cessfully
> in the test environment. However, it would be better if more people could=
 help to
> review it to further ensure its robustness.

This confirms Marc-Andr=C3=A9's "too late for 10.2" feeling.

I'll track this patch for 11.0.  More review would be nice, but if we
can get it, I'll get the patch merged early in the development cycle.

Thank you!


