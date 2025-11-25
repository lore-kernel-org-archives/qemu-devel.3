Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD5FAD0E6FE
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 15:38:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNv6o-0001OL-1I; Tue, 25 Nov 2025 10:37:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vNv6g-0001LG-PF
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 10:37:31 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vNv6e-0007Q1-RN
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 10:37:30 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4775e891b5eso24364305e9.2
 for <qemu-devel@nongnu.org>; Tue, 25 Nov 2025 07:37:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764085047; x=1764689847; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pal7b2o17HKgT1ionj87xcgpN3Mn34ldZckkp/PmxCU=;
 b=anx5XnjYlwX2qBcKOYUhX2nXjH2krxD0wlooyhDXQ4Jn9hUCA1MiMtAe6oQr178K02
 2RdkFXL9s9rMAYJNClSWpq7l4ZThDL0ePCVxoj8iH7U4eAJGv0LtyPgBfcBJxVDy07ru
 /jCxo8dQpzy5FLAqBtMqx1oI9vK0aSnAd+NAsXgEmDEUZPCWqQbSd6vVQvfkYo4cvRMc
 Km41d1MkK+xMFoP9xoz1Yxy3VCoOeE4F9nxYAceX9KddnRQaWpcfSmHfxuGJzE54jE1B
 tInyFQQaog1XMUJKWcYTklDoI368RYECqp6YbRo5dyMibHf5w8MVeTo65YlR3JyLaIT+
 k6Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764085047; x=1764689847;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pal7b2o17HKgT1ionj87xcgpN3Mn34ldZckkp/PmxCU=;
 b=a0UBs6lqrmL+Hz3/7fHI0D3CD6pW9HlXFCcElVBYu8TrJSE9G0+m8UvJqRDWlJaFzo
 MCyzxWlVjRhJ8fcHLfoM5TsOh78RKfROVHEf/iMhfpyApGU/+xfgtMzZARv8GiYBz+vp
 IQOCuXG1mICxn6kngHqKC0dkINNJ8PysiA1YGAT99KGvcH2lYpG4084PSSOUTn0D43L7
 t+wdFQfysGk7B5lCg1MDIWqrATBy4W6fpuWIeVwmeDJ9Werql+sT1v+OfZdsir1CH42O
 hRDCAoErsxVgAPXWoHVOPA49fMM9k/jOHJbXm2oaQ34N2WtI+We2O4QR2g4xzZ1UmCEY
 +0DQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVyfyPW+sNkEaTBkFvh6+tUPs4Mt+l3IzlpKC7HbkplUB8Phr5RitRkl1Rza2N74EaiV9CiTwdij/Pw@nongnu.org
X-Gm-Message-State: AOJu0YyneoyQeZNZGCtZtb9zJ4+1s1zUT+GIJ7ytv/A3hFZMO3UUfwKQ
 T00S+EeeX3VJIUiAsGw0pYsGA9v4nS4BNiepj7ga9k+Qe3VDFjYdpIzIilqgBz/xns4=
X-Gm-Gg: ASbGncuU/UFf1f9B89m462ApkVyoI5MjbXuUwJYGZWE146MPxNavXPAY9W4haL1Tzrc
 lK712VrybQl2v+Rr0cUDxFwqBTzeZYriygZDjGGIDF4jJbshkDth0YZfsYkU8amWWGEUj4zKlDX
 aDFS1Ae/IyAWzz2UNtkjyyAnCj8TbVO24S4sB2qIuaVsPf/6D5PmoLEOqdeI5CoOv9s8pg1rgu8
 kPx573Gzwnazg9lvUTDrxW37yRAvgSL+Aa+KgyvObKnfDYtNpm9Yt5tDM+9RtrT0cKive19C93d
 V/UEMyWo09iCzx5VcQXVQLS9w0kIJwoFx/WPwtDuZBEzCJ+bszW2sRRzEtkvvdOzHGU5Qq2bufI
 o9rQWrGwjcWp/+EoUrH9SCo6HzGLBdGHa2eA6TtPv4hwALyUdAMTGJAvZxhEW1SCD7U2cSOBXwB
 v9/ACDAw0surGEQKP60d0vSgIxATzidnyy1st8cQs=
X-Google-Smtp-Source: AGHT+IGKI+KUW25zjisjs1oiOqlh1rAy+s+pOxb4h1pgZA4kNacJr4fhvpxh4a/aFHhDVmxrce7L9Q==
X-Received: by 2002:a05:600c:4e87:b0:46d:a04:50c6 with SMTP id
 5b1f17b1804b1-477c01ebc76mr159800965e9.30.1764085046907; 
 Tue, 25 Nov 2025 07:37:26 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7f2e556sm34690151f8f.5.2025.11.25.07.37.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Nov 2025 07:37:26 -0800 (PST)
Message-ID: <429a1365-489b-4032-bb3b-355831c8b0f9@linaro.org>
Date: Tue, 25 Nov 2025 16:37:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 4/4] ui/vnc: Fix qemu abort when query vnc info
Content-Language: en-US
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, "AlanoSong@163.com" <AlanoSong@163.com>
References: <20251125141726.1755276-1-marcandre.lureau@redhat.com>
 <20251125141726.1755276-5-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251125141726.1755276-5-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 25/11/25 15:17, marcandre.lureau@redhat.com wrote:
> From: "AlanoSong@163.com" <AlanoSong@163.com>
> 
> When there is no display device on qemu machine,
> and user only access qemu by remote vnc.
> At the same time user input `info vnc` by QMP,
> the qemu will abort.
> 
> To avoid the abort above, I add display device check,
> when query vnc info in qmp_query_vnc_servers().
> 
> Reviewed-by: Marc-AndréLureau <marcandre.lureau@redhat.com>

                          ^

> Signed-off-by: Alano Song <AlanoSong@163.com>
> [ Marc-André - removed useless Error *err ]
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Message-ID: <20251125131955.7024-1-AlanoSong@163.com>
> ---
>   ui/vnc.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)


