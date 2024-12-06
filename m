Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C781E77173
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 19:03:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJdb8-0004DT-JJ; Fri, 06 Dec 2024 14:02:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tJdb6-0004DC-Ni
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 14:02:40 -0500
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tJdb4-0007vg-Tk
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 14:02:40 -0500
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-7fc41b4c78bso1671473a12.3
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2024 11:02:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733511757; x=1734116557; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iY/ROd5ZTjr8KBE8gn7my8bPVJoOInhWJvQ/K1kdSFY=;
 b=ksWFq1SKjsv7/vtIa30URhGLBmkiKRMukow/R/G4zDl4TxxS4YcA8niMVMR0hZavWq
 AEvjwIjCLJuBa+kBr28L+0HmE89bzQj1SfrpMYY3l9/W8MeZld0vA5rZEjNkORIM622i
 2gd+gJk+yjCheNgwvcfZsBPOX3WWXenJzhMblX8hgtWPlPaIvPFiUash0NWLIP1vfdTn
 0QNZ3YXUU0S8X0pw8fV4eA31qR+vZ9HtJC/GNPC3avMb2MC2kgEr28v+lQId6PgKpi0h
 LlkaNcMM6AyGc8w2UA0PR363UI65MSQI8mI93eqqJyxHLNf1+2npUnlnGdSluhnmXcwl
 jJOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733511757; x=1734116557;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iY/ROd5ZTjr8KBE8gn7my8bPVJoOInhWJvQ/K1kdSFY=;
 b=QTH8w7MyCo0VyUz/3g8o1K9h23XkOZRPE1BfJD0D7DGqPKk5ue+Psk5v1RWLnfBThN
 XLm5ifq3pPIgav7hKgzUVIJK4czwSkQKDD5DHZ4uSl9wbnPgwTFOr3tRcePQRuIKZIN/
 rE3984qfvNCmE0Ww70FqVYt/73lAo5QBx7HKd8L6lLf9A9A+q8YDc7SXwO42MJMVCxm7
 eXCQ50oyNFj/43Jm+cvsCq8xhtJR3z/Wa4bomkV8oMGmXN5iQbWo4q79FQ/fj/u1XRow
 rDac9ACLI71q2At7j7g2RF0liUinKUPPEX6tCCA/DulMrNwVbW3rbzCMMu8U/NH33Nvv
 itfg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCk5nbEF6rsOxUwY1YcDuRWtrgeBKZIbuXxK8XG3gUPHbX/hfbNSyte54BEjrYTx+VMCRqlfnPMLpa@nongnu.org
X-Gm-Message-State: AOJu0YxFJQiG+Hvm463RvOrPLaTO4rspN9ixq7Tw1OZEJPmNhr8TOEXY
 FQIKLTZiRZJ7uabo9MmX4Ic2cIPi5llLcPGJcUs/yj/a0D0zwd1f3MihR/qoqbM=
X-Gm-Gg: ASbGncvYq+CtE90I261P+TjGjrCgKH3o5f82hLhZOC2Q1mYDizGEn0h/jWmNv/vdS+o
 e7J0OdyHGTdBHm6RxQt7Cp4K7hmvCtNhlxvW3Hz4jG6aeDuF+F15ObFYGCBB3OvRQK95pZUtbsT
 +ThKp/4h12rsnk1sYr7pSHYj39s5/UpzwkNFC/yWzZ5Px1CEYYPaSxRlOjvf6ZCGuB2N/piR0zj
 AOe6EbZxpZfI2ZrwxEJdK7CiB9gBgNKPj+TFtK6xz6V7mrkqMxUhbkZUEiVbeOATKevSyXD069/
 RK7YJmM3wPN2gzQEuRDSrw==
X-Google-Smtp-Source: AGHT+IE75Z0FU0hmELvheVpdYBaxO0WbX33BxXXkv/RNOeHUWdekXwHKNipWB0oIcS+/cBwyzJJcUw==
X-Received: by 2002:a05:6a21:66c4:b0:1e0:dd8a:befc with SMTP id
 adf61e73a8af0-1e1870c4493mr6149558637.20.1733511757160; 
 Fri, 06 Dec 2024 11:02:37 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7fd156e14afsm2954050a12.30.2024.12.06.11.02.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Dec 2024 11:02:36 -0800 (PST)
Message-ID: <867d8a3a-ddf4-4655-9bfc-51c1a2ad8203@linaro.org>
Date: Fri, 6 Dec 2024 11:02:36 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 11/11] tests: add plugin asserting correctness of
 discon event's to_pc
Content-Language: en-US
To: Julian Ganz <neither@nut.email>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour <ma.mandourr@gmail.com>
References: <cover.1733063076.git.neither@nut.email>
 <36d316bf3e8b0aca778c5e8d1acde39a7f361946.1733063076.git.neither@nut.email>
 <d4b17c7d-c1d2-4e43-8eee-d1667e3ee5a2@linaro.org>
 <0e4171ca0baa8727c0bbec7a25fd72d8b8e1e4b8@nut.email>
 <997e809f-832c-4bbd-b27e-a722ac835b34@linaro.org>
 <450f3beedf979437fa3de8bfab1ee72f66c67ada@nut.email>
 <cda016be-c82e-4b54-a506-22afe6ec2eb2@linaro.org>
 <c850ee89e15d2775e7c0137a218286e7060874dd@nut.email>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <c850ee89e15d2775e7c0137a218286e7060874dd@nut.email>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52d.google.com
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

On 12/6/24 00:42, Julian Ganz wrote:
> Hi Pierrick,
> 
> December 5, 2024 at 11:28 PM, "Pierrick Bouvier" wrote:
>> On 12/5/24 13:22, Julian Ganz wrote:
>>>   December 5, 2024 at 6:30 PM, "Pierrick Bouvier" wrote:
>>>> We can store the next_expected pc for each instruction (from current_instruction + insn_length), and we should be able to compare that with the expected from_pc.
>>>>   This is mostly what contrib/plugins/cflow.c does.
>>>>
>>>>   With that, we can test from_pc.
>>>>
>>>   I'm not confident that this will work reliably for branch, jump and
>>>   other "interesting" instructions. But I can have a closer look at the
>>>   cflow plugin and try to figure out how that plugin handles those cases.
>>>
>> It won't work for latest instructions in a tb (because we don't know what will be the next one), but should be good for all the others cases.
> 
> IIUC qemu will schedule interrupts "opportunistically" between tb
> executions. If that's the case we'll observe interrupts exclusively
> after the last instruction in a tb. That strikes me as a serious
> limitation.
>

To reuse fancy vocabulary, maybe we should have a distinction between 
inferable interruptions (interrupt instruction) and uninferable 
interrupts, triggered by an external event.

In the latter, it *might* be acceptable to not provide a from_pc (let's 
say a value 0), because there is no useful information in itself, except 
creating random edges in the control flow graph, which we don't want to do.

What do you think of it?

> Regards,
> Julian Ganz


