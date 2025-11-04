Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDFCDCCF9E3
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 13:57:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGHXD-0003r1-SY; Tue, 04 Nov 2025 08:57:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vGHXB-0003qm-AG
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 08:57:17 -0500
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vGHX9-0002NQ-La
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 08:57:16 -0500
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-63c0c9a408aso8120541a12.3
 for <qemu-devel@nongnu.org>; Tue, 04 Nov 2025 05:57:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762264634; x=1762869434; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=l1DoROmVTnmZn/oUcTFsIS1PhOB4W7F4KNYx76Pffoc=;
 b=I+RKvBOuYw3s4YmDrDulThU778LNkcY7uL9vXvSqeUZEoNWxe3Jj/l48wnc7i2nvnD
 5b0HBdzRHGtDCaWJsnvTR+YRtyM9ZWigZHZ37WnSya4QrXd/YeqVi/CmlCyw0wAcCOGM
 DuqCecqmy2b9kT1/Hhh8KB78LXUGyAD8GkfNU2GA5Js06alDTtDMLySKyz08zfH6THfG
 oWRwh91XgtJJBrChjw3WylUFQIpax+7AWmZzFDZc5DZONT4eaHvMcAZY5ADsRB6JCcJL
 M5oN7Mft9YMR7oH09QPvOLrV6jEgVPioc4QPMXTWRMSbkzF2ae7ovPp0qme3RJfjFtAL
 gqcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762264634; x=1762869434;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=l1DoROmVTnmZn/oUcTFsIS1PhOB4W7F4KNYx76Pffoc=;
 b=dg/U0OAfJQF49AKa3Cj4vdKtYPVUMgjYG2gf06eXLtU4JJ9lcmIMG9OsLyaopoAKHu
 J2mZCECHNWVpY9/mP/hMVL9aWLztrOp5OJRHnJwzCt65YYGTtYqgSgc+aCB1RakWkiJ0
 uEkl32sqfGr8I1VXZv6m7vZSjDsU9Phz1I1VeXSGLZtcKaEgrFAyUUqPNwUgm3HPyQSg
 0FrlPG/2Rzw1cVKzg1KXhfNbyoW1Q+HvH+v1IQZ1/fttzU4NExFPGMkdbFZGyuC6F+ZV
 PVO+CDKzpkdFnt7JmZHc0hg6zYM7XjrGwo5Q4jLC6RVvnoXDuokYW/dsvJJ+lY3DZ9YZ
 Fb9w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXOJalnLEo/Bqm/C99wNlb2fMssxJFLWpXPQrY4ie20wSvMDaWfOlmhZ6vwym0TiuHQQldO9ZJfi4N+@nongnu.org
X-Gm-Message-State: AOJu0Yx3o9BKfjBqT5QFktgRAlKU9YmgXdIF89ICk4ew4+2kIIpt3OIf
 mZzAjnpzxw3IZxIQs+OLecO7bikZycS+B1n7VjAMHn8ahZT8/fN0UAvx9SQcUxOS+54=
X-Gm-Gg: ASbGncuF+yJQPGYOXLAWVVgketsNokrLry01aweFORBXyvIOO8PZv8UAALllpw9Us+7
 PQSp0eUx6JWljh7YfHYk+2KVYvYUV5ON3xIqebElu8r0ufZjOlegbS0HveBhheKBvokWk6mfwKD
 mlx6Jp6zdauJvuF0saDA1ArjTq11XeehhizVsz1E7eIAU2V4WGnwFwISmBP6xE8W7Nf8vPjDtPe
 qK38FYcjlxd1fHp2lDUEej8N55erlxxOcNtwaITknd31wQMYIbRMGmnYaJmmt72wK2BVaSwIxKq
 xGsBAvoUO6Q9EY4aILyGD1d1UAykJSz6bJkueGj95+5b4EZ9QmsEMWXTOtixyFG2C+BO5+qvAqP
 jjY1jWF2Fser09nKNT30ClKuou0MZQyxz6zeGA4hAfIlqgw8IvG2b42S6KVGbeQoPFHRvmRA4R9
 xCiKSR//8pNKiLjFIiovmDh0z1BA11I0Cd8J+f6w==
X-Google-Smtp-Source: AGHT+IFljxa7CQmrM0oXXWnCW/yU9Tp/+ipTZzmd3ZZ9tGwSpCwu7ozsYSE4XuILml9tIVwj8XrjFg==
X-Received: by 2002:a05:6402:144d:b0:640:ee09:bfc1 with SMTP id
 4fb4d7f45d1cf-640ee09c190mr1647266a12.37.1762264633876; 
 Tue, 04 Nov 2025 05:57:13 -0800 (PST)
Received: from [172.20.148.100] ([87.213.113.147])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-640e6a5cd09sm2088050a12.20.2025.11.04.05.57.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Nov 2025 05:57:13 -0800 (PST)
Message-ID: <a6169e3c-e4bd-47eb-a569-e1ec99f08400@linaro.org>
Date: Tue, 4 Nov 2025 14:57:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/22] Functional tests and s390x patches for the softfreeze
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20251103105824.322039-1-thuth@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251103105824.322039-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=richard.henderson@linaro.org; helo=mail-ed1-x52a.google.com
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

On 11/3/25 11:57, Thomas Huth wrote:
>   Hi Richard!
> 
> The following changes since commit 53b41bb78950912ba2d9809eef6b45e4df30c647:
> 
>    Merge tag 'pull-target-arm-20251031' ofhttps://gitlab.com/pm215/qemu into staging (2025-11-01 10:52:48 +0100)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/thuth/qemu.git tags/pull-request-2025-11-03
> 
> for you to fetch changes up to 0408c61e27aca56c2d40aeb6ca0e5c5f8b8c3845:
> 
>    tests/tcg/s390x: Test SET CLOCK COMPARATOR (2025-11-03 08:27:59 +0100)
> 
> ----------------------------------------------------------------
> * Fix spurious EOFError messages from the device-crash-test script
> * Fix various issues in the functional tests that pylint complained about
> * Improve logging information in the functional tests
> * Fix issue in the s390x clock-comparator code
> * Use address generation for register branch targets on s390x

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/10.2 as appropriate.

r~

