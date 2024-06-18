Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42A47C27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 13:50:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJZCy-00062i-ED; Tue, 18 Jun 2024 09:49:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sJZCs-000624-97
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 09:49:07 -0400
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sJZCq-0000md-GB
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 09:49:06 -0400
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-52cc14815c3so1298091e87.0
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 06:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718718542; x=1719323342; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=flw9SaA0nZN6x3YJjhuda53O4E/G6rHmnKdh+7Szslg=;
 b=bsA+2YLOk5T/jotrjSuRfgwSiGmRs50zaLCvPUAAtQjHuFreErQZ/RqdMBdwHyQ2m2
 dJPtjYYp3Jhvq3CtYY+JdfbI8MnoXvCdk3JCT1f/BGNTS0B7pwNoEoBn/UhYl28O2Esh
 xEq0fOj4A5GeqyvN6RFbCR/YL8fQ+RkLPATd4Np1QuJHliWf8DJQxYW19p7qZ1Tg3ZVU
 tYvyg7+jfUNn9UnEtcKPVYREfucHRjkPcL7owvmi/yY3qqze4rlJ2i6nKm2G2vOL22XZ
 41yCAn2VKmGJqjinWYDQ6AyWKRzKXH5piNaSfSscEi71NiVl9VnsLjdzeuEfXt3bnaLQ
 hdZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718718542; x=1719323342;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=flw9SaA0nZN6x3YJjhuda53O4E/G6rHmnKdh+7Szslg=;
 b=t5xr2WgPGiopOsRiDXFBPjai1Ec2D6R1eb9phKbefIerDZJv11AsgIm3NAjVmBWNav
 rrETRwBPx7XMafDS8B6sP5oPhWjNvkzBONzvVZ7tS6gDmpkGm8vxBVCz1rqRgHyJT3S1
 3G5mG0+SfGG0fa7xQ45tYK4rVbdHnSLD22Wml0nRoi3EYZO5wwEA4qXLl52NHooODg9F
 8Ihp2uAhUu3yJjClRFZhoVPII250jsp/tf0L+P0l7QzTIYYi7D38gHZiP+rTbt49iVZ5
 Rc4VvSnUfS4GjvVVPqR8x1jhKm7B8QtN6xIjW9TWdBsHQHGcxuRMEcJovZLkwXqrOhS+
 0odA==
X-Gm-Message-State: AOJu0YyR9QpGWyxaQnAUgj1EQXVmlZxLTOj9catjWHE1ZfJVKVfgqNLu
 N1+BFv71zu8A+cnvjZbax0JhBYrGVFJWTebCXe4n+Y/s2W2jD4Hg1hFveGDmOEFjPeOe1j5C2NA
 Uv7g=
X-Google-Smtp-Source: AGHT+IF6tSuaJsF3lFhvZX2/bhCTxVC6A2k2r1delU0GJeK99tbnyvgfkTTBo8TeDsKji+PoTvE5pw==
X-Received: by 2002:a19:9101:0:b0:52c:8aef:d16b with SMTP id
 2adb3069b0e04-52ca6e6d5d5mr6614727e87.34.1718718539771; 
 Tue, 18 Jun 2024 06:48:59 -0700 (PDT)
Received: from meli-email.org (adsl-103.37.6.162.tellas.gr. [37.6.162.103])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-360750f2489sm14096413f8f.69.2024.06.18.06.48.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Jun 2024 06:48:59 -0700 (PDT)
Date: Tue, 18 Jun 2024 16:44:36 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alex Benn=?UTF-8?B?w6k=?= e <alex.bennee@linaro.org>
Cc: qemu-stable@nongnu.org, C=?UTF-8?B?w6k=?= dric Le Goater <clg@kaod.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH] hw/virtio: Fix the de-initialization of vhost-user devices
User-Agent: meli 0.8.6
References: <20240618121958.88673-1-thuth@redhat.com>
In-Reply-To: <20240618121958.88673-1-thuth@redhat.com>
Message-ID: <fa3pl.fcf892mzbx7@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-lf1-x12c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, 18 Jun 2024 15:19, Thomas Huth <thuth@redhat.com> wrote:
>The unrealize functions of the various vhost-user devices are
>calling the corresponding vhost_*_set_status() functions with a
>status of 0 to shut down the device correctly.
>
>Now these vhost_*_set_status() functions all follow this scheme:
>
>    bool should_start = virtio_device_should_start(vdev, status);
>
>    if (vhost_dev_is_started(&vvc->vhost_dev) == should_start) {
>        return;
>    }
>
>    if (should_start) {
>        /* ... do the initialization stuff ... */
>    } else {
>        /* ... do the cleanup stuff ... */
>    }
>
>The problem here is virtio_device_should_start(vdev, 0) currently
>always returns "true" since it internally only looks at vdev->started
>instead of looking at the "status" parameter. Thus once the device
>got started once, virtio_device_should_start() always returns true


virtio_device_should_start() returning true if it's already started and 
running looks like a code smell to me... it intuitively feels like a 
ternary state instead of boolean: not startable, startable, already 
started.

>and thus the vhost_*_set_status() functions return early, without
>ever doing any clean-up when being called with status == 0. This
>causes e.g. problems when trying to hot-plug and hot-unplug a vhost
>user devices multiple times since the de-initialization step is
>completely skipped during the unplug operation.
>
>This bug has been introduced in commit 9f6bcfd99f ("hw/virtio: move
>vm_running check to virtio_device_started") which replaced
>
> should_start = status & VIRTIO_CONFIG_S_DRIVER_OK;
>
>with
>
> should_start = virtio_device_started(vdev, status);
>
>which later got replaced by virtio_device_should_start(). This blocked
>the possibility to set should_start to false in case the status flag
>VIRTIO_CONFIG_S_DRIVER_OK was not set.
>
>Fix it by adjusting the virtio_device_should_start() function to
>only consider the status flag instead of vdev->started. Since this
>function is only used in the various vhost_*_set_status() functions
>for exactly the same purpose, it should be fine to fix it in this
>central place there without any risk to change the behavior of other
>code.
>
>Fixes: 9f6bcfd99f ("hw/virtio: move vm_running check to virtio_device_started")
>Buglink: https://issues.redhat.com/browse/RHEL-40708
>Signed-off-by: Thomas Huth <thuth@redhat.com>
>---


Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

