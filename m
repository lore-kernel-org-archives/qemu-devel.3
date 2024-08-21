Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 268C9C52D6F
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2024 11:35:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgjcS-0007Go-Da; Wed, 21 Aug 2024 07:35:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1sgjcN-0007G7-Vi
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 07:35:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1sgjcF-00004x-Pk
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 07:35:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724240102;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Qz9IHk3gcI3pfrc7vnzqZv3c50K/sWZJfTKFZkc53/I=;
 b=augzyYriKOJTqwuAoiJ8xWzZIjxW78ndHzrVa8CFUhe4z4/izxJY1m8ifdgF56nMIIkQus
 lIvPufiJsCvZCC8AX9/gNooD13C92OZznpKHkm3MHqRHTy98WfpsOLBuJKjBcY7gnQCCrf
 Qjy0VIGHmyzjgd/984nUZ347mk+qEGo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-402-ofXHeY5zNpaBXrl7DeLVuQ-1; Wed,
 21 Aug 2024 07:33:40 -0400
X-MC-Unique: ofXHeY5zNpaBXrl7DeLVuQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3B5DB19560A6; Wed, 21 Aug 2024 11:33:38 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.194.20])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 81B101955F66; Wed, 21 Aug 2024 11:33:36 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 2693818011E8; Wed, 21 Aug 2024 13:33:34 +0200 (CEST)
Date: Wed, 21 Aug 2024 13:33:34 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Xianglai Li <lixianglai@loongson.cn>
Cc: qemu-devel@nongnu.org, Song Gao <gaosong@loongson.cn>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Bibo Mao <maobibo@loongson.cn>
Subject: Re: [PATCH] roms: Support compile the efi bios for loongarch
Message-ID: <m7tgg3ita6cheqbnzfjmndtknmemr4hqv7n3b57jhyb2iuyxkz@chczgemq4vzf>
References: <20240724022245.1317884-1-lixianglai@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240724022245.1317884-1-lixianglai@loongson.cn>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.138,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Wed, Jul 24, 2024 at 10:22:45AM GMT, Xianglai Li wrote:
> Added loongarch UEFI BIOS support to compiled scripts.

>   But now, the UEFI code of loongarch virtual machine has been migrated
> from edK2-platform to edk2 repository. The migration work was completed
> and merged into edk2 main line on 2024/6/18.
>   The edk2-stable202408 release will come with support for loongarch,So
> I modified my previous patch and submitted it.

Patch looks good, but should be applied only after updating the edk2
submodule to edk2-stable202408 so we don't break the firmware builds.

I'll add the patch to the next edk2 update.

take care,
  Gerd


