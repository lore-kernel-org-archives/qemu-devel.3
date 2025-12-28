Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 280A7E9271B
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Dec 2025 01:33:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZfeS-0003V8-3E; Sat, 27 Dec 2025 20:32:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wsh@wshooper.org>) id 1vZfeN-0003UZ-PW
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 20:32:51 -0500
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wsh@wshooper.org>) id 1vZfeM-0007vx-3Q
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 20:32:51 -0500
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-7bab7c997eeso9420704b3a.0
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 17:32:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wshooper-org.20230601.gappssmtp.com; s=20230601; t=1766885568; x=1767490368;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YHF634QQEy7XLPI8IFuAQD92NavKWIssy44yKkEKhqk=;
 b=fsqE5UZYTkDIenwuaujMMR9ozYU4zj4YLqGwJkmnj74JujUbIMQ6GkS0mP+5mAhl7l
 N1WMfT89RXty6bRoaD30YLXwQ4Pfeam1KymbkVWBvezmXrNVW34/b1HCQAv2+LK0rISZ
 LEPxi3J5swRjqhKag//yf1EP5QIrXlobkf15U/Du/B2YxRpL4s/ci2S94+kAjT1KuWt3
 L6CmFMmKaVpDczqH8Vea1ByLNNvfKQiP6i/a7QG6yBTvfLw/pDLTroy7BNUt+8Y4ohym
 2OqrIISU7IqSpQ/giqoFc3DfJDNJFgxSwnRn57SiVGO3rwEslHHgGWda6xUsvq7nqfxC
 3sow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766885568; x=1767490368;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YHF634QQEy7XLPI8IFuAQD92NavKWIssy44yKkEKhqk=;
 b=PWjkMQ3PVAIhNBika/Qx1STolth1VhHvGfM1I+H/YisD48B/fBp19p5vaDs19i6jDa
 3+EQC3u+b9NhtlHcgFWA+TqLGSYotgAobhGVks+ntTTh+bv1D6yzlpAn72toFTxrGm2y
 hUDZ5fwKRxrShfAD4Xzv0yyZbnjPkww0Z0F1UcppeAbgBMjTIpm2SqziWwj8dtqHxHIL
 SXvCQXIHMQb5qSAoUXk49rXfVhkmFkKEel1YjJdyCBs+hdd6ao+MCYkWG5YEbWcEGIvC
 KLiZUQXskely1pcYpTaQdNargv7Vt8sztd5re//gCqYKPmEknDGDSfCN39gVpAsGYgpM
 imQg==
X-Gm-Message-State: AOJu0YwoWV7uuttYn7AMxxfFR1DcPEfdr87ldRh4eao5jCQsVFXQLib0
 p5bnvtLMKERX6RlVW3MGAiSartTY8S1NkPSoWO03NssKE0bt+L25H5Bn6amxO5si7To=
X-Gm-Gg: AY/fxX5T809q+csG67tp2WbAtjd4r3AllcFdneUPOz1TYpZipg3CeQWtFiULXND111T
 YedFhKpqiFBpkbDwrLsmLRCZruQegg/rLHgM9CPo44Sofs/xv6TXlsLqWh3QBtupYwxMcERMVor
 x03sj1VUYaHmI+Tn45YnWtv57/aUbk/lHpRqM04m333MEe1dRIc8sb9OYBY4C89tYZPDhJ8Ja69
 zzRbb+9mW1ugR7lRePae4DR1OAJfKJ5Ls0WXFShy+hZXT/U3NiaWIPurogr9Oi+EI4khMSFKMxm
 qF/ASSvodJ9l5/fscPkAt1BJN8SEDH37At/Jo5kpFbsJOuDSd0jTp1wHM46EUjMqCWyiArA3421
 +Bz1U/gkJvt5uJ26JA/8wQuL7/HzyjFi0AagVopq5TU7zRSK3QQkcEo7ZXLMDAQ9pWPhqO0H6Hp
 f5okZbKfvGoSjJDUpnBNkuSHAehaB1tKPx20ahy9EJtbNuTINjcB39yuQG6nn9YBo6smo=
X-Google-Smtp-Source: AGHT+IHaxGxeiin9a1I1RGaXV5eoQe4/3tG/FPIPsARO+nivwUkeYRyNAgCP4954aOQITNIwcJnZxg==
X-Received: by 2002:a05:7022:2514:b0:119:e569:f275 with SMTP id
 a92af1059eb24-121722de5e9mr27250198c88.30.1766885567420; 
 Sat, 27 Dec 2025 17:32:47 -0800 (PST)
Received: from localhost.localdomain (syn-076-081-243-074.biz.spectrum.com.
 [76.81.243.74]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-121724dd7f5sm102760893c88.5.2025.12.27.17.32.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 27 Dec 2025 17:32:47 -0800 (PST)
From: William Hooper <wsh@wshooper.org>
To: Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] m68k: link.l is only available with 68020+
Date: Sat, 27 Dec 2025 17:32:46 -0800
Message-ID: <20251228013246.77473-1-wsh@wshooper.org>
In-Reply-To: <20251227210250.411882-1-laurent@vivier.eu>
References: <20251227210250.411882-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::42c;
 envelope-from=wsh@wshooper.org; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On Sat, 27 Dec 2025 at 22:02, Laurent Vivier <laurent@vivier.eu> wrote:
> Base 68000 only supports word size.
> 
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  target/m68k/cpu.c       | 3 ++-
>  target/m68k/cpu.h       | 2 ++
>  target/m68k/translate.c | 2 +-
>  3 files changed, 5 insertions(+), 2 deletions(-)

Reviewed-by: William Hooper <wsh@wshooper.org>

