Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD5A7C282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 15:19:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tretB-0003g9-J2; Mon, 10 Mar 2025 11:17:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tresX-00030c-Vl; Mon, 10 Mar 2025 11:17:23 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tresV-00008c-KD; Mon, 10 Mar 2025 11:17:17 -0400
Received: by mail-pl1-x644.google.com with SMTP id
 d9443c01a7336-223fd89d036so85540565ad.1; 
 Mon, 10 Mar 2025 08:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741619829; x=1742224629; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9hRR9eFzKTibA6SanHS7Z7NacsATBx5TBcKCL5oIsCc=;
 b=Hbg/9Pf6Bthg2VkvMvgVnFyFfwh1oMYf/M4hkm4R40CKdxMqX9bqAoB3Y7NjrZy5dK
 wRciPim/twF/vIY9QFfIL0I3Jxduu6WufXrd7tFFSVmanvlFCYHfXtB0c+1JqGOLXeFU
 LUtBOJb/B2HmcziRqWTsImNwRXn/UoD7ZDvYL8xfUp5NgkYA/QcGnka7pcYAYVrCnFca
 gArn4bq1V+XNbpvNBw8fzaowfG+GjfIo8xDjeI8pueI+2biweNRy/fToUHWTj7FcR8fW
 jP4uhVUlvTBOsiQ/N9L/AbH86kzOpzZhE6cdjvAA7PmSxonzS+7mr61VwRE2/Fe6Rp5w
 DMpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741619829; x=1742224629;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9hRR9eFzKTibA6SanHS7Z7NacsATBx5TBcKCL5oIsCc=;
 b=bqYr1QMy3HKFiTmipQOj6Y79DwdJ42SGSEKNmpLobDUU3vdH9KpQfdY+xZ6Z2NhBN0
 eMfJRXgkSl4OJhWvHp/oM7awhWKoMeznhxB6aKm+Zj6TdqSW5bfSXLr6Ze/cYO7Epop2
 gmLLpBIHxGs+hF5A/m1qVk3gk/nL9QmhnORrTtLM9vPyYTpd/N7I99rzX8ipQeKveRRd
 stOInZaFQb0sXX5qp5zMsVMVi5maUOTt4O52yhumI8Npg3yOuVSKhDEYpiVF70iDXnRI
 hZRsY3SmrxcH5LyeYPf1TucCkQpPG4BKTLYNPOplTah14f8DudWv8aSuHyIISvRIFrgX
 dj4Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNLsvpyjyRjmkEe/jp+22Uu2zXwajD+tfurNEMA4Y3c/AyW4BizhSx50hPGJtKzhJyBC5UK7Yg5sSHQw==@nongnu.org,
 AJvYcCUcuU3iPztE/Q2DTmvpgOx8JgP4CMas3jl8845zqHban9xQztcCtNZd4DHeYrhddfgic73j0LzfX4o=@nongnu.org,
 AJvYcCWa5qV/85kQZ1C0GMxxTGOPBpqY+lTFzoF5lRLmQI0zH9LhPXSsx1ZWKbWg6MDu4bqaJn8yyrrQOm43@nongnu.org
X-Gm-Message-State: AOJu0YwAMAVZCwfi0JD/jC62+VOeuMjo5fS1er/RSM98/Z6TVlaP2Hx8
 gOE4rfPehhYnrl1K385q3kiTdEi0Xn78AlvjVRJ8YqTRuiY8zVQ=
X-Gm-Gg: ASbGncveHPhVCLCf/e6yq0oeNc4nfGH3ReeBseMh03bzw7D9MB0eF4tJiTqeiPNEx81
 9kCSceXJTdgrvx26A9Kdldp4dqwyqRCofX6PEn/veBOI6OqAGChiKybo74p3aHLJudpdU8ELixk
 hmaXM11TPeRgKcL6xPL1g436Ei6qcmSjzRjzLwNg8vKmEQQyqwsbBwCKVdPidzu7uZ9NETuAfQo
 ePI7uE91jrTJ55CjIn++Dwtm2VVGULnzSEigbQ4b/18nKcorDnOvwbTn8Dzn6jwPuOduflZonZs
 vnl3U5hRVYEP6w1PRpjYvTo9pwv9EO6gYBNkuWCqX6vIMg25
X-Google-Smtp-Source: AGHT+IGoPEqYRu6kEb6iHvvB5lodkJM7ycEzmRHAEsrCpUaTNhIDOTfpdN//UjZ7KzKlSQrUCMm6Wg==
X-Received: by 2002:a17:902:e80a:b0:223:f408:c3f8 with SMTP id
 d9443c01a7336-22428897491mr261740075ad.14.1741619829297; 
 Mon, 10 Mar 2025 08:17:09 -0700 (PDT)
Received: from [192.168.0.113] ([58.38.42.149])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22410ac0794sm79129765ad.259.2025.03.10.08.17.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Mar 2025 08:17:08 -0700 (PDT)
Message-ID: <324d8b90-198b-40df-bd91-02cda9443e94@gmail.com>
Date: Mon, 10 Mar 2025 23:16:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/21] hw/vfio/igd: Check CONFIG_VFIO_IGD at runtime
 using vfio_igd_builtin()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Tony Krowiak <akrowiak@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Halil Pasic <pasic@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Eric Farman <farman@linux.ibm.com>, Eduardo Habkost <eduardo@habkost.net>,
 Peter Xu <peterx@redhat.com>, kvm@vger.kernel.org,
 Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-s390x@nongnu.org,
 Eric Auger <eric.auger@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250308230917.18907-1-philmd@linaro.org>
 <20250308230917.18907-13-philmd@linaro.org>
 <415339c1-8f83-4059-949e-63ef0c28b4b9@redhat.com>
 <7fc9e684-d677-4ae6-addb-9983f74166b3@linaro.org>
Content-Language: en-US
From: Tomita Moeko <tomitamoeko@gmail.com>
In-Reply-To: <7fc9e684-d677-4ae6-addb-9983f74166b3@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=tomitamoeko@gmail.com; helo=mail-pl1-x644.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On 3/10/25 21:43, Philippe Mathieu-Daudé wrote:
> On 10/3/25 08:37, Cédric Le Goater wrote:
>> On 3/9/25 00:09, Philippe Mathieu-Daudé wrote:
>>> Convert the compile time check on the CONFIG_VFIO_IGD definition
>>> by a runtime one by calling vfio_igd_builtin(), which check
>>> whether VFIO_IGD is built in a qemu-system binary.
>>>
>>> Add stubs to avoid when VFIO_IGD is not built in:
>>
>> I thought we were trying to avoid stubs in QEMU build. Did that change ?
> 
> Hmm so you want remove the VFIO_IGD Kconfig symbol and have it always
> builtin with VFIO. It might make sense for quirks, since vfio_realize()
> already checks for the VFIO_FEATURE_ENABLE_IGD_OPREGION feature.
> 
> I'll see if there aren't other implications I missed.
> 
> Thanks,
> 
> Phil.

I personally suggest keeping the VFIO_IGD Kconfig symbol to prevent
building IGD-specific code into non x86 target. The change Cedric
mentioned in another reply [1] moves VFIO_FEATURE_ENABLE_IGD_OPREGION
from vfio_realize() to igd.c.

[1] https://lore.kernel.org/qemu-devel/20250306180131.32970-1-tomitamoeko@gmail.com/

Thanks,
Moeko

