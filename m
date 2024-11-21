Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D97C0D75BDC
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 09:20:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tE3M5-000735-Ue; Thu, 21 Nov 2024 04:20:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tE3M4-00071e-8p
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 04:20:04 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tE3M2-0006WC-Pn
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 04:20:04 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-431548bd1b4so5417235e9.3
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2024 01:20:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732180801; x=1732785601; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=k5I7dV7K3xl837YcjJMUyH+X4UpQ9jmN8D70LndA5uY=;
 b=qf/q2e3B/M5w57q2Tzgd9ezG9/EQXkGQj7sTn4ZuIkvEsOX9TcWDgLdlpHDf9xctpE
 wIuDVS4cU01txTAqswtpubIe+RIVD29BxhyVhUEskPtxj6BUCAQ2lSGHKMXc4Lq9S331
 xNoEzQCLKqlljRXP7nWmuR99YTYUe9qK4XifQlWFMMZR3RfjmtsZJTL3b3/Rb25acb3g
 O+wOyteiFjmASvkY8Vd7OGFmx5W3PnWgo9YUsF+RJD/AReiMct+bhXO4NqDDNIxNAPrN
 FRFD0xUG0wMtGzWP+UGevkH3u7aoEtQ/fJ39h7oR7hE48PK/BLdEdxP9D+Kkj3XMwuL0
 zvkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732180801; x=1732785601;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=k5I7dV7K3xl837YcjJMUyH+X4UpQ9jmN8D70LndA5uY=;
 b=oAZFGse+dVl7LRS+QcJzricaTssBz0/Rgl4WA9W+usqIaeCFtu/NQdtP/As5GSOZOP
 G6WKRpT92Pl1ahMPFO77bsrt+Iz1JHuK5MviLIMl98T900Ip2oKGYT6YYcg7OBsMQYeV
 kYGB1NtUDp+AIpeAsV8fskx6U/yc51nXgE5MCx9au7AXq18zf9n2luZ/lsOgTSzM2Cte
 0FrxX6WRj2y/X3bLP7IBdE8BjzraVMYCKoN4tG88lYyFXw3Rxe9d0A+JnvlazZkl47qI
 4naERTqVsxyIdkrJEKCWbHNdLGFjRme8FTYiTlor88Z8AlK4zKyjffpnKuvUwgl3IGUU
 5SZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3e0QtgHBE2tmIIy/zBRH0NdswVi8Ojr7Xqsqki6B3UOsNOUlOn+O3wlOh2fhWG1QE5vAo3Zas6zXl@nongnu.org
X-Gm-Message-State: AOJu0YzuoLX3YRsRop43S7LmLwmlcU8Gf/xLzj1OQ2EdLzhvoxenWsN8
 bqAOoixc9fOV7+BgBElz7h5+IdHwVAjDS8StpsE1bHK3ZQjtlZ7RbYdSiPSy6pQ=
X-Google-Smtp-Source: AGHT+IECbRYGxFd41V3ILoj/olGIV+V0enam/f+P4Sh8L/GxxXjvoz8GV5/r0Ogu+fFlRMdRk4gtNg==
X-Received: by 2002:a05:600c:3b0c:b0:432:d875:c298 with SMTP id
 5b1f17b1804b1-433489b820emr54159345e9.14.1732180801417; 
 Thu, 21 Nov 2024 01:20:01 -0800 (PST)
Received: from [192.168.69.146] ([176.187.204.90])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-433b463ad1fsm47528845e9.38.2024.11.21.01.19.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Nov 2024 01:20:00 -0800 (PST)
Message-ID: <b33c5673-d279-4980-9c37-329d5f43d4f2@linaro.org>
Date: Thu, 21 Nov 2024 10:19:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/12] tests: Explicitly create containers in
 test_qom_partial_path()
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Juraj Marcin <jmarcin@redhat.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
References: <20241120215703.3918445-1-peterx@redhat.com>
 <20241120215703.3918445-5-peterx@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241120215703.3918445-5-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 20/11/24 22:56, Peter Xu wrote:
> Drop one use of container_get(), instead switch to the explicit function to
> create a container.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   tests/unit/check-qom-proplist.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


