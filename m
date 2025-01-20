Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62DBBC02181
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2025 20:55:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZymb-0005md-MC; Mon, 20 Jan 2025 15:54:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tZymA-0005Vo-Cv
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 15:53:40 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tZym7-0008R7-O9
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 15:53:37 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4363ae65100so54189365e9.0
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2025 12:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737406414; x=1738011214; darn=nongnu.org;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e/T6FUXw2U17q5T/G0ZMwFbS3MJSG5yoD7pRY5rVIaQ=;
 b=ViQIdVDclNQdXNrLRaFUAWc0pfszjd09DpyNfNW81gbKyZKDSjMMN8fDPROrV6IPVR
 9dV+L/pwGng5Qa15JV7ODAihqtImL63UvvhAtWe1Sux3Vv99Gkn0U2RegyAseMSXDK63
 Im89LEaKQOuQt/ezBmbnTbAxfRp3UzZPlnzZZbYmA5b16D/DG8xhTrKPJg2LqKUrS9v4
 bBaAUVCx9EZfljIzrIisQGCXR3VulvIGlEpxdkOLwVjLXev1C3zRAoqGIaji1ZfQVXq0
 I/QujEVIpW+Bi1ddHPQiIidsWlBdc4QQnrG1kv42bz6tk8Lh1tTSStbv0qEb0mxE40Mp
 QRJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737406414; x=1738011214;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=e/T6FUXw2U17q5T/G0ZMwFbS3MJSG5yoD7pRY5rVIaQ=;
 b=N0L0bK3BRL7uET5VzphlI0L+YNRYX6xlJLl4Ba6+EJGqlxEcLCvCLntpSS1EAW+wQ2
 PP3//BtFg3oRgvFjBIAE775hUJOy18/VeKNcZq9+BuacI2IRif+Yke+bYjU1U/kv5Wjj
 vj+etR7f5Z86iz5Ik+v8NqbMfhrlncnnvkiwIbfXkr+D5WIOhS/w/X04SqXT4SblbRMM
 s/wBMK0aj1Xpl+yl9UNfEPDdSzMv5gms6LTp/gqET1tjqwUPMOLNDopnWQRrmeP7g+p5
 +Ktmi4WjqDyHMGPnTia+Zhkj9D/z+/Y4bR7XEiq6y5o2EtamXOofZhTV74z/dh4WXZxg
 PPSw==
X-Gm-Message-State: AOJu0YwjVhn1sU/SVhdp8/+exH72xizk8acQe6Lw1b/YSSUcr8jNNU7x
 9LPQ2Dtv5Qyct/nEF9m24P1tFcR59R0QXeQ5elHmDroG7QqEsDeeOGDlsB1Jl2Y=
X-Gm-Gg: ASbGncsEipLDCVn7Mo0IWFuyVZKyv7MwJOA/Qg4X6sLiJZxqaqXxYczSQeSl9CwQmz/
 Ko/gTgtltzpl+GLd9euuGcNC62DlNvu6/3wBdgaT70ubNu1Tnv8kw90xdThlIRslI5M1jrVuwQ/
 ZLvgDX3HP5WSN9NugvbavWR5J8toMeMmW2iJas8A7XrNYHg5d9wMWWTTvrkqyO/TLldLPJqjcuQ
 D9J4XUircCMQ22XYgb2ArTS4ayNe4SKcFabMGIlb2Syg6YZqMsUeWjQR7BL/Sjye+fmi9oDdtjz
 GUKACJvlaakChl20N40F3ft7Y+5816Gy5Ndg+g==
X-Google-Smtp-Source: AGHT+IG/Ch/XqdOeqjfD2tHzoZ6ai9XIVmXxhDxvcHb+uK9TDnLjGNfateWYG1oEaRDb1Ait1PcWkQ==
X-Received: by 2002:a05:600c:4f47:b0:430:57e8:3c7e with SMTP id
 5b1f17b1804b1-43891453ab8mr124583665e9.28.1737406413705; 
 Mon, 20 Jan 2025 12:53:33 -0800 (PST)
Received: from [192.168.69.181] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43890413795sm150223055e9.14.2025.01.20.12.53.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jan 2025 12:53:33 -0800 (PST)
Message-ID: <3709ba37-fa92-467a-ba3c-85355762e0e9@linaro.org>
Date: Mon, 20 Jan 2025 21:53:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Alberto Garcia <berto@igalia.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: hw/ipack: Is IndustryPack still useful to maintain?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

Hi Alberto,

You are listed as odd-fix maintainer for IPack.

After your contribution in 2012, I only see maintenance
changes on this code (besides test addition by Andreas in 2014).

Is it still worthwhile maintaining this code? If so, can we
have real world tests? I'm updating legacy APIs and these
files use some; and I wonder how many community effort it is
worth to invest here.

Thanks,

Phil.

