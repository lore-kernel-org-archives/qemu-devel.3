Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3288FE7716D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 21:32:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIwyo-000397-FN; Wed, 04 Dec 2024 16:32:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tIwyl-00037z-EJ
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 16:32:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tIwyj-0003lW-Uc
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 16:32:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733347932;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7Sb97tRizMi83Un98vW8X7x0e8SD/WxJuAqjYbBZOZk=;
 b=RSXdzABns2F8VAvquDrPSnMWRHyt39dmfvrkxX5X8QlvM84iQ6GXSRETO388G9zzfgkoh7
 CO6nflLNjl0Y3Bl5N7alH4h3JZ+M1BSDPV5B5PwQGZyvfqo2eEnzudZ2EVi+Br+M/IdRzG
 llHw411xjUvqfkvj5l6K9bzMD99QTDs=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-263-UA8uXe2TObqcAjgRBD1KZw-1; Wed, 04 Dec 2024 16:32:10 -0500
X-MC-Unique: UA8uXe2TObqcAjgRBD1KZw-1
X-Mimecast-MFC-AGG-ID: UA8uXe2TObqcAjgRBD1KZw
Received: by mail-il1-f200.google.com with SMTP id
 e9e14a558f8ab-3a7c729bfbaso1849495ab.0
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2024 13:32:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733347929; x=1733952729;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7Sb97tRizMi83Un98vW8X7x0e8SD/WxJuAqjYbBZOZk=;
 b=YucY9U4SrhN8SQxDlgrauxo+nkksFIw8mH5WzYXsa3Gda+IIpHnDyQ5l7tMxSMbrcR
 bR7OzzNnK2Ijf12qEBOOtTmZFebxaRDMVLNNuDhk1wvOQcwb30a7O67wC6r1laGlGldj
 WlPjpPTWNzKDtX/YRvVscZM8fwqDB6hIUSsFfP9GePsVjghDO0hHPaOLfu6OZEkNh3ry
 7ZJgiRIihPy42o31AhOyVxttGPxGupbfNGDdQWVRZ7F2ccNzD3pP6YKVBghm6vcTb+C2
 LrOvQ2qFwzpDQG/J+SQ9Y1XC+pE/uLjm+sg11JsVh3mbhhGoT+PDKYjV12iSmMewHak6
 p1KQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUoiJV9dTjFmndBKYsf843kH1gTuI5APlDD5lBoyoMUrn/muUS7ffzJQU13F5CGgpMyCGC9RH7B3PY2@nongnu.org
X-Gm-Message-State: AOJu0YwH2L34ui43coyv8GJVMbSRMCD14sY1Y5SYAq8v7KHPkdmBErOu
 xudkReYRnRDoxdzUx65D0mJfUM/TN/TYN9PYnAyyEIP/DFNDpTSklXotbGmUpKbGIXb78SQcr/J
 +1wGzkx1Ks/mqhWh/OwlsE6nZ+sftOfSj46qjkgwYEiaKNHFxmeJL
X-Gm-Gg: ASbGncsLas4qjUR175DNLU8padpv4kDXDB5tz8KPp4D9Gi2xT5ELUNngQG4kMNYJLjm
 scdl3+YjatTIwFmagbIY+VKpcte7C31NmEBMEoJVy5u2GwE9dJNLZ102FPTKhuOzW9RoBLk4hRG
 YgR77J4Nwtu0KGEZ+XN9IWAKBOBEinq0Ev3bo+GqUu1pIh6pHvSUuoAgo233nU7/AIPfvJrjGoN
 JwwsV2CJ/AmLSERYvYHBX/RzDSvRCdRIEksIOA/+fVMDg/gST2LiZtO5UtuPRfqwJ6JoOgG4b/G
 ZlyB5UCYuOE=
X-Received: by 2002:a05:6e02:144d:b0:3a0:9c99:32d6 with SMTP id
 e9e14a558f8ab-3a7f9aa4ffcmr94472615ab.24.1733347929402; 
 Wed, 04 Dec 2024 13:32:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF4e6BWwJGmpjmUxWwdyNO1s/WiSOA1+S0plLYSSIW/bKcvG+ECU2+hC6xaqs4LJVgiQCkPrA==
X-Received: by 2002:a05:6e02:144d:b0:3a0:9c99:32d6 with SMTP id
 e9e14a558f8ab-3a7f9aa4ffcmr94472435ab.24.1733347929101; 
 Wed, 04 Dec 2024 13:32:09 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a808d8f843sm281885ab.15.2024.12.04.13.32.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Dec 2024 13:32:08 -0800 (PST)
Date: Wed, 4 Dec 2024 16:32:06 -0500
From: Peter Xu <peterx@redhat.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 06/24] migration: Add qemu_loadvm_load_state_buffer()
 and its handler
Message-ID: <Z1DKVpGEzp2X4oOr@x1n>
References: <cover.1731773021.git.maciej.szmigiero@oracle.com>
 <d791cb76e8c43a30b49758ed641bf566f5325e2a.1731773021.git.maciej.szmigiero@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d791cb76e8c43a30b49758ed641bf566f5325e2a.1731773021.git.maciej.szmigiero@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
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

On Sun, Nov 17, 2024 at 08:20:01PM +0100, Maciej S. Szmigiero wrote:
> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
> 
> qemu_loadvm_load_state_buffer() and its load_state_buffer
> SaveVMHandler allow providing device state buffer to explicitly
> specified device via its idstr and instance id.
> 
> Reviewed-by: Fabiano Rosas <farosas@suse.de>
> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

One nitpick:

> ---
>  include/migration/register.h | 17 +++++++++++++++++
>  migration/savevm.c           | 23 +++++++++++++++++++++++
>  migration/savevm.h           |  3 +++
>  3 files changed, 43 insertions(+)
> 
> diff --git a/include/migration/register.h b/include/migration/register.h
> index ff0faf5f68c8..39991f3cc5d0 100644
> --- a/include/migration/register.h
> +++ b/include/migration/register.h
> @@ -229,6 +229,23 @@ typedef struct SaveVMHandlers {
>       */
>      int (*load_state)(QEMUFile *f, void *opaque, int version_id);
>  
> +    /* This runs outside the BQL. */
> +
> +    /**
> +     * @load_state_buffer
> +     *
> +     * Load device state buffer provided to qemu_loadvm_load_state_buffer().
> +     *
> +     * @opaque: data pointer passed to register_savevm_live()
> +     * @buf: the data buffer to load
> +     * @len: the data length in buffer
> +     * @errp: pointer to Error*, to store an error if it happens.
> +     *
> +     * Returns zero to indicate success and negative for error
> +     */
> +    int (*load_state_buffer)(void *opaque, char *buf, size_t len,
> +                             Error **errp);
> +
>      /**
>       * @load_setup
>       *
> diff --git a/migration/savevm.c b/migration/savevm.c
> index a254c38edcca..1f58a2fa54ae 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -3085,6 +3085,29 @@ int qemu_loadvm_approve_switchover(void)
>      return migrate_send_rp_switchover_ack(mis);
>  }
>  
> +int qemu_loadvm_load_state_buffer(const char *idstr, uint32_t instance_id,
> +                                  char *buf, size_t len, Error **errp)

Suggest to always return bool as success/fail, especially when using
Error**.

> +{
> +    SaveStateEntry *se;
> +
> +    se = find_se(idstr, instance_id);
> +    if (!se) {
> +        error_setg(errp,
> +                   "Unknown idstr %s or instance id %u for load state buffer",
> +                   idstr, instance_id);
> +        return -1;
> +    }
> +
> +    if (!se->ops || !se->ops->load_state_buffer) {
> +        error_setg(errp,
> +                   "idstr %s / instance %u has no load state buffer operation",
> +                   idstr, instance_id);
> +        return -1;
> +    }
> +
> +    return se->ops->load_state_buffer(se->opaque, buf, len, errp);
> +}
> +
>  bool save_snapshot(const char *name, bool overwrite, const char *vmstate,
>                    bool has_devices, strList *devices, Error **errp)
>  {
> diff --git a/migration/savevm.h b/migration/savevm.h
> index 4d402723bc3c..b5a4f8c8b440 100644
> --- a/migration/savevm.h
> +++ b/migration/savevm.h
> @@ -71,4 +71,7 @@ int qemu_loadvm_approve_switchover(void);
>  int qemu_savevm_state_complete_precopy_non_iterable(QEMUFile *f,
>          bool in_postcopy, bool inactivate_disks);
>  
> +int qemu_loadvm_load_state_buffer(const char *idstr, uint32_t instance_id,
> +                                  char *buf, size_t len, Error **errp);
> +
>  #endif
> 

-- 
Peter Xu


