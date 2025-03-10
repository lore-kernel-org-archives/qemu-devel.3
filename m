Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C583AC282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 12:26:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trcD9-0001GK-5z; Mon, 10 Mar 2025 08:26:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1trcCL-0000xg-H5
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 08:25:38 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1trcCD-0005T8-7x
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 08:25:30 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-225477548e1so26497295ad.0
 for <qemu-devel@nongnu.org>; Mon, 10 Mar 2025 05:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1741609523; x=1742214323;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7V9GNVR1JkwU3wkKuqtyi6BbuP7GCjEAxa04CYcqdpc=;
 b=HkUSOPY7l3OWQJDQxUhjwq2drSc3QYaazkx52d0dBliCgmZk8ud2/kKO/rxuDSMpg3
 Woi8Dx0MVDTmQeGAutZs68ogCzicNffiWlb79AQ0aLrsovVYXeMfto0TCTcv5EBCIzfB
 YsedUZV+cmv7ta4slYRfQjMf2JTCRaO+QHOiFJm2UN/InXRipZZo9J1AedO8AdzqVKFt
 MxHwMamIKF5uCMHGSHby6lQ3/CgtcYLRyH5Ekh5uGMrW25iTFETbYMjSTA9/MVGP+0WL
 RJ27chScgnWbBPKlA7E/WNabuAGD3s9gaa0n1XVBGa/onkOxAqcV4MG5CDTDi/aDirhC
 jAyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741609523; x=1742214323;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7V9GNVR1JkwU3wkKuqtyi6BbuP7GCjEAxa04CYcqdpc=;
 b=eGWtsuPkjs6BDHvf3StxFEnmeuZ4xbiy8YDAIhv0TBFAvzbrP/2fspg6dM1V+n+Sq1
 OeByqjy/1LA+Y2rezCc/8iLKRUsG2T13xdxN9QyicbWlOhW2NlU8cOrcC+P3KF1bcPhH
 j49K/Csm35QdolSw52O5Nw5EOEjj0MwV99jHgTmMowXzETt3w4/akwMDusbJNJon2xh1
 2A9WWkn3LBa4ir6aXRs5lviOtF/Eivtr/99PRLRI3nzOd4vBucZDX2Ug+EkTOycJtN0R
 /6oWYF1HCg67hs8wem+JAkUgKz21il6wHFKc+nRQEPqyjcgiWRrFzQ14q4gIOTab12L/
 7Zmw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhHJYoTGwFK5EIeoxB0RDoHCXJaMWOR2JUpzGQ69uBfj24yhweaUFuyjGbXz/16xp2gCtFGpb9pGvu@nongnu.org
X-Gm-Message-State: AOJu0YxKA8DbsY0kOTS4Pnt0CwOWsonL5vetj0RGSA81AxC6j89a5iUm
 B6ncUg4/UyzRoENmXOnGyOwoQgY+ny/rze59cTloJD69hjRDmP/K2QNrqdkh+MM=
X-Gm-Gg: ASbGnctvydEPGQqrER+0rEQKKOBWyA6iwWe69M25vyEiO0/GVDFq9itJRp7IqU6Vw5j
 vJhTas/+64HMBSDN0md4lOD9pnlSuUt8kE8k0ngQ1AAf+2//NQMqM/VTGRdwBM1Mj6BJRq0nyDw
 Gl+9yTRjt+btVZ1IpyX4yVKkHk4lMDKX99qi/vw0yJb54VVsEe7PsCfkmED0WcqtwOr+fn6bCRv
 zHMrx8FnlpHRGB2BzhHuPa4sqo0qOXn25iML66TZZ/wNEYTX+uG+Ajvh0i07NjVb9dGvTKrxAAy
 Sc5kgnRcyObKwsXjlZ6iZY2qkS3Latk/dAMpMJBaYpu+8nNzy2PqxyIi2w==
X-Google-Smtp-Source: AGHT+IGgoBbFFfbzm8DhmShJ5WW8zcVjMpVtDOA+Wgn4aas0yiijSkbYbAKXnoAfFLDg2cwTi/ZesQ==
X-Received: by 2002:a17:902:e812:b0:211:e812:3948 with SMTP id
 d9443c01a7336-2242850b42amr214076395ad.0.1741609523196; 
 Mon, 10 Mar 2025 05:25:23 -0700 (PDT)
Received: from [157.82.205.237] ([157.82.205.237])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22410a91cd1sm76136715ad.177.2025.03.10.05.25.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Mar 2025 05:25:22 -0700 (PDT)
Message-ID: <06751210-413b-499f-8ddf-05659179fdb7@daynix.com>
Date: Mon, 10 Mar 2025 21:25:17 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 10/10] docs/system: virtio-gpu: Document host/guest
 requirements
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Huang Rui <ray.huang@amd.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Gert Wollny <gert.wollny@collabora.com>, qemu-devel@nongnu.org,
 Gurchetan Singh <gurchetansingh@chromium.org>, Alyssa Ross <hi@alyssa.is>,
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Julia Zhang <julia.zhang@amd.com>,
 Chen Jiqian <Jiqian.Chen@amd.com>, Rob Clark <robdclark@gmail.com>,
 Yiwei Zhang <zzyiwei@chromium.org>, Sergio Lopez Pascual <slp@redhat.com>
References: <20250310120555.150077-1-dmitry.osipenko@collabora.com>
 <20250310120555.150077-11-dmitry.osipenko@collabora.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20250310120555.150077-11-dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x631.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 2025/03/10 21:05, Dmitry Osipenko wrote:
> From: Alex Bennée <alex.bennee@linaro.org>
> 
> This attempts to tidy up the VirtIO GPU documentation to make the list
> of requirements clearer. There are still a lot of moving parts and the
> distros have some catching up to do before this is all handled
> automatically.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Cc: Sergio Lopez Pascual <slp@redhat.com>
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> [dmitry.osipenko@collabora.com: Extended and corrected doc]

Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>

