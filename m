Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBA70CC6B2D
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 19:04:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH4GM-0005Ub-7S; Wed, 14 Oct 2026 15:03:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xH4GG-0005TZ-4i
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 15:03:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xH4GE-0005hs-F5
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 15:03:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792004613;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T0ptoZz/A+0LKGzEhuEmlWcS9wqSsrxj9GOpgkRHU5Q=;
 b=hWNlz1JXB9g52aacgG261D/VOkgJahxJwyh1QQq/ARmweExHN00lBYGjUW8CHctlusLLKB
 i0mb3KvmPaqfD+qghiqmN9gRkhLoRU6wOp+VEq16DqpkD5U1RSdTHEsQQ7e5PV9cIIhFbJ
 SFH5WisnQYXGheGLbUPXALGUrKJxMo8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-216-jDTHZGb7PAK7EkODPkXbvw-1; Wed,
 14 Oct 2026 19:03:21 +0000
X-MC-Unique: jDTHZGb7PAK7EkODPkXbvw-1
X-Mimecast-MFC-AGG-ID: jDTHZGb7PAK7EkODPkXbvw_1792004599
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2ABB31955BC5; Wed, 14 Oct 2026 19:03:02 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 13D821800345; Wed, 14 Oct 2026 19:02:59 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 7/8] hw/usb/redirect-server: Stream interrupt IN
 endpoints
From: marcandre.lureau@redhat.com
To: Jamin Lin <jamin_lin@aspeedtech.com>
Cc: marcandre.lureau@redhat.com, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, 
 Kane Chen <kane_chen@aspeedtech.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, 
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>, 
 Troy Lee <troy_lee@aspeedtech.com>
In-Reply-To: <20261014075011.2708115-8-jamin_lin@aspeedtech.com>
References: <20261014075011.2708115-1-jamin_lin@aspeedtech.com>
 <20261014075011.2708115-8-jamin_lin@aspeedtech.com>
Date: Wed, 14 Oct 2026 23:02:50 +0400
Message-Id: <179200457099.338496.3833991068027849650.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3049;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=FVEYG30lZfU141PLYJpGsuEL4k7geljAjbbn5uRCZ8c=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqz9HcxRHfHo8hcMsUboEH94G8akYhgAMBYh5kE
 x5lZqormdqJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCas/R3AAKCRDa6OEJdZac
 5Z/gD/4tgBzqv/2h0GJ8l8FPGbfXxPeTkDnSQoqpXlfrQdIpGchpiZpubMU0OyGgQgHXEI4IxTg
 vYGsVs7qcX48o3rtre7hNlpCuN6WT6E4ORjWB+Ny/JvZ0ok4Fna/T6t+Yr3fC3iWSyABJZkiFI4
 53uO7vaGymMpWn+IMFrpXsQbKHeEUg0GRJfl7uoW4f+0ZstMMagbHfgPa45CXO/fHKC0q1+9wSz
 q7I4NsHos6nmgJV7JDca6U+JdnvhqC4cwceGscSr2mXiaCtTOwDdsllN5TRjMBOkXLKiSSfctAH
 hKNskSFlMpPWA9TRLCiuYwOZABJeShoMamdBoLMmOcVh0od9KgeNheRcz8ueDG8PK2FdOKM1Hbx
 lJbpZ7MneKMBO8iMr7zWaR67+lLb1tw/7DkwWlzVh7ckxgoccj1ezqb4+NWeTPcTVOuJjemiBKu
 r503AhOjNe4yYgAQjNozDgrK6n2A9V1h+U0DFHvALVnHfgQU72b/EeYIIudp45fyQnk/QZP2pC8
 sy4cjjhG1nO5v0ihWhQ3USRbKwIHfafhkUpErvdxqTuRkCojOK4u5x/p8wKZJKWug/7I6ECNFtd
 bTylOvu5VUSLapHgFChG2zTtKzke8Sfpig305uO4bgRHLnp8EJYttyc7pjPa//sw6SqL/3n1Qni
 vfPAO3KMQ23ybxw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
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

> Interrupt IN is not a request and an answer in usbredir. The host asks
> once with start_interrupt_receiving. After that it expects a packet
> every time the device has data.
> 
> Park one IN packet on the device for each streaming endpoint. A device
> that answers USB_RET_ASYNC holds the packet and completes it when it
> has data. A device that answers USB_RET_NAK gives the packet back at
> once, so park a new one when the bus reports a wakeup on that endpoint.
> A slow timer parks one too, for a device that does not report a wakeup.
> 
> Wait for the endpoint's bInterval before parking the next one. Some
> devices answer every time. Without the wait we would ask as fast as
> the main loop runs, and the guest would get no time.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> Message-ID: <20261014075011.2708115-8-jamin_lin@aspeedtech.com>
>
> diff --git a/hw/usb/redirect-server.c b/hw/usb/redirect-server.c
> index bf5286b64996..c613147fbd0a 100644
> --- a/hw/usb/redirect-server.c
> +++ b/hw/usb/redirect-server.c
> @@ -56,6 +56,7 @@
>  #include "qemu/main-loop.h"
>  #include "qemu/module.h"
>  #include "migration/vmstate.h"
> +#include "qemu/timer.h"
>  #include "qemu/cutils.h"
>  #include "hw/core/sysbus.h"
>  #include "hw/usb/usb.h"
> @@ -82,16 +83,30 @@ OBJECT_DECLARE_SIMPLE_TYPE(USBRedirServer, USB_REDIR_SERVER)
>  #define USBREDIR_SERVER_MAX_EP 32
>  #define USBREDIR_SERVER_EP_IN_BASE 16
>  
> +/* An endpoint number is 4 bits, so 0 to 15. */
> +#define USBREDIR_SERVER_MAX_EP_NR 16
> +
>  /*
>   * The bulk length field is 32 bits, so the host can ask for up to 4 GB.
>   * This is the largest transfer accepted.
>   */
>  #define USBREDIR_SERVER_MAX_BULK (1 * MiB)
>  
> +/* Buffer size for an interrupt IN endpoint before its descriptor is seen. */
> +#define USBREDIR_SERVER_INTR_DEFAULT_LEN 64
> +
> +/*
> + * Ask again this often after an endpoint answered NAK. Most devices wake
> + * the bus when data arrives, and then the next ask happens at once. This
> + * timer is for the devices that do not wake the bus.
> + */
> +#define USBREDIR_SERVER_INTR_RETRY_MS 1000
> +
>  #define USBREDIR_SERVER_CTRL_SETUP 0
>  #define USBREDIR_SERVER_CTRL_STATUS 1
>  #define USBREDIR_SERVER_BULK 2
>  #define USBREDIR_SERVER_INTR 3
> +#define USBREDIR_SERVER_INTR_STREAM 4
>  
>  /* Which message answers the host when a control transfer ends. */
>  typedef enum {
> @@ -140,6 +155,16 @@ struct USBRedirServer {
>      bool host_connected;
>      bool device_announced;
>  
> +    /*
> +     * Interrupt IN streaming. intr_in_started is indexed by endpoint
> +     * number. intr_timer asks the device again, after the endpoint's
> +     * interval or after a NAK. intr_bh asks at once when the device says
> +     * it has data.
> +     */
> +    bool intr_in_started[USBREDIR_SERVER_MAX_EP_NR];
> +    QEMUBH *intr_bh;
> +    QEMUTimer *intr_timer;

Why not have one timer per ep?

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


