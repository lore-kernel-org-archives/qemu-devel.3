Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B256CD37BE
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 17:49:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMUkQ-0001H3-Ha; Mon, 11 May 2026 13:48:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMUkG-00018U-OM
 for qemu-devel@nongnu.org; Mon, 11 May 2026 13:48:45 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMUkF-0000AX-94
 for qemu-devel@nongnu.org; Mon, 11 May 2026 13:48:44 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-453903ee4adso4002203f8f.3
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 10:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778521721; x=1779126521; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DV49/5ZVeWtAV1woDG9GF0F8fvY+EVfMnnzSeASK6v0=;
 b=YgyOixF7D93qzH1tpYhG8c+JFlejUK6MShQLaa8UOSJ8ZsfaMPSL+/OQ93WthHsuYp
 nyRVcUPjnjj434J1//Ssa/fsZDoHApXL4iE0eH6mgWrRiHA0pru3fswqoVEaoVaDlogr
 Ptj6nxZ3t9HNCBiRrmkZNeGPfAqmEEhAtj5Jr9I5rpgvuDnx+usTy7JmpRjm17L3FfEY
 xm9aRpE0uCsuj+duBFJAspKBg5Vikt616hqiLVWB0n/esnxCuCwb7tKWJauA0Ujy3FVX
 Lu/+ZV1Z3Z7Ex1szIlwCTja5mwzO4gvhcwKbUsU9ipc9SU9Bu/k59yHf8oPDCR5sEVTw
 9S5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778521721; x=1779126521;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DV49/5ZVeWtAV1woDG9GF0F8fvY+EVfMnnzSeASK6v0=;
 b=OdUJupeNfp0cXDhGXaP6PjLf1jKjEC5xE7BkTSt77iR/aW6JjFEsrbMUoGXySAsE8o
 nJ9Ag8HzOt3ppCG8i5BIMUZ2vgNupV7te9YETEmaH71yt0tTCaIOVpxjZM53JQ0SfsQT
 ovVgoujtHXx6RqL71wyfVMoEBD/i3V6voDtLXRg3I4w1EfCOJDFzJNm7pOOiVCz/E1QV
 8ODfeq9whaEu7TeDOjcN9K0r4Tnxyu4vNcNL4QJniNKGn19lEbufbZMnlAA+cm3LSLO4
 MFLIXxEiUfNafPIyE3LusCIo6k6yr9u/11V2mYPvo7LV4NtgiHuThWuSuoN8qPWoQjH3
 0fHw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+xSy2x5fe8jciyr5Rgha5GBl5pBgR6/0dWna2whfcgWDWFjEei0cV21vTHyVO4UH8+K3kgDeosnu6S@nongnu.org
X-Gm-Message-State: AOJu0Yyt6bZ21qD5y4LNJPn2xsaHXINSG5J7Xa5992dJtz8T1GJhCGOz
 1w/bK3MF82q3F//XYzUtari5qJugeODMGbigjADAr4Zldx4hiab6vcb+9uR1TstY2T0=
X-Gm-Gg: Acq92OGdCrmgRCTZu9qeL32jD5n9UOTC1DA09vl8Exi5kJbgLyzPNsKbtmGxRVOS4Et
 z8GkVH7Ao2nFpe5NZ46ev5XLXPllqlVc0OXqyXKOXDKqTBet/LQZaTr+Xs3GeHuMpaM75bOqNBm
 t4upOHrCg+aJaJnP+s5hhyjUVi2BKQjQj15ERMhfMAZoYNY/kOdkx1GzgK4Esb9kt9evYCGoPkm
 TDtXdz+frSJHnHNTqni4UUFJGO8BjniiEg0ekqwAP224p4DYYL6JXiGcgSvyBx45eSYbfQanPZ+
 wYm5knr5eUgGPg7bGMTaYGRJ8qzEPZaRFWTkOGnd6doMFFi9/0dl5TBkXkLKQZfwjjSK6wqjThZ
 a9uQzYd2dELpEwSJh092C2v2H0LRhLLRElRcoXUJOEY6I08KDtp6qg3/JG8ctv2Pl+oNMSv9Tpr
 cJAZQ2xfwissc7qBoZbvWopECzWfipl4kc+C8HvMWfD3zncU1t4vyGQ/oU9ZY0MI6ig1MIM/28K
 Qb5
X-Received: by 2002:a05:6000:4024:b0:43b:5b25:67f8 with SMTP id
 ffacd0b85a97d-4569fe472dcmr16040748f8f.20.1778521721316; 
 Mon, 11 May 2026 10:48:41 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4549120eb95sm26123824f8f.20.2026.05.11.10.48.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 May 2026 10:48:40 -0700 (PDT)
Message-ID: <a57d5120-dabf-4953-a680-a9c875ecf238@linaro.org>
Date: Mon, 11 May 2026 19:48:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 089/110] target/s390x: Introduce common system/user meson
 source set
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>
References: <20260506135524.20617-1-philmd@linaro.org>
 <20260506135524.20617-90-philmd@linaro.org>
 <5b1fd1f6-00ec-4575-9609-845218405403@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <5b1fd1f6-00ec-4575-9609-845218405403@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

On 11/5/26 17:48, Cédric Le Goater wrote:
> Hello,
> 
> On 5/6/26 15:55, Philippe Mathieu-Daudé wrote:
>> Introduce a source set common to system / user. Start it
>> with the files built in both sets: 'cpu_models_user.c'
>> and 'gdbstub.c' No logical change intended.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
>> Message-Id: <20260423135035.50126-4-philmd@linaro.org>
> 
> This change introduced a regression with PCI passthrough which
> stopped working. Guest kernel reports :
> 
>    [    0.156501] zpci: PCI is not supported because CPU facilities 69 
> or 71 are not available
> 
> and other devices (ap, ccw) are impacted too I think.

Is it something we could test with the mainstream CI, or does this
requires specific hardware?

> 
>> ---
>>   target/s390x/meson.build | 25 +++++++++++++------------
>>   1 file changed, 13 insertions(+), 12 deletions(-)


