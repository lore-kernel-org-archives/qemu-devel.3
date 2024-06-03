Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9401C25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 14:20:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE8Xr-0001wS-13; Mon, 03 Jun 2024 10:20:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sE8Xn-0001w0-Nt
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 10:20:15 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sE8Xh-0002V4-JF
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 10:20:14 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-57a1fe63947so3718294a12.1
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 07:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717424400; x=1718029200; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=fcPdkpRWp56Gkr8DQ3RfeedzRUWF4Qj2aToRrp6ZnS0=;
 b=YxPD6JFcYSsjwyRqzpYQraLXHfciKGendTAYXgbi4s2aRc+3sBR2hNLNO7QaN6fkKC
 YR4Ondcj/f2SttH+bhvucQ1tb+Lol42XmWHjxOoaeonxVnOHOhYaZrWxHbpQOf3zB4vu
 tug6Yfry+WRUtRR7JpVPfZJzl1OsEGc8Z1V15ye0WvoQLOs6aRkBjxmBtciRFlHh6lNZ
 qm3ljf4tWGB97gmG0lOCjwQ+ZE797SddI/gt9yrjNBr2twGt+DLGqxnhZg6B8B1cWNJy
 CC3h7uHWZ2CCdHECy1IF2mqOgukLGDWYwzhBf/Droptk98TpHMHGK9dmHBZmTCINRGfe
 50/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717424400; x=1718029200;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fcPdkpRWp56Gkr8DQ3RfeedzRUWF4Qj2aToRrp6ZnS0=;
 b=ECkArkIO/ncHC1eeD5p4Wztas9/nKzDZzQyN6xRvqGLRxBnAqtqGoxP1FELtgqMNUF
 sAXdtmQNh1BZKiqKjovr8zapmi3tsGaPdNiRLN/zqptiC9ygmSjFhAYxnKnlT38GJeGG
 OT660X1qASg6e7KBnXQEZK3r2QossGZy9Ay/ASu4ffO1zS2B/NErDKGskk2oxepbvYHm
 7fZuMR+aS6T4YG878TGoSREFbuIAgTmvygkJLZvNK7RdIpzvEYFHrbkdAsQ/F1q2h9NK
 6K5e1YgyPqCMpbdm3MIxm4FQIWiYHffkWH/LLxsUrVLtCmal3IPoMX+OEIEkNmodaTr4
 DZYA==
X-Gm-Message-State: AOJu0YwGuJapS2zcqg7TD/Z2eyiTIUwFrIGTe7kOMZYvjdtzAX05cyzJ
 6u2dSmwVeY2Zd1Piw9MRjGGjzMm61lQJk3BxlcBHoBbdYmv8ZxXehE45x4/LuA0=
X-Google-Smtp-Source: AGHT+IGtxUcz5Jn3s4N4L7hQt1Rb6KtzRJuNUUTb5gXSMDjmOSvQ4MZJrc68H8z6sbOUSEFfMNAzRg==
X-Received: by 2002:a17:907:7241:b0:a67:910d:1b4a with SMTP id
 a640c23a62f3a-a6821982261mr681149066b.62.1717424400410; 
 Mon, 03 Jun 2024 07:20:00 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a68fcb85d66sm219983266b.34.2024.06.03.07.19.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jun 2024 07:19:59 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 4732A5F860;
 Mon,  3 Jun 2024 15:19:59 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Cameron Esfahani <dirty@apple.com>,  Alexandre Iooss <erdnaxe@crans.org>,
 Yanan Wang <wangyanan55@huawei.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Eduardo Habkost <eduardo@habkost.net>,  Sunil
 Muthuswamy <sunilmut@microsoft.com>,  Richard Henderson
 <richard.henderson@linaro.org>,  Pierrick Bouvier
 <pierrick.bouvier@linaro.org>,  Mahmoud Mandour <ma.mandourr@gmail.com>,
 Reinoud Zandijk <reinoud@netbsd.org>,  kvm@vger.kernel.org,  Roman
 Bolshakov <rbolshakov@ddn.com>
Subject: Re: [PATCH 4/5] plugins: remove special casing for cpu->realized
In-Reply-To: <0a76250f-db5b-4c94-941a-cbec1f2e1db6@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Mon, 3 Jun 2024 13:31:07
 +0200")
References: <20240530194250.1801701-1-alex.bennee@linaro.org>
 <20240530194250.1801701-5-alex.bennee@linaro.org>
 <0a76250f-db5b-4c94-941a-cbec1f2e1db6@linaro.org>
Date: Mon, 03 Jun 2024 15:19:59 +0100
Message-ID: <87bk4iglbk.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52d.google.com
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> On 30/5/24 21:42, Alex Benn=C3=A9e wrote:
>> Now the condition variable is initialised early on we don't need to go
>> through hoops to avoid calling async_run_on_cpu.
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>   plugins/core.c | 6 +-----
>>   1 file changed, 1 insertion(+), 5 deletions(-)
>> diff --git a/plugins/core.c b/plugins/core.c
>> index 0726bc7f25..badede28cf 100644
>> --- a/plugins/core.c
>> +++ b/plugins/core.c
>> @@ -65,11 +65,7 @@ static void plugin_cpu_update__locked(gpointer k, gpo=
inter v, gpointer udata)
>>       CPUState *cpu =3D container_of(k, CPUState, cpu_index);
>>       run_on_cpu_data mask =3D RUN_ON_CPU_HOST_ULONG(*plugin.mask);
>>   -    if (DEVICE(cpu)->realized) {
>
> We could assert() this to protect future refactors.

No because the CPU can still not be realized but it will be able to
queue async work.

>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>
>> -        async_run_on_cpu(cpu, plugin_cpu_update__async, mask);
>> -    } else {
>> -        plugin_cpu_update__async(cpu, mask);
>> -    }
>> +    async_run_on_cpu(cpu, plugin_cpu_update__async, mask);
>>   }
>>     void plugin_unregister_cb__locked(struct qemu_plugin_ctx *ctx,

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

