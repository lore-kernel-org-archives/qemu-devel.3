Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 654CECFA466
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Nov 2025 03:50:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNNae-0003aU-SF; Sun, 23 Nov 2025 22:50:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vNNaY-0003a7-Hl
 for qemu-devel@nongnu.org; Sun, 23 Nov 2025 22:50:07 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vNNaV-0001LN-Ox
 for qemu-devel@nongnu.org; Sun, 23 Nov 2025 22:50:06 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-47796a837c7so24077705e9.0
 for <qemu-devel@nongnu.org>; Sun, 23 Nov 2025 19:49:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763956195; x=1764560995; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wBt0VMh5UNoaAMkYMJi8BaFvkaBAP+iBIRWQUwbCU08=;
 b=Zh9KR1tb24cHqswCZB7tLHrYcdWvj2vgaKM36ZtbzFzKfxJHWdABHxjB9uU3e8DQdl
 j/gQmYALJwfkZ5lDqL0OOEuLE2r1ewvXjmJymVN3E6y3ZMytVp991D+xlXJ0dYuJ7251
 GeSSii0O5NSg3QeCN2OPOoPz51vm3nbERrRB82s2TYXrw2Zq2nbhYvcAwfKjtIlQXV4p
 0egj+DkNxn3+VB3AsGkqdyRMMVPTbzcZJz/qJg66Q7TJmXPG2gNxd4TsKjEtGPZZkPZz
 gCPFhbXgj0PxVjEWJTqE08hDu/rTNkS4OsWvRrt485ELoMs1yE3bnwGsEnIqDqCBna6Q
 C2aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763956195; x=1764560995;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wBt0VMh5UNoaAMkYMJi8BaFvkaBAP+iBIRWQUwbCU08=;
 b=RePh+h/BFcFUcGKSXWlBzV9T6oVSwQVYthmkbGAd73UAeYGGkL0EQtwmqJt7vbDApA
 NK76Z9skx6jZCyXlAZjFXbfLPLYnjRF8RWxAwMdYag9Y2h+w2dLD1b+L8jnn4IaiEES2
 rndUXQXQHvRpbT42E+Fn2LgksrmUMuv/I96AISQXITlLdwjTCb0qiRxAHUu/NJkS3Jou
 ARSXhHQOaFhbHg1qF2kezLM10iQI8tOzAWyEquDK7UY+Z0SUYDJbAeRj9CM9YrYa5Pk+
 LpM+sFQ4N0xcaBVPuD+Cuu2CpOa3JPvF5o6BrWOu2qMLkaLCdzMebFAQAMCYh9nMCh9g
 DJwA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMIKRdyENLjKaC4eD+CJRsh2lZ9Cfxi77dn8Y4rLkG2yWijiXfun97MddfbF5oWk1vE/ZbvMClXgpP@nongnu.org
X-Gm-Message-State: AOJu0YyrrzwucB+xQR9SPgeH17xKRryCVhmgLnzg6PgFD55Ud8fUDaeo
 2/eL/xaf8/3QO/Vi7O4S9eai9KFsOqwCr2iD1gMr0Gw7sSDctunQUMLMgOEYGBLP6qY=
X-Gm-Gg: ASbGnctUK0ABFhAJ1z1/OTyWPxTT57reHse0qiLSac+8KalNQroLuk4CQ/p1qmuvQd1
 lg3wY+7AcBeWDRulPnDI6z5/juYEAAVVaoix6sSfhCPxZAIZdmj/EOdh39r2FOxh6pOefKW5fjo
 Gv4wuVLtuPqFcn6QYrAe/NaQ7vmuMYGllrwkJzqlAPJNErJPuzmRo2N25Jkjh09pOnLuVyFaQNd
 tqhLvqTkOG0AeHv3vL2bwiwnEfrWSckPIR5FgKpLXcTuQripfOL6Muo3kar5XS1ZF7UCLKBX/n/
 Xhs4sLOr7L3dJx5gg9UngycXoM/mtx6giKHRdxQrw/LxeKjyGv1VhcpUmq0Iz7DA9efn1BGenww
 RufiIomFJuxjnG3iVxyZSE3jeP6Ly9sTMFqXwPPhTe8CiW5FjLXmfDCm8uhAFCKPX2MF6SvAF64
 CtdlFJZoWzD+wGmsSZpY93/IhIBpOwZg5CWyt/3FNoOTAMpWDreDyF9A==
X-Google-Smtp-Source: AGHT+IHyFEbCrDVD80J6wd5FoQFK1Ci4HQgoJtloPTcuDXTToUCSy6vNJnI6Wbz+Ya0B6/SJCqj2Tw==
X-Received: by 2002:a05:600c:4684:b0:477:9c73:2680 with SMTP id
 5b1f17b1804b1-477c01bf658mr103227735e9.23.1763956195398; 
 Sun, 23 Nov 2025 19:49:55 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477a9d198a0sm145913095e9.1.2025.11.23.19.49.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 23 Nov 2025 19:49:54 -0800 (PST)
Message-ID: <14dacd31-7d62-4ff1-a013-04dd3da176af@linaro.org>
Date: Mon, 24 Nov 2025 04:49:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Fix the typo of vfio-pci device's enable-migration option
Content-Language: en-US
To: Yanghang Liu <yanghliu@redhat.com>, qemu-devel@nongnu.org
Cc: clegoate@redhat.com
References: <20251121090005.79399-1-yanghliu@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251121090005.79399-1-yanghliu@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 21/11/25 10:00, Yanghang Liu wrote:
> Signed-off-by: Yanghang Liu <yanghliu@redhat.com>
> ---
>   hw/vfio/pci.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


