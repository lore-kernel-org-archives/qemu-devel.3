Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D3C6E9A053
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 17:35:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt7ve-00031u-PK; Thu, 19 Feb 2026 12:35:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vt7vc-0002zW-J2
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 12:35:04 -0500
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vt7vb-000525-0o
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 12:35:04 -0500
Received: by mail-pf1-x443.google.com with SMTP id
 d2e1a72fcca58-824a829f9bbso642694b3a.0
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 09:35:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771522501; x=1772127301; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HXNgy//UJeYgNhZHOPgQs63udPSt7ejfDdxGmeQIDiQ=;
 b=wQ/ZzfiXClZRcTC+EP9eXmteobdq4zijWkTdr/TVbHJfssU6DAsDOt0uKShT6zniOj
 X5fi3CDIp/roAgvXE2UmTzSHHc5FK6T+g2zqLDm1eSW3P8ThXsCq5hpRfSQF1shXa2na
 bcMNrWk8CYTdZw+G9/CALW1M6fEL0+FGBtCWqGTRF/JLoBcvX4JxRlxTL1OHOHz6O2YE
 wGgTeS3+tUjq0e2GBRJh/U6+IrkdecajBOY5lEpjW1RekqRYREceRVMYXFl7NVWIYQYJ
 6mHfTZ3c2W/+cj+ZT1hnE1kcsoLNzI9eFweZg2DZsSmZdG562t9QOuRXiq7tVRU9AcOA
 eNAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771522501; x=1772127301;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HXNgy//UJeYgNhZHOPgQs63udPSt7ejfDdxGmeQIDiQ=;
 b=DhMbntt1IlXErDX7pMTDmAvwSTXJoHQJhW0MFd5MWCVW56XCrsEYKj1q3+dVZ5memf
 +musThRmQgElfSprs6L1LiaHZ+gaZjv4dHYTn3abL2z5JVXHO16HbX0q+ajbwqpG/Ehb
 wqeZHWO18u3fRufXYOftJKg2e25/nwYPB+zcpSwcmXHgmA7zk9q3Cvh8mdCV6EGaxMrb
 XnqLR5diXFl4QiQkEGefOiGGuC9eOX7sXPNr9/oMpWnO3r+fNWzcPd1XT5oY8Cyllose
 1p/Dho0B41T+wLVHLfWgcSuTK/WZ8bfGLcrqUIenlgXAfsVs2umef+h4CHtgpYvrS3qa
 TX/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJJLRKZ0KuWjx0Ok6C3v2VI2th04UEfSKUw3vgf0yVx1XmPd7I44+HtbgKX3ENe+WvPo26WNIG/8Xh@nongnu.org
X-Gm-Message-State: AOJu0Yy+dzW0uOLEP7ZolLcENKFXjQMBklCGkCIViHIBcxLrFUdqiSZW
 5tkqh4guRjK/KCHnmGGbHBtHwDjZuK7z4GdtpIbUmLl6TLGltHvZo6EoIz2QCv+fysk=
X-Gm-Gg: AZuq6aL5rrY3O+4ftRp2nJTAXgjcIe6/uFMCuiVONkc6+QeZunpJ6SajLPBJcKRMHIO
 g7U5MDHOZvZAf+vAF/iFo9ak0hfDqk1dqzdf3L6li+KmaHEHg0SloYMLdfDL7CVN3BnSpdTGyPo
 QNx4gMssoeGeqGwNz9cGu1Iwmjm8XS76HB3grPv5K6toKk1PSCUPShn3wqAWKNkq0h5WExwq05f
 6sHaGYvKe4eRSmDGvqFH6aGllWZl+MRKn0ENix1x8XkUztn15U8ggtC+VlpqMgblwqy7WofQOEn
 +cHSZCjPJ3f/UEr2uPPaBAc03FdIFKbXH6PsAUSJ5WU6wVl+LXQyhZXyAJsxHnn/6vYmnlPqcxz
 qmlwyni/p21ZKHoXypeEE9nLtTOO1TO8VhCbWSgbaB4KR3+DMjaTJpOkQOQDxYdAlZykrB/5EjQ
 9U439jjvGz7osSl+96AybQfLIAn1J0jqilzrZAa0SgNzeGBxVsZP+fH4AzOsEtuEPK7XYf
X-Received: by 2002:a05:6a00:4b50:b0:81f:c6d1:d167 with SMTP id
 d2e1a72fcca58-826b68faf05mr2815196b3a.61.1771522501050; 
 Thu, 19 Feb 2026 09:35:01 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-824c6a546edsm20514774b3a.25.2026.02.19.09.34.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Feb 2026 09:35:00 -0800 (PST)
Message-ID: <1dce14d4-9b63-431b-800d-1f05b23f6bc4@linaro.org>
Date: Thu, 19 Feb 2026 09:34:58 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 13/14] target/alpha: move cpu reset into a proper
 reset function
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Yoshinori Sato <yoshinori.sato@nifty.com>, qemu-arm@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>, Thomas Huth <huth@tuxfamily.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jim MacArthur <jim.macarthur@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 Bastian Koppelmann <kbastian@rumtueddeln.de>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Yanan Wang <wangyanan55@huawei.com>
References: <20260219171810.602667-1-alex.bennee@linaro.org>
 <20260219171810.602667-14-alex.bennee@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260219171810.602667-14-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x443.google.com
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

On 2/19/26 9:18 AM, Alex Bennée wrote:
> Now the alpha clipper machine will execute a proper reset we can use
> the reset mechanisms to reset the CPU.
> 

(for fun),
https://www.reddit.com/r/memes/comments/1q97e3d/heard_you_like_the_meme_reset/

:)
Pierrick

