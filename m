Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D9E3E7716E
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 13:13:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIpBa-0008S9-SZ; Wed, 04 Dec 2024 08:12:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tIpBX-0008RI-P0
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 08:12:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tIpBW-0000E6-Bg
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 08:12:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733317971;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K0OdfHAWE083Kg3ZyFOHbjW6Kan4rzbMlwnGwZHkV8g=;
 b=JbX4hcGmouMAMoo3nRjUMkw66RmftCso40ljezSVdMBOJdAd2F7crfAKw0rk5eAhUXfVns
 85ssT0Pny/WFayixlWRZgzyuRy7thKSH0r/t0xwFMdlCfEhKFR70RBU/Qsob22FUL8mE5K
 7xSOfoIEdrtMclq9ruYOrN3p6PxGmu4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-212-2ZMuZ8fnPlaMPx1G2i18kQ-1; Wed, 04 Dec 2024 08:12:49 -0500
X-MC-Unique: 2ZMuZ8fnPlaMPx1G2i18kQ-1
X-Mimecast-MFC-AGG-ID: 2ZMuZ8fnPlaMPx1G2i18kQ
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-434a0d30c06so4467765e9.1
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2024 05:12:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733317968; x=1733922768;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K0OdfHAWE083Kg3ZyFOHbjW6Kan4rzbMlwnGwZHkV8g=;
 b=FyJ6tjm+q4gHTffBX6R/NBaBFkiHmD4w/Wobnf7bPluQBVBp2A8YS7BhLDhSGDRYZJ
 iXcAceXIk5Tw33TbOwWvLNdqVqSbtB1b59eAooMEDv2psh+N05R2QnQNAUWe7B+UsqUZ
 sG69rsKz9QKZrpwi+TXnVev64tpU+Tbu9Cl8HPbpfZWS+5lFiRPXHUnInjyo5wrZ9sMJ
 GVRwwC7HQADMPcbJm7SV+XKAAkWJyQStHJD6hdH16HxoNrizWNpGkFUcREuN6GlBVVsF
 bYo8edIbI28/lf+m988sBdcmvErkGtbuZpZ8OC8SDXBet6z1X4p+yz0lZmXxclR8BSpU
 0VbQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3vDwG8x627RvtqMnmUQeJzVMAatU0C/K0+DGyW6q0Lg2WpZhFjl054eswUd00fen+OzX/jNE+zsIH@nongnu.org
X-Gm-Message-State: AOJu0YxztcuSLVRYPv6WIYx7YE2wCbrNU9HMHUJ5j+BVVa9ax+vO1itE
 BtVUXssjgjgLB7EZfqd1DhksYC9NoItsh307OczKweXl4isHCijK9Sl08hZ62lz71YYLzDbf+ab
 HfaFMFabvQJUz84HahbaoP7LrIMqivjzOH/49aXJtEko2iaWBn5JP
X-Gm-Gg: ASbGncvOeBDk5qQei5qnazJ6TSago/WmE6+mrPzbeDv98lxcTvD77N9hfbRDTOVH3k5
 lBjcvFTdgbaMqGJuVsReAbsKmbl2yV93TKjV+XhUyOQ7N0yZcE6accQQA+MLpVDhH9Vz707H96F
 fSBKQwS8LAjqwgK7WRqKdFNZ2HEyc1FOKtbXfH0bSZ3GDDAhKXcOCP8C8zihKBdIPm3YS3mU8Iw
 KWa+CUV7PH5dGgmKa24m7lFFemeuk8Y6jIgNBuVuzFoBWtx7wSHsBjEbs3A/b3Fyb3NoS05K5Wl
 4wGuZN5A9ZXpa5+HonWutg==
X-Received: by 2002:a05:600c:3b16:b0:434:92f8:54a8 with SMTP id
 5b1f17b1804b1-434afb29148mr209412555e9.0.1733317968243; 
 Wed, 04 Dec 2024 05:12:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFQxAZLZpmjkLzkDFbywJOF+ghsGV+U3VvgxLTvIQC6dHR7uta8PxKFS9O0+ohwhZE2ziMhZg==
X-Received: by 2002:a05:600c:3b16:b0:434:92f8:54a8 with SMTP id
 5b1f17b1804b1-434afb29148mr209412315e9.0.1733317967956; 
 Wed, 04 Dec 2024 05:12:47 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385e06c485fsm15131424f8f.83.2024.12.04.05.12.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Dec 2024 05:12:47 -0800 (PST)
Date: Wed, 4 Dec 2024 14:12:46 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 linux-kernel@vger.kernel.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v5 08/16] acpi/ghes: don't check if physical_address is
 not zero
Message-ID: <20241204141246.37a7cb9d@imammedo.users.ipa.redhat.com>
In-Reply-To: <95c0fa3fc2969daf3b6bc1f007733f11b715a465.1733297707.git.mchehab+huawei@kernel.org>
References: <cover.1733297707.git.mchehab+huawei@kernel.org>
 <95c0fa3fc2969daf3b6bc1f007733f11b715a465.1733297707.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
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

On Wed,  4 Dec 2024 08:41:16 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> The 'physical_address' value is a faulty page. As such, 0 is
> as valid as any other value.
> 
> Suggested-by: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/acpi/ghes.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> index edc74c38bf8a..a3dffd78b012 100644
> --- a/hw/acpi/ghes.c
> +++ b/hw/acpi/ghes.c
> @@ -400,10 +400,6 @@ int acpi_ghes_record_errors(uint16_t source_id, uint64_t physical_address)
>  
>      start_addr = le64_to_cpu(ags->ghes_addr_le);
>  
> -    if (!physical_address) {
> -        return -1;
> -    }
> -
>      start_addr += source_id * sizeof(uint64_t);
>  
>      cpu_physical_memory_read(start_addr, &error_block_addr,


