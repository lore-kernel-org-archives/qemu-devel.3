Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F200CF45D4
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 00:51:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfScO-0004nO-EQ; Mon, 12 Jan 2026 19:50:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vfSc0-0004ki-Un
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 19:50:24 -0500
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vfSby-0007Kc-Ie
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 19:50:20 -0500
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-7f89d0b37f0so2182065b3a.0
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 16:50:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768265415; x=1768870215; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CuUPMh7ZR7Dg1ea/lFkQh4vcwzb6vjlXr0gNZkL+wy0=;
 b=zMvOxravJ6K7naUjw33TaCt7X+mjOz+3cV/2zlzfCfe9/DQO5sOwaOUTeP5vQjNSQN
 NK+uKeaPMsSx4Oce++Pw10WsZ0xP6x8zRCrHWAJHVjpOJ2XwUH9V0FXjV86X/eLUQqHW
 O84lQRjUFW3YtwP0HoKKpOj08ByaikLkie/MYdgkSlWH7mx1TrYwARlOk7b781RpKJxE
 v7DWuwLVoAy278Ss7tU28lw66OPI/LgyuuG4q0scPOV3/jee8g5sYGpD0Kzn/eJ/hWET
 D0q4jIWcV6lvoJhW0OxbMS0VyOi7lsVKpYaAppAEVBp+f3fniVbBbT8B951NwO/HjCBu
 zbdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768265415; x=1768870215;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CuUPMh7ZR7Dg1ea/lFkQh4vcwzb6vjlXr0gNZkL+wy0=;
 b=wwpoM+madiC6spuACdLAKSsoaUE8T7tHngmYuxe6b/H9EwM9xX31LgYvf+76hgqz3s
 3xZjy1RW4elOsxkCgTulGZp52fPCLCW8YAN/Bnh3R2jBPyoZSTBkw1o5I8mjJU9AkoZC
 nvSiR5wu+OHoSuv9f071GAEf2lQ6TBBxgjhRgzsP5HO+oVR0Ng+A8bpmaQR3Z2X+doaX
 jN/QFZXUKJGmCvwcaV+ID3H6basuUXUMSDXEOhaqURqnftZjKhVoJL7c3Gy2vANZqfkL
 bDVAoAa+w05jSU6Y1SJ079EZgET5WF9Vnq1SB2exAlh01f2lGV7a5FrOF1jWEIKYsMb+
 pY8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPxfuSghm6vSjx56YXeO5rJlkBUri1y8zWMt/BSYfqoSzv/SJ4RW1YzPbkwCOadHT5QqhtSOzeGeXr@nongnu.org
X-Gm-Message-State: AOJu0YwWT8uFHvMxfXlQXMQ3If4Q+lhDFA3tuBCQta2lNKUH8MB+nBAt
 8X/GI+DdU434hAh+8cUHVqBOlpO2BQTnhqf8vrLiniNLFN4hPNBIhFWKP3kGjZMxAeRvPatT3VX
 f9JYUPAk=
X-Gm-Gg: AY/fxX58NqobY7wvlJo7yfsU0QGKXAO3gDLbPcGXvm15246aMWm+ZLWPzbHOKcPdCC6
 3TYZ/A/gQ8TrwqTu1Fj4Kf6Yk80Sh3ea0elvf6nbizQfoswIaVOUGkkkDj86HYmiyNrBqEJVtVI
 lmCFxbC6g57PJiunbd4TwVgdZMQCc/rPgTmpGG2GKR7oh7BLJPIWUsLpFty6ezL1J+Tha6AXnAB
 dtFsrkamVVtlSyyTnPYAblka8S9woAYOyv4fNvAGL72VBWLNNIhGUnYLf1T4J6zkcg5CQ4OoUYx
 owcyNQzQ4psSdp4xH1A3G92QvHD7doLXkwevz9aM1AcWNa1tngJ8HlNuUmCEJUXub1agSexGiiq
 uphy798e4lln9EyQCbWzJDg9clCvTXLKFJmP2iNiDCOXhsejGaSAliIchnvfI/CJMDqW1lpdgqO
 y2BAu8OEShUbK3EKysj9bf8blC9eQ=
X-Google-Smtp-Source: AGHT+IFrNA6mIeybP8tglTGri7ysS2KNP5LcQOHp9Coe54j2DbCT4lFF6/K1WREKCgsMlClrYK5FeQ==
X-Received: by 2002:a05:6a00:338e:b0:81e:a228:f0bf with SMTP id
 d2e1a72fcca58-81f6f7b1d74mr967331b3a.21.1768265415482; 
 Mon, 12 Jan 2026 16:50:15 -0800 (PST)
Received: from [192.168.15.8] ([101.187.175.172])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-81f46882d19sm6402276b3a.63.2026.01.12.16.50.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Jan 2026 16:50:15 -0800 (PST)
Message-ID: <72382fbe-7944-4f9e-ae32-d4e77bb131d7@linaro.org>
Date: Tue, 13 Jan 2026 11:50:10 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/15] s390x patches and pylint support for functional tests
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20260112131457.67128-1-thuth@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260112131457.67128-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

On 1/13/26 00:14, Thomas Huth wrote:
>   Hi!
> 
> The following changes since commit b254e486242466dad881fc2bbfa215f1b67cd30f:
> 
>    Merge tag 'pull-riscv-to-apply-20260109' ofhttps://github.com/alistair23/qemu into staging (2026-01-10 10:31:57 +1100)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/thuth/qemu.git tags/pull-request-2026-01-12
> 
> for you to fetch changes up to f397b7652dac77bf24a491dfee8def59a5d2591f:
> 
>    tests/functional/s390x: Add reverse debugging test for s390x (2026-01-12 13:56:28 +0100)
> 
> ----------------------------------------------------------------
> * Check functional tests with pylint
> * update copyright year to 2026
> * Some more universal-binary work for the s390x code done by Philippe
> * Fix reverse debugging for s390x and add a functional test for it


Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/11.0 as appropriate.

r~

