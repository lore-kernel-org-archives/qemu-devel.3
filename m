Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B7E3C5AD49
	for <qemu-devel@archiver.kernel.org>; Sun, 25 May 2025 15:20:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJD9c-0005xA-GC; Sun, 25 May 2025 11:20:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uJD9Z-0005o3-50
 for qemu-devel@nongnu.org; Sun, 25 May 2025 11:20:45 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uJD9X-0007Es-74
 for qemu-devel@nongnu.org; Sun, 25 May 2025 11:20:44 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3a375d758a0so1297472f8f.0
 for <qemu-devel@nongnu.org>; Sun, 25 May 2025 08:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748186438; x=1748791238; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oNEB9gZX/6wELzfei30Cpb8j4aVTnTQZ1fn639Eezfs=;
 b=AJU1PlRR/BmUJ4eC74ewo0g22NZvPFsJC71CXXcQJ/C7xnmcLYkT4F1fpVnB37PG+H
 KTkXi1bLyeBfp+mFv1HFADNYWogNZIss+dCvvb2xkDwjOZ1NYC34X5YCWjRgCZqVEVgJ
 ZVa20NMzYiwlzRxPTqHnL1gvSk0xMwLpZNPLJ2ZPFi+eWTfUqmPfdUjTNXuDFDpFKHBw
 3qy8twZPybzU0HTmAHPVIkD5SbvU56iPD/N3OkdMQQpn1bGOS2AS91EPp98n0FjI0o5D
 X7R9BGhLS7baSQJEOa7hLOMbnkgZiJZvrAGtMswcqBcH/2ZBw0ycKunnnTasJ2H4UIIl
 kO9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748186438; x=1748791238;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oNEB9gZX/6wELzfei30Cpb8j4aVTnTQZ1fn639Eezfs=;
 b=PZXyGEDZ3QgW44uANSa43nm+y/5VjGKyxbH/gG3/xVflbWvWyHbs4UvXfp+DfCbmI8
 dffJUEYfiUER3iSUFtBQLfX7LdQnoQqlXbSmR1fF50vw+Pd57Qmx50tZlCVDZVn5DdZm
 05cQ9YnJ69MqtVS27JJT3WA3qGYB/mumIEAvKmTWm5SXbMAR1KYBWlXWitEyaSh1u80q
 J64eLFfs7NwIOBMnJDgy7cbHisDARGUfL75SQKKBXafaaqfdTZ5l/VYJLSh1+mx+4fOl
 cFVjqWuEm3nxbfUuH0ENZETASBPWx28Fg9yAvDpZBLe60Iaqj07pkj3vl0IJ/4a0Il8Z
 iqkw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6KSeMJJeLbAqS85HeTiZw/n2EHaq6xU8mRl+fSjR0qfOj2iOXY6WpTPV1+eT7tnAVChdzJyvFUjrx@nongnu.org
X-Gm-Message-State: AOJu0YzuGv1x0gRTlUY/vBkvmPQdG0xNHNMNDDKh6ITTKwYGpQ0WqntB
 1sxbkSJswANMWjqrE8408rMtUxm1+eTXqKe+jKuQo/MFGH4ST804vwkZIEQ55I6iEHE=
X-Gm-Gg: ASbGnctvDuAFKv7wMcr+XLWGrrKytFown75/P4BsQEn308ZJcmypouXiJBSTS0boAcR
 6R9po/IqI6zduS2VQj/8dHIXnJ1hngks2L9wmww7Zj98INEVQNi3nTCiYTzO+V3KHHmYEHf2Tyh
 mhbsqTnFSIAXkS055qDnwH19rNqdW1SemOuCkySAw81cmB+RI1Z2gRRB2kGhVV7DD0Rp1g3B3A/
 n4v5yyRquKlDueeC33qSxujxWGdE+6qlwIDgIvBewFSDNwqKouDwnS5Iok/0bgvSw9qjnF+oOqb
 Z6r4DA3lRff20A8kAr4pPPY4BUHG8HFSNnTxNNJnJlDKE4Pvy6DJCltnyMlSGHQddAkB0ObWYLl
 +3gxKoTCNs1PZE5VNdnP+qq5Gd6Ye+N9S9/y6iQ==
X-Google-Smtp-Source: AGHT+IG4Wjf4B+T8GA7G5iTswRP4iu+XbUeXyjXrs5Vx7OW0g0gQAJM9tRUCQI0JPtVya3qcxHo1pA==
X-Received: by 2002:a05:6000:4203:b0:3a4:79e8:d1d8 with SMTP id
 ffacd0b85a97d-3a4cb0eaf18mr4734066f8f.0.1748186438452; 
 Sun, 25 May 2025 08:20:38 -0700 (PDT)
Received: from [10.132.0.213] (17.red-95-127-33.staticip.rima-tde.net.
 [95.127.33.17]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4cfa20c03sm3986417f8f.7.2025.05.25.08.20.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 25 May 2025 08:20:37 -0700 (PDT)
Message-ID: <45b2ad25-2307-4fa9-97cc-057666627f1b@linaro.org>
Date: Sun, 25 May 2025 17:20:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/20] MAINTAINERS: add Akihiko and Dmitry as reviewers
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, John Snow <jsnow@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Markus Armbruster <armbru@redhat.com>,
 David Hildenbrand <david@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20250521164250.135776-1-alex.bennee@linaro.org>
 <20250521164250.135776-11-alex.bennee@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250521164250.135776-11-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

On 21/5/25 17:42, Alex Bennée wrote:
> Thanks for volunteering to help.
> 
> Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
> Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   MAINTAINERS | 2 ++
>   1 file changed, 2 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


