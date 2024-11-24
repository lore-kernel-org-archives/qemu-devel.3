Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF31BE6688D
	for <qemu-devel@archiver.kernel.org>; Sun, 24 Nov 2024 12:29:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFBjG-0008TT-RH; Sun, 24 Nov 2024 07:28:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tFBjF-0008T2-73
 for qemu-devel@nongnu.org; Sun, 24 Nov 2024 07:28:41 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tFBjD-00068u-BG
 for qemu-devel@nongnu.org; Sun, 24 Nov 2024 07:28:40 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-431481433bdso31946085e9.3
 for <qemu-devel@nongnu.org>; Sun, 24 Nov 2024 04:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732451317; x=1733056117; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qaeSiiAxxBpiSHvzxp5Gd1By6LR7RiRGvxoZlw8BM7I=;
 b=WjJDklt24xjHBY5Z2JJgLs5EWdMpvhyfcq9rh2zrP3r7a0nYcMizWJKbFiYHezJ9YP
 Da0Mdu8dtwzVH7KAzwLfS8paHCslvLbO+LxtvtcTwvnHP7ykyq9dl/0KOjxkdefKZQzO
 iTWMYquppgfsSSxWRDK8sHH41Shai2dcZayuFBfNt+qWg42PCxTNuaPZhpQVAQuq+6EH
 IhPEyzo5/c09g1k+6CaB9jAem+u1nF8In/bDGLXTnw0mb5wogJBgspe0wF7HAdaLdGDt
 AIIZ81SX8fQmKhGTR8lwbrEdP6uXWYCzjFnMrRatOZSgF1RiHCnN+4bPjBlAW/lDNEnt
 HhYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732451317; x=1733056117;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qaeSiiAxxBpiSHvzxp5Gd1By6LR7RiRGvxoZlw8BM7I=;
 b=h80lgYNFQyYePz84DTqW2VeMBbFRazfGszXHFUHoKho+LcUacrn7l2AdRh+w64wMJe
 CciSaFuaIqBrwyrYyCUreorF7khPdKqHXXHShQ0YN7o2Yf2ZpLy8I12YhrxiG1ELE8Tw
 Cj4S+k0zU/n6drWVc24QM3JgDEpYUxi/AupNxZN/GGByIfkF7m6nTCSvEQFyrsWlIXom
 cESxB+lG/lU0tvzj4L4fBwbbfALFUZGoRiEmjexoOR9yXO0e2SyH9tRQ47+bl+HdkRKm
 AOQzgNdhktHMQ5RoAOfnH+U5jGMIdhNXei7tDpE6rYeTvyBuunL2h24qX3W4ogX0vgGP
 81vQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXE4jwN/rifRp9jTcaGRwilm7Pqvq9gAUQs30GM/HJ0NBWZPMA3dpusJa1mEg4fN8RBxe/xNBSDnQ2q@nongnu.org
X-Gm-Message-State: AOJu0YzPrQ56PFg/JR2VHltozFioOP//i0X91Cb2wT1cv2jhMvo34rPg
 OT2NQUKnyniClcmkmJs+ogkLFQupZeJm5vI5bna1epeE30ikjxFLYP8uJgJ+6xg=
X-Gm-Gg: ASbGncsMT+EsWjYpF0oW9qpbI8GpKIU7v9Be4mw/4qx/ytyNqxpAwkNWTmxltSvweGh
 TxkRh89nTThI/cqBcvcnea7aAfSABxZYvY5GPqHwNDS0qI9CqB8iIY7+1nDsfdJ5wU+K4b7cCd7
 oGdNnMHWn4jBKtHZr8mi8bmMgReu+4Ji5TfhdwjRiG/zKJn+6aT3nGQwweG1ENJrIzvxb8jKWgN
 XpFdb9YLDUPG97C14wDlTFLapzG/x/vGvG+8Q+rpwZ3xhKrdYiTTFcaKVVsu0MJJIBwXQ==
X-Google-Smtp-Source: AGHT+IGbYKNldjjZkg28bvwUBY0lVgoOtj9CDfgxx7O2/ex74tvsNjaRCWUF4C6yIUfSjh4zbhCF9A==
X-Received: by 2002:a05:600c:3b26:b0:431:52da:9d67 with SMTP id
 5b1f17b1804b1-433ce4108ecmr87371385e9.3.1732451317235; 
 Sun, 24 Nov 2024 04:28:37 -0800 (PST)
Received: from [192.168.69.146] ([176.187.215.43])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43499bdfc0fsm33660415e9.19.2024.11.24.04.28.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 24 Nov 2024 04:28:36 -0800 (PST)
Message-ID: <ae79e5a8-d875-41c5-ace0-911be633d8c5@linaro.org>
Date: Sun, 24 Nov 2024 13:28:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Supporting clang on windows
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <66c346de-7e20-4831-b3eb-1cda83240af9@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <66c346de-7e20-4831-b3eb-1cda83240af9@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 24/11/24 01:21, Pierrick Bouvier wrote:
> Hi all,


> After thinking about it, a simple, exhaustive and reliable way to find 
> this type information is the debug (dwarf) info.
> By compiling qemu binaries with --enable-debug, and extracting info 
> using llvm-dwarfdump plus a custom filter [4], we can obtain a text 
> representation of all structures QEMU uses.
> 
> As expected, turning the option globally has an effect. The exact list 
> of structures impacted (those having bitfields, and not being packed) 
> can be seen for each binary here: [5].
> As there is a lot of repetition between all qemu binaries, the reduced 
> list of structs concerned is [6]:
> +name:ArduinoMachineClass size:0x0198
> +name:ARMCacheAttrs size:0x04
> +name:ARMVAParameters size:0x04
> +name:AspeedMachineClass size:0x01d0
> +name:_GIOChannel size:0x70
> +name:MachineClass size:0x0188
> +name:MicrovmMachineClass size:0x01a0
> +name:MPS2MachineClass size:0x01a8
> +name:MPS2TZMachineClass size:0x01e8
> +name:MPS3RMachineClass size:0x01a0
> +name:MuscaMachineClass size:0x01a8
> +name:NPCM7xxMachineClass size:0x0190
> +name:PCMachineClass size:0x01c0
> +name:PnvMachineClass size:0x01b0
> +name:PPCE500MachineClass size:0x01e0
> +name:RaspiBaseMachineClass size:0x0190
> +name:RxGdbSimMachineClass size:0x0198
> +name:S390CcwMachineClass size:0x0190
> +name:SpaprMachineClass size:0x01d0
> +name:Sun4mMachineClass size:0x0190
> +name:TriBoardMachineClass size:0x01a0
> +name:VexpressMachineClass size:0x0190
> +name:VirtMachineClass size:0x01a0
> +name:X86MachineClass size:0x0190

The *MachineClass ones come from [*]:

   struct MachineClass {
       ...
       unsigned int no_serial:1,
           no_parallel:1,
           no_floppy:1,
           no_cdrom:1,
           no_sdcard:1,
           pci_allow_0_address:1,
           legacy_fw_cfg_order:1;

IMHO Using bitfield to manually micro-optimize memory size seems
a bit a waste of developer time/focus, I'd rather see compilers
doing that for us.

Regards,

Phil.

[*] Interestingly Thomas is also looking at those fields:
 
https://lore.kernel.org/qemu-devel/20241122084923.1542743-1-thuth@redhat.com/

