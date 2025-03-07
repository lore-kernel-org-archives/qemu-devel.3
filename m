Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5460C282DE
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 22:38:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqgKM-0004St-Tb; Fri, 07 Mar 2025 17:37:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqgKK-0004RX-Rz
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 17:37:56 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqgKI-0002yY-Vv
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 17:37:56 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-38f406e9f80so1738703f8f.2
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 14:37:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741387072; x=1741991872; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=e4rleLc94EIeJq/5s9DmHx8jo6DISQiC04wrdGtPmL8=;
 b=sFYbpGw3c2kSl3AIHHkXzOX+L+OO4WOO+lRc5Orm9g/OJkpz1FyyZJzfcvZ5Z9X4j3
 wZ0lgAWQcuZBVJf+BKKmQn+x+HscQxgJuR5VI7qsXIRu5pxMhLbfued56+WyZTrPQexe
 KgfScCY5u72dkwS9EVPnTwM0q5gJkzZpH2ZCZUlJL5V6ibD7oSs67cImik+LCBNIWIyM
 p5Z6krTTPhHgClCDZD1u9RusOuahTzuGLugLCbdVs7Q10aATnPaJ+lXv8xDEIS/Ubiw6
 1zHS4+5tmOYjeuT/75nxq/OE6MQu41VdzUYCKOiUSjmbGFk0DeMN8ZlA2dRjTdv1JZ3t
 L3pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741387072; x=1741991872;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=e4rleLc94EIeJq/5s9DmHx8jo6DISQiC04wrdGtPmL8=;
 b=VPGJCDxrx/MrqkFKULA5l9v4Aj2ha4JZaHNsrXookYSEeJpYhAPZixKpVdcDfqeT/y
 C44gGdL8qlTUNatJVmpc9waE48nh2t94LGjEkBzRzNM7jsYFbOJ7i4DGPxDpIU3Cwu3d
 Yi78g59IkrUPKlk3naHiZNnjOmN8UyGt46lUzmKsUBgtALNIs1T60x85jtn0aXi4xjtR
 +xEAvbFBiCMHMW6ZkYLyZBMLAjs7Yss3zihFQPAcwfYZ7kmItZoPwFo/F4621gNaO+LH
 fTsPJYyOcuSIOzvzPcHEMXw4kxN1JnBhhcHkCbATS6pVu/82UjJtrvwWiIbvoCpWioyI
 29FQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWb+tb41QIix7jDqQj/UxsISh155VkKhr0F9rWfE9Dh52IGNRpROJgoIO6cFjqA+/8wUvaflu5Rh4Xn@nongnu.org
X-Gm-Message-State: AOJu0Yzms32QQ5bvdniqHgq7HjcRrWxp6XJcdDFghJeVePz5y77vHp28
 +dCxjSrAg3ZXE2+hhPRFqnmtNduuIBbQ87LESOPNnp3Qgm5YClAVVu6hTeWSD28=
X-Gm-Gg: ASbGnctzoR32dpW3gZRBI4SoJBDKFujkwWfyoY3+rdoAPJBGgtjawZR039m7qPJ0R0c
 3QPVIfPF+hkrttY+iyZcs23x3EGqt39wr+tnoOQzWWyijysNMzJRM2JBYvJqQ8T8r5bv3nLIlUx
 dj2HiJflxSYuhNvJniKh07q+FZW37ppSiR3BYNwAoj2x5VdiIKA4biriGPPJSO7BmN1kz8MVs7b
 kbkhsFIioEeoKgkpXjkuG0WS5rXHgNPuxnBpJB4Sm4fXEwywk7h+4pcnpyN/crKZKvrAWi/YGwa
 4UPfzZhlnf+4YYWlA/rGjxwt6b7jF/GvWPxarPfZrpc+fNalarm8bmz18UOew8vf4IiuQiG4HYl
 yBsbRLTChRs2A
X-Google-Smtp-Source: AGHT+IGm6i4jn7/777fdWMH9irN0kdXHGTTez+ymNzVtUCzZNfBnC94C/cJUt846w13DX8FWoIrTzA==
X-Received: by 2002:a05:6000:2cb:b0:391:2da8:6e26 with SMTP id
 ffacd0b85a97d-39132dc402cmr3675207f8f.52.1741387072341; 
 Fri, 07 Mar 2025 14:37:52 -0800 (PST)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c01de21sm6778385f8f.59.2025.03.07.14.37.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Mar 2025 14:37:51 -0800 (PST)
Message-ID: <df3f78ab-5d47-4c11-8a4e-062b2bd47085@linaro.org>
Date: Fri, 7 Mar 2025 23:37:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/7] hw/hyperv: remove duplication compilation units
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 alex.bennee@linaro.org, qemu-devel@nongnu.org,
 Marcelo Tosatti <mtosatti@redhat.com>, richard.henderson@linaro.org,
 manos.pitsidianakis@linaro.org
References: <20250307215623.524987-1-pierrick.bouvier@linaro.org>
 <8c511d16-05d6-4852-86fc-a3be993557c7@linaro.org>
 <8d2a19a8-e0a4-4050-8ba5-9baa9b47782f@maciej.szmigiero.name>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <8d2a19a8-e0a4-4050-8ba5-9baa9b47782f@maciej.szmigiero.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

On 7/3/25 23:31, Maciej S. Szmigiero wrote:
> Hi Philippe,
> 
> On 7.03.2025 23:25, Philippe Mathieu-Daudé wrote:
>> Hi Maciej,
>>
>> On 7/3/25 22:56, Pierrick Bouvier wrote:
>>> Work towards having a single binary, by removing duplicated object 
>>> files.
>>
>>> Pierrick Bouvier (7):
>>>    hw/hyperv/hv-balloon-stub: common compilation unit
>>>    hw/hyperv/hyperv.h: header cleanup
>>>    hw/hyperv/vmbus: common compilation unit
>>>    hw/hyperv/hyperv-proto: move SYNDBG definition from target/i386
>>>    hw/hyperv/syndbg: common compilation unit
>>>    hw/hyperv/balloon: common balloon compilation units
>>>    hw/hyperv/hyperv_testdev: common compilation unit
>>
>> If you are happy with this series and provide your Ack-by tag,
>> I can take it in my next hw-misc pull request if that helps.
> 
> There's nothing obviously wrong in the patch set,
> but if we can defer this to Monday then I could do
> a runtime check with a Windows VM too.

Thanks, no rush on my side :)

