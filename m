Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF718CCF9EE
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 13:45:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE6TI-0004uU-Va; Wed, 29 Oct 2025 09:44:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vE6TG-0004tV-QF
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 09:44:15 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vE6T7-0002cs-G4
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 09:44:12 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-47719ad0c7dso19722765e9.0
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 06:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761745439; x=1762350239; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NRsBYX/oBXvjLSY1VvIVbRjPQWhxL4pD655V5k10NYk=;
 b=YgPSn8TMh2v++1niEoeXBeTxQVNh+aM3lfkvOPEfElUN+AWdgLlwCoVICYLc+TJGd5
 ttHlNvLMZXmqpzJRzlBVbf7EyUJn+MOrGc+dr1FWqC/gxV0M0Xy4jpwt1XCn0aLL4f+g
 nUOp9xLn+UC4NMk5NXuUK2S4E8LrxW7nE8lIq3nuHjVieRnevSqzCSL4fJx7wdcJXGCi
 nhyKs6qxofVLXaCkQYzt/BP0uvgghBkialz65A93o3pQFJsS3IVEZa+mH5Exg/5wGfjN
 0IZkJTR9Ws32CHIZfc8kX9u2Sbn9LzWGQSJ7lYSHv6RuvVvYncWu2G+Iw9ZBHLapr8k/
 r4yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761745439; x=1762350239;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NRsBYX/oBXvjLSY1VvIVbRjPQWhxL4pD655V5k10NYk=;
 b=iAdTiXhyNE9uUfeIPZXPnqDHAGKmdjmTnWcGz+VzZ1SKaSr0bmDjGuy+Z1ISHJ7eZg
 Mjt7lHtGyD3tH/ABXKN5iOcqJGhdS20E53aPU6IGEqvC78jncDJ6vjFkEFTZETDxZZ9d
 8LxWX2GIzxW3GG/8kIe+ni45ZE5Q4ZEvIM269Ydd0mak39cjXEm/q2zUSTsV3sXyzEp+
 +bUBQ6nez7JaiuQTRlbHeXzqHBi5b/o9oJ91RyvCIfqGicsP5gFW4eQddyfLkayyntWV
 FXh1WDrjrynCuMj7ZOf5FpTBzN5NkIHlcGaZi6/VCfT8oQBaowJu4jea5aWEEFOSLhRf
 jjzg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWH2JLLEwWlPci5Shnops4ir62P1jAaDtnphl8kLsuTw5Tf/Bd0VMIaATGI4KaPX3lMRK1iE6bDfdcH@nongnu.org
X-Gm-Message-State: AOJu0YwQVx7ChPCepR47UhG53S1lTWgB/or+iSGO7dUgJ0mALX/RNp+v
 6/Y/KF3cv3yDOjGnwzXDbCISS/6P6vYqnm0tby5Ra042S2/pPC/UpHegB5SbdjK9gzc=
X-Gm-Gg: ASbGncsYiCGAG7+gZJ0JQfhdNRnrXQpsSOrcqgRTc72Rb90WAKMwCKVBxLn785vjgkF
 ToMWbVrude8HDlIzWsQ8l1l5HO63lNRgLSZftISNVAsQVujlQne6Lpw7GrcXiitwD8EfZQlW2vL
 AwQnx3no8ZNtKoCrM5y8NRHD7gj0/3k0vi6g1V0+/CIt4W/zvB5k5Fy7li1tWFh2bAsLkFcIpM8
 VfLBGQbqFX3529QYQp3y1NnAeNhS5M5G/ylv/ytMZmJrRznZ5SWVO+Va0DCRfuSJEOWOt9+tgh5
 GtDwpRW8+qdwWPmnKkneAuIsOU+i8Z6vFJeYdryOK0ZYgI8IdzbIH3aBlCaxrvyWBHLENT3hbC1
 IrFVhoGlGLrZps9xWkyt298uAMmi9ADnT2H+Stc27+gBrPypmmrg/zdUVD0NO6pfz/gWsk4l0VM
 uRhwWlRgPV8iL4QFl8MSX0UQQtZM7BzyhaQKrpt2hrbgg=
X-Google-Smtp-Source: AGHT+IGOKoA5My+C4OxMpueyTXWYVLkbKoWaifxcGMwvkEqS8t1wbxSmLmY0LIGL7f6bwcXyDQFs7A==
X-Received: by 2002:a05:600c:1e28:b0:475:db8f:ae0e with SMTP id
 5b1f17b1804b1-4771e17412fmr32288965e9.2.1761745438761; 
 Wed, 29 Oct 2025 06:43:58 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4771e222ca5sm52365755e9.15.2025.10.29.06.43.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Oct 2025 06:43:58 -0700 (PDT)
Message-ID: <d7e77944-06a9-4b7c-8475-0e943a251690@linaro.org>
Date: Wed, 29 Oct 2025 14:43:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 14/35] audio/dsound: report init error via **errp
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
 <20251027151045.2863176-15-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251027151045.2863176-15-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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
> Whenever NULL is returned, errp should be set.
> 
> Inline SetCooperativeLevel call to simplify code.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   audio/dsoundaudio.c | 182 +++++++++++++++++++-------------------------
>   1 file changed, 79 insertions(+), 103 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


