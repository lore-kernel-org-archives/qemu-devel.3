Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16739CD1297
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Nov 2025 18:13:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIsrX-0001tY-3z; Tue, 11 Nov 2025 13:13:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vIspI-0000MK-Fe
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 13:10:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vIspG-0004ht-Rh
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 13:10:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762884642;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=IepPRqgK1jr/UOoANH4bVxcEIwwE2dFGrKTXGlRzhYQ=;
 b=Nem+sYMzC0mXItEam/hmeFXKnBgfS8IxNM0cNpa8oKlj422zJYFxaS2zDcdLFI1SkeLx7x
 ZZS2zEhfJXuWXNsJkFoAPLifXrtwt7kmQqMgu8P6G7pQPAXzD23t8JER2lWFGZYGWN8P0M
 4mHe+zZkq5Lo0cyft+5ZoU+0HlFzXMI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-elpUan9HPGey_m38bAAmdQ-1; Tue, 11 Nov 2025 13:10:38 -0500
X-MC-Unique: elpUan9HPGey_m38bAAmdQ-1
X-Mimecast-MFC-AGG-ID: elpUan9HPGey_m38bAAmdQ_1762884637
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-429c93a28ebso3310668f8f.1
 for <qemu-devel@nongnu.org>; Tue, 11 Nov 2025 10:10:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762884637; x=1763489437; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=IepPRqgK1jr/UOoANH4bVxcEIwwE2dFGrKTXGlRzhYQ=;
 b=HG7KXjPAN2ODI2WsL0eFuPfeaUM4d8LmBRDirOS4o1uPU8cT7IxFDSCN0TqixploJJ
 ejhM+8hfCgCsoTZUOvgYgne2m+FEI4+mS2JPPVv2IqtMPZ5gmarenJVAkAjz3/rLS7Gm
 dvpf35IagHlrZUoUBiTg+/LlebUcHlkAHut6WYI6W5kEwq2kThrCCze32Vly2z+sYMZZ
 AI7hnDVgmkSK/YP/elyY8Kgfu6kj6Td1FiubX/6JQxGzHABT4pquF/EbOXEWzUPizSjK
 BDi+oWcDntReJMHdp+woWQELwTaR2R231xcKta6Xvs8M0mo5+ryIfmJuPjtTQ/9qy70d
 pKtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762884637; x=1763489437;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IepPRqgK1jr/UOoANH4bVxcEIwwE2dFGrKTXGlRzhYQ=;
 b=M9ITBENa1MuASgFMIehsUEwPkYq4peLlvvM4TwEdlKr9XbQ6DA5QOfIJaHTT52Ah8+
 YZK/aFilCe+URZD8ctGKHqCfui3+tufxls6xf4X6Ruj9/aVLfWHaLOV3zWhhWoA1dnpJ
 8CmKjPut2HCiMX8V2ZpGcg3hwPpPTOkB/mjfqo3cUGg0zsDABQyqsJn/uCN+ESNv6KkO
 i+Ys/+KupOoaHX8mrZcUZ1HYPssdtlLa5KgKM+RaFbM9lvibkjyl1Syp8k1OY/tyxSny
 plm9b6WQZJM15YhYnC/7yxTsg3Yxh/xO13uumE09C6PT5uKUFt1SH/dR3a5riA7HHQ5B
 DN1A==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/t8vsMwW3qb8yjrrRBk7M5WWm1JDTzXw/NinTaetswf+D4tPHAgxlwOQdl1PE2Cbrw9Jr2dWW/0S2@nongnu.org
X-Gm-Message-State: AOJu0YwGQZBc/Sqe0nETuSSeZzr02qPnVw6r1TAWivEBnqH+GDwXwl0P
 lLp5oPVEr+CroLM46DK6OB5y3ZTw0hsdJQNDlmKNnvm64NFOdYYlAmwJnM1G10VgThXyLZZ5G29
 y48e4ogla7Geh1AKgYmyR7Wn7tJZmKPh0nLxu8Hd38SGlwdK2uNcEQPFl4Bbo7BZ/
X-Gm-Gg: ASbGncvbVoIKbCiuliJtXfXOKjjcHACeh5945pTEP21N3oInkllyQlpcOJMHTchYVVd
 4qHt1LKa97OUK7nTk2er4w0YspT0xFSfFsYkRBn+d4cwA6O9sr+4Hmz7fMBRYMC4UaZeGbl1tn4
 Zobn6GZ7r29CK+yg15OZF1HursKRHYbhKPMLgkOjaygD9GtqA7KFD5Hb/SbQ5b7PkjnlEbBvEZF
 J+DI3f8Ir2lGWWqZm4cQYYziRUpxc5VswjPwGp9O477L41o33w6OlZrU72I/GPTPBPyJBji8fao
 L53OLpO3DuZYCqD1qzsJJ2c/11VqOMn16fFD1I0PoRrCeEqJHp0ahLaOxzLdDX6bUDTMv70=
X-Received: by 2002:a5d:5d10:0:b0:42b:3d5f:ebfb with SMTP id
 ffacd0b85a97d-42b4bd90943mr137150f8f.27.1762884637078; 
 Tue, 11 Nov 2025 10:10:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGVfvesgUZ0Zo9rnPPsmfDNpup0423SVZBOkeG1xdiM38JuPRvXpLM+BXYWWTMHPqbRPKtceA==
X-Received: by 2002:a5d:5d10:0:b0:42b:3d5f:ebfb with SMTP id
 ffacd0b85a97d-42b4bd90943mr137121f8f.27.1762884636663; 
 Tue, 11 Nov 2025 10:10:36 -0800 (PST)
Received: from [192.168.0.7] ([47.64.113.41]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42ac679e06csm29121631f8f.47.2025.11.11.10.10.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Nov 2025 10:10:36 -0800 (PST)
Message-ID: <9c9bf493-7cb3-42fd-aa5d-6a8c89e6f373@redhat.com>
Date: Tue, 11 Nov 2025 19:10:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/16] tests: move test_netdev_ethtool to share.linaro.org
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-s390x@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>, Kohei Tokunaga <ktokunaga.mail@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Ed Maste <emaste@freebsd.org>, Paul Durrant <paul@xen.org>,
 David Woodhouse <dwmw2@infradead.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Gustavo Romero <gustavo.romero@linaro.org>, qemu-stable@nongnu.org
References: <20251111171724.78201-1-alex.bennee@linaro.org>
 <20251111171724.78201-10-alex.bennee@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20251111171724.78201-10-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 11/11/2025 18.17, Alex Bennée wrote:
> Linaro are migrating file-hosting from the old NextCloud instance to
> another sharing site.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Cc: qemu-stable@nongnu.org
> ---
>   tests/functional/x86_64/test_netdev_ethtool.py | 14 ++++----------
>   1 file changed, 4 insertions(+), 10 deletions(-)
> 
> diff --git a/tests/functional/x86_64/test_netdev_ethtool.py b/tests/functional/x86_64/test_netdev_ethtool.py
> index ee1a397bd24..ac8a92512cf 100755
> --- a/tests/functional/x86_64/test_netdev_ethtool.py
> +++ b/tests/functional/x86_64/test_netdev_ethtool.py
> @@ -16,16 +16,10 @@ class NetDevEthtool(QemuSystemTest):
>       # Runs in about 17s under KVM, 19s under TCG, 25s under GCOV
>       timeout = 45
>   
> -    # Fetch assets from the netdev-ethtool subdir of my shared test
> -    # images directory on fileserver.linaro.org.
> -    ASSET_BASEURL = ('https://fileserver.linaro.org/s/kE4nCFLdQcoBF9t/'
> -                     'download?path=%2Fnetdev-ethtool&files=')
> -    ASSET_BZIMAGE = Asset(
> -        ASSET_BASEURL + "bzImage",
> -        "ed62ee06ea620b1035747f3f66a5e9fc5d3096b29f75562ada888b04cd1c4baf")
> -    ASSET_ROOTFS = Asset(
> -        ASSET_BASEURL + "rootfs.squashfs",
> -        "8f0207e3c4d40832ae73c1a927e42ca30ccb1e71f047acb6ddb161ba422934e6")
> +    ASSET_BZIMAGE = Asset("https://share.linaro.org/downloadFile?id=QD37GYYAJhGOgVe",
> +                          "ed62ee06ea620b1035747f3f66a5e9fc5d3096b29f75562ada888b04cd1c4baf")
> +    ASSET_ROOTFS = Asset("https://share.linaro.org/downloadFile?id=YAqnr0W8fruDh3f",
> +                         "8f0207e3c4d40832ae73c1a927e42ca30ccb1e71f047acb6ddb161ba422934e6")

Close to 100 columns, but I think it's still ok.

Reviewed-by: Thomas Huth <thuth@redhat.com>


