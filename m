Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8F57C54F4C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 08:13:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wocwR-0006ym-Oe; Tue, 28 Jul 2026 04:13:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1wocwP-0006yL-So
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 04:13:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1wocwO-0006CG-Hq
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 04:13:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785226410;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IWje6h96RoGE6SUXT2enEoV/hzyPl4TDb5ERa3kDIsI=;
 b=bqUxMDtWcIBQQsJOHebBfy2kkoMko3TuV3ollp0oq8PsJJlm06aBAQgzWjDq2fk4LlYY8c
 XfnvFQ+A25f0KNnJIsG8G/QPCOgXdfBtvN1+zezOgJKiBjBx4Pg3Ncapju06qCCI16vv5d
 aVDe9N9Uc3ZcKqCL/yw5VJPzkvG4EBY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-654-ufgW1aFyPz6sdPXUC6iXKQ-1; Tue,
 28 Jul 2026 04:13:29 -0400
X-MC-Unique: ufgW1aFyPz6sdPXUC6iXKQ-1
X-Mimecast-MFC-AGG-ID: ufgW1aFyPz6sdPXUC6iXKQ_1785226408
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EFCFE195608E; Tue, 28 Jul 2026 08:13:27 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.49.247])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5FABC19560AB; Tue, 28 Jul 2026 08:13:27 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 2F08518000A2; Tue, 28 Jul 2026 10:13:26 +0200 (CEST)
Date: Tue, 28 Jul 2026 10:13:26 +0200
From: Gerd Hoffman <kraxel@redhat.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: Alex Graf <graf@amazon.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 5/9] hw/misc/vmlaunchupdate: Introduce hypervisor
 fw-cfg interface support
Message-ID: <amhkiU5giwE--OdD@sirius.home.kraxel.org>
References: <20260714024557.204578-1-anisinha@redhat.com>
 <20260714024557.204578-6-anisinha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714024557.204578-6-anisinha@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Jul 14, 2026 at 08:15:24AM +0530, Ani Sinha wrote:
> VM launch update is a mechanism where the virtual machines can use IGVM
> file bundle to boot into a trusted execution environment without
> having to depend on a untrusted party to provide the IGVM bundle or firmware
> image. This is particularly useful for confidential virtual machines that
> are deployed in the cloud where the tenant and the cloud provider are two
> different entities. In this scenario, virtual machines can bring their own
> trusted IGVM file containing a trusted firmware image
> bundled as a part of their filesystem and then use this hypervisor interface
> to update to a trusted and deterministic boot state.
> This also allows the guests to have a consistent measurements on the firmware
> image.
> 
> Currently, this mechanism only works if the VM was started with IGVM in the
> first place.
> 
> This change introduces support for the fw-cfg based hypervisor interface
> and the corresponding device. The interface is made generic
> enough so that guests are free to use their own ABI to pass required
> information between initial and trusted execution contexts (where they are
> running their own trusted boot state) without the hypervisor getting
> involved in between.
> 
> Currently, this device is only supported for x86 machines. Presence of
> IGVM host libraries is also required for parsing IGVM files. Hence, the device
> cannot be initialized for other machine types or hosts where IGVM support
> is not present. Trying to initialize it for arm for example will lead to failure:
> 
> $ ./qemu-system-arm -device vm-launch-update -machine virt
> qemu-system-arm: -device vmfwupdate: This machine does not support vm-launch-update device
> 
> Functional and qtests will be added in a subsequent patch.
> 
> CC: Alex Graf <graf@amazon.com>
> CC: Gerd Hoffman <kraxel@redhat.com>

Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>


