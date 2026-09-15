Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A3FCC88E75
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 14:53:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6UXP-0003Jd-75; Tue, 15 Sep 2026 10:53:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6UXK-0003JQ-6B
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 10:53:30 -0400
Received: from mail-pz2-x10.google.com ([2607:f8b0:4864:3b::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6UXI-0005F2-Ne
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 10:53:29 -0400
Received: by mail-pz2-x10.google.com with SMTP id
 41be03b00d2f7-cc4d04d73b8so2579796a12.1
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 07:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789484006; x=1790088806; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=iW85w8JT2Ud8ZIV/je+GqXV9Dp6crmuMrqnsvglAI8A=;
 b=Ml2/ocy/fZY1Dgc8tq7XtQvUpV+iRYZlZtElxyWKcNmkBLiteWLrKIYOivVt/LD+Gl
 kFNUMK6r91cQrKCMfLvoM3u5lBx5MN6qq9CLvDPkezWwyW5c7t3qL/cMtmkng54nGOSx
 rGPKrdgYHxTbpYb7icy4j987rNQdsJeQ4tp+MJq/TPDtyKeTEKqEAoSgbmS396ss4Idh
 xZP6676WfvbhSbL3WXMYe3gWxclAJgr0bnJ2NYa4+mzbkH0gi+rvlHA8NbWWX/7AOorL
 N1BbqdDHVVA84ScqWtds5sQTtrRnvg2ZvgoBnovg9Att0jN3Byabrnamww7n3WWjXeGV
 EhUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789484006; x=1790088806;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iW85w8JT2Ud8ZIV/je+GqXV9Dp6crmuMrqnsvglAI8A=;
 b=SzKV9rl1fjU0uT+aqYTj1AJClOxjz6NiOXrayScEJelSFKqAyn3Nh63XNA+uIs/lJC
 0yYq0I9MAjf7XCJbrxwlF+5wgGtF1py9H0nU4DGNq4/ARWnbn/cxl7Oz+bB2aVHYGdC9
 U3/BEipPzDzGr67I5ye+0QWqHdiFt5CfKXq1n3aRZID3285iBvo8ERfAcjkFcJ+ydn6+
 aTbhGzpkJTxhen6/6UoQ+ZbW9PcqPqoyXP1/7HTW+jayskKJGs66DcgqAF8MWQkUtUuJ
 9a+6F1t/tLdZ3tJdPJ631ieOiLCHabyGkyDxyw7aH97O7yabS52IjtIkd7yNJ3cZCxey
 2ptg==
X-Forwarded-Encrypted: i=1;
 AKwUvByg0WEXnft3boBZTsYc1dEBBDpbcJ6DLxqKIwwiIF22Ol8jbTsweMg4VrDkDz9n/KZ2dGUREJw3m4kp@nongnu.org
X-Gm-Message-State: AFuF++mVUKfbdEUyZfmiqdgrAeqT2nL5M08y4qBDGqdl6jUiZGy/NL15
 7FKfB7wyHGSTaxMfFgzlQF4BmW+7/Ni9qFpKnn4abx5d2xDeTOGTQSOMVIgvHJPInQg=
X-Gm-Gg: AYBFou2VE8q7IafuJf0WgKa7zfk1ZQVXiFencMq448Dc1CmnXTBh95DniGwzvm/dX/a
 R6rNgo15Pxz9E/teu1toMsrptxemWTkY/+5vuc1cISkOYock6YxLmPEHps6UkIvDrb5/OXubaYM
 oUx+EMSfLtsozPEYl39PK3DxKz5m7DHm9z9V+pnSBQZTrXOQHl0N6LBrEIy6X/9bWeb/KGhMYd6
 lbVXIZiIH8yKq3OrNpZa7brDhXkszILIUckm3ME14vt3XJEJQU4IJOGQx8ViMm2Esym2dNNo+a9
 wDPP+Iz9xcaUQTYcs1/TZDh9DqGejEQTqiFlhVSQ72J20Cz1HSpr2m7mvxgqonmIq3Tq4yKy6Nj
 p4lWLxI9BkD5eza6terE6RAjhWx3SHvQtIxEtvzvWe38V0xO3f/nHCHllR9w419ODSoMT81ByZR
 YXoW5bZzQCl2PNhhBXPpjwzGxn/LAMIvnJGgQwggNJJeNEZilLqW0rcumzG4juczzA58V8NYOOT
 coGdoJ6HnKIrk7+qpWYBTXgfNWUi/p4ZVjM8OmMCM8MJIAGCDwBc2oVVjc=
X-Received: by 2002:a17:902:ec89:b0:2dd:76b1:34f0 with SMTP id
 d9443c01a7336-2dd76b1361fmr80597245ad.11.1789484003379; 
 Tue, 15 Sep 2026 07:53:23 -0700 (PDT)
Received: from ?IPV6:2603:800c:7900:ed00:c119:8717:353:53c6?
 ([2603:800c:7900:ed00:c119:8717:353:53c6])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2dd2cca6b7bsm70873075ad.3.2026.09.15.07.53.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Sep 2026 07:53:22 -0700 (PDT)
Message-ID: <67d72d9e-4947-470e-8819-35d23c6a5f90@linaro.org>
Date: Tue, 15 Sep 2026 04:53:20 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] Bump min compiler versions again
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Kyle Evans <kevans@freebsd.org>,
 Warner Losh <imp@bsdimp.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20260915085213.139944-1-berrange@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260915085213.139944-1-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x10.google.com
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

On 9/14/26 22:52, Daniel P. Berrangé wrote:
> Daniel P. Berrangé (5):
>    tests/vm: drop redundant ';' at end of each shell command
>    meson: simplify clang version checks
>    meson: bump min XCode CLang to 17.0
>    meson: bump min upstream CLang to 17.0
>    meson: bump min GCC to 12.0

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

