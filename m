Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE60AC02181
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 10:09:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taXfY-0002lP-Ts; Wed, 22 Jan 2025 05:09:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taXfT-0002ba-Ja
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 05:09:05 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taXfR-0005aB-Ro
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 05:09:03 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4362bae4d7dso48638835e9.1
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2025 02:09:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737540539; x=1738145339; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bRP+F/5UhpZ87vve3G8EKuvvYsVEvCLgzCcqM1fn+QE=;
 b=uWCdI9P1vdhtRO1IzDilf+THpUqmQkeJ3HIiKkTTf35lLT20QW3RSnDNCnI2/WPdA3
 qlVWdbI+bsJn1eAV4+AqYAyUV9k+kaOcCatnaV8v/e8oTCmaPDyEm9h00II54OE1ViYl
 E6gFn75EqrQtpMh2yMyeubcAKULLYOVMwIU9q94qRct+2t+x5kf3BEXEttFygfJZy3GW
 qj+g+XyYphXdyQeFKYBckSaSCmgs2C0yVF7mx2Ifd3UTQ/lf7/Vl2wHUZPvpzMhykOSn
 FN8cjSK8/gsispDSElNrZq6W6MoTHKx2qwFqSis+9owYGAGPeGcU23vEvNZc7FQup0Vl
 iHFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737540539; x=1738145339;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bRP+F/5UhpZ87vve3G8EKuvvYsVEvCLgzCcqM1fn+QE=;
 b=HmlEMl67Oq5oALtAUH3XGP6pnOO0lRRNDZzCYDBMVVdf20GYcIVrnt/9YrXcOi2KrH
 UKHr9p3Iatuo1SYrqUsxXvf821ziOyhwsFl6yUvFeEamNI1HhMlbu2KeL9mDOoF4DCXm
 tmk4pRnGMK4pseWsmUzbIRzPe7OHY96lepgfHawn/KjC8n05SiBmC0yOShWqbbXYtfD+
 4Tvkib+WvlGY06wWIoeLjfmY/+dM49E3vIgeh4UFxK8kGXaNqa+3GH6w5IQegyJcCtom
 0woG1uF8k5uZznaUjpA2p38bP6638TU24vT5frUsZ2eB+Qz2eFL3rFF14Ubn/8RQo1DX
 PbyQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfKZvkhZ665xIk+hzBuMCQSbwspmj1RWjm6FKbSthDGTa4AgyLRzxtdvP3TsgLlEz1PxngMppLNVce@nongnu.org
X-Gm-Message-State: AOJu0YyESQEpJmnSLErSto22jKrCo6hHLIrA1R8nOmFPmmxAPDTVnktG
 jrr6RLAXHwfgKSOV+8osTuRh3WJZIeDU3pgvLcTABgO6cbg4YwZwRsvjTpq06DI=
X-Gm-Gg: ASbGncvynh9++OrCi1SDN8yZaZFwjIuOS44lAFwWkOxer/56dO0lRmdrSmcc1DBKBRT
 Q3TXRnma1b9jHZoz3IFXWtf6sStJxrxifmsXSKH8KERqpu4PxZaduAfaX0BSWdU3t4DxRqA8WRg
 e0oDmyGEDkq/ZFgO2XHvfGeJCO0p6Bk2v18XfEqSfkbv05C37a+aI0RbaBju3wjbteZL7FvrmTl
 +gyv489deaJYvVTxMihHLKLBpwCEnk7eJXvceCNgYNNGSeLJLIUFOsOviViM1mjxEMI/nPP9Cwp
 GRPYFg0UG9I9oGAM9SRnbCzSiMZ5ncH4UD5uFg==
X-Google-Smtp-Source: AGHT+IEpHQzoA/dE3SCvYGhGYdP34gT3Xl7k9IyPwVYmmX2CX9El+iAgytFGxz8ar55xpCoVpKTI5w==
X-Received: by 2002:a05:600c:1f0d:b0:431:3bf9:3ebb with SMTP id
 5b1f17b1804b1-4389143923bmr173792065e9.24.1737540539180; 
 Wed, 22 Jan 2025 02:08:59 -0800 (PST)
Received: from [192.168.69.181] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438b318c325sm19158035e9.1.2025.01.22.02.08.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Jan 2025 02:08:58 -0800 (PST)
Message-ID: <dec84486-757f-4135-b094-5dd3c6174fc0@linaro.org>
Date: Wed, 22 Jan 2025 11:08:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/4] hmp: use cpu_get_phys_page_debug() in hmp_gva2gpa()
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>, Stefan Zabka <git@zabka.it>
References: <20250120111503.244994-1-david@redhat.com>
 <20250120111503.244994-4-david@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250120111503.244994-4-david@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 20/1/25 12:15, David Hildenbrand wrote:
> We don't need the MemTxAttrs, so let's simply use the simpler function
> variant.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>   monitor/hmp-cmds-target.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


