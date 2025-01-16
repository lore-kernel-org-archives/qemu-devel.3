Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAA44C02183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 14:04:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYQTo-0004OM-KB; Thu, 16 Jan 2025 09:04:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tYQTl-0004Nq-BA
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 09:04:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tYQTj-00006z-Kh
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 09:04:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737036249;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ehItaMtNhnbzc7nNrvtY9FTNOO9Y8NkswR6NL4EQdFk=;
 b=SB2BQj8mqAsqaRYZII3t6cgIhAgeiFNZt1EirPTIxaaetlGfTnbPxfcWffYtFP7dXwWsHq
 kx0rA91XDUrZ/d8EMuRcdi582gAK9nbI+xobEimxvmFtkhsOcZew+TSHl3mQdbH7Wcb4Lj
 TAjynbXB5ByfWRHY+nmXlkAfz42NlV4=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-391-es1lX6gtNMmCGp4Ewv_ANA-1; Thu,
 16 Jan 2025 09:04:05 -0500
X-MC-Unique: es1lX6gtNMmCGp4Ewv_ANA-1
X-Mimecast-MFC-AGG-ID: es1lX6gtNMmCGp4Ewv_ANA
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 786641955D80; Thu, 16 Jan 2025 14:04:04 +0000 (UTC)
Received: from redhat.com (unknown [10.39.196.38])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 33C401955BE3; Thu, 16 Jan 2025 14:04:01 +0000 (UTC)
Date: Thu, 16 Jan 2025 15:03:59 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>
Subject: Re: [PATCH v4 0/2] vpc: Read images exported from Azure correctly
Message-ID: <Z4kRz1oEAgT_PWw5@redhat.com>
References: <20241212134504.1983757-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241212134504.1983757-1-vkuznets@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.093,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Am 12.12.2024 um 14:45 hat Vitaly Kuznetsov geschrieben:
> Changes since v3:
> - Split the change into two patches [Philippe Mathieu-Daude].
> 
> It was found that 'qemu-nbd' is not able to work with some disk images
> exported from Azure as it uses a currently unknown 'wa\0\0' 'creator app'
> signature. QEMU currently supports two methods for determining the image
> size: CHS and 'current_size' and the list of known 'creator app's is used
> to decide between the two. Invert the logic in QEMU and make 'current_size'
> the default as it seems that VPC and old QEMU are the only two legacy apps
> where preferring CHS makes sense.
> 
> Vitaly Kuznetsov (2):
>   vpc: Split off vpc_ignore_current_size() helper
>   vpc: Read images exported from Azure correctly

Thanks, applied to the block branch.

Kevin


