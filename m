Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3A65C36010
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 16:34:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzeYD-00023f-9x; Tue, 01 Apr 2025 12:33:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pkrempa@redhat.com>)
 id 1tzeXR-0001wa-6Y
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 12:32:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pkrempa@redhat.com>)
 id 1tzeXL-0007uu-GS
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 12:32:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743525143;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=P0Ds+dk6WT0av2/CpfVBgCQRq39ZKOiHI1h3LY9TR08=;
 b=aUljx1CGiRzPA+IQyAP7adPrcnYgB/+UKuH3rxxRGlbDX+rGO8m/tquM6V6iKwY2nZKxp4
 P9d12pbQADGJRiLWdkVoa9hQOhiCTVgAY5XcwUuQ5xJH0Q+mSHr3hRtk794+1igY4hyGlJ
 QR7CD4a5M62ld/3hUFugsCELgMmGXEU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-595-LzUdHUwTO2GQWVGDPjPVxg-1; Tue,
 01 Apr 2025 12:32:20 -0400
X-MC-Unique: LzUdHUwTO2GQWVGDPjPVxg-1
X-Mimecast-MFC-AGG-ID: LzUdHUwTO2GQWVGDPjPVxg_1743525139
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D926918004A9; Tue,  1 Apr 2025 16:32:18 +0000 (UTC)
Received: from angien.pipo.sk (unknown [10.44.22.8])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AED611801747; Tue,  1 Apr 2025 16:32:13 +0000 (UTC)
Date: Tue, 1 Apr 2025 18:32:09 +0200
From: Peter Krempa <pkrempa@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, hreitz@redhat.com,
 kwolf@redhat.com, armbru@redhat.com, eblake@redhat.com,
 jsnow@redhat.com, devel@lists.libvirt.org, michael.roth@amd.com,
 pbonzini@redhat.com
Subject: Re: [PATCH] [for-10.1] qapi/block-core: derpecate some block-job- APIs
Message-ID: <Z-wVCQ2ZDduwdnWl@angien.pipo.sk>
References: <20250401155730.103718-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250401155730.103718-1-vsementsov@yandex-team.ru>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pkrempa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.997,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Apr 01, 2025 at 18:57:30 +0300, Vladimir Sementsov-Ogievskiy wrote:
> For change, pause, resume, complete, dismiss and finalize actions
> corresponding job- and block-job commands are almost equal. The
> difference is in find_block_job_locked() vs find_job_locked()
> functions. What's different?
> 
> 1. find_block_job_locked() do check, is found job a block-job. This OK
>    when moving to more generic API, no needs to document this change.
> 
> 2. find_block_job_locked() reports DeviceNotActive on failure, when
>    find_job_locked() reports GenericError. So, lets document this
>    difference in deprecated.txt. Still, for dismiss and finalize errors
>    are not documented at all, so be silent in deprecated.txt as well.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
> 
> Hi all!
> 
> That's a continuation of my "[RFC 00/15] block job API"[1], exactly, the
> simplest part of it - deprecating block-job-* commands which simply
> duplicate job-* ones.
> 
> Note that the old series was started with trying to introduce job-change
> command as substitution to both block-job-change (which only can change
> mirror copy-mode parameter), and block-job-set-speed. It was rather
> complicated and controversial attempt, which latest implemenation was
> "[PATCH v3 0/7] introduce job-change qmp command"[2].
> 
> In [2] Kevin noted, that we'd better follow existing blockdev-reopen
> approach of changing options (i.e. specify all options) than introduce a
> new one. But, on the other hand, now I'm afraid, that rewriting in
> third tools simple call to (old good) block-job-set-speed into
> job-change(_all_options_ + changed speed) is too much work just for
> "having nice interface". And too much for the only two options we want
> to change.
> 
> So, let's just start from something more obvious. Finally,
> we can simple keep block-job-set-speed and block-job-change as is,
> as they (unlike other block-job-* commands) are not duplicated by
> similar job-* commands.
> 
> [1] https://patchew.org/QEMU/20240313150907.623462-1-vsementsov@yandex-team.ru/
> [2] https://patchew.org/QEMU/20241002140616.561652-1-vsementsov@yandex-team.ru/
> 
>  docs/about/deprecated.rst | 31 +++++++++++++++++++++++++++++++
>  qapi/block-core.json      | 30 ++++++++++++++++++++++++++++++
>  2 files changed, 61 insertions(+)
> 
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index e2b4f077d4..eed3356359 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -148,6 +148,37 @@ options are removed in favor of using explicit ``blockdev-create`` and
>  ``blockdev-add`` calls. See :doc:`/interop/live-block-operations` for
>  details.
>  
> +``block-job-pause`` (since 10.1)
> +'''''''''''''''''''''''''''''''
> +
> +Use ``job-pause`` instead. The only difference is that ``job-pause``
> +always reports GenericError on failure when ``block-job-pause`` reports
> +DeviceNotActive when block-job is not found.
> +
> +``block-job-resume`` (since 10.1)
> +''''''''''''''''''''''''''''''''
> +
> +Use ``job-resume`` instead. The only difference is that ``job-resume``
> +always reports GenericError on failure when ``block-job-resume`` reports
> +DeviceNotActive when block-job is not found.
> +
> +``block-job-complete`` (since 10.1)
> +''''''''''''''''''''''''''''''''''
> +
> +Use ``job-complete`` instead. The only difference is that ``job-complete``
> +always reports GenericError on failure when ``block-job-complete`` reports
> +DeviceNotActive when block-job is not found.
> +
> +``block-job-dismiss`` (since 10.1)
> +'''''''''''''''''''''''''''''''''
> +
> +Use ``job-dismiss`` instead.
> +
> +``block-job-finalize`` (since 10.1)
> +''''''''''''''''''''''''''''''''''
> +
> +Use ``job-finalize`` instead.
> +

Libvirt uses only the following two with 'block-job-' prefix:

src/qemu/qemu_monitor_json.c:    if (!(cmd = qemuMonitorJSONMakeCommand("block-job-cancel",
src/qemu/qemu_monitor_json.c:    if (!(cmd = qemuMonitorJSONMakeCommand("block-job-set-speed",

thus on behalf of libvirt:

ACKed-by: Peter Krempa <pkrempa@redhat.com>


