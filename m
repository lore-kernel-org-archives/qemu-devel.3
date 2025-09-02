Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5A7CCA0FFE
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 10:23:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utOB0-0001cF-JR; Tue, 02 Sep 2025 06:23:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utOAz-0001aY-2I
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 06:23:45 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utOAw-0008DR-To
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 06:23:44 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3b9edf4cf6cso4448054f8f.3
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 03:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756808621; x=1757413421; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JfWIWCH3TnD3+QAV9La1YOioI6YaS6rPL70UlLp4DPo=;
 b=zyetPdhkCYz9eBQhSU8nH4WO/X7R3Rz67RSUu/Aqi65eG1AzJ4/UGfsrqV8tAR42k/
 CBYNfDdGfydwmBhZBsMESN6/QeCDFVlQe9GuPz6e6XrlvegnHcZWTsqgYf94wlKb4O3N
 wjjGb6V6p2uCyGEGqUSqQJ7gLBed5PbI8kJRNCw1yGKLdtnWzK6sqnI27zY9IKKenaF1
 C5g6LCP3mVIG7KtHYpWWdlMo5lL96UGSMDKGo8c5OwocnP8bzr+6F0mGDBvDG540luyh
 3qlwJmHW+14Z140uPWBMpK/5pbgO/RW2iqxE/h4xpxILEINR4/Hw1oweMUS7LEF0DN+h
 NEOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756808621; x=1757413421;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JfWIWCH3TnD3+QAV9La1YOioI6YaS6rPL70UlLp4DPo=;
 b=rYQg2xvFDdqpCJwmfbClocGsG6V9ZIMQlGZxKz8QFnC+GTwBMztFngPJD6mx8Cb/i7
 uGF+baroaWUgWQM1/cHQySApj1FmaXnlGbEtYmmkD71SfFIQPYCJ/eCPcXb+O1wOgVUg
 G8pOV/FsicIIdcWAddqlpwiZcnNoc5DEu5lJ7PITEy2gtgpqSq7H0t91OBFiRB+dr6Hx
 q7yr5uUyhHKC8MTL0UvQCHGkYDeJvZBY2AGoRnVU4zW9YO9GSCpWxS5yfwNxzzEBqjIc
 lgkWidqP9+Ct9oXdbk3qXqcm9ZzrywiIJWSFPax+kZD0wcUZR6HUS4se4uqhLRQVB1Ed
 UWFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXviFA51nQz5HiUTsCm8dFWdaVc+6rlSVmXMYUmqygdi0K8DqyFzlhXHa/ZfJuU6X9qGdaTMcHXxOpZ@nongnu.org
X-Gm-Message-State: AOJu0Yy/+/6z8twlXHctaWjzihKB6SsEqQXrIZHW1ZeeqZJx5ZU9PR5F
 brWoLqANzeWk5R655uW1oVs9sS1BoUqdy13QnZy571EVEuxeUc54YfBcNQjJ5KmDke0=
X-Gm-Gg: ASbGnct+WZcFM4ClvI4MXH0l2Eq8iH4cnEkOv7kTbIbdCLHwknsr8aogtw+0dNMMwZL
 o8xersCjAWj6UHPXb4uyQwhf/F2EXX3w45zKk97xjQqdUVrY/X93c4IzQev8Eo3xCeZEBnrRAK/
 W7YEqglB+JM29rfNUCbqqojg3c7VBdbeUkpf206aDQCWEkHYwupuXoUkCAYK1Qr6kFWgsKVpzW5
 AHk61V40j2wP6I202DKz4bFNfAhFEHVMtrf65GsYfTOhEuk1jgKy9zAl1JkXsV8MlSdB7UHA2JV
 lfQi8YoMA5WNKBcEhiH+97Wr5ro8OgFV4G5APi6ewT4hCYfG0dslZIfuY7/lBsS/gRt/Fh19jM7
 OCyQriIarO5ELydYAsmizHcQDRA/c7TgyV9zXvpwSOe75XgmKI+mLuFz8SICf2wO7RyKkN32VqJ
 +khXh3+L6eDEk=
X-Google-Smtp-Source: AGHT+IH2VB2a4wYEbk0ICFjdY446Tb/B3/J5N690UBbjzpAhz5dOYhDE9UqMGDZeqalYGF8lHeMH+w==
X-Received: by 2002:a5d:5f4d:0:b0:3d5:a6a9:7d45 with SMTP id
 ffacd0b85a97d-3d5a6a98cb4mr4729797f8f.18.1756808620746; 
 Tue, 02 Sep 2025 03:23:40 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3d6cf485eb7sm8529738f8f.3.2025.09.02.03.23.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Sep 2025 03:23:40 -0700 (PDT)
Message-ID: <2c2f25a6-4f11-4404-8298-60b43fb28052@linaro.org>
Date: Tue, 2 Sep 2025 12:23:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] hw/char/serial-pci-multi: Use qemu_init_irq_child()
 to avoid leak
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20250821154053.2417090-1-peter.maydell@linaro.org>
 <20250821154053.2417090-3-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250821154053.2417090-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

On 21/8/25 17:40, Peter Maydell wrote:
> The serial-pci-multi device initializes an IRQ with qemu_init_irq()
> in its instance_init function; however it never calls qemu_free_irq(),
> so the init/deinit cycle has a memory leak, which ASAN catches
> in the device-introspect-test:
> 
> Direct leak of 576 byte(s) in 6 object(s) allocated from:
>      #0 0x626306ddade3 in malloc (/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/qem
> u-system-arm+0x21f1de3) (BuildId: 52ece17287eba2d68e5be980e1856cd1f6be932f)
>      #1 0x7756ade79b09 in g_malloc (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x62b09) (BuildId: 1
> eb6131419edb83b2178b682829a6913cf682d75)
>      #2 0x7756ade5b45a in g_hash_table_new_full (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x4445a
> ) (BuildId: 1eb6131419edb83b2178b682829a6913cf682d75)
>      #3 0x62630965da37 in object_initialize_with_type /mnt/nvmedisk/linaro/qemu-from-laptop/qem
> u/build/arm-asan/../../qom/object.c:568:23
>      #4 0x62630965d440 in object_initialize /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/ar
> m-asan/../../qom/object.c:578:5
>      #5 0x626309653eeb in qemu_init_irq /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-as
> an/../../hw/core/irq.c:48:5
>      #6 0x6263072370bb in multi_serial_init /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../hw/char/serial-pci-multi.c:183:9
> 
> Use the new qemu_init_irq_child() function instead, so that the
> IRQ object is automatically unreffed when the serial-pci
> device is deinited.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/char/serial-pci-multi.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/char/serial-pci-multi.c b/hw/char/serial-pci-multi.c
> index 13df272691a..9410428ba90 100644
> --- a/hw/char/serial-pci-multi.c
> +++ b/hw/char/serial-pci-multi.c
> @@ -180,7 +180,9 @@ static void multi_serial_init(Object *o)
>       size_t i, nports = multi_serial_get_port_count(PCI_DEVICE_GET_CLASS(dev));
>   
>       for (i = 0; i < nports; i++) {
> -        qemu_init_irq(&pms->irqs[i], multi_serial_irq_mux, pms, i);
> +        g_autofree char *irqpropname = g_strdup_printf("irq[%zu]", i);
> +        qemu_init_irq_child(o, irqpropname, &pms->irqs[i],
> +                            multi_serial_irq_mux, pms, i);

We could also pass "irq[*]".

>           object_initialize_child(o, "serial[*]", &pms->state[i], TYPE_SERIAL);
>       }
>   }

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


