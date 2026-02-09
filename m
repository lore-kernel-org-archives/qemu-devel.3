Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09C71EF071A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 07:11:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpLQN-0001zv-J4; Mon, 09 Feb 2026 02:11:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vpLQK-0001us-U5
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 02:11:08 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vpLQJ-0000Bl-DS
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 02:11:08 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2aaecf9c325so3605315ad.1
 for <qemu-devel@nongnu.org>; Sun, 08 Feb 2026 23:11:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770621066; x=1771225866; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ch8PkExBODJ/rci20CZL+FXoQyYDV+Qppvlv94KVSqo=;
 b=YVYnOkOBT5zE94+D/N9aCC/iA8JKuYy8QUtQAkDCpZDQIi1fWujY9/N0SDeC1IIF19
 EHnsY6vssC61Vt8S1G6DViVnJX8GTs2dAuJ/IsT+ZhIMbRXCPN5NFZJtKgVHOP0o2w7h
 AThkzEpea7C8srFug9EAVd4XasoI3JBDy4zMaioW/o97Kw5vbPbH68JCb1AgQfZcYvhd
 P6Am6hGq6EXIh5XKNF2c5/y1SGO6+V9nn7OvoCc7WKq6HWP7w3DdpAUSLDGRE8NXc9fh
 DyNtdYLFJJJhbr0yB91CwB2OCoZehFvWcD+IMdE0TatUFcwkACyWvP6RR6AJgXrW7OKJ
 /jZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770621066; x=1771225866;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ch8PkExBODJ/rci20CZL+FXoQyYDV+Qppvlv94KVSqo=;
 b=aTa/8uPjoHT8WZcC6PA9YM9AVYW92XdJskE9VzOWIOR0iGAlhyOpRMX/k4IapxHOev
 XavzRYq7HDPgUBt9iWO57zyYsxBZc5p5YMgWjE0wLtxzCeoX880scv3QFcSAOpcxnbj6
 eupDR3Lryi829DVFRJoEZem+tOg211d0csx4Qmy/ZA8f66Ob/8W8DeMtxXOTWWLQinTr
 vZVr0WrPX+du3T7NrVaReETPJF/gvsHiR5rHOc5OOiFSc7LJlBHKDU6L+qlLqtf7zFY0
 sIic3ys5uAHVOIA7llJqE45pInT1joJid+0LEkwpqxpLBc5tPeZRLrfxz5P21h3dPlgX
 hRYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6OViEypz8whAELQ8Aot4Ld2Y/6R5KZdUBjNjNNik3dl1lSBm+xZHdPW/U4SxAA0whFAFK9/zXlD3v@nongnu.org
X-Gm-Message-State: AOJu0YzQVMNlCcUVscuEw0mqPmUWqPSuvcbJPNZIqvWCC7N1qaA84sMt
 Z56xb5z1CVx2Qadaz/WP13olGkEn7vCRtWodj8VqbLP6cXelYPl2mwgTVV6c1N2UH3s=
X-Gm-Gg: AZuq6aJMEegB9DUnSFR+Bb48tmhCco/D1YET8xxviy9xBNG1ChI6Qbemtvi6U2CUCHo
 CQK0FM8ztaTTDb6z+HcY/o96zoX1IqUGENGmOYjD5CDZpklksQVsVjVvt4TH8ncNAMitpHlVI7a
 zct5nvNnQLCgHIH7XinAJY9s4BPFD38kIZFS1/8BSTLYtGawAHM7hyeD04uVarxYG0Qs+itzxZN
 qB6+rLC4KsHYTSRUJcKSdinwZIjDENdCIf3HR4OxTHsWLdG9F9lxLSdtzcSmsL/Z6UXNUF58Di/
 BvRgglXeYOvGTQNSWsO4AT4ERq7N5Ks8MXNuBreaeaqs1/YvJyfjAznikQdgwhWRsUuFen2MLA9
 AHPWLFlpev6t+8iiTwCnXNoKRRdski4sFbDwC4visr5NHtitK1ugN7JoRi0e7RPKxqSyqnSVOzR
 3siqTKNFE68sBBdsAOIW/l9YGzZjAFd1pe1XSIJZP3kKYjdG9qaa89F3g9sGeqLV6/P6dpDt00U
 Q==
X-Received: by 2002:a17:903:2446:b0:2aa:d349:e63b with SMTP id
 d9443c01a7336-2aad349e90cmr44613545ad.25.1770621065579; 
 Sun, 08 Feb 2026 23:11:05 -0800 (PST)
Received: from ?IPV6:2001:8003:e109:dd00:7b35:2dcc:ff07:8193?
 ([2001:8003:e109:dd00:7b35:2dcc:ff07:8193])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a963f8fbdbsm66056115ad.58.2026.02.08.23.11.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 08 Feb 2026 23:11:05 -0800 (PST)
Message-ID: <41834751-4cfa-4fe1-8e39-c6a53f4eaa90@linaro.org>
Date: Mon, 9 Feb 2026 17:10:57 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 7/9] hw/virtio/vhost-user: make compilation unit common
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>, Nicholas Piggin
 <npiggin@gmail.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, stefanha@redhat.com,
 qemu-ppc@nongnu.org
References: <20260206221908.1451528-1-pierrick.bouvier@linaro.org>
 <20260206221908.1451528-8-pierrick.bouvier@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260206221908.1451528-8-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 2/7/26 08:19, Pierrick Bouvier wrote:
> PPC architectures use a custom value for VHOST_USER_MAX_RAM_SLOTS (32
> instead of 512).
> 
> vhost_user struct and several functions use VHOST_USER_MAX_RAM_SLOTS to
> define stack allocated buffers. To avoid changing all functions to use
> heap allocated buffers, we keep this max, and simply add a
> target_base_ppc() conditional for the single place where size really
> matters.
> 
> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> ---
>   hw/virtio/vhost-user.c | 11 ++++-------
>   hw/virtio/meson.build  |  3 +--
>   2 files changed, 5 insertions(+), 9 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

