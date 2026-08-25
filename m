Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36418C61DBD
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 18:41:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyw4s-0006y6-Dm; Tue, 25 Aug 2026 14:40:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wyw4q-0006xa-Rx
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 14:40:52 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wyw4o-0007zU-Eb
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 14:40:52 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-84f3ab8750cso163213b3a.0
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 11:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787683248; x=1788288048; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=W6Ptusl0fLLaPAewHuXx9dlrfYA78FiqcrcESaj3SuA=;
 b=a6mZReZrbWcYQ6gSOaszpCW1jLisP5XFNwu4FRxUYEYBUb10JnIvNi6DK9TkZMz6+m
 qV2CaGjDSKf4xKGWaCWnbyADoydtVewD7NwFTwMQoAJuzKEJm2f/k8LtF/QtblXJZo7/
 g3sKF1zQBskCJI4rs1YJy2GnXxn1uuWMqOSWTB6jTOo6FQ/98NwUmRcg9e9So3wAEcdm
 4ycIsEgVAzyWnseSSoITflEmfqttxZkWq4sewkrDNKenPHumL30QjZdn+4K8OIdxVEFP
 F9UAvIb+B8I6z+0p9Rs0+q52VUtE5SEzl8GogoO/VVHC2i2OtIf4AwbQNjpAceGbn9V8
 /3Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787683248; x=1788288048;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=W6Ptusl0fLLaPAewHuXx9dlrfYA78FiqcrcESaj3SuA=;
 b=EfKGnVinQxVwtCLx170+kl5TIiKf86A5XvRk7tflRI3G2A+DESS6DoHqgkQCk4WpbF
 GVjAD2AariYcxeA1z1uLCDfzW0hVTTX0GHpXX5dSitb9DCzmUT6VY6SKVVJHefmARMCt
 B6QaZcObBoczvvLy/ojAoG9u7bUug+pBxupC6vlkdEIiNhvJjYSH0PwkdhyXye1C1+8G
 ATaXpaue+PvHP4jVshULlxkF7EX2gQMS0kCwRVYX1q//KDS3Iwj1ZZ99yI//gFgYVahj
 d6pWvW1SVQaHQPdlei90Jxd5L+DpdWCXBPLqY4U7HcUBxegqR6iZfR23F+cD6GT12jQ3
 vJ5w==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqcl2oiAFAGUaiX2gV65CP/lwCc0TQAtAI2id2zIf9G6htYhjvt5hSayl27rFhSVdLWSayBIpHecCtw@nongnu.org
X-Gm-Message-State: AFuF++nG/uAXs7/R90RIFzgXDJPumzexQNgEyzqVj1Pvxpak4yW9N8dc
 ZiVf9iiGQZyWyTxXeyGimZE11klBPduxV/YzGN9b1aNa9FQasOfHSCH7fTcSJ3hY0fw=
X-Gm-Gg: AR+sD12Kv+nbyENJiJaRsPndQBy3w5KYusVZvOz8XxbRdplTWQ3hyoIWZoJssWYuCMI
 RuyOJkH3UnATeaz+Gp7WCmecS1m/QdxIbaF+WRvi/M/8tyfF198SHm0wQRUpzLOTkTIlsxKxXKE
 W3mG3Osg816fH0bbsSYxRzSLxfBHLlot+41169EmFMZ+BHwOMcYuDcjrkrU8G1fQkuOsm1jE4N5
 /1ZPebLihmLRn4UjThNb7dtaQE9X4Nb9F+Ks8rhe+8wiQzVUWTSyT3uFgHBWJdosTR+8WRq0Hyz
 WrJ8hmDxanxnx+mursiPWQfhkZFjjWMrdJTIOmVEmO23o7Tt3QDmdy0Fs/PiTYIAFro8v/YnYDQ
 VPUf85OCDf3Eq5rX+rhcn7LSUTttG07ixFPDpJJkybqJ+5k7bg1zsqfzUY5TVsCnZ3nvhDuSVAX
 iS46d/vC0CaRx945shmJqJtjVY9fLZdNAI3j8R/3HHXu2BqavwiYuv7IUM1xanY08O9I9oN7dGf
 L5hi9g7s5tinwUrGDRg28gmu45q
X-Received: by 2002:a05:6a00:4b43:b0:848:2ab3:ddeb with SMTP id
 d2e1a72fcca58-853757bccddmr1071092b3a.14.1787683248489; 
 Tue, 25 Aug 2026 11:40:48 -0700 (PDT)
Received: from [192.168.0.4] (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8535cf4462esm168622b3a.53.2026.08.25.11.40.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Aug 2026 11:40:48 -0700 (PDT)
Message-ID: <33d75473-8d27-4075-bd5b-e2194d1c5249@linaro.org>
Date: Tue, 25 Aug 2026 11:40:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL 00/19] Various fixes
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
References: <20260825-fixes-v1-0-c59e8a620836@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260825-fixes-v1-0-c59e8a620836@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

On 8/25/26 04:20, Marc-André Lureau wrote:

> The following changes since commit 2be159078ea26feac4c9c9902acf8906f1a05c2a:
>
>    Merge tag 'pull-riscv-to-apply-20260824-1' ofhttps://github.com/alistair23/qemu into staging (2026-08-23 23:04:09 -0700)
>
> are available in the Git repository at:
>
>    https://gitlab.com/marcandre.lureau/qemu.git tags/fixes-pr-v1
>
> for you to fetch changes up to a88191a0caecdfba440682e3c120b439681ccaca:
>
>    hw/input/ps2: say why unknown keyboard commands draw a resend (2026-08-25 15:20:44 +0400)
>
> ----------------------------------------------------------------
> Various fixes
>
> Collect various graphics & chardev fixes, and some others.
>
> Signed-off-by: Marc-André Lureau<marcandre.lureau@redhat.com>

Applied, thanks.

r~


