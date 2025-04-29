Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39FD9C369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 20:12:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9rJ9-0006mB-Ry; Tue, 29 Apr 2025 16:12:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u9rJ4-0006iT-Nb
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 16:11:55 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u9rIz-0000mV-TF
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 16:11:51 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2ff6cf448b8so8426867a91.3
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 13:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745957507; x=1746562307; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=sXjQ1GwSAPjEhoESh+xA0/zVcxdIHeGgOhsOgA9BWCU=;
 b=k28LbMJd4/02b7PAGRON5iSqlRCsxKjE3Z9plrWyOEkl6mHE/61k03N1t0IJ5Du4vX
 tPJbhNiD7kwzCfnzmJ9Wuh7TlYvmTnKRvTl0denBhztYujH5u4oiu1ouUY1sO817tupZ
 wYa4cshY1G6rreACqZlRZGGA0duTB4R6hcS8qTk/1rNiAQLixm0el7TziPJG5Z99Qcha
 yls+t4xvOBbLM7DFaINfHoz71S0ZIjmV5fpojL3YSX9nrhfJtmRJLAczKWQYvS9dmIyg
 a99KGw5w/yfMOt4VSkcJucdlhN6MMcGxYesWIx0CJNxuRhOS3OtWjokJmCvk1a/k9Bx2
 cm+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745957507; x=1746562307;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sXjQ1GwSAPjEhoESh+xA0/zVcxdIHeGgOhsOgA9BWCU=;
 b=LtAK9rpCyPtnklgon/LSa6WMBU4ftul2kaBO7FEU1Mlsl+kJbm+cUPLUIRz+jI4NOr
 lCcbBun+X7Wj16yNkqezcofES9fDWhSbwo6o4ogwSthIL2iNJlzizVNcdd60m5BWekuM
 Ic2ptzs+r9iVc7hV9iXrjIX3ojh290qVk9GwrgkEeLUYlWVxhNTzRVTpENcvWFMZNzFY
 a2BSH66VrS6VSBLqeDNwrLzlwjpqz8RXXAoT/5wM+rluJq0pwsolRkOI02L+tOAOnaNR
 1vhd9wmRZyeOIduMGF4Fs8x2IT6hOoUTTlRasbnkWT+tpOPZW8z4t4mnwM/MPTpbmp/B
 RGGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYqUNwqfUKJZnd7NY3oPL993Ur67duAUSkT+PSPvsR9P1HUhAc0gmtnplsOw39mqbkcGxKJXWaH3g2@nongnu.org
X-Gm-Message-State: AOJu0Yz/JLCwdVCuxMUkAZev07L/5T1kcWbokllEC1fG6aP6DLQLy8ZB
 ANTXUrI7BnsP/9Mpx67ZlSv4y52UN+lFAlzMrIEmVvK3T65lv/rfKIjer7R0DtA=
X-Gm-Gg: ASbGncss0CP77CxIwi73h9EFFXH4zHWkkanRz2icI6hzle+xZD7CCtnqxNdU/3P+0Gh
 Qvlc6h+uU/HB82OHQi+Mh4WhKY4l1kSXIhCyXY4MGBMfof5AEvmo7q82AgBBFhw1igPAuIvUjfh
 lPm/ibH+O7KyP6HrMUPKvtuAEn/k/zGaYaKt8LXfhnHRcQyCQgox1RS6nz6S+HveXvh7GqwXRX6
 jv9TFU1OehSBzmr5/UkPwldzuB6d76IDFcysReLKwWr1XplquuxAN2fHWbY6o/aGEQ+0FE7CeIB
 0IP6BoD24KkeMVrjV6NYOZGk96a1XW2EftD0+4jBBBVfhyg5EamLTg==
X-Google-Smtp-Source: AGHT+IEERfCWnRx9vJ6QYIl/mPnjihSsEpXkD2ME0J641tQxemqLtjnV9EsGF5XCC+Z8SrXO7u/L6Q==
X-Received: by 2002:a17:90b:1d48:b0:30a:204e:3271 with SMTP id
 98e67ed59e1d1-30a33300d8emr657806a91.17.1745957507302; 
 Tue, 29 Apr 2025 13:11:47 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-309f784ab1bsm9879875a91.42.2025.04.29.13.11.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Apr 2025 13:11:46 -0700 (PDT)
Message-ID: <d33ca7c1-221d-4d0e-85bb-d84c3acba629@linaro.org>
Date: Tue, 29 Apr 2025 13:11:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/3] single-binary: make QAPI generated files common
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Cc: Peter Krempa <pkrempa@redhat.com>, qemu-devel@nongnu.org,
 richard.henderson@linaro.org, stefanha@redhat.com,
 Michael Roth <michael.roth@amd.com>, pbonzini@redhat.com,
 peter.maydell@linaro.org, thuth@redhat.com, jsnow@redhat.com,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 devel@lists.libvirt.org
References: <20250424183350.1798746-1-pierrick.bouvier@linaro.org>
 <87a584b69n.fsf@pond.sub.org> <aA9ChuXrkmx1Igy5@angien.pipo.sk>
 <8734dswnm3.fsf@pond.sub.org>
 <2cc27344-8cfd-4435-9d41-79b86f61d537@linaro.org>
 <875xinnzok.fsf@pond.sub.org>
 <ae321f41-9405-4a6a-915e-969303c08d9b@linaro.org>
 <41c2ee8e-d077-46c9-8106-e979e7cb80bc@linaro.org>
Content-Language: en-US
In-Reply-To: <41c2ee8e-d077-46c9-8106-e979e7cb80bc@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102f.google.com
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

On 4/29/25 12:57 PM, Pierrick Bouvier wrote:
> On 4/29/25 2:35 AM, Philippe Mathieu-Daudé wrote:
>> If a distro wants to name a binary 'qemu-kvm' it can drop the
>> -target option and hard-wire its target_info() to a distro-specific
>> TargetInfo implementation, or &target_info_x86_64_system.
>>
> 
> Having updated my Debian stable to next stable (trixie) last week, I
> noticed that qemu-kvm was removed [1].
> 
> I don't know why, when or how, but it's just an example that things can
> change, and people can survive to it.
> 
> [1] https://packages.debian.org/search?keywords=qemu-kvm
> 
> For the concerned other distros, if at least one packager asks us to
> provide a "./configure --default-target", it will be an excellent reason
> and opportunity to do it.
> 
> But before that, let's first build this single binary, let's see if it's
> useful, let's see how to use it, and eventually, let's see how to
> package this and cover corner cases.

Well, thinking about it twice, it's pretty easy to cover: qemu-kvm means 
select the target that match host and add -accel kvm to argv.

