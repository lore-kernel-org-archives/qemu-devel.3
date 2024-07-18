Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9B92C3DA63
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 14:46:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUSNy-00011E-32; Thu, 18 Jul 2024 10:45:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sUSNl-0000v3-0G
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 10:45:32 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sUSNi-0003wd-BQ
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 10:45:20 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-367b6e5ffbfso486876f8f.0
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2024 07:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721313913; x=1721918713; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PRspVrcL+/8oEqUxxNYp67onkT/Vkb9gpb259qmWb2w=;
 b=GbKdzphTOjuKOhfUZTIsklHau8PldOXSo70ZD5sI9b+62LzNqLmBNd9bJLq/VLs65y
 GTwSDbMBxWYuCQs/Oi3GDDRK7D0cQjO+gAv7MGJg0Ui0XjZl6EeaSs7eCEWcHIn1p3Yv
 anPx9+QXaZzdmeBum5g740z9KlRbKJMh9FNuaTGY0RK7qKC9cEHOjwpZvyKUTrFBxUhM
 oYQ2IrKUrtekrA1PgteR4y0lWXLZSNutHtwDNP0HaYVbR+31olopZhdQBMq6N41f6YND
 6m5HWUU9W0I0aAfJydgWBPIP1PVBbPsr/b3ASQi6iUWUBO9Ga2k/2QDgFkVjk4P0EV16
 Fy8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721313913; x=1721918713;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PRspVrcL+/8oEqUxxNYp67onkT/Vkb9gpb259qmWb2w=;
 b=kEcIx2JIDrOCZSvrKs9FN4Ng0zYZkDYdX8TMX5RkrIblMfX8nKJTyz1/7x7eA1Ccba
 L/9ErPbz7maMYUPfJ+qpK5Iehad/21URPoIxjN4vD6TAZGPT/Qe8ABjnp9mCjy/qkkLE
 7mMR/IAoQRqKTBeN9fNeoZj73riQ06zl+cETQYykKk7kC2Zc+L1/vt2LUW2Ery/HpPhr
 195kGdCdH53Pg9y6V8VNzXd+Dn2txZNUIaeqkvRGzLV/oBRxzDEdppRirxzL35fwnV7Q
 XoVeaPY+qCzGR7+lJ7ehuRZ2XL3OkuBHak+saWSFDNXkDd86oeq8mY6vnsCid6hDTniv
 cz/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVS4QqrHKIo6zAYENgIpa/tmCp3xcJHRBudQPPiHhOySzWeamZ5oUYRcDMPjWn8h4MCmjgtNKPPUExRnFbZfOeyYpDoT8E=
X-Gm-Message-State: AOJu0YwAsqBcGCrlpUWiKf7Fr08rXJ4E3hPUqlJBcEKx2B/9o1zAXUPI
 TfJHUt4n6aZzOjRt7EnvVZsI34nXBJrQq5L03273tC8zTTsd20KE/IcyzfrAn4g=
X-Google-Smtp-Source: AGHT+IEXcrjLFyWQHXsktr4EPw085AiiIaGVRONDiW9EWQcFjO4KgmG4TdYtwNr/Bet50mvftdgvqg==
X-Received: by 2002:adf:fa4f:0:b0:368:6596:c60c with SMTP id
 ffacd0b85a97d-3686596c6dbmr920902f8f.30.1721313913074; 
 Thu, 18 Jul 2024 07:45:13 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.173.113])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36837dc67d4sm3850007f8f.16.2024.07.18.07.45.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Jul 2024 07:45:12 -0700 (PDT)
Message-ID: <85b84ba5-ad69-4f1b-86a1-a054c4210738@linaro.org>
Date: Thu, 18 Jul 2024 16:45:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] qapi/machine: Belatedly document target loongarch64 is
 since 7.1
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: eduardo@habkost.net, marcel.apfelbaum@gmail.com, wangyanan55@huawei.com,
 eblake@redhat.com, yangxiaojuan@loongson.cn, gaosong@loongson.cn
References: <20240718141001.3077709-1-armbru@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240718141001.3077709-1-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

On 18/7/24 16:10, Markus Armbruster wrote:
> Fixes: a8a506c39070 (hw/loongarch: Add support loongson3 virt machine type.)
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   qapi/machine.json | 2 ++
>   1 file changed, 2 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



