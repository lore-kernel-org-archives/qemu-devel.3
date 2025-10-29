Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA77FCCF9EB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 13:52:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE6aK-0001at-Cs; Wed, 29 Oct 2025 09:51:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vE6aF-0001Pi-Gl
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 09:51:28 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vE6a5-0004ES-Az
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 09:51:27 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-4270491e9easo6004015f8f.2
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 06:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761745867; x=1762350667; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=euRmubwCtldlDQVZZTH5D7w0GOGt/trWIgjgmyymC8U=;
 b=m5r7Hqj4+9++/nzaMa65V2OW6lx8KjqEhyf8QuRi+sWmk12CQMpwKN5rhFG9xkRo8+
 TLzlq+SRVuPDAXWOWSrdVRGL0FI+6z92orBeIRIvMAva/CgZeNn5F+e73NT4b7UflWen
 h68tFn8F8s0s6iw8IUidRyEtU3G4wjQA1nPzV4hB1wjpok5TamqgWfPAgHVcrZrx/Vxh
 t3Rdg4Z0EwjMoK74T8gbAqQ2S0vmQHFSB0lFnOb7GU20Pu7LJQQHMX8hvF6+alX0ESWL
 TqtZLKra04tc5dAaZmfHEdoTvpgdi0RHn4sSrPY0vkecRxCCDlEOiK/i9p8AUCdhXj+Y
 p2rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761745867; x=1762350667;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=euRmubwCtldlDQVZZTH5D7w0GOGt/trWIgjgmyymC8U=;
 b=R9hjsIvsEg3/owIsZqVOds9kMxvlfe6sx+uGfNpOqEVZlTrNj4wMQrg5Pdp068e5ur
 PDfFFmItZYpE2uPxMmho6HA7DTYwKp4C8A4LVgghOX3tZR86T3WlYi7H0H4C/gwOIQhC
 Nhig87jkIo7pXM0TKPByJmV4PkTBI9nZHq8LPdwtXjioUjyzyXNMJl8al34G6EU6uBqJ
 6TCVm3sJYJe7dhZQO96Iy9rlyrWdDuefIWSqYlN95yMZUv7fefdSjdsTpypHbSUvuXoE
 X8qC2l1UAnv0oP2yFt+lmZdHOdwaCVk0ASbpzrIVmJlUsOoywWoyizctNVUP8yuoWjm+
 HzFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVuy/dYgM5Tph21kJIIdhAnzmGv8ExW2xucphameV2L4UsPSAR+f2qDQIsrGdqmUqPNU+h8TPXBg/c9@nongnu.org
X-Gm-Message-State: AOJu0YxbRmQYjN8A5pdqsEftJt1uZwAP0tPesCxUcAnhh49RW5kUJhll
 gKvuWy011yaez6iaIvopuje16g71QQEcgRu57ACCPBRZTzol/3wePIaauRUZ5j9cHPU=
X-Gm-Gg: ASbGncvOPI1qLvl8lEz0rkDhJpz7X5MTJEOrU3hKZm9J2IOPmjMBojF+ZtQ62LRDfeJ
 VMY7xeJzHUeDqu/AMw9YPqAzAqhMImvz7eyWdo6yjIFUXucH6godvqjCYhk/LNPRupWA8pXbsJk
 AlAUC/T2PQBmQzdrPEH95NZ2Dz30q+ZVcGZ5d/HWd3hd9fkNp5s6Uix/VKU7zQFo8aW7E3GoaE9
 DpIlcaDipu0ucZOldRxLzv2b5omu2KAcdrn1NalsqzNqrkemM93iSTQfTYczq9eo2cbrmYlpd5w
 f03O/tWTLLGV1e9wm9enja44ZIDk7ayLf6pPz6l0aGkph6o6NUJRanQzWl5i1TaZvCp1BMDxMHX
 HJ3KFSfpo6nxWxfS5zbXaIMBiH9UjjygeF1GD68G6rAzqzwTNX7288COJkdGvjumIg1Q1MsJ9QD
 eBcqNnFyu4pgoRws/jyM4zuOtZwFZ1qkLdFSmrbPOpJ0U=
X-Google-Smtp-Source: AGHT+IEXRNHOgE3ZAwFHNCgWjXdF8+++BhjWtfxZOFgCcGrxoeLm9cXdSbmwvbwfdNSF29jw+RwtcQ==
X-Received: by 2002:a5d:5849:0:b0:426:ff7c:86d3 with SMTP id
 ffacd0b85a97d-429aef78c90mr2735976f8f.13.1761745866760; 
 Wed, 29 Oct 2025 06:51:06 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952cbc16sm25671177f8f.15.2025.10.29.06.51.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Oct 2025 06:51:06 -0700 (PDT)
Message-ID: <daaa6667-d5ad-43ed-96ed-40a8d6fab67f@linaro.org>
Date: Wed, 29 Oct 2025 14:51:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 30/35] audio: remove dependency on spice header
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
 <20251027151045.2863176-31-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251027151045.2863176-31-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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
> It is no longer required.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   audio/meson.build | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


