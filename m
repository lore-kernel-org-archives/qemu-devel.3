Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16B23CCF9E5
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 19:18:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDSjC-0004XL-SG; Mon, 27 Oct 2025 15:18:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDSjA-0004TS-1N
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 15:18:00 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDSj2-0005D7-6b
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 15:17:59 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-475e01db75aso17202405e9.1
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 12:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761592658; x=1762197458; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OX4zfCLoPvhE7+rhyNGlBqoW+O/OVNQrXavKW0oZ7hg=;
 b=LG+FP2NL6SVh9t4PBhyJK7iOlQerBl+AYUT16ORXOufp34iHReoIoQ0sCH6toaR38V
 4oLCkH7UzZNytbvrip8+QyFcVsLlwSCBsvdVBqzL7k3Va10kkWASxTEoxk29vFPuwx1d
 IwKKbQXdLE/yLFZ1WX677iFnacrtrINce4W+tujBgWU/gDTnmrOJuNIykijTROxut2Jj
 XcDlEFOph26Tc6U30puZXeehe9YYa4AI7DMWDNR5slzecewofBy8xl1hrIPN9pylg4A0
 VxceaVtc7MbqIY9pgOWEpMzsLox8N9oBaiFPaTA7jrxxd4N2hvdTv8d18+LW3rwi9nED
 ZnAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761592658; x=1762197458;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OX4zfCLoPvhE7+rhyNGlBqoW+O/OVNQrXavKW0oZ7hg=;
 b=CeVWA955dUu4+0h3XCrDV411igv+K2Oorsw3pJY6NOtT2hr0ilJe2q/lI6R+clmZMj
 CDSOQsLee+82y2K3wOECwrcuOIlX+ydSo/uVCSu05aO1wZ+6lqFi0JHvMO3J2L+Jo0rb
 HTOtjZF727hl4X5rdATFhDnCX0uOvcBekiMxfHK+HPDDD5bGqNOL5nPvMwOHD0eCN7e+
 tfer3GHNDRIwPE3I1Akse11aETrNXlPBvdoD7YFHKLvPOaFTOBI/UjPeK6lyEMc+01iW
 9MzJmeIE7EuJwV3nEXLvXCcQ2I76y6r6QZNBdJSLxaklhIa3EQGUSodvFgRS9euJW1ab
 wdDQ==
X-Gm-Message-State: AOJu0Ywe3rXVi5YoUq6hQHiT6IzQAT/vsKOSqtpp/JIdLMRTsfV5hmf7
 RLgXAC65ygV0RTP5zo5BiM8WUnIwabOpx0ZrNuoMleXV69R2Gr7tI3IYzK3czLbmmeK4I3KQ0Bw
 Oq3XXVHs=
X-Gm-Gg: ASbGncuBXVwd+P15ruPckd/6dCSth8hMezBQHx/6AjPTdLW8mdyKAlsM8A9BHwhRzxa
 A1Q6a7tdZB5uTyUypRpOoCoH1yUQ213EjeyatS2ZUBB4s44UltOCU3GSTKZG+7+58YkDPnPhgnb
 5l5t3xAL7g7VtLbWsDcmXTjchoBgg8FeQGf16YRC4kQbGwgGebSClXyXx64spcFjJt3/5Y3L3ys
 jVPXX+qkycT+y3eYahn7euFMJRL4aIdTt8M3rLMzJMCsUpwZsJIbuLsMHAROLuJeORnsXhNS4bd
 ialAawv/uYwjrqf4Zt8p6TentIWdE58SVf2JGPbGOrFOwtYI0GGEHWEyvlFh9I2Q0sFGTxFTKoP
 1t2KAQmQrEP88lPX5lfSqJh2zPgX4/C9p58vFUKtAPbfAOD8+faCbef4p6uuJIyOV5l/x5TOhUr
 M08YiPbVDX+o+JUBR6usuOSzyPtR+GdzwgqXDH5AeOQvAIInpY1Wyr8Q==
X-Google-Smtp-Source: AGHT+IE6bsd48TMgBcJRd8xWdvttKaErtSwdPfBofrIhRIW/1pPh7lT8y/cKFUSZgcIose3NawzhVQ==
X-Received: by 2002:a05:600c:3511:b0:476:84e9:b561 with SMTP id
 5b1f17b1804b1-47717e587d1mr8807005e9.32.1761592657798; 
 Mon, 27 Oct 2025 12:17:37 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475dd4a5cc4sm148220435e9.11.2025.10.27.12.17.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Oct 2025 12:17:36 -0700 (PDT)
Message-ID: <64b66fb0-f297-494a-8e79-b38c02c070b1@linaro.org>
Date: Mon, 27 Oct 2025 20:17:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] hw/xen: Build only once
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Anthony PERARD <anthony@xenproject.org>, xen-devel@lists.xenproject.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Paul Durrant <paul@xen.org>,
 Stefano Stabellini <sstabellini@kernel.org>, Anton Johansson <anjo@rev.ng>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
References: <20251022140114.72372-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251022140114.72372-1-philmd@linaro.org>
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

On 22/10/25 16:01, Philippe Mathieu-Daudé wrote:
> Replace target-specific code to allow building
> hw/xen/ files once.
> 
> Philippe Mathieu-Daudé (3):
>    hw/xen: Use BITS_PER_BYTE & MAKE_64BIT_MASK() in req_size_bits()
>    hw/xen: Replace target_ulong by agnostic target_long_bits()
>    hw/xen: Build only once

ping?

