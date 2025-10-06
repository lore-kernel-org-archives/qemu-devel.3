Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DED07CCA471
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Oct 2025 11:53:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5jlm-0006TL-OG; Mon, 06 Oct 2025 07:52:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xpahos@gmail.com>) id 1v5jll-0006Sn-9g
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 07:52:45 -0400
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xpahos@gmail.com>) id 1v5jlc-0002ae-Nc
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 07:52:45 -0400
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-586883eb9fbso3256045e87.1
 for <qemu-devel@nongnu.org>; Mon, 06 Oct 2025 04:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759751551; x=1760356351; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YskWGD68uJvBj0jMWXqhQa5vmb1tAxTHbSj3LJXf0EQ=;
 b=HN8aIjbdfbtv8b+nHf8RLC/w9uC67cz9MP8jWyx+vHtgdj7lxYijr0xGSSIM5izPLM
 uslly4vhnPkm6vhzOoSMtn2Zym7fASarBu2A7Xd11NDJtzep1ZQEPhA2BxH/hZZLI2jU
 6YITZP4aBEYYP1f3+gkzCUR9v4uII1WzW3zgGRoaVzzvWnvJePglF98raKk0i4lhZhyp
 rtY/N0eLBMMDAA+/C8AIF69lp5q5RADzogOKXjSJcbTruCOSuaIDA0n/KGRrWYQbRf3e
 KYmojeiVLmjgR93Rgyg71NbkKEDqeubzf2npfkYB54aBggKfDTY+Bug00gTTO9ReF5ws
 NhRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759751551; x=1760356351;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YskWGD68uJvBj0jMWXqhQa5vmb1tAxTHbSj3LJXf0EQ=;
 b=aU0Q3wphoFXk2nuiQQgTyIdqZYNisGpHItVY8W9mvIr6zuPAq06h8zoI5Cdlw2fqXo
 oLrz/2kzocNW6N1ckSLIVAg1U0ophMUfQJyDQULiqgNBp0nuQncUtt40lE+Kar2cQxQ7
 0566yXfY0g/Jn3SOBiUukeQXwiCmpw+vpxh1Z+yX15K9ynyef/LqhC9HGomTdZrt+Rag
 kS804aaeZnL/53DnRdKCfNLCW1gcCRSKrdZSgQSztS0OzpqFMrm9h7mnU6kxoCRwXcL8
 O/XYvC/tSlUYNPUK62kvxwKT3ERHObxRGk2eFPn7ktrIiuLf20m9fuIiYdCDP5L1rHE0
 YfCA==
X-Gm-Message-State: AOJu0Yzj9HPWvJTw6atTI5wKeic3yNjHxfIOU8smGAdA68qM+RYv4NUi
 Ky2xSQdO/CMWAwPXTZVCgc16W1PG0UuOjMnZGjTY+UJFC2bw9OoQDBBa
X-Gm-Gg: ASbGncsMJsb78B3l0OZNzQ4Mq2GvasVoWkYo8fHqRZUHGvY4rVv3zmvvlcqD8O535Q/
 JtFNvTCnS1q7WKz2v2yl6BEDDhYxkRD3qZlyBXIemiXboXtTUIHg085J0kjlUrSZfN2TYcqIiZ1
 FtLa3XYVsdAXFhcqm0kAeLglDKYyyM0oGfqh1s0gFfSNt1/iiYi5DOu1+DmDC4a1pA2Pf8Qxjjg
 TMcE1EPvBkMlW2JwYQVnrkjZhtQYmoDU91JbLEjJ80315Q3UZ8q2Rgru3DoD30xtdybne6vz6Kp
 kDrV36ZU+SCUSoM5SgH0b8LoestL4W413rwcagBzfvBrtKxq3S4RqoanRFjJ5hTa+M6hLEx22TR
 plFmNVcMsgmQvpnyz0eFxTmqXa3iyftg25DMGUvLr/LfxACJ8Q5mJoCaDEFjKTHRfToj4LFo=
X-Google-Smtp-Source: AGHT+IH2DW8NUO2RXA2M2qymj65OLOc1M07jw495xWAisuZjiORubU0t862pejjdPOnmA1LRq4hMiA==
X-Received: by 2002:a05:6512:3f05:b0:571:e01b:da9f with SMTP id
 2adb3069b0e04-58cbb06ade9mr3780461e87.31.1759751550501; 
 Mon, 06 Oct 2025 04:52:30 -0700 (PDT)
Received: from smtpclient.apple ([2a02:6bf:8011:f00:143:4fb8:4913:8a43])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-58b011b14aesm4995049e87.128.2025.10.06.04.52.29
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 06 Oct 2025 04:52:30 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.2\))
Subject: Re: [PATCH] hw/arm: add pvpanic mmio device for arm
From: Alexander Gryanko <xpahos@gmail.com>
In-Reply-To: <CAFEAcA_PbfzTAW2qeFao1MhPG=jn9dtzt0AzwL-aPCEULijsuw@mail.gmail.com>
Date: Mon, 6 Oct 2025 14:52:16 +0300
Cc: qemu-devel@nongnu.org,
 qemu-arm@nongnu.org,
 qemu-trivial@nongnu.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <A1FB7B7D-603D-4D21-807E-17C1B18891CC@gmail.com>
References: <CC5A0011-CD14-40F9-8023-8BF5F989BCCF@gmail.com>
 <CAFEAcA_PbfzTAW2qeFao1MhPG=jn9dtzt0AzwL-aPCEULijsuw@mail.gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-Mailer: Apple Mail (2.3776.700.51.11.2)
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=xpahos@gmail.com; helo=mail-lf1-x12a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Would it be acceptable to add a new device like uefi-vars-sysbus that =
can connect to the sysbus?


> On 6 Oct 2025, at 13:41, Peter Maydell <peter.maydell@linaro.org> =
wrote:
>=20
> On Sat, 4 Oct 2025 at 21:19, Alexander Gryanko <xpahos@gmail.com> =
wrote:
>>=20
>> Currently, pvpanic is available in three device types: ISA,
>> MMIO, and PCI. For early stages of system initialisation
>> before PCI enumeration, only ISA and MMIO are suitable.
>> ISA is specific to the x86 platform; only MMIO devices
>> can be used for ARM. It is not possible to specify a
>> device as on the x86 platform (-device pvpanic); the
>> only possible way is to add an MMIO device to the dtb,
>> which can be implemented by manually adding new functions
>> to the QEMU code, as was done in the VMApple implementation.
>=20
> No, thank you. I don't want to add more devices to "virt"
> than we have to. There is a PCI pvpanic device -- use
> that. Yes, you might have to do PCI enumeration in software.
>=20
> thanks
> -- PMM


