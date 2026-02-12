Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 083E7EE3691
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 14:54:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqY5P-0006Ys-0b; Thu, 12 Feb 2026 09:54:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vqY5G-0006QN-8t
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 09:54:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vqY5D-0000gZ-Oq
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 09:54:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770908058;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=baDT8Kmvgz8ip/09bBEMGRtMOZO+FM/nsG8N8Owd5m0=;
 b=ada7b1RgFaofg6oXY2XX1DoYvr0kdtPKLRjM6aPKiTwrPI02pqgOjYy33Re5XpPMhMijaZ
 uBob9qgRPlg/0WVTe2Z8Wlpa2v7rpXJ8lW6XJaRyjUPyceoPFw7IN3ln2cT8E7KDLzkX/f
 OOtY6fAzhMemJz7NAZQrUvUC1mMqmAE=
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-475-1irDMLMMPg-SaS4VxgJBIQ-1; Thu, 12 Feb 2026 09:54:17 -0500
X-MC-Unique: 1irDMLMMPg-SaS4VxgJBIQ-1
X-Mimecast-MFC-AGG-ID: 1irDMLMMPg-SaS4VxgJBIQ_1770908057
Received: by mail-vk1-f197.google.com with SMTP id
 71dfb90a1353d-566e0daa6dfso5507660e0c.1
 for <qemu-devel@nongnu.org>; Thu, 12 Feb 2026 06:54:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770908056; x=1771512856; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=baDT8Kmvgz8ip/09bBEMGRtMOZO+FM/nsG8N8Owd5m0=;
 b=CGdJPlSSKiUuyX7vb0WRbmbE44ntlyqO7Wb2mN2aGK5TgU/BLl0s2MVwzVa7DV1EtD
 kFMXYTS28znKd2ryRui2Ht2viXQtAMBkSKFjW5UrziVU9A0S7upFxasZQ+E0lBUH+DAU
 bZFFZ6cAS3kyjopg+1z1nLCJsy2a4ItMDfSdLhEg84FdfHYG1k6Eng7Bn4GhJ0x0rBv2
 1P2tZULGBl+HXRf45XvilXCAvFNOmJcVurWAjdTI1IfML+jk6Y/hn9qbVVo9u4iEjATL
 lk2W/ijiQYHOrQ1t46wi4nVRyRRP0G0czRz0toFVcJCrRyq0sfAv1GPY6Qhn2s4ehBob
 1CCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770908056; x=1771512856;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=baDT8Kmvgz8ip/09bBEMGRtMOZO+FM/nsG8N8Owd5m0=;
 b=gb63y+MK6/H1tS4p5NlOZwZlelOJWw9WFdMBG1shGGX710oDOFo7vOyoOW62DEUN4L
 cf5ZAJ39jsfkcxLTLpdZrmP4zRG5PKSS+yFQPGmEcOxd2yb0kFmgEw/oyjw3VNU03PCR
 RGTt/T71RehsThLVifMZMcXFFIik4bkGFodzhKMcJTPP2Dhzw9t83MpDKWp7Cd2RIPYd
 mw4ZonQ3YgeQPwYjpzo4Gx3oMZqy85Lm61XX7aoHlCuwEYqmAn7zUWO7OtqrUHYyKXp7
 PPQYWMkF00mvioS9KWnrpFfq1rBJzBonC8ybPe7u0BKaQGeENeD+ADTlJ6IcD46Id3A1
 5ZhQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWOzhVZhblqvKmCS/qO4FTpeGqnldmPrNvQOOspfo0IlUd4SFb2sV0hisfFP0o2m+wFaMyEbdx2S7Nz@nongnu.org
X-Gm-Message-State: AOJu0Yx4TjysA64ACuE8sHY9JYlTIyZHQO6N0N50Hg0E8SVY/uSONADD
 Gr/197bIrPL9xt4zISCZAP0n6DXOOW7xbOIW+EjCxd9NxvRoQ2I2FZvzxtU1Zzc3NQ7pqgUkI0T
 YTX88wtAZ3lxdrxusSMQQy9PT5VKUe92gp1K4E2xrCCEH8bc0T31U/EH16FVVsa9Z
X-Gm-Gg: AZuq6aLWwZoKFYW0vrQx+8QW+NveXsbA5zmj/wjOYQFX4tXDMBSxIMMul8u6OTjwYV9
 2JV7bLM3SI5nVmd8ffRqPkOFH/TpL1W2l0EXarmeY0GoKUlX2CKmdMwHYFFU8Byf24unljjN/Nq
 xB9BxJqPasmbzwStZIW7offi5P1ygO770ZFjj/0O1V0SXX+kRME6G1GmDwcmoaD3v6CR6A2sBSE
 +FiLVfTHcUNhFPcPcjBI9FdrfnZ6V61+KFMLiWF29tpJM/tCaWylj3q/qpo1IpZE7Dzr5+lWlnz
 Ybzmiv/zHNm1HaqPsJ+dSYo7Tna4ijzzYKBPWAA1TMPGfO3HG/fTYowaSePCl02KjhPl0p+Fjoc
 n++10WuctLXBCxa/GzliKMzjkKTFQiacgrSCTOLR7QDLykq0fGkxz6jXc2Up5uj7PkCahosjGgJ
 0KdPYsrH2Cgb8EuEY+9FS83kGEzsA4youbfr5HuoKnCfhT4ycj464=
X-Received: by 2002:a05:6122:2b0b:b0:567:4750:6132 with SMTP id
 71dfb90a1353d-5675a203466mr570385e0c.2.1770908056455; 
 Thu, 12 Feb 2026 06:54:16 -0800 (PST)
X-Received: by 2002:a05:6122:2b0b:b0:567:4750:6132 with SMTP id
 71dfb90a1353d-5675a203466mr570374e0c.2.1770908056068; 
 Thu, 12 Feb 2026 06:54:16 -0800 (PST)
Received: from [10.32.181.178] (nat-pool-mxp-t.redhat.com. [149.6.153.186])
 by smtp.googlemail.com with ESMTPSA id
 71dfb90a1353d-5674c24aed4sm1714659e0c.19.2026.02.12.06.54.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Feb 2026 06:54:15 -0800 (PST)
Message-ID: <b6dfb2c8-7b81-4c32-b3d7-af9b373ddd3f@redhat.com>
Date: Thu, 12 Feb 2026 15:54:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/i386/vmmouse: Fix hypercall clobbers
To: Josh Poimboeuf <jpoimboe@kernel.org>, qemu-devel@nongnu.org,
 qemu-stable <qemu-stable@nongnu.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Justin Forbes <jforbes@fedoraproject.org>,
 Alexey Makhalov <alexey.makhalov@broadcom.com>
References: <c508fc1d4a4ccd8c9fb1e51b71df089e31115a53.1770309998.git.jpoimboe@kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
In-Reply-To: <c508fc1d4a4ccd8c9fb1e51b71df089e31115a53.1770309998.git.jpoimboe@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 2/5/26 17:47, Josh Poimboeuf wrote:
> @@ -247,7 +247,7 @@ static uint32_t vmmouse_ioport_read(void *opaque, uint32_t addr)
>               vmmouse_request_absolute(s);
>               break;
>           default:
> -            printf("vmmouse: unknown command %x\n", data[1]);
> +            printf("vmmouse: unknown command %lx\n", data[1]);

This needs to use PRIx64 - other than that, this is good so I have fixed 
it up and queued it.  Also,

Cc: qemu-stable@nongnu.org

Thank you very much!

Paolo

>               break;
>           }
>           break;


