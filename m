Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 504DFCF31AC
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Nov 2025 11:31:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLgOK-0000tD-VZ; Wed, 19 Nov 2025 06:30:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vLgOK-0000t3-1C
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 06:30:28 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vLgOI-0008Uc-Cq
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 06:30:27 -0500
Received: by mail-wm1-x343.google.com with SMTP id
 5b1f17b1804b1-4775ae5684fso33603495e9.1
 for <qemu-devel@nongnu.org>; Wed, 19 Nov 2025 03:30:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763551824; x=1764156624; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lluPvpIpNfIbtLgB2Xwyt0bFItl0gbX00AAtLCZSLa0=;
 b=f9UwNbG4oT/9WK9WnCeHw/e5ZTXvON45xQj24wlwNNrm/IO/3x2/ucqwD1PkxJunp6
 eo6I/McW5hvXOSPGtb/iuY5d3SwAdHg/TBIBjkTkb7OSgJKNwOE36vwhIIjEkxdZ+TmU
 VT3qdhofAG8te5YYj5X9AH4twf+NcNr6cxqxdPMFYru6AHfy6TJ5NGDru+ABrCIQ8/7V
 LTC2Df0ynn9eO9oefOzaqt7HANA6UmV+Hn/zj1PH4ejb2iyGSWII6T4QhnN6KWQmdC8E
 oZcczEJhtjeTBlMkqXKsrZnZO4mFDdS5pksYBYW3buIPnYjLcWR2XeH+jMBxYzGZ9TPf
 XcbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763551824; x=1764156624;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lluPvpIpNfIbtLgB2Xwyt0bFItl0gbX00AAtLCZSLa0=;
 b=YC0Xw9ppfEp1gv2BrttXc4g/HoaJwuLbZ/bv8lsNrNJqzoFfzZBwxvuEe9bRdW+ohX
 nqND0DAkyqAAFOr08r3S/pyb4y8FTZdBVVS1wDE0U5m/dTr06qnsgNaHYxzMPK+iJ25h
 oQx4esmtZ2hq0ZhxMoUx22Jq4qcnlC8ecF1TWWV9LndZVi8zLuJQnnNmyVLesycmhCfL
 vJwrrNEruuSHR1ikjijTsUDH/HsHBk9XM12uYgtwbbHMJwZmG1glsh7oRbiLv1JQsEre
 IlbhNceGOhnh8nx1zYp/ZU925HJFATxs/c5gZYY5EwmsHA29HzLTr5n9+MEjtINFsh+v
 4/Rg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNH4cPXP5UH7JHZLuuTfsYth+xoA9h3+31hJUMYk9YuDx7hNF+wIgQ8LpxBKxF3QWgMZMI8GOvSXIk@nongnu.org
X-Gm-Message-State: AOJu0Yx8psTqZS4Aum/pDh5JtyXagDEDo64E6X1uJbBigEnsxMnh/D5m
 fc3LDH0gDgIfYaiBdCLe2qrg7iMq4JuoWr8PTd8VITLAMf3C8w8hIfoc1vZBalTqGH8=
X-Gm-Gg: ASbGncuLcIrvyauF8Hm83NIkhBz3m7FtrA534UWds8l938hdRZvYW63L8c2Sjb18eVF
 la+7EHUxZsL5eW6ICIxGJLXcPk6wo0Cu6NxTG1eMM3RgOmnPG9y99igMEm2/Y3/++9xtKHaZKtu
 cJxvRWTAY9PVXsQCWVbPGjVLLmclRjn+qZP0VGnT1oEUxixb5lKaxWxnDWa7bqbxsK6JnKGJBRD
 GZhJvlEZ4aQOFvCvuGhDDzFtCCQYVTcyuehMpGzN3JWj9d3CD+PPZdTr8ayH5ad+Lq6QtAdth9S
 s3IfXhmcVMt/QSA6vImKWF8dDWEZazFWIUgMUIvZ6Tubfld/1bUo/HAE2/4SqVPyI6F/AtnkfA0
 bGtZPbeNuTL5ycqSHm945KBkro0Bm98mFKEY3R9UZXu+Mx+m7ghRDZ3ukiCVE+qzRiIMMJQmIjv
 i2yO3EK5CmxcbcEdHteOExolYTq6JUsMtzXZxmTwGBIMQLSSrEtg43Kw==
X-Google-Smtp-Source: AGHT+IEoXvExm0Bz0x5XflpTMGTkw62WDApxTosdQh0Onld4ksW7Bvmj0DATe1xOywuLFmlFrl8WuA==
X-Received: by 2002:a05:600c:1910:b0:477:9e10:3e63 with SMTP id
 5b1f17b1804b1-4779e103efamr116881105e9.35.1763551824496; 
 Wed, 19 Nov 2025 03:30:24 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477b10804c8sm44687055e9.15.2025.11.19.03.30.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Nov 2025 03:30:23 -0800 (PST)
Message-ID: <40e40d05-e491-4513-85b7-48dfe8f5c178@linaro.org>
Date: Wed, 19 Nov 2025 12:30:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Python: fix tests
Content-Language: en-US
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: Michael Roth <michael.roth@amd.com>, Markus Armbruster
 <armbru@redhat.com>, Cleber Rosa <crosa@redhat.com>
References: <20251118200657.1043688-1-jsnow@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251118200657.1043688-1-jsnow@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x343.google.com
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

On 18/11/25 21:06, John Snow wrote:
> Whack some minor annoyances down to make the tests green again. Fixes
> both minreqs and the optional check-tox.
> 
> John Snow (3):
>    python/mkvenv: ensure HAVE_LIB variables are actually constants
>    python/qapi: add an ignore for Pylint 4.x
>    python/qapi: delint import statements
> 
>   python/scripts/mkvenv.py   | 24 ++++++++++++++++--------
>   python/setup.cfg           |  1 +
>   scripts/qapi/commands.py   |  5 +----
>   scripts/qapi/introspect.py |  2 +-
>   4 files changed, 19 insertions(+), 13 deletions(-)
> 

FTR, per 
https://lore.kernel.org/qemu-devel/20251117185131.953681-1-jsnow@redhat.com/ 
reviews:
Reviewed-by: Thomas Huth <thuth@redhat.com>


