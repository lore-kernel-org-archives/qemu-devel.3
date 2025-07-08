Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92CD0C83F09
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 22:04:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZGPO-0002ww-Fe; Tue, 08 Jul 2025 18:03:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uZFno-0007H1-Cw
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 17:24:38 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uZFnl-000800-6k
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 17:24:36 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-558f7fda97eso243473e87.2
 for <qemu-devel@nongnu.org>; Tue, 08 Jul 2025 14:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752009871; x=1752614671; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oZ3NfbDweQ6yEUTpMj7i4CrlixtD66ut2JAVvXWwR5o=;
 b=fE2YKpdYxW/whmu/PDFYM+pTqn4d3Eu/Ufg2yqm5b86pF5L2Pka7U1HP5P6BURlBuv
 X0zS4Ar2ttjDX9a1VcxrGavUb2ABfEigPKuiKZMs8XOK2PWYKnWlUZ9JSP512oWipF/H
 BEHdH7+C+Wr1ybViQaBtyRYPuNHso8S5NwjhdombXZkZnLyl7Kvagx+VL1JhEB1xgWaw
 sYw2S+iSG8OcE9X0aI/Q6UHD6+tBRckFgLyDAStNoDKrYemwcB4SQLRHQeNq2QPK8aCa
 3O/yJ6RYBB/BxdDBggHPRLFQd7gYGUIV3Qsiooeyv/qQa7EF5CLgzF2jel5CjlkCHMY7
 YGeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752009871; x=1752614671;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oZ3NfbDweQ6yEUTpMj7i4CrlixtD66ut2JAVvXWwR5o=;
 b=Nu4PL4XK/NEOGykSjCAXFZzXLh1W3u3u7liAahVe176JCB/SYrRO1R28UL8IO1MaZb
 2A4+Ir3pKoP7RYfH6uO1PsNHs4DGQspqSRrvmLof2jinekkG8U0s+avk5NUMX0aBg8aD
 Dyu8U7SCeDjbOngtXqC1Z/HQ2T+cK0+lZENaNKgC8oj9pR0avaC+voy1DzxDa9Amf0vh
 cOC3xGyaVYgTTr0WlJ6GOghkPaokpVWBtFnf8P9M+4a1dyry5qIwG/ysI2zbV4Cmx4Ee
 tTuN/+3Py7+e4yKKxtlRaTTUlUJuWHuT5hJQPnwEINjt4EAuTipGYt6jAOo2A2N9QbRD
 3PkA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXAd7FLBL01Hwifi2X0+5knwkZT4VTbt7cvF+lcSUQKCSu+eO1ETuBtYEn8RtqeUv4dsrf/LTm08ai5@nongnu.org
X-Gm-Message-State: AOJu0YxHVqEcGpcfTfdw4ABlIUPQrgxLw+Ddy88U8EdPatiqyNzdTR5V
 SnfFAxcxEdOw+wrmEoTpE/+UJpg6Vfh7WdXeLwjryCm9hjInjQwB/zcHpbH0ydQ2tTFL7hBG2J8
 /rCKiqUI=
X-Gm-Gg: ASbGnctqgpgrZzeLrBnhJkW6QjVXAN2vF7rCs4tbCMv1zJFWuppIBH7KaD33bW8EvFO
 QsP6pWtn4SCunXHTrTMeDQ0GBuBXJIxdu4RuvO+ywHTTcvNB6QPULefogmYdyE9/kX8z1ug7Wrv
 hMCAuPvzJnSoLLWJAOScLXNyTwFPXJOlteSPV2HoeyJTdSD3OakeqaiANP5KwGZId9XR27KxJTl
 6spWNm1yQeX9NDruU8k0XXf6xdLrFojLQlEBeSmC8qQNUzSmk01olI3tTxktKoEDvCDBSURT22F
 PfbkVkK6K26o5VKS36cBQ1/Dx0aUT1MCy3In1pyilB48JbRlpaYUC240AjU6ISGVTEIcfiKaZUy
 JNEzqwdnUBhFJJi9i9BwHt9EtoW0htg==
X-Google-Smtp-Source: AGHT+IFVN617IjCz5Ko4jntsVdELqgBtdUJKO7CCtiJsZ3niaxeguWDoU8ObyrjiUyXCv+nPesX5gQ==
X-Received: by 2002:a05:600c:648a:b0:43d:878c:7c40 with SMTP id
 5b1f17b1804b1-454b4e769e4mr149037895e9.10.1751958910511; 
 Tue, 08 Jul 2025 00:15:10 -0700 (PDT)
Received: from [192.168.69.242] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454cd44ffb9sm13087135e9.14.2025.07.08.00.15.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Jul 2025 00:15:10 -0700 (PDT)
Message-ID: <7669d561-4491-4074-9e56-8095ff91e489@linaro.org>
Date: Tue, 8 Jul 2025 09:15:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 3/5] tests/qtest/qom-test: unit test for qom-tree-get
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>
References: <1747057635-124298-1-git-send-email-steven.sistare@oracle.com>
 <1747057635-124298-4-git-send-email-steven.sistare@oracle.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <1747057635-124298-4-git-send-email-steven.sistare@oracle.com>
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

On 12/5/25 15:47, Steve Sistare wrote:
> Add a unit test for qom-tree-get
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>   tests/qtest/qom-test.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 49 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


