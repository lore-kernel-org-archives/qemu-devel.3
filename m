Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCE88C369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 16:46:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7Gky-0004qO-6Z; Tue, 22 Apr 2025 12:46:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7Gki-0004mQ-Mt
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 12:45:50 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7Gkd-0001Ux-Kj
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 12:45:41 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43d0618746bso41622695e9.2
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 09:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745340338; x=1745945138; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sh1i0UXY7swmk7U2d4f15vuLortTwi1zj+SvezGibB0=;
 b=Em0tjRWCszIc4Ckkw/crvmbnbZ1Jqku+BDdQKzBW0rDoAfNY7j4xXyDzXp7+DjdG45
 e+ocaD1tNWoQG9c/CJ6DoEU6V7mJUr87/c35qyhfZby2cA8GyA6B64VRRemvN7v9QQUI
 BsT1iCWz/fsqxsMGbPyblwANJN+ydz4vPiJJaCAA5WNfoTJBFGPF+KBmEYXhTh5yrKjk
 tghH77lP83Euda17dYTx9qQe72UYqH6vACWxusJNzxKBPAqT+B57fCKhKvdl622l7MeT
 5jLfQj1AI8HeEYjBhPqe4d7AR4R0zOroMxDS8eesNbwRSD/zDm6egg74fqHbCzs5AOGS
 iHIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745340338; x=1745945138;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sh1i0UXY7swmk7U2d4f15vuLortTwi1zj+SvezGibB0=;
 b=l6X4oBE6LoZ5k2K18E2R7kmZ3KD2gv6kUjpZnxYvnerkrQdG7e9nkiZciR5xViM7Y1
 hCui2p9HjScTHprUE2QQ96Nn2O38Qi8t79FleQGZ7kvquT5n3pEvAToFH9k1OT0Y0yRt
 YqIQuJaRHIrbVC4WjBWuEQQvNjt6jicLAbSp0sj//Nm20JdNFSmYLpYjfNAZcOU3Q4Un
 hrAL5SLa4bmSjjc98M62Eo/gv+86ANHDViMGgBXAjwMIyACy0YYDiPb46lLYXN89xRPx
 /esLKEksIuPmeaV0J46Y3PKCvHwjn/3vv6fmXPKvplyx/mmWfrknktbkRQiXr5PeMZGn
 dLzg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVc4bmZW371TOXCa2vuX8KXGRGcah14dLoEOWffuBn5kc54L8oV30irGvrRcRhB0ucUpF+f3atwrFHb@nongnu.org
X-Gm-Message-State: AOJu0Yz5mg4Mrb9qj+ZFv35WGn/ydVj2awkD2SErjzczieLjJrghD97i
 8uRRKuWTEPudg2PAcVxow6xdrJ1MFWXrQKOsmrUmpjFkUf6VYG+93hY4ZplEa3c=
X-Gm-Gg: ASbGnctE9j3TcPsNon0NO6y+axP9FLboIcYGxsAr04hYjuRUdxQRs18lUGRp6xyxrp4
 8BaRdokoyABCetIm4y30C28PTfeJGN6dh11TxbMV0kgm5M8rXDao0DtZE5UdtjvL7929mx8Bu+9
 rGvFYn3XjnOsKhSXswI/Ui2sCUqSxDkHWey7rH0je3fathLBcz538w8zT1+xup5fAIi5p3bCMGV
 peu80Po3rr0j1z42lEfmt9cV1vLs8Ob/hv2RNthCxUMvX8qpUl3/AN8VbjuJ8AGXZx4VAwrdaB3
 BgirGkYZEDGaTB6xyjWIvtxVpMUnNC5fhg0RkAg43Cw4GK1xm3+Arhe1dolac4dYl0T0dg5kR1s
 47ni1gvp6MPBL12XMubc=
X-Google-Smtp-Source: AGHT+IEDL/3laSO4KqJCawbeLPNW05amijcjqIO4HQV1rIkYOwfOOiSStewn3bcWlTd3WmyaeHkC7g==
X-Received: by 2002:a05:600c:1c9d:b0:43d:224:86b5 with SMTP id
 5b1f17b1804b1-4406ab81a47mr156654145e9.4.1745340337697; 
 Tue, 22 Apr 2025 09:45:37 -0700 (PDT)
Received: from [192.168.69.175] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4406d5a9dbesm181049505e9.7.2025.04.22.09.45.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Apr 2025 09:45:37 -0700 (PDT)
Message-ID: <c97ba9c9-57cf-4715-9d1e-1b2716721ebf@linaro.org>
Date: Tue, 22 Apr 2025 18:45:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Add a maintainer for util/vfio-helpers.c
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org
References: <20250422162954.210706-1-clg@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250422162954.210706-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 22/4/25 18:29, Cédric Le Goater wrote:
> The NVMe Block device driver makes use of a reduced VFIO library
> managing the host interface. These routines are VFIO related and do
> not have a maintainer. Move util/vfio-helpers.c under VFIO jurisdiction.
> 
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)

Thanks :)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


