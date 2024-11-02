Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56300E677F1
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Nov 2024 08:28:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t79Tz-0005zk-H5; Sat, 02 Nov 2024 04:27:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1t79Tx-0005zS-7B
 for qemu-devel@nongnu.org; Sat, 02 Nov 2024 04:27:41 -0400
Received: from mail-wr1-f53.google.com ([209.85.221.53])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1t79Tv-0006b1-EM
 for qemu-devel@nongnu.org; Sat, 02 Nov 2024 04:27:40 -0400
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-37d49ffaba6so1784544f8f.0
 for <qemu-devel@nongnu.org>; Sat, 02 Nov 2024 01:27:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730536058; x=1731140858;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cZMRMRIpzHOCc++FNywspFrBJekG7HjAqziCIWx/r7M=;
 b=QtpHPeXf7L5Bm5C4wUlqLQttPl8/zeG6rpZRurk67kPPlw1IZnjacb46l2Pwv2fwgN
 pI8aeBmMGku3mwzUewPY4QLroO6FWsta1wBCiKehmjjOecYs2VqH8h+Hqv0de+2idnLB
 OhLwEP/R0BBmFKFxf5EZR+55tb2dwJu6Vnsj/QUzqAfklITJgbGCdVfqHSWZHmgyl5AE
 /tu4yNjnJsf7Zp6lCPU7s+28PvZqghGlh+PFSDQ9E1IL03uIIQJGGf2wCAiiaQK5TRol
 GZ8wyFyUsxvhoJEYxSckPNFK4/J8G25GI1FKDDi9JD7C9oAQYRWQXIYp5sA0HZJ2AnC+
 Bu3g==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/VnSOl9oKJBqqRaDPRx7RdbTdaMGE5KNarWRh7OiYGrl8LPG2RnqUpaLl5bfb9Q4WsuPPKzziDQqT@nongnu.org
X-Gm-Message-State: AOJu0Yz+EjNoU2mg6xGm0PglXf+y3dMYldAP2xcWi20tl6SCnjS1VfII
 a/XIo4zy71IyjITC7ZcqbvNgbeV1CTAiSWgnviuzRkqtlPyJNXhm
X-Google-Smtp-Source: AGHT+IF3NP4P+bWq4josTQmSd6ffEdmIuq5iA+v3vREh4to0U7416keSbu4ijqsM++9FtZ6Fw5GgOg==
X-Received: by 2002:a05:6000:b4c:b0:37d:3735:8fe7 with SMTP id
 ffacd0b85a97d-381b708b14bmr8301350f8f.32.1730536057673; 
 Sat, 02 Nov 2024 01:27:37 -0700 (PDT)
Received: from tpx1 (ip-109-42-48-251.web.vodafone.de. [109.42.48.251])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-431bd910357sm120928995e9.11.2024.11.02.01.27.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Nov 2024 01:27:36 -0700 (PDT)
Date: Sat, 2 Nov 2024 09:27:34 +0100
From: Thomas Huth <huth@tuxfamily.org>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 1/2] next-kbd: convert to use
 qemu_input_handler_register()
Message-ID: <20241102092734.03fde080@tpx1>
In-Reply-To: <20241101201106.1432336-2-mark.cave-ayland@ilande.co.uk>
References: <20241101201106.1432336-1-mark.cave-ayland@ilande.co.uk>
 <20241101201106.1432336-2-mark.cave-ayland@ilande.co.uk>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=209.85.221.53; envelope-from=th.huth@gmail.com;
 helo=mail-wr1-f53.google.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Am Fri,  1 Nov 2024 20:11:05 +0000
schrieb Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>:

> Convert the next-kbd device from the legacy UI qemu_add_kbd_event_handler()
> function to use qemu_input_handler_register().
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  hw/m68k/next-kbd.c | 166 ++++++++++++++++++++++++++++++---------------
>  1 file changed, 111 insertions(+), 55 deletions(-)

Reviewed-by: Thomas Huth <huth@tuxfamily.org>

