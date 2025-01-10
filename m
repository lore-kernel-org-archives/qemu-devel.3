Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53FB0E7719C
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 06:44:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tW8kV-00049H-KF; Fri, 10 Jan 2025 01:44:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tW8kU-000498-9g
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 01:44:02 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tW8kS-0003Wf-Nw
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 01:44:02 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-385eed29d17so898470f8f.0
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 22:43:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736491439; x=1737096239; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eSxEtg27h4hFortmdG+sHOfqorbolxztnTl8uexH1NU=;
 b=GyVqE2tRoy1pWpqEn8lCishBS/f3mfQkAdfUNX1YoLchcNixRJczIVXsuIs+pPAbQy
 DdkicidCl4cUg88bzn4eWx1NWw9yyFiIGtkEzt0c8oVM0U+vqV5rJGcHDbsBdvcGf+66
 zuvAZVY5O4632WxZ2yX09lLV4IDHm4p8LZKqw3rEZJ/XN1EvH5/vxjpW4X53yuE/5DgC
 wCyhCTxonUFhRliAIheweVxs5gc/HgDR8AD1vjOaz9cOyjsN6xfys/EHAa0htDZXWzBw
 WRQ2q1TD41aJTmaE0waqRxQ0W/seng1wdkChFTL8/RcELvE3epgkJHmcTOlLOM8sIHWM
 Spdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736491439; x=1737096239;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eSxEtg27h4hFortmdG+sHOfqorbolxztnTl8uexH1NU=;
 b=umk3DNF/joyNTw3HXzcNwUGkGJnGVVQMVM+KpAc5MS8tYLwix1z9liZ+QISQ3QKcZa
 YcfvDIyoHzqNkyyfXqnRT6XX2qtAI7bZFOxUwdvFsH17WWlC6LaZB5VcI9m3QkDrrdEP
 fCsjydWS6yTIR+RkPv3/J6K5KOK+QulQ8J/vhl5qMs0sO5ef74fyDj+dntmksxZK7Sg3
 s9oFzQPWwJ1lnPdYSn/KQ4tCVmZEC6ixsLw5xcgmr70gORHUrARDV3C39zlcw5p5/usC
 QnPmVuGgA5uHCOgnAjQY8CmE2huK6DjC/uert/eyRqimt74dKMXR/hlnzVJ5EwzUkBwH
 pn7g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSpjhif3fhxWoLKAsm3SfF4kt/rDL4HeCW4rrZpVedc8SooGr6VQeBJgjndv1w3u+5iemmHn7wE95X@nongnu.org
X-Gm-Message-State: AOJu0YzZgO2P1ItF8U5ZmiPiQNE7E9tlir7sxkHw0TZyne8QgSt2DqdJ
 PwCdah/tUattdfrTAZS9scMuT6RJ1RoIMjiYhO0AXXwVdONesRZ1QqLcD6/m7SE=
X-Gm-Gg: ASbGncvNBxqTGI7eANJx/1yMGqq1h4Wxnvfvr+Z9Naj4kp81mQ6eArgygZkb0w/NKQr
 GJTvP8JkiRG/MOrMFncEsqqiqRDlCSUVn6zo1ZAfF3zY8+iLo4P5t9eEnVLAcNyii0k7YkDO//x
 d0E4PxYX3KoqU1Ma1ukNFXQpQt974SaC8cnCAxiHaCT+MiTPs5un0Dy+71uLUuvPbd9g3eLspZZ
 nguB0DSvElOPq4IlM7pidEn5AOQXe6of5JMs7brpkI7qkDMAUFohoYlS+0IP/w5ui8lFK9N9EkY
 DeFwQsPGFYtdMYM0ZvdlY/sCJso=
X-Google-Smtp-Source: AGHT+IGDLf9nYmT0aNbr/wpzEyqKa3AHYb1DIisEVdSxtTGcdHPse5Pqev6eOrCUry0tYn3+vqUw8g==
X-Received: by 2002:a5d:5f95:0:b0:38a:88e2:e703 with SMTP id
 ffacd0b85a97d-38a88e2e75cmr4513727f8f.13.1736491438802; 
 Thu, 09 Jan 2025 22:43:58 -0800 (PST)
Received: from [192.168.1.74] (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e2dc0babsm76636375e9.14.2025.01.09.22.43.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jan 2025 22:43:58 -0800 (PST)
Message-ID: <1f229b58-02fb-4f92-96fd-dfc883c1ad0c@linaro.org>
Date: Fri, 10 Jan 2025 07:43:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] tests/qtest/libqos: add DMA support for writing
 and reading fw_cfg files
To: Fabiano Rosas <farosas@suse.de>, Ani Sinha <anisinha@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: berrange@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org
References: <20250109074929.252339-1-anisinha@redhat.com>
 <20250109074929.252339-3-anisinha@redhat.com> <87ikqnenn1.fsf@suse.de>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <87ikqnenn1.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 9/1/25 21:30, Fabiano Rosas wrote:
> Ani Sinha <anisinha@redhat.com> writes:
> 
>> At present, the libqos/fw_cfg.c library does not support the modern DMA
>> interface which is required to write to the fw_cfg files. It only uses the IO
>> interface. Implement read and write methods based on DMA. This will enable
>> developers to write tests that writes to the fw_cfg file(s). The structure of
>> the code is taken from edk2 fw_cfg implementation. It has been tested by
>> writing a qtest that writes to a fw_cfg file. This test will be part of a
>> future patch series.
> 
> What's the blocker for the rest of the series? It would be preferable to
> merge it all together, rather than this going in first without any
> users.

Agreed. We could use a multiboot image, or a guest with vmcoreinfo
support. Or a dumbier test just testing this API.

>>
>> Signed-off-by: Ani Sinha <anisinha@redhat.com>
>> ---
>>   tests/qtest/libqos/fw_cfg.c | 138 ++++++++++++++++++++++++++++++++++++
>>   tests/qtest/libqos/fw_cfg.h |   6 +-
>>   2 files changed, 143 insertions(+), 1 deletion(-)



