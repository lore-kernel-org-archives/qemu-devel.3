Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB220C3ABA3
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 08:25:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAlhR-0001WZ-Lm; Fri, 02 May 2025 04:24:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAlhO-0001Sw-Cc
 for qemu-devel@nongnu.org; Fri, 02 May 2025 04:24:46 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAlhL-0000lV-5s
 for qemu-devel@nongnu.org; Fri, 02 May 2025 04:24:46 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5e5bc066283so2652261a12.0
 for <qemu-devel@nongnu.org>; Fri, 02 May 2025 01:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746174281; x=1746779081; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UtQpI+NCEgKaYzd5ZP106PWh5pc8fWKBb5RVFXL84+k=;
 b=C2OkMS2YZWv9aifUmKbgk9Fk9mhGSJMuHB0pYg1JOCJD0JxbLmCgU0Yjws+POg3Jdf
 DHM+3jrnkLAK0vCZbKFg/o74976KyEH6SdiaFHw/O6azMtw/IhLGo60cXu9h96ivo0F8
 4Fi9NDAdlQvtaG2zZul+ExfWpyQA3B2uYrOf+/OokLn3PPN2t4RPsYpdOLKCzcMjJK8s
 l+wBZQYZXW9c1D8dpbzAKfVxWarsVmcHfXTlz2xWRUBL7v+OSBq7siB7nvOut72uEApC
 VwuNPt+OLeiUiSILlYOy56XNQ9l4p25k9C5YtOhRXL3C77uJpwqY4QZIaPR9VxU5kEnK
 J14g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746174281; x=1746779081;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UtQpI+NCEgKaYzd5ZP106PWh5pc8fWKBb5RVFXL84+k=;
 b=EEebNrI9A7TtMI3xvwp1U6n5bnSHxbrOLvtjI/JG2yoBDlnZHpGvsah15soYkoxEhU
 QK1whXAsn7x6cZABqr4EtPL0ibix0IeFQe4yK+JOAzIbQWTsR2tf5ty6FFdSRi0VIZfM
 XCx7zCHewrxq95r2DeOxEL5OJ+Jg1XFZ/RgoJRlWTjztRggn77nTgcEqJUITxd3WCr0s
 ztrctIfI4ER3RUTDrfHRDZuHGA2WpVVuT5Pn4MCkR/bI2rUPjNYVP7d/mFNKfCUVA95o
 VhDnd8+8PRcamSwIBkvp8+f1FrTTtXb58vbkgiwmiTsiWd9R2Oom2naJfJg8X1rnTIoq
 lnmQ==
X-Gm-Message-State: AOJu0YyfjEVPJ56cSxT0WqHiEJsr861s5ze3ZOzZyFZSt+nV4D862XCw
 djUaZtnW6kQEDlrBCXAsfQMZsRtumDFfGFThFD9BRPxu/knApgVrD91bVgausNI=
X-Gm-Gg: ASbGnctmG8W75DCId9oEMBHiFRxSdoGMZThKrSvcIpoCBL674O098naOT45EjPBwnUe
 tkUPlMmNkeWbT7lOl91HXuKKxScrE9FKB9YBJpAEJsNH89KbPkBjpIUPWDxRoovL+U5BpMFi1wR
 dPSJ1BSCqwegyCNTHYSaOALrakF1cpJZ4kTHvp1EKrsaVUEyitn+LG1qH9/qpZxYVteM470z4TL
 2lyXU7MitVnm+HM53EGJ43L8bHJodW+iVvVFUQYQRZ8a2lsNU1VAIJkM8xugdHuibnHa3h4c+xE
 j/BiDvrDg0EdIZJdyo2c0ToRcIYysme5ADYdxokgjrDLEtuvaBX5HqJ7cpeBIHpFoDtniGNUh9r
 odB9AfYVS
X-Google-Smtp-Source: AGHT+IH9UBgg8/jOi2t+R6VuylmjHdty6gePImkBoeTqpmd4/uV5eXK3UFOiBNT0F1u/IcumUEmSVQ==
X-Received: by 2002:a17:907:72c6:b0:ac3:bf36:80e2 with SMTP id
 a640c23a62f3a-ad17ad8024dmr211637366b.20.1746174280845; 
 Fri, 02 May 2025 01:24:40 -0700 (PDT)
Received: from [192.168.69.244] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad189540485sm11936066b.168.2025.05.02.01.24.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 May 2025 01:24:40 -0700 (PDT)
Message-ID: <14f30ea3-2200-4289-9f66-a23fd77a091f@linaro.org>
Date: Fri, 2 May 2025 10:24:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/22] tests/qtest/usb-hcd-xhci: Deliver msix interrupts
To: Nicholas Piggin <npiggin@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Bernhard Beschow <shentey@gmail.com>
References: <20250502033047.102465-1-npiggin@gmail.com>
 <20250502033047.102465-9-npiggin@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250502033047.102465-9-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52b.google.com
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

On 2/5/25 05:30, Nicholas Piggin wrote:
> msix

Hmm? :)

> ---
>   tests/qtest/usb-hcd-xhci-test.c | 14 +++++++++++++-
>   1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/qtest/usb-hcd-xhci-test.c b/tests/qtest/usb-hcd-xhci-test.c
> index 7f801f8f1a0..2eecc8d9f26 100644
> --- a/tests/qtest/usb-hcd-xhci-test.c
> +++ b/tests/qtest/usb-hcd-xhci-test.c
> @@ -48,6 +48,8 @@ typedef struct XHCIQState {
>       QPCIBar bar;
>       uint64_t barsize;
>       uint32_t fingerprint;
> +    uint64_t guest_msix_addr;
> +    uint32_t msix_data;
>   
>       /* In-memory arrays */
>       uint64_t dc_base_array;
> @@ -279,7 +281,8 @@ static void xhci_db_writel(XHCIQState *s, uint32_t db, uint32_t value)
>   
>   static bool xhci_test_isr(XHCIQState *s)
>   {
> -    return xhci_op_readl(s, XHCI_OPER_REG_USBSTS) & XHCI_USBSTS_EINT;
> +    return qpci_msix_test_interrupt(s->dev, 0,
> +                                    s->guest_msix_addr, s->msix_data);
>   }
>   
>   static void wait_event_trb(XHCIQState *s, XHCITRB *trb)
> @@ -298,6 +301,9 @@ static void wait_event_trb(XHCIQState *s, XHCITRB *trb)
>           qtest_clock_step(s->parent->qts, 10000);
>       }
>   
> +    value = xhci_op_readl(s, XHCI_OPER_REG_USBSTS);
> +    g_assert(value & XHCI_USBSTS_EINT);
> +
>       /* With MSI-X enabled, IMAN IP is cleared after raising the interrupt */
>       value = xhci_intr_readl(s, 0, XHCI_INTR_REG_IMAN);
>       g_assert(!(value & XHCI_IMAN_IP));
> @@ -395,7 +401,12 @@ static void xhci_enable_device(XHCIQState *s)
>       uint32_t value;
>       int i;
>   
> +    s->guest_msix_addr = xhci_guest_zalloc(s, 4);
> +    s->msix_data = 0x1234abcd;
> +
>       qpci_msix_enable(s->dev);
> +    qpci_msix_set_entry(s->dev, 0, s->guest_msix_addr, s->msix_data);
> +    qpci_msix_set_masked(s->dev, 0, false);
>   
>       hcsparams1 = xhci_cap_readl(s, XHCI_HCCAP_REG_HCSPARAMS1);
>       s->maxports = (hcsparams1 >> 24) & 0xff;
> @@ -640,6 +651,7 @@ static void xhci_disable_device(XHCIQState *s)
>       guest_free(&s->parent->alloc, s->command_ring.addr);
>       guest_free(&s->parent->alloc, s->event_ring_seg);
>       guest_free(&s->parent->alloc, s->dc_base_array);
> +    guest_free(&s->parent->alloc, s->guest_msix_addr);
>   }
>   
>   struct QEMU_PACKED usb_msd_cbw {


