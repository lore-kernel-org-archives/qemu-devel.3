Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0607F9B601
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 09:54:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFUHE-00038b-T0; Wed, 22 Apr 2026 05:53:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1wFUHD-00037Z-8H
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 05:53:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1wFUHB-0005EH-UR
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 05:53:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776851625;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mpLL2JsAvlLGdZ0LkOdNtXVSOtggLdChHixrjvr2xpI=;
 b=cYTyfCMTPRgyx5t8jz1a3bUP9aYZv70Hx4kb+uCqFtiFu3s8aZcuowo1fKAOAxj77YpyFK
 9z5+0I1tcX2/DRCWxzxRK91XUaRpyHqXNPdlxfo6U5uZjP5du3ZPhfFeJo8T7HRRdMqXpj
 AeINDfPgBbjMzs1EjrstpHtgcXr0Jqc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-660-vHFdUsUXOoeiwSuhiVmAvQ-1; Wed,
 22 Apr 2026 05:53:40 -0400
X-MC-Unique: vHFdUsUXOoeiwSuhiVmAvQ-1
X-Mimecast-MFC-AGG-ID: vHFdUsUXOoeiwSuhiVmAvQ_1776851618
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EA6231956095; Wed, 22 Apr 2026 09:53:37 +0000 (UTC)
Received: from localhost (dhcp-192-224.str.redhat.com [10.33.192.224])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C6F7E3000C15; Wed, 22 Apr 2026 09:53:36 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Jaehoon Kim <jhkim@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, Jaehoon Kim <jhkim@linux.ibm.com>, Mohamed
 Mediouni <mohamed@unpredictable.fr>
Subject: Re: [PATCH v2 1/1] hw/s390x/ccw: Disable legacy virtio-pci by
 default (v11.1+)
In-Reply-To: <20260420144759.2970726-2-jhkim@linux.ibm.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Avril Crosse O'Flaherty"
References: <20260420144759.2970726-1-jhkim@linux.ibm.com>
 <20260420144759.2970726-2-jhkim@linux.ibm.com>
User-Agent: Notmuch/0.39 (https://notmuchmail.org)
Date: Wed, 22 Apr 2026 11:53:34 +0200
Message-ID: <87y0ifs4m9.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, Apr 20 2026, Jaehoon Kim <jhkim@linux.ibm.com> wrote:

> On the s390 Linux kernel, IO_SPACE_LIMIT has been 0 since the initial
> zPCI implementation (commit cd24834130ac "s390/pci: base support"),
> making I/O BARs unusable.
>
> However, when virtio-pci devices operate in transitional mode, QEMU
> unconditionally exposes the legacy interface via BAR0. This results in
> firmware warnings during PCI enumeration, such as:
>
>   pci 0005:00:00.0: [Firmware Bug]: BAR 0: invalid; can't size
>
> even though BAR0 is never usable on the s390 kernel.
>
> Close this gap by disabling legacy virtio-pci support starting from
> machine version 11.1. This effectively makes virtio-pci devices
> non-transitional and prevents the creation of the unusable legacy I/O
> BAR.
>
> This introduces s390x-specific global compatibility properties that
> set disable-legacy=on as the default for virtio-pci devices. Machine
> versions v11.0 and earlier set disable-legacy=off to maintain their
> original default behavior (legacy support enabled), ensuring VMs
> created with those versions continue to work identically.
>
> Users can override the default on the command line if needed:
>   - On v11.1+: -global virtio-pci.disable-legacy=off (to enable legacy)
>   - On v11.0-: -global virtio-pci.disable-legacy=on (to disable legacy)
>
> Signed-off-by: Jaehoon Kim <jhkim@linux.ibm.com>
> Reviewed-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> ---
>  hw/s390x/s390-virtio-ccw.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)

Thanks, queued to s390-next.


