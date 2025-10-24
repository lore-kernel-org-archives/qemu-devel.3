Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8152BCCF9E3
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 19:05:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCN5P-0000vH-UD; Fri, 24 Oct 2025 15:04:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1vCN5O-0000v3-AD
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 15:04:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1vCN5M-00051M-L8
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 15:04:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761332663;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XA/4q4Ov24n9vAgzW1LfcQ1pMbwFjxB/xETz3OMfPM4=;
 b=THI35GQXEQkEGYV0SEGU7bZlAH1SfcZ9kdJ1AQjGNxPs0J6k9klHUvfwANJi3SGvxyyZeA
 p1qCUU4KV7bMfkms7UJnjf4Gnf2feYS4Za4WXSvk9cndsR8kQZ8PmKEK8SNq6ph8fdhUwp
 JHclUqaTmmSMbH1R+7PqCK32xycDoRo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-318-jeXZNimPMrWXdRnMXfu0jw-1; Fri,
 24 Oct 2025 15:04:20 -0400
X-MC-Unique: jeXZNimPMrWXdRnMXfu0jw-1
X-Mimecast-MFC-AGG-ID: jeXZNimPMrWXdRnMXfu0jw_1761332659
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 26A22196F76E; Fri, 24 Oct 2025 19:04:19 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.155])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3537530002DE; Fri, 24 Oct 2025 19:04:17 +0000 (UTC)
Date: Fri, 24 Oct 2025 14:04:14 -0500
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, armbru@redhat.com, qemu-devel@nongnu.org, 
 hreitz@redhat.com
Subject: Re: [PATCH v2 4/4] qemu-img info: Add cache mode option
Message-ID: <zg2f7rmtapyvgztyyuj2twsntezx3ayhmloawqesf25g56pkxf@qperuc67znnm>
References: <20251024123041.51254-1-kwolf@redhat.com>
 <20251024123041.51254-5-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251024123041.51254-5-kwolf@redhat.com>
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

On Fri, Oct 24, 2025 at 02:30:40PM +0200, Kevin Wolf wrote:
> When querying block limits, different cache modes (in particular
> O_DIRECT or not) can result in different limits. Add an option to
> 'qemu-img info' that allows the user to specify a cache mode, so that
> they can get the block limits for the cache mode they intend to use with
> their VM.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  docs/tools/qemu-img.rst |  2 +-
>  qemu-img.c              | 25 +++++++++++++++++++++----
>  qemu-img-cmds.hx        |  4 ++--
>  3 files changed, 24 insertions(+), 7 deletions(-)
>

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


