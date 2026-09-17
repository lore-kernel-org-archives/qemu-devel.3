Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C609C88E72
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 22:18:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7KR4-0005Z0-HH; Thu, 17 Sep 2026 18:18:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x7KR3-0005Ys-2H
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 18:18:29 -0400
Received: from mail-pz2-x10.google.com ([2607:f8b0:4864:3b::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x7KR1-00089v-Dw
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 18:18:28 -0400
Received: by mail-pz2-x10.google.com with SMTP id
 41be03b00d2f7-cc4cdc0d663so12515a12.3
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 15:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789683506; x=1790288306; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=04DVbRiOrJCKwtHDwyoX9hfgegCmdaMQBZt3dj3s1lo=;
 b=F0+ZsFOJqT+hkzOF1/x+MHESqEKCAezOPGLM0RiZZkEWboCwmZ3esDx2p1vn9FoZv4
 D4ac/RWkmgqtv7fjkheNyDThvv8HS6fBtTWxetedN48QGjc8BZWq1KRv/LzvOKnXcj+/
 GLFRKnuVooRLEuU4oZftt58wt76K0C9x9MMzafm09IBiIAeFFuJVvkB7Cc+2cN5gwR/b
 zfWBUtCsQ2xRanHQdBiTH6rUu3lmWRl2mhahxqF8Obx/s1Wbs/jMG4yJtsWEvk+cvL+/
 taEbqUjuTStH1Aw9U2Z6carq4iRqAjo4s6GDXDWwCNedwIFJKvHZkUDpwGgjxmBlkHun
 Xk4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789683506; x=1790288306;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=04DVbRiOrJCKwtHDwyoX9hfgegCmdaMQBZt3dj3s1lo=;
 b=R9nwPYcYRj0auHFJtCIbW/J+NO9LEpXGzWdofu+qh+Xa35i0G2SBWtFoZS4qOutiej
 jWZeiwYxQntcPUaOx7OhDC9rcy2V5AFPLZSlyIbZpVsYXyQPhHCGUB8TEx8NKX7WCKx8
 kgf/Hsohmzf5/+cCs6n37bhAs0vZ+2hwkPiFUblpFIqaDYtaEaH3ULraoT0hASBC9NEy
 udF/YaA56Wg+xb+X6eCLd6h2Q6E6U6dWpOx7o9Ry7GSLUAzAALGtkNezfa8y8SLSAPh+
 89HKWSsAZ0Sx3uam0lreaPk1brPvYAYnCnETb94E45l1Z5N6l444qC41UxkeUvrZy7YD
 DDig==
X-Gm-Message-State: AFuF++mYMxwqZSF2QQxuZ0qIRjlMI3BNaZOIkLJzhl4EClbR9/xkho53
 b627kedRXUW+LZ77BU6zmfuku87W8KI33rgEBMcjHJ8esls4WeuuBh6Y3HXHHhz7Z0w=
X-Gm-Gg: AYBFou1x2AD1fZy9aUpF0cFUHBXvv0NJ5qtccsLHVtvc1tX7lKgZzq0yKBVyUHdTxjv
 +B77UraQiv3Ri/U5+1POqO126Hw5roGhuG9YjLoSXsohx8ppzFApJp4P1DERgmbL6dR/8D4Lo7X
 W0bxdNZSrbyPVhiysUudTMv3YVlHY+hAuMIlMwF/DVzpKBtO34GH6tSQp4lmaEhygFneUTpO2aw
 kSF6IxuTscw+i6wICmE3rbw+Vz14j9xfTXgEqCR70BPaLNk32jP0GoGglkP/IsThJOHDV50nm3X
 NN5G0uGx2B4wpGQMaE35l/W4pQ5cPMlJG8KFExi0p1x7UvQXBk27VqUDLQj3di2Pxsr9MluBsF/
 zwBzvndzFSJoMP4hNlYEoOVdIqw66XS/PzFqawX0ianrk/QVnJfMLgsP58xgJUHpHq57JM8dKWR
 DmW9KtTBwBu3tk1QG6h2CP3Mj00LjIaPnIgmVQsiOif3onyVgY00agZt9BgJ2yZuxKYFZA/poVy
 5cHLVqlGcZis5uioYObK+nocpYZIH+vIXa0PcKUFPAooJ05mpAh3Rs1pXKGag==
X-Received: by 2002:a17:90b:2243:b0:398:9be9:ab92 with SMTP id
 98e67ed59e1d1-39e54d56e0fmr1039305a91.23.1789683505623; 
 Thu, 17 Sep 2026 15:18:25 -0700 (PDT)
Received: from ?IPV6:2603:800c:7900:ed00:83aa:9d68:3956:350a?
 ([2603:800c:7900:ed00:83aa:9d68:3956:350a])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395cacce6sm16146863c88.1.2026.09.17.15.18.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Sep 2026 15:18:25 -0700 (PDT)
Message-ID: <96e3f93f-a12f-4d18-badd-2ea60efc715b@linaro.org>
Date: Thu, 17 Sep 2026 12:18:22 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 11/17] tests/docker: strip remaining caching logic from
 docker.py
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20260917165602.3405537-1-alex.bennee@linaro.org>
 <20260917165602.3405537-12-alex.bennee@linaro.org>
 <a42e8f17-8bdd-4c9b-b465-0428ada507e7@oss.qualcomm.com>
 <87fqz77dln.fsf@draig.linaro.org>
 <7a587ac5-b7bb-4c69-a022-3e65e49070c6@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <7a587ac5-b7bb-4c69-a022-3e65e49070c6@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x10.google.com
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

On 9/17/26 12:00, Pierrick Bouvier wrote:
> On 9/17/2026 2:49 PM, Alex Bennée wrote:
>> how much time? it flies past when I run a rebuild.
>>
> 
> For a no-op tcg-tests build (i.e. with tests already built):
> 
> - With current patch:
> time ninja -C tcg-tests
> ...
> verbose pull and build
> 320 lines of output
> ...
> real    0m15.817s
> user    0m1.342s
> sys     0m0.840s

The variance from the middle of the pacific ocean, and associated 
network latency, is between 20 and 27 seconds.

Amusingly, with the network actively disconnected (airplane mode), the 
no-op build completes in 1 to 2 seconds.


r~

