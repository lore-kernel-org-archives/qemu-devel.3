Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50E43C71136
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Jun 2025 05:06:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uR22g-000683-8q; Mon, 16 Jun 2025 01:05:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uR22W-0005vb-H6
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 01:05:48 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uR22U-00039Z-Vt
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 01:05:48 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-45300c82c1cso12352305e9.3
 for <qemu-devel@nongnu.org>; Sun, 15 Jun 2025 22:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750050344; x=1750655144; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8NP9s+tx48m7BdFmsQmElOUryZdvKVdirYNWILMc2kE=;
 b=ZjPsM5AvVOCmPoEtrXgxgf50V6yJ3J1jwvgTLKbPH2XZh84HP3niEtLWTPxunTIRHv
 i3oZBaDjtaArj/6dPgbdMY8RJGBck7okOKpSkBYunsxUg9CAMe50UMSDLVbojJUTXoXZ
 6WPFbupEB0WsJqGBP1ZRgvzIK80ItLp42ATnFWqG0IlqG12JLM91n/arnLJyTX/DG4U/
 M9E2t5Q/CuCKZzPBCrHSYqFwR9FWG1/gvyok7CFndsFDJ7vWVqZfj7TjnJFO9PFWsreD
 g6roAqo4cKFDXxLRPZBq3KEoEuQA3vrJQpNc1FpP+3Woq/xGwPYvhofBVHxqkAk9o5+n
 sTSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750050344; x=1750655144;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8NP9s+tx48m7BdFmsQmElOUryZdvKVdirYNWILMc2kE=;
 b=FbK2W7534TFhhbVUZP+5TVY3em2XgieGkvk1umfnSPHb4VmoAiEEVtGa1+iMfMExYu
 0QDJXG9V5Tzdb4EWusdR83PjV4u3fVLV9DqkRf4gJKv77qkq+37wg16ZPvmxGScVYyOy
 YiZUhdgSsJeWf5W8vt9rh01B6im55XlXrbSEFwv+IZchMjRJG68sD+mxKIB76Lx7IsU9
 WMuMWnPfN2a3O9wzz5dQOUg6Y5RoyrtaIuF+UnBjhP7iW1wryHLFr8sYIM1CeIFvXX36
 UYNcvNQ/fMqG8R3q/7qRJAM/TceZ84UkqEkRgc8dNqxhXc2kgzX3XDr9ZxQoeXvkMCjc
 EL/g==
X-Gm-Message-State: AOJu0YzSNdAHrMQm9TM5+zjGYFaOGWghSZRlaNOLb7wq58hXltOkyTMg
 CCkYeBRurjnbVAp6c4ELPfUl3l2vcuC3xN6F09IgnNsA7XwkXfRcIrw7HlMCOUpPtT8=
X-Gm-Gg: ASbGncubpXo4lUlmNiUURoBi7SdeaNdchulDKlp51eYOjVT6cdfP/ORN294hggBFd0d
 j/xl6P04IMZBAzF6wvXyp8s55kZN+ABy7SGuUvLwV1LpOHN15h4Lomk0V5J5X9RMivigthIMwtc
 AIiF1KnKFrbFL00jPEZfsJNj92Wl2fP+10SJhuYt26CAbGBFFfTRvg+kpr2l+M5yPwlBpOtR8y5
 OTNWLpbfwvhX7PetdEMLsAmk6xUt0xsohqfeKzHHiP8WJTnJQujHqn2+P1AtBxGwLJ17DMTEUC6
 kdODHW2kg3vQ8BhlCbECcoKd08D8/PygRLUSj9CNDlRjsaciFQEcTL+LMF1oU55QHZDiNtYkEUJ
 M7IZ9954awPqWrkO4gyjlf8MAoMV93jYRoYNxkFnG
X-Google-Smtp-Source: AGHT+IGKGU6qbvtJhZiFAbT2c+9hokS971qo7eFdgh0s/BAR49SBh+EbC1m4ZI801E7g6CCISPxqmQ==
X-Received: by 2002:a05:600c:3ac6:b0:450:ceb2:67dd with SMTP id
 5b1f17b1804b1-4533cb5751bmr64158355e9.33.1750050343822; 
 Sun, 15 Jun 2025 22:05:43 -0700 (PDT)
Received: from [192.168.69.167] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45320580af6sm162199965e9.1.2025.06.15.22.05.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 15 Jun 2025 22:05:43 -0700 (PDT)
Message-ID: <93ee20ce-52cd-48d1-9657-dd386d9d6e36@linaro.org>
Date: Mon, 16 Jun 2025 07:05:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/18] hw/nvram/fw_cfg: Inline fw_cfg_file_slots()
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Cl=C3=A9ment_Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 Zhao Liu <zhao1.liu@intel.com>, Hanna Reitz <hreitz@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 qemu-block@nongnu.org, Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Ani Sinha <anisinha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Yi Liu <yi.l.liu@intel.com>
References: <20250501210456.89071-1-philmd@linaro.org>
 <20250501210456.89071-13-philmd@linaro.org>
 <20250606152935.1ba8114f@imammedo.users.ipa.redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250606152935.1ba8114f@imammedo.users.ipa.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Hi Igor,

On 6/6/25 15:29, Igor Mammedov wrote:
> On Thu,  1 May 2025 23:04:50 +0200
> Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
> 
>> Now than fw_cfg_file_slots() only returns
>> FW_CFG_FILE_SLOTS_DFLT, we can inline it.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> does this even compile?
> I see more usages of fw_cfg_file_slots(), then being removed here.
> 
> git grep "fw_cfg_file_slots("
> hw/nvram/fw_cfg.c:static inline uint16_t fw_cfg_file_slots(const FWCfgState *s)
> hw/nvram/fw_cfg.c:    return FW_CFG_FILE_FIRST + fw_cfg_file_slots(s);
> hw/nvram/fw_cfg.c:        dsize = sizeof(uint32_t) + sizeof(FWCfgFile) * fw_cfg_file_slots(s);
> hw/nvram/fw_cfg.c:    assert(count < fw_cfg_file_slots(s));
> hw/nvram/fw_cfg.c:    assert(index < fw_cfg_file_slots(s));
> hw/nvram/fw_cfg.c:    if (fw_cfg_file_slots(s) < FW_CFG_FILE_SLOTS_MIN) {
> hw/nvram/fw_cfg.c:     * configuration is (FW_CFG_FILE_FIRST + fw_cfg_file_slots(s)). */
> hw/nvram/fw_cfg.c:    if (fw_cfg_file_slots(s) > file_slots_max) {

No problem in the branch I posted, commit from April (and yes,
it does compile fine):

$ git grep "fw_cfg_file_slots(" 09deca844303fde6761
$

I'm OK to rebase/respin once the prerequisite series are merged.

Regards,

Phil.

> 
> if we decide to remove x-file-slots, this patch probably needs some fixing
>> ---
>>   hw/nvram/fw_cfg.c | 13 ++++---------
>>   1 file changed, 4 insertions(+), 9 deletions(-)


