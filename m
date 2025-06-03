Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5201C5AE59
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 09:24:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMNsk-0002Wk-LV; Tue, 03 Jun 2025 05:24:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uMNsh-0002WL-GK
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 05:24:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uMNsf-0007UE-Ty
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 05:24:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748942664;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0jnTUeD5PcKcTTdi3+j0o5j1iOfoiFQ3L/Wsc6De+V4=;
 b=i7f6Yb/lLYAT2QS/A/nX/8rftnDClnrTNyg6LUCec2coEukICJoHMOzNbRQNw2xkcDwkyA
 j/vczPs/Q0tPBwLOLsGFqTe6zuUvRpt7XotsT6a8WYsyo8EncKOHcZzf6m+2tGJLAH0r9+
 ubXtpsPmwqNwK+K6mn+X+ug2TY7R054=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-36-YPAy9qVXPhOjqb8FvpCnPg-1; Tue, 03 Jun 2025 05:24:23 -0400
X-MC-Unique: YPAy9qVXPhOjqb8FvpCnPg-1
X-Mimecast-MFC-AGG-ID: YPAy9qVXPhOjqb8FvpCnPg_1748942662
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a4ea7e46dfso1635317f8f.3
 for <qemu-devel@nongnu.org>; Tue, 03 Jun 2025 02:24:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748942662; x=1749547462;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0jnTUeD5PcKcTTdi3+j0o5j1iOfoiFQ3L/Wsc6De+V4=;
 b=Uai7wWPbqYB28TEzgSpnmgkPNrPvp5MXwNSV9HqmtRh6azSf+E8uyrTgrVjNKH6dl1
 Bdkfo94IVPKeups2yA1Kfx960x5YGqFIincmW1yO6QJkwBVXVkQN7bAQRBBGpxg5eBLd
 NXrmdQXHph3Rp1e59LNSZ3juQWyWif5VIw51npJOG83BlV1z5uuVz0MGeQeMv/9Ro3BV
 QEVShrWc16I0PBfw3xPmykV2LVsoutCO6VqTB8qtBfhwJHuonMF6XU1gd4xmsmFK6Bt6
 4f9Y7s5LbJ841M0rcFR1w91nlFqxYUbi11kItU4Nk3ZBG53bCfum0JaMunnangu/NJLo
 Vq2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2FJstdIMwtQ4d7iADco3FyPdL6ge+LNdp6740WNEql3N7ixhWFXN16FLXbxm8iXp9vpDnE3bStHou@nongnu.org
X-Gm-Message-State: AOJu0Ywb5iUfkrCDPgt0Gu/f/y4eSfkGXOohuWpM5Rt8I8EaHZDuHZKl
 HzRK5y+dSrtnocw0SDmzpHQdEnWynQAZymfehN34LhuQeQNQyzb3x4MVTKnDJM+OS0JwlvtwQ52
 c+yhDWop5ywQCRX+8r/WmdyMU1AK+Z11HxLjWZLhb38oQKAWE3mU6nbed
X-Gm-Gg: ASbGnct4I93jc+yTDArkSVSZfM9Lbg9qD0wzv1GqPBqOmp39VvXL8qww+jXXwdSAwNN
 kcFJsY4TGgTb+vWJnJOEbr97k7xhPbFhiNR8AYoW2swY/MSErTZS8+p5qESuoTECbKCaUplxTMZ
 ba9H+2Z7YDhWic+Y7UPvx3qfpp7tnSd+EBFYMjXhOA1IBzJnydR0L3LalmHv+Rk9FVDJUIw781T
 LNzmMPnwEzImPhHyPvrsxiStyaqW03BCIqhIzPIavHEB17/1EfwXvs5VvwYQv+PepmfBWDpkm+E
 4mwXDVrdPswkWDU4VpDjTF6QX2QQ9Mmh
X-Received: by 2002:a05:6000:2212:b0:3a4:edf5:b941 with SMTP id
 ffacd0b85a97d-3a4f89d3186mr11733458f8f.38.1748942662466; 
 Tue, 03 Jun 2025 02:24:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHLmbF0+FcGHJmunc71U0PkwHUBS7M8Pvp1Lyt0bosjp2KszQMy7WKHzBnQSml12mBCNu9n4A==
X-Received: by 2002:a05:6000:2212:b0:3a4:edf5:b941 with SMTP id
 ffacd0b85a97d-3a4f89d3186mr11733436f8f.38.1748942662065; 
 Tue, 03 Jun 2025 02:24:22 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com ([85.93.96.130])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4f0097539sm18024925f8f.63.2025.06.03.02.24.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Jun 2025 02:24:21 -0700 (PDT)
Date: Tue, 3 Jun 2025 11:24:20 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Daniel P . =?UTF-8?B?QmVycmFu?=
 =?UTF-8?B?Z8Op?=" <berrange@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH 2/3] i386/tdx: Fix the typo of the comment of struct
 TdxGuest
Message-ID: <20250603112420.75d992f3@imammedo.users.ipa.redhat.com>
In-Reply-To: <20250603050305.1704586-3-xiaoyao.li@intel.com>
References: <20250603050305.1704586-1-xiaoyao.li@intel.com>
 <20250603050305.1704586-3-xiaoyao.li@intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.015,
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

On Tue,  3 Jun 2025 01:03:04 -0400
Xiaoyao Li <xiaoyao.li@intel.com> wrote:

> Change sha348 to sha384.
> 
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  target/i386/kvm/tdx.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/target/i386/kvm/tdx.h b/target/i386/kvm/tdx.h
> index 04b5afe199f9..8dd66e90149b 100644
> --- a/target/i386/kvm/tdx.h
> +++ b/target/i386/kvm/tdx.h
> @@ -40,9 +40,9 @@ typedef struct TdxGuest {
>      bool initialized;
>      uint64_t attributes;    /* TD attributes */
>      uint64_t xfam;
> -    char *mrconfigid;       /* base64 encoded sha348 digest */
> -    char *mrowner;          /* base64 encoded sha348 digest */
> -    char *mrownerconfig;    /* base64 encoded sha348 digest */
> +    char *mrconfigid;       /* base64 encoded sha384 digest */
> +    char *mrowner;          /* base64 encoded sha384 digest */
> +    char *mrownerconfig;    /* base64 encoded sha384 digest */
>  
>      MemoryRegion *tdvf_mr;
>      TdxFirmware tdvf;


