Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F420CAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 15:11:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0iCB-0000bU-55; Mon, 22 Sep 2025 11:11:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v0iC1-0000TZ-TV
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 11:11:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v0iBz-0006in-Ld
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 11:11:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758553861;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=3Y+9QWimXpDxg6AveCuChFhvWzHU+54yFVssbEDXr/c=;
 b=YzJ8vlbaW71GV1Qg/lUTBKRPLEU4DfRV1mV0VAOoIe8fj9WctedFD4+XxM3kd/j88A6sWB
 woGyfSmrrDXjAVUH60kGlhDCNpaOCZNXJWsa+0H3cyc4RPTOt9dMoGG2b+VxmPPBHTVIaU
 cTILhtG2pZBEkU0TXp7Fh7dpUwJcAME=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-329-7bGnxu5tOVafFs4xAguorw-1; Mon, 22 Sep 2025 11:11:00 -0400
X-MC-Unique: 7bGnxu5tOVafFs4xAguorw-1
X-Mimecast-MFC-AGG-ID: 7bGnxu5tOVafFs4xAguorw_1758553859
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-45f2a1660fcso39038955e9.1
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 08:11:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758553859; x=1759158659;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3Y+9QWimXpDxg6AveCuChFhvWzHU+54yFVssbEDXr/c=;
 b=rYgQ7FuRDlpwCAcAYY8BPjo6zImw9ut3akBxzIghNXw/PHWE+0Y92f9cyL+NhL+P2M
 cS6wH9rNa9IxmKpCDkkQH3dQ8+Dg5bzbaiR5fuiifLac8uU23VtTbDsv7w3ErC+gax89
 JsHluNElbwLM1kbEmYaUaKoW2L0eB1gRESn87kAw0KEfsAT5vw7QdH5eRIOs6EWP8wtN
 naQnRsBN82n/8tQpMjVrxe3BNZc5Hbgh6BX9mnucUxBYGMvHtG7mQb7QVsvup9vu1ogN
 oasqVivkIkpgr8OB5cnSJrOsvtn3aKP0AYyGUbivzf3Fw8OzIGsWezFtUmG8DzZyDQD2
 iXPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXtoYovC/v3no6wyE72QpA7K6+hauHwlGmCiF+AsipdpZLGJGvYvzVhqOEAXHynI88Fz9Tw8d8bHEo1@nongnu.org
X-Gm-Message-State: AOJu0Yz4ZjHJsZ2LS3hynk/HSfb96tdjlSWoap5P+Cw/sJNopzmc28FO
 pbKL/e3CsKme8xekmlosxg4kawevQdKJTxXjFiBOxDWyjvw2uqHo7P68mlevplfxDSeOzCa/GBS
 +g+znA4jzP7ps2UREnTRashtWe+EbYdLMSLomzhLtyREN07z7gy+kuaeN
X-Gm-Gg: ASbGncv4LiQDntbLl50fqIvrH9KiCDYWY/S1wgJftHq+/A5MS+t9B0wFiIgLUFvwj9R
 1YMXTTAa9A2i4w4RhQk5aoqP2pYzGklhXzSyuTyjGQrplOPBdO8pkHgdB/SP98wUsaP54BB0ZPf
 wWwB8rsqAUsp96Gs+JW4dxvHzPcIWwU0IsFITGePUcEm+TrSVOedoxyOHejjXtqUBpy8Sbo9DF5
 uDgIGpS3nSgYBggC51/2SM3wtKcUhhgojhd8Y6yNXoiNxi+RSEVTST+L7ZuBfjmewOi994iHk70
 0ZCcOiuzMUpseizWPxfzkWMbpeBAKVxd4qmAKYRASqR7RP6wBQSi2sKbu1dKaBpMPcHSEa4DOFj
 xVtDZi3V/3VyGx5BbbL9+tlYLFgtt/Q7zAO7S0GBmJrk=
X-Received: by 2002:a05:600c:c162:b0:45d:e110:e673 with SMTP id
 5b1f17b1804b1-467e63be4d0mr115707125e9.4.1758553859164; 
 Mon, 22 Sep 2025 08:10:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGSCEh78yMcLUnp2E0WdlcqOCfLSKSQt/oNCrdDVAKlUOXvOn+zhjS2BzHPDfHFAp/kfulZgg==
X-Received: by 2002:a05:600c:c162:b0:45d:e110:e673 with SMTP id
 5b1f17b1804b1-467e63be4d0mr115706905e9.4.1758553858718; 
 Mon, 22 Sep 2025 08:10:58 -0700 (PDT)
Received: from [192.168.10.81] ([151.95.47.123])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-3fb8ebb0d91sm6956173f8f.54.2025.09.22.08.10.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Sep 2025 08:10:57 -0700 (PDT)
Message-ID: <c94acf92-5f35-45ea-a11e-c85ff7e4d811@redhat.com>
Date: Mon, 22 Sep 2025 17:10:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/24] tests: move mips to debian-legacy-test-cross
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Ed Maste <emaste@freebsd.org>, Thomas Huth <thuth@redhat.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Yonggang Luo <luoyonggang@gmail.com>,
 Warner Losh <imp@bsdimp.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Kohei Tokunaga <ktokunaga.mail@gmail.com>,
 Kyle Evans <kevans@freebsd.org>
References: <20250919133320.240145-1-marcandre.lureau@redhat.com>
 <20250919133320.240145-15-marcandre.lureau@redhat.com>
 <aM1m13xBnM9WU_E3@redhat.com>
 <CAMxuvayXSdVaz=i56T686oKpKf5gE4y6YaPgedPBKGQEPx0v8w@mail.gmail.com>
 <aNERkB5WhM4ePIHn@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <aNERkB5WhM4ePIHn@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 9/22/25 11:06, Daniel P. Berrangé wrote:
> On Mon, Sep 22, 2025 at 12:38:09PM +0400, Marc-André Lureau wrote:
>> debian-legacy-test-cross is for tests/tcg. Debian 11 supports more
>> architecture than 12 or 13..
> 
> If there are architectures in 11 that can't be tested in 12,
> then from QEMU's POV that is now an untestable feature, since
> 11 is outside our support target and we don't want to be
> holding back our support platforms for this.

That is true for using that architecture as a host; but as a target, the 
architecture remains testable with just a few extra hoops to obtain a 
working cross compiler.

Paolo


