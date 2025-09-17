Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39DC4CAC59A
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Sep 2025 22:34:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uz0iw-0006F5-3R; Wed, 17 Sep 2025 18:34:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uz0is-0006Dq-Qw
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 18:33:58 -0400
Received: from mail-qk1-x72d.google.com ([2607:f8b0:4864:20::72d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uz0ir-0002z5-22
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 18:33:58 -0400
Received: by mail-qk1-x72d.google.com with SMTP id
 af79cd13be357-816ac9f9507so149315685a.1
 for <qemu-devel@nongnu.org>; Wed, 17 Sep 2025 15:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758148435; x=1758753235; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Sylxd9R0V43b2OH+XEE+hRK0+lRRVBbL+2xWoNnLtFI=;
 b=SplP0zm6vsxR7vsiFw37MDjJJVSSYsWxHwxa/xHUUT8AhcrMH9g4F2ccyjCXv0aY//
 /jqVKjT3B4WgYF4yce+d5z17/QluT8wbCR39WZ8ez4qifT8vgH2S+v7t9HBEu42TUv94
 0iy94BKVHR71jv1Lowy+hb5O7jS35hhMBUrNVUC8m9sbxXKT+bQJtx/8rvqliMhFqmsj
 l0wMatSQrczUJeHKn0qfH96FkolqJ3kuy0J/9O87bZiHDrnbfAIN2K8p+Nhb9aN7n0v/
 kzUddeqMJ9WqD4sHR6YRFzqUUBAA0pgzeYx/UZ1yNq3qvyMFeAHaJA2K51t9Yy/N8nco
 PjKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758148435; x=1758753235;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Sylxd9R0V43b2OH+XEE+hRK0+lRRVBbL+2xWoNnLtFI=;
 b=ibSp/gyqnYhJJcuUPOMnGMjnl2wcE5BQiiCYoZ3LVMmnqpe00X/FsPuSCdqQ2kEz4+
 cdlM0vPB+6isogQGpLJ+KqMuVKJz2Idi0X/6+XBWA7aI+qwPqB5nk3n0KlDzFxb0j8vb
 95yjtcHodXqxImPS2r6I1Zy0oyZG/LK0uxhsosAwEl41Bgm3rN5aptWS5Y8lRQ0BXZwk
 LL6QLPeapjlMHaqegLWmg0zSVqB6IxvQiMP992fbGGEb4oGMOUv+liOli6K1COqrI0N2
 HjxMzeSRKKPU7AL/UaLQlQ3iocakQWZqfS8Ta3eSxknnI8XQWEs28l0NSxqJswJDrNTG
 xUXg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWAcmkPC4SyVbeowitRrwOw9td8nojK2b4GlzGrNqWkv4VpJKOTgHljYZGu1LEm7I6qMDSHXiIgQitZ@nongnu.org
X-Gm-Message-State: AOJu0YxZOl9xpWaft7RxgtFTpIoIJZH9r0kQvgP6oEUVUOLgmJJjtp5y
 7E3LTUZdZA89DhXrHHRpwODnRjTzYbr/O7romyxFO6PZW1y11fQiY4rKgBekYZ6x0BVlnwHBrvh
 qT7ZP
X-Gm-Gg: ASbGncvPerLGKJbsg7xe33vAlQLpOErLIE8KydO2tDduIKVkPaGSbzgMwDnS86TCCM5
 51tYV6Xj11eNxoshMhqMaon4smLoAQIrKwEGwsWcHLGkLywAWGQGDtB2ApN1mLGc1l+STtNrOwp
 YZxbV2pVen0g3L6ipdVKjMdk+w6xXKmaHIAGXBvjbssLfXZ/vQnMEE2BAFTjNrbvfTP4xccYZKL
 LAcSMkv2IolId+5i7Csy/j7L/7KnzK/r2DAA5Ro1ZHrwbdKdTo7gApE4OWc+acdR8i2bBc6JAMe
 OaXQrUphRT/aOkiCfYvmumyqnYIjMLxyK96PY/yW4buE2BVHdK1aUR+N3sT4jM0bzHyOb6n+dMq
 pdkf1XJNy/fW5Q3SZLhr0Su4i6lIfFszYL+RVtC2CL3DuoPpHzdOfiKg=
X-Google-Smtp-Source: AGHT+IEu1QC07Dv7I4exZ+Oc7cxmI/VYv+m2s2Z7kvVjU2AR/ODVDtI2NOnH7pnA+IuLpk5JidDc0Q==
X-Received: by 2002:a17:90a:f945:b0:32e:6111:40ab with SMTP id
 98e67ed59e1d1-3305c591a46mr1220044a91.3.1758147821422; 
 Wed, 17 Sep 2025 15:23:41 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-32ed26a9993sm3437992a91.11.2025.09.17.15.23.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Sep 2025 15:23:41 -0700 (PDT)
Message-ID: <b41dbd62-4641-4b59-8c81-924ef3f7b95f@linaro.org>
Date: Wed, 17 Sep 2025 15:23:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/7] target/sparc: Relax decode of rs2_or_imm for v7
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org
Cc: atar4qemu@gmail.com
References: <20250905115128.376295-1-richard.henderson@linaro.org>
 <20250905115128.376295-8-richard.henderson@linaro.org>
 <7b88d9fd-ba71-47be-b8c7-cc325e179dac@ilande.co.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <7b88d9fd-ba71-47be-b8c7-cc325e179dac@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72d;
 envelope-from=richard.henderson@linaro.org; helo=mail-qk1-x72d.google.com
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

On 9/17/25 13:42, Mark Cave-Ayland wrote:
> On 05/09/2025 12:51, Richard Henderson wrote:
> 
>> For v7, bits [13:5] are ignored for !imm.
> 
> Should that be [12:5] here?
> 

Oops, yes.


r~


