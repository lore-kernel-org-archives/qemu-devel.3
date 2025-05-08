Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 005ADC3ABBE
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 10:22:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCyNh-0007GD-NK; Thu, 08 May 2025 06:21:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCyNg-0007G4-5C
 for qemu-devel@nongnu.org; Thu, 08 May 2025 06:21:32 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCyNe-0004Z6-AH
 for qemu-devel@nongnu.org; Thu, 08 May 2025 06:21:31 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-af6a315b491so646155a12.1
 for <qemu-devel@nongnu.org>; Thu, 08 May 2025 03:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746699688; x=1747304488; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=E4gbiILORQ5SKAOiOpRy1Lu2hmzlunjIj77BVpolAGc=;
 b=Hx87CkKDBkWwUpvIPGcCxzx+WBiJneMtVb+QFy2Bs7WQ9m8AvIeTTC4D23AlCgiBP7
 XkH8Qf7LXJLWAsIBirGpFdqUXbFx/X0mgioDIvvj14qGrZXrOhoGeoA60r6Mgw8DTtm0
 0UNUgMwVml4Bl/tea5Pk0s+HTDImOXTxhy1KPtZ+pawCst3oeLF2q3dBzz9PYO6pjzB1
 0zbf2RHVWbhyWIaaJ9SBx9d3FDwVeXwbRQssjIKjfbBdeeSCjpdrtFt5A5+T98TIKDAy
 TVtypYKdB5jCtwpzHE955bw5KIq9ByUCQWB6DswQTGGvPnJR4ZwYRNLy8dZN538BSia/
 BCnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746699688; x=1747304488;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=E4gbiILORQ5SKAOiOpRy1Lu2hmzlunjIj77BVpolAGc=;
 b=ubc1BR9uiuxixQySzqUI9lm6GbVDyssRlG6yu6094Fs/zOyCZ3ebXG9Q4BNJY6xSQf
 rF2lyHPmQoHY5JIpYLFK4cJdZbO4ocGPsV7rY3ZAyoG8syIjh0/UDvfy/Eeb6VVm/xmo
 zUHPxiS9mWfhynXtWAQib/1jclHXAjCVNkEooWUawi2zd/qqsfq4+qAWPv/Zm3Wu+uyP
 WK7HKxFaBgfEMIJMeW6RHJc5EWx8xDlTog/raUCXLHUmOJEAiktIZpQX7Fim92i/ylsa
 ql7PeAeSIT5u/yX4Ppo9veWwms4DxwfD4k8Jl3ATcf8m2j12wqAXBFRwtkk6/C779iE6
 XtNg==
X-Gm-Message-State: AOJu0Yxlx1Zsc79pASIK+cc9n0q0jqtIjTm8gGvAZZxdRvxeNc0uByU2
 b7gy7wHKXJSljHYO+qHoAMwIa0VaiKn5N0WtO/j7ouBa5N6YprFlWaaTpR1P/d4=
X-Gm-Gg: ASbGncvoSfMHpyK8EkjUFqiPU8Zp7p9ZNCienTEAlbyBhq4c50yu3tRpZfkghduMKnv
 wUYOL6mkWr92vDlWp6+bI7o4c8Yy5Tvi6GtumvQckc7ZvssuupbNv9nw9Ng97eu5l7GJiEFZsNe
 G/eCB003fFefzqanVhOaPfozBHdsnp9rcryI08v2AMs7cNpHqnQGmiY8PXFw2YGiqDjzX6H/Keu
 DL683fGcEg3hfrGeoq9TLHJTYqnkBZwdVVVeul5LizvOciatwY53zGW+7v5oguVg8Dftwh8JRZ7
 S0HbCZPbGNBctY3jUzMiMQBVDBmASeG81TPIMh9+MiKG80d6yUa2ECcNJ0Hjq4WPu2oOEtHU0HM
 kEdgxO1jd
X-Google-Smtp-Source: AGHT+IEnwO+e/aWjRp6opISVgYsy/hA9DeK9AqdySEm1FmKtOL58eVWwNsNncyoiRpviFFGjtjiadw==
X-Received: by 2002:a17:903:19c6:b0:223:f639:69df with SMTP id
 d9443c01a7336-22e5edfd586mr97846555ad.41.1746699688535; 
 Thu, 08 May 2025 03:21:28 -0700 (PDT)
Received: from [192.168.69.244] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e152291e3sm108525195ad.202.2025.05.08.03.21.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 May 2025 03:21:28 -0700 (PDT)
Message-ID: <3b92958c-c99f-4c9c-96b6-c5fbaaec06fc@linaro.org>
Date: Thu, 8 May 2025 12:21:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] include/hw/boards: cope with dev/rc versions in
 deprecation checks
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Yanan Wang <wangyanan55@huawei.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, devel@lists.libvirt.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Zhao Liu
 <zhao1.liu@intel.com>, Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>, John Snow <jsnow@redhat.com>
References: <20250506160024.2380244-1-berrange@redhat.com>
 <20250506160024.2380244-3-berrange@redhat.com>
 <09b0a1cf-afac-4308-89a2-cc22aba5699d@redhat.com>
 <aBxxHob9MK0BYHLw@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <aBxxHob9MK0BYHLw@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=philmd@linaro.org; helo=mail-pg1-x52c.google.com
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

On 8/5/25 10:53, Daniel P. Berrangé wrote:
> On Thu, May 08, 2025 at 09:45:50AM +0200, Thomas Huth wrote:
>> On 06/05/2025 18.00, Daniel P. Berrangé wrote:
>>> When VERSION is set to a development snapshot (micro >= 50), or a release
>>> candidate (micro >= 90) we have an off-by-1 in determining deprecation
>>> and deletion thresholds for versioned machine types. In such cases we need
>>> to use the next major/minor version in threshold checks.
>>>
>>> This adapts the deprecation macros to do "next version" prediction when
>>> seeing a dev/rc version number.
>>>
>>> This ensures users of release candidates get an accurate view of machines
>>> that will be deprecated/deleted in the final release.
>>>
>>> This requires hardcoding our current release policy of 3 releases per
>>> year, with a major bump at the start of each year, and that dev/rc
>>> versions have micro >= 50.
>>>
>>> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
>>> ---
>>>    include/hw/boards.h | 33 ++++++++++++++++++++++++++++++++-
>>>    1 file changed, 32 insertions(+), 1 deletion(-)
>>
>> FYI, this causes a failure in the CI now:
>>
>>   https://gitlab.com/thuth/qemu/-/jobs/9965651507#L163

Ah, just noticed the same error msg:

   qemu-system-x86_64: unsupported machine type: "pc-q35-4.1"

>>
>> Looks like we have to remove the related subtest now?

Hmmm shouldn't we merge this series on top of up-to-4.1 machines
removal?

