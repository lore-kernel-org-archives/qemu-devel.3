Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB8BFE7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 14:14:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLjwt-00079s-82; Thu, 12 Dec 2024 09:13:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tLjwm-000798-1t
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 09:13:45 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tLjwi-00037j-R5
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 09:13:43 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-435004228c0so7985715e9.0
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 06:13:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734012818; x=1734617618; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dElJPklpHD3O1sEDGTFJM+XvTU4dW558nqSlojyvJ1A=;
 b=zMEQbkSnvAfXVGOTlfzHOXB7eBv0Q541UN7A6/4WLgnOS/Bi+G+zNKpTZ8mffRCJgP
 wGH3IXWgWJsBCVPuiIjOt7Bj5zEsgn1hFbN4y/2d1flYG6bjdXzZjovGQVms0/+BbLB+
 X9DpkyvDHORLmNYH4PObSk8MqSJZfxSAHQJjZocL3B+/u27QTJV/D6ekCNj8xWGEJFwt
 pmroq53SsFjlo7lnz1YFrSOpL0d1O13L6HKIuKLJF04v10Zmm8iYHlqZ5JTm5i5AeNxN
 +JRUxCBdVsyvYJgcnuH5xwKP8VFeu2f+WsnA9LZY9/RPIRF7K3WqY4j9iy9eJXUuedzy
 1ifQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734012818; x=1734617618;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dElJPklpHD3O1sEDGTFJM+XvTU4dW558nqSlojyvJ1A=;
 b=pzhEtQwhz7pwcnnxh1CN+P8PPOcj6RpVBTMcLvRn1DSnxtMZuETKij0ZahaDoeNZtd
 C2gbNspe7U9GPkHMoCJkNkixhm4RLxSErnRlnaLI1VYhHkI8W3V8y7YQkkQ95d6NcJOD
 +XVPC5wxMJUy3QEkP2borY5/abP9wx/d+SqFTBmGEahqBKJouwB6FYbafn6KNx1omrZj
 Ta9dJecqnhAzve3PMszFNYfFGybgbgMMARpHJQduKY1oAH4SW5x8VsIXE2W3cJWNd4+b
 0j7szCZPWC2rrhp8ppKtAt/m2WtiktGEKKrnnTHoNLStfWUbTK5Zait3ZALIMAHdYPr8
 9Nrg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+fYC0KPvB/Q8FpLP5kzGZ4iUpP98jxdiagr3X833KA/tn4oU571e2d0saH2lxNJsLQ2uMQVfbnCly@nongnu.org
X-Gm-Message-State: AOJu0Yy/6V7GEjEQ64iy7ewF7QYJ2EJu6J8YdO3ZrZPtLnrYq/je1Bv2
 tK27iVlJdn72fHclhqkAvPH4im4QoKIT17r6e+ec7Gwx0yizplUFeiXvBE5rrNU=
X-Gm-Gg: ASbGncsVWRw0zsYbjhk4YremDLbn7eJWvPlPL12dyvwP9xFcC3qFvo4UqGk1soIGlcb
 zmhhW8FsJthvmND57VVI4L3MDl2Rreo2BN9Q2W1bSNGYaG2i4740qwkhgFxm5r23pRaNEm2HQ8N
 Q3/vU/Q+ub8NacA65kApIgfeYLFJd/sahb2aUUpgDb6sQP0tnWSB7qqeuzs5dFRaUpMRpMGAItM
 t6UDGxmpttan3tOZ9qnTUreYbdZNGUbXvivXaKWEqULOPb1KCgdTB7ky/Iygll8D+ehAKldZkhn
 QQ4sO2anQGWjFlGg39EIQA7B
X-Google-Smtp-Source: AGHT+IHW5QF8Tq4SFz3W7TAjsebslLcblEflRcTCcBsTtWRcaU2c/0kzPGDmRPcCJ42u3HuDXKKDGA==
X-Received: by 2002:a05:600c:b86:b0:431:557e:b40c with SMTP id
 5b1f17b1804b1-4361c43d66bmr58749765e9.27.1734012818128; 
 Thu, 12 Dec 2024 06:13:38 -0800 (PST)
Received: from [192.168.69.223] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436255800f6sm17675515e9.18.2024.12.12.06.13.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Dec 2024 06:13:37 -0800 (PST)
Message-ID: <06656a39-49a6-4073-b0be-98b1a073e973@linaro.org>
Date: Thu, 12 Dec 2024 15:13:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] vpc: Split off vpc_ignore_current_size() helper
To: Vitaly Kuznetsov <vkuznets@redhat.com>, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org
Cc: Eric Blake <eblake@redhat.com>
References: <20241212134504.1983757-1-vkuznets@redhat.com>
 <20241212134504.1983757-2-vkuznets@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241212134504.1983757-2-vkuznets@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 12/12/24 14:45, Vitaly Kuznetsov wrote:
> In preparation to making changes to the logic deciding whether CHS or
> 'current_size' need to be used in determining the image size, split off
> vpc_ignore_current_size() helper.
> 
> No functional change intended.
> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>   block/vpc.c | 67 +++++++++++++++++++++++++++++------------------------
>   1 file changed, 37 insertions(+), 30 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


