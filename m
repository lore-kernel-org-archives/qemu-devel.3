Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC109D3C934
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 01:03:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2gpB-0000Fn-Bd; Sun, 20 Oct 2024 21:03:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1t2gp9-0000FG-7s
 for qemu-devel@nongnu.org; Sun, 20 Oct 2024 21:03:07 -0400
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1t2gp7-0003cQ-Ns
 for qemu-devel@nongnu.org; Sun, 20 Oct 2024 21:03:07 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1729472571; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=WSBl/WR0C7s+t42Mk3RY5EDPR2IekOXvIMyuUmS3UENlMFUsjuK4RW2791ZMIogQocjWIkOoykzI1jJ3HtMLBpKf0mny0zSug9iN+fhDVIhiaLy5pAmJa35GSTfkiLaT9N08iqFT9kgoyapQ6kBeDzkqzIE9OrenUNhxjYk9jrE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1729472571;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=ifsn+03v+07VP+YHCiUZA049TCfl8Bf2/0zVES3uf2M=; 
 b=NCg3n7hMRHG7W5A78ejqtQu9mE6qp6bBNMs0OtXDyzWn04xRldvjjDgZdMwlLCMbTJY6YfFr/pMfZ3MrdPdCw5mQmP08iBXI8XSvKbkbNEOy37TMBBP2B37SR0crfEcgmofo442EboZSXDhQTnp6qG//RXGgzOf8di+jLTxU0rA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1729472571; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=ifsn+03v+07VP+YHCiUZA049TCfl8Bf2/0zVES3uf2M=;
 b=XPcb4XW6h2RJUVx6c+C5ZVeG6m2cftGVB7hgilUICyBdIBJMrJYDTXD9Kl2h33Hu
 4TcWAr3TmOJ3CuwaWkmZYSjswgYJzb8P64LEc7OJPllOYPACPk6fPwASau1odblb2Qi
 DLcgICcMo1Dq0s7UcthKS/unbNb2rvND85TeLSI0=
Received: by mx.zohomail.com with SMTPS id 1729472569279284.018831665804;
 Sun, 20 Oct 2024 18:02:49 -0700 (PDT)
Message-ID: <03d164ac-85d9-459b-b0ed-1d242234479e@collabora.com>
Date: Mon, 21 Oct 2024 04:02:42 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] ui/sdl2: Implement dpy dmabuf functions
To: Akihiko Odaki <akihiko.odaki@daynix.com>, Huang Rui <ray.huang@amd.com>,
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
 <20241015043238.114034-3-dmitry.osipenko@collabora.com>
 <e2c0584f-c8da-4cdd-932d-a87ee2cd838f@daynix.com>
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Language: en-US
In-Reply-To: <e2c0584f-c8da-4cdd-932d-a87ee2cd838f@daynix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.112;
 envelope-from=dmitry.osipenko@collabora.com; helo=sender4-pp-f112.zoho.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/18/24 08:22, Akihiko Odaki wrote:
...
>> +    EGLDisplay egl_display;
>> +
>> +    if (!x_disp) {
>> +        return;
>> +    }
>> +
>> +    /* Prefer EGL over GLX to get dma-buf support. */
>> +    egl_display = eglGetDisplay((EGLNativeDisplayType)x_disp);
>> +> +    if (egl_display != EGL_NO_DISPLAY) {
>> +        SDL_SetHint(SDL_HINT_VIDEO_X11_FORCE_EGL, "1");
> 
> SDL may not be going to use X11 but may use e.g., Wayland.

SDL uses this hint only within the X11 code, i.e. setting the hint
doesn't make SDL to use X11 instead of Wayland.

-- 
Best regards,
Dmitry

