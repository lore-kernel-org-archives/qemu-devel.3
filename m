Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 834EEC197BF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 12:04:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnccl-000174-4D; Thu, 27 Feb 2025 07:04:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tnccC-0000Z6-Ri
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 07:03:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tnccB-0002R6-2S
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 07:03:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740657822;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A3IIRWTfz/eEhKgTnFWptplWM8F1KHYcG7w57dEy7Ao=;
 b=am7+JUtMPqkiFw/Q1B69GBbiDyxp6IFrT2iSRND8Yg5jS30LW2lrqlZLLGeqYMNcr4CLwT
 K/CSMkhog6O1kyNUAD5gvgoWQF/8wsM1k2LvIPRT62udYGD7KrPNedk/wx+qX2aJcw56D0
 b+Vzqox8uhwO4ffwSPsDuxBofEJfnVg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-mDe7OrUTM5-7N_yeRPuEBg-1; Thu, 27 Feb 2025 07:03:40 -0500
X-MC-Unique: mDe7OrUTM5-7N_yeRPuEBg-1
X-Mimecast-MFC-AGG-ID: mDe7OrUTM5-7N_yeRPuEBg_1740657819
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-390de58dc09so585243f8f.0
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2025 04:03:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740657819; x=1741262619;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A3IIRWTfz/eEhKgTnFWptplWM8F1KHYcG7w57dEy7Ao=;
 b=YIVEk1YQBjgV5yhoFs1GKUUno3+RHotZAVcaiEnED4u7Vonp/386U+6ZN6gtmqlwY0
 RyBaJk2uGgHMVkXE7mbb6yAgJmz6mZK8xP9lFoF4gLlBauclhSlnQYgyOR9zurIA/v2x
 qt6i3sSJlb55xIBIb+SVabO9O64qd9QAyVthi8aPFuQDF19pdVDrEXXJgJuGJs7CPdzP
 fF4wn7Be1eIhDNXdNk33b3MOpdyUoBpfxrUso7Wcau30FhbMwZfUZ5GsEUpY0KYwmyFS
 EFRe4NTvouzqzT0HbhjWa6S/NAF4pd0t+C16XzTO6Fz1dDw67KkKxZQ1wKSJn4KJBj9p
 cZYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU03MNi9JrU0ucXnV0zJZN1Ff9rPM3LOcvfsEtqSSEvIDv7u5WcDRSrbwtkTT28AeDEtXEIeFg6/iT8@nongnu.org
X-Gm-Message-State: AOJu0YwJoWbpfv8Mhg+zDBO1BmqTSrgtfjE7EJQsBA8ddVLvBkfAHBh0
 M2hughlKNdQt7d9f3apGdDSTzLF5rF7/JFsxPWti6oPeU2dStK/qfp130vJtcdCBdjOnyJpRwaC
 3bcPSc5QHSDLfD8pPoJjW/Eed7r2TjWwOp64IzCrQ4tuubHsO8epl
X-Gm-Gg: ASbGncuPEBk3PFqRHUQwHnIkaiL1IdCxTkXT3y861nAtl2+9oBRMuHkC/RJ6p9VmXW0
 J5tUJGrHZsSQ2oWe/8mo+vJiYqJcsBDW5u4G4mptulHHkb6jRYjfN2irQ9FHaAMGCYwundHA+yh
 8NpHCQrny5eMbh+2Mv5Gl0b7Ok2asF/wb2G+zN7OIQSuBn24i7LV6XCmCCYzGntHUaXmXu8TQv+
 Nwsg6qgD53T5YW/FQKun/bGzMJMEdYDXWesbBZ2y0EVwz+vVLG1/ScR4XXK5fz0sl8REJs2ZeEB
 xOAhHgC+wpcWI3Z32F1RzUFCw9PktVPTdk7wadNmdJMbwRzIco5sZeParYKEYgY=
X-Received: by 2002:a05:6000:18a5:b0:390:de58:d7fe with SMTP id
 ffacd0b85a97d-390de58dbc6mr4083580f8f.51.1740657818811; 
 Thu, 27 Feb 2025 04:03:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHIvLiWh2tdVmP6HZrr7TBnk071x+cG1W0d6K0NLkz3NzaVfzLf567WwsMpcijntSKKBlKQ5A==
X-Received: by 2002:a05:6000:18a5:b0:390:de58:d7fe with SMTP id
 ffacd0b85a97d-390de58dbc6mr4083544f8f.51.1740657818495; 
 Thu, 27 Feb 2025 04:03:38 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e485d906sm1828794f8f.90.2025.02.27.04.03.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2025 04:03:38 -0800 (PST)
Date: Thu, 27 Feb 2025 13:03:37 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Shiju Jose <shiju.jose@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, Ani Sinha
 <anisinha@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 03/21] tests/acpi: virt: update HEST file with its
 current data
Message-ID: <20250227130337.31f2a285@imammedo.users.ipa.redhat.com>
In-Reply-To: <5bb163b260d6a29b082d12cbae31035fa68342df.1740653898.git.mchehab+huawei@kernel.org>
References: <cover.1740653898.git.mchehab+huawei@kernel.org>
 <5bb163b260d6a29b082d12cbae31035fa68342df.1740653898.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Thu, 27 Feb 2025 12:03:33 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Now that HEST table is checked for aarch64, add the current
> firmware file.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Acked-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  tests/data/acpi/aarch64/virt/HEST           | Bin 0 -> 132 bytes
>  tests/qtest/bios-tables-test-allowed-diff.h |   1 -
>  2 files changed, 1 deletion(-)
> 
> diff --git a/tests/data/acpi/aarch64/virt/HEST b/tests/data/acpi/aarch64/virt/HEST
> index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..4c5d8c5b5da5b3241f93cd0839e94272bf6b1486 100644
> GIT binary patch
> literal 132
> zcmeZp4Gw8xU|?W;<mB({5v<@85#X$#prF9Wz`y`vgJ=-uVqjqS|DS;o#%Ew*U|?_n
> dk++-~7#J8hWI!Yi09DHYRr~Kh1c1x}0RY>66afGL
> 
> literal 0
> HcmV?d00001
> 
> diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
> index 39901c58d647..dfb8523c8bf4 100644
> --- a/tests/qtest/bios-tables-test-allowed-diff.h
> +++ b/tests/qtest/bios-tables-test-allowed-diff.h
> @@ -1,2 +1 @@
>  /* List of comma-separated changed AML files to ignore */
> -"tests/data/acpi/aarch64/virt/HEST",


