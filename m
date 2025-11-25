Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B203CFD315
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 06:19:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNmOU-0007Fx-4h; Tue, 25 Nov 2025 01:19:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vNmOM-0007CD-OK
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 01:19:10 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vNmOJ-0002Sc-Ko
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 01:19:10 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4779adb38d3so35765835e9.2
 for <qemu-devel@nongnu.org>; Mon, 24 Nov 2025 22:19:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764051545; x=1764656345; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=X30FMRBV6rs2CIsf7r6Mx7FRlGfIzbGDOF+dbbDNFAg=;
 b=fmgJt+SnuV5Ct+CVUdKbgeVjdb9jt5sskyAD3+lsPF/EYa2y6RCIaxBqzXhaz4l/Yz
 dvgXI5QoYV6LLIfL+kMtugs1XHlaKq5X3a2fEHhTFGV20BnPNVNqw1oel2aPhmgLYpfu
 EZEV+PhTanxFVp1Geudv7xqiG0Z6GlLdl6zXopVHJu0tkNJWIMG1RHqDbzBUyuHMx8sm
 0MfZ888L9XySFrJM7SH8CozeZV/LRqiR0eI9ObY4KCy9BAiTtZOseo+TbOnVHJvGTS88
 zxmgHoI09RRju/6cCMjBYHUEDKybfjxtsrsOtpvwNX+ht8t6rA9dVyxJh6+Ixb0X6Ngw
 AuLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764051545; x=1764656345;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=X30FMRBV6rs2CIsf7r6Mx7FRlGfIzbGDOF+dbbDNFAg=;
 b=F9vHN7BeUTvG7wlNnTAIBaIGxOlwaetN1hDHG5IczHsnYsRrSkfUesSG/T6McHA88s
 rhEMu3Jhv2jaez85sCJVTsRQZQXQefA2OQGT7YeHzTrMnRDDZFEsuXE1Yw3VBuoBge18
 kXP+1zmAkwikBz3OuUIFx78s1OsF5S6VXMuqrc6vTBmrcFMpUx+TG+9cIAPyExIsVFf4
 RRd0wI1dFg+cnWZWorIaWmFwwcZjxnuz+mUGPMHHlqwP989sv37ly/IAUtNBypa2xFA1
 wJwMiKgSqmKiO8iPrwoVTtn2ZcWS+iUvb0zkmh+snhJPqGTNIRAKwUABsgiKy8biNJj/
 a1GA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4t5EFPxiEI87E5iksUnjyGJPOH77Lh4M145281OoVxKkONKBEgco+U2nvMKcIhGw45lpp1L5zd9sA@nongnu.org
X-Gm-Message-State: AOJu0YyD0WTa8f308QP+c9Fz0KjBgKsvvNXGdItrv0kx07xblEDYtwpV
 JNGv9HoJ0g5aReacU7D/X9a6TUrgiB3xgFYhAXzAR1y8O+8OkUP/XWnY6kweoGd/B+0=
X-Gm-Gg: ASbGncsF82MG0dBfQyBmtYDcRKyj44WhJqJ3fNBZtWbECxjlr+z8qVGqGRBAq2B8+q/
 xhnWAGc5OK1WoLorzM/bX02ROpE4ArJId9U2vmOGdQh9o3W0/yYmOtveHDMCzzwb3WpKnXkNoWX
 K8/nDvWCX2ZXYey3tV2CAv1rxyHkMuChS4DQ0JiKnwfULWnYxNEM4+pWS2KTnuswPycaro9ndXS
 pRtg/z07hm0CYp2WU5c7wJZ9ScH+40Zv9ymddjp3bws2qQbpoIhc5DLZN8yBvTpBtUkxu21RJAT
 D1LMG9j/RVfhd4wWx/4BOSswRhBZXSCbqXo69oeAlLCc67xumRClXoPAQk1DHFgIBrLZigbNvGm
 fACrKbuyKi5/HtEM7Ro94Zrr3gbhyInN9LSfNTEHwdfubBcbUcbcLDhTMR8XSft+P2kMfsx8qHK
 pCI/+j1qDJOkZtmcqcmyRrcQdwZp7NxSV6KaP91PVzs/bHyY+042aMWg==
X-Google-Smtp-Source: AGHT+IEAS/g3YIxold2M9P/q5H77arLENsXrfrsPawoV7IMsBeDbBm6FxQuMeLBU7nI1wau2acezwA==
X-Received: by 2002:a05:600c:c48e:b0:477:641a:1402 with SMTP id
 5b1f17b1804b1-47904ac438bmr12859925e9.4.1764051545408; 
 Mon, 24 Nov 2025 22:19:05 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-479040cfe17sm10996785e9.5.2025.11.24.22.19.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Nov 2025 22:19:04 -0800 (PST)
Message-ID: <7a99da47-44fa-45cd-8cdc-60bef1fa9e60@linaro.org>
Date: Tue, 25 Nov 2025 07:19:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/15] hw/virtio: Use error_setg_file_open() for a
 better error message
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: arei.gonglei@huawei.com, zhenwei.pi@linux.dev, alistair.francis@wdc.com,
 stefanb@linux.vnet.ibm.com, kwolf@redhat.com, hreitz@redhat.com,
 sw@weilnetz.de, qemu_oss@crudebyte.com, groug@kaod.org, mst@redhat.com,
 imammedo@redhat.com, anisinha@redhat.com, kraxel@redhat.com,
 shentey@gmail.com, npiggin@gmail.com, harshpb@linux.ibm.com,
 sstabellini@kernel.org, anthony@xenproject.org, paul@xen.org,
 edgar.iglesias@gmail.com, elena.ufimtseva@oracle.com, jag.raman@oracle.com,
 sgarzare@redhat.com, pbonzini@redhat.com, fam@euphon.net, alex@shazbot.org,
 clg@redhat.com, peterx@redhat.com, farosas@suse.de, lizhijian@fujitsu.com,
 dave@treblig.org, jasowang@redhat.com, samuel.thibault@ens-lyon.org,
 michael.roth@amd.com, kkostiuk@redhat.com, zhao1.liu@intel.com,
 mtosatti@redhat.com, rathc@linux.ibm.com, palmer@dabbelt.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, marcandre.lureau@redhat.com,
 qemu-block@nongnu.org, qemu-ppc@nongnu.org, xen-devel@lists.xenproject.org,
 kvm@vger.kernel.org, qemu-riscv@nongnu.org
References: <20251121121438.1249498-1-armbru@redhat.com>
 <20251121121438.1249498-8-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251121121438.1249498-8-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 21/11/25 13:14, Markus Armbruster wrote:
> The error message changes from
> 
>      vhost-vsock: failed to open vhost device: REASON
> 
> to
> 
>      Could not open '/dev/vhost-vsock': REASON
> 
> I think the exact file name is more useful to know than the file's
> purpose.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   hw/virtio/vhost-vsock.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


