Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10CCCC02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 16:52:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYpaA-0008QN-Sn; Fri, 17 Jan 2025 11:52:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYpa9-0008Q0-K3
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 11:52:29 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYpa7-0001k7-T2
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 11:52:29 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4361f65ca01so22738005e9.1
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 08:52:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737132745; x=1737737545; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=X7kRQyS0bgwOu0TqrPtZcEBd9tfNhc1jRVYE3AXsm/c=;
 b=eSr7S0rFUkvcnc4DcRDbFtdbmDoL4ORAwJ+s18BBGghh2DPqwtPvnTY94QIet68t2K
 zIAdcy3VrDbQHjpSWWwOXpQftfDEuXzTFixVJAQkPJTkQvLX3atTaXBOgjPitrnTVHwd
 mXtNIhH2/xcBYUmdvL3ii5XL7kFkbDirVrBtrULB9eH1JfnhLhumK8lJ5/MNCCb8Wfuh
 RnjfMoLQhwGLcSLG6MqutD5D7hcALNrBXoACV8/xJVBUZPQCcPeqA1AhTkHQMAx86B8I
 aQfETAl5nnF0iuXN9zhX2D5olAIEQlU/p2tnlr6mbD1SojWUAjdd7dZjtVo/lJSMH5E6
 jpLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737132745; x=1737737545;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=X7kRQyS0bgwOu0TqrPtZcEBd9tfNhc1jRVYE3AXsm/c=;
 b=i54FO4SgODrmonVZd44ox3/brQO+eTeEhuqVN3ySoRPWb4jmcs2BiVe6birLY7TNeF
 ACcxNxieGd/oXNg1FczIqPpv7BfLAhmP6iABzKgFhymHSdvLzF2xfQcIIW4/C89RLk0P
 f9wrwKdJohzABhNiKxDOYRlBJ0GBzy3nOeFZedFO8xZQug6chiDSK3MRMXzU1tPytmQy
 vW8iagJigWGpfeUZXlBgHqx0J1N9Ta23IpQPJlFvgFQJl/G8mJoMpIE0wFU4Kh7YQZ5U
 ao9sfTSCyzlIB8CM9S+fVGtTHDWw63l01xEc71enHgPeJsvdqzN9ZKOmrpsxC9CUO7g1
 qYUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVtu2AVlkhgQ0nQgvd7CWP37SoJGIcShT8Scd1zdFNDJGWtSEnBi5Emp/ZR6yL8zr4Bdw0ks28u7JE6@nongnu.org
X-Gm-Message-State: AOJu0Ywc4yBWjhPiFtg7gUqHq2DIh+EWOxpXC82l1z5e22U1m05+oSqF
 QY9XtaPDQJt6EUNTgEi5ZRAl2ivQftjv5UoBufe123T1ALp57nYUQoy+FRBgS80=
X-Gm-Gg: ASbGncvZ2bTir18gQXMNrsVJLDtb7uv8VTpL9qTBWvOkNKsPkVHhB3h2YLHFK0UIZLT
 CPTejyG49spi3i7qEycfdJvjMGfzlDHAbcGtPcQLKqdQvcQGtq/mFh62W3ZlWlAPuZJSEoxZwFC
 sLwNYotW3TCfDkP7ppEsXxRS8grCUuA0iaRpviogDMbhQ4ug2tFbG3ca/F9Mkp0Iyv58QiLtdut
 2VmavvVVuPywL988gx9FcKMd9+7E1fcgQBAEYuJlg9yHjfjjDhcv5TmSiqemjvZyDtRi5TNqVwJ
 qFjLGGfGuDVf+1Iu1dFIUiBh
X-Google-Smtp-Source: AGHT+IFhbWesp7KMvmsDc8KkgPezQWWTN21rG/mnu4IlV7F6dtIu3tDUSuv62ttY95QVb5uh23OS8Q==
X-Received: by 2002:a05:600c:5027:b0:434:f5c0:3288 with SMTP id
 5b1f17b1804b1-43891430ed1mr34770305e9.29.1737132745356; 
 Fri, 17 Jan 2025 08:52:25 -0800 (PST)
Received: from [192.168.69.151] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-437c753ca42sm96978235e9.35.2025.01.17.08.52.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Jan 2025 08:52:24 -0800 (PST)
Message-ID: <1b111fa7-a2f6-499f-8556-775d2a10eb13@linaro.org>
Date: Fri, 17 Jan 2025 17:52:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Remove deprecated machines pc-i440fx-2.4 up to
 pc-i440fx-2.12
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: devel@lists.libvirt.org, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Kashyap Chamarthy <kchamart@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20250117102738.59714-1-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250117102738.59714-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 17/1/25 11:27, Thomas Huth wrote:
> While our new auto-disablement of old machine types will only kick
> in with the next (v10.1) release, the pc-i440fx-2.* machine types
> have been explicitly marked as deprecated via our old deprecation
> policy mechanism before (two releases ago), so it should be fine to
> remove them now already.
> 
> Note that we can not do much additional clean ups on top yet since
> the corresponding q35 machines (which share the same compatibility knobs)
> are still around and only will be removed for the 10.1 release instead.
> So the bigger clean-up can only be done for 10.1, but removing the i440fx
> machine types now will still have at least a small benefit of accelerating
> our CI a little bit (since we don't have to run tests for these old machine
> types anymore).
> 
> Thomas Huth (3):
>    tests/qtest/test-x86-cpuid-compat: Remove tests related to
>      pc-i440fx-2.3
>    hw/i386/pc_piix: Remove pc-i440fx-2.4 up to pc-i440fx-2.12
>    tests/qtest/test-x86-cpuid-compat: Replaced the removed pc-i440fx-2.*
>      machines

Moving #3 before #2 seems a bit more logical to me :)

