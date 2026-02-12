Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF158EE3698
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 15:51:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqYxs-0001aa-Sd; Thu, 12 Feb 2026 10:50:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vqYxq-0001Zi-13
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 10:50:46 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vqYxo-00063I-Dq
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 10:50:45 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-47f5c2283b6so29015475e9.1
 for <qemu-devel@nongnu.org>; Thu, 12 Feb 2026 07:50:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770911443; x=1771516243; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dbc+ejlhexKqJRXXRcE7/vYNbCti6eE+TrxcRanXq1k=;
 b=z5Ioq1GXMs02ZqagIhNcjT/MSzCf8Ec9tHgnLK71eMCMEGJ+2tRc69K5PVxU/m/nWI
 ytbn0Y4NyNXMPqlGHU+qIYrcI4bf8HH3+PwlXyxkdYY75nsX2rWVIeeUGd46C7HjFcTi
 3ULlPpl2r3wEsyNmRzq0FE4nm5UUSaV+b0FxxPz9VBTCWPyYQepvjNClGT/JnX1ne2hu
 0tn5qor2Cl9ruBow6EcAhoQsu1VzkcArxRoJspZ5oAjcT2CNvTekG5DprVoBMCaAeipr
 qkCO6K0xSKpKj4XE7J5fN6XlmPMGi7cBZMXg6KgFnJxYtGdFwsnb1jqyuKpHxgLOm+UB
 W6tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770911443; x=1771516243;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dbc+ejlhexKqJRXXRcE7/vYNbCti6eE+TrxcRanXq1k=;
 b=WO5vjYKsUPrbp/g3e4cgTzWE5cc9BXRyAoHomc+vK/2x+oqzx5Ng0g696Vl+Grzd3L
 T8XNGrtLbAf811rYIEI5e62FqDoReKLlqK/JLi5tZhEI6bJNg+MMGyo3A5dO0/+0VKt9
 CcvVn9Kd8MfgBPL/7xVTYrHh/ttA/WMBCCbbt9lS2PvTHDjsH1zFDmFs1iTXRtG3yO5l
 sZQaf03J+sflA2LhIrtExUnfKRyw5jQmoCryAXvrktdC6HWjgOZHXd4DD2rZtOmex2kQ
 k0JL0nLN5/6JL81pDOfkOTpyQU296HqzjQigESZ0jiDNeZoacxaAR1iEhG1ZRF2AsJGj
 exmA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUyyRvfZVTTELfn1L00Zoe8kY6WWk7sl9+Efvsw69VZ52B/1p6zuXPmJAgCE6njogNQ+k23ZDmHsWB6@nongnu.org
X-Gm-Message-State: AOJu0Yzx2i3lnH/5vnooOHpfuopWgiQAve33CU+/AdWIDMMO6pnZKc3i
 WSOxvOJu1PD4vj+RiyekhAFOCsmYSKnvh9fzRtfCeFy+EtNu/kkNrf0M72XegwJ8zZg=
X-Gm-Gg: AZuq6aL6G2nM3QV5P7gAkAnJoxHDSehFLSMzszibN6NXrAOT6DGbyNaIQRqbHN/JJak
 PwlHhrABYMqmWj4SS69FIXp5/5mQFP/NNwf3V3DM7OW0aGJ7t73+D0RBFQOvSILU3OlEX+B4FY0
 qe4mkItvtlADMtJBi6sTSzMJHlnzfSjAMX3ItpQ/xRhMHM8l7T3C55s8MykV3jfO2g+muTwM7oU
 SqbFPl6EAVv7Boy1H+xQB/Ia1RovwvrWIq49DjtdJNRCwUTrH/IMwb707rsErWn/UnnLzFlTRcR
 foFVBcCkWSxuCS/0oVv2wV69+ql8PNCzT7IndgQgAjYW4vVyNFOmhxlIFYOsQGHIMyJQNE6eKWo
 hwyOThvDCl5G2z1X9y1OYfIkFKn4nc4cioc1wuHG0MnYz5ecCkV0W5YxZGjAmA9/yDD3OUjI3M5
 X7s7wHypcJ1MLDaroL/UUBl/wrfEm/yozfyoFmnWZyKMSlhuODyQw2k3uSyPLA8GOTKg==
X-Received: by 2002:a05:600c:19d2:b0:480:4a90:1afe with SMTP id
 5b1f17b1804b1-4836716c6ffmr45408115e9.34.1770911442619; 
 Thu, 12 Feb 2026 07:50:42 -0800 (PST)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4835d994670sm104358755e9.4.2026.02.12.07.50.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Feb 2026 07:50:41 -0800 (PST)
Message-ID: <79df010b-e4fd-4311-a4c7-5c6ca53e78b2@linaro.org>
Date: Thu, 12 Feb 2026 16:50:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] net: mark struct udp_header as QEMU_PACKED
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Jiri Pirko <jiri@resnulli.us>, Jason Wang <jasowang@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Patrick Venture <venture@google.com>
References: <20260212140917.1443253-1-peter.maydell@linaro.org>
 <20260212140917.1443253-5-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260212140917.1443253-5-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 12/2/26 15:09, Peter Maydell wrote:
> The eth_header is not actually guaranteed to be aligned.  We attempt
> to deal with this in some places such as net_checksum_calculate() by
> using lduw_be_p() and so on to access the fields, but this is not
> sufficient to be correct, because even accessing a byte member within
> a misaligned struct is undefined behaviour.  The clang sanitizer will
> emit an error like this if you run the sifive_u_mmc functional test
> with sanitizers enabled:
> 
> ../../net/checksum.c:168:24: runtime error: member access within misaligned address 0x5b7a7f829033 for type 'udp_header' (aka 'struct udp_header'), which requires 2 byte alignment
> 0x5b7a7f829033: note: pointer points here
>   ff  ff ff ff 00 44 00 43 01  34 58 54 01 01 06 00 85  95 80 60 00 00 00 00 00  00 00 00 00 00 00 00
>                ^
>      #0 0x5b7a71a5887e in net_checksum_calculate /home/pm215/qemu/build/clang/../../net/checksum.c:168:24
>      #1 0x5b7a7156819a in gem_transmit /home/pm215/qemu/build/clang/../../hw/net/cadence_gem.c:1386:21
>      #2 0x5b7a71566201 in gem_write /home/pm215/qemu/build/clang/../../hw/net/cadence_gem.c:1650:13
> 
> Fix this by marking the udp_header struct as QEMU_PACKED,
> so that the compiler knows it might be unaligned and will
> generate the right code for accessing fields.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   include/net/eth.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

