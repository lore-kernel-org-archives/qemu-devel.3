Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DBC7CA0EED
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Aug 2025 14:32:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upSnR-0004QJ-Kr; Fri, 22 Aug 2025 10:31:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1upSnL-0004On-AM
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 10:31:08 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1upSnI-0001Ok-2z
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 10:31:07 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-24457fe9704so20811415ad.0
 for <qemu-devel@nongnu.org>; Fri, 22 Aug 2025 07:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755873059; x=1756477859; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=goUcwQz4szYtNXGwS+WJVyvlIs1Z0UiVC7chkpwC7Aw=;
 b=CRzlJBsBcN5O1PffrTHxhuL4khGYU33ZpEqaRcxUpGHyIaKKEwenIzKEuOXOQO9C0e
 HPeXJ6HV1Cw6zp/35QIbIZv9gh7PS9Vp6DQik4s8SX0Sqr9yIHdPumTequ8YL3rgOoY4
 QYoIlH7v7hVw0Ck0jcGniLSioL7fShxTSiSmxGXAVtYVo8N9GrdB36uzRllodl0DVl+U
 7OdBR3CxB0l9Y1DnK7kTOWX3IkXmDgXvup50ls3gQuvzTPGy4ieXBANugXslvS9mIZkm
 ycF0zyfGUIkuR/Kl7WfqH7RxMSEZlrKxmugVol7BgmsFp+SZifLsXO9ErgZKU0PIxKLL
 PJNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755873059; x=1756477859;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=goUcwQz4szYtNXGwS+WJVyvlIs1Z0UiVC7chkpwC7Aw=;
 b=K5DYHJBMF4qPCzzzbdODiPrM9jHgrvOGq8NOfX4UGNjxT/bbZZXMPbh54LQcE6OIlT
 MSliaYcYBxndaF6msX8gMjDrqh6BegOa+DFiJL2ajH4k3KDryvCEqAocwO9NCI/w6/XV
 GsKv0y09og8xQi+ZnfG94NJeAdYudhc8IfIqbkf5Ct6IKgRTPVCdCW/PNQJqX0wG+CAW
 ROdQMJVcTr6fW/6z0QZNYF4L6ki3gs37JazxY/fcDnonfsfZJjkdRxqkLmU2CGVFQRtf
 36HMImbZoVW1tdBHmhmxuGAz+AUz+fhag4vCaVVM6D1P+jfrQAwHa+9ffthw48oeA/qC
 edsA==
X-Gm-Message-State: AOJu0YwDjxbaoGNaWDp5eN33PIPSU8qQSk+LtFYuxc4n6nxXZ4iInjUz
 Uf224pyJMdE6OOOUvy52fP+K4Mh+IZ5LY3lDpFFy3UYrwCURiYpuvZEPV+EhxlhgDLQb0yzUaer
 Q8GhJwQuhzw==
X-Gm-Gg: ASbGncu21q+8yHofCserVixb4ZyIl2GTkRpGlE0u3bI9uCbQWTqQ3QQEvje+fqdL2Ix
 jxd4fCTlJxNEJ5/DBbcfN6fBGWdzKNZkGTQBeFT+GN8rGf1/vdPfGBexHlj2dTgYXP92ihnX43f
 2eXlXgSkJn6UUmHC40UePrvuffTZ24nwxWWloWw534M72Da7HLPud88Yy2uwlrrwNBt6TcwOkZQ
 J8Sh0hn7UPPd0jafmWdCz+U9JkyWa5EMaccVCH5qrCMPACKvLNAXq7xsAzTycStmtr8KPgS2+mf
 Fb9TmRphUkxBtzEby4h1DmGHbMN7eFYmPfgybidmH/ujjAr5lTFISSt5OYYyhYiCXxyhVGt01lL
 tfLYX8KoLSZb7hjVt9VmEQhVQkv8FI6I+wnE2
X-Google-Smtp-Source: AGHT+IGvWHnOS0jJ6akkccOlgH6nhm2YXrPO27yTY8p7dAA+bi9YTdrTPHJmkRXtWrlBBaAhn80Pzw==
X-Received: by 2002:a17:903:943:b0:243:47f:c41 with SMTP id
 d9443c01a7336-2462efae4fdmr41825865ad.57.1755873059155; 
 Fri, 22 Aug 2025 07:30:59 -0700 (PDT)
Received: from [192.168.1.111] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-245ed35bc19sm85910025ad.46.2025.08.22.07.30.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 Aug 2025 07:30:58 -0700 (PDT)
Message-ID: <f35d1945-3995-4ce3-8992-c701bdf965dc@linaro.org>
Date: Fri, 22 Aug 2025 07:30:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] single-binary: compile once migration files
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, philmd@linaro.org,
 Fabiano Rosas <farosas@suse.de>
References: <20250730220435.1139101-1-pierrick.bouvier@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250730220435.1139101-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62e.google.com
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

On 2025-07-30 15:04, Pierrick Bouvier wrote:
> This series removes target dependencies in migration code.
> 
> v2
> --
> 
> - rebase on top of master (one patch was already merged)
> 
> Pierrick Bouvier (2):
>    migration: compile migration/ram.c once
>    migration/vfio: compile only once
> 
>   migration/vfio-stub.c | 16 ++++++++++++++++
>   migration/vfio.c      | 14 --------------
>   migration/meson.build |  8 ++++----
>   3 files changed, 20 insertions(+), 18 deletions(-)
>   create mode 100644 migration/vfio-stub.c
> 


Ping on this series.
I'll be out next week, but it should be ready to be pulled once the 
trunk reopens.

Regards,
Pierrick

