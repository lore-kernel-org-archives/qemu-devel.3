Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F004ECD1297
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Nov 2025 17:51:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIsVZ-0001aP-OT; Tue, 11 Nov 2025 12:50:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vIsVT-0001V0-7G
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 12:50:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vIsVR-0001OM-2Q
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 12:50:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762883411;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V5YdgpSepIM+Vu72ZmZR6JDazpPsxkKp2SzwOXtK9HQ=;
 b=hWeApdl6Raz+/kUtfVgtWcAsjtm7PP6DMAsqtsZGYmfyGng/ngNIvOxKQhRtuRCux4mUUA
 n3aW/YEFjHTZ55gaaZMUO6YLT5QZV1fNOWInhz1FNUrf8BNCPtxvPUqVWL+lvAPuV0L153
 cf+TPIBwelLhE7tYSU21GzkwJtGbis4=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-sZz9s_ItPEGtHqbZzbqK2w-1; Tue, 11 Nov 2025 12:50:10 -0500
X-MC-Unique: sZz9s_ItPEGtHqbZzbqK2w-1
X-Mimecast-MFC-AGG-ID: sZz9s_ItPEGtHqbZzbqK2w_1762883410
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-882381f2092so121190216d6.1
 for <qemu-devel@nongnu.org>; Tue, 11 Nov 2025 09:50:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762883410; x=1763488210;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V5YdgpSepIM+Vu72ZmZR6JDazpPsxkKp2SzwOXtK9HQ=;
 b=EKl8ObSatAN7q1Rc2tv5mWEAclKm09TURVYOMZUTK8l8pqY7NFz2UTCRqLZ8DhIGc/
 Q8N2uLcP/0gfw/qU2Wwlsju4OcwXX7VPnPKsECMBNOp7rJou008lR7n+fTs7WQqL2wh6
 ORY/qsCdLaD1O+TaM6b7fOL2Rox6EBq7f6gG078cazy/vlAjD2+a1lz1CtS5+Z+sBUyl
 jzXLrxQ82IHnoR46J1gPJMQOBU0XZ9N0KCs57/r/KrYljRi7b/gAizCG1I/Ua8auSI1U
 IVc8w9rqN86VkBOi3msX8aAT7QSzFqHCiMNxEv+m83fBpfIc6h0tyVRYWNvKwif0MU5O
 SjdQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVbM1/jy+wXsKpWgP2yyeVF0WtYKienPGkolRPZ6zJQVzmcpkfvRuoyvce2qb//lnsDrCOw1Xfwh6C1@nongnu.org
X-Gm-Message-State: AOJu0YxXKQRR8VAZ/3EVHv1qslpH6qmsHz7k5wfS+yeQPlB6rxx9fhOq
 vX5psZJyfyaM9k/mNHHbpFn38GWNYksS4+zjcXbzJEpZuqClWDeYw025aiukPUxrHyHypEZ8zOs
 Y7/2sH2vi8msIprkbX7+HJw/LvKuPIvbn+bPXTNbhJRqv2/J63ZbYwc5I
X-Gm-Gg: ASbGncvblSrOUidRBdLRo5vYVh9ZF68Kvh+ub2Pcd/paQ8yJKiKU19HJWA9nMra5qfo
 W/QvuOm5w0/yAqhdgXonPAfdoVmZUXoJBa0qk9XWYY2eltKQbzz5oW4IrAmOyHm4JnInORLNEuv
 ovk7ZCo8IonAwbiNHLJJUc5JU+eYyHlaZkt+P+S8LiIWwHd6WF9k0ZONQD0XE2JgF3PsoY/iia+
 3J7yBkQUemQE2FLcOzOZ8bja8nbg1eA5WCy/9nNc5dGnPkOwFsj6Ixav0mw/KMmHdHvaxqcNbTl
 lplTGoHnwHRJUCeziNY7uHSrp88bdr/uqQXlY/w2EdcOmW82BaWpbhfn//KSJTUx8N4+wtWC+0U
 E/g/JmvvXbT76MXzgj/Poyf5122ZNhnfRMOSySx4fh76zgIanLViPWY4c
X-Received: by 2002:a05:6214:1256:b0:882:3828:fa33 with SMTP id
 6a1803df08f44-8827195f622mr3497536d6.26.1762883410114; 
 Tue, 11 Nov 2025 09:50:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG0Ci9tdkmBBhpaJb4rkRghX6NZbIVWm0/hZnIdsIzeoWFuTuvMXuGLGtwGnZRnSZ7XXAbryQ==
X-Received: by 2002:a05:6214:1256:b0:882:3828:fa33 with SMTP id
 6a1803df08f44-8827195f622mr3497326d6.26.1762883409798; 
 Tue, 11 Nov 2025 09:50:09 -0800 (PST)
Received: from [10.188.251.182] (cust-east-par-46-193-65-163.cust.wifirst.net.
 [46.193.65.163]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-88238baa0aesm76833956d6.60.2025.11.11.09.50.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Nov 2025 09:50:09 -0800 (PST)
Message-ID: <ad87bec9-e36d-4c5d-adf8-ae92917451a2@redhat.com>
Date: Tue, 11 Nov 2025 18:50:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] target/arm/kvm: add constants for new PSCI versions
Content-Language: en-US
To: Sebastian Ott <sebott@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kvm@vger.kernel.org,
 kvmarm@lists.linux.dev
References: <20251030165905.73295-1-sebott@redhat.com>
 <20251030165905.73295-2-sebott@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20251030165905.73295-2-sebott@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Sebstian,

On 10/30/25 5:59 PM, Sebastian Ott wrote:
> Add constants for PSCI version 1_2 and 1_3.
>
> Signed-off-by: Sebastian Ott <sebott@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  target/arm/kvm-consts.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/target/arm/kvm-consts.h b/target/arm/kvm-consts.h
> index 54ae5da7ce..9fba3e886d 100644
> --- a/target/arm/kvm-consts.h
> +++ b/target/arm/kvm-consts.h
> @@ -97,6 +97,8 @@ MISMATCH_CHECK(QEMU_PSCI_1_0_FN_PSCI_FEATURES, PSCI_1_0_FN_PSCI_FEATURES);
>  #define QEMU_PSCI_VERSION_0_2                     0x00002
>  #define QEMU_PSCI_VERSION_1_0                     0x10000
>  #define QEMU_PSCI_VERSION_1_1                     0x10001
> +#define QEMU_PSCI_VERSION_1_2                     0x10002
> +#define QEMU_PSCI_VERSION_1_3                     0x10003
>  
>  MISMATCH_CHECK(QEMU_PSCI_0_2_RET_TOS_MIGRATION_NOT_REQUIRED, PSCI_0_2_TOS_MP);
>  /* We don't bother to check every possible version value */


