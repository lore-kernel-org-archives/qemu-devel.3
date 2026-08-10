Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9234C5AD55
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2026 14:10:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtQiC-00015n-CG; Mon, 10 Aug 2026 10:10:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wtQiA-00012K-62
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 10:10:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wtQi8-0001jV-Kr
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 10:10:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786371039;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=09KljatR4X9O/8uB07LHQ/OsPTOC/kIFk85pqTN4Wlk=;
 b=WIfE9cAXIzqZ4h7NMj8pmoiTeYx64KwFdMW63uArLskUpveWFcrL0AYEl4LjnhBjuY0XNb
 CzvYMNxQlcfBb/Wh/FuWibM6+/CgaCK1FjU07P53xoVTI9kxPtZ6A0pZMRxATsG8+YUVkL
 6E5GsQcI3YraEXSnVMhgqzLUUeieQ/4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-494-cBo-g_CiPsGjTTpPq3AJOg-1; Mon,
 10 Aug 2026 10:10:36 -0400
X-MC-Unique: cBo-g_CiPsGjTTpPq3AJOg-1
X-Mimecast-MFC-AGG-ID: cBo-g_CiPsGjTTpPq3AJOg_1786371035
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E210A1956057; Mon, 10 Aug 2026 14:10:34 +0000 (UTC)
Received: from redhat.com (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DE571180049F; Mon, 10 Aug 2026 14:10:32 +0000 (UTC)
Date: Mon, 10 Aug 2026 15:10:29 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Cc: qemu-devel@nongnu.org, Valentino Paulon <valentino.paulon88@gmail.com>,
 Yan Vugenfirer <yvugenfi@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH v3] qga: Change effective user/group ID in guest-ssh-*
 commands
Message-ID: <annb1XDdADxPUGw_@redhat.com>
References: <20260810140641.161728-1-kkostiuk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260810140641.161728-1-kkostiuk@redhat.com>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.746,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Aug 10, 2026 at 05:06:41PM +0300, Kostiantyn Kostiuk wrote:
> Before this commit, when qmp_guest_ssh_add_authorized_keys adds an
> SSH key for an existing local user, the agent (running as root) decides
> whether to create the user's .ssh directory with a symlink-following
> directory test, and then writes and chowns the authorized_keys file.
> A local unprivileged user who owns their home directory can pre-stage
> their .ssh directory (or the authorized_keys file) as a symbolic link
> so that, when the host or operator triggers a key add for that user,
> the root agent follows the link and transfers ownership of an arbitrary
> root-owned file or directory to the unprivileged user, who can then rewrite
> it to obtain root.
> 
> Fixes: CVE-2026-12080
> Fixes: https://gitlab.com/qemu-project/qemu/-/work_items/3929
> 
> v1: https://patchew.org/QEMU/20260709105707.91209-1-kkostiuk@redhat.com/
> v2 -> v1:
> Change effective user/group ID instead of checking for symlinks and
> changing ownership of the file.
> 
> v2: https://patchew.org/QEMU/20260810104659.82320-1-kkostiuk@redhat.com
> v3 -> v2:
> Deduplicate code.
> Fail daemon when can't rollback effective user/group ID.
> 
> Reported-by: Valentino Paulon <valentino.paulon88@gmail.com>
> Signed-off-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
> ---
>  qga/commands-posix-ssh.c | 66 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 66 insertions(+)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


