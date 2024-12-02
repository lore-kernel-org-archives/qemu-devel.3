Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E2D9D78306
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 10:54:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI43t-0000jD-LP; Mon, 02 Dec 2024 05:53:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1tI43r-0000iv-Sg
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 05:53:52 -0500
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1tI43n-0001M2-TR
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 05:53:50 -0500
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2ffe4569fbeso34873751fa.1
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 02:53:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733136825; x=1733741625; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:organization:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=7i60CMqUFFvcLcI7Fj3fPaX15CPhB+4GrtpNLVeRe6I=;
 b=zhuQ9B+Vzzg130F92SQygII7TspJoup1cO1u9N6PwA774BPVwuY3VG2zatNqcysxTa
 3qoayManyw5N7eKbdNI7O1zvHanuaj3g10PiD3UyWJz1eRdTbpwLQkqjXsPgGRCjym4Q
 YMrINkVH92UVUb7tT5x8lsRQ0dExsNPdugS8lm1xe27UCs3AeTMK+6SQuiU0iKqGcKB+
 q3UhuAgilbqY+OP+PX0zIzaxgPiwGb18+3fQoHyuQrxxTZ6lxU1bZMbbVyJTYLanCzZY
 +7Srtz2akodNY9IsqQYqArLjHG2vZcmizqkQ7WICW0LpToGX6jb7cK31jfh5zIgCPlhl
 gnCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733136825; x=1733741625;
 h=content-transfer-encoding:in-reply-to:organization:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7i60CMqUFFvcLcI7Fj3fPaX15CPhB+4GrtpNLVeRe6I=;
 b=NxHAn7Ht6vpknfKpN3L8FAGDJtLnrKW0HTnIuW5Njk4uvUF6mefpZzbbyl6i4XSBK2
 cn0xyrWrwFnw98sc5RSgnXqrsxaP7oNvU/GH2NqmOT4uMReS2iuSb1y/5ji3hMuzbGZU
 50AT9pil9BN5KzCBBLKjoLMezh/TlCLi+4jjwgsw+1UNQLLYNYdlVT6p3ATbK+GiRT2K
 XLMYtmQL5sStrsziqwSwBNSKiJMbXnOtbA0sZ6OQwT6mKHr/moAFMNd4tRrouBV9sE2g
 eWhUVX2WELegvS4jU+psw7E96NpRNbcMWverQXGl6rSI+1qH5izQYTyH0nTHW96YKSV8
 fIQw==
X-Gm-Message-State: AOJu0YwlM95Qh/n0LgFsS79n8tyWAyTphC1hCxKO2FmQI+3z4xotPMS6
 uCkbC/pl5VrtCJJ9LKRYWqScOapJaOfn1bITYWgG8xJkO1+UcL+YHl68Wi431eM=
X-Gm-Gg: ASbGncviD5ItWfWBV/CVC6Za9orzkB//XhL9x+nMXNl3LszNFXo9tEELmQeBXzVWdfB
 EbAE70g1iD92TtyuqwNiDvEhtzNU/lkP5gCwew/zEUrIsQzQuX8fDX05Pct1jk5f/C9lzoqDY6L
 cwIpLBEcxpJInVqEbPwxlfdn+mZNwU4yK6Qq5KGvZE37FIFpGGaPi4iYjDI7JIqUAh+vCwKhcYJ
 Cay1L3sX5B8ZMwUNpFPNmKBMB9FXbdwBJ2uZ4yfk9pm9beDfO+O5dBYHqDox48LVfPtTzQo994w
 4/lVrrybFuheXwXa2PV8qawdIP7N
X-Google-Smtp-Source: AGHT+IHtEnP3crzbdjOMjNuiwehpbaFCAzjfMSmcWKk/K55nj+jO1VsWCbHhKFwqJyAey5/RDY13HA==
X-Received: by 2002:a05:651c:542:b0:2fa:c185:ac4e with SMTP id
 38308e7fff4ca-2ffde23e3dcmr50857441fa.13.1733136825167; 
 Mon, 02 Dec 2024 02:53:45 -0800 (PST)
Received: from [192.168.210.26] (83.11.10.28.ipv4.supernova.orange.pl.
 [83.11.10.28]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-2ffdfbb8f38sm13814261fa.20.2024.12.02.02.53.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Dec 2024 02:53:44 -0800 (PST)
Message-ID: <cd635753-4e2c-42d6-bb7b-d558d90f59d7@linaro.org>
Date: Mon, 2 Dec 2024 11:53:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] hw/arm/sbsa-ref: bump default memory size to 2GB
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Leif Lindholm <quic_llindhol@quicinc.com>,
 qemu-arm@nongnu.org, Mathieu Poirier <mathieu.poirier@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>
References: <20241126084928.252067-1-marcin.juszkiewicz@linaro.org>
 <CAFEAcA_SkZ+ew8AAVpBHuw-9YW4S5wFbB0Vqx+dBzXf97JGDGw@mail.gmail.com>
Content-Language: pl-PL, en-GB
From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Organization: Linaro
In-Reply-To: <CAFEAcA_SkZ+ew8AAVpBHuw-9YW4S5wFbB0Vqx+dBzXf97JGDGw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::236;
 envelope-from=marcin.juszkiewicz@linaro.org; helo=mail-lj1-x236.google.com
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

W dniu 26.11.2024 o 14:14, Peter Maydell pisze:
> On Tue, 26 Nov 2024 at 08:49, Marcin Juszkiewicz
> <marcin.juszkiewicz@linaro.org> wrote:
>>
>> We are working on adding RME support to SBSA Reference Platform.
>> When RME is enabled then RMM (Realm Managment Monitor) takes 1072MB of
>> memory for own use. Which ends with firmware panic on 1GB machine.
> 
> Reasonable change, but isn't it also a bug in the RMM that it
> grabs 1GB of RAM regardless of how much RAM the machine
> actually has?

I think that the goal is "get it working" first and then optimize.

