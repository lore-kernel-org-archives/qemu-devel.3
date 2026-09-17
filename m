Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BCE5C982D0
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 21:50:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7K0J-00021O-HH; Thu, 17 Sep 2026 17:50:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x7K0H-0001xT-DV
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 17:50:49 -0400
Received: from mail-pz2-x0f.google.com ([2607:f8b0:4864:3b::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x7K0F-0002p6-OD
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 17:50:49 -0400
Received: by mail-pz2-x0f.google.com with SMTP id
 d2e1a72fcca58-85469b355ffso73892b3a.1
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 14:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789681846; x=1790286646; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Svj+lMI5oIYb2v+4aL5AoNG9IHIpPEaV2xJ0SEo6gQw=;
 b=w0pk2/Zk756lY4cm5kCOJZ833KWajDCLv8GKVSqhtUsaACEaWMwjz3TnAd/w7j7nYU
 LetHbxQBp9rx+c4LFFFqY85uGUAeQMvzcGkWjHezTZYzd5dr+nvfn3NcMwxBPgbuuwZ8
 01H5FiqkYZl5GRUGJ3eEidSEMDUt/cheBSMGPvR/hISkkZAiJhE+K9+bMyQzjBHQAdHX
 1WKJLg2/T2nqgESXFyo8GI0TL0rhFCYFJMeXphlQw6O78Nrmx5Q3egDrInPZhuII0UhU
 kiW3ak19w7aZmNZENm01uThMBuFCEoA0EsfL/NONizyjm7MBy2VHxpzCbcsrC/8u5tTy
 3w7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789681846; x=1790286646;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Svj+lMI5oIYb2v+4aL5AoNG9IHIpPEaV2xJ0SEo6gQw=;
 b=EuWAgIanYz3oNPnm4tYIFkEVVDuzsmFle+PUrwSA44djys0+BMe5obSP43UW7AMIos
 7a2++n2370lhFwhi9yrzJ1DY4eckL+wiBTlVTMjG2gCad0113OYGB7itsMMrzJ2x5Yqo
 +t0mx2INSYtDbyqahROXuStYbnrTdWDlHDrvQlSr7GbfktqThMkNlTPM9+RgZrcb3VRF
 xDC5knNYladvpiTulVDr4MDeB9eyD3cqfBUHBJw6BDK/D70PtLdoOaYuXJA8VgUOUOTx
 mc7ED4X+GGlZZm2Aixl5phJ6XBjGINlTrvisShpRPyfWnqsK2pdLp5J/bT0Sgc+bgaO2
 UMaw==
X-Forwarded-Encrypted: i=1;
 AKwUvBytRjHkU7gz4by2Z00fJwqVLEVemV63YyBqOQZ53O/Pbm1jI3H8Zornf4qbc7b2SkEr8g1JLAq2/5W1@nongnu.org
X-Gm-Message-State: AFuF++mhQM/WXh3vsz16ya7Lnqi9FooQYQeRNAbKgdgaW44irlhd3DS+
 L2+z5x9KufflPATnVfJOD/edIoYMof49RNJ3b45Ig8jDEvcQtY0MrZm2fCFskF6t14k=
X-Gm-Gg: AYBFou2QP8A2rx6+ReXnsdd+9edufEooYnFLmdmVJP2Xshn4DH2v+IgkK8PN6nTeK/c
 aqAzOjsAmpwoZCUi5FYiw9RcVQh0fxDLxUvdRwwKj0x295sG8JTn5EnCPsDQ7t/HItEg0gpW5QQ
 8LUMh8DFoCvfM6vrl439z2zn5NzBLKrJR56IHRKE8tJYr+yLMAyIyHRuqE3mJO6YQlAlW9Ovn0K
 RmspRBKVyH8ifwZMr2fVooKDf6n5eJkpsCpXXhtsy1H9RtFBeXSjdj7WnApr6g36C4HFMStwKKk
 Xv7rxipskP6ME/NzG0ZmdOwfwKIgNLpwBN5JtEcbSCMOhtf8mWN013URsm53XBXC1afYUWvhYTF
 +HW1H2QWMWA3p2XXhMRC30m/s4mYPI3+jbkeJFD4NXEm4CMTU9q5wwW2KAYQbzJD61h0nJqIHpG
 vcBbdfE12O6PpUdieu6T/Q2ENcZ1vPitEpSqB+JI7ve0TKopGLwecBk3HdO3Rcg/bXXFwmih85e
 vbO5PfcoEpYEvcZq6bjv1RhXqRolDHxeQy6FeL3QgH4YCQX4yXxmJwq28MaLQ==
X-Received: by 2002:a05:6a20:9c8c:b0:3dd:85a9:559d with SMTP id
 adf61e73a8af0-3dd8c57fe0emr601870637.31.1789681845705; 
 Thu, 17 Sep 2026 14:50:45 -0700 (PDT)
Received: from ?IPV6:2603:800c:7900:ed00:5a4b:653b:1dce:569f?
 ([2603:800c:7900:ed00:5a4b:653b:1dce:569f])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bf5aee8b0sm35753840eec.23.2026.09.17.14.50.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Sep 2026 14:50:45 -0700 (PDT)
Message-ID: <a8180a70-2dbd-4c54-9a05-15920cc194eb@linaro.org>
Date: Thu, 17 Sep 2026 11:50:43 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/14] QOM security status patches
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
References: <20260917160525.1275388-1-berrange@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260917160525.1275388-1-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x0f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 9/17/26 06:05, Daniel P. Berrangé wrote:
> The following changes since commit f8296b816fabd370307cd22b0270b610fc0fa279:
> 
>    Merge tag 'pull-loongarch-20260917' ofhttps://github.com/bibo-mao/qemu into staging (2026-09-16 18:24:08 -1000)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/berrange/qemu tags/misc-fixes-pull-request
> 
> for you to fetch changes up to f49f267664ac9a681ab19c1790cc3d75a1723790:
> 
>    machine: add helpers for declaring secure/insecure machine types (2026-09-17 17:00:44 +0100)
> 
> ----------------------------------------------------------------
> Merge support for recording & reporting object security status
> 
> * '-compat' gains a new option 'insecure-types=reject|warn|accept'
> * '-device help', '-accel help' and '-machine help' report
>    security status of their objects
> * 'qom-list-types' can filter and report on security status of types
> * 'query-machines' can report on security status of machines
> * Adding macros for defining secure machine types

Applied, thanks.

r~

