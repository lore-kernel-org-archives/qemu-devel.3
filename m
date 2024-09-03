Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F467CD37A9
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 17:18:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slXAC-0001uA-8c; Tue, 03 Sep 2024 13:17:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1slXA8-0001mj-Qe
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 13:17:53 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1slXA6-0003KG-Ry
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 13:17:52 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-53346132365so6903703e87.1
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2024 10:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725383869; x=1725988669; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cYbenkBoYNCeNgQP8dsyHNhQG3ZkFGz3Dry3Yum6nAE=;
 b=q3hUDRTiwfo3O6Hh/LuEVpCUIUSiLpjDiXqtU/f2C7kExrk5l1a262SDEinD9tRIQr
 Q97+2hN8r0HZknr6MetlW/2w/Yb/7dFP1XfRRIPFdnDM7TsrBBQSIzyDMNoAo+2qiYLG
 +6azldzC/ngp4Mz2TFuDuUCcPnJGg+HghOfd+qthcVa2Xk8Bu0QC53qsn1GHPZkdnCWo
 NfYmTvi0sGBl/Ox5vfr7sw6SiuzH9N+jQ9cCtkndFJ3I7HDmVVpZl39OaZbH6GVxJS0u
 YUCPpAIWUdXx77BiHH2lH1bcicBwRVLExp7mhMVPl7C89iFAPVx9Bk0B1eY8wvnRva6p
 +xGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725383869; x=1725988669;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cYbenkBoYNCeNgQP8dsyHNhQG3ZkFGz3Dry3Yum6nAE=;
 b=cOwyvppK5hl+mSYCrtXcxWC4+NTQyr2UsOr/R0cCMmRMK05P/o26PG61xkwgXsRVUt
 GxYZlU7XIZ7jY6VPfmk5AFaD8MbkKaDI/IfS3Frtz5hswie1p4Sd3cL+jyW6xQkNSrTg
 +EUnACLml9YxvMUw8zjf3Vr2hlRkTL117ldQRYUJkADl8bB982oktbFJ/AFhVChVGgO3
 hV6yLavg9GeISXXSQjYS34S4vLIUF2qtWq09zkTcr71ZEFs7CeeypYaJtf9TNID3Lczh
 /oDHNw5qPlvGpS4oXYhkDBV+53tRq4T2VSsxZ61jJdI7OCu2ffSR/IzEK8y/pgZr9nZy
 Dkdw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXuzoqg9IsW7uiFEkh2juFfVdhECeCo58VqdObJQ6TthJmnHfepub35Gy+5mxkhW3XfDiNnuOtqABsi@nongnu.org
X-Gm-Message-State: AOJu0YxiQUiUpWyVnsBycQZs+kKRQqWiad65Uf91ZV9szwwT1J32/gJg
 a184MNt1xKtLXuSy40tMEuBK39O+yxHmiZ+UYfNY/ADg6IHtbOorc8Rgr5ChitI=
X-Google-Smtp-Source: AGHT+IHZ+SeE8WkDk0ggAw8Md8Qm8+Cser4NRBKVOFaV9s+pmrNJSYeoWu0U1z/g9p0RPovKowlhnQ==
X-Received: by 2002:a05:6512:e94:b0:533:483f:9563 with SMTP id
 2adb3069b0e04-53546b8d711mr9089736e87.45.1725383868207; 
 Tue, 03 Sep 2024 10:17:48 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a89891d7368sm706414966b.168.2024.09.03.10.17.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2024 10:17:47 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id AF79F5F846;
 Tue,  3 Sep 2024 18:17:46 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,  Xingran Wang
 <wangxingran123456@outlook.com>,  qemu-devel@nongnu.org,  Paolo Bonzini
 <pbonzini@redhat.com>,  Alexandre Iooss <erdnaxe@crans.org>,  Mahmoud
 Mandour <ma.mandourr@gmail.com>
Subject: Re: [PATCH] plugins: add two events for cpu_restore_state_from_tb()
 and cpu_io_recompile()
In-Reply-To: <664c54d6-ac73-4e3f-9d2c-dd0a357fd1d8@linaro.org> (Richard
 Henderson's message of "Tue, 3 Sep 2024 09:41:40 -0700")
References: <SY8P282MB4322879DBA2E5E3E3B72B383A1912@SY8P282MB4322.AUSP282.PROD.OUTLOOK.COM>
 <87mskqcp5n.fsf@draig.linaro.org>
 <592a0bc6-fbf0-4189-bd47-7b7cc6fc7681@linaro.org>
 <87seuidjtp.fsf@draig.linaro.org>
 <664c54d6-ac73-4e3f-9d2c-dd0a357fd1d8@linaro.org>
User-Agent: mu4e 1.12.6; emacs 29.4
Date: Tue, 03 Sep 2024 18:17:46 +0100
Message-ID: <871q20vepx.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x134.google.com
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

Richard Henderson <richard.henderson@linaro.org> writes:

> On 9/2/24 10:52, Alex Benn=C3=A9e wrote:
>> Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:
>>=20
>>> Hi Xingran,
>>>
>>> On 9/2/24 03:42, Alex Benn=C3=A9e wrote:
>>>> Xingran Wang <wangxingran123456@outlook.com> writes:
>>>>
>>>>> Currently, the instruction count obtained by plugins using the transl=
ation
>>>>> block execution callback is larger than the actual value. Adding call=
backs
>>>>> in cpu_restore_state_from_tb() and cpu_io_recompile() allows plugins =
to
>>>>> correct the instruction count when exiting a translation block
>>>>> mid-execution, properly subtracting the excess unexecuted
>>>>> instructions.
>>>> This smells like exposing two much of the TCG internals to the
>>>> plugin
>>>> mechanism. You can already detect when we don't reach the end of a blo=
ck
>>>> of instructions by instrumentation as I did in:
>>>>
>>>
>>> I agree that this is definitely a QEMU implementation "detail", and
>>> should not be a concern for end users.
>>>
<snip>
>>    /**
>>     * qemu_plugin_register_vcpu_tb_exec_end_cb() - register execution ca=
llback at end of TB
>>     * @tb: the opaque qemu_plugin_tb handle for the translation
>>     * @cb: callback function
>>     * @flags: does the plugin read or write the CPU's registers?
>>     * @userdata: any plugin data to pass to the @cb?
>>     *
>>     * The @cb function is called every time a translated unit executes.
>>     */
>>    QEMU_PLUGIN_API
>>    void qemu_plugin_register_vcpu_tb_exec_end_cb(struct qemu_plugin_tb *=
tb,
>>                                                   qemu_plugin_vcpu_tb_en=
d_cb_t cb,
>>                                                   enum qemu_plugin_cb_fl=
ags flags,
>>                                                   void *userdata);
>> I think the tricky bit would be getting TCG to emit the callback
>> code
>> for the last instruction before the
>> tcg_gen_exit_tb/tcg_gen_lookup_and_goto_ptr bits but after whatever else
>> it has done to execute the instruction.
>> I don't think we could easily support inline ops at tb end though.
>> Richard,
>> What do you think?
> I think this will miss all exceptions raised in the middle of the block.
> I don't think it will be reliable at all.

Ahh yes - I guess we can't fixup as we go through cpu_loop_exit() and
the restore code is only called from helpers. Oh well I think we can
make do with what we currently have.

>
>
> r~

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

