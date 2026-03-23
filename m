Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E975F46101
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 13:28:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4fKF-0006Z7-La; Mon, 23 Mar 2026 09:28:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w4fJy-0006Qx-95
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 09:27:55 -0400
Received: from mail-yw1-x112a.google.com ([2607:f8b0:4864:20::112a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w4fJg-00013i-M0
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 09:27:53 -0400
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-79a60975dc5so1958127b3.0
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 06:26:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774272402; cv=none;
 d=google.com; s=arc-20240605;
 b=djh++CM6BeILJDwLV8bvhYb6AtMSbuy+we1U8sOaUmVlBwwd6s+ivCDmUp/+HSaNCa
 QR6G+dSk0ZHSwntu0LR1lb78B17eeeXQku5nHWQFxMrnduhl4jIRhffIzASfpjUeMDAN
 TfiKaPzcMghMxTkbouMHCb/xH+fpASBbh/1zqBCDGs+GorohRS7SKaIEKa3WJMk2PoRw
 J5m3s+CG/c7a92PujiAYB2ztlb5KB79zkkSFwr8VeQxAjdD/oIqZb5Y2/r9R1P6ngIm6
 xSYBxu0jmpaJ96E2nglrIEg+A/8VhejQ/LWAT+GZ17eSu/aXwpvkyyG32G+aognXASDC
 OAkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ZMPhbqAC1qtdpr4ZKzbcLLAslk2BpexcsQvFVErQQ1Y=;
 fh=B6SfS+t7t2sOwUdRIJJMwxzv7371OVRRFmEabax5l7Q=;
 b=HSYgG6/kK4ghP/T88RoxACSi5XYvt33jdaeCHraCbKrZcZI4Mvs8dygSXapDphoLZc
 Q8VyVOTTAAQqgHEqFMV89gV8RFQiJjwrzPDTwho9Q581K53myNwtzCYMal4qnNaHoLJo
 VyScp/MSElfhLzaBSLN7Kvkbq1L8943FyBncnHGW7FPoHLPDaQc7PceO2AWAIMZXExg4
 lCx/RqW2Z1YSpZLa91gk4M33FToLh7MfbNTydgGIPMv7UaeIJ138iVhyCXq+YaEtJZ57
 vZABaEUKuCjljGAbWBwEDLOfGs6M88FTvsawoLQUHUcnbuJ+8UNh6dynhotNx71qN76i
 Pt8g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774272402; x=1774877202; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZMPhbqAC1qtdpr4ZKzbcLLAslk2BpexcsQvFVErQQ1Y=;
 b=YD6IrMNP5tpm2z1/k+8lbhHXEiNdvsU2au13/fnHEywfDGyc0MvbBIeRdRWNzTx24z
 qWwYaAWL+esutZVsuQTn0botAVT4XvhiGnXYM1LS9D3mDN4qvGy2QJE9HQwm0sXHVYl9
 QdfF3P52i5yOBSm+V2nkcX+ra3O/OQfocXW2UbwxoyNFao+zqelFnkKkgEO9at/C9ku8
 s9xNnqH5Ojv/rZUp5BADNIJzjYvE/GZ79pgF+QII1LrAxSWlebGNLj60+qbvvXbs6iIz
 TBlGFOulrECWtWXXGbmCZVPM35QIe52YUo2nuGNcM/B88Qxxz0j49R9R7a7b1vuYQ/jx
 17yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774272402; x=1774877202;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZMPhbqAC1qtdpr4ZKzbcLLAslk2BpexcsQvFVErQQ1Y=;
 b=haVfAQ2ohWA7i5djU4fb0GATs35HOBUrt94M++uEsLGDveVrsvAr7W2d9S20VHIKrM
 WgCGnO5PD0MdH4Hs0PDXUcdDo9Dj4Jjtavt9hhXcYAX+6cZ76ARmcQ0kYr6Oo/yFx5TZ
 BMSqQXInGmQAPVNvpJRAqeSpzpJld9VcgZwzmhdVOFggeXFCFEXcDbrYbj3XsvlqqLBA
 SoO9/KdPgzxpq3xHzZo4fY0rJT3FDIQ7dED7+bcuchB2W6MavtVrLSJdv0u6BuZgmc/U
 MicCMUHTyKWlMRjpSi5PhUuw+FLq4IUFr+d4pAoPm5OJHMEcvk+/lXck0J5mc8GA0T0b
 yV4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmrR7cfVGCF0HDHR4RLmqGRFjNnv+d+S3TGo803/RBVJjj2dpLzsBrNE4VO345yd1gIiYULpRavQir@nongnu.org
X-Gm-Message-State: AOJu0YwCdswsIZfwd6iAcnUhE9BWjxFjIt5e3QVI7UTHQhGyoj3Juxgy
 qiTQxC8ecM3xHv60Dp0taU5SMpL/GyJVfJaFhTWL/xxh/l623yA2V5YhtRjdgLE7dMTrNgt9E2X
 cSIzgpBGtUS/o/5bFT3hsaxIxXQHdMGzG82jRl9ZFew==
X-Gm-Gg: ATEYQzwXl+2MUpoQpcgWwWcVZoYn9P52ABlkm22B1BGP4CToFWN/FyqnSaB5YhtsrrU
 TRYKz0L5gSIHY6fkM4VxIr1JpGi/JNLn97kbkbuFucBCXxBiNXw7X2C1pN8DOTe3UzuL4ihtNfX
 vOIJebdc/IWK+/6saKbIKe2J3xo5oe9rqVGo6AwnWt1ocfvyusik9qdlbrpY8Ns/xQH/K7VojjO
 IqG2PisbFlq5xgJsjPLfz6FOo6x6BTEqfKEMMZ4XEYd4TPZWpYhm+765u2Sex6SxTkF8ijrWq2c
 Wi80VifmDBXPn51OEaVxD9u4leYjVfCRA2KOG6tucKLO06L00rP6s+gDCze7SXHbaBE=
X-Received: by 2002:a05:690c:e4d5:b0:79a:55f5:a422 with SMTP id
 00721157ae682-79a90aeaea8mr106937857b3.22.1774272402098; Mon, 23 Mar 2026
 06:26:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260223170212.441276-1-peter.maydell@linaro.org>
 <20260223170212.441276-2-peter.maydell@linaro.org>
 <8a696b3a-f55d-4c9b-ba0b-34c5391de28b@linaro.org>
In-Reply-To: <8a696b3a-f55d-4c9b-ba0b-34c5391de28b@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Mar 2026 13:26:29 +0000
X-Gm-Features: AaiRm53xo-peWTQ0Jy8trZQiQvUueAOKy5akaOcvMNd2czGSk17zUDXnGihWrQw
Message-ID: <CAFEAcA8BqCzbmcLK6D4sGEe6=Vg2+i+GHeqsnGgW2E87d=Osig@mail.gmail.com>
Subject: Re: [PATCH 01/65] hw/core: Permit devices to define an array of link
 properties
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112a.google.com
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

On Sat, 21 Mar 2026 at 15:42, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> (+Kevin / Markus / Mark for previous discussions)
>
> On 23/2/26 18:01, Peter Maydell wrote:
> > Currently we allow devices to define "link properties" with
> > DEFINE_PROP_LINK(): these are a way to give a device a pointer to
> > another QOM object.  (Under the hood this is done by handing it the
> > canonical QOM path for the object.)
> >
> > We also allow devices to define "array properties" with
> > DEFINE_PROP_ARRAY(): these are a way to give a device a
> > variable-length array of properties.
> >
> > However, there is no way to define an array of link properties.  If
> > you try to do it by passing qdev_prop_link as the arrayprop argument
> > to DEFINE_PROP_ARRAY() you will get a crash because qdev_prop_link
> > does not provide the .set and .get methods in its PropertyInfo
> > struct.
> >
> > This patch implements a new DEFINE_PROP_LINK_ARRAY().


> Nitpicking, I'd add object_resolve_and_typecheck() in a preliminary
> patch. Otherwise patch LGTM!
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Thanks. I've split the patch in two (it splits exactly into
"changes to object.[ch]" and "changes to qdev-properties.[ch]")
and added your R-by tag to both the resulting patches.

-- PMM

