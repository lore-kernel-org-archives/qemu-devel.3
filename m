Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E79D3C87FCB
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 21:15:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uj2W6-0001sR-5q; Mon, 04 Aug 2025 17:14:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uj2W3-0001pt-OQ
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 17:14:44 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uj2Vz-0006Hr-Mw
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 17:14:42 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-76be8e4b59aso2273392b3a.1
 for <qemu-devel@nongnu.org>; Mon, 04 Aug 2025 14:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754342077; x=1754946877; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=em/f9GiRz6FXMCYyInMKAWnOPFcHcBZWG6JdyD/V21o=;
 b=auCbQG7h0tmYq4815fAYoc5u8Qt2bpTEYE/0kK4Ivo/U7mtpJDwCuR9PU8tlC82lsT
 wzjTW1pgZ+hwSkctgGunJN/uxmJCdULQblBxXjNRQjbTWgOeEvP1tOK4dPsfs9jGvFCt
 KJaZ4SF7zRO/b19dblis/nU8sGSD99mmypGlP18NnbbpBZ1XHRfHGe1cqcCNBRZfClgV
 Uxd6gFJlyNA6HWjPLoNglhD3jY63qORVn0FKtHYMzkRj8ez4rDQv7tuvb5IqucbS8STi
 uHP6GRw1IPkouzQZ6TDvZBhj3e5xrg2J9MwE0Rq0AzkGWbnZYY4Ghtk2+ZOlgH39SeDO
 R58w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754342077; x=1754946877;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=em/f9GiRz6FXMCYyInMKAWnOPFcHcBZWG6JdyD/V21o=;
 b=nl5c+Bt4VU+iUseIEE8dJCLdH/sq6aGHms0eqNbRqJTUO4I6QSd3SShZzntZk3DBJ7
 UPB7E0B4f3C38H6xLtX5WYvzCDzycF1m/mB6ZDmp85BPIGxacmQxcxUXVbk9iMY1Rfk8
 IfftpUE776Jy4jmimZ4H4cdbStQicdYfKBi7e1o7iaxkaPxXMRrHWN32nnUfNqiVHhNL
 Bdh5IjM0nEu39ObpEXhNNjQKRjz24Wq9CYrRMc+/glJfxDf7OsMLOgS9M31JCE81XLDe
 EXyiF3DOvdUF4/sJi37qIGOtjP+S+6nMZKgrHfleHmn4v93qsVll/JFcGamB6ktsL9vB
 cNnQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXVIA+HL64BVnooLEdiB2sdmT+9pHS1CV3kyJ7LnUQBIJkNl0DS9IrcXRJaU6pZEGqSlXkE7T/IPAOL@nongnu.org
X-Gm-Message-State: AOJu0YxGwoFpfvXUdcMdPgFvUAqAwYgTk1CFCvw3Lru9qI7AdBDgn/o5
 DIKSOpVNMUUKnpRWB2ptf3mTaEIp7qf7hUY9t8QxlfBbe9LS0CwqQGcbaIqn6i4KTLY=
X-Gm-Gg: ASbGncs3eKKF+tuzGpC926NFSgAfR8DERvTJ2Lun/n27ox6ozfzWIZjYDbnFfo007qz
 NvHkjYr+6FaekxnVX0MaIbcu/1z5JwnTvT37m/lioaH/RlwDUp9o6C7pskiZqK04rBvSPv0t5pj
 yOL9ueRpCaqIb7/6yJPnb4lIHBRq0WzaLF3MIMcWZFWE22QjDUw9yoGq5fs0SG6pwNVxNpSMwBy
 Hb3urqdI9r9V9si131rYc2wy5+rkibUe0woLWm/QSYf89pygSBE8Hjl7nycVLsYloai0f7b04Ir
 /k0zpSmLNYaYBP1gsXSTddpL1lyKxmcc79sdg/EGQHVackHk60GQlQijsJfszGvQr4M8cqpMv6v
 hLiBNTIBMM4wveQYDmeySyMcSewpJGtIn6XQ=
X-Google-Smtp-Source: AGHT+IGHp14xND9jYcBXwV21Zq85UUpy9GqUSFD56QzHi+TEaidqdDR1fCmFKwgz7mXouYIWmYVM1g==
X-Received: by 2002:a05:6a21:339a:b0:240:eb5:77c5 with SMTP id
 adf61e73a8af0-2400eb57d43mr6310996637.23.1754342077381; 
 Mon, 04 Aug 2025 14:14:37 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b422baedf5csm9732577a12.47.2025.08.04.14.14.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Aug 2025 14:14:36 -0700 (PDT)
Message-ID: <75b87357-75f3-4237-b38b-6fcb51013570@linaro.org>
Date: Mon, 4 Aug 2025 14:14:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/17] whpx: copy over memory management logic from hvf
Content-Language: en-US
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
Cc: Shannon Zhao <shannon.zhaosl@gmail.com>, Ani Sinha <anisinha@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Roman Bolshakov
 <rbolshakov@ddn.com>, Igor Mammedov <imammedo@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Mads Ynddal <mads@ynddal.dk>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>, Zhao Liu <zhao1.liu@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20250804142326.72947-1-mohamed@unpredictable.fr>
 <20250804142326.72947-11-mohamed@unpredictable.fr>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250804142326.72947-11-mohamed@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42e.google.com
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

On 8/4/25 7:23 AM, Mohamed Mediouni wrote:
> This allows edk2 to work, although u-boot is still not functional.
> 
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> ---
>   accel/whpx/whpx-common.c | 201 ++++++++++++++++++++++++++++-----------
>   1 file changed, 147 insertions(+), 54 deletions(-)

It's indeed duplicated from hvf.
I would be worth to factorize this, once we identify what is missing to 
boot u-boot. In the, it would be nice to have same implementations for 
hvf and whpx, with accelerator specific bits extracted. For now, we can 
live with the duplication I think.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

