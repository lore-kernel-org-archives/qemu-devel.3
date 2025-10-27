Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE7EDCCF9E5
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 19:15:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDSfW-00016r-8V; Mon, 27 Oct 2025 15:14:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDSfU-00015Y-3B
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 15:14:12 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDSfK-0004ov-Fk
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 15:14:11 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-47103b6058fso37142915e9.1
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 12:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761592440; x=1762197240; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QZD91lk/H5cElIViFNtuzvYiD76APtVBDjWNMxi3u7I=;
 b=TXduyaogkX6gPb6s/0lslOCOjLPMu5IunR1gkwaHv/9LcE7FY0U7q+IVzpzPhVne32
 MOM4KFI0jYONTtM+CDMIWkKkxV/G5KDJGztfPlwIPAjz0LhjSFmYDqYnV1H4yAElY6ma
 f74QfsGCdLqjpFVPn3CuH6V1RGVHmK6zgY1c1bbaIyVr+D8rfGhFqZSmQKrFOw0Io2Lw
 ig9/MK/tPsORYe8kha0eybrLv6bfO2LF4Pvt/E68Lzyp+evn7iUElMPCHjOqOBd9mPOR
 oaoZty5CfLKaSbAuk8XsEVMp8G1UU3f+NbxNdnJzFnoEVtlOwtpPgF73lcGsDuRuZth6
 mPcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761592440; x=1762197240;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QZD91lk/H5cElIViFNtuzvYiD76APtVBDjWNMxi3u7I=;
 b=rb1iJwOxRq8O4e0flSv7DTXKyZOQ7ak+YQuupw0+H9/ImV3FsB8C1o0Avc75JHFx8x
 AYpJTU04bLSGo3KRY4rQR8WNwd8g/58JsiFKcWur+Xrd7rRIAk003igvpWj5OuhZk3JM
 wWOS0bV2cN8PEk/CHwySoxeiNNBtr5Uxhh4CGip/Sxit4gMg+2gAiccWwqbMgE/stVXT
 xIw4R+nuDqRviI5ZvnruZC7TX5QscDGBidt06ey0JwSAdiFtqTalr6672cAgEwGOFbqZ
 DO7FvCI4OeLHTXpcduCyK3VPre/2s/mBQ6rre8VRHqbjXjsz99SiUYHOIW2oSVmz14g6
 Ep9w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUr+Bof6X4iKR6AB3i5oSTkW70+JW5OILlcpK7t2qZsowEYzjhhelJV0z01Qfsd3mkgy5MamCGCa02g@nongnu.org
X-Gm-Message-State: AOJu0YzGc6IMXwwDKZ2czjEyFnhpWBja852raON0e7/idC7UDnky9YrJ
 sw0/CrdTsuRgA1IO/YDkElD3xD87CdtDlnqOprPx4LY00j8VCOlS30t5D7F/MER3Np8=
X-Gm-Gg: ASbGncuGN4eL7VF9S+lVMCeWTOno8/DYAMLMxkLaiDaVprC209iyA118sztBPSzlwzv
 3Q5FlDfdBmVtOrzNJLGhlohB8TV/vOdUK/n04abm+pR8RuqBuYqNbx90DlCHRLSTqP2nAUFUjuo
 Ayhrbaz0itBeMXksC0cVoUQ0WfGMukhDUFZ5cFi6hgAMyAWMr9X8gwRNhVyjecoCtOXn1HpAuKn
 FLuP/g9Ad1zLl2X4wKRvcBAzPHDgO4ACOQdlbiKkv9na5aj6RIySiZZ6biEebOxeJlkaMP6c5Z4
 vjzvKcXvce/a3fTBXm2QHRtedPdVQ3HwFYsIDb9xBUM47V/K991RIvbEi2GYlF3vucEbfJ19C73
 u2JRHo2ThGlXEzBayOLi9o9MLHnTYq/fTcmeVec9UVEQZVmR88yaPnTAjgTcYTgKUGfdvzX7tfT
 wnB5s2VFevjxY3MAXv1tt+BnuMHRb6bh7L6iqK+Jb80FN2bw49fNUl6Q==
X-Google-Smtp-Source: AGHT+IF8xLoboInyv51TbHc//7OxQ2/ZdVNu84tifKDxawEZDB2JRjAYlkB7iv0B+RW1DxkJ+9Crqw==
X-Received: by 2002:a05:600c:3f10:b0:46e:59bd:f7e2 with SMTP id
 5b1f17b1804b1-4771815a225mr6230765e9.11.1761592440123; 
 Mon, 27 Oct 2025 12:14:00 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952d9e80sm15796282f8f.28.2025.10.27.12.13.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Oct 2025 12:13:59 -0700 (PDT)
Message-ID: <91c9cbc9-ffd0-452c-bf93-9ff4b702e225@linaro.org>
Date: Mon, 27 Oct 2025 20:13:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ds1225y: Fix nvram MemoryRegion owner
Content-Language: en-US
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Rikalo <arikalo@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20251027-ds1225y-v1-1-406888eb495f@rsg.ci.i.u-tokyo.ac.jp>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251027-ds1225y-v1-1-406888eb495f@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 27/10/25 02:05, Akihiko Odaki wrote:
> s points to the MemoryRegion itself. dev points to DS1225Y, the real
> owner.
> 
> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> ---
>   hw/nvram/ds1225y.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Queued, thanks!

