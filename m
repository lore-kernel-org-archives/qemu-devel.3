Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE2BAC25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 05:44:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE0Uh-0007EE-Hu; Mon, 03 Jun 2024 01:44:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sE0Ug-0007E2-1Y
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 01:44:30 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sE0Ud-0004Yb-SR
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 01:44:29 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2c1def9b4b3so1818656a91.0
 for <qemu-devel@nongnu.org>; Sun, 02 Jun 2024 22:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1717393466; x=1717998266;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bFX017E7vF54R9D7CK5reHQUfuOV+AkSJzQ84FLY+/M=;
 b=LC3NJJawndKg7IzZCP5dG726NPorIKiAOxdwC7evrmmfqEWXKUfFnDlLTX5G9aYeG4
 R9zKvB1NoTyTnjsgVWPNGhwlOR37Z3+faWcWUhkIciS56Ocl0pLL5qiz88+5VyKQqh5/
 cVGtey44qF024jvOHPwhiiDrhn3vKZLscz9pJcsMXEUnfz57Yg7LidDtxvxzZqhnp4s9
 uVrYCSnNaHPpFAXhzgrRxUvozR2Uub8DqYY63HvXGYN0z5Pkgl9tzu+tI3uBcwx5LK1e
 +/HWyq+a4WPVvocx08EQU8TwEJ4lL8J6xLIHw5o2DxLa4dKLmWg2whevHX7aHdkm2v4f
 hitg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717393466; x=1717998266;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bFX017E7vF54R9D7CK5reHQUfuOV+AkSJzQ84FLY+/M=;
 b=pEKcdlG9GRX+wh3AsnM5KrpMY8xx52Qnuflq52JvhfRULh3xdWVZLJEEQ2u2dv3tiH
 gKglqrmThRjNiiHUHDQ4bB1p83qIYlbyn/fV5ZTz9Ai40pLXPPn+N/qsnSuMtESi0N6A
 XKGlExD5DITGJbx4iNNfpnbnop7QbUloTfsEnwaebScmN6RcN9NsnZgoYgnqIQlyL2qw
 u9cIb4LevECZEFC5sUdzXfhEMxbJQIahZMblJ1gKq2HY04zBGip0HmCP9EFvAObR+WEy
 mo1FpINJGJpLWZ2R061dgGURdu0/rF8WGXjmTBRaJR41lPDRLbA0qTRqUO33baoOtRVP
 oIaA==
X-Gm-Message-State: AOJu0Yzg5RoTpNXXQ8/eVSp+ITRKvWtHS9bXscCind5674oJIyNnQSNr
 pU67xiwztwzmswycDNOIvVhhJFeUC40ao/3vFOVVR84KKmT+LiHbYsIQPABu+hA=
X-Google-Smtp-Source: AGHT+IEs7EyVCzLMiAwjAMip/wQx8mdBaUuMoZBzOeJMuT4rb5edsJ45e4lGTGKWoQEyHZwPTmbs9A==
X-Received: by 2002:a17:90a:fd8e:b0:2bd:f712:48c5 with SMTP id
 98e67ed59e1d1-2c1dc5dd5dfmr6486274a91.49.1717393466376; 
 Sun, 02 Jun 2024 22:44:26 -0700 (PDT)
Received: from [157.82.204.135] ([157.82.204.135])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c1a778361csm7044335a91.34.2024.06.02.22.44.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 02 Jun 2024 22:44:26 -0700 (PDT)
Message-ID: <24afb7f8-f091-4405-917e-ee7bb0a1e2b8@daynix.com>
Date: Mon, 3 Jun 2024 14:44:19 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 03/13] virtio-gpu: Handle virtio_gpu_virgl_init()
 failure
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Huang Rui <ray.huang@amd.com>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@gmail.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Antonio Caggiano <quic_acaggian@quicinc.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Robert Beckett <bob.beckett@collabora.com>,
 Gert Wollny <gert.wollny@collabora.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Gurchetan Singh <gurchetansingh@chromium.org>,
 ernunes@redhat.com, Alyssa Ross <hi@alyssa.is>,
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Julia Zhang <julia.zhang@amd.com>,
 Chen Jiqian <Jiqian.Chen@amd.com>, Yiwei Zhang <zzyiwei@chromium.org>
References: <20240527030233.3775514-1-dmitry.osipenko@collabora.com>
 <20240527030233.3775514-4-dmitry.osipenko@collabora.com>
 <c9891c82-b139-49cb-9f94-52a96cc20eea@daynix.com>
 <c2a4c684-24d8-4a3d-bed0-9b711b00b169@collabora.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <c2a4c684-24d8-4a3d-bed0-9b711b00b169@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::1033;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x1033.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2024/06/03 14:26, Dmitry Osipenko wrote:
> On 6/2/24 08:34, Akihiko Odaki wrote:
>>> +typedef enum {
>>> +    RS_START,       /* starting state */
>>> +    RS_INIT_FAILED, /* failed initialisation */
>>
>> Is the distinction between RS_START and RS_INIT_FAILED really necessary?
> 
> The state stays in RS_INIT_FAILED once was failed until virtio-gpu is
> reset, re-initializing virglrenderer isn't allowed in this state.

Can you elaborate more? Why isn't re-initializing allowed?

