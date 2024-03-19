Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 148BDC54E7C
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 14:37:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmaZz-0006gl-6L; Tue, 19 Mar 2024 10:36:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rmaZx-0006gP-P0
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 10:36:37 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rmaZv-0000my-9D
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 10:36:37 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-33eee0258abso1498473f8f.3
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 07:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710858993; x=1711463793; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0efgDKKkLGerMPweoEieQnx14k1OlzDjgpUUyMAKWC0=;
 b=DVLQmZkuHPlaV2TxzpmFUc351BLeWj8UR8cBjKGOCZynUwx/dxIj7ioG5ZKGMtUvlq
 4fAPvjqLPstDM6NduufIq6LVTdYNUq2tPUgKeUyE2dlPO9z3U8+W1yqqMiIaxLvK4Oao
 EVTdKvvT7hrS3pySIQmI1Z8gFOU0+ypwREVe3G9hdRUO/eViMHHUY++6NjCh1/r348b5
 9v4hySK3Xayo61nUtf0fTTPJW8TuQlJFmMmQxnMv67tJ2C1Rk19MmcjtOKjjpOkE0zp2
 QcBpVMWz0iFWago4JLPA7ksnTAn03Z4OvmjIKDQw8/ah00eBFAeuws2CdxhFGWkuijrF
 iqRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710858993; x=1711463793;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0efgDKKkLGerMPweoEieQnx14k1OlzDjgpUUyMAKWC0=;
 b=XOYbgNtND47LyiXJsXXZlozxCTBD8ukF6/JGPSKtMuiZtHAjkP4LaLe59qo4gOydxN
 2162IUWX+aJ2OcvXTpp5OdXdr0CDmXDSMIkfgYL12udEklSmZsgZi0IYKJjuXWAwW6a7
 tSkKLvWek75fUe/Ttcb454mVHAszeo6wrpBJlyulkH+GPQ1yRwGKvJc0MzLVtUH5C8JK
 w8uxYB0yOb/fiG0WdKu4CjwslWgNnbNxcC+hdBNOgUk8O3yyMcnP6iR8td35fL9J4J5r
 DTx8GKG5Gz+EQZ7lTGmIUdJNvxEFu/9BcIhVNe9fbJyebj4qTkc9+7Wn2WUoe/uG3P+d
 uFtQ==
X-Gm-Message-State: AOJu0Yzq6SGcWoEUP/SPu+tYdHabHCLXZ8uT3YKvDyX85rReL4YR+oeA
 EbdIn+MLX0Fvac6m6KTJjpdXKeCzYzATjNlQ2sHWEalq4r2AWj4dRVAwh5iY744=
X-Google-Smtp-Source: AGHT+IFQ2AO8+WjjsFwxyYigYtouP0IjZjLRKMSlkApWghbKMjzW1pMLApEgEzmayBJZW2WbZi62lA==
X-Received: by 2002:a5d:46c2:0:b0:341:7656:d358 with SMTP id
 g2-20020a5d46c2000000b003417656d358mr3423310wrs.38.1710858993357; 
 Tue, 19 Mar 2024 07:36:33 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.166.129])
 by smtp.gmail.com with ESMTPSA id
 bt14-20020a056000080e00b003417893ef1asm4051601wrb.14.2024.03.19.07.36.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Mar 2024 07:36:32 -0700 (PDT)
Message-ID: <adb7c11b-cf09-471f-9ddb-43bd32b47895@linaro.org>
Date: Tue, 19 Mar 2024 15:36:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v2 0/4] machine development tool
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>,
 Maksim Davydov <davydov-max@yandex-team.ru>
Cc: qemu-devel@nongnu.org, vsementsov@yandex-team.ru, jsnow@redhat.com,
 armbru@redhat.com, peterx@redhat.com, farosas@suse.de, pbonzini@redhat.com,
 berrange@redhat.com, eduardo@habkost.net
References: <20240318213550.155573-1-davydov-max@yandex-team.ru>
 <CAFEAcA9Kcowzuy84SeBqi9zQv6e9Ojo57Wknw2BON2NKms=JcA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA9Kcowzuy84SeBqi9zQv6e9Ojo57Wknw2BON2NKms=JcA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

Hi Maksim,

On 19/3/24 11:24, Peter Maydell wrote:
> On Mon, 18 Mar 2024 at 21:36, Maksim Davydov <davydov-max@yandex-team.ru> wrote:
>>
>> The following changes since commit ba49d760eb04630e7b15f423ebecf6c871b8f77b:
>>
>>    Merge tag 'pull-maintainer-final-130324-1' of https://gitlab.com/stsquad/qemu into staging (2024-03-13 15:12:14 +0000)
>>
>> are available in the Git repository at:
>>
>>    https://gitlab.com/davydov-max/qemu.git tags/pull-compare-mt-2024-03-19
>>
>> for you to fetch changes up to e12b89f71ba5b93877b6a3adc379a6369d0c9bab:
>>
>>    scripts: add script to compare compatibility properties (2024-03-19 00:13:54 +0300)
>>
>> ----------------------------------------------------------------
>> Please note. This is the first pull request from me.
>> My public GPG key is available here
>> https://keys.openpgp.org/vks/v1/by-fingerprint/CDB5BEEF8837142579F5CDFE8E927E10F72F78D4
>>
>> ----------------------------------------------------------------
>> scripts: add a new script for machine development
>>
> 
> I said I wanted this to go via some other sub-maintainer's tree.

I'm OK to take the first 3 machine-core patches, but the
tree is currently frozen to stabilize before the next release.
Since your patches add a new feature, I'll merge them once the
tree re-opens in ~1 month, see the announced schedule:
https://lore.kernel.org/qemu-devel/CAFEAcA_ncrw8nsD50Ov=Fse=gYFw3CabpURWM9yK3yWmL5CTQw@mail.gmail.com/

I haven't looked at the last patch yet, at a glance I'm not objecting
to it, but having an Ack-by tag by John (Python maintainer) would be nice.

Regards,

Phil.

