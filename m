Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06BD6D1715D
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 05:12:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t37Be-0007cg-Jv; Tue, 22 Oct 2024 01:12:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1t37Bd-0007cV-7V
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 01:12:05 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1t37Bb-0002n0-42
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 01:12:04 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-71e585ef0b3so3977446b3a.1
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 22:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1729573922; x=1730178722;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dHPvtn0Ny0oILoTP4tn8hwP7lxZ5imNUOr81aHRq0qE=;
 b=k1/QriOLw3rIyy5TbNJiQL13rnJ/mlVxv4PzO+MYVWA3PYaMlrMGpczYncZjUv8z+J
 TR/7F0fpfyf9ej1tjAu95TJzIjcYm3PFw1/dw19qKPkWpMDQH/0dAcOt4IDQ47eKm4d6
 2ABh+JbQLq+sd9GspI5a3ojiHYus8o7TGBrj758VMzALfRyH5zgzsyZeIl/JkgVchxZt
 CXnib25h1f4aCI6zFg2JXGD1Jn1yc+dzZt3gZz2Uhoi5TS744SQl8iRc+44nasrl7PLf
 UXAsEYprb7s3Wria0mTXo0YiL7qQHpXaYBIgX0AvaaR394jngAE0yOpwOobLIQYYbh3A
 Pnjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729573922; x=1730178722;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dHPvtn0Ny0oILoTP4tn8hwP7lxZ5imNUOr81aHRq0qE=;
 b=BuGLA67eFb+cmhetKI/o5F9IIGaA5YH4J6C4AE1wkZsQfGwzHS7sC3ZhDtoMWmr5ci
 wsdSPAthMU+efmb0ZHcAr7gqEHftXsb4fQ+xeDdKnEOLMqeQiwpzXO5iYjHG6ndsGW7h
 ffZPSODFWmDAYmFfEDKteRaoKaebVrEyyx85PooR3Wlba38OZHzHlNQWF0dxSFkckQ/x
 g0QBy51U1k+A1FZfE3t3vB5ISEwFnu+QFIn3bEZ7hlrZqeH3DknhCXRV3AD6HKkZF1XS
 KjaJ1unmveADGrOTvICATZCfmAXnlyw37JN5TrvWRdSFBWOM+gnr6oIAWvLp7Yvhck7M
 wRCw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+dt99+s+LG3QlJ4H7SM45DYZiyVik3GjEsNWKncuJtdkj/7d/OpC04N4svznYcSROe84hwS7BE+zH@nongnu.org
X-Gm-Message-State: AOJu0Yx7eeZmtuo2poBZUBUqMLnfl3Wbdyb2bglDhU2S8Jd4KuABsf+8
 yF5pGrZoX1OeLgoBiO+4Qm+DOlBrFRSCBHJwbktIkBeCRDpNGcgwYV1kqK6pWtQ=
X-Google-Smtp-Source: AGHT+IH8GxfANozYLbbafR9gTAH5Wct4ci8/z6cb0IgwUNEo63vbl3GEt5+lln/iDlBlq8CZWH7vMw==
X-Received: by 2002:a05:6a00:3e01:b0:71e:6919:f295 with SMTP id
 d2e1a72fcca58-71ee5afed7dmr1866352b3a.28.1729573921598; 
 Mon, 21 Oct 2024 22:12:01 -0700 (PDT)
Received: from [157.82.202.230] ([157.82.202.230])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71ec1332f3dsm3836720b3a.53.2024.10.21.22.11.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Oct 2024 22:12:01 -0700 (PDT)
Message-ID: <c02c2bb3-c5fe-4675-bfc5-2b99fbf78f42@daynix.com>
Date: Tue, 22 Oct 2024 14:11:56 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] virtio-gpu: Support asynchronous fencing
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Huang Rui <ray.huang@amd.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: Gert Wollny <gert.wollny@collabora.com>, qemu-devel@nongnu.org,
 Gurchetan Singh <gurchetansingh@chromium.org>, Alyssa Ross <hi@alyssa.is>,
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Julia Zhang <julia.zhang@amd.com>,
 Chen Jiqian <Jiqian.Chen@amd.com>, Rob Clark <robdclark@gmail.com>,
 Yiwei Zhang <zzyiwei@chromium.org>, Sergio Lopez Pascual <slp@redhat.com>
References: <20241015043238.114034-1-dmitry.osipenko@collabora.com>
 <20241015043238.114034-6-dmitry.osipenko@collabora.com>
 <9362f8ac-5616-4f6d-b424-3a2b679c2141@daynix.com>
 <f79ebab7-fe1c-419d-89d5-6238b0b36ba5@collabora.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <f79ebab7-fe1c-419d-89d5-6238b0b36ba5@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::42a;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 2024/10/19 6:31, Dmitry Osipenko wrote:
> On 10/18/24 08:28, Akihiko Odaki wrote:
>>> +static void virgl_write_context_fence(void *opaque, uint32_t ctx_id,
>>> +                                      uint32_t ring_idx, uint64_t fence)
>>> +{
>>> +    VirtIOGPU *g = opaque;
>>
>> What about taking the BQL here instead of having a QEMUBH?
> 
> That will block virglrenderer thread writing the fence, which in turns
> might block other virglrenderer threads.

Looking at virglrenderer's source code, the thread writing the fence is 
the only thread it creates. Otherwise virglrenderer's code should be 
executed only in the QEMU thread calling virglrenderer's functions, 
which always holds the BQL. So taking the BQL here will not interfere 
with another thread.

