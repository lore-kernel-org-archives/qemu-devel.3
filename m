Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43773E68155
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Feb 2026 09:43:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsHbc-0008Cl-7L; Tue, 17 Feb 2026 04:42:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vsHbX-0008CG-Hf
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 04:42:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vsHbV-0003QO-8I
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 04:42:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771321368;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tq83adxn1WHkeBbsb89kOrynytES++HknCz40BCZt2I=;
 b=N9Fq8QHz3/yyr4LxQK5Z1fqRE9gWiq4R2jcDiAYQqx0aNYSyTpSFV/MkWANcY99hC/Uvly
 WacT7Pfsls1eimuOG9F7RxyT99csbCZoKJcAZtzhiM3m14DDVgbYODr/gmJNQFueojLL6+
 wuwMhcKo1ZXT6XRNZP4J8RPUFTOiMYg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-275-fFkJuEHRMQ-f3zlirBQfKw-1; Tue, 17 Feb 2026 04:42:46 -0500
X-MC-Unique: fFkJuEHRMQ-f3zlirBQfKw-1
X-Mimecast-MFC-AGG-ID: fFkJuEHRMQ-f3zlirBQfKw_1771321365
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-43771113b3bso3113337f8f.0
 for <qemu-devel@nongnu.org>; Tue, 17 Feb 2026 01:42:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771321365; x=1771926165; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tq83adxn1WHkeBbsb89kOrynytES++HknCz40BCZt2I=;
 b=ZgnnksLZqQd+HPpyh7//D6htymnlMBKUM06owVY79Zr5zGbtH2JHxx25J55LauGdaH
 5nSEJhnwWQOB80VoQYF6g6vkM75UBuK1wRl0ZqUDlb91FfHZHM5fCyCD0gP9sJSrcT+0
 jKO8IET5fX1MalbiD8trD3RiIiK0FQPUXdK0pzrLTAVSXb1Ru1TMXj5ktRdcQ3JjgRDh
 QdP7otD1pYdWfavve9UIkCGQePEsAclNMPrsFdTUx4/lFtycncjvYAfiDr2EBJC/L6Um
 2JpeS5Gahr6wOKuqNazQZbNpHltJmecWkEVR0/fZ8JFvadiuMG9Y3W4c3fm65IKRmaCu
 CETg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771321365; x=1771926165;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tq83adxn1WHkeBbsb89kOrynytES++HknCz40BCZt2I=;
 b=YbCds0UwkEtmrJOT6o/Q7OTjYNGitRfjaDWdR8ZXEA8tnAw7DaXCnha3f+RcNbpnoL
 8iEMRL5zqd6vk8t/rP/TADJZrj9gA1kUebhsPo3uJ3ItXkJGfYrMqFMhj6ynHZiVEGh8
 zg7beYkRWawCu7pHajQWsWU7bJ3mTIob5nPWVG1B4MHB9RnaAVxev4ldRkrN6eF5OXQa
 1+98K2sKiqsGczLoqmnETIaeBl62QReGe6oaOgzvSkpNt1c3zgHv+MR7jxYVdCm49EuE
 hq7luHIqa9yog2NpGuB0pa499I4kpdwaAZ4TSwyYcUB+uaS6V9QA+wcp6qnHYVsLyroJ
 enkQ==
X-Gm-Message-State: AOJu0Ywkjd4BDHQy0GdXgr31v4DMu/zB8rAGHIQuiib9rf9An3tQ8370
 Lf1fYWzFgK50Ns6l5JcfNMDM6sebH+JQHU0pVEIZZrdayigG2OfNyBla0ew8KH3+ui/Ez5hFjfu
 /3+nJzbOlX3lu4D0ErZ5eDC4Jhb7BYXoSMRQnGkmll1tGHusKjdhMgQK4
X-Gm-Gg: AZuq6aI2S+LU6r7Xh2Tk58t8ZVTtbY1BCTOcou9aQoSs8FhIxDmQ/9PL/8/vwuCHbQn
 rj5HwuwCpyUfZCa5oIpBTKgWz6csrhMVPRR7TP5ZXksn9BbxLDWgGiHi8aclre/V6V6oxmGMcAR
 JLwnEhmL31K53Kz7pG0w8jvNjEh8MOQJ4wKJzEdzMkMghszLjy+kiXstSwFKDckW5eXrchFICPM
 AOJC8By5nY7DH90HpuQaIGVcIqV1p/lyYE2T9lrQqzrMRwyqmWQncWthV8M465RbqhGDBnUePCe
 ftZhrvGHz0hlbyl48YGoIsj0GeyJvXVaxER3V2y/2XE56jSkWPlX4UuyumQVbBB+k0gFHRb5yQM
 oCtifKNA74pNBp6bI3WpkN/9pUWT4wCts3VX+E0nM6iJDDPOXARmZKL64RuSX4AaESABvVh42Oa
 UEAx3sd8rMW0BPKtw8qdIS6GgWsFI=
X-Received: by 2002:a05:6000:26cd:b0:437:a49:137c with SMTP id
 ffacd0b85a97d-437978c09bemr23705277f8f.3.1771321365150; 
 Tue, 17 Feb 2026 01:42:45 -0800 (PST)
X-Received: by 2002:a05:6000:26cd:b0:437:a49:137c with SMTP id
 ffacd0b85a97d-437978c09bemr23705246f8f.3.1771321364683; 
 Tue, 17 Feb 2026 01:42:44 -0800 (PST)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-43796a6b563sm33012925f8f.12.2026.02.17.01.42.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Feb 2026 01:42:43 -0800 (PST)
Message-ID: <d09950dc-dd3e-45ca-b54a-cbdff9f71e0d@redhat.com>
Date: Tue, 17 Feb 2026 10:42:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] audio: add `audio` build option for meson and Kconfig
To: Peter Maydell <peter.maydell@linaro.org>,
 Sergei Heifetz <heifetz@yandex-team.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Thomas Huth <thuth@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>
References: <20260217052740.114117-1-heifetz@yandex-team.com>
 <20260217052740.114117-2-heifetz@yandex-team.com>
 <CAFEAcA9y-QEaiRZMrYadQWJ1KgnHxT8Fkqt1uS0PkbY0Sb-_3Q@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
In-Reply-To: <CAFEAcA9y-QEaiRZMrYadQWJ1KgnHxT8Fkqt1uS0PkbY0Sb-_3Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 2/17/26 10:31, Peter Maydell wrote:
> On Tue, 17 Feb 2026 at 05:29, Sergei Heifetz <heifetz@yandex-team.com> wrote:
>>
>> This patch adds the `audio` option to meson_options.txt. It is
>> propagated into Kconfig as AUDIO. It is enabled by default.
>> The corresponding `--disable-audio` and `--enable-audio` options
>> for `configure` are also added.
>>
>> For now, this option does nothing. In subsequent patches, it will
>> gradually disable audio in different places. The final goal is to stop
>> building sources from `audio/` and `hw/audio/` and other audio-related
>> files (except for some stubs). Note that this intent is different from
>> `-audio none`, which mutes audio but still compiles the audio subsystem.
> 
> Not building audio/ code makes sense, but do we really want to
> stop building hw/audio code ? That's the guest facing audio
> devices, and if for instance a machine type has an embedded
> sound device that would require us to stop compiling that
> machine. I think it would be very confusing for users if
> --disable-audio meant "we will silently not build half the
> Arm boards that have a pl041 in them".
> 
> Maybe it would be better if "--disable-audio" meant "don't build
> the audio backends, and everything behaves as if the user
> passed -audio none" ?

The problem is that "-audio none" uses a silent backend but still keeps 
all the audio/ code around.  If you prefer to keep the Arm boards 
around, the solution would be to disable the audio code in the 
individual pl041 devices with "#ifdef CONFIG_AUDIO", so that the 
"depends on AUDIO" for pl041 can be removed too.

I agree that this extra ifdef-ery is not great, and it's the only thing 
that makes me pause on this series.

Paolo


