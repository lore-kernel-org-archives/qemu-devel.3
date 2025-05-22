Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 934BBC54E65
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 05:20:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHyLS-00047e-Il; Thu, 22 May 2025 01:19:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uHyLP-00046v-QT
 for qemu-devel@nongnu.org; Thu, 22 May 2025 01:19:51 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uHyLL-0000oL-Rd
 for qemu-devel@nongnu.org; Thu, 22 May 2025 01:19:50 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-233b1e4376fso19589025ad.0
 for <qemu-devel@nongnu.org>; Wed, 21 May 2025 22:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1747891183; x=1748495983;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PF9DBrhsOTFqE8++SPnSPBoNs8mjJ7ckZTobz4u+DMI=;
 b=dbdevmSkjnnAJgKTtvwVVsSanP6F6i1N480j3Ivr6xAiZiDRc1FGZG77wQdskpPtbZ
 LT78vb1N5k4gZ6fSbrx2vM1XiI0FtewOtv1Ng77pOH59t8AVdOa4OqtNRzFBI1M0CEt9
 1jyflCF749azQ9JtV9uq1LNckSYHe4VttqP9CiClKmfnpvBbrZ3+nwUtUS/y/zGVZlvV
 sB+DSYxyK2rS2QqMrGzYza0tEQmWslh3DxLxUAvtaSVtpnkOTgU7jEn4qdnt3l4bhlNL
 OLfciimPrCCfpSDrESLzQ+4DRooYV2U4bhpI6n5dOyt01wTz4vpP5ldpyGSoS3VWSRjz
 NcnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747891183; x=1748495983;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PF9DBrhsOTFqE8++SPnSPBoNs8mjJ7ckZTobz4u+DMI=;
 b=tLns/vMjGZ0MBYSW+Fgi6042OOIDmYFF4dQjdMxSz7S0vy6a4fR1BCYUbAdUHS0PQW
 j1tBk+SrWsovqzpBc4OaMO2uJdyrKZxB0ZU4S2zdPMkpMtToo8eWHym1IXDfdrb1DY+0
 unHffeCnkJcg3qFcV01kN+UI/nAKlVWLVktV35tF+gpppwqO4DXR1XxdgSfg05QlOYj/
 nw2hjFnq8PCJCjh/7GrlCtdJPffAyVWtas1Guw8nU2uFBazzxk51VuhAMu4Ci4eF4H5N
 Ivewm+XMBHz1x6um8cwdQKhxCfZUlcjFf/9e8EzRN4NwuRCQLQwpgwYB7nT8nQ6pvDv/
 OCbA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5EgJlls3d8/9BiMe1zvqB154nenOd2Jh3jD0UPp5KvpI9PB0D3E+jJEYO2lSWaAVr62iz2JSv97yr@nongnu.org
X-Gm-Message-State: AOJu0Yx/XpG93v7GUsqSQnah9MeuWCWkbhS2AMmuPe/PLdYga/SGs/Cu
 NiasDascCz+V0SkoYitKm2JwsgwKfXlGCp3cnXKehVSXnKG2A6Pg4CgNg67tB5KSpzg=
X-Gm-Gg: ASbGnctFLcK3k4R37KSphPtuZPI4szAO7bdI6gS0XGWz85v3nZCJsdaXdlsUOkIRRN7
 9u03oTIXcoWL58bAwQaJulfSiMU2UjNbtvT9lv7KIMqMQAvCXAwBjDJYGb+j+UdpPE3cxcYLKcL
 mdAjWgP2jA6X+KeAXQ3Srr1BiMq614pPDn4CxJeJjrlaVx3CtAxjBhy4eJqeqfx/qTbmWsAKZSq
 HFf+UG9DWBTdh43BxsGoyDlAp3vRbh9PTqTNMBb98tstDOOg8zN8oYhXh1+y27SJ0+0piuHOMrS
 b4MezA5kaxR19DRbc2udKugzx3oc1QC+SmtZ1tzwe/uUH7SSI2CTaarMbe3bGA==
X-Google-Smtp-Source: AGHT+IFJab9die+N7MMiqcb/2QSE1Lmc42YVnTc2KZjvkOnJyWrwELuYZGzNr/kiO+1T6JkyEKHjCA==
X-Received: by 2002:a17:903:1a28:b0:231:c05f:29d7 with SMTP id
 d9443c01a7336-231d43a54f8mr325262675ad.13.1747891183562; 
 Wed, 21 May 2025 22:19:43 -0700 (PDT)
Received: from [10.100.116.185] ([157.82.128.1])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-231d4ebae71sm100975585ad.190.2025.05.21.22.19.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 May 2025 22:19:43 -0700 (PDT)
Message-ID: <acc76a26-d6b5-4ff4-a8d6-3595873157ea@daynix.com>
Date: Thu, 22 May 2025 14:19:37 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/20] tests/qtest: fix igb test failure under
 --enable-ubsan
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Markus Armbruster <armbru@redhat.com>, David Hildenbrand <david@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Nabih Estefan <nabihestefan@google.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250521164250.135776-1-alex.bennee@linaro.org>
 <20250521164250.135776-5-alex.bennee@linaro.org>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20250521164250.135776-5-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 2025/05/22 1:42, Alex Bennée wrote:
> From: Nabih Estefan <nabihestefan@google.com>
> 
>    ../tests/qtest/libqos/igb.c:106:5: runtime error: load of misaligned address 0x562040be8e33 for type 'uint32_t', which requires 4 byte alignment
> 
> Instead of straight casting the uint8_t array, we can use ldl_le_p and
> lduw_l_p to assure the unaligned access working properly against
> uint32_t and uint16_t.

I think the subject should mention the problem (the unaligned access) 
instead of the method used to detect it (UBSan).

