Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C828C54E5D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 12:16:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmBuH-000460-Qv; Mon, 18 Mar 2024 08:15:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rmBto-000430-BX
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 08:15:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rmBtX-0006Lb-H2
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 08:15:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710764109;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jsHu8Z17oCFadmgPA2y6e6YbmNkk+eER4NODuF2wheg=;
 b=K8TUHCKaYa1q2gYbkzOdD4UkMpe/GmnyfExJ6YaKrZzrnwQ9a9iiHXCLjq1ycDfSz7Keyx
 MDDPgwQLdkOC3KnDzPBCVijBD8tKtkqwfr1tWOoo6Jz0uvG0bQ6qL/+qi4auR7oYHo6zWY
 6tfl9jOyPGv/n92Zo5oH7eK0RV05XTA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-219-y20wUQ_-P4uEpUkSIz3jVw-1; Mon,
 18 Mar 2024 08:15:07 -0400
X-MC-Unique: y20wUQ_-P4uEpUkSIz3jVw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8258029ABA13;
 Mon, 18 Mar 2024 12:15:07 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.127])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CDACF40C6DB3;
 Mon, 18 Mar 2024 12:15:06 +0000 (UTC)
Date: Mon, 18 Mar 2024 13:14:51 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH 0/9] tests/qemu-iotests: Fix running with "check -ssh
 -qcow2"
Message-ID: <ZfgwOzF0HF9z1hua@redhat.com>
References: <20240315111108.153201-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240315111108.153201-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.374,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Am 15.03.2024 um 12:10 hat Thomas Huth geschrieben:
> I recently wanted to check for some changes that I did to the URI handling
> in the block layer code, but I had to discover that a lot of iotests only
> work with the raw file format when using a protocol that is not "file",
> i.e. "./check -ssh -qcow2" shows a lot of failures.
> While some tests could be fixed to work with the "ssh" protocol, too,
> many other tests seem to be written for the "file" protocol only and
> thus have to be marked accordingly.
> 
> After applying these patches, there is still one failure left in test 181
> where I'm unsure whether it's a real bug or whether this test should also
> simply be marked to work with the "file" protocol only. Suggestions are
> welcome!
> 
> Thomas Huth (9):
>   tests/qemu-iotests: Fix test 033 for running with non-file protocols
>   tests/qemu-iotests: Restrict test 066 to the 'file' protocol
>   tests/qemu-iotests: Restrict test 114 to the 'file' protocol
>   tests/qemu-iotests: Restrict test 130 to the 'file' protocol
>   tests/qemu-iotests: Restrict test 134 and 158 to the 'file' protocol
>   tests/qemu-iotests: Restrict test 156 to the 'file' protocol
>   tests/qemu-iotests: Restrict tests that use --image-opts to the 'file'
>     protocol
>   tests/qemu-iotests: Fix some tests that use --image-opts for other
>     protocols
>   tests/qemu-iotests: Restrict tests using "--blockdev file" to the file
>     protocol

Thanks, applied to the block branch.

Kevin


