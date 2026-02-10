Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A92EEA8112
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 13:13:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpnY9-00086a-Hz; Tue, 10 Feb 2026 08:13:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vpnY1-000862-6I
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 08:12:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vpnXz-00054R-JB
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 08:12:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770729172;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p72Ycd9HlgZa2McnyEkLgs5kf5rSxURidXNEjNx2Gzo=;
 b=W7Npmrqf0AYSUFjzAvndfxNagTyN1lSwA/cyqrbuLCInPmaImgPXdXPlT2g35E8/dNWdzN
 arrrDni3KnYQ/GGB79lXm98RCxBy5blsYe0D6SVi7I2cEwwRvjZI7eHskIh5FL7/HbKDdT
 AGgO6Ka5EYo5a09zwdRJDqwXDxQMlsU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-678-FejE-XW1N-eKqgzskyzE6A-1; Tue,
 10 Feb 2026 08:12:49 -0500
X-MC-Unique: FejE-XW1N-eKqgzskyzE6A-1
X-Mimecast-MFC-AGG-ID: FejE-XW1N-eKqgzskyzE6A_1770729167
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 21A191956067; Tue, 10 Feb 2026 13:12:47 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.253])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E1BA01956053; Tue, 10 Feb 2026 13:12:42 +0000 (UTC)
Date: Tue, 10 Feb 2026 14:12:40 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Qing Wang <qinwang@redhat.com>, Fam Zheng <fam@euphon.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Hannes Reinecke <hare@suse.de>, pkrempa@redhat.com,
 Eduardo Habkost <eduardo@habkost.net>, Alberto Faria <afaria@redhat.com>
Subject: Re: [PATCH v3 0/5] scsi: persistent reservation live migration
Message-ID: <aYsuyI0RbAcEktsj@redhat.com>
References: <20260129212035.219676-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260129212035.219676-1-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Am 29.01.2026 um 22:20 hat Stefan Hajnoczi geschrieben:
> v3:
> - Use warn_report_err() instead of suppressing errors [Daniel Berrangé]
> - Wrap lines exceeding 80 characters
> 
> v2:
> - Add user documentation [Paolo]
> - Send PREEMPT on the source if migration fails. This rollback operation
>   ensures the source regains access to the LUN even if migration fails after
>   the destination issues its own PREEMPT.
> 
> Live migration does not work for SCSI Persistent Reservations acquired on
> scsi-block devices. This patch series migrates the reservation key and
> reservation type so that the destination QEMU can take over the persistent
> reservation with the PREEMPT service action upon live migration.
> 
> The approach involves snooping PERSISTENT RESERVE OUT replies and tracking the
> scsi-block device's current reservation key and reservation type. In most cases
> this involves no additional SCSI commands. This approach isn't perfect: if
> another machine modifies the reservation on the physical LUN, then QEMU's state
> becomes stale. Persistent reservations are inherently cooperative, so this is
> acceptable as long as real applications don't run into problems.
> 
> I am also working on a test suite called pr-tests that runs sg_persist(8)
> commands across multiple machines in order to exercise various scenarios:
> https://gitlab.com/stefanha/pr-tests

On top of this, should we do something to catch cases where migrate-pr
is off, but the user still tries to migrate while PRs are in use? Maybe
have a migration blocker as long as pr_state->key is set?

Kevin


