Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C405DC54756
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 20:13:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uH6qW-0000tS-KJ; Mon, 19 May 2025 16:12:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1uH6qQ-0000sh-QN
 for qemu-devel@nongnu.org; Mon, 19 May 2025 16:12:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1uH6qP-00066f-4m
 for qemu-devel@nongnu.org; Mon, 19 May 2025 16:12:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747685536;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+viDVsoJDAluJaTzG7+kRmPT6NrnYkIBphDAt0jVpyQ=;
 b=O5qRh0yFSvNKS/8aIuMe76kVpOEdw0bJbIZRimfUuTPWLtXNMjV/L/f/fywk7QgYmJmEW8
 XSabP0K0oQYZJkZtFQ4yUYCaIhi4pHsAIKRkJ1rRQjrdp5qStbJ7r1SrQbvnO9Rpsq149J
 WHLlwwXCH8iyp36/8ke5E7eFtq43Sxw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-610-iTu1q1b-NvSQ1y10GD6YPQ-1; Mon,
 19 May 2025 16:12:13 -0400
X-MC-Unique: iTu1q1b-NvSQ1y10GD6YPQ-1
X-Mimecast-MFC-AGG-ID: iTu1q1b-NvSQ1y10GD6YPQ_1747685532
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C543E180035C; Mon, 19 May 2025 20:12:11 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.201])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6EEB218003FC; Mon, 19 May 2025 20:12:09 +0000 (UTC)
Date: Mon, 19 May 2025 15:12:06 -0500
From: Eric Blake <eblake@redhat.com>
To: Nir Soffer <nirsof@gmail.com>
Cc: qemu-devel@nongnu.org, 
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Richard Jones <rjones@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, 
 qemu-block@nongnu.org
Subject: Re: [PATCH v4 0/3] nbd: Increase unix socket buffer size
Message-ID: <5udsw4sg2avldgtdpisiu6arrg7t6el7kbiz4a7xgwiqs5g7e4@qhmkaa4oldbx>
References: <20250517201154.88456-1-nirsof@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250517201154.88456-1-nirsof@gmail.com>
User-Agent: NeoMutt/20250404
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.13,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Sat, May 17, 2025 at 11:11:51PM +0300, Nir Soffer wrote:
> On both macOS and Linux, the default send buffer size is too small causing poor
> performance when reading and writing to qemu-nbd. A simple way to experience
> this is to compare TCP and unix sockets, showing that TCP socket is much
> faster. Programs like nbdcopy partly mitigate this by using multiple NBD
> connections.
> 
> On macOS the default send buffer size is 8192 bytes. Increasing the send buffer
> size to 2 MiB shows up to *12.6 times higher throughput* and lower cpu usage.
> 
> On Linux the default and maximum buffer size is 212992 bytes. Increasing the
> send buffer size to 2 MiB shows up to *2.7 times higher throughput* and lower
> cpu usage. On older machine we see very little improvement, up to 1.03 times
> higher throughput.
> 
> We likely have the same issue on other platforms. It should be easy to enable
> this change for more platform by defining UNIX_STREAM_SOCKET_SEND_BUFFER_SIZE.

Thanks; I'm staging this through my NBD tree.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


