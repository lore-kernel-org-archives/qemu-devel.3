Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCF42CCD193
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 08:31:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAlIo-0004Tb-6Z; Mon, 20 Oct 2025 04:31:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAlIm-0004Sl-Dy
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 04:31:36 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAlIj-00087P-3D
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 04:31:35 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-46e6ba26c50so26254885e9.2
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 01:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760949090; x=1761553890; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Kfk0zu0vmO9W22pWKATMNhqU90DG1WSCANu4coVqJ3k=;
 b=ZBSoMiUUboKGLlPbOq6NrW61Nabn0qJlmyDSY1W7vgl2Yl7oFabUHnSMr80WihKtG1
 mf9Mw8+V+JoJQeD12Kg+rMcYF+63u9VI5Mc+4zqYagJqv2SlLXq1pOJUWiLh4rgAHuGK
 9bcCuiB3KU4t9zpQ/2M3Vu894BtQ+GJ5wfbfZzeyL88OeRfbC0gtujwwm6ylXtbAtJzf
 dOH31GsBY9yO5TVXKlWbNkYUvOH5lztKUOrHGzi/9ELH0ECOOHKXJXOBm1CZ0p0Qk4eN
 wo86y8Vuq8DNSkZnKzghJLyLIqlhNP+zv+GuSyHsVgWpLmnn1a8dTzfTme28NlXn1ArP
 w4uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760949090; x=1761553890;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Kfk0zu0vmO9W22pWKATMNhqU90DG1WSCANu4coVqJ3k=;
 b=wg00GoPxghlqh3SNXzDstirwvQEP8C+6C3WoLl4t+PzvdcCNpNv6cm8HulNtoO+6Tb
 LYo3TgaMK0+JjBBYkrX1eVgiVa6th2jCmvo1hHDzXFLkWx1yzA6rd3yXIbvR0kWxW45l
 LvtjeXrDDUoQ/rPzQMmpRO+vbOa/rsNE1uCuEphegHcaXoHy29q5ZH2Niyube6zA4Sbg
 YYiSDvU54rNFU/UiXKVQRjfqsRa7YjS6dJDvo70A5l0lGqHYtWeWiiEpcjz07Qjw+yl9
 LtcS2tbAaTKG4WgH0R33i3gFra90lVLYnA3spodygESe4LGKR2kE2qO9QKt2Yv7E/DDJ
 2PXQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUyMAnoDPv0fneLJXimQwcYmRIs7NtzXM+ZztvuHWlOJBWdsoNsLTVdBKrSLjCY/6pf4RX6IZHgSgu7@nongnu.org
X-Gm-Message-State: AOJu0YzJShGeJ9g0gOI/j7dWNgnMNx1Rr7IjtYRpl9fWu2PlOLZGoTj2
 NaLKmRHdnNo8kxsxvAittx2aR5LWYC2u0ATtQbRNKtTsH+SoU4Bq4PNU5xIrhdRLGbs=
X-Gm-Gg: ASbGncv+53zSmMNMEyMidM70rkKN9l6o2Hz2ceoqisAOUiKHtvj1uQ5zUtmI+SL/Xwq
 xA50fCDDXR8isVhnQZKzdkaMBJF49jVMOgP7tNTRXvjSo2DpkYIMuzjaf83krmLyRZuKHzi88NN
 3eW9GUEVmaM45oUdAmFniOyL/8YbYVpr0q0+aE++L+kPfYMjeV228Eb9nG0CbXAcA4x/iTcVmFp
 BCu/u9ydV+LtiHHbCnfvSKhg1x3bFYfMIQl8UbcxsWI9tYYXD3wFi2qdmgy2UsQShNteNz2wmWd
 ELPqgzSu/ITFlAHBROxtGP6Vn8cFq6lEFU2KrqsD23qgnr4GFeO1viz1LK6jleYcyJJqnNev4hn
 nnZMFznWWMvBqq+F8Rd4EdAvGtHfluDwnRkOhlJ1LhiyUH9OqMY61mhp3xZrVpqPjgqR/hcZCwR
 UhdTHYteawozO5jG2k5va6bSRnCoi/MYOhPXQnhEu1TqJ6Q4pldjlUMA==
X-Google-Smtp-Source: AGHT+IGMZtfmBcTewqhPn1UIg+L75Wku84JXFjnzM4sfO50VVAoNSP2FKvx8EcGUTSa8RrcqwmTWoQ==
X-Received: by 2002:a05:600c:524f:b0:471:115e:624f with SMTP id
 5b1f17b1804b1-4711790c2d6mr85823025e9.21.1760949089797; 
 Mon, 20 Oct 2025 01:31:29 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47152959b6dsm129861005e9.7.2025.10.20.01.31.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Oct 2025 01:31:29 -0700 (PDT)
Message-ID: <4f8a640e-d1ac-49c8-8b14-743d248a91e4@linaro.org>
Date: Mon, 20 Oct 2025 10:31:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/10] hw/timer/i8254: Add I/O trace events
Content-Language: en-US
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Laurent Vivier <laurent@vivier.eu>, "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Zhao Liu <zhao1.liu@intel.com>,
 kvm@vger.kernel.org, Michael Tokarev <mjt@tls.msk.ru>,
 Cameron Esfahani <dirty@apple.com>, qemu-block@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-trivial@nongnu.org,
 Laurent Vivier <lvivier@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, Phil Dennis-Jordan
 <phil@philjordan.eu>, John Snow <jsnow@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Gerd Hoffmann <kraxel@redhat.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
References: <20251019210303.104718-1-shentey@gmail.com>
 <20251019210303.104718-2-shentey@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251019210303.104718-2-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 19/10/25 23:02, Bernhard Beschow wrote:
> Allows to see how the guest interacts with the device.
> 
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>   hw/timer/i8254.c      | 6 ++++++
>   hw/timer/trace-events | 4 ++++
>   2 files changed, 10 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


