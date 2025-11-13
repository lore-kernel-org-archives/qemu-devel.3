Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6772CD5BCF
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 11:59:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJVzN-0007wU-Qo; Thu, 13 Nov 2025 06:59:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangfei.gao@linaro.org>)
 id 1vJVzG-0007lt-NH
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 06:59:39 -0500
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangfei.gao@linaro.org>)
 id 1vJVzF-0007UT-7m
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 06:59:38 -0500
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-5943d20f352so760950e87.0
 for <qemu-devel@nongnu.org>; Thu, 13 Nov 2025 03:59:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763035175; x=1763639975; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VVJadbzVhhoEha0LPWhaDRWNxXnQUDBpTDgn4MKWgo8=;
 b=Wkk6Q2oHmvwLPtH+LfFV/aguAHkYRBlTivhdEKzhYNUlEmkuHT8ApUTVYXd4djHqNi
 WPfHChZGbLLRnxShEB+KPNJ/9Hfx+GD6N/3uJpxMBZZeuZzmZiARaTw+Y0oclANKgKI1
 G8BTw1DskeboaivX8wXh+h8PdaJoJvdMhdt+Nzpcst0qELID9MVT/Xn3faXRIv+WZ1Dh
 oMsegouBCo6OnaTMM19dwSE0p+vMkf4xFB6Q/+BwNvClWbp1x+hUBvdwx716XThXxj/p
 4iGkc69I3wAV25b0gqKqKVEJZDFM4k+3debFmlMczor0NMRlohWyKS2PXO0h1jTKlPS6
 QYPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763035175; x=1763639975;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VVJadbzVhhoEha0LPWhaDRWNxXnQUDBpTDgn4MKWgo8=;
 b=FGbVZzY9JHWE/w+cco558bnvxwXJ+9hR2ilN9Oxb+YSsUrp+GerzXGQkDTqIq61CQ+
 F04z6BDUtK66mh2u8xKVCVjSmGDMNkkDj1t6FCx5g8Tk9jewW/5R+ZgI69aTWPVj3WZ0
 rovUtR389QIXXnOZEwa/C7BdCRsA5itpLFEAUG5ZTYdICIWqqYotNFKE7by7Otx2g82d
 5jxcXoRqtmknDGmVhNxpCbHF0eRwkj6LQJq3E/15V7ECHI90H7zRnbYCkzSX35nG/e9M
 GsMs+JCRPAkjHZdzZevYb4kmsTtBsqpw8RLswYColMyJVpRJV2YrmBxvZyo/vRAvMTsZ
 QaeQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRr9id6EQQZzlHq4o3YcfzxUk5i3dARlqq88IiVM+Lsnrvjaap8dY23RsEYETMC3/UPGlM9LPxrsVn@nongnu.org
X-Gm-Message-State: AOJu0YzdH1rn6VLG0zaCS4f+gN3TkfCFRwZAah/daHKfkAgcliF9DL9/
 OZNvmm1tcdFxaV0b5mQ94VKSCn8BXojTCC9mgWQzBvgpqqrHWYP0CMX3yzxs1zKxRAqsPXlT4w9
 je0b1s1mMdc3H3YBHQ2tj2cUmj35G2CynX1pXPIzF6A==
X-Gm-Gg: ASbGnctaK/7240JAq0vVZOQipP9Uy99f+Z4OT3LHjNZ0i8xl+k6+orcllCdR2i9UGZV
 vfgjlBq3X8BfK47/5Ah028OwPj/oEdJEDFSbrXLU8ne59sg2c6Ar8ZupBSEJksFdVAFMJp6CpVp
 4GssWL/nPaTSpZlKJ2PUNklo97vSshx0UabfF+XyPfv19xJWE5AN9KLFUTk7jQTD5i/KfRWaZ6+
 CAdnfgFYmlh3PBC9/F9a1SzV3BG/13xUKaM++UH6KbEBJwktUMuuBsBTYaExQLXhKW1BZM=
X-Google-Smtp-Source: AGHT+IFUKG3nA//YaQZBuHjirAse05rPxxeRjW44qBb+wCs3IC7oXEFZxFPsGPEsIP/mglDiIDCeRaa6jvwEsx0yX7E=
X-Received: by 2002:a05:6512:31d1:b0:592:f5f9:f5a9 with SMTP id
 2adb3069b0e04-59576e3c63fmr2173275e87.36.1763035169628; Thu, 13 Nov 2025
 03:59:29 -0800 (PST)
MIME-Version: 1.0
References: <20251105154657.37386-1-skolothumtho@nvidia.com>
 <20251105154657.37386-5-skolothumtho@nvidia.com>
In-Reply-To: <20251105154657.37386-5-skolothumtho@nvidia.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Thu, 13 Nov 2025 19:59:18 +0800
X-Gm-Features: AWmQ_bmjYJUBjMNzxIUksNR0XPxJr5d2Yqn1M4Mu9ond4jTJYqg2__y0xHK2CS4
Message-ID: <CABQgh9HzB9yCD_rYjGFX5ZC7RX2e2iVu_FZPU2Vm-kuf3jfm+w@mail.gmail.com>
Subject: Re: [RFC PATCH 4/4] hw/arm/smmuv3-accel: Read and propagate host
 vIOMMU events
To: Shameer Kolothum <skolothumtho@nvidia.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, eric.auger@redhat.com, 
 peter.maydell@linaro.org, nicolinc@nvidia.com, nathanc@nvidia.com, 
 mochs@nvidia.com, jonathan.cameron@huawei.com, zhenzhong.duan@intel.com, 
 jgg@nvidia.com, kjaju@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=zhangfei.gao@linaro.org; helo=mail-lf1-x131.google.com
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

Hi, Shameer

On Wed, 5 Nov 2025 at 23:49, Shameer Kolothum <skolothumtho@nvidia.com> wro=
te:
>
> Install an event handler on the vEVENTQ fd to read and propagate host
> generated vIOMMU events to the guest.
>
> The handler runs in QEMU=E2=80=99s main loop, using a non-blocking fd reg=
istered
> via qemu_set_fd_handler().
>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>

Still don't understand how to use this vevent.
Is it to replace the fault queue (IOMMU_FAULT_QUEUE_ALLOC)?
And only find read, no write, only receive events but no response
(from guest kernel)?

By the way, can we use vevent in user space application? not in qemu
environment.

Thanks

