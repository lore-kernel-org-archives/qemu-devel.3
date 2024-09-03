Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1053CD3448
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 16:42:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slWbR-00040W-EX; Tue, 03 Sep 2024 12:42:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1slWbH-0003Tm-2G
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 12:41:54 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1slWbB-0007ak-Bi
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 12:41:50 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-715c160e231so4675352b3a.0
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2024 09:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725381703; x=1725986503; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CJCA0ytlHl/8WR2E7WnCb8s4sqFGQWVw0zotZiThVcw=;
 b=NyWzXQNW+AF8fw+gDTmAwkjZ2LGiqRYWEXIW0N9qUUnvFKpv/pMdID4WO1abpjh2sJ
 LnmwMNNtOmOKdZlEUgl42QGHU+NTUm/aZoJa2c9nmWzJsAc1MqW/H1nXLOJ7y7U2qU/7
 Ao3pjGX/GNeFnZOak5ZcBKAu/pp4+8wOsER2GOiy0MpjiJTW/i7Mz6WZGW3K/eLllz1R
 xqrFNdAM7XQ0DeBA260YTttFQVJ90anOi0th93esZv7pIvA8C9TuKJJkUHocPo1u+hKB
 RX0ZmFc0cGf7zkFwFxLoR1V5ZDRgn+j38782+L/FabwYTGMIoaiKeEOKzrKK9fHgLA+q
 MysQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725381703; x=1725986503;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CJCA0ytlHl/8WR2E7WnCb8s4sqFGQWVw0zotZiThVcw=;
 b=LYKMw8XXLstsTccmL3UwXXFgy2yZfjbRl6wMY2lcn7QiCi4nOXyWyMInqB/x5P4AXl
 cOKsFO92SDKjZ5KEQVDQh+bnvVNGqAkYEJQnQFYL+cpPAl8CaS6/RAIPCDzpmbkTvVEI
 VaGPNdah1FoiShWqqVKN3u4QJBo7lAnCdmJ2ldcbZcQ2HAxWDikxtzSF+SGb8xa4FiNf
 ocsg5KD/V5zcFIQ2NwRd98Wn+1hETbvIaY+BxI8cx2w+IiKQRbzvULVeUBBtewblZ/8B
 7eitAS7jD06Ri7WB8aePUz5GdifWIfeT5rx0J6SWFmE5GeIZ39X9N5Klg1dTSZcDCmrG
 qgVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXtzDhhDnjM/00UMRRsV7lHwMps0dqNPdY/RmWcnW1mOvbLMquKAew6MR4mZARLFQ5nk0UNlz6JEmsy@nongnu.org
X-Gm-Message-State: AOJu0YzYXUtFt24iTUzy3kY0qmBzhDni4BPqrtd2/ngJoo6T9XnaF1+N
 92r+dGF30wECmu125HI4E7JUfjibLfy2RB3MWG/K6ciltmY5xryHqar6FRbmK8I=
X-Google-Smtp-Source: AGHT+IHqr8ccSmHU8G8S9K0uy/o4wg+yMs44F9StcIWEvuSRoNTr4rgoP2J6e6k5TtNFuqB2nmZ6ng==
X-Received: by 2002:a05:6a20:9d8e:b0:1cc:ce91:8459 with SMTP id
 adf61e73a8af0-1cce0fff4edmr19243313637.5.1725381702918; 
 Tue, 03 Sep 2024 09:41:42 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7177858bfc9sm73655b3a.124.2024.09.03.09.41.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Sep 2024 09:41:42 -0700 (PDT)
Message-ID: <664c54d6-ac73-4e3f-9d2c-dd0a357fd1d8@linaro.org>
Date: Tue, 3 Sep 2024 09:41:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] plugins: add two events for cpu_restore_state_from_tb()
 and cpu_io_recompile()
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Xingran Wang <wangxingran123456@outlook.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
References: <SY8P282MB4322879DBA2E5E3E3B72B383A1912@SY8P282MB4322.AUSP282.PROD.OUTLOOK.COM>
 <87mskqcp5n.fsf@draig.linaro.org>
 <592a0bc6-fbf0-4189-bd47-7b7cc6fc7681@linaro.org>
 <87seuidjtp.fsf@draig.linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <87seuidjtp.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 9/2/24 10:52, Alex Bennée wrote:
> Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:
> 
>> Hi Xingran,
>>
>> On 9/2/24 03:42, Alex Bennée wrote:
>>> Xingran Wang <wangxingran123456@outlook.com> writes:
>>>
>>>> Currently, the instruction count obtained by plugins using the translation
>>>> block execution callback is larger than the actual value. Adding callbacks
>>>> in cpu_restore_state_from_tb() and cpu_io_recompile() allows plugins to
>>>> correct the instruction count when exiting a translation block
>>>> mid-execution, properly subtracting the excess unexecuted
>>>> instructions.
>>> This smells like exposing two much of the TCG internals to the
>>> plugin
>>> mechanism. You can already detect when we don't reach the end of a block
>>> of instructions by instrumentation as I did in:
>>>
>>
>> I agree that this is definitely a QEMU implementation "detail", and
>> should not be a concern for end users.
>>
>> The documentation already warns that all instructions may not execute,
>> and that in this case, it's better to instrument them directly,
>> instead of TB:
>> https://www.qemu.org/docs/master/devel/tcg-plugins.html#translation-blocks.
>>
>> Finally, even if we integrated an API like what you propose in this
>> patch, I think it would be very easy for plugins writers to make a
>> mistake using it, as you need to keep track of everything yourself.
>>
>> If we want to stay on the topic of this patch, one direction that
>> would be better in my opinion is a "after_tb_exec" API, where the TB
>> passed in parameter is guaranteed to have all its instructions that
>> were executed (not interrupted).
> 
> Or indeed resolves with the current PC at the "end" of the TB where it
> gets to. QEMU could keep track of that easily enough as the recompile
> and bus fault paths are slow paths anyway. It would be tricky to support
> inline for that though.
> 
> As TB is exposed internally I think we'd just need to set a flag and
> call out. Maybe an API like:
> 
>    /**
>     * typedef qemu_plugin_vcpu_tb_end_cb_t - vcpu callback at end of block
>     * @vcpu_index: the current vcpu context
>     * @pc: the next PC
>     * @insns: instructions executed in block
>     * @userdata: a pointer to some user data supplied when the callback
>     * was registered.
>     */
>    typedef void (*qemu_plugin_vcpu_tb_end_cb_t)(unsigned int vcpu_index,
>                                                 uint64_t next_pc,
>                                                 size_t n_insns,
>                                                 void *userdata);
> 
>    /**
>     * qemu_plugin_register_vcpu_tb_exec_end_cb() - register execution callback at end of TB
>     * @tb: the opaque qemu_plugin_tb handle for the translation
>     * @cb: callback function
>     * @flags: does the plugin read or write the CPU's registers?
>     * @userdata: any plugin data to pass to the @cb?
>     *
>     * The @cb function is called every time a translated unit executes.
>     */
>    QEMU_PLUGIN_API
>    void qemu_plugin_register_vcpu_tb_exec_end_cb(struct qemu_plugin_tb *tb,
>                                                   qemu_plugin_vcpu_tb_end_cb_t cb,
>                                                   enum qemu_plugin_cb_flags flags,
>                                                   void *userdata);
> 
> I think the tricky bit would be getting TCG to emit the callback code
> for the last instruction before the
> tcg_gen_exit_tb/tcg_gen_lookup_and_goto_ptr bits but after whatever else
> it has done to execute the instruction.
> 
> I don't think we could easily support inline ops at tb end though.
> 
> Richard,
> 
> What do you think?
I think this will miss all exceptions raised in the middle of the block.
I don't think it will be reliable at all.


r~

