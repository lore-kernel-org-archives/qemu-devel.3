Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10832C2BA15
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 12:04:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJB4c-0008SO-Jy; Mon, 17 Jun 2024 08:02:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sJB4S-0008RN-Bs
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 08:02:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sJB4P-0001o4-GC
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 08:02:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718625763;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=l1ZpAb/wn44XrchjUzZ/TXnIKUVrqz6gutVzuvMieDA=;
 b=QlwkzYB4MC4kanLHNrzFpqYbgCMQ79VAh8pANso5q9K3b1veqwPuSTLMyIZDzEbiZiWutZ
 xH6cgxjy4vWRMVF/HhqwzINlVG17+hxRVEnqt9cCJ9aNeh9gkae0BaXhY8CjDi9snHaqoK
 TcEjqwAHO1OBgfzy0xOrppmceEShUfc=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-117-syqApElrM4CpngTVAoUWTQ-1; Mon,
 17 Jun 2024 08:02:37 -0400
X-MC-Unique: syqApElrM4CpngTVAoUWTQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A07D419560B6; Mon, 17 Jun 2024 12:02:35 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.93])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 159B81955E80; Mon, 17 Jun 2024 12:02:33 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id BD50221E6757; Mon, 17 Jun 2024 14:02:30 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: mst@redhat.com,  qemu-devel@nongnu.org,  qemu-block@nongnu.org,  Hanna
 Reitz <hreitz@redhat.com>,  Brad Smith <brad@comstyle.com>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  =?utf-8?Q?Marc-Andr?=
 =?utf-8?Q?=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  Laurent Vivier <lvivier@redhat.com>,
 gmaglione@redhat.com,  stefanha@redhat.com,  Coiby Xu
 <Coiby.Xu@gmail.com>,  Gerd Hoffmann <kraxel@redhat.com>,  slp@redhat.com,
 Igor Mammedov <imammedo@redhat.com>,  Raphael Norwitz
 <raphael@enfabrica.net>,  Thomas Huth <thuth@redhat.com>,  Eduardo Habkost
 <eduardo@habkost.net>,  David Hildenbrand <david@redhat.com>,  Kevin Wolf
 <kwolf@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Jason Wang
 <jasowang@redhat.com>, Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH RESEND v7 00/12] vhost-user: support any POSIX system
 (tested on macOS, FreeBSD, OpenBSD)
In-Reply-To: <rx5hvcffqzmixgmlroko7t6qvjciifr77nvpwrakpl5oovw3ec@mihi4k5nhse6>
 (Stefano Garzarella's message of "Mon, 17 Jun 2024 12:35:47 +0200")
References: <20240612130140.63004-1-sgarzare@redhat.com>
 <rx5hvcffqzmixgmlroko7t6qvjciifr77nvpwrakpl5oovw3ec@mihi4k5nhse6>
Date: Mon, 17 Jun 2024 14:02:30 +0200
Message-ID: <87iky7eq09.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.148,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Stefano Garzarella <sgarzare@redhat.com> writes:

> Hi Michael,
>
> On Wed, Jun 12, 2024 at 03:01:28PM GMT, Stefano Garzarella wrote:
>>This series should be in a good shape, in which tree should we queue it?
>>@Micheal would your tree be okay?
>
> Markus suggested a small change to patch 10, so do you want me to resend the whole series, or is it okay to resend just the last 3 patches (which are also the ones that depend on the other patch queued by Markus)?

I guess you mean

    [PATCH v2] qapi: clarify that the default is backend dependent
    Message-ID: <20240611130231.83152-1-sgarzare@redhat.com>

> In the last case I would ask you to queue up the first 9 patches of this series if that is okay with you.

Michael, feel free to merge the patch I queued.


