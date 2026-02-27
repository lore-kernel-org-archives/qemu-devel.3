Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 872E0FEFB56
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 14:46:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvz6a-0006hB-3C; Fri, 27 Feb 2026 09:46:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <smostafa@google.com>)
 id 1vvz6J-0006c9-E3
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 09:46:02 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <smostafa@google.com>)
 id 1vvz6G-00004y-Id
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 09:45:54 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-48373ad38d2so86615e9.0
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 06:45:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1772203551; x=1772808351; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=hv8vfDQugJuqVRDVi3GNFojBbRtAggQJQ/HDDho8giI=;
 b=hwtEpwDFebC6PSD/2eJ5oMZ+WNED5P04VdNeOCoUS3OiLkqo8pwgNTIZjVs94/5S0p
 NOp2XVw3/Pz9jo/lKGTagxRWSc/OFrUc/MCeAAR6msAx0O9HKDYXqDzIeMytHnYVTuFx
 oXc3TJrY4B0kSdldjdc4VNhTVrweb8l9Om9+/YbDgh8wt6f1r+LFFNYuQdYy59lEJsJX
 rOKgBbL0c9odwI6pvaOG3/fDH7ES0kv2Rh8lHLQo+JdwRZp/fVxWQLEtl6VaHgkJOYNQ
 7xkm/rZCILxPrhRKUBvxTNMaYvC/98q+FoyeMP1LX/zbCIprpEXEY7PUIn4d3qr2vS/5
 +m1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772203551; x=1772808351;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hv8vfDQugJuqVRDVi3GNFojBbRtAggQJQ/HDDho8giI=;
 b=tmIAkpuArh8ohrcrS3asD2jonAIOusd987ctrx+XMEy/HemC4Sh0eJ3ThqXFkV17NM
 rQ0rT2dC4vhrnaebW132syN6I8S95LKz5G8CNZZB3xp/+sYPFZd5nRmYclaaorO9FoKv
 yG7xvds3k4V7OZGrtjbcpL4uh9Qd/QEZg4l6VUr9O4SldTC8P509W7TgWXjoUjN9HfHw
 Ko5+VoyKnc0WzVE/Dp1/j7gB5tkhETJiFfjUGWoeutpC8Jl8AGmE/ON4AqtV5Yixbr2G
 4PUELP+wiDquxEvZvdsmzhaZZMnBf4VBHZZh07hAO8wWSKReRFlCBsxf2j2PasYChAuP
 teXg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWbppKP0BXN1TFlVNO7vt984jdlguqr7tEK7t48Ni6Wa2dqElzSmXLCuXTiz1WqoN71iEFEx+7/XE+z@nongnu.org
X-Gm-Message-State: AOJu0YygqWAALBLCZJjf/9d8YbX2TN97b8NpzK+90UTod72FcYtew5Z9
 QmoFvnpNCYbVSyFd4yMrtLzbohcJjEJNe4vvVLQqBwC6eP5LO/SQs0fEz/FaUsZUKw==
X-Gm-Gg: ATEYQzx004VPj5ATUXGPkFokg1/ux0yih0cRX2iPCGRQ3CxtYRhHIIe6S9o4CBuMxE2
 Xp/4ne++UJ1344SD+KizKE7DmspZzHHUyj4SRFhpOPpZxyYVG6MLYBhFPFzZeBrAcLzocIktBNz
 7DWQJUBimgy9siCCYJc5NP1B1FXC/T2nFabXnwFDYgdZSPDBEviXfbAJRN7eIkpcmSzITQxIzBX
 6LjVx8jprpcyy8IrAPcKhrkAw5MQrYwbHkAfuVY3X04xqYhTULStszJqvxvMV5blujU1nE5UIxz
 Q1/EIDMw0k8M5yoiZTO+91SRKTe2cCNJ0pBx1mlRB869ZebABimztSociB0yyD8AuD2ooVpbup0
 N3M4qo5gXUilhsEDNGGjJw/id8MfDFC9PodpxcemY5PCrVUp+NrX/GvDFQi7l3s1gTYnDjZeNNf
 fjec7QBIBm+nlNaF9nrxu63OrPCLocmuBSChlQfVyKcQz4ZB2+YFN7MQbmpZg9gm+o
X-Received: by 2002:a05:600c:8214:b0:45f:2940:d194 with SMTP id
 5b1f17b1804b1-483c3165c0emr2231905e9.2.1772203550192; 
 Fri, 27 Feb 2026 06:45:50 -0800 (PST)
Received: from google.com (206.56.155.104.bc.googleusercontent.com.
 [104.155.56.206]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4399c75b327sm7942778f8f.20.2026.02.27.06.45.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Feb 2026 06:45:49 -0800 (PST)
Date: Fri, 27 Feb 2026 14:45:46 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Tao Tang <tangtao1634@phytium.com.cn>
Cc: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Chao Liu <chao.liu.zevorn@gmail.com>
Subject: Re: [RFC v4 13/31] hw/arm/smmu-common: Add sec_sid field to TLB
 entries
Message-ID: <aaGuGuevX8HFqx0x@google.com>
References: <20260221100250.2976287-1-tangtao1634@phytium.com.cn>
 <20260221101640.2993566-1-tangtao1634@phytium.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260221101640.2993566-1-tangtao1634@phytium.com.cn>
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=smostafa@google.com; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sat, Feb 21, 2026 at 06:16:40PM +0800, Tao Tang wrote:
> This is a non-functional preparation step that adds storage for
> resolved security state in SMMUTLBEntry.
> 

I am not sure about this, when I added stage-2 I re-used the same
TLB instance as it might be used for nesting, and we can have
end-to-end cached entires.
For secure state, I think it’s cleaner to instantiate a new TLB, as
both states can never mix, and in this case we can re-use the same
functions without adding the secure bit in the TLB.

Thanks,
Mostafa

> Together with the earlier commits that added NSCFG handling and
> PTE NS/NSTable helpers, the plumbing is complete and we can now
> refactor the PTW flow to handle Secure state.
> 
> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
> ---
>  include/hw/arm/smmu-common.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
> index bd88e599c77..b0a02e12fe6 100644
> --- a/include/hw/arm/smmu-common.h
> +++ b/include/hw/arm/smmu-common.h
> @@ -91,6 +91,7 @@ typedef struct SMMUTLBEntry {
>      uint8_t level;
>      uint8_t granule;
>      IOMMUAccessFlags parent_perm;
> +    SMMUSecSID sec_sid;
>  } SMMUTLBEntry;
>  
>  /* Stage-2 configuration. */
> -- 
> 2.34.1
> 
> 

