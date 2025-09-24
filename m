Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AEA2CAC5A5
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 20:57:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1WXA-0000Y6-J1; Wed, 24 Sep 2025 16:56:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1v1WX4-0000Ss-Tc
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 16:56:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1v1WWp-0005jE-OT
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 16:56:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758747351;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DaP50Kjxc1wZHymXqaDL4F7SQ05mPBfLI5Kh5+oSztQ=;
 b=FgnMowZZDLuocSz927tIMtwAGYtCBJuhmDQy5OAavgc4Fa2BH7V1U2ifCDLuL6D6UBwiuK
 fRJ25g8ARWnsB/OKHs8egK26vIBdj9ITx+7oxz/UixCTAdyHjhOBus7PcPCQfncREBCC7T
 JpgFrSIvTsimd+BnfW9p/qKm6DcajN8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-515-7ibIu75JOZi9CjBa_XJE4g-1; Wed,
 24 Sep 2025 16:55:47 -0400
X-MC-Unique: 7ibIu75JOZi9CjBa_XJE4g-1
X-Mimecast-MFC-AGG-ID: 7ibIu75JOZi9CjBa_XJE4g_1758747347
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C68BE18004D4; Wed, 24 Sep 2025 20:55:46 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.89])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4EF1B180044F; Wed, 24 Sep 2025 20:55:45 +0000 (UTC)
Date: Wed, 24 Sep 2025 15:55:42 -0500
From: Eric Blake <eblake@redhat.com>
To: Daniel Kahn Gillmor <dkg@fifthhorseman.net>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v2 2/3] Socket activation: get FD by label
Message-ID: <56jgy7mqrmcqmws7tlxrmsudla7zwpy7ncnjsqoen3wvpglivp@6pk67wiek7d6>
References: <20250627180331.1370235-1-dkg@fifthhorseman.net>
 <20250629040723.1696325-1-dkg@fifthhorseman.net>
 <20250629040723.1696325-3-dkg@fifthhorseman.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250629040723.1696325-3-dkg@fifthhorseman.net>
User-Agent: NeoMutt/20250510
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Sun, Jun 29, 2025 at 12:04:00AM -0400, Daniel Kahn Gillmor wrote:
> This uses the cached copy of LISTEN_FDNAMES to find the first file
> descriptorlabel with a matching label.
> 
> Note that if two file descriptors are given the same label this will
> ignore all but the first.
> 
> This is another step toward addressing
> https://gitlab.com/qemu-project/qemu/-/issues/3011
> 
> Signed-off-by: Daniel Kahn Gillmor <dkg@fifthhorseman.net>
> ---
>  include/qemu/systemd.h | 15 +++++++++++++++
>  util/systemd.c         | 35 +++++++++++++++++++++++++++++++++++
>  2 files changed, 50 insertions(+)
> 

> +/*
> + * Check if socket activation indicates named file descriptor based on
> + * the colon-delimited LISTEN_FDNAMES.  The "label" must not be NULL,
> + * and should be a simple text string that does not contain a colon,
> + * matching the FileDescriptorName= directive in systemd.socket(5)
> + *
> + * It is acceptable to ask for the empty string as a label.
> + *
> + * Returns -1 if no socket activation is in use, or if the label does
> + * not match any file descriptor.  Otherwise, returns the lowest
> + * numeric value for a file descriptor matching the label exactly.

Per this description...

>  #else /* !_WIN32 */
>  unsigned int check_socket_activation(void)
>  {
>      return 0;
>  }
> +unsigned int socket_activated_fd_by_label(const char *label)
> +{
> +    return 0;
> +}
>  #endif

this stub should probably return -1, not 0.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


