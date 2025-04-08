Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D250C36010
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Apr 2025 20:40:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2FjL-0004ky-Co; Tue, 08 Apr 2025 16:39:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1u2Fj7-0004i9-5f; Tue, 08 Apr 2025 16:39:24 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1u2Fiw-0007pD-4L; Tue, 08 Apr 2025 16:39:16 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-ac289147833so1004860466b.2; 
 Tue, 08 Apr 2025 13:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744144745; x=1744749545; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IgUxJfhh3Ozt/b8ulQyeQIxejkkPVWsfOwlbE8S6q0o=;
 b=VLuZDroMFPA1sgAG6e3R2kOY4JJbdUpt/PIx8saHkEMTxjLRVM98nUZinLARfyCmL+
 C2fEuibhTLX/449A4Ez/zdRxgX+Ym9PBXSsXtepM8pDkEVBspTVQ6aTnBNckKm+cenpu
 7dGE8MUjPXcDYWT/f1LtdfaOKeGBmXsUS8D93Bfd0mkNO9rS6L0oCa/+C2Se/wUNuvfr
 DIf9ucOje1/1ZG5onl0IP+khZ14TWK1g7n0c2sEEE7tOPlTzr1CT0qaRU/Y45J3knXXk
 o7pDBDNlMZgUH8E9p0PH//xPb4FiHkE3MT3c1ur9dZKCDUkKQNgHXMzFCl9ZMJ1EYfeE
 LwhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744144745; x=1744749545;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IgUxJfhh3Ozt/b8ulQyeQIxejkkPVWsfOwlbE8S6q0o=;
 b=LC/5dUXDPnuH803OY7q/JT8pTiDQN+zMoVF0mMsREopKZfwMBWESTvuwCOhZOsPPZk
 XIlQcPFS3Oeyo9u+FMNkBRCkxMr8pxpAAB03l+NJ5j57e7w+fV052r6zCfUCkwOtmX2B
 rQvgKYEdgjuRT6t1E0uLcCbZL7ZqSUFUZqRi4UdY1V5FlSt52PrHC6s8FCWsK4opnwst
 e2qWiLroGSN9rEDOWupvw3T/7tBEYWj/CwwSc9KmrntY7EGyXOh9bgBC9NuIOKeERANQ
 kpOOOxSx1eq5EFP8n5mPxdeF2Grax75k3xUgjOrICLccVvZRMSD1WW64I0E6S+S4QCVR
 5OlA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVcWUpIInWwaW9cYgm4L2GookkchkSt6s5Y5kNgV/NdwJjNYNT3BULyfJ8G2AUHQ7tXGYB/vO8nGxHtgA==@nongnu.org,
 AJvYcCWlsb5lkIeg5jFC5ZoQDiSxDbl4Ym0enwe6qQckwaraCOU5fYU9lqAUS5oX2tDCIm+O++pRITT/0Q==@nongnu.org
X-Gm-Message-State: AOJu0YzlVRhUoF2D+94EF9RWi2FXO9Crp1Vxx8hZhqH4NIA8c/zABcnb
 T2B0pxox/tBirZmd/z9WZ72I1vCHgDYptA93f1ZfwHmzjFjIDqa4
X-Gm-Gg: ASbGncsgaP2WZJkx5NA7D4X9YZBAgXlyPxGx4g3J/XI3FcPn8+k1EeFAad5LNhLYIuN
 0ogaK/pydJnNJ5QeDY4aSQcvXU+fZfXsG5DqjkVmjmBUEVgPI8+PlYpW3UNHmLpKr/HWLAJLFyN
 WEcrY0dr7oYX3qNVRvcco9DCoB2LJI5FlcmLRMfPWiqU2nRQtEdCIQcg3ziZ8pVmzsMHDHgnBMd
 Cznlrpid+D9ZFjZK4Q4W6rCgwC/wu2bnO7WUt45MflIk5OgCz7I5BiuB6BBh/7/b4//6avBRoyT
 4Ejxj83vhfMjECXr+qTaEhGauSzxj0hCfEDg+DOYBQjDvoeepPeSKCwjK7vl01YGad639u8CW8n
 RW8a4iAtRMk2s9W0eWV+Sclt7EZI3beKQmLSRqrp/yNp/mpDaoW+R
X-Google-Smtp-Source: AGHT+IGsWTrv1+Ve9DqPSFLNnrJmJwd3ydzfWZBK7nf0ICkh/hYA5VgQAHxNcVtcY/ptu8k3GHxKtA==
X-Received: by 2002:a17:907:6d11:b0:ac2:b1e2:4b85 with SMTP id
 a640c23a62f3a-aca9d5d255cmr10332566b.3.1744144744931; 
 Tue, 08 Apr 2025 13:39:04 -0700 (PDT)
Received: from ?IPv6:::1?
 (dynamic-2a02-3100-291c-6e00-b87f-49d2-cee7-5562.310.pool.telefonica.de.
 [2a02:3100:291c:6e00:b87f:49d2:cee7:5562])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac7bfea16aesm971237566b.70.2025.04.08.13.39.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Apr 2025 13:39:04 -0700 (PDT)
Date: Tue, 08 Apr 2025 20:39:01 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
CC: =?ISO-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>, qemu-arm@nongnu.org, 
 Guenter Roeck <linux@roeck-us.net>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH-for-10.0 0/3] More imx8mp-evk improvements
In-Reply-To: <49539ce7-d36e-42f1-9ff2-771c893e5ce3@linaro.org>
References: <20250405214900.7114-1-shentey@gmail.com>
 <49539ce7-d36e-42f1-9ff2-771c893e5ce3@linaro.org>
Message-ID: <36A1B58F-535F-4129-A74C-EE8C467B91BA@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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



Am 8=2E April 2025 18:57:45 UTC schrieb "Philippe Mathieu-Daud=C3=A9" <phi=
lmd@linaro=2Eorg>:
>On 5/4/25 23:48, Bernhard Beschow wrote:
>
>> Guenter Roeck (2):
>>    hw/arm/imx8mp-evk: Remove unimplemented cpu-idle-states properties
>>      from devicetree
>>    hw/arm/imx8mp-evk: Remove unimplemented nxp,imx8mp-fspi node from
>>      devicetree
>
>Patches 2 & 3 queued, thanks!

Thanks! This is a real quality of life improvement=2E

Best regards,
Bermhard

