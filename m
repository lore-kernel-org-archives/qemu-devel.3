Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FAF3D2ED08
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 13:39:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7vmX-00027F-Lu; Wed, 01 Apr 2026 09:38:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7vmW-00022e-Dc
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 09:38:52 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7vmU-0007yv-C5
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 09:38:51 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4887f49ec5aso25277875e9.1
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 06:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775050729; x=1775655529; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FP6uLrWzjgYl1svCdxNI/KAmzzhVQS3rx3BtEwpgB2w=;
 b=aPutFpgczL50oxNzPftHGs0BemLci7WGMUynVy26oz+RSRIbpdRAWUN/oSxlhpPqsZ
 UEjxuxflZ47eQ1SuvopWBOEkThJkJT0CLhmTnJmEOl02qr8jhI1U46H2B/o7gZhQTB/D
 LMnXnClivtps7WqntMizj61oc8+xGTYj04wZe78NL5tWQmqWWZnNdPXx0pr0/pVTO5ld
 hSjC2HbKUWBBhnXNeUWRxy9LjLCUpnze8J7Tmwzoj0D2wX6DvuUBfuCcZifo32gq2itJ
 /IzG7y1M/idBVQUR+cVgKV1YQ0030dl8uxooAmL2xsnpIXwCd0hTDtws1MAXcTDpRXFu
 pSEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775050729; x=1775655529;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FP6uLrWzjgYl1svCdxNI/KAmzzhVQS3rx3BtEwpgB2w=;
 b=dnfWb0bM6UjygSxJ44AgwnCNHohU5ke6uMKq8AqUV+zcZKP/vjONOGZoab1B4fpEMc
 DHHIKLyrs317m+lUhmT6xw3llMP6WnmV0HtI2EJa9eEXUO747SzZUD94FE0v3X4/o0kh
 1I+ofX/ns0j8MNXnYNfx/CaP/ayf0tqVJnGA7WQznirpl0VtbEfrFrTxG7XRjrTyvsKg
 zX7KOp49+we+C1YzXOZHmsSnMNhsZPrFg0u4LtaTLNrEGpRhFONPk3JfNaxc1oMuC7ZU
 Wdtyn4UwJsikMfoGKACwF/QZ0v9GHcCzvii4vNcW2oGJio1HkKNu+k+HHztoXkVHkJ47
 UjuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWGK6aLpbbrzZ+KtVZW3zO0IkA+tm+4+5+I/wFa5MxvP1VbGjPV9NMAm7PsYrIDtTYACXGXkHN1FSfd@nongnu.org
X-Gm-Message-State: AOJu0YzrXuhI0LNGa6gZK+tma9R9lfBk3FI8eIkVmWJxGhdD3/zjEB1Y
 j2r43yOAakUE3mpYZT5OCu7rj9lTMIsLJish7sEPUl9YsCc1pS3cBkGCLdozIFuwWm6AWGArMHk
 xhPAbpMA=
X-Gm-Gg: ATEYQzzrssaoPWqaNokKZhgmwnHR6uL/ujbXlGTOx7MHc9v9lZl1a0va2fS3qq6aWOh
 ed9qsAxvyhPzeY25xKUtO57VrysPdjVz8PmADKyLZ4lv+RHaqAM0iPn7ZIBNDQVXRvzdtE/PiH3
 TbG5HT6VK6Qj+4UIiMESrQBgsBgEDr2DFhH7XBy1Abu7L0heBfmwOYWsgXk3n+ueySGRJlPrStr
 T9/TlsW82OErjqN0ERboZ4OP+Ub+sDxcC3ImcqBBvAKsI/oJSyQJ4rj4pga/MOFRSvni0+3upgZ
 DK8FXONUgAlKC6w66W7Sm8ksuKrbGEqw0SVIvQ2UhF2KI/qQui6QtdhDonSWXiohJ9ZRlJ+l7Gj
 qN7hcSRdEwaOEq4rcROBh2AFXHEPWgeMFFUX3hpiFFvwav4xo+5N3bcJZjcvdCKUa3y9p7YMBYC
 9ccLCO1+Kpg5SUDBZRX3FcAMAtVPtpJvOevU4Wd/93+yV61/DLenx/bDHXlnQ80y4kYg==
X-Received: by 2002:a05:600c:1e8c:b0:485:46fd:7887 with SMTP id
 5b1f17b1804b1-4888356734dmr64136485e9.13.1775050728577; 
 Wed, 01 Apr 2026 06:38:48 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4887a630922sm162326935e9.0.2026.04.01.06.38.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Apr 2026 06:38:48 -0700 (PDT)
Message-ID: <36ddb335-5844-4149-b757-4cd68d37d45e@linaro.org>
Date: Wed, 1 Apr 2026 15:38:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 27/60] ui/console-vc: move VT100 state machine and output
 FIFO into QemuVT100
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
References: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
 <20260317-qemu-vnc-v1-27-48eb1dcf7b76@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260317-qemu-vnc-v1-27-48eb1dcf7b76@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 17/3/26 09:50, Marc-André Lureau wrote:
> Move the terminal escape sequence parser state (TTYState, esc_params,
> text attributes, saved cursor position) and the output FIFO from
> VCChardev/QemuTextConsole into QemuVT100. Rename the corresponding
> functions from vc_* to vt100_* to reflect they now operate on the VT100
> layer directly, removing the indirection through vc->console->vt.
> 
> Add an out_flush callback to QemuVT100 so vt100_write() can flush
> output without knowing about QemuTextConsole, and move FIFO/VT100
> initialization from qemu_text_console_init() to vc_chr_open() where
> the callback can be wired up.
> 
> This continues the decoupling of VT100 terminal emulation from the
> chardev layer, making QemuVT100 a self-contained terminal emulator.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   ui/console-vc.c | 433 ++++++++++++++++++++++++++++----------------------------
>   1 file changed, 215 insertions(+), 218 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

