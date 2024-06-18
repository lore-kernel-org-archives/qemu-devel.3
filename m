Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FE89C27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 20:37:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJfZr-0006kf-Pn; Tue, 18 Jun 2024 16:37:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJfZp-0006iX-Oy
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 16:37:13 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJfZo-0004TB-3E
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 16:37:13 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3626c29d3f0so650283f8f.1
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 13:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718743030; x=1719347830; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Y+IevKFTv76CndXUesLWrW8UhW8oXmg6HlB4ji2VHJo=;
 b=tGR53TfKH6TyDpRIB3Esku0J3uuQyRMfACMizu9NiXQeafEAn5kBxoZqSQgYPjQdr/
 Klkw+gmLf29wz43CZ+5cj5UHFv/qNLEQKAQ4TkYr2Ukeibg+WU4PpgqWZ98FL6C03DbU
 UOa4gk9hQ5ZSzL2yLNxByL/c4IZpZBvkOlBrAVhdg2kyUPC5sePsiPY5tuxQ9m3usWCi
 UBNWxxSV7ZGBdq2Y77g/pFjnHMc3QkJowaCj5SpF95F7BL8wUuWWN8+lDM+3oF4UZyof
 YPcMd+qLsgHQmnjr48aU7iBegD3vLzNUCzHOXpinuPfgJwpnge7149zHVd3zgUmBSdv8
 ssqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718743030; x=1719347830;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Y+IevKFTv76CndXUesLWrW8UhW8oXmg6HlB4ji2VHJo=;
 b=GQYL5gkOaDk9dOwhjVxeRpyI8KPoZS2t3QodGfq3+FMWlUKinKUevXX3LLPisGOi/0
 UFvyPcDoTzDH2lEF56fRKaW5VHIP9WOsETwnvFrGOos8G4KuR6+IxrYo+TJx8j1fgelZ
 xsGx+4ICMcblCtZyLAz9+xnuhxsjbgQ99KEnP4Gs0aJPQqQBJvXk1xGYfs/gL2x0STiP
 AhFrE82i09GHjm0EfuMG0bVqP58REnib15n98IIGOOQ9jeTp/mPWvIMDYmfgsu2ptamZ
 1IOQ8xhv9VM3EPFzGnACBlazGzyDo7b9T0uBaCVdwGE2lkwP1jlcTpTjEY/UUYR/6BKj
 gLpw==
X-Gm-Message-State: AOJu0YxmwtHF0SlqBBE8n+RuFu9f113ZRBg//pI7StcKg/yIsIREKrKt
 QDsK0iOHsUr2DKl0Oa5DQWPB2xhxTJHNsSgv58DCXh2quRUkoqGTn37Ixs/sJRo=
X-Google-Smtp-Source: AGHT+IGBpAAVHbkS224WmucXvOZW8auH3g6riN+75rDCpHK2/k5F24fohtossJDzI/sRNGsNHD54IQ==
X-Received: by 2002:a05:6000:1bc1:b0:360:9bf5:1eab with SMTP id
 ffacd0b85a97d-36317c79ff7mr456024f8f.36.1718743030314; 
 Tue, 18 Jun 2024 13:37:10 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.212.55])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-362ba0b9b3esm1307332f8f.74.2024.06.18.13.37.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Jun 2024 13:37:09 -0700 (PDT)
Message-ID: <c60ac5cc-c592-46bc-b09a-b918253cb6cd@linaro.org>
Date: Tue, 18 Jun 2024 22:37:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/usb/hcd-dwc2: Handle invalid address access in read
 and write functions
To: Paul Zimmerman <pauldzim@gmail.com>, Zheyu Ma <zheyuma97@gmail.com>
Cc: qemu-devel@nongnu.org
References: <20240618135610.3109175-1-zheyuma97@gmail.com>
 <CADBGO7_XF5REzENPGupwMB-EOHXS78SG5v=yZ6TRZ_7yVgWUtg@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CADBGO7_XF5REzENPGupwMB-EOHXS78SG5v=yZ6TRZ_7yVgWUtg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi Paul,

On 18/6/24 20:58, Paul Zimmerman wrote:
> On Tue, Jun 18, 2024 at 6:56 AM Zheyu Ma <zheyuma97@gmail.com 
> <mailto:zheyuma97@gmail.com>> wrote:
>  >
>  > This commit modifies the dwc2_hsotg_read() and dwc2_hsotg_write() 
> functions
>  > to handle invalid address access gracefully. Instead of using
>  > g_assert_not_reached(), which causes the program to abort, the functions
>  > now log an error message and return a default value for reads or do
>  > nothing for writes.
>  >
>  > This change prevents the program from aborting and provides clear log
>  > messages indicating when an invalid memory address is accessed.
>  >
>  > Reproducer:
>  > cat << EOF | qemu-system-aarch64 -display none \
>  > -machine accel=qtest, -m 512M -machine raspi2b -m 1G -nodefaults \
>  > -usb -drive file=null-co://,if=none,format=raw,id=disk0 -device \
>  > usb-storage,port=1,drive=disk0 -qtest stdio
>  > readl 0x3f980dfb
>  > EOF
>  >
>  > Signed-off-by: Zheyu Ma <zheyuma97@gmail.com 
> <mailto:zheyuma97@gmail.com>>
>  > ---
>  >  hw/usb/hcd-dwc2.c | 9 +++++++--
>  >  1 file changed, 7 insertions(+), 2 deletions(-)
>  >
>  > diff --git a/hw/usb/hcd-dwc2.c b/hw/usb/hcd-dwc2.c
>  > index 8cac9c0a06..b4f0652c7d 100644
>  > --- a/hw/usb/hcd-dwc2.c
>  > +++ b/hw/usb/hcd-dwc2.c
>  > @@ -1128,7 +1128,10 @@ static uint64_t dwc2_hsotg_read(void *ptr, 
> hwaddr addr, unsigned size)
>  >          val = dwc2_pcgreg_read(ptr, addr, (addr - HSOTG_REG(0xe00)) 
>  >> 2, size);
>  >          break;
>  >      default:
>  > -        g_assert_not_reached();
>  > +        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 
> 0x%"HWADDR_PRIx"\n",
>  > +                      __func__, addr);
>  > +        val = 0;
>  > +        break;
>  >      }
>  >
>  >      return val;
>  > @@ -1160,7 +1163,9 @@ static void dwc2_hsotg_write(void *ptr, hwaddr 
> addr, uint64_t val,
>  >          dwc2_pcgreg_write(ptr, addr, (addr - HSOTG_REG(0xe00)) >> 2, 
> val, size);
>  >          break;
>  >      default:
>  > -        g_assert_not_reached();
>  > +        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 
> 0x%"HWADDR_PRIx"\n",
>  > +                      __func__, addr);
>  > +        break;
>  >      }
>  >  }
>  >
>  > --
>  > 2.34.1
> 
> Looks good to me.
> 
> Reviewed-by: Paul Zimmerman <pauldzim@gmail.com <mailto:pauldzim@gmail.com>>
> 

Does that mean on real HW the access to unassigned registers are
silently ignored as RAZ/WI like this patch? (I don't have access
to the specs -- IIRC you don't neither, but you might have real
HW to test).

Thanks,

Phil.

