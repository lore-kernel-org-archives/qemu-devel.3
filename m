Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD4F9E7718B
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Dec 2024 20:27:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tRGvZ-0006RY-MB; Fri, 27 Dec 2024 15:27:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tRGvX-0006RM-UQ
 for qemu-devel@nongnu.org; Fri, 27 Dec 2024 15:27:19 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tRGvV-0005ZV-Sg
 for qemu-devel@nongnu.org; Fri, 27 Dec 2024 15:27:19 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43621d27adeso52006595e9.2
 for <qemu-devel@nongnu.org>; Fri, 27 Dec 2024 12:27:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735331235; x=1735936035; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=p4O0vXcvFQi6NCehCovkZ2NkjvDyPab5DadoVABTZvw=;
 b=V8AZASbcUzB8YLX3WoFirEujwqf85o3MYEySvGoRm11iPjCzd4YNnJf3DFduiKPpa7
 Cu6MNdxPNwt2vN3jn4oslLwaWZNiZTqGvHMUJVkN86CXgKnODKP/dsXjFh4B8vAJ9Vy8
 VB5fMXSsVhP99lQARQw1dWIJie/tnSb27Sb8Iy8X5ihyLBjzgwV0mSoiXvVeJG1DNAV3
 dto/6ERQe8SGrZzkhkVctOd7dEUVUsPdMPGr1Zj733SdCr3mtZTg4ZJO3VoICWsSLVhn
 mWgK0Jnv5FWho292j+n89kFeZnHzwMDYFFq7v25P/xp8SwQW/X4qj/HaRf9+2Yl1My7i
 c2pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735331235; x=1735936035;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=p4O0vXcvFQi6NCehCovkZ2NkjvDyPab5DadoVABTZvw=;
 b=h6qB7ViiTpnN3UOomAk4INDM0j2kKxKPt+C95Ro8HbR9olfwBFGdMmgWRPxpS5pHOQ
 EFOztv+7+WdG9w5szMe3JAJDR+eL1+tbdB4eDx6oEm6n7Xqhdr785IP/F+sZ6Bsl2G4H
 brDh62XzQb7XvWcqEA1gHwcQ2d8UEmkg/vCCDNB+o+assoiaXmPMdr6bMKC43PmuOKuo
 pAVN8c/eMYr+ooW78SElPgEo25uARvEaLxUljpYx8y5GG1VYFRTgRuk4xXm5q5KM9t0p
 u2fcSpD14+QNL/zmX3c7p3kffX6sJjoxS7RvhlFCkFYeZOANG4kxWQP6MRLB2rCNS3or
 dnVQ==
X-Gm-Message-State: AOJu0Ywe0SPcZKKHsHqBc22uPEUxdVf8KO7Yh79OhwEv9zZ0oUNinIxS
 OaxYa60IxT6T+zfieUDIOwRe5cvGSOzOm9pEa7nRE2Xhz7JID2Iloh/cAGnKyuY=
X-Gm-Gg: ASbGnctq0PQyqUjr7yhx+jQ3dfWNc1Eb+PXu5vh8k/7/7wXl/fjSjFpIQRMl1j6Ejr0
 1iLqDX2GXiL5Hy2A7IijnbQV64tV2A+71I2+PPR741u6h55SfHFzuBBlNjR+qpGcPS9pdMVhg02
 54RRotaekeJSkGMZ7ZAAMcQWKxsKee9fvh1xy8DVUKqtZA3gJVB7R+G9Z28xzmsv2poRLUvz/gZ
 tzyGa8DI0z48QEhrx0jpg8kqmlR04OQ113QI76wZvL5jMwafTJl5mB633XA9adpWGHG5Qultubp
 T0kUK6qyo7CdAMTbXOoyzVfS
X-Google-Smtp-Source: AGHT+IFjPxSsDmsGUTcuJzTPnD+75U9wiDaPuotiE0Sg6UDEzqOtQ7g3Js4CxLg4+kVRGttqmpGT3g==
X-Received: by 2002:a05:600c:468d:b0:436:346a:fa9b with SMTP id
 5b1f17b1804b1-43668b499aamr204793705e9.20.1735331235514; 
 Fri, 27 Dec 2024 12:27:15 -0800 (PST)
Received: from [192.168.69.103] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c8a8d7esm23003794f8f.101.2024.12.27.12.27.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Dec 2024 12:27:15 -0800 (PST)
Message-ID: <f2f8a23e-32a8-4a2c-89a6-5f9ad0885dde@linaro.org>
Date: Fri, 27 Dec 2024 21:27:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/6] hw/usb/hcd-xhci-pci: Use modulo to select MSI
 vector as per spec
To: Phil Dennis-Jordan <phil@philjordan.eu>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, richard.henderson@linaro.org,
 thuth@redhat.com, zhao1.liu@intel.com, imammedo@redhat.com,
 akihiko.odaki@daynix.com, npiggin@gmail.com
References: <20241227121336.25838-1-phil@philjordan.eu>
 <20241227121336.25838-2-phil@philjordan.eu>
 <e332da74-d815-4c46-804f-a850d2ee12dd@linaro.org>
 <CAAibmn0CtihG5dijOKKQeMpW32vPoZTd_ekW5n_-3wVBVOP+uQ@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAAibmn0CtihG5dijOKKQeMpW32vPoZTd_ekW5n_-3wVBVOP+uQ@mail.gmail.com>
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

On 27/12/24 20:45, Phil Dennis-Jordan wrote:
> 
> 
> On Fri 27. Dec 2024 at 18:45, Philippe Mathieu-Daudé <philmd@linaro.org 
> <mailto:philmd@linaro.org>> wrote:
> 
>     On 27/12/24 13:13, Phil Dennis-Jordan wrote:
>      > QEMU would crash with a failed assertion if the XHCI controller
>      > attempted to raise the interrupt on a higher vector than the
>      > highest configured for the device by the guest driver.
>      >
>      > It turns out the XHCI spec (Implementation Note in section 4.17,
>      > "Interrupters") requires that the host controller signal the MSI
>      > vector with the number computed by taking the interrupter number
>      > modulo the number of enabled MSI vectors.
>      >
>      > This change introduces that modulo calculation, fixing the
>      > failed assertion and making the device work correctly in MSI mode
>      > with macOS's XHCI driver.
>      >
>      > Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu
>     <mailto:phil@philjordan.eu>>
>      > ---
>      >
>      > v2:
>      >
>      >   * Switch to modulo arithmetic for MSI vector number rather than
>     dropping,
>      >     as per spec.
>      >
>      >   hw/usb/hcd-xhci-pci.c | 1 +
>      >   1 file changed, 1 insertion(+)
>      >
>      > diff --git a/hw/usb/hcd-xhci-pci.c b/hw/usb/hcd-xhci-pci.c
>      > index e110840c7a..e5e7330387 100644
>      > --- a/hw/usb/hcd-xhci-pci.c
>      > +++ b/hw/usb/hcd-xhci-pci.c
>      > @@ -74,6 +74,7 @@ static bool xhci_pci_intr_raise(XHCIState
>     *xhci, int n, bool level)
>      >       }
>      >
>      >       if (msi_enabled(pci_dev) && level) {
>      > +        n %= msi_nr_vectors_allocated(pci_dev);
>      >           msi_notify(pci_dev, n);
> 
>     Should this be done at the MSI layer in the callee?
>     (I haven't checked the MSI spec).
> 
>     (Cc'ing hw/pci/msi.c maintainers)
> 
> 
> MSI-X has specified aliasing behaviour. As far as I can tell, MSI does 
> not - this does not seem especially ambiguous either. From the PCI base 
> spec 3.0:
> 
> 6.8.3.4. Sending Messages
> […]
> “If the Multiple Message Enable field is “000”, the function is not 
> permitted to modify the message data.”
> […]
> “How a function uses multiple vectors (when allocated) is device 
> dependent. A function must handle being allocated fewer vectors than 
> requested.”
> 
> 
> I understand that to mean that MSI vector aliasing is entirely device- 
> specific, and the assertion in msi_notify() is correct. The XHCI 
> specification statement that the vector should be determined via the 
> modulus of the interrupter index and the number of allocated MSI vectors 
> does indeed seem to be XHCI-specific.

OK, thanks for checking! Should we add this new information to the
patch description?

Otherwise,
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> (NB: reading the PCI spec, I’m struck that it seems very vague on HOW 
> the low bits of the message data should be “modified” to encode the 
> vector number. But perhaps I’ve just not found that section yet.)

Maybe MST/Marcel know.

