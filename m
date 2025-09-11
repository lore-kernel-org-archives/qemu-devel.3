Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99E68CAC58E
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Sep 2025 18:03:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwld8-000894-8u; Thu, 11 Sep 2025 14:02:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uwld6-00088N-25
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 14:02:44 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uwld4-0003zP-JK
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 14:02:43 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-45dde353b47so6710075e9.3
 for <qemu-devel@nongnu.org>; Thu, 11 Sep 2025 11:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757613761; x=1758218561; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oXDo6Tr3Pyup91T1xiHzuXdjiKIBgYUL+27srIgTP00=;
 b=w93zjqcaKQUbv+vkZ9kWt7SU+kHqLLg2MZr0gXJ7oxhV+LDcoPka7vxVJ2WMUhDEKe
 IoU9YFCrQs+YEq6bdb3aBA7QpfKpGHwGb5Ppg8r+chQAq4zhwDJ0hF8XsUUUmr7V66Lj
 iGneCNIkGL0nipJMIwofWS3MEa1kowAKmryDKsz4i4Q3NciB47776IxP/qhMIXHNn5GS
 N2nFocohASLlbBRZ55Wfb8Ia0YJmJL86fwFf66JzQSv7tt8AfQniCMGbF0tB63diC9/n
 /KtpRd83+Bg1XJT3CnamDxMun2uenrYIWo4zVzX0hlsA5WVdsSjERqHggjoFtaGftZ62
 l5Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757613761; x=1758218561;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oXDo6Tr3Pyup91T1xiHzuXdjiKIBgYUL+27srIgTP00=;
 b=kbHFPB5PzOUA20gwQDqlbHp6r9Sdf99A+VTbqfBVUWsFDTf/8hIllfrv5BaDuI/WIK
 PAAbHUT6iL3cBezSAU+cmf1JD0x4veLLGAmz4XmpApn2udOf4jNuM3QBQKDifTlsxUUY
 /DmPWMxdrFmZ34wnzKbbzhKg9Kck5BfSjiew01zVbjcGMglm0R62HZGh/aJ0J9uiWkfa
 toqofyzATNCelJEQBT6a5L0qU1YAQRon0hDII2UdVECiH6opgpQiNrVpztZ6QxsPomzm
 CQDDI+gNMjEJsFKw+V/7DCIAI56+l0FRwghL0z/ahRKpnNsPCx2C4atMckSoXf1T5lKm
 sXAg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVAQLEWhjjNm+Urk+hNctOcvN2jbx3GUY7kpZK//UCeEcHYIua8o72QPNGXglv34/kOjOk+54qkVs2w@nongnu.org
X-Gm-Message-State: AOJu0YzuClDcHl1VMBxnU1oATINQ31GVq4tGU+AUWcK/351fZtdpsb3Q
 5Yu85lhnoehlhmjiwCtQOUWHp7ozSat5BsKPgWCwMQgKvJgAZoDuPR2SQAUyY15pUCQ=
X-Gm-Gg: ASbGncsikQBNAdXtkYKl2Wn3jfZM+Tv2S37gdI5qtwBxSkzvVTF4nXv4v7xa/H5vUVy
 x0J2/xLqcbfPnagE61WqLIW3dZB6YCkYivedHtkf3gwEhHN2JJrrXDYWGUSc/7OwguEVnvRx/Ka
 umpiQTvG1TBoI6GNJBumMzxCBAmtnXouWK3oqfYkHPJvcu6gcNrzLJEUq0F22YhstkPzvmtKira
 gaRA7MMzCnGjzm98i1arCp14WNQCbMDFxDXa1fJU6FyfA3p4NN/VjcmH/88gaBBXuRR3Uwk3+KZ
 Q3ud1KbYyq0SLy/f9RWcay8L2wKTBLQ7QNHqYmVXAkOmoP4MYMWBrkZsPd4dmhz5soADtf8w3WP
 7hveAE33MyFLkE/PigWGrUFSUFN5WAtooqgc3j4H9dXum8DhW0uLtBwK87CkksrOJEjm3
X-Google-Smtp-Source: AGHT+IFsgkM3llF84C1g3eeXbcBmBgu2yb2pVh+jHPDq/7vWq1DzNjc5SqdDv06+4OWKW24rsoreyw==
X-Received: by 2002:a05:600c:6288:b0:450:d37d:7c with SMTP id
 5b1f17b1804b1-45f211f7562mr3731135e9.21.1757613760845; 
 Thu, 11 Sep 2025 11:02:40 -0700 (PDT)
Received: from [172.16.30.12] (ipnet-92-225.static.simnet.is. [157.157.92.225])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45e037c4490sm31778335e9.19.2025.09.11.11.02.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Sep 2025 11:02:40 -0700 (PDT)
Message-ID: <f61b3cba-6401-40ad-860e-45ee39244f3c@linaro.org>
Date: Thu, 11 Sep 2025 18:02:36 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 15/20] util: introduce common helper for error-report &
 log code
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Stefan Weil <sw@weilnetz.de>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
References: <20250910180357.320297-1-berrange@redhat.com>
 <20250910180357.320297-16-berrange@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250910180357.320297-16-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32c.google.com
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

On 9/10/25 18:03, Daniel P. Berrangé wrote:
> +void qmessage_context_print(FILE *fp)
> +{
> +
> +    if (message_format & QMESSAGE_FORMAT_TIMESTAMP) {

Extra vertical whitespace.  Otherwise,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


