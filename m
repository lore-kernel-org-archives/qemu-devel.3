Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25C74C87FCB
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 21:24:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhxE6-00021b-3I; Fri, 01 Aug 2025 17:23:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhwjr-0007nx-5X
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 16:52:28 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhwjo-0000hz-Vb
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 16:52:26 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-76bed310fa1so121706b3a.2
 for <qemu-devel@nongnu.org>; Fri, 01 Aug 2025 13:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754081535; x=1754686335; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=S37FMvu4+Z1x+xCujKg8u/5vV+XgGJuUqbNsXno5Qfg=;
 b=Qz6W+cCdD1Z8pTgskmJrCN8jHE0nyPg986sXtAqmCf7m3CFr/NkRMrQ1GTB3sep0pW
 poYBHTAOS+GBmoKYhr2+KWbKMWuNN+IALVZQUXwscM459h+SF1ycSpf2WkEJ+2w4vNGI
 AOBep9eEfdh+PdFy7lQJ6YFowH0LWUcsCrHN0w7M7B3uk9GKdPSaUQi5scnDg7MnF4zE
 m3K71qFCdn7IkjSp/gP79MygxItAhj5oFe3/ANVjqGwGQORgfJtPfa+XpiU9OqLkSkBP
 kTxnPTR+BOCgRcOHgl65aFH9/acIu6AkIXRr3S3+Xi43C6y4VY+MVrbAnJ7gT4ne7daa
 qNuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754081535; x=1754686335;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=S37FMvu4+Z1x+xCujKg8u/5vV+XgGJuUqbNsXno5Qfg=;
 b=gf/1hoWaJBuRjIaKabFGvu9hU3B5NxqlTV2Xl4AqrcLGZh1VY1fpXiYlea93xBK6ad
 NZtHVCcPVxbvOV3CcV7dIUs4RYIBLjBVuWHjnq307T7GDkUXQRMWmHcFqrYX8Ld0pzAy
 kn4EMb6N6EVgQxG3O0FYFGYxTySBE6oyGgJ0BlodkCX74XRp1GMI+wfXknn2wKGZ9jnS
 h/nJvHODxUP/rRgWizz5XN5Cc0Z5JpACzOE2eDuW1ZIwkD9uUQSXCxUKs0TKIEzb1Rh2
 zZNawmJ/kx23bneaEr6ndouCEDzybQJA/bPHdPM3H1+bi1EmjpIQYCjwGi0FiROOrc/t
 +N7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9uo4nZHTC5Z+uka3Fg5uOZ5yMlw3FWMy0YICPkdlqA07exs2wlyZYbp7FTGM/VDdDNzsEcgNpGYiM@nongnu.org
X-Gm-Message-State: AOJu0Yxllf5LSF28FGygU+42rAkqgf4WUAV0UEzSXORu/neJem+/fhhs
 NBuf5dDVJZUkjOgfcHkjhgsmv7WDCSJkFbkmVNrwqQl57hdD2GZOS1G+pw0lzcFqIJ0=
X-Gm-Gg: ASbGncujZQ1ESAkuxQrJ6O2DIHeV+0jO0F2/D6/MXHn5N4syURDXkEAYqNkvzW8lfUI
 10Hp4y1U0CS94Up069WaxhxeinMlyp0xVwydm0d8AUoZbSw61+DneQaw46OvgB9uSEEKzuslDla
 5LR3beP6meW4LuXfHXUmExdY27MI2mdaCE9lBQ5DSQv9I8rgOtewAOZvqdmgUijje03mO29Jt8C
 NHY0CGb/CSqmqYLjYAoDF8RTq2hBGmi4sM0XLRDMqXDHnpFdHET1/oChg8iUJ4rt77wvHjZIXSw
 z+GlBlZiZImmcY+IArehB/SBJYAvMtJoy5Nz2PB0OlGd1kn+ykYUjw7/rss+AyezA2JWcKns/U3
 cifoRs1MLNr1Pl1Wgz9GaGz2iMZeI9QjOz7gQ6qIfew7yDw==
X-Google-Smtp-Source: AGHT+IEFy1Sn6goHGOZBIZVKuhWa+6VljoFmTy5pAUckAxb4HxRycdUsBkEogGyanyqeZ89m55+k6Q==
X-Received: by 2002:a17:902:c946:b0:240:8cbb:7c86 with SMTP id
 d9443c01a7336-24246f5e67bmr12959985ad.16.1754081534714; 
 Fri, 01 Aug 2025 13:52:14 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241e8aaadadsm51276155ad.156.2025.08.01.13.52.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Aug 2025 13:52:14 -0700 (PDT)
Message-ID: <4bb0d09d-d408-4c42-ba0a-1c6fa417a6f6@linaro.org>
Date: Fri, 1 Aug 2025 13:52:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/24] tests/functional: Move tests into architecture
 specific folders
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20250801151251.751368-1-thuth@redhat.com>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250801151251.751368-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x429.google.com
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

On 8/1/25 8:12 AM, Thomas Huth wrote:
> This patch series tackles two issues. First, the tests/functional folder
> has become quite crowded already, some restructuring would be helpful here.
> Second, we currently encode the target architecture twice in the test names
> since a lot of the test file names contain the target, too. This contributes
> to the very long output lines when running "make check-functional".
> 
> So let's move the individual test files to target specific folders.
> Then we can drop the target from the file name (and thus from the test
> name).

I don't have have specific comments as it's mostly moving files.
Looks like a good and clean structure for expanding our tests set in the 
future.

For the whole series:
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

