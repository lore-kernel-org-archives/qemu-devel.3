Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78E50D3C52C
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Dec 2025 11:28:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTIMM-0007Z3-NE; Wed, 10 Dec 2025 06:27:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vTIMK-0007Yq-UJ
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 06:27:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vTIMI-0002G8-UH
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 06:27:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765366068;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zTXtHokjUtzRDl7h2vACNMlylh5NxAXs+riS/Ctozfc=;
 b=VbKhWM3B7EI7Gt/x3vGY5wffIvQSZOekh7kLOMHcfx0oE26eetYE3VbjEQmdF+YRGUdk3t
 j4O9LPRsBHBRasPQIoyixF3bXUiDMTr1n2+W2FmkLpmQqjiRNtUL86Zt/JGVH14iaVRJek
 NXrFXTQu61QyR5I06deY72GqlOJxN08=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-195-bkfxG7FQPneoKT-ork-3pQ-1; Wed,
 10 Dec 2025 06:27:44 -0500
X-MC-Unique: bkfxG7FQPneoKT-ork-3pQ-1
X-Mimecast-MFC-AGG-ID: bkfxG7FQPneoKT-ork-3pQ_1765366062
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AF7FA1955F3E; Wed, 10 Dec 2025 11:27:41 +0000 (UTC)
Received: from redhat.com (unknown [10.44.32.167])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 133C419560AD; Wed, 10 Dec 2025 11:27:32 +0000 (UTC)
Date: Wed, 10 Dec 2025 12:27:30 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dave@treblig.org>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alexandr Moshkov <dtalexundeer@yandex-team.ru>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Juraj Marcin <jmarcin@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH RFC 00/10] QOM: Introduce OBJECT_COMPAT class
Message-ID: <aTlZIlgB20OpdSEl@redhat.com>
References: <20251209162857.857593-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251209162857.857593-1-peterx@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Am 09.12.2025 um 17:28 hat Peter Xu geschrieben:
> [This is an RFC series, as being marked out.  It is trying to collect
>  opinions.  It's not for merging yet]
> 
> Background
> ==========
> 
> It all starts with machine compat properties..
> 
> Machine compat properties are the major weapon we use currently in QEMU to
> define a proper guest ABI, so that whenever we migration a VM instance from
> whatever QEMU version1 to another QEMU version2, as long as the machine
> type is the same, logically the ABI is guaranteed, and migration should
> succeed.  If it didn't, it's a bug.
> 
> These compat properties are only attached to qdev for now.  It almost
> worked.
> 
> Said that, it's also not true - we already have non-qdev users of such, by
> explicitly code it up to apply the compat fields.  Please refer to the
> first patch commit message for details (meanwhile latter patches will
> convert them into a generic model).
> 
> Obviously, we have demands to leverage machine compat properties even
> outside of qdev.  It can be a network backend, it can be an object (for
> example, memory backends), it can be a migration object, and more.

This doesn't feel obvious to me at all. A machine type defines what
hardware the guest sees. Guest hardware is essentially qdev.

I don't see any reasons why a backend should be interested in what guest
hardware looks like, that would seem like a bad layering violation. Many
backends can even exist without a guest at all, and are also used in
tools like qemu-storage-daemon. Having a machine type in a tool that
doesn't run a guest doesn't make any sense.

So if we do introduce some mechanism to provide different defaults for
compatibility with older versions, it has to be separate from machine
types.

Maybe it would make most sense to address this on the QAPI level then
and finally fully QAPIfy the command line. Adding defaults to the QAPI
schema is something that has come up again and again, so maybe we could
introduce that and do it in a versioned way from the start.

Kevin


