Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFD0CF0180E
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 09:05:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyR7b-0002IU-V1; Fri, 06 Mar 2026 04:05:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyR7S-0002Fj-UD
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 04:05:15 -0500
Received: from mail-yx1-xb133.google.com ([2607:f8b0:4864:20::b133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyR7R-0007K6-Il
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 04:05:14 -0500
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-64c9a6d68e5so6775642d50.3
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 01:05:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772787912; cv=none;
 d=google.com; s=arc-20240605;
 b=bHWXpFnf9UZZUmPq7tfFJVulyz4quspYI41Klp9w3+BIKKsl8a3xxXyW8WkK6X8bsd
 FJpV7a43U/1RdFTzAvpyfdXYLt7MEZEBxmcx+zLEAaiq3+qxtLFVtTWjbV2TdtqOWRXE
 vp7UaweoyB4wFbuTG9GgCgOc1DWKuAlbfxpcK8+NfsaVkPn9hLmzzt0MFf6xFE/s+I5k
 xqaWu/0LabF/QwLSC33vbUbhG9f6tW4e14jKh6uHapK2+/Ncsg1LBGb8HqTl84J44/FA
 PWWVD7DwSh+Czm2eydQ2Bwo3x4tW7qEylCvyWQeFlTkMPhhxkJYkXsov8aiI3NlSZDDb
 sVNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=2D9mnmF9YIc1ASiULt752ZFEY40HMTd19gFA3OqX15I=;
 fh=jjZEu7rw45pNspIPqJIQrqSqcalXiWsfo2bfFRX5zu0=;
 b=K/DbSSqm2vYd1bJgXmoLA4137Mskp6fNhFpKXMpPIS4XX+pj4abaT7b+98l1tVCNvH
 5xpq1ckrdQlnrZnUUUNODbXSc8X3E61ISJSkXLCAEOhmjG9ZQGn2vyQKS6/yauo4TTDC
 IbkDKGhRD3vSbTi/cPKpG8xkN7CIyLjbjF71ro57sSIUAFPeGmSalRiiMKmdEnuUJVtR
 wOL9Qv06P4RgiAxHLb7x8jV2M2FSlokITk+NI39ifi7QAOYMYGQ/camCVDPZ57dhxOeK
 efttnC9v5fXhoATRmrC07CHYeZ4WG+OxgiyNlC5y/I7AmOhMTlrOLpbioAnNYJg4wplM
 lVPQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772787912; x=1773392712; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2D9mnmF9YIc1ASiULt752ZFEY40HMTd19gFA3OqX15I=;
 b=mIBpYgTjcBdFUJzwtg3FApa8ukoIyym3OnZmlSTewnvwHTVD67N4LwynjN9RzrQf7Q
 dcGbL6g6gjThT0E6JsSXq/GQVuWHRsGe2DpYGurzcK9XMguB5R/8pI/pIOTIA9kzD38j
 b0UwwQt1822KdbYbSr1E+vlWry9ejtxxnnMIYMPLSvEijrtBfrkIJ0K8lqDflI9Wq6e9
 mmgL0z5kDcH919O2eDtUOfdViwEcFQqQ0ncqelVt0iXAcYgFGleZxcmSYV6WKyHqJzth
 dYsB34yfEYLS9nzmpNoTbH33xTuPa7FomlOnk1IHKlKvGfbs9vaS4Y3LLoYJc9TIQI5S
 H1bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772787912; x=1773392712;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2D9mnmF9YIc1ASiULt752ZFEY40HMTd19gFA3OqX15I=;
 b=URaK1SiUsSQ3bNjt1KUUegKU+H3aSyHF057/wVNQVWjRVXSl3iECh0eAypz5PVFqvU
 mr30emzKWB4Jf6tImTcJm0lYGg6T+v8BMnLps+sc9+Xn16LPfbFGLm0c3ItBHBRDPzmL
 hcHXnwfrfFBtZ5Ez33dIxcb/nvP6tkdmbpFlG6vqO3P5ZR05TPrWtlqUCd/pteJkkrEl
 Gy9tV0YKdpmcUJvD3GuBOnjKFGXoR6yi2kYItL6H2ngJIuQRa49qm94Z/QKt6epK7aFq
 jFgoUcxAZG4KlonDQ0daBXHEWsEi2mqbyZrzU3xFwth4pNE/vHc3h1aM4DUEbZYzJZ16
 pB9Q==
X-Gm-Message-State: AOJu0YwbOIBXph1zC4fBlqIOYFKlO4ww51gmmCev4FjaDSiv2upCaB5C
 ta/6CjL3ALWDm+Q+fZCI7XtFSzywjK1Is7yd+F+Px3pTuqaG9WlFD4U3NH2yKikTZYmoTey6Udp
 Ob2HCBL5ZrZrxuJgsZ7OkrzrDc1WUPgCaO5uu2cBsFg==
X-Gm-Gg: ATEYQzyzx676NtOIKkKrXqP9jI5hxs8OE5BdwwSM+6uLhLXGI0u1JsiS57jjHiaHJLT
 RncO1+dZg4u9ObA+W2aW5lbY53gb7sr532TH9axNXN/u7mJmaKMPS8AhNkP4UfP/1j04k1joEUf
 hpAfzK9JHQKYoirk5QGKB5dUlfonG/1Ww8Rtk0LDOpO7HDJUT7/U8QpzlnUhO0Ohls6Udtxc8Ao
 gvabs6nhxcy5/7iM36tg+ZQ4pXQa4WicIwcWr/UKKX0oq8l3hvDNe1cYNtuKV2hgr/snrykXW7j
 upvYbUhIj+ZJjm3JXOytuxK0Fk0ztOyFCirYe6qunuK78Ol8Q7QlPMiYmtao34bovamRCU+hTJ3
 N6g==
X-Received: by 2002:a05:690e:4192:b0:64a:ec39:dd64 with SMTP id
 956f58d0204a3-64d1427be45mr1108120d50.43.1772787911735; Fri, 06 Mar 2026
 01:05:11 -0800 (PST)
MIME-Version: 1.0
References: <20260306083113.74177-1-mohamed@unpredictable.fr>
 <20260306083113.74177-2-mohamed@unpredictable.fr>
In-Reply-To: <20260306083113.74177-2-mohamed@unpredictable.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Mar 2026 09:04:59 +0000
X-Gm-Features: AaiRm53vWqwli0FhM_mGRBpWQchwO7OdoMSJ2p2kh1F5wemoaiGQOuTQodt80jw
Message-ID: <CAFEAcA_dXMOzHuisenC+uEq5CyXBLgAjrA0SWVf8e+bmJ4Gsxw@mail.gmail.com>
Subject: Re: [PATCH v14 01/19] hw/arm: virt: remove hvf_arm.h include
To: Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Roman Bolshakov <rbolshakov@ddn.com>, Mads Ynddal <mads@ynddal.dk>,
 qemu-arm@nongnu.org, Cameron Esfahani <dirty@apple.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Alexander Graf <agraf@csgraf.de>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb133.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, 6 Mar 2026 at 08:31, Mohamed Mediouni <mohamed@unpredictable.fr> wrote:
>
> Having that include breaks the build for Linux after inclusion of SME support.
>
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>

Why does this break the Linux build? This is with Manos's two
patches "hvf/arm: handle FEAT_SME2 migration" and "hvf/arm: expose FEAT_SME2
to guest if available", right? Linux builds fine for me with those.

There doesn't seem to be anything in the hvf_arm.h header that would
be a problem on systems without hvf -- there's a couple of prototype
declarations which don't use any HVF specific types, and a block
of code protected by "#ifdef __MAC_OS_X_VERSION_MAX_ALLOWED" which
won't be defined on non-macos hosts.

thanks
-- PMM

