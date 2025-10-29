Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB7F3CCF9EB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 13:43:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE6Rx-0004Tq-PG; Wed, 29 Oct 2025 09:42:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vE6Rv-0004TM-7f
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 09:42:51 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vE6Rp-0002N6-QX
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 09:42:50 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-475dbb524e4so30451225e9.2
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 06:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761745362; x=1762350162; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yLXEqp9AMFVQkqy41V1LQbG8mPckdyIcZyzJQ1+3qok=;
 b=n7HXwOVz2ewJMYu+me/nAqZsYVbF4VS4Nk9/ouFcIo0TezgMxY89bEX8/2H0K+dqSW
 p5fKS5cvYgbgJHeT9YrMQpsucCch0E6XDOCKf7/5LTZs6XGD4WOnPKBSdal7ahp3e8lh
 9j2AxwMh71PnN47D6yi6xgdiA0QHYTuHrGzpAos62Rwx9KZ648KAmkTzsEfTlQQRV2XO
 vxTpILKVVDh+IzLUNAJ+BG+GaG589JgEJ2RsLvjfJVpqVtr7zcmBoMGJg5wmneiDI64O
 cxGxWimcCpP5KmuGKg7O8Zi45MuAr5Ntvb77DPcJy0ChcHiExhaM3XcbVVyR785fyG0Q
 xYJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761745362; x=1762350162;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yLXEqp9AMFVQkqy41V1LQbG8mPckdyIcZyzJQ1+3qok=;
 b=owcnTmtzfUbofPmnVGPy9j9JGcrQTrOaUgkOrNulS9UlYVQS6wRZCF5fQnCkU3k+8i
 cH/B93ZprVyTCh6bLrcaUXL5KdqvqrU+9gG8cWjbp03IuIuntzqAlzEdL3wv/PMhFQjV
 roVDvgTCvz3SXF1r/YL2KZ4xw8J36BScRE0k8k5ogF+YpI6kz7p6WocGO86nH5e4K9Gf
 XVAm5DQDgXzxeZ5I6yj7xC6gbDKYs+DC/uq61iLdxLKjgtjY1oXvH2wJqpxIdE7L3JQb
 Q1A1eltuAHNDrr8rHjSxySpBRJ35pf+fw6hfhF1OP00nKbvH1qN6Og+j5T4Hq59oFbyR
 oohw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQEZW/D2Cd7jNVEI0gDu0gzF86zMxzVheIPbXg89XnIzQBeNckLy/RRBIttE6g6e1pW0EQnzLe/DvM@nongnu.org
X-Gm-Message-State: AOJu0YwQYdvGF6Fd6IB2uDDWkb/8HaTHiipYA50q/NtXvDTkiSS5zNx9
 +hzZVJJ9I2ySjAcd6V0DoqNyKtZG5CMVpJ6pbGToz2htzW28RrRek7LIHuDGrFjE374=
X-Gm-Gg: ASbGncupi8KCPVViv/I/IWu62bwCQ0e79Aj6bTnSwfcEKf84SnMDZaE9LXCxt4ZecaE
 lrGGlJ6WsIaDeuHgQg4o9XAyTJqSLWdjE49O3HeyU1uNoRMn9ADHAsDVv3rTqN7LpJwEYkeFZE4
 E+AIRERGL370jYsCHAYF53zmk18jTB7JCbzmegOAVFEg1/j2MY19AfdoNCSY7SgvCQON3nOFGPH
 DkePE6kIQ4jkmU2FiwnooG+OcLd36c9xud58r1rYCbprtU9c/pBRqHqPjQ8m34FvzvTeSeTe8fi
 lpYAbNB3w/P5OyhqqbHFWvMIGHR1f1gO89ZO4j2RAbfIr8+gRQrQJ82tPxxDuhDdkG2hejwf7lh
 4IDmLCs7di9kvMo6WeyPREro+UMtbG8AfR5yvGLkuGshII39/5m/OQz07igEL3HneRbjUjSdp5Z
 wCQAxOoPCXZPDCmNztnwbttVf6APnDbMboLgakx9TjOGA=
X-Google-Smtp-Source: AGHT+IE1hmcoBZoZObbarq/8wPi5BLyKPTgD2lU/IyYdYctNJopLmVgddbjhI6ZCMqV0GJ+8k5oJOw==
X-Received: by 2002:a05:600c:4e09:b0:46e:206a:78cc with SMTP id
 5b1f17b1804b1-4771e1e1079mr32781795e9.28.1761745360541; 
 Wed, 29 Oct 2025 06:42:40 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952da645sm25223925f8f.30.2025.10.29.06.42.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Oct 2025 06:42:39 -0700 (PDT)
Message-ID: <2c4470f9-e71f-4c2b-acdb-860648c2e571@linaro.org>
Date: Wed, 29 Oct 2025 14:42:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 13/35] audio/dsound: simplify init()
Content-Language: en-US
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: Alexandre Ratchov <alex@caoua.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Jan Kiszka <jan.kiszka@web.de>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Thomas Huth <huth@tuxfamily.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-ppc@nongnu.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 qemu-arm@nongnu.org, Alistair Francis <alistair@alistair23.me>,
 Zhao Liu <zhao1.liu@intel.com>, =?UTF-8?Q?Volker_R=C3=BCmelin?=
 <vr_qemu@t-online.de>, Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Laurent Vivier <laurent@vivier.eu>
References: <20251027151045.2863176-1-marcandre.lureau@redhat.com>
 <20251027151045.2863176-14-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251027151045.2863176-14-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 27/10/25 16:10, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Use dsound_audio_fini() on error & fail if the capture failed to
> initialize too.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   audio/dsoundaudio.c | 29 +++++++++++------------------
>   1 file changed, 11 insertions(+), 18 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


