Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 507ADCCD193
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 17:58:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAu8i-00081u-6B; Mon, 20 Oct 2025 13:57:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAu8f-00081c-KA
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 13:57:45 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAu8e-00048H-0w
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 13:57:45 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-46fcf9f63b6so25070735e9.2
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 10:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760983060; x=1761587860; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QC4fy6Rk4oJr0RT8D196WRp8Eid0gaDOgS1JjoVfAFU=;
 b=WIx6KRlZkohiXqn70CVZk5q3Q2FXq0Z1cGEiR7RTcXDmMm8UMmz8He52JXNrnrjzjP
 bdcLcm6rnkMqtIem7oKCKTU6j4vY3UvsE6X8eRcts74H4qdOdCSDrxidbMevm0n6Tt6Y
 TINLJTveJwopWoZd2sgPOAANIzAilGI1IIbsAA1/CnQggEitBptwUq4BCaDcfUy17Aks
 MToKTQy7kP7TrJYuQNuMxAJkjkTga+qTDLjRlhV/qMFyHdEIY6RlZ2M9kHtA9tO+LZ5D
 qSLbQgbdae7unWJWphuApu+Bqe641ughIswdEQ2xW2HUylJfHOotI4lp+nykWf7VVO9n
 MchA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760983060; x=1761587860;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QC4fy6Rk4oJr0RT8D196WRp8Eid0gaDOgS1JjoVfAFU=;
 b=s7mZZgtv3upxoAnKr7QQS4e2Vn3Vaz5ej0EzSkmOeqGtpnkjz4RcwW5qpXpgxFt277
 62abPsImDyhXEZsOJQ5LMTvorBQnBlPyHWQggoA3b2ICYgml8Lz8leb9/guANd7aXzBG
 IbnZ2/nSWutr01fpPnzrTGBnnqNALXupBolHiUp44tm6KnDyMJk4vGo0PBfeqfsnXrvT
 rdACAY5jf21DAulBNvYXljdY5mTkzrYwW+h8zpE/UtjXESVMP+aaj17CkU6rY12cB+DB
 aYF5+VXcLflJ0SuEdN8MgAXnduRA0DbuLMG2afriDa/V3eb0KF1Xn/QRJAyReTf7hKbR
 KTTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXNW/HSiEiwAXdEZncfXkloCwxNtAybydmkQD/wNJ64ZrgRtIwDJVt+h1GgHUslvbI5uQ5xpZzgaX4H@nongnu.org
X-Gm-Message-State: AOJu0YxcoU/zo4r5Mu+ydm0oHefMkz+FV5h4xHZEG5ZPU691/wK7VDk4
 1Xpwh2lwKXYye9gf6eUGMkcUCRevRXGHMv8knVMizKYHWlyFIQFVf/UuvTWTBtHKQpg=
X-Gm-Gg: ASbGncucQxY6hZN6n9ZXVc4Vj1GIY9loJFR8589KBaCzq4P3f4uzjEPzHLV4cD9iWyf
 JhrHB21twc3VED9EcvN9TSofGQ2M+uV2OcLffuPve5aoG9dP8OB7pNMn7x9/tuYbuqUBfgtvTUD
 g5NmIKWkQf2GNCFaPLXDLiI40ROILNTYAXDzapFvOLcOSCf4mkhMyAx5XgVMDYlGMBZ2RNHkvXB
 4fvZzVGdEH2JZSpp6qHy1TJvIEawQTjsTmdt0bmXl0GX4yQQedUzAFL4+l1ba9PONGE5uSZ8SdR
 Zlx4MOOadSG0yKfiA6SJJzTyrjjLhnn9n0JM0Epot6BT80qGUBrJDlecOYVeW1AhYZk7ebHoVJr
 lpshw+xuPl/R6XFTW+Fy468yLUOIP0duV8zLgIqR7MiIKdn5JQ4LywiInxDQ+5VfeL6Lw3P0d/P
 evmZk6IpUitQmLg35Du9mw7aE+LdU77SICu2LKVsG3WpcOcEbPxo0Xhg==
X-Google-Smtp-Source: AGHT+IEqPs/K0yjS9ReXNNv+PoSxYI5svfpCTA9SVmr76ZvPEpjoVA8ThjK9WjZGsqNkSyBj+59pTQ==
X-Received: by 2002:a05:600c:6095:b0:471:95a:60c9 with SMTP id
 5b1f17b1804b1-4711786d054mr113832905e9.8.1760983059922; 
 Mon, 20 Oct 2025 10:57:39 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-471556e1892sm153262685e9.18.2025.10.20.10.57.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Oct 2025 10:57:39 -0700 (PDT)
Message-ID: <fedd5ea5-3398-49f1-bf15-87d14d9e0c5b@linaro.org>
Date: Mon, 20 Oct 2025 19:57:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] migration: vmstate_save_state_v(): fix error path
Content-Language: en-US
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, peterx@redhat.com
Cc: stefanb@linux.vnet.ibm.com, farosas@suse.de, qemu-devel@nongnu.org,
 armbru@redhat.com, berrange@redhat.com
References: <20251020160344.2401137-1-vsementsov@yandex-team.ru>
 <20251020160344.2401137-2-vsementsov@yandex-team.ru>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251020160344.2401137-2-vsementsov@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 20/10/25 18:03, Vladimir Sementsov-Ogievskiy wrote:
> In case of pre_save_errp, on error, we continue processing fields,
> unlike case of pre_save, where we return immediately. Behavior
> for pre_save_errp case is wrong, we must return here, like for
> pre_save.
> 
> Fixes: 40de712a89
>   "migration: Add error-parameterized function variants in VMSD struct"
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>   migration/vmstate.c | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


