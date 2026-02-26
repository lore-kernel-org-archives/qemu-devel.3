Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D284FD8FEC
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 18:05:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvfj7-0003z0-KV; Thu, 26 Feb 2026 13:04:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vvfj4-0003yU-Kf
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 13:04:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vvfj2-0002Zw-Fl
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 13:04:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772129072;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O8uV5FFdfaHX/bM74f+gaIEMVYXEYzdJEDvbn2Dyq+U=;
 b=TfoF7Kx8A3DVF2Oa28007HWxYjzPS1PDVl0pFbz4JBpJsq3EnD7uIQBNnJ7/RjCmoXHm4q
 FqJA7gE4BZKtmb4p0qp9GRpHz8WLZmjXIuOqna5Jq6ZTgEjdx6CZPp+raRmLD6zIRDQGdW
 BEYg2wd5JTD14AQN5UeYPY01lZ312Wo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-568-XljWOoiRPe69uWpVVEuMbA-1; Thu, 26 Feb 2026 13:04:31 -0500
X-MC-Unique: XljWOoiRPe69uWpVVEuMbA-1
X-Mimecast-MFC-AGG-ID: XljWOoiRPe69uWpVVEuMbA_1772129070
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4836cc0b38eso14254875e9.2
 for <qemu-devel@nongnu.org>; Thu, 26 Feb 2026 10:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772129070; x=1772733870; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=O8uV5FFdfaHX/bM74f+gaIEMVYXEYzdJEDvbn2Dyq+U=;
 b=A6YUmzVH10DSjRVfz7R0+zQ3dMNwueIwK7dCO7tLNLnA0QzRh5UwvDs/g8M/Yd97nJ
 kInrYfPbtez4Cc3Q3rJzx+HgGDqqeTpZnPtm2sUCok4A/ibktZ4dgA4RWQ9bhv92xYFo
 4M3e6YwQfpOMXQqI3J/D602EEIcSpgqw4P6O5ZRKG3Y538Glr/GzqacWWZxXfHMp1Dxv
 kWoTetG1VmDn4CHEIjEiquW3S0GDzPNdmagwyybZAEoD4bqumYZm+E8QBb5baGQqgbyt
 sg+1KtMSFuNaB23bSvDRK64Gr5ScCUjqNTH4J5KKAyMwIDO4Q0ea4o1JxqNOADqIsh5F
 HhUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772129070; x=1772733870;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=O8uV5FFdfaHX/bM74f+gaIEMVYXEYzdJEDvbn2Dyq+U=;
 b=vzUVxMSEn2po8XdFR8733+v0crJ3IuOAOxVOr/X9ZRp4mF9L4/6cJlm34H42c9Z7np
 xRkoFpoy13/KJFDDnua3QUfCYV/D0vX3i4FGr0l+oyjzymBS1Re97e6oowocusBo8guK
 Lq4yIqiv9boHTTI/zklGLmLz99bTSu1khDWvIEtar3H6ySGAXq7QRGfJ2KTDN5Uj9y5j
 ZhmYQqJVgNxks+V5x0h4V0zKSC7iDR/JG9XT1lfCGta09fBxZLrXXkDRHE2ZK4PsoEwE
 Iwh0Q1TzoX4bRUhxCqGSb2B8M9JG2kfjSuvi3UVKvIl7I4KqiE3ulKgP8DlDrsTznzZ5
 PmVA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUsnAck3Zmi/RWoHQDza1J2INXK9mt00TrhV4ZuMOSQED5aYOW8yCqj1YqAT/OZHVklFy69BbuCkMzG@nongnu.org
X-Gm-Message-State: AOJu0YzKGHb8T9o8oca5/9fWhcQ9MDPp5gm1sd19gKrVqC+balUgxMFK
 6wGOWJYH+9COB3xZ1YUDUHhi3eK0oqBIpUBsefEHz2TkAwJxopr5/vdAvVIo1sC5OnHEqoMaFiu
 h0t9FgLe3JwzzJq/+Wbz1qHdvd2KLVRZelJ03sfHGC0uY2VZGDJegoULfTLLKZd+C
X-Gm-Gg: ATEYQzwmN+/6/bhhn84J2SAXi7sN10bnvL2dfrMRJNmm8FOdQFB+vi2Z9ekwKcz0LdK
 VkJqNDTeVDCyl1l/+aX7yqCKKEPn6iAWtEKTQ5ztsoE0WPEYVEWjdEmNO91tQWqYvt2DpwIpY1G
 OCx3I8ErTrFkG661InhPtjFi1E8g3fLk2yaxRK5YAQczzqtJIfUWGhvEQHVyuUHaPIcmnNEDQXD
 YcKI+6N1bUSowbbMfbUV9bwiebM0B6pKX5dlu+RGwDWAXARo0HCQ/FlI/A9YfTnd41CTq0AkB11
 gluSujBooiiJ/4PnDxDbkWtQtIzxrvO1GHmIFmhr9/4PcHNZpOb/08vhirimL+Xlr9SAuft6bmG
 3qOfnibhOwG6VxoOniDB9MOnF40dEZb8SeBAkg8zlGXSjF/1qN9wD2yQo0rCvf85DOhoay2Q6FI
 CYFiB9SnMLrcgN84KVrCa7/HY=
X-Received: by 2002:a05:600c:6296:b0:483:3380:ca11 with SMTP id
 5b1f17b1804b1-483c3df7964mr52181195e9.33.1772129069779; 
 Thu, 26 Feb 2026 10:04:29 -0800 (PST)
X-Received: by 2002:a05:600c:6296:b0:483:3380:ca11 with SMTP id
 5b1f17b1804b1-483c3df7964mr52180585e9.33.1772129069357; 
 Thu, 26 Feb 2026 10:04:29 -0800 (PST)
Received: from [192.168.1.84] ([93.56.161.93])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-483bd75df9fsm172521895e9.13.2026.02.26.10.04.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Feb 2026 10:04:28 -0800 (PST)
Message-ID: <0ad14e43-90bf-433c-b97e-95486ac6dc16@redhat.com>
Date: Thu, 26 Feb 2026 19:04:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] Some cleanups (mostly ui/audio)
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
References: <20260211-cleanups-v1-0-e63c96572389@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
In-Reply-To: <20260211-cleanups-v1-0-e63c96572389@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.306, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.668,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2/11/26 11:01, Marc-André Lureau wrote:
> Hi,
> 
> Please review those ui/audio related patches,
> thanks
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Queued, thanks.

Paolo

> ---
> Marc-André Lureau (7):
>        audio: fix nominal volume channel (cosmetic)
>        python/wheel: remove meson-1.9.0
>        scripts/vendor.py: add pycotap
>        audio: require pulse >= 0.9.13
>        audio: require spice >= 0.15
>        ui: drop legacy spice < 0.15 support code
>        ui: drop spice-protocol < 0.14.3 support
> 
>   meson.build                                |   6 +++---
>   include/ui/qemu-spice.h                    |   6 ------
>   audio/audio.c                              |   2 +-
>   audio/paaudio.c                            |  28 ++-------------------------
>   audio/spiceaudio.c                         |  30 -----------------------------
>   chardev/spice.c                            |   6 ------
>   hw/display/qxl.c                           |  23 ++--------------------
>   ui/spice-display.c                         |  15 ---------------
>   ui/vdagent.c                               |  18 -----------------
>   python/scripts/vendor.py                   |   2 ++
>   python/wheels/meson-1.9.0-py3-none-any.whl | Bin 1029634 -> 0 bytes
>   11 files changed, 10 insertions(+), 126 deletions(-)
> ---
> base-commit: 0b91040d23dc8820724a60c811223b777f3bc6b7
> change-id: 20260211-cleanups-b51df70c3b2f
> 
> Best regards,


