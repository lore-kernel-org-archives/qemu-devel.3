Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1180BCA5FB3
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 07:04:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCApy-0000Bb-Ka; Thu, 01 Oct 2026 03:04:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xCApV-0008LK-3H
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 03:03:48 -0400
Received: from mail-ej2-x0f.google.com ([2a00:1450:4864:34::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xCApS-0002pm-Lg
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 03:03:44 -0400
Received: by mail-ej2-x0f.google.com with SMTP id
 a640c23a62f3a-c2a8b9acbc6so947422166b.0
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 00:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790838221; x=1791443021; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=9zH0jVUAWBNsubG5qPAMIcpEHq9TdNqUCh3M6plUd3A=;
 b=VsZZjU8KvOFbAx6HW6we6mJmVbIYBwjSLixTZ7/G0QLOPoMNL5XWsPQ20ZZePSUYjI
 +D1rEyo/MohX1t8VkOAHworHmuAllmVJFKT4HeAUXNwzFcIJajJgg6rh3z5666lnVRNJ
 ZNLxDMm3H6as11g9gAfYY6wXJiUFM2zU2tG8Rm969040Vu8Zl6/xxBV14v3rEYZ1oXXj
 o9Z7932gxhL4R+5jhmAcIwuo6Nv7+SVRxYzEPbCC6mXdm0r2ZgnDrYmvQ2ZshTfij/aZ
 VtB4yR1XLoBXgBsfbbNFzspZX+RDsAtUpqMlgz4+8fdMPp0BAecXOWPW+EdFtavCOJ63
 xOgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790838221; x=1791443021;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9zH0jVUAWBNsubG5qPAMIcpEHq9TdNqUCh3M6plUd3A=;
 b=Zrjnx5RX/hi+fyqPzH8AD+BRwhXF5UnLAJV6ndklHAtPDsJUvEXN9DJLyAUuJNWBUi
 uawz9rkyGiQRJ8Hn35y3vrHNiyRo42Vjzk/SjnfYzFC381oiARIWod3FzxzechkeTbAM
 OdI4kEQIRM7GqVQV5JOQaIUphw6q/Vy5xQGinB74b+Cj3q4YbLq85Pedad91gTNwTOFE
 RwmLg1aJPjPqjF42AsM9Ufdfy6CAF4TCfqSymE/8vBhyK0tftp1gZCr50JUc3BXIozSQ
 xh/eEHcJv3Akhzuatj6dMEmHZXhVVB0naQX260ySZpqCVulEIh6PGRA0KI7HaHHQHano
 ly5g==
X-Forwarded-Encrypted: i=1;
 AKwUvBx4uYeZQnUvDWOCtYHm5+b1xOG87LEJ9LfGa26JunF6Ef+n8HNFPquX1+2LGUesQ7VLgv+DKOGhFDBN@nongnu.org
X-Gm-Message-State: AFuF++mMc/NjvD9uSErq/mXvUMVzv1bFEwMR5EYBFNhQ14YzT7HQA8lH
 2LBGtQ2OyUPNRktfp+LCjwxJGHvU81G7hx95CX0OSboL9k8l/qFeZFWd2dn/2O6JWpllbDtCoM6
 josbN8Ho=
X-Gm-Gg: AYBFou26EuB+PcGGwlVRDCWpnUa8m0LGyssBPee+2hDMqJnrUqxICJaEM6O8dKymh3M
 APK9dzS1uPigm8Hst+Monyg92mFgE1zZg4l1dFrt4FE7YQACVF4m+eqJPNNTKd0tdvYHEmVLLRv
 83vQqAuYe7Ovf217T/2yLzniAzxmfW7/EP5CnGRde3I2PsSY6o7o5SoglG8TLfzEt6nw9wAr3US
 rTVPCcRFlR2n+/xeOXaECq1/b4Bz00nkEjR9rz2gZxqSdZPxVqXP+nwbYC9T8aL5KOqWHsre7Va
 0UD+aSTk5ZmP8rNbRKV20lYVYrXo8I993LHdKva/jDfjirnvCo/ncxvLlMd7VsUTF5FuzthPsvD
 p0+xVBtsxKxF7fQCfkL+SFK1NRAz/7ysfFplMTFpQvBOx5Fx5+seP1P8oZGU6I6vGtnnOuZlTp7
 gdmLvV+j7QywnN3fftVWBQmk9mzLRcuslTWSC/VkRR5+0Rjp8q/v5b2+AxtkDL/ZMUDSp1IP6lI
 UIuJ5B4ksc=
X-Received: by 2002:a17:907:d16:b0:c29:f5d5:5a96 with SMTP id
 a640c23a62f3a-c2e23daa09amr283101466b.32.1790838220679; 
 Thu, 01 Oct 2026 00:03:40 -0700 (PDT)
Received: from [10.70.4.59] ([157.231.30.34]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2e31d36795sm93551266b.38.2026.10.01.00.03.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Oct 2026 00:03:40 -0700 (PDT)
Message-ID: <f83ca81a-63d8-48d5-ac72-2825016b7c26@linaro.org>
Date: Thu, 1 Oct 2026 08:03:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/23] s390x queue
To: Eric Farman <farman@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>
References: <20260930152420.1956230-1-farman@linux.ibm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260930152420.1956230-1-farman@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:34::f;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej2-x0f.google.com
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

On 9/30/26 16:23, Eric Farman wrote:
> The following changes since commit 3876503faff51ce3a132dbbd0ab42c10f2269319:
> 
>    Merge tag 'target-misc-20260924' ofhttps://github.com/philmd/qemu into staging (2026-09-24 13:30:19 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/efarman/qemu.git tags/s390x-20260930
> 
> for you to fetch changes up to cf8299050666ee84ee400a3a0195be7598850e93:
> 
>    pc-bios/s390-ccw.img: update s390x bios (2026-09-30 09:09:14 -0400)
> 
> ----------------------------------------------------------------
> New s390x features for 11.2
>   - enable boot via virtio-net-pci
>   - PCI and SCLP fixes
>   - hardening fixes throughout
>   - regenerate s390-ccw.img
> 

Applied, thanks.

r~

