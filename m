Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CA6DCCD1A5
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 18:55:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBHVr-0003Fu-I2; Tue, 21 Oct 2025 14:55:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1vBHVo-00038I-Vk
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 14:55:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1vBHVm-0005Yn-Jp
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 14:55:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761072908;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zc1xsih85VOy5wFZrUJ/MBOn9XYdC5F365mvzJblObI=;
 b=Y7p+fgulCTJ+VwjzPSD9KMhsflXJC5ryv8s44UcTKMpRaLv10ilg/0pcoupCc/4meAxnvV
 itjjOJui2yS6iUkJwetO7y3XhaZ5Pc5dVPTq64hHzz27PgMIHKNjZQlcapfvBCtp2iVXeb
 CT4Z+AINjWcmrnVU/wLbJC5U16uhjN8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-114-SfwhSFYiMRSr4Vc5Wo8mLA-1; Tue,
 21 Oct 2025 14:55:06 -0400
X-MC-Unique: SfwhSFYiMRSr4Vc5Wo8mLA-1
X-Mimecast-MFC-AGG-ID: SfwhSFYiMRSr4Vc5Wo8mLA_1761072906
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F2ED418002C0
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 18:55:05 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.155])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F327B30001BC; Tue, 21 Oct 2025 18:55:03 +0000 (UTC)
Date: Tue, 21 Oct 2025 13:55:01 -0500
From: Eric Blake <eblake@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH] crypto: propagate Error object on premature termination
Message-ID: <6bwsra265kondoqu7xj7dwhfrembtbxbaasgedjqe6nboacru6@dlxjhli3iwes>
References: <20251006190126.4159590-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251006190126.4159590-1-berrange@redhat.com>
User-Agent: NeoMutt/20250905
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Mon, Oct 06, 2025 at 08:01:26PM +0100, Daniel P. Berrangé wrote:
> The way that premature termination was handled in TLS connections was
> changed to handle an ordering problem during graceful shutdown in the
> migration code.
> 
> Unfortunately one of the codepaths returned -1 to indicate an error
> condition, but failed to set the 'errp' parameter.
> 
> This broke error handling in the qio_channel_tls_handshake function,
> as the QTask callback would no longer see that an error was raised.
> As a result, the client will go on to try to use the already closed
> TLS connection, resulting in misleading errors.
> 
> This was evidenced in the I/O test 233 which showed changes such as
> 
> -qemu-nbd: Certificate does not match the hostname localhost
> +qemu-nbd: Failed to read initial magic: Unable to read from socket: Connection reset by peer
> 
> Fixes: 7e0c22d585581b8083ffdeb332ea497218665daf
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  crypto/tlssession.c |  8 +++++---
>  io/channel-tls.c    | 13 +++++++------
>  2 files changed, 12 insertions(+), 9 deletions(-)

Thanks; queued in my NBD tree, since I have further patches that will
further alter the output of 233 to give more details about NBD
devices.

Tested-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


