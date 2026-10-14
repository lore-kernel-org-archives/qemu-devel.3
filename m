Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FE72CC6B2A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 13:32:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGz4q-0003oK-C2; Wed, 14 Oct 2026 09:31:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gsh517025@gmail.com>)
 id 1xGz4o-0003o5-7v
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 09:31:26 -0400
Received: from mail-pj2-x0b.google.com ([2607:f8b0:4864:39::b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gsh517025@gmail.com>)
 id 1xGz4l-0005Em-JJ
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 09:31:25 -0400
Received: by mail-pj2-x0b.google.com with SMTP id
 98e67ed59e1d1-3a84a12aa97so95046a91.1
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 06:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791984682; x=1792589482; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=krV9bZqp1uGdZgEnrbDhc7M2/7tmVFJKekcwwYxBAYk=;
 b=Cs+BSnDblTYLsRg/KbkuyAj57Lhk/c89xrshqNI+lsdd3EV9KTFIZerA/yBbVNhJV7
 RA98Iru50bVAKg+vXmk2EGetCU58jsDoIVdUW7tn88ruuuRsruFd2eQZovTFhNJkwRfi
 qA7FOszgK0XcW/C3AU0V/J66+IguFW/vo9OSmJRACW0ZAIPyRoi0uzP2XrHUVtS1cqig
 +tjMyeH5jy5Awhz6Kn+rb+7TqzOAQrpbMtN2siUq8MxtUfyTCcQA0fukzWxY1t1KWlGk
 gRRlJpHwP3/mDWz/t+tB0DbS3O6lqO2lsAJQdcc42QNPnf9mI/jZRxhR4q6KcHeYVhrl
 OH6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791984682; x=1792589482;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=krV9bZqp1uGdZgEnrbDhc7M2/7tmVFJKekcwwYxBAYk=;
 b=sy8+8x6pxyvu0pcbhLGmyLvHuaqlqyD+/EyHuYkbhL0T8k1TfsbcBumCLPkVGyW5Zp
 p8D7DINlRnROctpHjrlxYE1pKlDc3HHbiAJaRccIrQxdj1Rc6Il4W5y79IimdXFLEkxg
 eyenlSoDq3pmU/OEHlf3cgaPAy0UEy4oPPkHFqSHRL7dlKo1MEZZBqBrokHo2/a947/U
 cFfHkEfZ+9mesXQQnt4qqdIUhN1HKoM+L5BGKStNjGUof+ObBlFrgyD1yom6bSCFqLgF
 3fRhi5jiAQ/Ww4V1adUMKCSvbMa32LTCVDw2C3rr8UjHspZXRLWb5dS64zqyop/VJ9N+
 vvJQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzFqynnksSgfIEeNKOU2pydHP7du8YdrmtyFm1SdicYKx5dvBRYU82S1ff9TZdzXQclj2UvU4WhoL76@nongnu.org
X-Gm-Message-State: AFq9FYKlJ4/aHfwnG4pIzPn8eJNOPHCqZrmRH0UXvs8EZhWzknTUOmRw
 u2hV29FjFItnEjIkxmcep6/cmM1lDdK1Ysn7Dp7erUTIeCPwWBYMLnTCVyzApp7VfEltpw==
X-Gm-Gg: AYBFou0FTHLoD8dMbt0WfK0LZ0Tb2gQjRpQZq6Duw+Y6hO0tyobyAx2Olt5AuB6d6S0
 N9yT+6DBnbWmoRIz7XuuQkIDWcnJsNmfZo1rQ+M3e0//5pnaEgKUKMDT9ZL+xpHg86HdoT5xMGl
 EW1OYazJhYM6XMvfZRTxcKPgTRw+/0vCL8cRPkcXwFyK1oSNTuNTo6OqPawY5Ds55v7k1fVWjWY
 PWo8rSEaxwwF7H74ldlnUpzKpQp3iiP2im1rSXlVEHV+rEmrSK8sd5Ww/pQeqTl2Y98knkttBXm
 5wWJbg71TAk4n+TbiAv+f5bG0O2t2DmPD+ICKITtqcv10rnyi2x4BBk1MzBXR8P3dzE8u5kUOD2
 hmL4fMV1SZFOhfqthDw+YHWj8MxYDTwZ2ypuK1XwaJgLlUOdBz4ll3uvJ5Y/8grf0nfAPAy/33r
 ZXsvIr0mUDkuLZzYYafvbhbyDFAHI2ck5XP55ruhPz7YhtkFqz4b0HyZd4VtnaZnxpk9t9cg5ig
 2Na/2v2kbt3kg7sm7s=
X-Received: by 2002:a17:90b:57cf:b0:3ac:8527:3fb9 with SMTP id
 98e67ed59e1d1-3ac852744a4mr553615a91.64.1791984681384; 
 Wed, 14 Oct 2026 06:31:21 -0700 (PDT)
Received: from [192.168.50.100] ([111.199.56.250])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac7c79bb59sm951860a91.1.2026.10.14.06.31.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Oct 2026 06:31:20 -0700 (PDT)
Message-ID: <c53e02a4-95d8-4a51-82bc-043b27114b5f@gmail.com>
Date: Wed, 14 Oct 2026 21:30:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 01/14] linux-headers: Update iommufd.h header for
 RISC-V IOMMU nested translation
To: Gong Shuai <gong.shuai@sanechips.com.cn>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Wu Fei <wu.fei9@sanechips.com.cn>
References: <20261014080005.548066-1-gong.shuai@sanechips.com.cn>
 <202610140811.69E8BqaU098670@mse-fl2.zte.com.cn>
From: Gong Shuai <gsh517025@gmail.com>
In-Reply-To: <202610140811.69E8BqaU098670@mse-fl2.zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::b;
 envelope-from=gsh517025@gmail.com; helo=mail-pj2-x0b.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Apologies for the separate email. Due to an email client setting error,
the thread was broken. Here is the cover letter link:

https://lore.kernel.org/qemu-devel/202610140811.69E8BN84098054@mse-fl2.zte.com.cn/

Best regards,
Shuai


