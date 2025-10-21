Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E399BCCD1A5
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 09:51:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vB91f-00063E-K3; Tue, 21 Oct 2025 05:51:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vB91d-00061l-L3
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 05:51:29 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vB91b-0002Ct-Kc
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 05:51:29 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-471bde1e8f8so11553035e9.0
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 02:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761040285; x=1761645085; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OXjkFIoAAgmasmjFb0TbxMhIf9ixAUHzDjHgk6jgWoA=;
 b=EIi7DCB1fsqlSOzTSOj9sZu5ZHCc9OXi1/gQb8gkz4Bp5ep/LaFKZv6Y88Q3jow5Y3
 iBwx2aM6OCkI0ZxtpkiIadECBB1LfW6kYBrypwXxqsRnq68Poe99UCX1I2RpFb9mOYl/
 8VZ1uNv6Wzd5lwHfNf7Krq4mBnxvJKblGyP1/Go/Gl+bc/ytlrqP7b7m6cZjKvSWMq56
 vq8/br74lP6ZAAtkru4AVyJZXDwutynopM8HMtOp8C2Zk4C9CsPKobU+dEkEQgNZSEa+
 BhP/Ihz3aC+8LvC+2lokz4U74/8dmh5PFiYw1KS2NsayJHmCaclz8XRbjyOBLAInkrEA
 cgQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761040285; x=1761645085;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OXjkFIoAAgmasmjFb0TbxMhIf9ixAUHzDjHgk6jgWoA=;
 b=us2MSkYucR2hGSU/lJWp3lFL+nk3g82oq0GKzj76biLz6icTDbAO0Li7AV3VACNUEe
 U4/nSdyPWYJScSfRIaCv/L5w9DMR0XQh26Q5U4XHB3bVp5cDP1PazRwyTfUqdfYWpLOG
 119KUpJxYKVgBaonmjyK/U0uN7hTnwA8X6mIAON78zZIxdGxm9xbHbsUJRRZuc1sY5m1
 XW/o1pgmdJTejwXNI4jRO/BteHeAMXkkhIqdW1sSp6CyhXz1AmAa4hfbax6lpE1QyroL
 qxmBUGqh//PLSbjKwWCoI5h4QIfD/MSAY/HSzIIHkb1ywvhWu8KBXQzHGnQgUy37K2on
 AqLA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDliRjBT1/EizohCU3mcWkDFJuM6wpJp4xWjUEErfm+0xIc23fokJYOmcKbIE/OVtTp4v0T4L7FBjK@nongnu.org
X-Gm-Message-State: AOJu0YyxawgPx2nwfhaRuyZxMzviQdYDh1+LI7IGadTSrOEFyBRFcH1c
 1lC4E1xww4tg0sIRaQ448cIR7FunKWdQMvBv2zfYa6mMA36l9yngAeOcv0nsSCHLFeI=
X-Gm-Gg: ASbGncvMkM5GiGlq4x+9Rm+JOpOqyesWsFGFLWDFgHah5+QAZVYc/ZY1FcFR7L0mzuE
 jKg3mRYw3sTtrXeINMNPx0NvqObNIySX2g8IOvuiR3lMudEZmuGllqOJAq0n2YU4W18l8Uy9FNF
 6IiQVT798VVZHh2AA2pIhFgJPONM8S3w7VNncg5cv8Hor8FYy4UK8dZiYjyEAv+TCDhY2++tcYe
 i8A+XH0+w2GYenxwm+XjCCb5OoCYTXZX9DcP78x0gN9exWtqm6EgsRs3bxgIMknEitPOSY8vqhe
 ySuUR+VoPEFSHkw/BpSS1tQgvCVjNNhIGWXCblx5UBkwOMfrXzL1J/NB2NTs5CyUjs0d+L3AgsF
 myybEyq69w7QfGbqv8JoVXUzt0cq8pr9R7jFO8hmFsGqbxEDmtpCZjSgOlnhLQFMXzwScNHFycf
 m+wfjQoEXwArm/uJkF5BCCgc/R/wGuuJHl76myZUK9pjIVKp7fhLV3tA==
X-Google-Smtp-Source: AGHT+IERKJ3E89yYiqqf8WoIaIQukKLVFgTptz67X8IA131Po6xmnthjTr8ZrTiKnH0nCXxM6YpgjA==
X-Received: by 2002:a05:600c:470d:b0:45f:2cd5:5086 with SMTP id
 5b1f17b1804b1-4711786d5a3mr115602345e9.3.1761040285230; 
 Tue, 21 Oct 2025 02:51:25 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-427f00ce178sm19476864f8f.46.2025.10.21.02.51.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Oct 2025 02:51:24 -0700 (PDT)
Message-ID: <0744dcff-440f-42bc-9f23-cf8612689511@linaro.org>
Date: Tue, 21 Oct 2025 11:51:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/43] hw/pcspk: check the "pit" is set
Content-Language: en-US
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>,
 Gerd Hoffmann <kraxel@redhat.com>
References: <20251021090317.425409-1-marcandre.lureau@redhat.com>
 <20251021090317.425409-7-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251021090317.425409-7-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

On 21/10/25 11:02, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> We don't let the user create a "isa-pcspk" via -device yet (in theory,
> we could, and fallback on a lookup PIT), but we can add some safety
> checks that the property was correctly set nonetheless.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   hw/audio/pcspk.c | 5 +++++
>   1 file changed, 5 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


