Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8558EEE020F
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 06:14:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soGbQ-0006Af-HS; Wed, 11 Sep 2024 02:13:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1soGbO-0005wh-M5
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 02:13:18 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1soGbL-0008RR-Im
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 02:13:18 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-5365aa568ceso6341095e87.0
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 23:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726035193; x=1726639993; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=J7LpRf93BAnXiOmKt/ZSNjq40Q0BcySlR1uVQMFuyR0=;
 b=yt4qLpqtXsswwy8QA2O/u5GSAf4Q18VA/Bt690sAtDmb4Bej5emAkBpOQ5AwZH0k5v
 VdcmnW+TCUpk638dd0hfvu/nD/kQtuiLsFd1jgZeESTfQQggUBomeB576KDh9fpVB2mb
 IF80R2h7ZU1YnzbgBSjw0Hq0n1BflfCGRzrX9YbRj1cTwqQmo+fasMesRIbEJSlKXeC1
 3BD4uYQntIbm/l5pMs+CrWPEFZy7ezRTpiFvISntZAr9MK5fgckqfJaYP6IHqtj2PZzC
 Kby9VEBfT7Sg1uWpY6OcyZuV3kCBsXWkcQNLmTyde4ZDkT4ET9y39aZjVA/8VZfUp+i7
 Sejg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726035193; x=1726639993;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=J7LpRf93BAnXiOmKt/ZSNjq40Q0BcySlR1uVQMFuyR0=;
 b=paCAY+aFdYhEQmY9gSsk9jFR5/YvB2WeamwqA9QPSESMX6xiW7uWaTtBXroPjB6pgU
 5WCye50MKIkg4pMt5yF9HotnbGx2GgL3up2GB/lgPyaKYEkBVNoIYtkloO/ufaNDOeaP
 2l4OPE6oWGKjq9JZJ1kTwpeYRlpsvZsMj2E84VtLlVlxDxiWWAExifO9TxgXvxom7Ipb
 ErV0IybbfBFVyZnLon6FDO+7/n9JNFb5xDVVA04sgzQTYhUVqrIVOyZGow/hWfJ9i/9J
 mE9oT6NHTolcrkHjqU9M2JOUgH42ghcKujDVyPqjCNZccMY7UOWVfAk33BUztnXwiWkg
 z1aw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWe4vni4e6BuP3YWImDKSOOwvr873iQ+iyIAwfd4G9dNDwrq6xU2LjshywEoH6C5HYACkWkUpO0s+Gf@nongnu.org
X-Gm-Message-State: AOJu0YwMFTKAztEB5p0JCcK+rS3BZJW2Bo74k+L9WFKZMqpXo+wnjOlj
 91jkBbYf4y5FQWvLTOxY1KKCHeX4zpXq+6Gq56EDzPcgdP/5x8+qi46HBGT/wYs=
X-Google-Smtp-Source: AGHT+IGgGKQ0AEU6HNcJt5DsM3mDmTwInbpRDGWNVq2w7Th+CmIVLvrwWJibFdq1qjuzb4izFD22Gw==
X-Received: by 2002:a05:6512:1048:b0:533:4620:ebec with SMTP id
 2adb3069b0e04-536587a6885mr16134873e87.3.1726035193184; 
 Tue, 10 Sep 2024 23:13:13 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.196.107])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25979e90sm573426166b.72.2024.09.10.23.13.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Sep 2024 23:13:12 -0700 (PDT)
Message-ID: <6efcf085-2118-4d70-b31c-56536179c615@linaro.org>
Date: Wed, 11 Sep 2024 08:13:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 28/39] hw/misc: remove break after g_assert_not_reached()
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, "Richard W.M. Jones" <rjones@redhat.com>, 
 Joel Stanley <joel@jms.id.au>, Kevin Wolf <kwolf@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Corey Minyard <minyard@acm.org>, Eric Farman <farman@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, Keith Busch <kbusch@kernel.org>,
 WANG Xuerui <git@xen0n.name>, Hyman Huang <yong.huang@smartx.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Michael Rolnik <mrolnik@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-riscv@nongnu.org,
 Ani Sinha <anisinha@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Jesper Devantier <foss@defmacro.it>, Laurent Vivier <laurent@vivier.eu>,
 Peter Maydell <peter.maydell@linaro.org>, Igor Mammedov
 <imammedo@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, Fam Zheng
 <fam@euphon.net>, qemu-s390x@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, Eduardo Habkost <eduardo@habkost.net>,
 Laurent Vivier <lvivier@redhat.com>, Rob Herring <robh@kernel.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-block@nongnu.org,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Helge Deller <deller@gmx.de>, Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Yanan Wang <wangyanan55@huawei.com>, Peter Xu <peterx@redhat.com>,
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>,
 Klaus Jensen <its@irrelevant.dk>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Jason Wang <jasowang@redhat.com>
References: <20240910221606.1817478-1-pierrick.bouvier@linaro.org>
 <20240910221606.1817478-29-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240910221606.1817478-29-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x133.google.com
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

On 11/9/24 00:15, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   hw/misc/imx6_ccm.c | 1 -
>   hw/misc/mac_via.c  | 2 --
>   2 files changed, 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


