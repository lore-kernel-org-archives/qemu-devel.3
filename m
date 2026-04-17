Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FD2AF436B2
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 15:15:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDkv6-0001fR-5a; Fri, 17 Apr 2026 11:15:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1wDkuq-0001c0-Dl
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 11:15:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1wDkuo-0000O9-FI
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 11:15:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776438929;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xVtfqTeNbNvhcew54QfhlHODc6ih1BOtzVV4oeDv/6U=;
 b=OeDf3UHJjGEL4jtWli6oii4EvbmVEVyK28TX4Qb/UOwfS5bITVQT92S5ZHMHm55+HpRcHA
 JdgtkVUGSmqlU69vYhAE6eBPb0i17Vt2IT+Fiur1oM49i2Hj0usOgRzOgKrtmg2X/9/o2v
 rUGZ4tZ0/OqLI9i/9RtMopJFVWxCtL4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-518--TtbxSHRO1OizIxnppIoTQ-1; Fri,
 17 Apr 2026 11:15:26 -0400
X-MC-Unique: -TtbxSHRO1OizIxnppIoTQ-1
X-Mimecast-MFC-AGG-ID: -TtbxSHRO1OizIxnppIoTQ_1776438925
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EA3911956055; Fri, 17 Apr 2026 15:15:24 +0000 (UTC)
Received: from localhost (unknown [10.44.48.66])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 34DEC18001D1; Fri, 17 Apr 2026 15:15:23 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Eric Farman
 <farman@linux.ibm.com>
Cc: qemu-s390x@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>, Thomas
 Huth <thuth@redhat.com>
Subject: Re: [PATCH] tests/functional/s390x: Add test for booting from a
 disk with 4k sectors
In-Reply-To: <20260323171423.112205-1-thuth@redhat.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Avril Crosse O'Flaherty"
References: <20260323171423.112205-1-thuth@redhat.com>
User-Agent: Notmuch/0.39 (https://notmuchmail.org)
Date: Fri, 17 Apr 2026 17:15:21 +0200
Message-ID: <87tst9ty7q.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 7
X-Spam_score: 0.7
X-Spam_bar: /
X-Spam_report: (0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Mon, Mar 23 2026, Thomas Huth <thuth@redhat.com> wrote:

> From: Thomas Huth <thuth@redhat.com>
>
> The DASD disks on s390x have a different sector size (4k) and use
> a different layout of the boot loader data compared to the usual
> "SCSI"-style disks with 512 sectors that are used with most modern
> guests. To make sure that there are no regressions with 4k disk
> booting, add a test case that uses a disk image with these 4k sectors
> and check that we can successfully show the boot menu and and load the
> right kernel in all supported cases.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/functional/s390x/meson.build     |   1 +
>  tests/functional/s390x/test_boot_4k.py | 138 +++++++++++++++++++++++++
>  2 files changed, 139 insertions(+)
>  create mode 100755 tests/functional/s390x/test_boot_4k.py

Thanks, queued to s390-next.


