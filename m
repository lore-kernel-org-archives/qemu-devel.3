Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D60FEBFD3A
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 10:49:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCEqz-0002ub-Df; Mon, 13 Apr 2026 06:49:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wCEqk-0002oO-94
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 06:49:03 -0400
Received: from mail-yx1-xb12d.google.com ([2607:f8b0:4864:20::b12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wCEqh-0004D5-RI
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 06:49:01 -0400
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-651cfaa21e6so517804d50.0
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2026 03:48:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776077338; cv=none;
 d=google.com; s=arc-20240605;
 b=i2nbBi1mVQZ/hj47QfCMXlb+2w8RQEgoLvvRSC2f2cdnqI8F3Rq/jxO76/UVyQGa+E
 aDpQYEpaZxKzag1lBwt8hja+gXEx9W8g7/lDZya4PlBe61muLKTR1GToVeaFdd20mfVV
 HIOUtU+9dgcgPtofDfEg2fUeL27eOYjUq2LoDtxIaC3Egwi+oj94l3YZs6QQog8J4uw0
 n+frDO5jbSUri7lg7y47aZoKY0rKCC/8GeR+rBlIhcoIC789U6fo3vgPLAb+ynCWd8ip
 bvRoJEXsy1HiVVscHIt4qPifPgyRgf3NR5M/yRLBK4Du49UuyU9bGlXasW0eLKxjloSQ
 UJ+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=T/1dmromYxTFvEtNo6SmDGXtOxL0QiWh3YyyT28njEA=;
 fh=nzB82wXMZp8IHFtzo5rr1BNPunJBjX04EUwTm2pcAS4=;
 b=TJpTPS3s/OnYXxXHTYKridsKAQHjmDLMdDpseeDSW6P53BOIlPSaunj1RwpQKygSYG
 qg3kTPLWflz/Bokr/nPpJkQxLx5EB8m9nFzjL0yo2mgU6G+kVHLo+DmYY76X653HBHE9
 TMJI2NVSrNjyTN/IcyPNBHPUrYG6C8QKxeozPIGPkR12eZHiTZTmFWcRlq1GyzJgGSeO
 o03iBNn6LS/w6ql15Ea2l10aSIr0Ok2g+gArGSkop+Is4nhH8j6o4T1LCHTP6hVHKMVS
 YSaelzOjzfZ+2mvI3uaOGSTHBzAWroaHjotIcdHbGlT1Vu7Cw1lSme3sStt7cFFFRE1b
 Ryhw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776077338; x=1776682138; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=T/1dmromYxTFvEtNo6SmDGXtOxL0QiWh3YyyT28njEA=;
 b=wFqzrQ8PtMiyHRaxYHvbi/5ZQfgrCDl3rRi3Veilopx8aa1M/Wg5s598tYVOld8/9q
 i/1zGUAiSEHWtDScoo7Snd7sHIyIM3jlexjYXiIRudkcXm66l3ujSYuuUVNu3VkvOLc/
 wiiXdrUvmjJt3xEWm9rgIxrN6l+erZN0YXEPvNS8+rDN5l4517S//mItgiyy+OVPeRR/
 KvTPqNqOUa0XXCq+Pj2bCoEluKdSiMTpf4u/VKQkuzTJMok5KzsjUKwD5T4gwWoT9amh
 MxFwocVuWFNPMQIekbH/Lg9DQicx+HZY6d7eNqCgLw+92IhKjLOipo94eg39BDNH57Mj
 cxKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776077338; x=1776682138;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T/1dmromYxTFvEtNo6SmDGXtOxL0QiWh3YyyT28njEA=;
 b=qID5FDXjCeCTEOqwVOoPy1QzO8Z5AdZGbypWj/bqsTVKStCaCgT10fQ8vp6bye/WGS
 eye+9zNfMifSyHmSOWgfDXNh/cY1BHrYDM/7JUaJ3K55wrh1judJ1IrjhoMMpjrDza47
 tND6oSRIuoMoDppYx1O6jsGTBmLMB0CAudoKU7acOo1GaVfIN0O8wsH6gprlmwAmcME7
 7nrygSb//RDn83bsxkBugebN8/dPi3xHKjildB/rVnxgIiuzwCuU98GwHow54uOchf2d
 hQj29x/zAAFFINNuuUtFFDQgNoqQURhi6uhlYNpF+JMlEBmg5jGs7sxu0hEeQfj5M1C7
 YLrQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8bJBFSC5NQv1E7LQXAcHC4rvIJUFEv+UycLMdhnMb2osHIxHLD4Y9ur3HbPREDvk/w1+4m5ohQcmpP@nongnu.org
X-Gm-Message-State: AOJu0YzSrAwbOfROoAPaUy9Gi/E2c241dzm+EmcD9/QH4KT9gjANy6Xb
 riekxaEdQM9W9Iz0yfQa7XguqtamuJmesOh/+Cymk1A6agATgn8vGLH4bem+myMimZ6ohYVKQ1z
 SAkWQXM7WBT1smc455CpVkrlLsa6hsZTR8QJMVRcNsg==
X-Gm-Gg: AeBDieuvsmKYxBgiAhOAofYPmV9WhH8DDbQKEZUaXRhTXQ8+0ekGBDzTaD3kMN+cN91
 sCYxSKz58ZmcGrur158x9QpMENhwlazLKPADaTKbu/EcWr61t/k4AUf6hNnwhBOpHCICUApQ5mt
 jpxGFb5C6YTEvmTAX8NuWooQkcNrUyzO1Xxp9T/zoOX/LixjRxb7poUGkx9EHK1r7WJ1y9XgCto
 2suMwe+g+5LFyrNmEnfkSMToIESt3HIS3gTHuL3djJ/0CEIhP0AbSxacxEDEyblNN1WPh91/wOG
 iVXrybPbIhtcuTId5m35n7EKWclL6WRloGsvBQUAmBQ95lD75Y0gtVHzdW0nx0LBzEM=
X-Received: by 2002:a05:690e:1308:b0:64e:e898:10ff with SMTP id
 956f58d0204a3-6518726a297mr13533121d50.40.1776077338101; Mon, 13 Apr 2026
 03:48:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260413103754.45745-1-peter.maydell@linaro.org>
 <F20654A8-2ECB-477B-8B64-9688B5FA9EB6@unpredictable.fr>
In-Reply-To: <F20654A8-2ECB-477B-8B64-9688B5FA9EB6@unpredictable.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 13 Apr 2026 11:48:46 +0100
X-Gm-Features: AQROBzA3EHEWErFX0uNKwE_BDfcwG573kit_NzKi7mycu2Ipws6rncgdJlfDD_M
Message-ID: <CAFEAcA887dXAQ153Z2ZqjpDtUtnpGAmoBwet63CTyn=wLtn1jw@mail.gmail.com>
Subject: Re: [PATCH for-11.0 ?] docs: Deprecate Arm OABI and NWFPE support
To: Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12d.google.com
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

On Mon, 13 Apr 2026 at 11:45, Mohamed Mediouni <mohamed@unpredictable.fr> wrote:
> > On 13. Apr 2026, at 12:37, Peter Maydell <peter.maydell@linaro.org> wrote:
> > NWFPE floating-point emulation handles the ancient FPA11 coprocessor,
> > which is only needed/supported with OABI.  Our implementation is old,
> > untested and not thread-safe.

> Especially that this has ISA emulation code inside of linux-user (!)
>
> If this is (unlikely) to continue to exist, it ought to be moved to
> common code for system emulation...

No, because no CPU we emulate has an FPA11. What we're emulating
here is the Linux kernel's emulation support. You can look at it
as a set of syscalls with a very funny ABI and very specific
behaviour :-)

-- PMM

