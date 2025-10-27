Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 050DCCCF9EA
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 11:57:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDLpV-00028b-3y; Mon, 27 Oct 2025 07:56:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vDLpS-00027h-Ls
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 07:56:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vDLpN-0008Df-DU
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 07:56:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761566152;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=BWxhTDCOh9MoSfT5VoNlOM8jI5PXrB412+iMQw22DkY=;
 b=dOQjWivTMO/8PTFVSG52Ji4EmkvG321T3fWaTb2NERdmHdzLPVESdkciNB8hU5fpy6+Jln
 R4d4LFpmkgE4bBa6icL7C5RLRjhXbiamwbFFI1pMH5J88YI9qSlJEtgrh+htPgYG0qAsMn
 UyfR1p9RtRjY0ewaoNDpwoY7bquLV1U=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-353-_nJZFntpPSS2WTphu9FYMA-1; Mon,
 27 Oct 2025 07:55:48 -0400
X-MC-Unique: _nJZFntpPSS2WTphu9FYMA-1
X-Mimecast-MFC-AGG-ID: _nJZFntpPSS2WTphu9FYMA_1761566147
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8949F1800BC1; Mon, 27 Oct 2025 11:55:46 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.35])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 87C421955F1B; Mon, 27 Oct 2025 11:55:43 +0000 (UTC)
Date: Mon, 27 Oct 2025 11:55:40 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jan =?utf-8?B?TMO8YmJl?= <jlu@pengutronix.de>,
 Jerome Forissier <jerome.forissier@linaro.org>
Subject: Re: [PATCH v5 2/6] hw/sd/sdcard: Allow user-instantiated eMMC
Message-ID: <aP9dvF1unTtLrSdQ@redhat.com>
References: <cover.1760702638.git.jan.kiszka@siemens.com>
 <90fc6201696fcf0e5fd0493365bc32b217aa9d6e.1760702638.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <90fc6201696fcf0e5fd0493365bc32b217aa9d6e.1760702638.git.jan.kiszka@siemens.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Oct 17, 2025 at 02:03:54PM +0200, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> Enable user-instantiation so that PCI-attached eMMCs can be created for
> virt machines, for QA purposes for the eMMC model itself and for complex
> firmware/OS integrations using the upcoming RPMB partition support.

IIUC, the 'emmc' device wants an 'sd-bus' but this commit talks about
it being PCI-attached ?

Can you elaborate on / illustrate the usage example for an end user ?

> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  hw/sd/sd.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index d1e1bb4f0e..305ea251cb 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -2928,8 +2928,6 @@ static void emmc_class_init(ObjectClass *klass, const void *data)
>      dc->desc = "eMMC";
>      dc->realize = emmc_realize;
>      device_class_set_props(dc, emmc_properties);
> -    /* Reason: Soldered on board */
> -    dc->user_creatable = false;
>  
>      sc->proto = &sd_proto_emmc;
>  
> -- 
> 2.51.0
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


