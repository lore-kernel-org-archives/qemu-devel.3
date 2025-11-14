Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AFE2CE8D55
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Nov 2025 16:58:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJx7U-0004Lj-Vq; Fri, 14 Nov 2025 11:57:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vJx7S-0004KP-Rs
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 11:57:54 -0500
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vJx7R-0004Q6-6m
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 11:57:54 -0500
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-37a48fc491aso20550931fa.1
 for <qemu-devel@nongnu.org>; Fri, 14 Nov 2025 08:57:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763139470; x=1763744270; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FNTCw1ZxeZUrEMbJIAgTzSPmC+fa/Byv4MwVnauU1Gw=;
 b=wDJqhIkRYyBta3cdRlzwGioDsd/BO16OnSfPKK7IRt7tykvMU81FvL3op1+PGhopp5
 Gfa9OmQSsXZj9Aqj01p53Ybu6T8PnxV1xh24uc9FjnV2ZIo+BiJCkp1fPQxdlBm5FOhg
 sqe3HQTYODpe2F6YSH2hqUzIU8oB3jvNnqCcxl9VkX71moTsvAdg23R8rbpoLP4Bhyny
 FAX49SxBoN0m/mkwLDhTkliOfvAuAMjmZCqyk8ANB9fM7qcRHq8aOI4Frn+ydAOH1Si4
 KVrENcK4nUVPg3kbcJV+bvRHRIYaDaQFaxCvGMA0O75hvrNzk42g8Y6++0g/bLeJRZqS
 bnrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763139470; x=1763744270;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FNTCw1ZxeZUrEMbJIAgTzSPmC+fa/Byv4MwVnauU1Gw=;
 b=ELsnPFs7haGkIzDEJDJljBoo02/SDNLtIN+Ti70WfbUs6upolLg2421SYXS9udfnGs
 g0pKnlR+IKUL5F2JYmh6Pda5VUaozluKLvzbYev/lmBTV0MbbWvIuHfvbIi6dHQ2K/IK
 dOw7lXNdTwhzguvMbBBI+OuoOSQSjYbWUb8ttuf6EtqlIZe6s3JtDp8JhMfo2lEaExjJ
 fKNhZf7AwY5ZkRD2KhWLc0W7yNhzgvNdB/5+gMRqilKiBKmtyM6NjUF6ELFAVi4TV5Ri
 FZkU7IXY4jgnsTyHB8kg1ZPhswx4MqwiZ3AJCW8wnGX5/8NRPg3OXN4DPuNWZG8diK3/
 Pfgg==
X-Gm-Message-State: AOJu0YzbE+HFXgjaHkps7/TKmePB22I1LZrz+vzhKS8rBaMueB3uTYnF
 iP4m6Jg0NyZAhsHoipSKmcoleQP9XabtVxGFnU5ZYgtLKp8hRkKJm59B1crbLGuUz8Xu/+uZg59
 AjHS+QJk=
X-Gm-Gg: ASbGnctyZz4jdnx+RyD/DzI20Yr9VxnBUj3wJwxBDxAtSEXit2GUxNIWjtnR9fKrdQR
 PnrRlrn1+D8K51HWftbWELA/B/0nhTvRmwGW7HvqEwozs1jRaCCyqarPMYouoF5g9KOcl9/T/1U
 JzcPzR/mLAaeOZXsJV4E6BCjTIY3WHLlqpKhrJkPKWRDmFO9WWd9cJHDc+E3JMPYaUhiDfuG70E
 ZccXjQkM48RgXvPdPfrvzC4myP3xtCTI5P91/Nzj4/eEL5emq+hS9uhxqrV294nmsWKiY6QBDuX
 wl9N0m6loVG7ZO2lL80LvKQhlMMePqBc99iLK+JJAiBz36I5xp/szKlUTJeEcsxos7XKIoxYxNK
 5FaeZpOgYEUpDVzuLmTLcLZ9TmeNsrN2b1ePSw9QR8tFHwPOtQ5c5F4fWWR6GiOTjCMQJds7Mt1
 wPK5WPCZosAaQtMDzh59RkMo/xyPOCJiwhvy+08QCHvNHd+vhcGIQcVp02rA==
X-Google-Smtp-Source: AGHT+IEXBY476qh6ieIb+c+o1o+h8XOQUBenPcDSfT08ztP0HzVW75vfYp4hbpFR/ngXhniicl3dIg==
X-Received: by 2002:a05:6512:1149:b0:595:7d95:eaad with SMTP id
 2adb3069b0e04-595841c0fe3mr1415227e87.22.1763139470301; 
 Fri, 14 Nov 2025 08:57:50 -0800 (PST)
Received: from [192.168.8.105] (86.red-80-27-231.dynamicip.rima-tde.net.
 [80.27.231.86]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-595803b3019sm1160099e87.26.2025.11.14.08.57.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Nov 2025 08:57:49 -0800 (PST)
Message-ID: <66e6265d-f71e-4709-aa37-7107fdd3b986@linaro.org>
Date: Fri, 14 Nov 2025 17:57:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL for-10.2 00/15] NBD patches for 2025-11-13
To: qemu-devel@nongnu.org
References: <20251113225531.1077484-17-eblake@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251113225531.1077484-17-eblake@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22a;
 envelope-from=richard.henderson@linaro.org; helo=mail-lj1-x22a.google.com
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

On 11/13/25 23:54, Eric Blake wrote:
> The following changes since commit 9febfa94b69b7146582c48a868bd2330ac45037f:
> 
>    Merge tag 'for-upstream' ofhttps://repo.or.cz/qemu/kevin into staging (2025-11-12 11:47:42 +0100)
> 
> are available in the Git repository at:
> 
>    https://repo.or.cz/qemu/ericb.git tags/pull-nbd-2025-11-13
> 
> for you to fetch changes up to 4c91719a6a78a1c24d8bb854f7594e767962d0d9:
> 
>    tests/qemu-iotest: fix iotest 024 with qed images (2025-11-13 16:43:21 -0600)
> 
> ----------------------------------------------------------------
> NBD patches for 2025-11-13
> 
> - Fix NBD client deadlock when connecting to same-process server
> - Several iotests improvements


Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/10.2 as appropriate.

r~

