Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E8B4CCD185
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 12:40:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7COi-0007Ib-1x; Fri, 10 Oct 2025 08:39:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v7COg-0007He-8I
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 08:38:58 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v7COV-0003Lp-ES
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 08:38:55 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3ecde0be34eso1620294f8f.1
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 05:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760099923; x=1760704723; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uuzFyIoAwO7W+bzGbBnrj2kx33yzwhJ3BfNWgxiSw9w=;
 b=tTUjKlXq8jvSL3MV1jnvhMtTafcB2tp8cMr4q2nsl0xsxQqME5FCDn4XU/N74EyIjY
 dqULXZSWs8DajrVigWeXiXpE4LgDQjwzJMqhnsw/gbcnmvUg9tEbBQH234dYnp1OeiCw
 NJMHJejgmMvLQejwVqMnXVYT7jxOpqKllKy6NG98HxQXmVtMJEXxB2pz4EFWzLmg/Qm7
 rmMRzOJoJJchfV4ZI1dkLcx8bmLJL3qr8S5Fxtj0wpzVbuuxAIwrvJNwSJlrj007t2A0
 bdFvR8guCxoBcDjZi7mK+TGKnhAy7WDOipUrSlVRPENTAAmvCyxx7U0vP91v4sk5Ozjh
 Tncg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760099923; x=1760704723;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uuzFyIoAwO7W+bzGbBnrj2kx33yzwhJ3BfNWgxiSw9w=;
 b=su5WMtD74W6nc3H+vY1Togu0KHAwKCrgd74ZxPvVzH5KUOnEnKRtbXXdjQ4mBt53+s
 /cap1zLlkqje4nD5v8PsO6eigWb8wF2ZSnOF8svhw4S/Bnq8FtlhmnGhGQfWfG3YlERg
 sU5nFM0FVnYYatCg+bjpYeN0r6p0UFAXoZwXc8Crm5EBSSS1YiLHveBuwOX0AtAinsXh
 P0sTNQzGlcFWLBkWINwrr+E2WcqE87CZPaWxDq9XxmJMqq5475TWOhAotX/8w+a8kTZS
 SkHuxYw0fo9S0DKJne0WXOm2L8VWzAL1yj9T8Jw2QQ75uNcTphDHYv49jXVE3tSGVC3e
 fl0Q==
X-Gm-Message-State: AOJu0YyLianxcjfcmlumy+mQqUZIWFewJEQeGfw1qDNcQEkqJmNsTBUE
 Tevx3c+RY/QLGgKzv3Y0+ggLIURymzATehh667EgSh1iD9WoK5A0PZu7QqA8WCstW8RdqDTQck2
 LbPEkJiW+RA==
X-Gm-Gg: ASbGncsy+byPtZYdaFgER5UgWeUhGdFnUJ4IfrNKKhrHYs0HhrNyODERZLhSLsCLEYO
 cFf0ROU1OxVy9WwnKj3WOGM5944qDQEim1FIqyXpkxImMcKYY6y+WJLIKj69Mq94cbQuIG6Vf8Q
 VxT9ROhuulyX3LZs4aFiGDHilFeU+JBM7STsuRVpNyvfijUYSN7kKnczgba11yAscRp2dLxJpr+
 Mif60XRJArA3iFjDnIoqAJHvGGQtlenDZCnxwugCHUkXXhqLBtP9r+qoG7yPQHvqsBokaQ5MPdN
 2E23TVrIKTmQkAUWL1xnLcgTeK7u5SAfo1gNDicV/Qfbdp+MCBOpN+9aVoEFoveU9ZkSeVUtofz
 G8fA8GXyEoTNt6Moc6IgZVfLgKSMg3X0SoChfOvJWMohZCP9vtT8vYwZHIbEextbDFgVmev3rEy
 KzH05glZVdYTRO
X-Google-Smtp-Source: AGHT+IH+ZTJD8/+ExpN4VX1UsQkJgg0tMzAd8/lDYzArbnGHNWHIHmo4bbNVEc/K3BT7er3Yi3J5Og==
X-Received: by 2002:a05:6000:288f:b0:425:58d0:483a with SMTP id
 ffacd0b85a97d-425829a5a12mr11307339f8f.3.1760099923460; 
 Fri, 10 Oct 2025 05:38:43 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fb4891958sm48252315e9.11.2025.10.10.05.38.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Oct 2025 05:38:42 -0700 (PDT)
Message-ID: <ca449bf5-a1e4-44d2-9181-128fa56432f1@linaro.org>
Date: Fri, 10 Oct 2025 14:38:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: update cpr reviewers
Content-Language: en-US
To: qemu-devel@nongnu.org
References: <1760098600-399192-1-git-send-email-steven.sistare@oracle.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <1760098600-399192-1-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 10/10/25 14:16, Steve Sistare wrote:
> Update cpr reviewers.  Some of these files overlap with migration
> files, but some do not.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>   MAINTAINERS | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


