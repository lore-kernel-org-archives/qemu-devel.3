Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7274E7716D
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 16:17:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJEXm-0003tV-1X; Thu, 05 Dec 2024 11:17:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tJEXk-0003tL-Ld
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 11:17:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tJEXj-0007ck-5V
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 11:17:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733415450;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DVyj4pG4LjmaHHy74hMqAB/zszH+J7Wu0iE26zyIm2E=;
 b=RXKmHXkdB840wALeltFtFGZH61nVuzIRgCM8KIIaDDvNnQqJ6KIRXmHHWvPXp6WOkhkErf
 FCd1dCVnw4Si3OKnM/YoNQ0GK67ET2PXnwe5K5YJBpvuMH9zpsi77MVBm3AZ+7C2ZOMwaZ
 0vXKHcr4Wgut8pRj1wxlb6KWE8bXTS0=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-M44Fsgm2MHO5uDNOpBsBzQ-1; Thu, 05 Dec 2024 11:17:25 -0500
X-MC-Unique: M44Fsgm2MHO5uDNOpBsBzQ-1
X-Mimecast-MFC-AGG-ID: M44Fsgm2MHO5uDNOpBsBzQ
Received: by mail-il1-f200.google.com with SMTP id
 e9e14a558f8ab-3a7cff77f99so19666045ab.3
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 08:17:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733415445; x=1734020245;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DVyj4pG4LjmaHHy74hMqAB/zszH+J7Wu0iE26zyIm2E=;
 b=pTY4nEWarANaRB6KdDn7oIjdiQZMMFhWUPXV/cvzn1ZSnHpXvrNgh7cm51htFDAtzi
 6qn5BFidI6XO8I+nUrIRQClYhoG1aueLl2xU5Nh1Jra4a0FoGLIKjCS+h8X9FMZ8c1RJ
 JSCB3MVjrMXt/IOeyOvTVYWGnP3c+yhpLrBkWIx10G9lxfnPUtFlAbyfVug2B8Jc8hbZ
 LKobvcwtTHBG9BVJE5jAwfAwtdfygFS1x8LiUVnnw1c3hxSjv65xEeu9B9fGO8T1QF8v
 ITT3LV5rThEEeyfICpnpD+ie9hpVypTIUtz7X5cMC+351B4Fdk6gBhjy0dAxt3tLz6iV
 rslg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVP9KPHjxlO7GlPOdIU2PJcVaQgX8t61q3RUp5A+GI3kVn3NZ/ZRryTfqDUOvFNy+z00DYtRpOkIr+@nongnu.org
X-Gm-Message-State: AOJu0YzuR8eron5BykHZmnmhg5yXZPJceg0MLCpzS3Pu8oBKrAAZYfBA
 cfe6KzIDViZoW+dAAh+zX315PvHIdL9IgHoZ683aLxeuQPqBeJGiadXqWsalRdz9l9OodSOQsAz
 zF/Q4mR2cd0P1EhllTH9oBqAp8vef5hweUlPLvuX0Me5pH5eobODB
X-Gm-Gg: ASbGncuKC39xvRswNzM7eLNaUplWWnKFIaEHYac1eA553WtvnkzUY2kdfyIj95s7JSU
 KCoDEIIiy/ktGsYrTxnsoyYaX4GKQNpYdqm36YRLmYjqYm02zhiHrjBfdMogZFDErsQM6duXzbQ
 VLkoSDAqCC5YqmPaessg7EHmJydjeCs1kiXLzcMlZxqcim9OyoTAufc+9vspYFm4L+6uKnCxy6l
 oUcHY2woDp57tX1SLphM1nfNeAMPEPEZTqmNORUh4WEi30JzrkWTAKxwBsORyV5aZl70CLN1f5c
 SuRDOWJcbhs=
X-Received: by 2002:a05:6e02:20ea:b0:3a3:b3f4:af42 with SMTP id
 e9e14a558f8ab-3a7f9a485c7mr109845475ab.7.1733415445056; 
 Thu, 05 Dec 2024 08:17:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHArBqLUVCgN8VjxWFAdLkH7HB1AgS1AJWpMvZt1yKu/wF1Nce5YKOmQZnAliXQfL4ouXA5KA==
X-Received: by 2002:a05:6e02:20ea:b0:3a3:b3f4:af42 with SMTP id
 e9e14a558f8ab-3a7f9a485c7mr109845285ab.7.1733415444727; 
 Thu, 05 Dec 2024 08:17:24 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a808e1eb4bsm5090565ab.49.2024.12.05.08.17.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2024 08:17:24 -0800 (PST)
Date: Thu, 5 Dec 2024 11:17:22 -0500
From: Peter Xu <peterx@redhat.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 11/24] migration/multifd: Make multifd_send() thread
 safe
Message-ID: <Z1HSEor05q3XYH2m@x1n>
References: <cover.1731773021.git.maciej.szmigiero@oracle.com>
 <20fadbcc46cc7cc698ce24e83a3e0fc0c35cd2d8.1731773021.git.maciej.szmigiero@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20fadbcc46cc7cc698ce24e83a3e0fc0c35cd2d8.1731773021.git.maciej.szmigiero@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Sun, Nov 17, 2024 at 08:20:06PM +0100, Maciej S. Szmigiero wrote:
> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
> 
> multifd_send() function is currently not thread safe, make it thread safe
> by holding a lock during its execution.
> 
> This way it will be possible to safely call it concurrently from multiple
> threads.
> 
> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

One nitpick:

> ---
>  migration/multifd.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/migration/multifd.c b/migration/multifd.c
> index 9578a985449b..4575495c8816 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -50,6 +50,10 @@ typedef struct {
>  
>  struct {
>      MultiFDSendParams *params;
> +
> +    /* multifd_send() body is not thread safe, needs serialization */
> +    QemuMutex multifd_send_mutex;
> +
>      /*
>       * Global number of generated multifd packets.
>       *
> @@ -331,6 +335,7 @@ static void multifd_send_kick_main(MultiFDSendParams *p)
>   */
>  bool multifd_send(MultiFDSendData **send_data)
>  {
> +    QEMU_LOCK_GUARD(&multifd_send_state->multifd_send_mutex);

Better move this after the varaible declarations to be clear..

Perhaps even after multifd_send_should_exit() because reading that doesn't
need a lock, just in case something wanna quit but keep stuck with the
mutex.

>      int i;
>      static int next_channel;
>      MultiFDSendParams *p = NULL; /* make happy gcc */
> @@ -508,6 +513,7 @@ static void multifd_send_cleanup_state(void)
>      socket_cleanup_outgoing_migration();
>      qemu_sem_destroy(&multifd_send_state->channels_created);
>      qemu_sem_destroy(&multifd_send_state->channels_ready);
> +    qemu_mutex_destroy(&multifd_send_state->multifd_send_mutex);
>      g_free(multifd_send_state->params);
>      multifd_send_state->params = NULL;
>      g_free(multifd_send_state);
> @@ -853,6 +859,7 @@ bool multifd_send_setup(void)
>      thread_count = migrate_multifd_channels();
>      multifd_send_state = g_malloc0(sizeof(*multifd_send_state));
>      multifd_send_state->params = g_new0(MultiFDSendParams, thread_count);
> +    qemu_mutex_init(&multifd_send_state->multifd_send_mutex);
>      qemu_sem_init(&multifd_send_state->channels_created, 0);
>      qemu_sem_init(&multifd_send_state->channels_ready, 0);
>      qatomic_set(&multifd_send_state->exiting, 0);
> 

-- 
Peter Xu


