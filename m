Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62737C83030
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 01:37:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWPvR-0005Pj-KM; Mon, 30 Jun 2025 21:36:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1uWPvH-0005PM-3V
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 21:36:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1uWPv8-0006pU-Ss
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 21:36:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751333783;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tfee1cz6vrrt0kqurbaEHqN1GcKcioLQZwEv3dVpFHw=;
 b=DpdKqesleHZF3ThlcxmMo5mP3tAJFmwrSm5/VnZPAbHusGuIZiMS1YJr4ORTuUqGfe9P0j
 nu+CwKwLmKkSJDQ+9UTL6GWvwZYDL13ELbvfrh06mzN+UhbQTu6MccASVAK1Rd4ndBuQ5q
 KEUIC6DhE5i+qYMvV2RI0h1Q++F3NZY=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-27-jYVaq0e-OXqe5MIL5s2SZA-1; Mon, 30 Jun 2025 21:36:20 -0400
X-MC-Unique: jYVaq0e-OXqe5MIL5s2SZA-1
X-Mimecast-MFC-AGG-ID: jYVaq0e-OXqe5MIL5s2SZA_1751333780
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-b115fb801bcso6176586a12.3
 for <qemu-devel@nongnu.org>; Mon, 30 Jun 2025 18:36:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751333779; x=1751938579;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tfee1cz6vrrt0kqurbaEHqN1GcKcioLQZwEv3dVpFHw=;
 b=S1R4jY7ZvYtsKn2129T03qkKuYRftBMnE1w5O+mzgfbPagQ4monNJerWKgjeOMfMJy
 Q3bRac5KDfgH8+VScrqIlJ2tLkfvGuHd+KehussnTnMItV3XBqZWITC3oh70wFO/YXSk
 oDWk0t5MkSI1zxw219yuKDNtmvRtauh7v/G70+SWl2z1odutJ+3rgIIjZdw+SoKk7yA2
 a5/+3pAf+m4/eM+d5fhUu8QQrWn0sBiyfoKnB8CcFHKN9m3zwIqX49tzHbtdKGE74qvJ
 +QgTlsDg09MI3O4Lw8jLn1G99RmcwOW8nqotIgwe151LarLVLGda0TozkVfg+7bB8tvJ
 v6SQ==
X-Gm-Message-State: AOJu0Yz1NKJSIL0gvR+sTAWcjLqoxk90afUFMj2bajv+WSBR7glApg+M
 zwna+dfp5d06eck9kt343ItxB/JoTRWpFq3+frEgVKMifnkZ4EfKNoXfmGCw2vdBafeMFCOkMjE
 +hGMZU2AmuRUs4aTQpSj2GbVlwCWu1R1wjPs21kHB1Mh92rrjWC1CdJwmHTDJMMZuOJKDIcHhcc
 flqEN/fYXqP+0QgDfTpaqDch83Cv/eGF4=
X-Gm-Gg: ASbGncvFW8UCmHwJK7SQwpVwL71/CDXraNuKkOYpTyWw9/L3AxHnLU2RARGak2wqSYR
 swwKRKE7828DHO50JORwPQ2mEWThSqA6aKmCNzL124yesqPXw5zBNN7nLuzh/+bbcq0hS2rR6Ju
 I9
X-Received: by 2002:a17:90b:1c09:b0:311:c1ec:7d05 with SMTP id
 98e67ed59e1d1-318c93274fdmr22108896a91.35.1751333779546; 
 Mon, 30 Jun 2025 18:36:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGpiVU8V2CYrcqLK4jGJL6EC6YBgXIRaGqjr0s88VUfmc4xKyfmQtw7MljWt3r+I+JKe9miJZGi8G59DY6lhAI=
X-Received: by 2002:a17:90b:1c09:b0:311:c1ec:7d05 with SMTP id
 98e67ed59e1d1-318c93274fdmr22108866a91.35.1751333779038; Mon, 30 Jun 2025
 18:36:19 -0700 (PDT)
MIME-Version: 1.0
References: <20250618155718.550968-1-lvivier@redhat.com>
 <20250618155718.550968-4-lvivier@redhat.com>
In-Reply-To: <20250618155718.550968-4-lvivier@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 1 Jul 2025 09:36:07 +0800
X-Gm-Features: Ac12FXwNTEpS4XTmv-lC0f4xtvphEvDHtuIBeEVvBaKwWUjN3JXzhvyFKf69TQ4
Message-ID: <CACGkMEtsVmH-knYwbB1UkWJ6fw4fYyUk13x1nb4WP_2Cis=O+w@mail.gmail.com>
Subject: Re: [PATCH v2 03/10] net: Introduce helper to identify vhost-user
 clients
To: Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Stefan Weil <sw@weilnetz.de>, 
 Stefano Garzarella <sgarzare@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>, Eric Blake <eblake@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Wed, Jun 18, 2025 at 11:57=E2=80=AFPM Laurent Vivier <lvivier@redhat.com=
> wrote:
>
> Currently, several parts of the codebase check if a network client is a
> vhost-user backend by directly comparing its type against the
> NET_CLIENT_DRIVER_VHOST_USER enum. This creates a tight coupling
> between virtio/vhost-net drivers and the internal implementation
> details of the vhost-user net client.
>
> To improve abstraction and reduce this coupling, this patch introduces a
> new helper function, qemu_is_vhost_user(). This function allows
> callers to query if a client is of the vhost-user type without
> needing to know about the specific enum value.

I'm not sure it's worth doing the change, for example, it works only
for vhost-user, and the rest are still being done via the enum.

Thanks


