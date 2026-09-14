Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4BCBC88E72
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 18:58:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6Bt8-0002MN-Dw; Mon, 14 Sep 2026 14:58:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6Bsw-0002Kd-72
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 14:58:35 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6Bsu-0007aJ-Ni
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 14:58:33 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-3990fe066ebso2949438a91.1
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 11:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789412311; x=1790017111; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=kuaCkhBpdMtpRd38eH6rb16QvHHZibgwb8r0GjEzP/4=;
 b=fPK57jZEzxLHbMx+HbKIIKUhzLE0Sd+zkJbQne4ltSijyg0QBNiQVAtMPOlRd2Wsml
 a1ys5hEhRpJuVOXx02UXMipn9Cq5JF11Xh/BztOmDD9hiARfvVYdTbAwuVpHryXWuKPO
 MSOIGeqwmofzUtxJF2aBN5+Cbg/BXfyuF87YUDe3IysdG5ouPuUbklo1Om8AykwAGkqK
 jGgVEfLSWk/rmRHRSOc1h3Kn91Dj5OUPE90ZFhBKe2EvCdd/ML8JzWjSnrJjr/QUAzyl
 Zu0UBkNsEQGPcyNrmQjyYLKHqW+fbRkrV2Q+yPDQ8cSHg47XIHoFkw7YuN/h0NwhVXsS
 rd7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789412311; x=1790017111;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=kuaCkhBpdMtpRd38eH6rb16QvHHZibgwb8r0GjEzP/4=;
 b=TpmNLbrTb6x2mF8HEimFUhWhbE5FtzeLarPobYIbNSwtlqNFqxs2Oq+q96tIMsUiVv
 ulr/LrIA3l27HFRmSuVjeoXjXOrw4Ij9fAyCAKZVi/C5QWjZX40rHsBhGMGYyq5J8jrN
 KS+Gvey9ryWqGn3BLjeQv6ZdYg65vyAi//WvzdbDoKiWrhmIt3ivoG6j0qhPDEGXR69V
 rJQyOSgC/+WoEcVHzLwGKWEsNgzulS7p93CPg1dQt9T0FDUgQ+xYsWHlvNK1AxKFhDiF
 DFSiLODsM+yWTICKk0NI+LZOhpICcnJfbO7Styo4Jq/NDJPSVVoGgNKzUf8buxmqYz8Z
 r7Kg==
X-Gm-Message-State: AFuF++n/xL2TtKnzLQ+o8huxu6lL8WsJShzu5cZeyWuHxCXH+cut3E52
 wIEsHKNKTFfNuDAnK1SiywSXhWx4t4QQkZAc6ARS7beOE/EetBtb5SAlJDnleB9mIeZkLRKvb6R
 RA/tbGag=
X-Gm-Gg: AYBFou3CNwfDkqxVyOaon1ySY0CzzMbWpy+o44dI91XU3w5fKXlH0QPJhY5uHUyDflV
 qcFOgR/9E1gRbT2Znc2qFHJ+rxp3x7Kj7LXFO0jPjd5exgtmcJ7OZ+qgdkVwqKGFNmM5Q9NiCem
 g4ChoCia3bh9MpID3F9NRz0RILXI4wKIOx/FYLo6uMZ90wPeQsmgmc7rV1X7Gl9a6zjYdcbKLJ7
 PzyI9w1YXbvSQbSAWE7Dr6D/XtgsZbW6tEqIOXGw5ph7le5SfQIfAYDQLc0bEU8Yx3a9r//11j0
 sMhVCl+Q9+WH+GOQ43RJBROSTXyx4rieoBaf4iwBk8nXcsvCN23RCxmijUJqLx+IO3WtGeRFdts
 ZKPOdXgSQuvR+dGfMmOj9IHaDDQ1j0R1fw4aCwgvVHS0lHK1w6ciM0X6D1sQ3VfFH33lOvUFVBa
 oCXaYbeC4epc827faO5K4+PIhtg2WC6D4St4kxAJPtX3MIK/BbMGtOx6rgXhdUERhFFL1/cebT4
 96DnrXk7qJuNA5OSCcKZrWSgBo3SSHXst784cAnHQL9DeOhLiX7O/nGwxLrZQ==
X-Received: by 2002:a17:90b:3bc5:b0:39d:f259:3363 with SMTP id
 98e67ed59e1d1-39df25936c1mr5811437a91.12.1789412310734; 
 Mon, 14 Sep 2026 11:58:30 -0700 (PDT)
Received: from ?IPV6:2603:800c:7900:ed00:7164:7976:4c53:31bc?
 ([2603:800c:7900:ed00:7164:7976:4c53:31bc])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14365b347e6sm24702811c88.4.2026.09.14.11.58.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Sep 2026 11:58:30 -0700 (PDT)
Message-ID: <47b9d6fa-c95a-451c-bef7-c42fe0e066a9@linaro.org>
Date: Mon, 14 Sep 2026 08:58:27 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/14] qom: add helper API for checking object class
 security policy compliance
To: qemu-devel@nongnu.org
References: <20260910103628.2326622-1-berrange@redhat.com>
 <20260910103628.2326622-4-berrange@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260910103628.2326622-4-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1030.google.com
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

On 9/10/26 00:36, Daniel P. Berrangé wrote:
> This helper simply avoids a verbose code pattern being repeated for
> many callers.
> 
> Reviewed-by: Marc-André Lureau<marcandre.lureau@redhat.com>
> Signed-off-by: Daniel P. Berrangé<berrange@redhat.com>
> ---
>   include/qom/object.h | 13 +++++++++++++
>   qom/object.c         |  9 +++++++++
>   2 files changed, 22 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

