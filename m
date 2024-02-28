Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AB6DC47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 06:56:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfDrp-0000v6-CE; Wed, 28 Feb 2024 01:56:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rfDrm-0000uG-Pp
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 01:56:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rfDrl-0002a3-Fv
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 01:56:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709103392;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0+fEX33lstw1TH7E+ySAD+mE2+QhO3a2YTnW3RiYdBc=;
 b=Zg2wPq+RB2EORANY//HqFdHZUuE5bXxYB3ZrLu9q2Zym2r1ZD8xxYf1niV8Dy4yHO+POh+
 8dJmXV7nobC94keuuPtLf/K+Xmx3ciOWILBSqgN5PPap3imJHUpqUVIeVmUuMEaQGeCwWE
 9bXIxSsreOP+YP5DUvhXBSao9uagbuQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-374-jFxPBeVlN4K9UcsKwTzjOA-1; Wed,
 28 Feb 2024 01:56:29 -0500
X-MC-Unique: jFxPBeVlN4K9UcsKwTzjOA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DB4791C631C0;
 Wed, 28 Feb 2024 06:56:28 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.4])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C68CD2166B33;
 Wed, 28 Feb 2024 06:56:26 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9288121E66F4; Wed, 28 Feb 2024 07:56:24 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Maksim Davydov <davydov-max@yandex-team.ru>
Cc: qemu-devel@nongnu.org,  vsementsov@yandex-team.ru,  eduardo@habkost.net,
 marcel.apfelbaum@gmail.com,  philmd@linaro.org,  wangyanan55@huawei.com,
 jsnow@redhat.com,  eblake@redhat.com,  pbonzini@redhat.com,
 berrange@redhat.com,  alxndr@bu.edu,  den@virtuozzo.com
Subject: Re: [PATCH v9 2/4] qmp: add dump machine type compatibility properties
In-Reply-To: <20240222153912.646053-3-davydov-max@yandex-team.ru> (Maksim
 Davydov's message of "Thu, 22 Feb 2024 18:39:10 +0300")
References: <20240222153912.646053-1-davydov-max@yandex-team.ru>
 <20240222153912.646053-3-davydov-max@yandex-team.ru>
Date: Wed, 28 Feb 2024 07:56:24 +0100
Message-ID: <87o7c13wmf.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Maksim Davydov <davydov-max@yandex-team.ru> writes:

> To control that creating new machine type doesn't affect the previous
> types (their compat_props) and to check complex compat_props inheritance
> we need qmp command to print machine type compatibility properties.
> This patch adds the ability to get list of all the compat_props of the
> corresponding supported machines for their comparison via new optional
> argument of "query-machines" command. Since information on compatibility
> properties can increase the command output by a factor of 40, add an
> argument to enable it, default off.
>
> Signed-off-by: Maksim Davydov <davydov-max@yandex-team.ru>
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

QAPI schema
Acked-by: Markus Armbruster <armbru@redhat.com>


