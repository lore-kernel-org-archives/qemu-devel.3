Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B20AC48BEB
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 17:50:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcqj6-0002iM-3L; Wed, 21 Feb 2024 12:49:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rcqj4-0002cp-Hm
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 12:49:46 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rcqj3-0005AK-50
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 12:49:46 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-41270d0b919so14419065e9.1
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 09:49:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708537782; x=1709142582; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ViK5NVF7EIFo/pZleuy1lkx+xIl19qVY6tklZU4ucB8=;
 b=E9KyOOZDXeAstynFYGxc2RB5daMq3N+2S89FkBQTNO56LZ3QIiFo4xjncCYmwEKdvG
 /H6xtnNMtuTHa3fGfk+iZ5BNDwvpHMQxQF7+ZXS7k7RZw2JYEfJplhk6zIZvXIvzJMCd
 0NW+KRI9aZGNekrEtE1JIE+uckdJiE24kWohW1aK8qPUi8XgZpEl5KSUUOALKNVR41Nn
 QGBWFRMzUhhER2ghHGwbPaOI3Pi7muvP77DZktE08fWMT1BY72TRrriJo0lj17D0HMaf
 vA/RMJ+bo0pWc/r3TIcpkZqQPoF6VGBz6dHqWdZyPHgWHGNpRTs5jV1YQgy1AGLfvqKX
 yuZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708537782; x=1709142582;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ViK5NVF7EIFo/pZleuy1lkx+xIl19qVY6tklZU4ucB8=;
 b=FDbqZs7z4MInNmyXB3SzxONLc3lE9Sa8qWcKz2IhvZjxYecv0NqMnJeZgLrqEs0jIF
 q8aMh52K30o20+49+oP6l9L6S8yn9SyFaHUWPACTzY3PVhr4b3sF2QXKa7Hdd335GfO4
 Fg0vogSUjEtgMSrQyFbcm3rbq1jWgfeEpvRQ3zhiCBuW0EmA3ewa09v8C7T0lmvINYy8
 0q1MKmmXXlWSRYBFufS7VJvDSqG17KSGms5BsbTU3VYAEOqmIrFHpf95krQZMaohK+Uw
 e3eRnM4oSY4ff3nVO4YzB9ZH0d0WzA1S9n1C+Yjld9ECdwFABKnOX/V4G7/WgJjPEHMX
 rLWw==
X-Gm-Message-State: AOJu0Yz8A+D/QwhEpimriTNfZ3T2jeFAWgrhddAySiqh2AevESakKbep
 1h0BhuiZM3YUDO4MIXw6NRl7egrhySbn4ZRsPRE0villq0iC+KqT7MigzA42BE/FxiBXSFwLJZh
 V
X-Google-Smtp-Source: AGHT+IGrTEIHshzy80zaCWY5Kgh03zC4KdzVrVSXMXFQh3NFCErESVX0hIfh0dVPcY/ePMDjXAdNGw==
X-Received: by 2002:a05:600c:3594:b0:410:d3b8:9f9a with SMTP id
 p20-20020a05600c359400b00410d3b89f9amr13867897wmq.5.1708537782468; 
 Wed, 21 Feb 2024 09:49:42 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 1-20020a05600c248100b0041061f094a2sm3192900wms.11.2024.02.21.09.49.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Feb 2024 09:49:42 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id BE5275F875;
 Wed, 21 Feb 2024 17:49:41 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,  Ilya Leoshkevich <iii@linux.ibm.com>,  Pierrick
 Bouvier <pierrick.bouvier@linaro.org>,  Helge Deller <deller@gmx.de>
Subject: Re: [PATCH v4 02/36] linux-user: Adjust SVr4 NULL page mapping
In-Reply-To: <63284092-627d-4411-a21d-179b8dbf24e9@linaro.org> (Richard
 Henderson's message of "Tue, 20 Feb 2024 16:07:40 -1000")
References: <20240215062018.795056-1-richard.henderson@linaro.org>
 <20240215062018.795056-3-richard.henderson@linaro.org>
 <87sf1s4p6a.fsf@draig.linaro.org>
 <63284092-627d-4411-a21d-179b8dbf24e9@linaro.org>
User-Agent: mu4e 1.11.28; emacs 29.1
Date: Wed, 21 Feb 2024 17:49:41 +0000
Message-ID: <87o7c9aeru.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Richard Henderson <richard.henderson@linaro.org> writes:

> On 2/16/24 01:35, Alex Benn=C3=A9e wrote:
>> Richard Henderson <richard.henderson@linaro.org> writes:
>>=20
>>> Use TARGET_PAGE_SIZE and MAP_FIXED_NOREPLACE.
>>>
>>> We really should be attending to this earlier during
>>> probe_guest_base, as well as better detection and
>>> emulation of various Linux personalities.
>> Do we know all our supported systems support this flag now?
>
> We know that target_mmap() itself supports it, even if by emulation.

Ahh ok

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

