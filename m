Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0DD9C83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 06:49:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubZTP-0003ex-Q9; Tue, 15 Jul 2025 02:49:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubZNJ-0004AK-IL
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 02:42:50 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubZNG-0006wV-P4
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 02:42:49 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-451d7b50815so33054775e9.2
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 23:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752561764; x=1753166564; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=twUCOjPVDB5dFLy+EA3QoTaV6f9tCXA/fI/J/rklt28=;
 b=I4Vl83/NR9fQsTJGo9Wj4lq4FGoDW5wdeVdI/yhvg8GjgqjRfRnMouI62Vr8/XWKLN
 XEXXRBQRWo4ie80NzWL2zeh3X1DXX4Nv1/XF5ktev+L5Yk9IzB3zn0qemYB0TkCYj1IM
 rkq/HteaSpD45srQIoJcJC3Va1VXqpYDKBnmDS5DQr2CxSOUV7Eo5IX1eymob4aw6tBg
 nUFusWUaEVN6b8/8XYROn1Ub6PIT5Q278Ja+1+Vru74pMOmJCcRXXouc9uWX7ftuSyjI
 /4qLuSKptWU71I4+ywSftBg53lilfLY0QHYcPecEbIs0Sew6TQEg36v/Z5PQ1F6lR4qa
 ZNIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752561764; x=1753166564;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=twUCOjPVDB5dFLy+EA3QoTaV6f9tCXA/fI/J/rklt28=;
 b=oUGmacxqnDKNQ0xFangDPwiKckPcQjvjFt7ctx0KEzCQWKUHcKvxUVXCswIjcPNL3m
 PQpIVQ6Jzq7VbxNVFoLcDj+6B97SrYhdATkLFh/L1QJsQLggzSWQ3IAAmFUSLnju5peG
 ka1jnWL8zsKxdsRm+VCOentSNsEkk7MTvF2HKjUejLopGpj24GZjLHvq3j0gz8r8Cbb+
 Aeu6gVZCYoQgti31jKb0B3Nq3l6WAscV9CJYMZnPlhR5dge/4k6Ma5f+MsGeYSbGklZw
 DPzxRMuuYWPA91Gbh9fCeGCoSsaAC/nrZ7A15QROfNFZ5fBVzEVy7lQTHA032HkLpSXy
 TfGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWoRd3rs0op2d55ohLikymcd5q1Z5arA5c8c/NuLwgRMIfCoiQ77MGHxj6/nceAPxw4pqYviN9159uQ@nongnu.org
X-Gm-Message-State: AOJu0YzYG6Nf0YQTA08n+Kvl1Fx1yodZanvL5v6JOzT8Wof0z7gJrdiN
 d3wrL9MeHOBipp+uF1G2ORqDP7t/GmwFYCkwxozNKOnDy4hcuBWlldyC3Di02PH+ZzQvvrSslBU
 un+qm
X-Gm-Gg: ASbGncv/kcqsD8aw9ZY8+U3qwU43DOW8K3h31msvo1I0Aisy7uUiHxldxxRShWBlx4p
 jpiuAzI/nb7b+gjBxDxnKYmtehijGgo0tp4PBZa+qo5Fd4+1+J2+/8tumVYyVHAW/a2TqYOg8nH
 nt1a0NNuV/csOtti2ECQXV6+pIlGY9eTD9wJ+3982jAjeuXU/RD9Wv+rM6cS4EbJmZS+zoHX57l
 XmZgKW9cwuesULOrmPQ7SD069WezeMyPQa/yvEDAzTO3i4m/1/OZDW/7XsB0MYJP0EpZG8RPBeC
 VqZ5v2/RUrX0PYpSsqX+uj51ZIXBuGKtgS4C7Oa4lGl5b9jFoHNMSfefSz3ZhBb1YbOMLIqLU39
 CjH+05NvLYhfbkDnCHTgKhdO5jZQ8qLeam/RjNNM5rbu87zVWEexG0bIodEkidy9dp+k9DlFqJY
 lT
X-Google-Smtp-Source: AGHT+IG6XA01cgOWCc0iz5/jMcP4Qym6GypxVACMfAsDdOeTdcqgozozmFxrdcJo1EOE0UWeI99S9w==
X-Received: by 2002:a05:600c:4f03:b0:456:26c6:77f3 with SMTP id
 5b1f17b1804b1-45626c67d94mr17171395e9.12.1752561764398; 
 Mon, 14 Jul 2025 23:42:44 -0700 (PDT)
Received: from [192.168.69.239] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45614aeba29sm66631525e9.11.2025.07.14.23.42.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Jul 2025 23:42:43 -0700 (PDT)
Message-ID: <ffbfd05e-6db2-4a75-97f3-672e3e1bdba9@linaro.org>
Date: Tue, 15 Jul 2025 08:42:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 02/19] hw/i386/pc_piix.c: remove include for loader.h
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>, pbonzini@redhat.com,
 mst@redhat.com, marcel.apfelbaum@gmail.com, eduardo@habkost.net,
 imammedo@redhat.com, qemu-devel@nongnu.org
References: <20250711095812.543857-1-mark.caveayland@nutanix.com>
 <20250711095812.543857-3-mark.caveayland@nutanix.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250711095812.543857-3-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 11/7/25 11:57, Mark Cave-Ayland wrote:
> This header is not required since the loader functionality is handled separately
> by pc_memory_init() in pc.c.
> 
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> ---
>   hw/i386/pc_piix.c | 1 -
>   1 file changed, 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


