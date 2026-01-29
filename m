Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6593BD3F09D
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 17:03:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlVQU-0006Cg-EI; Thu, 29 Jan 2026 12:03:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vlVQO-00066L-C7
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 12:03:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vlVQL-0001X5-6h
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 12:03:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769706192;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=FM1t8QIf1xoegnbU5dHkCQRqpeOUcRUVTQonxz9ohNs=;
 b=hBnwbr1H8wqP/lhvwBF011YEJbSctqmzgkwhsu8s51Grj1ya4jbH+Ket/iyoblHU9NM2CD
 jrfo2l+QaTrK7zV/+MbfXuUXhWQ8TfEw6sW0GGuaNd59gjeeM5tp/+udGac/bNXNHSKsJo
 mUHQUg2Pnf9cN7Y4lTIOHEt4ESfFbQQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-354-ZJjkl57TNOeIdn1SVg9Cpg-1; Thu, 29 Jan 2026 12:03:11 -0500
X-MC-Unique: ZJjkl57TNOeIdn1SVg9Cpg-1
X-Mimecast-MFC-AGG-ID: ZJjkl57TNOeIdn1SVg9Cpg_1769706190
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4806b12ad3fso8802055e9.0
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 09:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769706189; x=1770310989; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=FM1t8QIf1xoegnbU5dHkCQRqpeOUcRUVTQonxz9ohNs=;
 b=lyUFlVbZuMPhKMCRorzXSZKYrvs+Y1vJCAvrwYAZtfbTcy45noSMoKPCcaCdRbryjx
 PPc921s6yDf4gBa36n3cJvLoz7KFAHVF+m/12ZVTRuh7uBfIj9W0PkHvesnY8/pNFgtj
 8rtzDecFW0SRhcKw+6u3TaA2DUkniD+ZvPJZlyYYk7baMthYM8RYA8mG8obPCFtiFagn
 fztYVr+jq0bKhSCeVjHpmCZVuclov1M9vhfpI1Vg5pJyxuHrRf/1pNiCqrEJmUuGBXti
 u5JDIGrhQI6mjSIq3tiujpHEMhOGX79ekbC5YA/Q2ltm28+JtU/NJ0Ks5miFqXdTyN6C
 T0cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769706189; x=1770310989;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FM1t8QIf1xoegnbU5dHkCQRqpeOUcRUVTQonxz9ohNs=;
 b=pXCXWiO/lH9ztHcsL9s1QvA0XSDAs6QB6xYVS6Ib4T0s64xUYaXNSYLyeHxfnEkvKS
 mdVJdSBfMg24yLaUnsn2ErG6CwdT/F0zyAGRo6C8kuMuGxCRU2XAnKMlQDyG2esWTGT+
 zXo3YBpTtG+DpMW3N+kM1Jdf2XVijTiZBV7vP2UueaLXonj4cBAgVqBl11sFyVFGPaIN
 S0RCJa0ZifcZxOlLRAP8KqrGE4WEVs2avHIsE6DYFQQmG0ILN1Bk6KhG2my21ZvWox5W
 JDogI9XtP5BX0H06O/HtHf1hTfLEtlwEBOQk4+haFHvm4Z5CUPxghzYhJg/PI/tT9mtD
 DoYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXy6idSev5UrIw0so3Rv+ibC67lft0UcIEUlrvUWrrt4dAdSkxSczn1qIFdMkyzNDpOwXSKOgsPs7DM@nongnu.org
X-Gm-Message-State: AOJu0YxmLGuR9DQNfmOE4flJsoJ9crvNdZInPpTnj9KXgbE6i3hjwWen
 306IYAxIrf/IKY4tWviCGa3LqR+1IR+HLAesXhdxtRo03VJd05Qj3NFhJY/FmGJtoBmO89TZbTM
 EYvpAaNogY96qKXwy3qktZIZb18i23FQuYBQq+sFsVXqJxNJ9WewA+UUK
X-Gm-Gg: AZuq6aJr74r85aDf3ejkaAslmshGP17MwameSYC4azBN/e3M9F/UiI4uIwXX+7QHHSx
 wd1CP/9AoHe+41gnSwf/o9vIve3EEvlNQF1kqtoFGJqQwxc1VyGr/BabLK4E3np8gAonWREf8jY
 5BQK9ERG0tQ8PLnX0H3kXIpQbUmoC00sJgETGzOFgPCu416W/AbNtx1DlRJio6ODByyJdat3NEQ
 YyYNHjePZpT4sRZ1qwN5WKRdzV+W4k8rM6jzwzfB6BmgCCcHuhIcK9O/pHEIvf3F7amLKD9itiH
 0JMoQLqR9FM0bxnZg9uZhvy5BecT4B543z332sbnXZXjEcCtH8hw9YDDOSoC3IESQwupnJ2GqJm
 qK3VUe/g=
X-Received: by 2002:a05:600c:35d1:b0:480:68ed:1e70 with SMTP id
 5b1f17b1804b1-48069c6355emr163642895e9.35.1769706189646; 
 Thu, 29 Jan 2026 09:03:09 -0800 (PST)
X-Received: by 2002:a05:600c:35d1:b0:480:68ed:1e70 with SMTP id
 5b1f17b1804b1-48069c6355emr163642395e9.35.1769706189255; 
 Thu, 29 Jan 2026 09:03:09 -0800 (PST)
Received: from [192.168.0.9] ([47.64.113.220])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4806ce564f9sm150365555e9.14.2026.01.29.09.03.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Jan 2026 09:03:08 -0800 (PST)
Message-ID: <7fb919fe-10b3-4c0f-a71d-65367fbf5772@redhat.com>
Date: Thu, 29 Jan 2026 18:03:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: tests/functional: PPC test failures
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Cc: qemu-ppc <qemu-ppc@nongnu.org>, Reinoud Zandijk <reinoud@netbsd.org>,
 Ryo ONODERA <ryoon@netbsd.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <5100b77e-eb58-4651-bb43-13ccc6b531ce@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <5100b77e-eb58-4651-bb43-13ccc6b531ce@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 29/01/2026 17.39, Philippe Mathieu-Daudé wrote:
> Hi,
> 
> PPC AmigaOne and 40P tests are failing:
> 
>   40/306 qemu:func-thorough+func-ppc-thorough+thorough / func-ppc-40p 
>                        ERROR             6.02s   exit status 1
> qemu_test.asset.AssetError: https://archive.netbsd.org/pub/NetBSD-archive/ 
> NetBSD-7.1.2/iso/NetBSD-7.1.2-prep.iso: Download retries exceeded

Looks like netbsd has got a "botcatcher" in place now, so you cannot 
download this from a script anymore :-( Unless someone finds a different 
location for dowloading this asset, we might need to disable the test.

> 274/306 qemu:func-thorough+func-ppc-thorough+thorough / func-ppc-amiga 
>                       ERROR             0.36s   exit status 1
> -----------------------------------------------------
> tests/functional/ppc/test_amiga.AmigaOneMachine.test_ppc_amigaone/base.log
> 2026-01-29 14:34:05,923 - DEBUG: qemu-test.archive_extract Extract / 
> root/.cache/qemu/ 
> download/8ff39330ba47d4f64de4ee8fd6809e9c010a9ef17fe51e95c3c1d53437cb481f 
> format=zipsub_dir=None member=None
> 2026-01-29 14:34:05,924 - INFO: qemu-test.fetch Downloading https:// 
> www.hyperion-entertainment.com/index.php/downloads? 
> view=download&format=raw&file=25 to /root/.cache/qemu/ 
> download/8ff39330ba47d4f64de4ee8fd6809e9c010a9ef17fe51e95c3c1d53437cb481f...

That one still seems to be working at a quick glance ... maybe it was just a 
temporary hickup?

  Thomas


