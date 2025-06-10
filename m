Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 890DCC5B543
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 16:46:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uP26k-0001oS-1V; Tue, 10 Jun 2025 12:45:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uOzt0-0006b2-4z
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 10:23:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uOzsx-0004rN-Ba
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 10:23:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749565410;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Jy+rAtJo2LcCemA4cuJSU6u81+m1bjdr9ng6rBrK9p0=;
 b=iB735FBjewI6RwPqOkFO9tZsWW5OrJX09g2LMJLX+z+mHpYt3gQWVjsYMQrTVyjnmFi99I
 V0g7ZdTJTME4gw/MqZF+pRBj1mzBC3ml3Z8eA+LZ0bGeLDjD5h3rdhAnzjXwDGVmu8Iwnx
 dTxj/XRhUR6OBeRQanoOOO+ru7Hi5IM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-99-w-We82axPGechgKDqabtGQ-1; Tue,
 10 Jun 2025 10:23:27 -0400
X-MC-Unique: w-We82axPGechgKDqabtGQ-1
X-Mimecast-MFC-AGG-ID: w-We82axPGechgKDqabtGQ_1749565406
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E534118002A2; Tue, 10 Jun 2025 14:23:25 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.87])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8178519560A3; Tue, 10 Jun 2025 14:23:22 +0000 (UTC)
Date: Tue, 10 Jun 2025 15:23:19 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH 11/31] hw/audio/gus: skip automatic zero-init of large
 array
Message-ID: <aEg_1x61XGQn4WaT@redhat.com>
References: <20250610123709.835102-1-berrange@redhat.com>
 <20250610123709.835102-12-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250610123709.835102-12-berrange@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Mistake in $SUBJECT - should be 'hw/audio/marvell_88w8618:' prefix

On Tue, Jun 10, 2025 at 01:36:49PM +0100, Daniel P. Berrangé wrote:
> The 'mv88w8618_audio_callback' method has a 4k byte array used for
> copying data between the audio backend and device. Skip the automatic
> zero-init of this array to eliminate the performance overhead in
> the I/O hot path.
> 
> The 'buf' array will be fully initialized when reading data from
> device memory.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  hw/audio/marvell_88w8618.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/audio/marvell_88w8618.c b/hw/audio/marvell_88w8618.c
> index 6d3ebbb0c8..c5c79d083a 100644
> --- a/hw/audio/marvell_88w8618.c
> +++ b/hw/audio/marvell_88w8618.c
> @@ -66,7 +66,7 @@ static void mv88w8618_audio_callback(void *opaque, int free_out, int free_in)
>  {
>      mv88w8618_audio_state *s = opaque;
>      int16_t *codec_buffer;
> -    int8_t buf[4096];
> +    QEMU_UNINITIALIZED int8_t buf[4096];
>      int8_t *mem_buffer;
>      int pos, block_size;
>  
> -- 
> 2.49.0
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


