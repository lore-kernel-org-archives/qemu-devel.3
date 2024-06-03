Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7AFEC27C44
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 09:02:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE3Z0-0000fo-Bm; Mon, 03 Jun 2024 05:01:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1sE3Yy-0000df-KU
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 05:01:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1sE3Yt-00055D-Dh
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 05:01:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717405262;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yJwqvL1t7ldby4TwVbl0UjKOgrf8xugbBrdHfK/iWP8=;
 b=imw/wB1d6xtDSVGCfcpG6kZLN/pZEmO9iccMHxcI/ZcTZq5wkCJTmuG75SdfLIajE+yoEU
 V8G7CZAMDq9uhX7yner9f287jJmoNly/7nU/hwk/ZIyU42dscj02mPvo4tORzuxtphx+Qo
 /h2y7G2U4Q8jZ+a6UiiTFE1e2U+Il7M=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-qCu1AvFSOGyNyx0soH6NQg-1; Mon, 03 Jun 2024 05:00:57 -0400
X-MC-Unique: qCu1AvFSOGyNyx0soH6NQg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4DF9F185A780;
 Mon,  3 Jun 2024 09:00:57 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.239])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A668E1C00A8E;
 Mon,  3 Jun 2024 09:00:56 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 8FE9D1800985; Mon,  3 Jun 2024 11:00:55 +0200 (CEST)
Date: Mon, 3 Jun 2024 11:00:55 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <eduardo@habkost.net>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Yanan Wang <wangyanan55@huawei.com>
Subject: Re: [PATCH 4/5] x86/loader: expose unpatched kernel
Message-ID: <lsfhpx3th7sxecpbbpq7ofvnlhp2r3dpzjb7ux54hzk6hidn5x@77mzennh3fes>
References: <20240411094830.1337658-1-kraxel@redhat.com>
 <20240411094830.1337658-5-kraxel@redhat.com>
 <20240602092541-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240602092541-mutt-send-email-mst@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Sun, Jun 02, 2024 at 09:26:09AM GMT, Michael S. Tsirkin wrote:
> On Thu, Apr 11, 2024 at 11:48:28AM +0200, Gerd Hoffmann wrote:
> > Add a new "etc/boot/kernel" fw_cfg file, containing the kernel without
> > the setup header patches.  Intended use is booting in UEFI with secure
> > boot enabled, where the setup header patching breaks secure boot
> > verification.
> > 
> > Needs OVMF changes too to be actually useful.
> > 
> > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> 
> So given we have this, do we still need patch 2?

With this merged to qemu plus related edk2 patches merged too OVMF will
stop using the patched linux kernel setup header fw_cfg file.  So, patch
#2 will not be essential for direct kernel boot to work correctly with
UEFI.

Nevertheless I'd consider patch #2 a clear bugfix.  Trying to patch
linux kernel setup header fields in binaries which are /not/ a linux
kernel doesn't make any sense.

take care,
  Gerd


