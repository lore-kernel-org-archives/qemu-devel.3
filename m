Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8E01E77197
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 16:43:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVCfc-0000jU-9D; Tue, 07 Jan 2025 11:43:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVCfa-0000j8-KF
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 11:43:06 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVCfY-0004rg-Vl
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 11:43:06 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-385e0e224cbso7894149f8f.2
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 08:43:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736268183; x=1736872983; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ajBEs138YIrfNAaA0lf+oBxMqXWwTsndcE/xBwmdSmc=;
 b=P2LtI4TYWXjXz0V3StL85X7fVFazdk1w9R1+f5/nF6bLpfipWBW8xlC80zpy0Vbw/Z
 U85W37T3g0cltLqmepvnqeXTAjzKIgWPkcphtwZ48UQq2EoEouq8I2Po3TcW/zk9cChm
 Oivn3Eqv4PBUOr+KOLEbooyKBizBDqPbEh85McD/H1N5mkm6mYGRZMw0WKwWzQHyaG6q
 lBUUJqeDcugNZ4QQRQe+kFI2g/m0eVqVRkytf1nvk/i3dwkm0c/GHrmMNnCQBNFJyOlw
 v9KqxZ321dvGOHp4y735rXTbPfkPfUPTO9lz8uhQYvCZmxaHG2G9aRJtf7R7m28M9ET5
 5s1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736268183; x=1736872983;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ajBEs138YIrfNAaA0lf+oBxMqXWwTsndcE/xBwmdSmc=;
 b=BI08Wo513G/h+f1Dz2scCU4Bu/GOeEwD8+uB7cs8YVLOqbDMQBn2O5L9vumiTfCxSA
 gG8tZgHnSBoL9erYtPIVvOutPaKvZk+z+7gMDFfNQfRdxUdK0BLuVO568PXxJ6ZJfwR/
 pDhrKi5V2nxsGGHLhup+p4ChBLMkkkQlkdCT2MVI7RBdl0axBSRijlChlyKTnSnL+oWY
 kK8KTAyituLDmp9G7peJRvQ9i0Hs7GjnT4/mFT9KEXVrt/m1HG0r1RLj96eZROcMHtr9
 mrbULC5jT7xQ1DUogi9X5FM+Su0MxOU/tcMybi2I/UNdbKCH8B/3yDBikpZjmI+LccBX
 fUxg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWt5m4CbkmGA22tym9TtYGcuvzeu17rTPxBsAUg6Pfwvl5TZRThV8ikxnrvWsDelAQhQdqVH0eeYXZt@nongnu.org
X-Gm-Message-State: AOJu0Yz2v0hIX4hNFtqsAUpFHZrGWDIVsG4vuv/8bPQLmhclgd4zy1CY
 15yGi2ahUDfUw+dZtQ2pCFPmEsS+m49/e3s870CBJH+WDKmda4/RkfQ+h5VvkjU=
X-Gm-Gg: ASbGncsznfanqYFixXXPkuugi6IrVR11y//8We0qGOAVAW7XqmqFb1XIypyI0rab6XB
 zPIdGu9pJan4EpLaCd++g4xXmsbPoloRBP+SoUYEgGnlOMzJITazQdwXUr7T3r5Gidiv654NT8a
 fVBfpOpSLMw9xypzGU05VrhJ/aa1kdpzS0I7L7G08RbyRg/PlRRxDZWScGmz8artWK7JcFo7N6q
 TSepHxBpyiF+N5OGY7AVaxeK2LBmjNGaP5DUjmSi6Lz0zoett49NVHo4SMeqR9MNeV0Apdf3OVS
 LgWgeJlO3u2coVtVRC71KcUQ
X-Google-Smtp-Source: AGHT+IHa/XW/fbtvyBSeF7ED3j9c2/33wWRX1NZcT5YQsfZwrscWrLplJ3jYEZA2yHeopeM9MgtO8A==
X-Received: by 2002:a05:6000:1446:b0:385:fae4:424e with SMTP id
 ffacd0b85a97d-38a22408624mr46171891f8f.52.1736268183008; 
 Tue, 07 Jan 2025 08:43:03 -0800 (PST)
Received: from [192.168.69.132] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43656b417afsm642955295e9.36.2025.01.07.08.43.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jan 2025 08:43:02 -0800 (PST)
Message-ID: <9dff9882-01a0-43a2-987d-eea210e8cdbe@linaro.org>
Date: Tue, 7 Jan 2025 17:43:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 25/41] rust: qom: put class_init together from multiple
 ClassInitImpl<>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Zhao Liu <zhao1.liu@intel.com>, Peter Maydell <peter.maydell@linaro.org>, 
 qemu-devel <qemu-devel@nongnu.org>, qemu-rust@nongnu.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20241219083228.363430-1-pbonzini@redhat.com>
 <20241219083228.363430-26-pbonzini@redhat.com>
 <daea6757-a67b-45d5-bf2a-807fd9569a70@linaro.org>
 <CABgObfYMP5-9uN9cLofPT6DzBS_o1CVfbHbY8pwn9xjdOXOqgw@mail.gmail.com>
 <CAFEAcA-PE1paXOJNUo-cihu__htZQUYogZphVhRAjFNFzgi7JA@mail.gmail.com>
 <CABgObfZ7FFW5yhA2u6Rt5=MndrLsF=BnNhgE73LAyUWUGF=yXQ@mail.gmail.com>
 <Z31OiMcYT/66AGDt@intel.com>
 <CABgObfZETbD03-H6=qOt6V8GY4ex3WP82i5axzdf_U0GCwsMbw@mail.gmail.com>
 <7cc2a444-c699-4e56-80ff-8f9d6890b71a@linaro.org>
 <CABgObfaMja+D5NcCBp-AKUGgOgTR=uju93dyj57ZFAO+mUGUDA@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CABgObfaMja+D5NcCBp-AKUGgOgTR=uju93dyj57ZFAO+mUGUDA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

On 7/1/25 17:29, Paolo Bonzini wrote:
> On Tue, Jan 7, 2025 at 5:24 PM Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>> but I don't really like the two parameters and also I don't like that
>>> class_init is called differently for classes and interfaces. It's
>>> probably possible to design a better API, but I didn't spend too much
>>> time on it because it may require rethinking how classes are declared
>>> (not a huge deal, as we have only four of them).
>>
>> Are you saying this is not a problem related to QDev Reset, but
>> a limitation with any QOM interface, and we can not instantiate
>> any type implementing TYPE_INTERFACE? As in:
>>
>>     .interfaces = (InterfaceInfo[]) {
>>       ...
>>     },
> 
> So far there was no need for that, so it is not implemented. There are
> three parts:
> 
> 1) adding interfaces to the TypeInfo
> 
> 2) filling in vtables for the interfaces
> 
> 3) filling in the ResettableClass vtable based on a trait
> 
> None of these is supported by Rust code right now, but only (2) and
> (3) are needed for qdev reset. That's because the Resettable interface
> is declared in DeviceState rather than in the individual devices.
> 
> (2) boils down to wrapping object_class_dynamic_cast into a
> nice-enough API. The commit that I added to rust-next covers that and
> it should work, but the API is a bit unorthogonal.

OK, thanks for explaining.

So currently we can not implement any device requiring one of
these interfaces:

$ git grep -hwA1 INTERFACE_CHECK
31:    INTERFACE_CHECK(void, obj, TYPE_RESETTABLE_INTERFACE);
--
12:     INTERFACE_CHECK(AcpiDevAmlIf, (obj), TYPE_ACPI_DEV_AML_IF)
--
24:     INTERFACE_CHECK(AcpiDeviceIf, (obj), \
25-                     TYPE_ACPI_DEVICE_IF)
--
16:    INTERFACE_CHECK(ARMLinuxBootIf, (obj), TYPE_ARM_LINUX_BOOT_IF)
--
29:     INTERFACE_CHECK(FWPathProvider, (obj), TYPE_FW_PATH_PROVIDER)
--
23:     INTERFACE_CHECK(HotplugHandler, (obj), TYPE_HOTPLUG_HANDLER)
--
12:    INTERFACE_CHECK(InterruptStatsProvider, (obj), \
13-                    TYPE_INTERRUPT_STATS_PROVIDER)
--
113:     INTERFACE_CHECK(IPMIInterface, (obj), TYPE_IPMI_INTERFACE)
--
25:    INTERFACE_CHECK(IsaDma, (obj), TYPE_ISADMA)
--
26:     INTERFACE_CHECK(MemoryDeviceState, (obj), TYPE_MEMORY_DEVICE)
--
21:     INTERFACE_CHECK(XlnxCfiIf, (obj), TYPE_XLNX_CFI_IF)
--
33:     INTERFACE_CHECK(NMIState, (obj), TYPE_NMI)
--
30:    INTERFACE_CHECK(PnvXScomInterface, (obj), TYPE_PNV_XSCOM_INTERFACE)
--
50:    INTERFACE_CHECK(SpaprInterruptController, (obj), TYPE_SPAPR_INTC)
--
141:    INTERFACE_CHECK(XICSFabric, (obj), TYPE_XICS_FABRIC)
--
156:    INTERFACE_CHECK(XiveNotifier, (obj), TYPE_XIVE_NOTIFIER)
--
431:    INTERFACE_CHECK(XivePresenter, (obj), TYPE_XIVE_PRESENTER)
--
463:    INTERFACE_CHECK(XiveFabric, (obj), TYPE_XIVE_FABRIC)
--
38:    INTERFACE_CHECK(Nvram, (obj), TYPE_NVRAM)
--
12:     INTERFACE_CHECK(StreamSink, (obj), TYPE_STREAM_SINK)
--
20:    INTERFACE_CHECK(VMStateIf, (obj), TYPE_VMSTATE_IF)
--
14:     INTERFACE_CHECK(UserCreatable, (obj), \
15-                     TYPE_USER_CREATABLE)
--
35:    INTERFACE_CHECK(TPMIf, (obj), TYPE_TPM_IF)
--
35:    INTERFACE_CHECK(IDAUInterface, (obj), TYPE_IDAU_INTERFACE)
--
23:     INTERFACE_CHECK(TestIf, (obj), TYPE_TEST_IF)

Not a big deal at this point, but just to keep it in mind.

Regards,

Phil.

