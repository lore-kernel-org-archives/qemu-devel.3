Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C02DCC6B08
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 14:51:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGdq1-0005FN-VH; Tue, 13 Oct 2026 10:50:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xGdpv-0005Ea-Hf
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 10:50:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xGdpt-0006J2-Th
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 10:50:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791903035;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pIOhFLsUOv1Tt1kDFIh0bgqQCl7B7wBR93FSjFNMNP0=;
 b=PFz6dOMDj1eLpBtG4AjqN/ie21+0/9R1uDLviuk6R5+e4iVyYPPVdWqei583yHgKG2RsFo
 naJYMi+MVgNqC02d4DpBYMp69ZvLaGaLJS0CofwNnJYJUYcpBOPuIQOEw6t34BuzrqiNoX
 3UqcvOY/P2En8aOVal9xgr4Bx5yoGOE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-452-WqDu-kqDMtSg58eKfRsm7g-1; Tue,
 13 Oct 2026 14:50:34 +0000
X-MC-Unique: WqDu-kqDMtSg58eKfRsm7g-1
X-Mimecast-MFC-AGG-ID: WqDu-kqDMtSg58eKfRsm7g_1791903033
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6219A182A134; Tue, 13 Oct 2026 14:50:32 +0000 (UTC)
Received: from redhat.com (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 21D2730001B9; Tue, 13 Oct 2026 14:50:28 +0000 (UTC)
Date: Tue, 13 Oct 2026 09:50:26 -0500
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, akalenyu@redhat.com, qemu-block@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Benjamin Marzinski <bmarzins@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, 
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Fam Zheng <fam@euphon.net>
Subject: Re: [PATCH 1/8] pr-manager-helper: fix sense buffer overflow
Message-ID: <as5E1SXMTv7BYupL@redhat.com>
References: <20261009153058.1089786-1-stefanha@redhat.com>
 <20261009153058.1089786-2-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261009153058.1089786-2-stefanha@redhat.com>
User-Agent: NeoMutt/20260616
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Oct 09, 2026 at 11:30:51AM -0400, Stefan Hajnoczi wrote:
> scsi_build_sense() assumes the sense buffer is SCSI_SENSE_LEN (18) bytes
> long, so the caller's buffer with an arbitrary size cannot be used. Use
> our own sense buffer (resp.sense) as an intermediate buffer and honor
> the caller's sense buffer size (io_hdr->mx_sb_len).
> 
> This is triggered when scsi-generic.c:scsi_SG_IO() calls blk_ioctl()
> with an 8-byte sense buffer. There does not appear to be a way for the
> guest to trigger this buffer overflow directly since
> SCSIRequest->sense[] is 252 bytes long.
> 
> Fixes: 9bad2a6b9d0a ("scsi: add persistent reservation manager using qemu-pr-helper")
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  scsi/pr-manager-helper.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


