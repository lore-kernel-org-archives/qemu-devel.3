Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4534EDE9A0
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 16:07:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so3OT-0007q5-Fu; Tue, 10 Sep 2024 12:07:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1so3OQ-0007pQ-Fj
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 12:07:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1so3ON-000303-4D
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 12:07:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725984417;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eOC6MZJyOs7MU9E9KpWkOzfQL3Bi4o5aJ9iuyKs0c7E=;
 b=KLNBLmPUikCidL+V29EeZ2uRQJPIqhFrjB55kKaXyt9KwRMqu/UTYYl9MxzXMT3cXp95w/
 2i8lSqOlNb0XHUNDhiOOXVa2mrG3mr3NWe7VKXTAEV7vxf2oAkxhBUu2uV+oFQRc8T9AvH
 Vq3GIBw+UWF0Z7lusNQK1zLyUoolQP0=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-395-sxPBAYoJOXS5Li7MGoz43Q-1; Tue, 10 Sep 2024 12:06:54 -0400
X-MC-Unique: sxPBAYoJOXS5Li7MGoz43Q-1
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-6d73c1c8356so157627587b3.1
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 09:06:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725984413; x=1726589213;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eOC6MZJyOs7MU9E9KpWkOzfQL3Bi4o5aJ9iuyKs0c7E=;
 b=J5gmlZLjCXJR1IpNOKYe7y/wfepB3t8jXtyz3UoCdulPTjvX0qn8rc4iRtk6UkUWJn
 34hx7IbYwN9ED4ikKW8AzkjlAmnb8H6PC5vhj5hdxIoIYIrwLrShOzzL58u4NNdEfoG+
 pGvlytMoyPvR0BG8hVEnxbplOXJ67bI3BuQSjM6mqaM5KJP6tSML/Z4XG4A1ABZcLyzx
 rWPQpYlTqGf6DSgBtOO/T3QksxeTgLKDAO8IQBxNNnbcpZYMvVDW2cJGx9TPwKXpRR6+
 fDTwv6OQJyR2zYA+C+WrIctT9G2emQ7ObBgsvUYiYqjYwhlDwPjXZXDPuCS6g2IxWtWU
 epFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXMrzZFA+uo9WXrT9/N+P1apYHNZzgD25RLXX13tkxnw2+K3mvWmxt2Hgs25VHzCHkTmGoM9NtxM4m@nongnu.org
X-Gm-Message-State: AOJu0YxP9r4FYCOd74v5H4k8nHAMqR/SajEiaGqL9O+S4g/OQrZ7h6zI
 QOXttXCEdsRJjHR6RhbRrKT23jc4iKoCP6BcR8Sclgye1+oqjfbZ3tB6EdVdme3Yd830+btuEsE
 nlJG0Iw6PsXaCPTNcdo0WPUG7ra6qxOc5O6/9u6PdDF4hiHKlgwu+
X-Received: by 2002:a05:690c:350a:b0:6b2:7ff8:ca1 with SMTP id
 00721157ae682-6db4515443dmr148748567b3.22.1725984413543; 
 Tue, 10 Sep 2024 09:06:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEgVdOlR5+6n2K4mQRgD6GTqMqtI1GElrZPkB7ZqfaT5OgGQmo82FxwFTAHTZqL6nGbTgOqRQ==
X-Received: by 2002:a05:690c:350a:b0:6b2:7ff8:ca1 with SMTP id
 00721157ae682-6db4515443dmr148748057b3.22.1725984413046; 
 Tue, 10 Sep 2024 09:06:53 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-6db96491b4esm3405477b3.65.2024.09.10.09.06.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 09:06:52 -0700 (PDT)
Date: Tue, 10 Sep 2024 12:06:49 -0400
From: Peter Xu <peterx@redhat.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 12/17] migration/multifd: Device state transfer
 support - send side
Message-ID: <ZuBumSH-nZDzpCcQ@x1n>
References: <cover.1724701542.git.maciej.szmigiero@oracle.com>
 <fdcfd68dfcf3b20278a4495eb639905b2a8e8ff3.1724701542.git.maciej.szmigiero@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fdcfd68dfcf3b20278a4495eb639905b2a8e8ff3.1724701542.git.maciej.szmigiero@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Aug 27, 2024 at 07:54:31PM +0200, Maciej S. Szmigiero wrote:
> +bool multifd_queue_device_state(char *idstr, uint32_t instance_id,
> +                                char *data, size_t len)
> +{
> +    /* Device state submissions can come from multiple threads */
> +    QEMU_LOCK_GUARD(&queue_job_mutex);

Ah, just notice there's the mutex.

So please consider the reply in the other thread, IIUC we can make it for
multifd_send() to be a generic mutex to simplify the other patch too, then
drop here.

I assume the ram code should be fine taking one more mutex even without
vfio, if it only takes once for each ~128 pages to enqueue, and only take
in the main thread, then each update should be also in the hot path
(e.g. no cache bouncing).

> +    MultiFDDeviceState_t *device_state;
> +
> +    assert(multifd_payload_empty(device_state_send));
> +
> +    multifd_set_payload_type(device_state_send, MULTIFD_PAYLOAD_DEVICE_STATE);
> +    device_state = &device_state_send->u.device_state;
> +    device_state->idstr = g_strdup(idstr);
> +    device_state->instance_id = instance_id;
> +    device_state->buf = g_memdup2(data, len);
> +    device_state->buf_len = len;
> +
> +    if (!multifd_send(&device_state_send)) {
> +        multifd_send_data_clear(device_state_send);
> +        return false;
> +    }
> +
> +    return true;
> +}

-- 
Peter Xu


