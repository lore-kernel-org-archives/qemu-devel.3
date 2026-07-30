Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 641D8C55164
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 14:57:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpSBY-0004Qi-SL; Thu, 30 Jul 2026 10:56:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wpSBA-0004M4-9C
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 10:56:12 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wpSB8-0003EB-R4
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 10:56:12 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-6a051b73866so3152998a12.0
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2026 07:56:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785423368; cv=none;
 d=google.com; s=arc-20260327;
 b=Kfds/xVEzL6dhb8TzWThPEDYAXB3pl+f1HFGMy6wmpv44SDFtldy/Bo69Q7foYG1+f
 95KK9Ez1t7cGyEZuEc5eZhxNx3q2eDRaxilM6nnHA8lhcIIb9gGUEB0HqFRfeHPVhVuM
 k1lg3GlIfyzdutl04vNdVd0Cm7LJo3rOp85gJ0dwpplfSd4OAAvpr/+0rUWC3kIwR7V+
 M6u6XwAo6d1ViNJSurZGB8C1O3OXIh6Sn3D3xwMxSdw83/GzOARMfa+eZEn+A3VKGCn0
 6l6pByo+4mzumUCkBq3+OsjyxfGzDYE+7kP6rpYfhlYuIQXc7coNN62VO58T2f8YytEK
 i3lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=wGbhZy/A5H58OF7/zPzBmqAu4fUKf7Z/iopqk1UseFM=;
 fh=dMBuULl7DHqFgMFBx5jdFD0q/Yls2ZIryYpHmqk1U/E=;
 b=JPF9NGEHkkX7+ctmfCUDG0sTZ9XHigP9u7RFXNsblCOZd4X/c5XG3miED50mCNTTC/
 s0Ey6L9tCJ0K24Ua40Hj84JeJy0DUZnH8dyfIVkvrdSjR+2d38HVY9nk/YyDyzPLJSpS
 AQu9jTwnGQsrmW3MMHJeJKEQr5jSxLDPaFfOFrmbUf4Il2DsvSkdT5D1p1lginTp1AdL
 N2s6xgq0G9SGy5Z7k1A8vWexfWaojl81lqrGUmO1/ZpVZj148+URU7RbAi9grmdQ/mv4
 jjKJWG3Pq8ZbdnreC5F2/rRafXrizwqIun0eOrB+jzH3E9igdaqHupiAa1GSCadBvjHU
 Tj2w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785423368; x=1786028168; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=wGbhZy/A5H58OF7/zPzBmqAu4fUKf7Z/iopqk1UseFM=;
 b=pF1ZglnPbz6jx01BnHjHuIIG/Iciz1XPURt1gxbwz2VGFmDJ879wpavP+vp72AyTjA
 DK+u/nUuHMam4ibit6PKwzVPpHPEqkF3EluO7H4HDTIIWh4Q6rWMzqUrYN/wvByBY+J7
 h4G3jaSum7qVeWUSrw+Djw4ktrKRSgzGhsQ3F3xJQSTqvOpd3ENp/2X8B/bzfHDkt70f
 /ju3IRUapD9+OSSlWO3+yTZH+SRGtOuVFT2al0xapjO3Po2Bw3gWxmg5bHtl8ssAug3e
 pkFzuGjLXTYcUnsPIPxIQ8amFZcK9pCqJHKWHLou+/MP9L9P7VnrasefJ5yzJElxr6oC
 YJ2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785423368; x=1786028168;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wGbhZy/A5H58OF7/zPzBmqAu4fUKf7Z/iopqk1UseFM=;
 b=rcO109L2pHtB/ZsFf9AT+f6HK75+WyGigZS2RwZAc5qjaiPW+2gfS7vdhxkOIjW3aj
 ep+8VIgIf0h9Gm7AUt7T5eY7TbYkU9zMuJFcs6eH40cnNf39SyTbUcPw1oWrvuCnlTcT
 xT1uy7NimOLtk5URWOoIynWplsLtjmwWaze3C8gKvhi8gZLA3AExGKGZWXhOzusF9C6o
 UxDnnWGmwXxKxe+9fvDq+sOqo4czL3evS3DDPid+4K5ZyapIfaclCbN90CAfEGX0AYuf
 SReXAXQkZdv9siPs+JgEu834+iBb3qzh09nv+lrlt0NkMe/hJ+iderQZmM0UBySO3P1D
 wuNw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqRvDzglN+ZZIW03NFfgT6b9IAzGCqTHS/JlpdZhNK18GyIYNCgvB/3Q7wFgPSvAafWINe4zYxyEQ57@nongnu.org
X-Gm-Message-State: AOJu0YwgjAFEzXuVDrGNaQMTPxzfj6TvnjXJACy+gD87On6kE672as60
 0CbKJI6dpMQYoM8BR5dga2VAyeqIM39/skgaQSSUUDTl5HzTXkJJI21zLaCCA6z4LQG9gGRPt8h
 tgZYLgpxQBv/fIx6Td7JugGVocF62gX8=
X-Gm-Gg: AR+sD11uSW8rQFOqAoGF0mLHTpdpMyArPjSZeS9laT+f/Uy3BGeuD9TEqicythG1cnL
 InSw3unO6oWrn5e4w7bSYAyqROjVMek3/t6IXFNdw7Cf0twhDEqp8zAWJHt3WuZ9+vH13n6pnZu
 dlY2Z/9L+PrzFei4qdGTJXfGM5fWTJyQQ40WtV8tn1ryiJM6lLJziH/aMbojmU7R/hSOuxUcYBX
 NtT7TxlrMFbOPU5TKhBqaEXkyrXjxRpOeGMRhmZf3UaV1Rv7Wj6iUmxoNqv8pe78d30ICiGkcX7
 4pk+fuoimunVHJgQfhtK5QvQJSymaKU6TLbyvMSbM9E/NLQLGGcgnTkOSj+qVB03kBYguWo9to4
 yOu17Ta/9lCQx
X-Received: by 2002:a17:907:1b09:b0:bec:64d4:3872 with SMTP id
 a640c23a62f3a-c1fa54be7b7mr155957466b.24.1785423367202; Thu, 30 Jul 2026
 07:56:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260730081325.1816193-1-den@openvz.org>
 <20260730081325.1816193-2-den@openvz.org>
In-Reply-To: <20260730081325.1816193-2-den@openvz.org>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 30 Jul 2026 10:55:53 -0400
X-Gm-Features: AUfX_myqyMyyNCVbf1KmdiL17SMtPK73zTboRwaoD_LJmF5MaLdo2ZUW8sxVIv8
Message-ID: <CAJSP0QUnp4=pPYQvGvTEoBCndvJb0o=Z0RzehP30KKK_svyXCA@mail.gmail.com>
Subject: Re: [PULL 1/8] MAINTAINERS: add myself to IDE maintainers
To: John Snow <jsnow@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, 
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 "Denis V. Lunev" <den@openvz.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Thu, Jul 30, 2026 at 4:14=E2=80=AFAM Denis V. Lunev <den@openvz.org> wro=
te:
>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Stefan Hajnoczi <stefanha@redhat.com>
> CC: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 902db77218..4628793dde 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2160,6 +2160,7 @@ F: docs/specs/edu.rst
>
>  IDE
>  M: John Snow <jsnow@redhat.com>
> +M: Denis V. Lunev <den@openvz.org>

Waiting for acknowledgement from John.

Stefan

