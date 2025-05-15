Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76EF0C54754
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 07:37:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFT8q-0007zo-JC; Thu, 15 May 2025 03:36:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uFT8o-0007zf-Ry
 for qemu-devel@nongnu.org; Thu, 15 May 2025 03:36:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uFT8m-0005M2-B9
 for qemu-devel@nongnu.org; Thu, 15 May 2025 03:36:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747294585;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=QTff/lNpSkK4YBe7NK+nN1jY4NvLldH2owcY8su8puA=;
 b=ako3Hvrku9YKVKOC0AVzJFhY+MhJmHsfW+zKdaGfxGJ+yRIbS4M+2TdBbNxVYN0CDoFM8q
 1tWhbGYdbXDkjLdIyuhR4T3GjUTaUw0Hhu0t6ONCDEfCMApx8ulOnvYbFMc9IKz+dDUN1k
 4/U4WNgjrjl43GgnOp6ddGrl7c7skI4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-26-qf-Q6TGUM4K4_qitF5_54Q-1; Thu, 15 May 2025 03:36:24 -0400
X-MC-Unique: qf-Q6TGUM4K4_qitF5_54Q-1
X-Mimecast-MFC-AGG-ID: qf-Q6TGUM4K4_qitF5_54Q_1747294583
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-441c122fa56so2553345e9.2
 for <qemu-devel@nongnu.org>; Thu, 15 May 2025 00:36:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747294583; x=1747899383;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QTff/lNpSkK4YBe7NK+nN1jY4NvLldH2owcY8su8puA=;
 b=ruPjyqU2fReKJXFfPL04jv8h543H3FIwg5glRfMZ27NiANOc8q+lE5UQ6iYv+5QZcv
 y8ZLwPb+QV1QqAiDY7RF9ZrI+GidHlE4GoGm9b/sJFJ+otbjiVr2o1IOr9CgzjJll0mp
 OQjkCPZhG1RQf2tHqbd60VGBwQtUfWJLFzH8mt3djIYtxG2R7KM7tvDzwU6mbZpEorGk
 1qWXGmfzeMgUmyJ2AUyupCiJx8u0Oztlilwfr/WoB1wnCbD8fCXI3WR52kcPuxWeLTiW
 2MY95/pzpfhAE9PoFcyR+xHBP4Qe0qRujiulUhEZZwl5wYQvDTilBxMqbYg4Kr/ywHZc
 UGUw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUrQSLDsa1DV1x+go3lClHS3jX1QLW6MtYFZx8/VTHwn2rYZN6MFFNIEqtwvGF0JuLx1hA4bVLxPChd@nongnu.org
X-Gm-Message-State: AOJu0YwP/0dWoweZ2cN5gm+q48nv7kLS6jTUyolmOiUD5vnND95cNudo
 Y3szrlZ4vF3/8deVAomOKbrzKlUEw/8R9i3AQz97BbX/Fbe9b5ParwRpeSsx5eGgI74ofyhlCz7
 aFqRVV18dzhW/vKIQ7NRiua47JL+HMf5LGHekJQudm9AQP0lV1W1T
X-Gm-Gg: ASbGnctd5YiiJPTFjtkn7uaknrDZQT6qfRxtodnRUuODh7RL1YxpQ10eYq5O25HmQCm
 szjRpEuD0+0Z7J31dHqAXCpMxcUfinqBr0fzO+g34fQwCg0wsTabGTwTPrOoePpcX/BpPf76kJr
 fF2sl24qPw3CKdw57R12Qs9tf2BzZ2gXmWnOMipGhoVnF7CDptp57Zu/oG/veWsZNLLtW62K0HF
 384psjpq+bTj7dOAHdV7NZlz+MkL9Z+hOE7iRZWg0Qmkff9ymOcHfUE7ZRXGXsewmGQGfpU4PGB
 +rneqLQgc1tu3Zrg0msOGmstij/o2KSMVxycB726xdGiBPkSew==
X-Received: by 2002:a05:6000:22c5:b0:3a1:fc91:f784 with SMTP id
 ffacd0b85a97d-3a34994ef51mr4845486f8f.53.1747294583009; 
 Thu, 15 May 2025 00:36:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXojvA7hkWU3MQ6H+FA+IR6GPArq24jrsELIyexv/CVX1FPLIFokEBs8eaW6yYJLU5lOjS7Q==
X-Received: by 2002:a05:6000:22c5:b0:3a1:fc91:f784 with SMTP id
 ffacd0b85a97d-3a34994ef51mr4845464f8f.53.1747294582671; 
 Thu, 15 May 2025 00:36:22 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442f3368f2bsm60841945e9.4.2025.05.15.00.36.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 May 2025 00:36:21 -0700 (PDT)
Message-ID: <58bdbe4c-3d8b-4b6c-9bbc-d453a104d07b@redhat.com>
Date: Thu, 15 May 2025 09:36:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 01/42] MAINTAINERS: Add reviewer for CPR
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Yi Liu
 <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
References: <1747063973-124548-1-git-send-email-steven.sistare@oracle.com>
 <1747063973-124548-2-git-send-email-steven.sistare@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <1747063973-124548-2-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 5/12/25 17:32, Steve Sistare wrote:
> CPR is integrated with live migration, and has the same maintainers.
> But, add a CPR section to add a reviewer.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>   MAINTAINERS | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6dacd6d..d54a532 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3019,6 +3019,15 @@ F: include/qemu/co-shared-resource.h
>   T: git https://gitlab.com/jsnow/qemu.git jobs
>   T: git https://gitlab.com/vsementsov/qemu.git block
>   
> +CheckPoint and Restart (CPR)
> +R: Steve Sistare <steven.sistare@oracle.com>
> +S: Supported
> +F: hw/vfio/cpr*
> +F: include/migration/cpr.h
> +F: migration/cpr*
> +F: tests/qtest/migration/cpr*
> +F: docs/devel/migration/CPR.rst
> +
>   Compute Express Link
>   M: Jonathan Cameron <jonathan.cameron@huawei.com>
>   R: Fan Ni <fan.ni@samsung.com>

Please add :

   include/hw/vfio/vfio-cpr.h

with that,
  
Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


