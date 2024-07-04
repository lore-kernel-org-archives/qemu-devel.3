Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A78CAC30653
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 21:33:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPU4i-0002JE-Nz; Thu, 04 Jul 2024 17:33:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sPU4h-0002IF-AQ
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 17:33:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sPU4f-0005BX-UH
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 17:33:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720128783;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WDzGwbRNT/r0RyYFadajTgEd4KbzMMkaD/NFeDfcGIM=;
 b=g6wegPAac5rTrvy15fgziJCXla10vefTQ/+7XBm/7bl2hr6Lc+J2jHML4DwhmESU9KtJ9u
 1wuqpHpnsbyqc2xTlrSljDpY/bSS7y4dYkW7i9Qv04nX3YbJvBozLxe8JOzw/eEGR2YST2
 A4e3d5vputEFWIqeTNY2FISu604DjhM=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-178-C7dTsDjTPHmWjxvlLB0_Vw-1; Thu, 04 Jul 2024 17:33:01 -0400
X-MC-Unique: C7dTsDjTPHmWjxvlLB0_Vw-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-52ce42bb0efso1016769e87.2
 for <qemu-devel@nongnu.org>; Thu, 04 Jul 2024 14:33:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720128780; x=1720733580;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WDzGwbRNT/r0RyYFadajTgEd4KbzMMkaD/NFeDfcGIM=;
 b=xEIefN7O8c1BwuBWAOQ5iuWVsSslC+iTzTbGmz5McWUY7Vk6P9fmUyhSpz9U49j6FZ
 ouN6bC7sNyKkVt2rEmJnORYcmdecnPN2p11PzqiLcE/jgu4Mxw3nuHxHYStJrA0blcQa
 OpAKFvp4ZT1YcuCbw9c7oG+Na3QlVqry5ZTeSLr0xxdm6gghI5vcj3O/KBoPRxasZ+Po
 x7uRCurecu8u1I9IYl2L4QIwnDRz9SFuyh1OrWlyQfZbU+BDdCT6bKY1U+YumehVxICj
 ytRi1Kb5LakXYENb1X8j+lcEtocz3lejOSwrsyYk64vNqxeZ/NqmH+coInpIAqmgZdMn
 JCGg==
X-Forwarded-Encrypted: i=1;
 AJvYcCURMFmojKbbxxVT9utdA0s0vHqMh7IOxfLoHsyHaBdHIj9PeH6gyqaRxXftqEuMtGLTf4Z2691TyKnfcTjF3XSVQgz2Ab8=
X-Gm-Message-State: AOJu0Yx2ToEjwvpUjRgPGLsOUJtW1GWoRjGgCSsyfYQpMFOU00w1h1oo
 Jta2Re1UAp9yDTBIvU0ImhHGzg6DRwO0ZtHcsEgnED79t4gESQbk7rpZNJ7jqOrWwnyLbP6yv/m
 V3JNlXxplqtfP4Q1TSvK5KbyQ9hM5e/dQjYH9iHnyI8D0esOnlqNm
X-Received: by 2002:a19:691a:0:b0:52c:e01f:3665 with SMTP id
 2adb3069b0e04-52ea062e6a5mr1716298e87.25.1720128780581; 
 Thu, 04 Jul 2024 14:33:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGIPaDjXM8k8w4EU7lqoll7bD0yOyVmq4ryA70SvaPvoGzsBzQFrD5fP8AVnx0crCKY9VpTMw==
X-Received: by 2002:a19:691a:0:b0:52c:e01f:3665 with SMTP id
 2adb3069b0e04-52ea062e6a5mr1716272e87.25.1720128779961; 
 Thu, 04 Jul 2024 14:32:59 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:441:1b5b:ac5c:b82e:a18c:2c6e])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-58b246087e0sm4273783a12.62.2024.07.04.14.32.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jul 2024 14:32:59 -0700 (PDT)
Date: Thu, 4 Jul 2024 17:32:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Giacomo Parmeggiani <giacomo.parmeggiani@gmail.com>
Cc: Lei He <helei.sig11@bytedance.com>, qemu-devel@nongnu.org,
 berrange@redhat.com, f4bug@amsat.org, pizhenwei@bytedance.com,
 jasowang@redhat.com
Subject: Re: [PATCH v2 7/7] crypto: Add test suite for ECDSA algorithm
Message-ID: <20240704173233-mutt-send-email-mst@kernel.org>
References: <20220622091549.31115-1-helei.sig11@bytedance.com>
 <20220622091549.31115-8-helei.sig11@bytedance.com>
 <9D69E1A4-5694-44FC-B3FD-C6BE7EC68EA3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9D69E1A4-5694-44FC-B3FD-C6BE7EC68EA3@gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Jul 04, 2024 at 11:11:20PM +0200, Giacomo Parmeggiani wrote:
> PING
> Hello Li He, maintainers,
> 
> Any chance to revive this thread? 
> The patch series no longer applies to latest QEMU and it would be a useful feature to have.
> 
> BR
> Giacomo

Not sure why I didn't apply this.
Care rebasing?

-- 
MST


