Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74209C369D5
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 21:38:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9WAs-000795-7M; Mon, 28 Apr 2025 17:38:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1u9WAq-00078q-55
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 17:38:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1u9WAo-0004LH-42
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 17:37:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745876277;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/bbIN7NN5Gmv5EluReGNLg8Lmj2WVGec8RFeQhW/K2k=;
 b=ZLpOAw8kpzTIMrqHJ8poOXoE2VsyJe2kDIq4SuUe+fWQPktWVMxeL3yu0PkI2DUPS402Sz
 VdaDFPn8Th0xlZHf2BLJBMIpYN5g1Wm3Tro63WB4z2q6TMFyoOiQTmTw7rPe4Sw4KlKEjB
 FdXgZS88KV578p4gQHUPlkVg5mTq/lY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-280-L1xYYI2rNrebgYeBw6N3yw-1; Mon,
 28 Apr 2025 17:37:53 -0400
X-MC-Unique: L1xYYI2rNrebgYeBw6N3yw-1
X-Mimecast-MFC-AGG-ID: L1xYYI2rNrebgYeBw6N3yw_1745876272
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9A8C418001E0; Mon, 28 Apr 2025 21:37:52 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.31])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C61F230001A2; Mon, 28 Apr 2025 21:37:50 +0000 (UTC)
Date: Mon, 28 Apr 2025 16:37:48 -0500
From: Eric Blake <eblake@redhat.com>
To: Nir Soffer <nirsof@gmail.com>
Cc: qemu-devel@nongnu.org, 
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Richard Jones <rjones@redhat.com>, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v3 2/2] io: Increase unix socket buffers on Linux
Message-ID: <ttbupbckoby7agbxdpwrnnkigahb7w4bsujjiz3o5kefyjrkgc@a6xmrs6fcwp5>
References: <20250427165029.9072-1-nirsof@gmail.com>
 <20250427165029.9072-3-nirsof@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250427165029.9072-3-nirsof@gmail.com>
User-Agent: NeoMutt/20250404
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.484,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Sun, Apr 27, 2025 at 07:50:29PM +0300, Nir Soffer wrote:
> Like macOS we have similar issue on Linux. For TCP socket the send
> buffer size is 2626560 bytes (~2.5 MiB) and we get good performance.
> However for unix socket the default and maximum buffer size is 212992
> bytes (208 KiB) and we see poor performance when using one NBD
> connection, up to 4 times slower than macOS on the same machine.
> 

> +++ b/io/channel-socket.c
> @@ -39,12 +39,13 @@
>  #define SOCKET_MAX_FDS 16
>  
>  /*
> - * Testing shows that 2m send buffer gives best throuput and lowest cpu usage.
> - * Changing the receive buffer size has no effect on performance.
> + * Testing shows that 2m send buffer is optimal. Changing the receive buffer
> + * size has no effect on performance.
> + * On Linux we need to increase net.core.wmem_max to make this effective.

How can we reliably inform the user of the need to tweak this setting?
Is it worth a bug report to the Linux kernel folks asking them to
reconsider the default cap on this setting, now that modern systems
tend to have more memory than when the cap was first introduced, and
given that we have demonstrable numbers showing why it is beneficial,
especially for parity with TCP?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


