Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0C59EA3C59
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 12:49:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAooi-00036g-Ns; Thu, 09 Apr 2026 08:49:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wAooe-00036N-6M
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 08:49:00 -0400
Received: from mail-yx1-xb131.google.com ([2607:f8b0:4864:20::b131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wAooc-000389-Q5
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 08:48:59 -0400
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-64937edbc9eso774571d50.2
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2026 05:48:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775738936; cv=none;
 d=google.com; s=arc-20240605;
 b=ixHvcTkQqI4XXyCr7RFPTTV9vczKsMVFg274osSadFwDLCoWd27PXlhcT0RANphSMA
 OoB99t2FDa0GYl0WUQ4lZv4LLQXHuoSAd+eQcz0puLP32qk2/05JPmeWzBIfMuZquCJx
 Hgm8YKtyFu2pgbVv1JH7B4z2CXTKqMmOkbmI2D+g9EHvZ3w5PuhD7jw7h8YVthgAJ67v
 vhFlPMh8xjZP5KtdR7irQcrJnMfJnKjotJOe+9MLJ3BSHHipXwlWWLyjZOMf3A1AI53M
 WsVrRXjBGD7UFh0+mz5+M9voJqB0BDRj2MQpou3PaSbHlx/znAxyYOJq3zyYgGtIpiG8
 VTNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=yT5xHRSlVuDlCKLT2yF3T0lqtP5ptWJW7Dyr+P8sFaY=;
 fh=ZArSW7+vJJODnJMJnxo5Vd6T3WHasiYNFpAuJV753DA=;
 b=g6EigMjmqZe8GR+GJCOAircPGZggF0ocnfmR81Scizv5SOuMR2qjzRFQ0N4FVclEXf
 NRIK3lMEhLhR9/oUnwsO814DYFpCvdAMXgQJXsj87oms3sKVzr3oyr+uzMVRzWKe5eF+
 /oDB0HtkdChDdwunAvh0WWEwj7GtcALHhIRqw8r6iDiiK4b15m3ObBUI3xcNgu29CfwX
 bzkm79eD2376gCXvCqXC/c+g61CKLeko9StKohQ/CTQLD1atuuQy3eO8v+phrBH+6v9/
 VJb2wy80i7e4aWoowUYetq0wiIuBg83yH6BC7b5SfQERbTLqFNDgbvc2bPRo0CFeREa1
 OmNA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775738936; x=1776343736; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yT5xHRSlVuDlCKLT2yF3T0lqtP5ptWJW7Dyr+P8sFaY=;
 b=KpsjFPpnj6RuxxSD6MOAi9yHBEDk8O2nkPulnRIYqRnryZHJhDLoKNDjZSBCCi2igp
 5Sdkq5iRYMLSe/wQUnjw2YrtTdfXgPxxFoyIwi71LHiSqbzMwjEElClpsUWZxM2AbePM
 CDaksURB0jjmUfbxz2OIfKMF7MsVUR/9DYgnNoJNYOcSzGVEprDRcRPVC9T6Y1+Tlgao
 3Ew1X2aqAvc7Dw+4jW18aOeBDf0FaYbOBccM4qtR4Q4c9LFef8pRagfbUCJlH31gRspK
 vyg6KF69V4obpcmAXu1GYBmk3iT+qVOZDUUrSm7G9hI28iTKnnazW3cJCA3rcBb6WXgP
 Rx4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775738936; x=1776343736;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yT5xHRSlVuDlCKLT2yF3T0lqtP5ptWJW7Dyr+P8sFaY=;
 b=gxJ6FmA9aeCOGVCRyGcpBvm35pvwXoZrPSCbA3C6Nvnx2y4gAol4LOjXbcVbqPomn5
 DDVA6YrChCpFJG7bF9eRHMLrj4rnQ1Tv1f6hDdQjDdooJ0/cOKo67nKzaRu374pUcw/x
 o7KcvM+7TnsirNVu63gUmI6B+fUrqUjJp3fJoG/JrPhHUUSsNaFlFmoof1jc9jO5DpZL
 XHXoG1ZtMHGyvzubvR2ZeRXKjw+ms+7vulAiTGjEFaZQedfNXslqkkuACP+UazbFnW7h
 M1MoCWm12EpjI1PuysplNEL7FVbvzvKOVaRs5kbKYdgwErGx6Q+xvulVQru9bO1Xq3ES
 5B2Q==
X-Gm-Message-State: AOJu0YxdjZRsIRIq4NiPN98KbMBK//+659RijoHPUBZWro1cuYtPzGyD
 A5m1k9qCUh+thJMjo7lhngDk/Xc1rz8lWFitmABf4zC++gMr5O+9W3MDdk9jQWFVTCRSg5X7Vx1
 t1zmeDa+eFXpv4ff83Qai37Q+n7d2FtDF8NCsptnzvA==
X-Gm-Gg: AeBDievEnrJe+lBoEgE8HhQWQI30bxFjfeQlK0qOLf1Z6zmh6VFvF97Zz7jQa2DWRKy
 FqpxOCJ0vLeFnbF8I6iZZqiBD6yNO5PwCTE76VjM0gpk4JbOrfv2lwVLXfWnPfOsgjAEdptf/Cr
 Jj4KcV0ez4E1QmLNfNGjayuGSOFmrkY+qeRH6RZsc3Zv7ipGEdV914cswLoc9Rpt2t48DmxEoQm
 8pzXmLtEhpL+gEK/xRX6C99TVFK5VIxPbGSIw0mfSmkskGCOq68Io/f1VVsKEc5b48B4M41d9Yf
 we4TN16Mha9S3iKozsrpQ+Ld6FLECQQSzS8Oz8eI+2jTh8STPOjAutni0Bt8nqCCy1K3qxfudAM
 GRg==
X-Received: by 2002:a05:690e:120c:b0:650:1aa5:8568 with SMTP id
 956f58d0204a3-651877dca15mr2819622d50.55.1775738936493; Thu, 09 Apr 2026
 05:48:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260405180826.729652-1-alessandro@0x65c.net>
In-Reply-To: <20260405180826.729652-1-alessandro@0x65c.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 9 Apr 2026 13:48:45 +0100
X-Gm-Features: AQROBzB3Ngwa5g5InIVXE-RjkjGj_whSyglhZKO2odPBUg8f7R62L2vFY4NLNlI
Message-ID: <CAFEAcA9reE9J99SFt2HzQkRJDrxRnObbCrZ3jfrZvNO70uaAWg@mail.gmail.com>
Subject: Re: [PATCH v2] target/arm: Move OMAP CP15 register definitions to
 cpregs-omap.c
To: Alessandro Ratti <alessandro@0x65c.net>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb131.google.com
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

On Sun, 5 Apr 2026 at 19:09, Alessandro Ratti <alessandro@0x65c.net> wrote:
>
> The OMAP CP15 registers are only relevant to system-mode emulation
> of OMAP SoCs. Move them out of the monolithic helper.c into a
> dedicated file, following the pattern of cpregs-pmu.c and
> cpregs-gcs.c. This reduces the size of helper.c and compiles
> the OMAP-specific code out of CONFIG_USER_ONLY builds.
>
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Signed-off-by: Alessandro Ratti <alessandro@0x65c.net>
> ---
> v1 -> v2:
> - addresses Philippe's review adding the correct includes.

Thanks, I've applied this to what will be my target-arm
queue once we re-open git for 11.1 development.

-- PMM

