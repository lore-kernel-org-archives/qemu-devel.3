Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89AB5C3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 08:31:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUMXB-0000ip-Aj; Thu, 18 Jul 2024 04:30:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sUMXA-0000fi-FP
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 04:30:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sUMX9-0003OZ-3d
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 04:30:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721291438;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0vjwG1JkGckzMDWyDQPKrhQhAHERlAi00mY6ATMa5Zc=;
 b=bLa9ZiJspzQCKer847Fj8TnI9vb+aJiFiYJeixxRJdbeuy7T6nqhf6D8E8UEBTBhXO1/N5
 PIHqG/+2m3mLirry2u6snmnp6IW+ai6fQnY6E9N7ApI9v5ccf3O3GKe+Sm13PZpkMtF085
 uX1ufzv9xZRnylRmE29/wglxWIQoY5c=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-203-WozhPETtPSqDuWd0ZrcouQ-1; Thu,
 18 Jul 2024 04:30:32 -0400
X-MC-Unique: WozhPETtPSqDuWd0ZrcouQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 799E21955F3D; Thu, 18 Jul 2024 08:30:30 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.65])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 971321955D42; Thu, 18 Jul 2024 08:30:28 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 512B521E6757; Thu, 18 Jul 2024 10:30:26 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-block@nongnu.org,  raphael@enfabrica.net,  mst@redhat.com,
 qemu-devel@nongnu.org,  armbru@redhat.com,  eblake@redhat.com,
 eduardo@habkost.net,  berrange@redhat.com,  pbonzini@redhat.com,
 hreitz@redhat.com,  kwolf@redhat.com,  yc-core@yandex-team.ru
Subject: Re: [PATCH v5 1/3] qdev-monitor: add option to report GenericError
 from find_device_state
In-Reply-To: <20240625121843.120035-2-vsementsov@yandex-team.ru> (Vladimir
 Sementsov-Ogievskiy's message of "Tue, 25 Jun 2024 15:18:41 +0300")
References: <20240625121843.120035-1-vsementsov@yandex-team.ru>
 <20240625121843.120035-2-vsementsov@yandex-team.ru>
Date: Thu, 18 Jul 2024 10:30:26 +0200
Message-ID: <878qxzm7a5.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:

> Here we just prepare for the following patch, making possible to report
> GenericError as recommended.
>
> This patch doesn't aim to prevent further use of DeviceNotFound by
> future interfaces:
>
>  - find_device_state() is used in blk_by_qdev_id() and qmp_get_blk()
>    functions, which may lead to spread of DeviceNotFound anyway
>  - also, nothing prevent simply copy-pasting find_device_state() calls
>    with false argument

A possible way to reduce the likelihood of further spread:

1. Rename find_device_state() to find_device_state_legacy().

2. New find_device_state() that reports GenericError.

Could also be done in a follow-up.

>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

The patch does what it says on the tin, so
Reviewed-by: Markus Armbruster <armbru@redhat.com>


