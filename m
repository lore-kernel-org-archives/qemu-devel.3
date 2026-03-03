Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED75BEDA6BE
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 17:31:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxTaI-0000at-6c; Tue, 03 Mar 2026 12:31:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vxTaE-0000Ui-38
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 12:30:58 -0500
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vxTaB-0005lH-M8
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 12:30:57 -0500
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-b9362ddbee2so822874766b.0
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 09:30:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772559052; x=1773163852; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2RAkIBVkW5tI4FybOyJBTKE9T7v8apUkv9KbBJC3jJk=;
 b=bnWsDiIhJjuKh7HHPB7FXuVzBhykPOGyVuWQtY90cdeCOFFTkGEGOwZQqaZvwUQ+1S
 4BtJ0rYsI+aSrx4RD7oCsr2u9hK6eydm/IqKFg2p7fC51ocQcSIZEp5M4vIi56xPPzW9
 60p132+0f8lRhNV+ZCH8nSErPH2gvfZvdUTIzt+FfY8zv7um5k/rA7fG/XldzVxqMbeT
 U4kTor2aVcoapHZdJ9r1/1oHiavGKwl4r7+NftLlYVIcCjb5F/YUV0mfJ7tlMYsp5Nta
 gNYBRRAhlO9q6u9/2qAjUDZI+Fe1L7G/VKOoKGSFNrDxg2G4aCIW7kprzzf/Cxb5vQS/
 jNeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772559052; x=1773163852;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2RAkIBVkW5tI4FybOyJBTKE9T7v8apUkv9KbBJC3jJk=;
 b=atH96MYHrvotjj5vwYjXi1dUNEYzXz27fZ+slb/B/DtdLx9YylNgdnODhBoMms0q63
 39wy9rLqQtCWYarJgD8zgAXZ3h7Me73tABczP5ufqQShT2DRrFB1BISghNyDDGA2NmHz
 Ex6CVu/AyEefKjJcWuLw3aqIN3sIuj4UODUdmL+TnuHqL34WShs4B2G3+4xwMalSMlbT
 B8zen3NOM+P6AIE99cmtsJJMXN6pNxuFZIl+sZdAtb7NTUmB6J+lYOzleZ9EeArhyDkW
 aHB1XO0DByPng1BVjMRQdRmbKpFaTkZsT4uh7s1SOXv+Bku9lQZig+yoJKlelLI2r493
 VqdQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXC8OSVb1gPMQy1G6uZ/Y9ATUWsccxHKaXHLWh2wYAvcDei/0hdGL2yBp65SAJasgSzT9zVOkaB9TWg@nongnu.org
X-Gm-Message-State: AOJu0Yw8t9hZXTIqsABBJeiRIVy7qkgkfUcPokSVzW6O1YxGnbTGx9XM
 Qz9bz/vVSJeLEBM6HTZU2d/vWf70ShBkHv2GjLZJLXH/pQMlZ1V972Z/Z5EOueBi720=
X-Gm-Gg: ATEYQzyK2Wjz0XoIeL1XNEATyXWvE+edEFKnGfgaQDvSIJ5A2X8ZsAsDaJQ15aC9uCY
 moxBGnzsKZ27g8KOjWTAGkiIi7xNjFW8mDDGJZ6PANZRCLswTAHxope009Jz8EnMaSdAMXfpgbL
 3K7wWNkdxLaeK02XOs3B6RWAyOVAzJn5fJ/XnFmO1qukWjdHfiKaWvsRlNzrWk3muFpVZ4Ijx3w
 RDKH75Sp+mMSnhcFoQrf7TH63D33st45eDGPv4vcE3048TqNIMg8sl8xrgO/X521A7Yhaw0SjuO
 +fVknaa8J4KBUvTD08zJ993U9DaXA8k00wb3+RsReRlknF0kSQ+ZIJfxlMaTwRyg0qRzpDW/oMj
 Ulio0bDhqaya3eub6Xc1JXNqjF7PgQH3jO5LKvZY/pYnKcox+040QGEv+/vFK+dNTEZ/8vmEWDX
 q/HYDGyX/5lg1w5XghdUeVDkQ=
X-Received: by 2002:a17:906:756:b0:b87:1fe8:9534 with SMTP id
 a640c23a62f3a-b937656ea7fmr784878666b.48.1772559051609; 
 Tue, 03 Mar 2026 09:30:51 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b935ae93357sm617011566b.48.2026.03.03.09.30.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Mar 2026 09:30:50 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id AA2465F7BE;
 Tue, 03 Mar 2026 17:30:49 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: dongwon.kim@intel.com,  qemu-devel@nongnu.org
Subject: Re: [PATCH] virtio-gpu: Fix scanout dmabuf cleanup during resource
 destruction
In-Reply-To: <CAJ+F1CKCQiBnOncaecpgG2FXj3R2tjxYOe8z7r8rGqCBAo97=g@mail.gmail.com>
 (=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Tue, 3 Mar 2026
 17:28:15 +0100")
References: <20260303010047.1925589-1-dongwon.kim@intel.com>
 <CAJ+F1CKCQiBnOncaecpgG2FXj3R2tjxYOe8z7r8rGqCBAo97=g@mail.gmail.com>
User-Agent: mu4e 1.14.0-pre2; emacs 30.1
Date: Tue, 03 Mar 2026 17:30:49 +0000
Message-ID: <87wlzsrfau.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x632.google.com
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

Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:

> Hi
>
> On Tue, Mar 3, 2026 at 2:06=E2=80=AFAM <dongwon.kim@intel.com> wrote:
>>
>> From: Dongwon Kim <dongwon.kim@intel.com>
>>
>> When a virtio-gpu resource is destroyed, any associated udmabuf must be
>> properly torn down. Currently, the code may leave dangling references
>> to dmabuf file descriptors in the scanout primary buffers.

Queued to virtio-gpu/next, thanks.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

