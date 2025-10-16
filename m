Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EDDBCCD183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 15:44:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9Q9N-00021I-Vr; Thu, 16 Oct 2025 11:44:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1v9Q9M-000212-MB
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 11:44:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1v9Q9F-0006yn-N7
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 11:44:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760629450;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=no2TgKK1J2PrH2IH3islxuddl2gD4j52x9O9Dw1t5OA=;
 b=e4jqk3Yg3eR4ymcav1Js3LoXsLagBMXUdUpFmOy9nWXfJsm+m7krfL5AMkzyQGVJ2x4rid
 rAa19yTxw2v+xLt7eFnfVVi1eT5lqWr1xSiT8ERGi5WxeUj+Ec9d/pAIzMmuYpH9B9UDkA
 kBOcQB+0AtWynE+T8MfoKgrfyrr+j1k=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-519-4Y-U4OzMNb6GXUYuairWyw-1; Thu,
 16 Oct 2025 11:44:08 -0400
X-MC-Unique: 4Y-U4OzMNb6GXUYuairWyw-1
X-Mimecast-MFC-AGG-ID: 4Y-U4OzMNb6GXUYuairWyw_1760629447
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 97A7B180A23F
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 15:43:56 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.155])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2C9801800579; Thu, 16 Oct 2025 15:43:55 +0000 (UTC)
Date: Thu, 16 Oct 2025 10:43:52 -0500
From: Eric Blake <eblake@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v2 5/6] crypto: switch to newer gnutls API for
 distinguished name
Message-ID: <5p3xcoqo2dy3ueuha5e6msu65bz3avtrwdcpwucomkthx7guok@fymdxsnyswrc>
References: <20250919101022.1491007-1-berrange@redhat.com>
 <20250919101022.1491007-6-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250919101022.1491007-6-berrange@redhat.com>
User-Agent: NeoMutt/20250905
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Fri, Sep 19, 2025 at 11:10:21AM +0100, Daniel P. Berrangé wrote:
> The new API automatically allocates the right amount of memory
> to hold the distinguished name, avoiding the need to loop and
> realloc.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  crypto/tlssession.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)

It's nice to see that the library is slowly becoming easier to use.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


